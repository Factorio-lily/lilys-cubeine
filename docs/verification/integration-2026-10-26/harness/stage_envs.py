"""Stage three clean Factorio environments for the Cubeine integration check.

  before : what players have today  = shipped 2.4.3 zip + asset packs 1.0.5/1.0.1 + RSL 2.3.0
  mid    : dependency fix only      = patched tree (HEAD) + packs 1.0.5/1.0.1 + RSE 1.0.2
  after  : the whole change         = patched tree (HEAD) + packs 2.0.0 zips  + RSE 1.0.2

Each env gets its own config.ini (write-data inside the env) and mod-list.json naming only
the mods staged there, so her real profile, log and saves stay untouched.
"""
import json
import os
import shutil
import subprocess
import sys
import tarfile
import tempfile
import zipfile

ROOT = "H:/Factorio Mods"
INTEG = ROOT + "/_integ-2026-10-26"
POOL = "C:/Users/Lily/AppData/Roaming/Factorio/mods"
VERIFIED = ROOT + "/_testenv/mods"
SHIP = ROOT + "/_ship-2026-10-26"

OLD_PACK = POOL + "/lilys-cubeine-asset-pack_1.0.5.zip"
OLD_PACK2 = POOL + "/lilys-cubeine-asset-pack-2_1.0.1.zip"
OLD_CUBEINE = POOL + "/lilys-cubeine_2.4.3.zip"
INJECTOR = POOL + "/lilys-injector_1.1.1.zip"
RSL = POOL + "/runtime-spoilage-library_2.3.0.zip"
NEW_PACK = SHIP + "/lilys-cubeine-asset-pack_2.0.0.zip"
NEW_PACK2 = SHIP + "/lilys-cubeine-asset-pack-2_2.0.0.zip"
RSE = VERIFIED + "/runtime-spoilage-engine_1.0.2"

ENGINE_MODS = ["base", "space-age", "quality", "elevated-rails", "recycler"]


def fresh(path):
    if os.path.isdir(path):
        shutil.rmtree(path)
    os.makedirs(path, exist_ok=True)


def unzip_mod(zip_path, dest):
    """Extract a mod zip so that <dest>/<mod>_<ver>/info.json exists.

    Several of her zips nest the mod under <name>/ or src/; flatten a single top dir.
    """
    tmp = tempfile.mkdtemp(prefix="unz")
    try:
        with zipfile.ZipFile(zip_path) as z:
            z.extractall(tmp)
        entries = os.listdir(tmp)
        root = tmp
        # descend while there is exactly one directory and no info.json at this level
        while len(entries) == 1 and os.path.isdir(os.path.join(root, entries[0])) \
                and not os.path.isfile(os.path.join(root, "info.json")):
            root = os.path.join(root, entries[0])
            entries = os.listdir(root)
        info = json.load(open(os.path.join(root, "info.json"), encoding="utf-8-sig"))
        target = os.path.join(dest, "%s_%s" % (info["name"], info["version"]))
        if os.path.isdir(target):
            shutil.rmtree(target)
        shutil.copytree(root, target)
        return os.path.basename(target)
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def stage_repo(repo, dest):
    """Extract the committed HEAD tree of a repo (never the dirty working tree)."""
    tar = tempfile.mktemp(suffix=".tar")
    with open(tar, "wb") as fh:
        subprocess.run(["git", "-C", repo, "archive", "--format=tar", "HEAD"],
                       check=True, stdout=fh)
    tmp = tempfile.mkdtemp(prefix="gitx")
    try:
        with tarfile.open(tar) as t:
            t.extractall(tmp)
        for junk in (".git", ".gitignore", ".gitattributes"):
            p = os.path.join(tmp, junk)
            if os.path.isdir(p):
                shutil.rmtree(p)
            elif os.path.isfile(p):
                os.remove(p)
        info = json.load(open(os.path.join(tmp, "info.json"), encoding="utf-8-sig"))
        target = os.path.join(dest, "%s_%s" % (info["name"], info["version"]))
        if os.path.isdir(target):
            shutil.rmtree(target)
        shutil.copytree(tmp, target)
        return os.path.basename(target), info["version"]
    finally:
        shutil.rmtree(tmp, ignore_errors=True)
        os.remove(tar)


def stage_verified_dir(src, dest):
    info = json.load(open(os.path.join(src, "info.json"), encoding="utf-8-sig"))
    target = os.path.join(dest, "%s_%s" % (info["name"], info["version"]))
    if os.path.isdir(target):
        shutil.rmtree(target)
    shutil.copytree(src, target)
    return os.path.basename(target)


def write_layout(env, staged):
    mods = os.path.join(env, "mods")
    write = os.path.join(env, "write")
    os.makedirs(write, exist_ok=True)
    cfg = os.path.join(env, "config.ini")
    with open(cfg, "wb") as fh:
        fh.write(b"[path]\r\n")
        fh.write(("write-data=%s\r\n" % write.replace("\\", "/")).encode())
    modlist = {"mods": [{"name": n, "enabled": True} for n in ENGINE_MODS + staged]}
    with open(os.path.join(mods, "mod-list.json"), "w", encoding="utf-8") as fh:
        json.dump(modlist, fh, indent=2)
    return cfg


def build(name, cubeine_src, pack, pack2, spoilage):
    env = os.path.join(INTEG, name)
    fresh(env)
    mods = os.path.join(env, "mods")
    os.makedirs(mods, exist_ok=True)
    staged = []
    if cubeine_src == "repo":
        d, ver = stage_repo(ROOT + "/lilys-cubeine", mods)
        staged.append("lilys-cubeine")
    else:
        staged.append(unzip_mod(OLD_CUBEINE, mods).rsplit("_", 1)[0])
    staged.append(unzip_mod(pack, mods).rsplit("_", 1)[0])
    staged.append(unzip_mod(pack2, mods).rsplit("_", 1)[0])
    staged.append(unzip_mod(INJECTOR, mods).rsplit("_", 1)[0])
    if spoilage == "rsl":
        staged.append(unzip_mod(RSL, mods).rsplit("_", 1)[0])
    else:
        staged.append(stage_verified_dir(RSE, mods).rsplit("_", 1)[0])
    cfg = write_layout(env, staged)
    listing = sorted(os.listdir(mods))
    print("%-6s -> %s" % (name, env))
    for item in listing:
        print("         %s" % item)
    return env, cfg


if __name__ == "__main__":
    os.makedirs(INTEG, exist_ok=True)
    build("before", "zip", OLD_PACK, OLD_PACK2, "rsl")
    build("mid", "repo", OLD_PACK, OLD_PACK2, "rse")
    build("after", "repo", NEW_PACK, NEW_PACK2, "rse")
