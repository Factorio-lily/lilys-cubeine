"""Gameplay check in the combined env: does module spoilage still roll through RSE?

Runs the migration probe that the dependency card built (docs/verification/cubeine-spoil-probe)
against the *combined* tree - patched lilys-cubeine + re-mastered asset packs + RSE - so the
runtime behaviour is proven after both changes, not just after the dependency swap.
"""
import json
import os
import re
import shutil
import subprocess

EXE = "E:/SteamLibrary/steamapps/common/Factorio/bin/x64/Factorio.exe"
ENV = "H:/Factorio Mods/_integ-2026-10-26/after"
PROBE = "H:/Factorio Mods/lilys-cubeine/docs/verification/cubeine-spoil-probe"
NAME = "cubeine-spoil-probe_0.0.1"


def main():
    mods = ENV + "/mods"
    target = os.path.join(mods, NAME)
    if os.path.isdir(target):
        shutil.rmtree(target)
    shutil.copytree(PROBE, target)
    listpath = mods + "/mod-list.json"
    data = json.load(open(listpath, encoding="utf-8"))
    if not any(m["name"] == "cubeine-spoil-probe" for m in data["mods"]):
        data["mods"].append({"name": "cubeine-spoil-probe", "enabled": True})
        json.dump(data, open(listpath, "w", encoding="utf-8"), indent=2)

    save = ENV + "/write/spoil.zip"
    if os.path.exists(save):
        os.remove(save)
    r = subprocess.run([EXE, "--config", ENV + "/config.ini", "--mod-directory", mods,
                        "--create", save], capture_output=True, text=True, timeout=900)
    print("create rc=%d" % r.returncode)
    if r.returncode != 0:
        print(open(ENV + "/write/factorio-current.log", errors="ignore").read()[-2500:])
        return 1
    r2 = subprocess.run([EXE, "--config", ENV + "/config.ini", "--mod-directory", mods,
                         "--benchmark", save, "--benchmark-ticks", "1400"],
                        capture_output=True, text=True, timeout=1200)
    print("benchmark rc=%d" % r2.returncode)
    text = open(ENV + "/write/factorio-current.log", errors="ignore").read()
    open(ENV + "/write/spoil-probe.log", "w", encoding="utf-8").write(text)
    lines = [l.strip() for l in text.splitlines() if "[spoilprobe]" in l]
    for line in lines:
        print("  ", line.split("[spoilprobe] ")[-1])
    errors = [l.strip() for l in text.splitlines()
              if re.search(r"Error|Script error", l)]
    print("errors: %d" % len(errors))
    for line in errors[:5]:
        print("  !!", line)

    # assertions on the roll
    rolls = set()
    for line in lines:
        for item in re.findall(r"([a-z0-9-]+)=\d+", line):
            rolls.add(item)
    totals = [int(m.group(1)) for m in re.finditer(r"\[(\d+) items\]", "\n".join(lines))]
    stuck = any("placeholder" in line for line in lines)
    print("\ndistinct items seen: %d" % len(rolls))
    print("placeholder left in a chest: %s" % stuck)
    if totals:
        print("item totals over the run: min=%d max=%d" % (min(totals), max(totals)))
    return 0 if lines and not errors else 1


if __name__ == "__main__":
    raise SystemExit(main())
