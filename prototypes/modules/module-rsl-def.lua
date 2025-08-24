local oc = require("prototypes.modules.oc")

local modules = data.raw["module"]

local list1 = {}
local list2 = {}

--local list1 = prototypes.get_item_filtered({ { filter = "type", type = "module" }, { filter = "subgroup", subgroup = "module-overclocked", mode = "and" } })
--local list2 = prototypes.get_item_filtered({ { filter = "type", type = "module" }, { filter = "subgroup", subgroup = "module-degraded-overclocked", mode = "and" } })

for _, data in pairs(modules) do
    if (data.subgroup == "module-overclocked") then
        list1[data.name] = data
    end
    if (data.subgroup == "module-degraded-overclocked") then
        list2[data.name] = data
    end
    
end

for name, proto in pairs(list1) do
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

    local my_rsl_registration = {
        type = "mod-data",
        name = "lily_" .. name .. "_rsl",
        data_type = "rsl_registration",
        data = {
            loop_spoil_safe_mode = true,
            original_item_name = name,
            data_raw_table = "module",
            conditional = false,
            random = true,
            weighted = true,
            random_results = {
                {name = base_name, weight = math.floor(base_chance * 1000)},
                {name = degraded_name, weight = math.floor(degraded_chance * 1000)},
                {name = destroyed_name, weight = math.floor(destroyed_chance * 1000)}, 
                { name = hyper_name,     weight = math.floor(hyper_chance * 1000)}
            }
        }
    }

    data:extend { my_rsl_registration }
    --[[
    remote.call("rsl_registry", "register_rsl_definition", name,
        { -- You call the "rsl_registry" to use "register_rsl_definition" and pass it the name of your custom item "mutation-a"
            mode = { random = true, conditional = false, weighted = true },
            condition = true,
            possible_results = {
                [true] = { { name = base_name, weight = base_chance }, { name = degraded_name, weight = degraded_chance }, { name = destroyed_name, weight = destroyed_chance }, { name = hyper_name, weight = hyper_chance } },
                [false] = {}
            }
        }
    )
    --]]
end

for name, proto in pairs(list2) do
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

    local my_rsl_registration = {
        type = "mod-data",
        name = "lily_" .. name .. "_rsl",
        data_type = "rsl_registration",
        data = {
            loop_spoil_safe_mode = true,
            original_item_name = name,
            data_raw_table = "module",
            conditional = false,
            random = true,
            weighted = true,
            random_results = {
                {name = degraded_name, weight = math.floor(degraded_chance * 1000)},
                {name = destroyed_name, weight = math.floor(destroyed_chance * 1000)}, 
                {name = hyper_name, weight = math.floor(hyper_chance * 1000)}
            }
        }
    }

    data:extend { my_rsl_registration }
    --[[
    remote.call("rsl_registry", "register_rsl_definition", name,
        { -- You call the "rsl_registry" to use "register_rsl_definition" and pass it the name of your custom item "mutation-a"
            mode = { random = true, conditional = false, weighted = true },
            condition = true,
            possible_results = {
                [true] = { { name = degraded_name, weight = degraded_chance }, { name = destroyed_name, weight = destroyed_chance }, { name = hyper_name, weight = hyper_chance } },
                [false] = {}
            }
        }
    )
    --]]
end

