"""Numeric before/after comparison of the same in-game camera.

Both runs photograph the identical scene from the identical position, so any difference is the
re-mastered texel density.  For each subject and zoom this reports

  * mean absolute pixel difference  (0 = invisible change)
  * detail energy = mean |Laplacian| over the centre crop (falls as a sheet gets softer)

A file that renders at half the texels but the same on-screen size must keep its silhouette
(diff small outside edges) and lose high-frequency detail when the camera is pushed past 1:1.
"""
import sys

import numpy as np
from PIL import Image

BEFORE = "H:/Factorio Mods/_integ-2026-10-26/mid/write/script-output/integ/"
AFTER = "H:/Factorio Mods/_integ-2026-10-26/after/write/script-output/integ/"
SHOTS = [("drill", 1.0), ("drill", 2.0), ("drill", 4.0),
         ("reactor", 1.0), ("reactor", 2.0), ("reactor", 4.0),
         ("scene", 1.0)]


def load(base, label, zoom):
    return np.asarray(Image.open("%s%s-z%.2f.png" % (base, label, zoom)).convert("RGB"),
                      dtype=np.float64)


def laplacian_energy(gray, crop=0.5):
    h, w = gray.shape
    y0, y1 = int(h * (0.5 - crop / 2)), int(h * (0.5 + crop / 2))
    x0, x1 = int(w * (0.5 - crop / 2)), int(w * (0.5 + crop / 2))
    g = gray[y0:y1, x0:x1]
    lap = (-4 * g[1:-1, 1:-1] + g[:-2, 1:-1] + g[2:, 1:-1] + g[1:-1, :-2] + g[1:-1, 2:])
    return float(np.abs(lap).mean())


print("%-9s %-5s %-14s %-14s %-10s %s" %
      ("subject", "zoom", "detail before", "detail after", "ratio", "mean abs pixel diff"))
rows = []
for label, zoom in SHOTS:
    try:
        a = load(BEFORE, label, zoom)
        b = load(AFTER, label, zoom)
    except FileNotFoundError as err:
        print("%-9s %-5s  MISSING (%s)" % (label, zoom, err.filename.split("/")[-1]))
        continue
    ga, gb = a.mean(axis=2), b.mean(axis=2)
    ea, eb = laplacian_energy(ga), laplacian_energy(gb)
    diff = float(np.abs(a - b).mean())
    rows.append((label, zoom, ea, eb, eb / ea, diff))
    print("%-9s %-5.1f %-14.2f %-14.2f %-10.3f %.2f" % (label, zoom, ea, eb, eb / ea, diff))
