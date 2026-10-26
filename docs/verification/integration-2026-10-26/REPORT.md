# Cubeine 2.4.3 + asset packs 2.0.x — end-to-end integration check (Factorio 2.1.23)

Date: 2026-10-26. Engine: Factorio 2.1.23 (build 87750, win64, steam, space-age).
Machine: Radeon RX 580 4 GB, 16 GB RAM, Windows 10 19045.

Validates the two combined changes: **the runtime-spoilage-library → runtime-spoilage-engine
migration** in `lilys-cubeine` and **the re-mastered asset packs** (2.0.0).

## Verdict

**PASS, after three atlas regressions were found and fixed during this check.**

The dependency migration and the re-master both hold up: the mod loads, spoilage rolls, the
re-mastered sheets render, and VRAM/load time improve measurably. But the first GUI load of the
"everything fixed" state was **not** clean — three separate sprite defects in the re-mastered
packs were only visible to the real sprite loader, and every headless gate had passed them.
They are fixed (four commits, two per pack) and re-verified.

| # | Criterion | Result |
|---|---|---|
| 1 | Mod loads in a clean environment, dependency error gone | **PASS** |
| 2 | No missing texture / sprite / atlas errors | **PASS** after fixes (3 found, 3 fixed) |
| 3 | Gameplay behaviour unaffected (module spoilage still rolls) | **PASS** |
| 4 | On-screen size and animation unchanged | **PASS** (resolved dump: identical offender set, 0 new) |
| 5 | Memory / VRAM / load time improved | **PASS**, measured, smaller than the model predicted |
| 6 | Zoomed-in look acceptable | **PASS with a documented trade-off** (softer past 1:1) |

## Environments

Three clean, isolated mod directories under `H:/Factorio Mods/_integ-2026-10-26/`, each with its
own `config.ini` (`write-data` inside the env) and `mod-list.json` — her real profile, log and
saves were never touched.

| env | mods staged | purpose |
|---|---|---|
| `before` | shipped `lilys-cubeine_2.4.3.zip`, asset packs `1.0.5` / `1.0.1`, `runtime-spoilage-library_2.3.0` | what players have today |
| `mid` | patched tree (commit `3bde868`) + the **old** packs + `runtime-spoilage-engine_1.0.2` | dependency fix alone — the "before" for every performance number |
| `after` | patched tree + **re-mastered packs at repo HEAD** + RSE 1.0.2 | the whole change |

Only space-age, quality, elevated-rails, recycler, `lilys-injector` and RSE load alongside —
the required dependency closure, nothing else.

## 1. The shipped state does not load (reproduced)

`before`, first load attempt, `factorio-current.log`:

```
0.178 Error Util.cpp:81: Failed to load mod "runtime-spoilage-library":
• runtime-spoilage-library
    • Incompatible Factorio version (current: 2.1, required: 2.0)
```

Exit code 1, no map, no menu. This is the reported bug and it is a hard block, not a warning.

## 2. The patched state loads, runs, and passes every headless gate

`mid` and `after`, per env: `--create`, `--benchmark 2000`, `--dump-data`.

| gate | before | mid | after |
|---|---|---|---|
| data stage (`--create`) | **fail** (RSL) | ok | ok |
| `lilys-cubeine` data.lua ran | no | yes | yes |
| RSE loaded | no | 1.0.2 | 1.0.2 |
| RSL loaded | — | no (mutually exclusive) | no |
| runtime, 2000 ticks | — | ok, 0 script errors | ok, 0 script errors |
| resolved dump | — | 32.31 MB | 32.30 MB |
| `rse_registration` prototypes | — | 36 | 36 |

## 3. The GUI gate — and the three regressions it caught

No headless run builds the sprite atlas (`--create`, `--benchmark`, `--dump-data` all log
"Running in headless mode"), so `mid`/`after` both passed every gate above while the
re-mastered packs were broken. A real GUI launch of the probe save exposed them one per run,
because the engine stops at the first bad rectangle.

All three are the same mistake in different shapes — **the re-master shrank a sheet whose
consumer reads more than one frame from it**:

| sprite | consumer | why it broke | fix |
|---|---|---|---|
| `oxidizer-hr-animation-1/color1-1/color2-1`, `emission-1` | thermal boiler | layers name their file through `stripes`, and the rebase pass only looked at `filename` / `filenames`, so their frame boxes were never halved | `entry_for()` also scans stripe filenames (`528b483` pack, `a6be933` pack-2) |
| `pump-remnants.png`, `steam-turbine-remnants.png` | `cubeine-pump-remnants`, `cubeine-turbine-remnants` | 4-direction corpse sheets cropped to direction 0 only | re-cut whole sheet at 2:1, crop dropped (`4485442`) |
| `reactor-connect-patches-large.png`, `…-heated-large.png` | `nukubeine-reactor` connection patches | 21-variation sheets cropped to one variation | re-cut whole sheet at 2:1, crop dropped (`40cd6a9`) |

Engine output for each class:

```
Error AtlasBuilder.cpp:1378: The given sprite rectangle (left_top=0x1280, right_bottom=280x320)
is outside the actual sprite size (left_top=0x0, right_bottom=1120x1280).
__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-hr-color2-1.png
  data.raw["assembling-machine"]["cubeine-thermal-boiler"]

Error AtlasBuilder.cpp:1378: … (left_top=0x93, right_bottom=94x93) … 94x93
__lilys-cubeine-asset-pack__/graphics/entity/pump/remnants/pump-remnants.png
  data.raw["corpse"]["cubeine-pump-remnants"]

Error ParallelSpriteLoader.cpp:67: … (left_top=32x0, right_bottom=32x32) … 32x64
__lilys-cubeine-asset-pack-2__/graphics/entity/reactor/reactor-connect-patches-large.png
```

**Cost of the fixes:** 0.66 MB on disk (the two corpse sheets and the two patch sheets are whole
again). 3 of the original 7 one-frame crops remain, all genuinely single-frame sprites.

Final GUI load of `after`: `Errors: 0`, atlas built (33 pages), 7 screenshots rendered,
`INTEG PROBE DONE`.

## 4. Gameplay unaffected — spoilage still rolls

The migration probe (`docs/verification/cubeine-spoil-probe`) run against the **combined** tree,
1400 ticks, module `spoil_ticks` shortened to 120 for the run:

```
t=100 forced spoil() on speed-module-3   ->  speed-module-3=50
t=140 natural roll                       ->  speed-module-3-degraded=100  speed-module-3=50
item total over the whole run: 150 (constant)   stuck placeholders: none    errors: 0
```

Two different roll outcomes landed on different module types, nothing was lost, nothing was left
as a `-rse-placeholder` stack.

## 5. Prototype geometry unchanged

Static check over the resolved data dump (`check_sheets.py`), comparing every sprite's frame grid
with the real PNG it points at:

```
before: 210 offenders   after: 210 offenders
new in after (regressions): 0     gone in after: 0
```

The 210 are the same vanilla special cases in both runs (`space-platform-hub`, `cryogenic-plant`,
`foundry` pipe pictures and vanilla corpse animations) — an artefact of a naive frame-count model,
identical before and after, so **the re-master introduces no new geometry mismatch and nothing
that used to render stopped rendering**.

## 6. Measured before/after (warm-cache runs, engine-reported)

Both sides run twice and the second run is compared, because the OS file cache alone accounts for
26 s of sprite-load time on the first run of a freshly staged directory.

| metric | before (packs 1.0.5/1.0.1) | after (2.0.0 + fixes) | change |
|---|---|---|---|
| asset packs on disk (staged) | 418.0 MB | **153.1 MB** | −63.4 % |
| atlas pages built | 34 | **33** | −1 |
| atlas area | 3.915 G texels | **3.619 G texels** | −7.6 % |
| texture VRAM (engine estimate) | 4451.28 MB | **4045.82 MB** | **−405.5 MB (−9.1 %)** |
| total VRAM, whole program | 5109.95 MB | **4699.09 MB** | **−410.9 MB (−8.0 %)** |
| sprite-load phase | 100.29 s | **96.88 s** | −3.4 s (−3.4 %) |
| whole load → game up | 135.6 s | **132.9 s** | −2.7 s |
| process peak working set | 2284 MB | 2268 MB | −16 MB |
| process peak commit (private) | 7748 MB | **7113 MB** | −635 MB (−8.2 %) |

Independent corroboration: the WDDM adapter counter (`typeperf "\GPU Adapter Memory(*)\Dedicated
Usage"`) peaks at 6675.7 MB before and 6283.7 MB after, a −392 MB delta that agrees with the
engine's −411 MB. Per-process GPU counters are not populated for this driver, so the adapter-wide
figure is the only independent one available.

**The saving is real but smaller than the asset card's model.** The model predicted 736.5 →
207.3 MB for the two packs (−529 MB); the engine measures −405 MB of texture VRAM. The gap is
atlas packing: pages are 16384² canvases, so freed texels only turn into a saving when a whole
page stops being needed — which happened exactly once (34 → 33 pages). The −63 % on disk is
unaffected, since that is the uncompressed source, and it is what players download.

**Load time barely moved (−3.4 s).** Sprite loading is dominated by PNG decode + BC7 compression
of everything that remains (9190 bitmaps, 8 threads), not by the four atlases the packs own. Do
not promise players a shorter load; promise the VRAM and the download size.

## 7. Zoomed-in look

Screenshots of the identical scene from the identical camera, before vs after, in
`shots/` (`drill` and `reactor` at zoom 1 / 2 / 4, plus a wide shot).

Measured detail energy (mean |Laplacian| over the centre half of the frame, after/before):

| subject | zoom 1 | zoom 2 | zoom 4 |
|---|---|---|---|
| drill (core extractor) | 0.87 | 0.82 | 0.69 |
| reactor | 0.92 | 0.83 | 0.25 * |
| wide scene (control, mostly ground) | **0.96** | — | — |

Control at 0.96 says the camera, animation phase and lighting are comparable; the machines lose
high-frequency detail as the camera goes past 1:1, exactly as the asset card predicted.

\* the reactor at zoom 4 is a smoke-and-particle frame in this particular capture (both runs
photograph the same tick, but the plume is animated), so that number is a scene difference, not a
texture measurement. Judge it from the images.

**Trade-off to accept knowingly:** the re-mastered sheets are now standard texel density. At 100 %
zoom they are indistinguishable; past 1:1 (zoom 2-4, which is what you use when placing or
inspecting a machine) they are softer than the old high-res art. That is the price of −410 MB.

## 8. What is left open

1. **Pack ZIPs are stale.** `_ship-2026-10-26/*_2.0.0.zip` predate the four fix commits and still
   contain the broken sheets. Repack before anything is uploaded (no version bump yet — the
   release steps for both packs and for `lilys-cubeine` 2.4.4 are still open).
2. **Release bump / changelog / packship** for `lilys-cubeine` (2.4.3 → 2.4.4) and both packs.
3. **Player-facing migration note:** `runtime-spoilage-library` and `runtime-spoilage-engine` are
   mutually exclusive — RSL must be uninstalled, not just disabled-and-forgotten.
4. A sprite-geometry gate belongs in `_tools/`: `check_sheets.py` + `check_crops.py` here catch,
   statically, every defect this GUI pass found piecemeal — worth folding into `shipcheck.py` as a
   pre-GUI gate that counts `frame_count × direction_count × variation_count` and understands
   `stripes` / `filenames`.

## Reproduction

```bash
# stage the three envs (packs from their repos, cubeine from git HEAD)
python harness/stage_envs.py && python harness/stage_after_fixed.py
# headless gates
python harness/gates.py before mid after
# static sprite geometry
python harness/check_sheets.py <env>/write/script-output/data-raw-dump.json <env>/mods/*
python harness/check_crops.py
# the gate that finds what the others cannot: a real GUI load + screenshots
python harness/run_gui.py after
python harness/atlas_stats.py
```
