"""Run the headless gates on each staged env: data stage, runtime, data dump.

  1. --create            : data stage (prototype errors, dep resolution)
  2. --benchmark 2000    : control.lua / runtime errors over 2000 ticks
  3. --dump-data         : resolved prototypes for the atlas + geometry checks

Writes <env>/gates.json and keeps every log next to it.
"""
import json
import os
import re
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor

EXE = "E:/SteamLibrary/steamapps/common/Factorio/bin/x64/Factorio.exe"
INTEG = "H:/Factorio Mods/_integ-2026-10-26"


def run(env_path, name):
    cfg = env_path + "/config.ini"
    mods = env_path + "/mods"
    write = env_path + "/write"
    os.makedirs(write, exist_ok=True)
    save = write + "/gate.zip"
    out = {"env": name}

    def call(args, logname, timeout=1200):
        log = write + "/" + logname
        current = write + "/factorio-current.log"
        if os.path.exists(log):
            os.remove(log)
        r = subprocess.run([EXE, "--config", cfg, "--mod-directory", mods] + args,
                           capture_output=True, text=True, timeout=timeout)
        text = ""
        if os.path.exists(current):                     # Factorio always logs here
            text = open(current, "r", errors="ignore").read()
            with open(log, "w", encoding="utf-8") as fh:
                fh.write(text)
        return r.returncode, text, r.stdout + r.stderr

    rc, text, console = call(["--create", save], "create.log")
    out["create_rc"] = rc
    out["create_ok"] = rc == 0
    out["create_error"] = first_error(text)
    out["mods_loaded"] = sorted(set(re.findall(r"Loading mod (\S+) \S+ \(data", text)))
    out["cubeine_data_lua"] = bool(re.search(r"Loading mod lilys-cubeine \S+ \(data\.lua\)", text))
    out["rse_loaded"] = any(m.startswith("runtime-spoilage-engine") for m in out["mods_loaded"])
    out["rsl_loaded"] = any(m.startswith("runtime-spoilage-library") for m in out["mods_loaded"])

    if rc == 0:
        rc2, text2, console2 = call(["--benchmark", save, "--benchmark-ticks", "2000"], "bench.log")
        out["bench_rc"] = rc2
        out["bench_ok"] = rc2 == 0 and not runtime_errors(text2)
        out["bench_error"] = (first_error(text2) or runtime_errors(text2))
        out["bench_tick_line"] = next((l.strip() for l in text2.splitlines()
                                       if "Performed" in l or "avg" in l.lower()), "")

        rc3, text3, console3 = call(["--dump-data"], "dump.log")
        out["dump_rc"] = rc3
        dump = write + "/script-output/data-raw-dump.json"
        out["dump_ok"] = rc3 == 0 and os.path.isfile(dump)
        out["dump_bytes"] = os.path.getsize(dump) if os.path.isfile(dump) else 0
    else:
        out["bench_ok"] = None
        out["dump_ok"] = None

    with open(env_path + "/gates.json", "w", encoding="utf-8") as fh:
        json.dump(out, fh, indent=2)
    return out


def first_error(text):
    """The first 'Failed to load mods' / Error block Factorio printed."""
    lines = text.splitlines()
    for i, line in enumerate(lines):
        if "Failed to load mod" in line:
            return "\n".join(lines[i:i + 6])
        if re.match(r"\s*\d+\.\d+ Error ", line):
            return "\n".join(lines[i:i + 6])
    return ""


def runtime_errors(text):
    bad = []
    for line in text.splitlines():
        if re.search(r"\bError\b", line) and not line.strip().startswith("0."):
            bad.append(line)
        elif "Script error" in line or "attempt to index" in line:
            bad.append(line)
    return "\n".join(bad[:8])


if __name__ == "__main__":
    names = sys.argv[1:] or ["before", "mid", "after"]
    with ThreadPoolExecutor(max_workers=3) as pool:
        results = list(pool.map(lambda n: run(INTEG + "/" + n, n), names))
    for r in results:
        print(json.dumps(r, indent=2)[:2200])
        print("-" * 70)
