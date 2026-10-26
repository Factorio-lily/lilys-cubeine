"""Atlas accounting + load-phase timing straight out of the engine's own log.

Factorio logs every atlas page it creates ("Created an atlas bitmap (size 16384x16192) [..]")
and the per-phase timestamps, so both the texel footprint and the load time are measurable
without trusting a model.
"""
import re
import sys

FILES = {
    "before (packs 1.0.5/1.0.1)": "H:/Factorio Mods/_integ-2026-10-26/mid/write/gui.log",
    "after (packs 2.0.0 + fixes)": "H:/Factorio Mods/_integ-2026-10-26/after/write/gui.log",
}
MARKERS = [
    ("data stage done", "Prototype list checksum"),
    ("sounds loaded", "Loading sounds"),
    ("crop bitmaps", "Crop bitmaps"),
    ("sprite loader start", "Parallel sprite loader initialized"),
    ("sprites loaded", "Sprites loaded"),
    ("map/scenario up", "Factorio initialised"),
]

for label, path in FILES.items():
    text = open(path, errors="ignore").read()
    pages = [(int(w), int(h)) for w, h in
             re.findall(r"Created an atlas bitmap \(size (\d+)x(\d+)", text)]
    texels = sum(w * h for w, h in pages)
    est = re.search(r"Estimated VRAM usage for textures: ([\d.]+) MB", text)
    real = re.search(r"Real VRAM usage for the whole program: ([\d.]+) MB", text)
    threads = re.search(r"Parallel sprite loader initialized \(threads: (\d+), bitmaps: (\d+)\)",
                        text)
    print("== %s" % label)
    print("   atlas pages: %d, total area %.2f G texels" % (len(pages), texels / 1e9))
    print("   biggest page: %s" % (str(max(pages)) if pages else "-"))
    print("   engine estimated texture VRAM: %s MB" % (est.group(1) if est else "?"))
    print("   engine real VRAM (whole program): %s MB" % (real.group(1) if real else "?"))
    if threads:
        print("   sprite loader: %s threads, %s bitmaps" % (threads.group(1), threads.group(2)))
    for name, marker in MARKERS:
        m = re.search(r"^\s+([\d.]+) .*" + re.escape(marker), text, re.M)
        print("   %-20s %s s" % (name, m.group(1) if m else "-"))
    print()
