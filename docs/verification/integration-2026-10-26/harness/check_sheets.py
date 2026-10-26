"""Does every resolved sprite actually fit in the texture it points at?

The engine stops at the FIRST bad rectangle ("Error AtlasBuilder.cpp:1378 ... outside the
actual sprite size"), so a GUI load only ever reveals one offender per run. This walks the
whole resolved data dump instead and checks the frame grid maths that the engine uses:

  plain sprite : needs  (line_length * frame_w)  x  (ceil(frame_count/line_length) * frame_h)
  stripes      : needs  (width_in_frames * frame_w) x (height_in_frames * frame_h) per file

and compares it with the real PNG size. Run it on two dumps to tell a regression (clean
before, broken after) from a pre-existing bug.

    python check_sheets.py <dump.json> <mods-dir> [...]
"""
import json
import os
import sys
from PIL import Image

GAME_DATA = "E:/SteamLibrary/steamapps/common/Factorio/data"
SIZES = {}


def png_size(path):
    if not path:
        return None
    if path in SIZES:
        return SIZES[path]
    try:
        with Image.open(path) as im:
            size = im.size
    except Exception:
        size = None
    SIZES[path] = size
    return size


def resolve(filename, moddirs):
    if not filename.startswith("__"):
        return None
    parts = filename.split("/")
    mod = parts[0].strip("_")
    rel = "/".join(parts[1:])
    if mod in ("base", "space-age", "core", "elevated-rails", "quality", "recycler"):
        return os.path.join(GAME_DATA, mod, rel)
    for d in moddirs:
        if os.path.basename(d).rsplit("_", 1)[0] == mod or os.path.basename(d) == mod:
            p = os.path.join(d, rel)
            if os.path.isfile(p):
                return p
    return None


def walk(node, path, out):
    if isinstance(node, dict):
        if "stripes" in node or ("filename" in node and ("width" in node or "frame_count" in node)):
            out.append((path, node))
            return
        for k, v in node.items():
            walk(v, path + "/" + str(k), out)
    elif isinstance(node, list):
        for i, v in enumerate(node):
            walk(v, path + "/%d" % i, out)


def required(node):
    """(per-file required width, height, list of filenames) or None.

    Frame tables stack `frame_count * direction_count` frames; `filenames` (plural) spreads
    them over several files, `filename` keeps them in one.
    """
    w, h = node.get("width"), node.get("height")
    if not w or not h:
        return None
    scale = node.get("scale") or 1
    count = (node.get("frame_count") or 1) * (node.get("direction_count") or 1)
    if "stripes" in node:
        files = []
        need = []
        for stripe in node["stripes"]:
            wx = stripe.get("width_in_frames") or 1
            hy = stripe.get("height_in_frames") or 1
            files.append(stripe.get("filename"))
            need.append((wx * w, hy * h))
        return need, files, count, scale
    plural = node.get("filenames")
    line = node.get("line_length")
    if not line:
        lpf = node.get("lines_per_file")
        per_file = count if not lpf else max(1, count // lpf) if lpf else count
        line = per_file
    line = max(1, int(line))
    if isinstance(plural, list) and plural:
        # each file holds one line's worth of frames (line_length frames per row per file)
        rows = -(-count // line)
        return [(line * w, rows * h)] * len(plural), plural, count, scale
    rows = -(-count // line)
    return [(line * w, rows * h)], [node.get("filename")], count, scale


def scan(dump_path, moddirs):
    dump = json.load(open(dump_path))
    bad, checked = [], 0
    for ptype, protos in dump.items():
        if not isinstance(protos, dict):
            continue
        for name, proto in protos.items():
            if not isinstance(proto, dict):
                continue
            found = []
            walk(proto, "", found)
            for path, node in found:
                req = required(node)
                if not req:
                    continue
                need, files, count, scale = req
                for (nw, nh), filename in zip(need, files):
                    real = resolve(filename, moddirs) if filename else None
                    if not real:
                        continue
                    size = png_size(real)
                    if not size:
                        bad.append({"type": ptype, "proto": name, "sprite": path,
                                    "file": filename, "problem": "image unreadable"})
                        continue
                    checked += 1
                    if nw > size[0] or nh > size[1]:
                        bad.append({"type": ptype, "proto": name, "sprite": path,
                                    "file": filename, "problem": "needs %dx%d, image is %dx%d"
                                    % (nw, nh, size[0], size[1]),
                                    "frame": "%sx%s" % (node.get("width"), node.get("height")),
                                    "count": count, "scale": scale})
    return checked, bad


if __name__ == "__main__":
    dump_path = sys.argv[1]
    moddirs = sys.argv[2:]
    checked, bad = scan(dump_path, moddirs)
    print("%s: %d sprite-file pairs checked, %d do not fit" % (dump_path, checked, len(bad)))
    seen = set()
    for item in bad:
        key = (item["proto"], item["sprite"])
        if key in seen:
            continue
        seen.add(key)
        print("  %-20s %-32s %-28s %s  [frame %s]" %
              (item["type"], item["proto"], item["sprite"], item["problem"],
               item.get("frame")))
    json.dump(bad, open(os.path.splitext(dump_path)[0] + ".sheets.json", "w"), indent=2)
