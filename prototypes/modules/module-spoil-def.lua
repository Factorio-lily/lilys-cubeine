-- Spoilage outcome tables for the overclocked modules.
--
-- These are "mod-data" prototypes (data_type = "rse_registration") consumed by
-- Runtime Spoilage Engine in its own data-final-fixes stage, so this file has to
-- run in data-updates or earlier.  Runtime Spoilage Library (the previous
-- dependency) is deprecated upstream; RSE is its successor.
--
-- The prototype named by original_item_name must already be spoilable -- the
-- module prototypes get their spoil_ticks in
-- prototypes/modules/cubeine-module-boost.lua.  RSE points their spoil_result at
-- a hidden placeholder and re-rolls the real outcome at runtime, which is how a
-- single module can spoil into several different results.

local oc = require("prototypes.modules.oc")

local modules = data.raw["module"]

local list1 = {}
local list2 = {}

for _, data in pairs(modules) do
    if (data.subgroup == "module-overclocked") then
        list1[data.name] = data
    end
    if (data.subgroup == "module-degraded-overclocked") then
        list2[data.name] = data
    end
end

local WEIGHT_SCALE = 1000

--- Append one spoilage result.
--- Chances are authored as fractions of one; RSE requires a *positive integer*
--- weight on every random result, so scale to 1/1000 and drop the entries that
--- round to zero (results below 0.05 %, which cannot be represented and are
--- invisible in play).
---@param results table[] accumulator
---@param item_name string
---@param chance number 0..1
local function add_result(results, item_name, chance)
    local weight = math.floor(chance * WEIGHT_SCALE + 0.5)
    if weight > 0 then
        results[#results + 1] = { name = item_name, weight = weight }
    end
end

--- Register the spoilage table of one module with RSE.
---@param item_name string the spoilable module prototype
---@param entries table[] array of {item_name, chance}
local function register_spoilage(item_name, entries)
    local results = {}
    for _, entry in ipairs(entries) do
        add_result(results, entry[1], entry[2])
    end
    -- the chances of a set always sum to 1, so at least one result survives
    data:extend { {
        type = "mod-data",
        name = "lilys-cubeine-" .. item_name .. "-spoilage",
        data_type = "rse_registration",
        data = {
            original_item_type = "module",
            original_item_name = item_name,
            -- A module can spoil inside a crafting machine's output buffer, where
            -- the spoilage event exposes no inventory.  The placeholder then spoils
            -- into itself and the roll happens once the stack reaches a real
            -- inventory, so nothing is lost.
            placeholder_spoil_into_self = true,
            results = results,
        },
    } }
end

-- healthy overclocked modules: back to base, or further degraded / destroyed /
-- hypercharged
for name in pairs(list1) do
    local level = tonumber(string.sub(name, string.len(name)))
    local base_name = string.gsub(name, "%-overclocked%-" .. tostring(level), "")
    local degraded_name = base_name .. "-degraded"
    local destroyed_name = base_name .. "-destroyed"
    local hyper_name = base_name .. "-hyper"

    local hyper_chance = oc[level].su
    local destroyed_chance = oc[level].x
    if (hyper_chance + destroyed_chance) > 1 then
        destroyed_chance = math.max(0, destroyed_chance - (hyper_chance + destroyed_chance - 1))
    end
    local degraded_chance = oc[level].d
    if (hyper_chance + destroyed_chance + degraded_chance) > 1 then
        degraded_chance = math.max(0, degraded_chance - ((hyper_chance + destroyed_chance + degraded_chance - 1)))
    end
    local base_chance = math.max(0, 1 - hyper_chance - destroyed_chance - degraded_chance)

    register_spoilage(name, {
        { base_name, base_chance },
        { degraded_name, degraded_chance },
        { destroyed_name, destroyed_chance },
        { hyper_name, hyper_chance },
    })
end

-- already-degraded overclocked modules: destroyed / hypercharged, otherwise stay
-- degraded
for name in pairs(list2) do
    local level = tonumber(string.sub(name, string.len(name)))
    local degraded_name = string.gsub(name, "%-overclocked%-" .. tostring(level), "")
    local destroyed_name = string.gsub(degraded_name, "%-degraded", "-destroyed")
    local hyper_name = string.gsub(degraded_name, "%-degraded", "-hyper")

    local hyper_chance = oc[level].su
    local destroyed_chance = oc[level].dx
    if (hyper_chance + destroyed_chance) > 1 then
        destroyed_chance = math.max(0, destroyed_chance - (hyper_chance + destroyed_chance - 1))
    end
    local degraded_chance = math.max(0, 1 - hyper_chance - destroyed_chance)
    if (hyper_chance + destroyed_chance + degraded_chance) > 1 then
        degraded_chance = math.max(0, degraded_chance - ((hyper_chance + destroyed_chance + degraded_chance - 1)))
    end

    register_spoilage(name, {
        { degraded_name, degraded_chance },
        { destroyed_name, destroyed_chance },
        { hyper_name, hyper_chance },
    })
end
