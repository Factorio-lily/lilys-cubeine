# Module spoilage: Runtime Spoilage Library → Runtime Spoilage Engine

Status: implemented and verified on Factorio 2.1.23. Commits
`e276333` (code), `3628392` (this document), `31dd37a` (dead-comment cleanup)
on top of `4ab16b6` "Release 2.4.3"; the version bump + packaging steps are still
open (see §7).

## 1. Symptom

A stock install of `lilys-cubeine 2.4.3` cannot start on Factorio 2.1:

```
Failed to load mod "runtime-spoilage-library":
  • Incompatible Factorio version (current: 2.1, required: 2.0)
```

Reproduction (no GUI, ~15 s):

```bash
W=C:/Users/Lily/AppData/Local/hermes/cache/scratch/rsl-gate
mkdir -p "$W/mods" "$W/write"
printf '[path]\r\nwrite-data=%s/write\r\n' "$W" > "$W/config.ini"
unzip -qo "C:/Users/Lily/AppData/Roaming/Factorio/mods/runtime-spoilage-library_2.3.0.zip" -d "$W/mods"
"E:/SteamLibrary/steamapps/common/Factorio/bin/x64/Factorio.exe" \
  --config "$W/config.ini" --mod-directory "$W/mods" --create "$W/write/t.zip"
```

The only `runtime-spoilage-library` release a player can have installed today is
2.3.0, and its `info.json` declares `"factorio_version": "2.0"`. Factorio refuses
to load a 2.0-declared mod into 2.1, so the *dependency itself* blocks the game.

## 2. Root cause, in three parts

1. **Version gate.** RSL 2.3.0 is the last 2.0 release. `lilys-cubeine` asked for
   `runtime-spoilage-library >= 2.0.2`, which 2.3.0 satisfies — but 2.3.0 is not
   loadable on 2.1, so the dependency resolution fails before any code runs.
2. **API break above the gate.** The portal does carry RSL releases for 2.1
   (3.1.0, 3.1.1, 3.1.3). Those drop the 2.0-era registration helper
   (`require("__runtime-spoilage-library__/data_registry")` +
   `register_spoilable_item`) in favour of a `mod-data` prototype with
   `data_type = "rsl_registration"` and `original_item_type`. Cubeine's
   `prototypes/modules/module-rsl-def.lua` was written against the 2.0 shape, so a
   naive version bump moves the failure from "won't load" to "registers nothing".
3. **The library is dead.** Its portal page is marked deprecated — *"RSL is
   deprecated and no longer maintained. It is replaced by RSE"* — and
   `github.com/SirPuck/runtime-spoilage-library` no longer exists, so there is no
   upstream to fork and no place to report a bug. RSL 3.1.3 is a courtesy 2.1
   port of an abandoned library; nothing will ever follow it.

## 3. Decision

**Migrate to Runtime Spoilage Engine** (`runtime-spoilage-engine`, RSE 1.0.2, by
the same author, published for 2.1), and drop RSL entirely.

| option | verdict |
| --- | --- |
| Pin RSL `>= 3.1.0` (3.1.3 on the portal) | Works, but keeps the mod tied to a deprecated library whose source is gone. Also unverifiable offline: portal downloads need a factorio.com login, so the 3.x code could not be inspected or load-tested. |
| Vendor / fork RSL | Impossible — the repository was deleted. |
| Re-implement the spoilage swap inside Cubeine | ~200 lines to redo inventory hot-swapping (character, chest, beacon, crafting buffers, belts, ground), quality preservation and the placeholder loop-safety. RSE already is that code, maintained. |
| **RSE** | **Chosen.** Maintained successor, same placeholder/hotswap model, documented and source-available (`github.com/SirPuck/runtime-spoilage-engine`), published for 2.1. Its data stage also still accepts the old `data_raw_table` / `loop_spoil_safe_mode` keys, so the migration is a rename, not a redesign. |

RSE declares `! runtime-spoilage-library`, i.e. the two libraries are mutually
exclusive by design. Consequence for players: RSL must be uninstalled (see §5).

## 4. Changed files

| file | change |
| --- | --- |
| `info.json` | `"runtime-spoilage-library >= 2.0.2"` → `"runtime-spoilage-engine >= 1.0.2"` |
| `prototypes/modules/module-spoil-def.lua` | **new** — the registration file, renamed from `module-rsl-def.lua`: `mod-data` prototypes with `data_type = "rse_registration"`, `original_item_type = "module"`, `placeholder_spoil_into_self = true`, and `results` as a weighted array |
| `prototypes/modules/module-rsl-def.lua` | **deleted** (same content, old API + dead `remote.call` blocks) |
| `data-updates.lua` | `require("prototypes.modules.module-rsl-def")` → `...module-spoil-def` |
| `prototypes/modules/cubeine-module-boost.lua` | header comment only: dropped the dead `require("__runtime-spoilage-library__/data_registry")` and documented the new registration owner |

Gameplay maths is untouched: the same `oc` table drives the same
base/degraded/destroyed/hyper chance split, with the clamping code carried over
verbatim.

### One real semantic difference: weights must be positive integers

RSL accepted `weight = 0`; RSE rejects anything that is not a positive integer
(`[RSE] Registration error ... field 'weight' must be a positive integer`). Chances
are fractions of one, so `module-spoil-def.lua` scales them to 1/1000 and rounds:

```lua
local WEIGHT_SCALE = 1000
local function add_result(results, item_name, chance)
    local weight = math.floor(chance * WEIGHT_SCALE + 0.5)
    if weight > 0 then
        results[#results + 1] = { name = item_name, weight = weight }
    end
end
```

Results below 0.05 % therefore drop out of the table instead of being
unreachable-but-present. A level-4 overclocked module still rolls
`degraded 790 / destroyed 200 / hyper 10`; a level-1 rolls `base 800 / degraded 200`.

Dropping RSL does not lose the machine-inventory plumbing it provided: RSL's
`data-updates` widened `trash_inventory_size` to 5 for assembling machines and
labs so results can be parked in the trash slot, and RSE's `data-updates` does the
same.

## 5. Player-facing migration note

> Cubeine now uses **Runtime Spoilage Engine**. Uninstall *Runtime Spoilage
> Library* and install *Runtime Spoilage Engine* (the mod portal will offer it as
> a dependency of the Cubeine update).

Stale `<module>-rsl-placeholder` items can only exist for the few ticks between a
module spoiling and the library swapping it for the real result, so removing RSL
costs at most a partially-spoiled stack that was already mid-roll.

## 6. Verification (all run headless on 2.1.23)

RSE is not downloadable without a factorio.com login, so the tested copy was
packaged from its release commit — `d8ac298` ("Chore: Bump version",
2026-07-12, `info.json` 1.0.2), which matches the portal's 1.0.2 release date and
changelog — and staged as a verified dependency in `_testenv/mods/`.

### 6a. Ship gate — `_tools/shipcheck.py --mods lilys-cubeine`

```
lilys-cubeine   data=ok   runtime=ok   atlas=ok
=== summary
READY  lilys-cubeine  v2.4.3
staged: lilys-cubeine 2.4.3, asset-pack 1.0.5, asset-pack-2 1.0.1,
        lilys-injector 1.1.1, runtime-spoilage-engine 1.0.2
```

`create.log` confirms the load order (`runtime-spoilage-engine (data.lua)` before
`lilys-cubeine (data.lua)`, RSE's `data-final-fixes` after Cubeine's
`data-updates`), and the 2000-tick benchmark ran clean.

The first run of this gate reported `atlas=ERROR FileNotFoundError`: `shipcheck.py`
needs a vanilla baseline dump at
`cache/scratch/vanillaenv/write/script-output/data-raw-dump.json`, which was not on
this machine. Regenerating it with an empty mod directory
(`Factorio.exe --config <env>/config.ini --mod-directory <env>/mods --dump-data`)
turned the gate green — that is a repo-wide tooling fix, not something this
change needs.

### 6b. Registrations actually exist — `--dump-data`

From the same env's `data-raw-dump.json`:

* 36 `lilys-cubeine-<module>-spoilage` registrations and 36 matching
  `*-rse-placeholder` items;
* every overclocked module now points at its placeholder, e.g.
  `speed-module-3-overclocked-1`: `spoil_ticks 72000`, `spoil_result
  speed-module-3-overclocked-1-rse-placeholder`, `spoil_to_trigger_result` set;
* a resolved definition:
  `results = [{name="speed-module-3", weight=800}, {name="speed-module-3-degraded", weight=200}]`.

### 6c. Spoilage actually rolls at runtime — probe mod

The harness, its raw logs and both runs live in this repo:
`docs/verification/cubeine-spoil-probe/` (mod), `docs/verification/spoil-probe-{create,bench}.log`.
It shortens `spoil_ticks` to 120, fills two chests with full 50-stacks of
`speed-module-3-overclocked-1`, `speed-module-3-overclocked-4` and
`speed-module-3-degraded-overclocked-1`, spoils one chest naturally and one
through `LuaItemStack::spoil()`, then logs both chests every 20 ticks.

To re-run, stage it into a `shipcheck` env and run `--create` then
`--benchmark 400`:

```bash
E=C:/Users/Lily/AppData/Local/hermes/cache/scratch/ship/lilys-cubeine
cp -r docs/verification/cubeine-spoil-probe "$E/mods/"
# add {"name":"cubeine-spoil-probe","enabled":true} to $E/mods/mod-list.json
"E:/SteamLibrary/steamapps/common/Factorio/bin/x64/Factorio.exe" \
  --config "$E/config.ini" --mod-directory "$E/mods" --create "$E/write/probe.zip"
"E:/SteamLibrary/steamapps/common/Factorio/bin/x64/Factorio.exe" \
  --config "$E/config.ini" --mod-directory "$E/mods" --benchmark "$E/write/probe.zip" --benchmark-ticks 400
```

Run 1 — outcomes spread across the tables:

```
t=0    natural: overclocked-1=50 overclocked-4=50 degraded-overclocked-1=50 [150 items]
t=100  forced spoil() on speed-module-3 (stack of 50)
t=100  forced : speed-module-3=50 overclocked-4=50 degraded-overclocked-1=50 [150 items]
t=140  natural: speed-module-3=50 speed-module-3-destroyed=50 speed-module-3-degraded=50 [150 items]
```

Run 2 — the same scene, different roll:

```
t=140  natural: speed-module-3-degraded=150 [150 items]
t=100  forced : speed-module-3=50 degraded-overclocked-1=50 overclocked-4=50 [150 items]
```

Reading: level-1 rolls produced base (`speed-module-3`) and degraded, level-4
produced `destroyed`, and the degraded-table module kept itself degraded — the
three chance tables behave as authored, and two runs with identical inputs
landed on different outcomes, so the roll is really random. The item total stays
at 150 in every line: nothing is lost and no `-rse-placeholder` is left stuck.
Neither the create log nor the benchmark log contains an error line.

Note: one roll happens per *stack*, not per item, because both libraries default
`items_per_trigger` to the item's stack size (deliberate — it keeps the event rate
sane). That is unchanged behaviour, not a regression.

## 7. Release steps still open

1. Bump `info.json` to `2.4.4` and prepend to `changelog.txt`:

```
---------------------------------------------------------------------------------------------------
Version: 2.4.4
Date: 2026-10-26
  Changes:
    - Replaced Runtime Spoilage Library with Runtime Spoilage Engine (RSL is deprecated upstream)
---------------------------------------------------------------------------------------------------
```

2. Package with `_tools/packship.py`, then `shipcheck.py --zips` the artifact.
3. Regenerate the vanilla baseline dump so the atlas gate stops erroring for every
   mod in the report (unrelated to this change).
