"""For every file the re-master CROPPED, how many frames do its consumers actually read?

A crop is only safe when the sprite reads exactly one frame from that file. Anything with
frame_count > 1 or direction_count > 1 needs more rows than a one-frame crop keeps.
"""
import json
import re

PACKS = {
    "lilys-cubeine-asset-pack": "H:/Factorio Mods/lilys-cubeine-asset-pack/remastered-sheets.lua",
    "lilys-cubeine-asset-pack-2": "H:/Factorio Mods/lilys-cubeine-asset-pack-2/remastered-sheets.lua",
}
DUMP = "H:/Factorio Mods/_integ-2026-10-26/after/write/script-output/data-raw-dump.json"

crops = {}
for pack, path in PACKS.items():
    for line in open(path, encoding="utf-8"):
        m = re.search(r'\["__([a-z0-9-]+)__/([^"]+)"\]\s*=\s*\{([^}]*)\}', line)
        if m and "crop" in m.group(3):
            coords = re.search(r"crop\s*=\s*\{\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+)", m.group(3))
            crops["__%s__/%s" % (m.group(1), m.group(2))] = tuple(map(int, coords.groups()))

print("%d cropped files" % len(crops))


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


dump = json.load(open(DUMP))
users = {}
for ptype, protos in dump.items():
    if not isinstance(protos, dict):
        continue
    for name, proto in protos.items():
        if not isinstance(proto, dict):
            continue
        found = []
        walk(proto, "", found)
        for path, node in found:
            files = [node.get("filename")] + list(node.get("filenames") or [])
            files += [s.get("filename") for s in node.get("stripes", [])]
            for f in files:
                if f in crops:
                    count = ((node.get("frame_count") or 1) * (node.get("direction_count") or 1)
                             * (node.get("variation_count") or 1))
                    users.setdefault(f, []).append(
                        (ptype, name, path, count,
                         "%sx%s" % (node.get("width"), node.get("height")),
                         node.get("direction_count"), node.get("frame_count"),
                         node.get("variation_count")))

for f, crop in sorted(crops.items()):
    entries = users.get(f, [])
    worst = max(entries, key=lambda e: e[3]) if entries else None
    flag = "NEEDS >1 FRAME" if worst and worst[3] > 1 else "ok"
    print("%-70s crop=%s  %s" % (f.split("/")[-1], crop, flag))
    if worst and worst[3] > 1:
        print("      %s.%s%s  frames=%d (direction_count=%s frame_count=%s variation_count=%s)"
              " frame=%s size=%s"
              % (worst[0], worst[1], worst[2], worst[3], worst[5], worst[6], worst[7], worst[4],
                 crop[2:]))
    if not entries:
        print("      (no consumer found in the dump)")
