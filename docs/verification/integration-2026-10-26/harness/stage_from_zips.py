"""Build a clean env from the PACKAGED zips (not the repo trees) for the GUI gate.

Runs as:  python stage_from_zips.py fromzips
Leaves <env>/mods containing exactly what would be uploaded plus its required deps.
"""
import os
import shutil
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import stage_envs as S

name = sys.argv[1] if len(sys.argv) > 1 else "fromzips"
env = os.path.join(S.INTEG, name)
S.fresh(env)
mods = os.path.join(env, "mods")
os.makedirs(mods)

SHIP = S.SHIP
staged = []
for zname in ("lilys-cubeine_2.4.4.zip",
              "lilys-cubeine-asset-pack_2.0.1.zip",
              "lilys-cubeine-asset-pack-2_2.0.1.zip"):
    entry = S.unzip_mod(os.path.join(SHIP, zname), mods)
    print("uploaded artifact ->", entry)
    staged.append(entry.rsplit("_", 1)[0])
staged.append(S.unzip_mod(S.INJECTOR, mods).rsplit("_", 1)[0])
staged.append(S.stage_verified_dir(S.RSE, mods).rsplit("_", 1)[0])
S.write_layout(env, staged)
print("\n" + env + "/mods:")
for item in sorted(os.listdir(mods)):
    print("  ", item)
