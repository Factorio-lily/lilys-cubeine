"""Rebuild the 'after' env from the fixed repo trees (packs included).

The shipped 2.0.0 zips in _ship-2026-10-26 predate the stripe-rebase fix, so the end-to-end
validation has to read the repos, not the stale artifacts.
"""
import os
import shutil

import stage_envs as S

env = os.path.join(S.INTEG, "after")
S.fresh(env)
mods = os.path.join(env, "mods")
os.makedirs(mods)

staged = []
staged.append(S.stage_repo(S.ROOT + "/lilys-cubeine", mods)[0].rsplit("_", 1)[0])
staged.append(S.stage_repo(S.ROOT + "/lilys-cubeine-asset-pack", mods)[0].rsplit("_", 1)[0])
staged.append(S.stage_repo(S.ROOT + "/lilys-cubeine-asset-pack-2", mods)[0].rsplit("_", 1)[0])
staged.append(S.unzip_mod(S.INJECTOR, mods).rsplit("_", 1)[0])
staged.append(S.stage_verified_dir(S.RSE, mods).rsplit("_", 1)[0])
S.write_layout(env, staged)
for item in sorted(os.listdir(mods)):
    print(item)
