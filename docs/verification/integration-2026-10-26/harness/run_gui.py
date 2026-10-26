"""GUI integration run: load the probe save in a real (non-headless) Factorio and measure it.

Why this needs a GUI run at all: --create / --benchmark / --dump-data all log "Running in
headless mode" and never build the sprite atlas, so they cannot see a missing texture or a
sprite rectangle outside its sheet, and they never upload anything to the GPU.  A GUI load
that survives to the first scripted tick proves the atlas built; typeperf's GPU counters and
GetProcessMemoryInfo give the resident memory numbers the asset card could only model.

    python run_gui.py after          # env name under _integ-2026-10-26

Writes <env>/gui-metrics.json, <env>/write/gui.log and copy of the GPU csv.
"""
import ctypes
import ctypes.wintypes as wt
import json
import os
import re
import shutil
import subprocess
import sys
import time

EXE = "E:/SteamLibrary/steamapps/common/Factorio/bin/x64/Factorio.exe"
INTEG = "H:/Factorio Mods/_integ-2026-10-26"
HERE = os.path.dirname(os.path.abspath(__file__))
PROBE = os.path.join(HERE, "integ-probe")
ENV = dict(os.environ, SteamAppId="427520", SteamGameId="427520", SteamOverlayGameId="427520")

PHASES = ("Loading mod ", "Checksum for", "Loading sprites", "Loading sounds",
          "Factorio initialised", "Loading map", "Map loaded", "Sprite atlas",
          "atlas", "Texture", "VRAM", "texture")


class PMC(ctypes.Structure):
    _fields_ = [("cb", wt.DWORD), ("PageFaultCount", wt.DWORD),
                ("PeakWorkingSetSize", ctypes.c_size_t), ("WorkingSetSize", ctypes.c_size_t),
                ("QuotaPeakPagedPoolUsage", ctypes.c_size_t), ("QuotaPagedPoolUsage", ctypes.c_size_t),
                ("QuotaPeakNonPagedPoolUsage", ctypes.c_size_t),
                ("QuotaNonPagedPoolUsage", ctypes.c_size_t),
                ("PagefileUsage", ctypes.c_size_t), ("PeakPagefileUsage", ctypes.c_size_t),
                ("PrivateUsage", ctypes.c_size_t)]


def mem_counters(pid):
    PROCESS_QUERY_INFORMATION, PROCESS_VM_READ = 0x0400, 0x0010
    h = ctypes.windll.kernel32.OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, False, pid)
    if not h:
        return None
    try:
        c = PMC()
        c.cb = ctypes.sizeof(PMC)
        if not ctypes.windll.psapi.GetProcessMemoryInfo(h, ctypes.byref(c), c.cb):
            return None
        return {"working_set": c.WorkingSetSize, "peak_working_set": c.PeakWorkingSetSize,
                "private": c.PrivateUsage, "peak_private": c.PeakPagefileUsage}
    finally:
        ctypes.windll.kernel32.CloseHandle(h)


def stage_probe(env):
    mods = env + "/mods"
    target = mods + "/integ-probe_1.0.0"
    if os.path.isdir(target):
        shutil.rmtree(target)
    shutil.copytree(PROBE, target)
    listpath = mods + "/mod-list.json"
    data = json.load(open(listpath, encoding="utf-8"))
    if not any(m["name"] == "integ-probe" for m in data["mods"]):
        data["mods"].append({"name": "integ-probe", "enabled": True})
        json.dump(data, open(listpath, "w", encoding="utf-8"), indent=2)


def create_save(env):
    save = env + "/write/zoom.zip"
    if os.path.exists(save):
        os.remove(save)
    t0 = time.time()
    r = subprocess.run([EXE, "--config", env + "/config.ini",
                        "--mod-directory", env + "/mods", "--create", save],
                       capture_output=True, text=True, env=ENV, timeout=900)
    log = env + "/write/factorio-current.log"
    text = open(log, errors="ignore").read() if os.path.exists(log) else ""
    with open(env + "/write/create-zoom.log", "w", encoding="utf-8") as fh:
        fh.write(text)
    scene = [l.strip() for l in text.splitlines() if "[integprobe]" in l]
    return {"rc": r.returncode, "seconds": round(time.time() - t0, 1), "scene": scene,
            "error": "\n".join(l for l in text.splitlines() if "Error" in l)[:1500]}


def run_gui(env, expect="INTEG PROBE DONE", timeout=600):
    log = env + "/write/factorio-current.log"
    if os.path.exists(log):
        os.remove(log)
    gpucsv = env + "/write/gpu.csv"
    if os.path.exists(gpucsv):
        os.remove(gpucsv)
    # GPU counters: adapter-wide and per process, 1 s resolution, killed when the game exits
    tp = subprocess.Popen(["typeperf",
                           r"\GPU Adapter Memory(*)\Dedicated Usage",
                           r"\GPU Process Memory(*)\Dedicated Usage",
                           r"\GPU Process Memory(*)\Shared Usage",
                           "-si", "1", "-sc", "900", "-f", "CSV", "-o", gpucsv],
                          stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    time.sleep(6)                     # baseline window: gives the adapter counter a floor
    t0 = time.time()
    proc = subprocess.Popen([EXE, "--config", env + "/config.ini",
                             "--mod-directory", env + "/mods", "--load-game",
                             env + "/write/zoom.zip"], env=ENV)
    samples, state = [], "timeout"
    while time.time() - t0 < timeout:
        time.sleep(1)
        m = mem_counters(proc.pid)
        if m:
            m["t"] = round(time.time() - t0, 1)
            samples.append(m)
        text = open(log, errors="ignore").read() if os.path.exists(log) else ""
        if expect in text:
            state = "done"
            break
        if re.search(r"Failed to load mods|Error (Util|Sprite|AtlasSystem|AtlasBuilder)|"
                     r"outside the actual sprite size|sprite loading failed", text):
            state = "error"
            break
        if proc.poll() is not None:
            state = "exited"
            break
    wall = round(time.time() - t0, 1)
    time.sleep(2)
    if proc.poll() is None:
        subprocess.run(["taskkill", "/PID", str(proc.pid)], capture_output=True)
        time.sleep(5)
        if proc.poll() is None:
            subprocess.run(["taskkill", "/PID", str(proc.pid), "/F"], capture_output=True)
    tp.terminate()
    text = open(log, errors="ignore").read() if os.path.exists(log) else ""
    with open(env + "/write/gui.log", "w", encoding="utf-8") as fh:
        fh.write(text)
    return {"state": state, "wall_seconds": wall, "log": text, "samples": samples,
            "gpu_csv": gpucsv, "pid": proc.pid}


def parse_log(text):
    phases, probe = [], []
    for line in text.splitlines():
        m = re.match(r"\s+(\d+\.\d+) (.*)", line)
        if m and any(key in m.group(2) for key in PHASES):
            phases.append([float(m.group(1)), m.group(2)[:160]])
        if "[integprobe]" in line:
            probe.append(line.strip())
    return phases, probe


def parse_gpu(csv_path, pid):
    if not os.path.exists(csv_path):
        return {}
    rows = [r for r in open(csv_path, errors="ignore").read().splitlines() if r.strip()]
    if len(rows) < 2:
        return {}
    header = [h.strip('"') for h in rows[0].split(",")]
    per_pid, adapter = {}, []
    for row in rows[1:]:
        cells = row.split(",")
        for i, name in enumerate(header):
            if i >= len(cells):
                continue
            try:
                value = int(cells[i].strip('"'))
            except ValueError:
                continue
            m = re.search(r"pid_(\d+)_", name)
            if m and "Dedicated" in name:
                pid_key = int(m.group(1))
                per_pid[pid_key] = max(per_pid.get(pid_key, 0), value)
            elif "GPU Adapter Memory" in name and "Dedicated" in name:
                adapter.append(value)
    out = {"gpu_process_peaks_mb": {str(k): round(v / 1048576, 1)
                                    for k, v in sorted(per_pid.items(), key=lambda kv: -kv[1])[:4]}}
    if per_pid:
        biggest = max(per_pid.values())
        out["gpu_game_peak_mb"] = round(biggest / 1048576, 1)
    if adapter:
        out["gpu_adapter_dedicated_peak_mb"] = round(max(adapter) / 1048576, 1)
        out["gpu_adapter_dedicated_baseline_mb"] = round(min(adapter) / 1048576, 1)
        out["gpu_adapter_delta_mb"] = round((max(adapter) - min(adapter)) / 1048576, 1)
    return out


def main():
    name = sys.argv[1]
    env = INTEG + "/" + name
    stage_probe(env)
    create = create_save(env)
    print("create: rc=%d %.1fs, scene lines=%d" % (create["rc"], create["seconds"],
                                                   len(create["scene"])), flush=True)
    for line in create["scene"][:12]:
        print("   ", line, flush=True)
    if create["rc"] != 0:
        print("CREATE FAILED:", create["error"])
        return 1
    run = run_gui(env)
    phases, probe = parse_log(run["log"])
    gpu = parse_gpu(run["gpu_csv"], run["pid"])
    samples = run["samples"]
    metrics = {
        "env": name,
        "gui_state": run["state"],
        "gui_wall_seconds": run["wall_seconds"],
        "ram_peak_working_set_mb": round(max(s["peak_working_set"] for s in samples) / 1048576, 1)
        if samples else None,
        "ram_peak_private_mb": round(max(s["peak_private"] for s in samples) / 1048576, 1)
        if samples else None,
        "gpu": gpu,
        "phases": phases,
        "probe": probe,
        "errors": [l.strip() for l in run["log"].splitlines()
                   if re.search(r"Error|error: |Failed", l)][:10],
        "create": create,
    }
    with open(env + "/gui-metrics.json", "w", encoding="utf-8") as fh:
        json.dump(metrics, fh, indent=2)
    print(json.dumps({k: v for k, v in metrics.items() if k not in ("phases", "probe")}, indent=2))
    print("PROBE LINES:")
    for line in probe:
        print("  ", line)
    return 0 if run["state"] == "done" else 1


if __name__ == "__main__":
    sys.exit(main())
