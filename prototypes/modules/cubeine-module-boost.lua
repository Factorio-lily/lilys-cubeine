
--local multispoil = require("__multispoil__.api")
local rsl = require("__runtime-spoilage-library__/data_registry")
--------
---groups

if not data.raw["item-group"]["module"] then
    data.extend({{
        type = "item-group",
        name = "module",
        icons = {
            {
                icon = "__base__/graphics/technology/speed-module-3.png",
                icon_size = 256,
                scale = 0.25,
                shift = {0, 0},
            }
        },
        order = "h"

    }})
    data.raw["item-subgroup"]["module"].group = "module"
    data.raw["item-subgroup"]["module"].order = "a"
end

data.extend({
    {
        type = "item-subgroup",
        name = "module-overclocked",
        group = "module",
        order = "b"
    },
    {
        type = "item-subgroup",
        name = "module-degraded-overclocked",
        group = "module",
        order = "c"
    },
    {
        type = "item-subgroup",
        name = "module-degraded",
        group = "module",
        order = "d"
    },
    {
        type = "item-subgroup",
        name = "module-destroyed",
        group = "module",
        order = "e"
    },
    {
        type = "item-subgroup",
        name = "module-hyper",
        group = "module",
        order = "e"
    }
})


--overclock effect table, lines = overclock levels
-- b - boost effect
-- d - degrade chance
-- x - destroy chance
-- t - effect duration
-- db - degraded boost effect
-- dx - degraded destroy chance
local oc = require("prototypes.modules.oc")
local restabilize_time = hour / 12


local effectutils = require("prototypes.modules.module-effect-utils")


local function create_degraded(m, tier, icons)
    local module = table.deepcopy(m)
    module.name = m.name .. "-degraded"
    module.icons = table.deepcopy(icons)
    table.insert(module.icons, {
        icon = "__lilys-cubeine__/graphics/icons/speed-module-mask-degraded.png",
        icon_size = 64,
        --tint = { 0.5, 0.5, 0.5, 0.5 }
    })
    module.spoil_ticks = restabilize_time * tier
    module.spoil_result = m.name

    module.effect = effectutils.degrade_effect(module.category, module.effect)

    module.subgroup = "module-degraded"
    module.localised_name = {"?",{"", {"module-strings.degraded"}, " ", {"item-name." .. m.name}}, {"module-strings.degraded-fallback"}}
    module.localised_description = { "?", { "", { "item-description." .. m.name }, " ", { "module-strings.degraded-desc" } }, { "module-strings.degraded-fallback-desc" } }
    module.beacon_tint = {primary = { 0.5, 0.5, 0.5 }, secondary = { 0.5, 0.5, 0.5 } }
    return module
end

local function create_destroyed(m, tier, icons)
    local module = table.deepcopy(m)
    module.name = m.name .. "-destroyed"
    module.icons = table.deepcopy(icons)
    table.insert(module.icons, {
        icon = "__lilys-cubeine__/graphics/icons/speed-module-mask-destroyed.png",
        icon_size = 64,
        --tint = {0.5, 0.5, 0.5, 0.5}
    })
    module.effect = {}
    module.subgroup = "module-destroyed"
    module.localised_name = { "?", { "", { "module-strings.destroyed" }, " ", { "item-name." .. m.name } }, { "module-strings.destroyed-fallback" } }
    module.localised_description = { "?", { "", { "item-description." .. m.name }, " ", { "module-strings.destroyed-desc" } }, { "module-strings.destroyed-fallback-desc" } }
    module.beacon_tint = {}
    return module
end

local function create_hyper(m, tier, icons)
    local module = table.deepcopy(m)
    module.name = m.name .. "-hyper"
    module.icons = table.deepcopy(icons)
    table.insert(module.icons, {
        icon = "__lilys-cubeine__/graphics/icons/speed-module-mask-hyper.png",
        icon_size = 64,
        --tint = {0.5, 0.5, 0.5, 0.5}
    })
    if module.effect then
        module.effect = effectutils.hyper_effect(module.category, module.effect)
    end
    module.hidden = not settings.startup["hyper-allowed"].value
    module.subgroup = "module-hyper"
    module.localised_name = { "?", { "", { "module-strings.hyper" }, " ", { "item-name." .. m.name } }, { "module-strings.hyper-fallback" } }
    module.localised_description = { "?", { "", { "item-description." .. m.name }, " ", { "module-strings.hyper-desc" } }, { "module-strings.hyper-fallback-desc" } }
    if module.beacon_tint then
        if module.beacon_tint.primary and (module.beacon_tint.primary[2] and module.beacon_tint.primary[3]) then
            if  module.beacon_tint.primary[2] < module.beacon_tint.primary[3] then
                module.beacon_tint.primary[1] = 1
                module.beacon_tint.primary[2] = (module.beacon_tint.primary[2] and module.beacon_tint.primary[2] / 3 or 0.2)
                module.beacon_tint.primary[3] = (module.beacon_tint.primary[3] and module.beacon_tint.primary[3] or 1)
                module.beacon_tint.primary[4] = 1
            else
                module.beacon_tint.primary[1] = 1
                module.beacon_tint.primary[3] = (module.beacon_tint.primary[3] and module.beacon_tint.primary[3] / 3 or 0.2)
                module.beacon_tint.primary[2] = (module.beacon_tint.primary[2] and module.beacon_tint.primary[2] or 1)
                module.beacon_tint.primary[4] = 1
            end
        end
        if module.beacon_tint.secondary and (module.beacon_tint.secondary[2] and module.beacon_tint.secondary[3]) then
            if module.beacon_tint.secondary[2] < module.beacon_tint.secondary[3] then
                module.beacon_tint.secondary[1] = 1
                module.beacon_tint.secondary[2] = (module.beacon_tint.secondary[2] and module.beacon_tint.secondary[2] / 3 or 0.2)
                module.beacon_tint.secondary[3] = (module.beacon_tint.secondary[3] and module.beacon_tint.secondary[3] or 1)
                module.beacon_tint.secondary[4] = 1
            else
                module.beacon_tint.secondary[1] = 1
                module.beacon_tint.secondary[3] = (module.beacon_tint.secondary[3] and module.beacon_tint.secondary[3] / 3 or 0.2)
                module.beacon_tint.secondary[2] = (module.beacon_tint.secondary[2] and module.beacon_tint.secondary[2] or 1)
                module.beacon_tint.secondary[4] = 1
            end
        end
    end
    
    return module
end

local function add_oc_icons(icons, amount)

    for i = 1, 6, 1 do
        table.insert(icons, {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-framed.png",
            icon_size = 64,
            scale = 0.25,
            floating = true,
            shift = { 12, 14 - 4*i },
            tint = (i > amount and {0.0, 0.0, 0.0, 0.4} or {1, 1, 1, 1})
        })
    end

    return icons
end


local function create_overclocked(m, tier, icons, level)
    local module = table.deepcopy(m)
    module.name = m.name .. "-overclocked-".. level
    module.icons = table.deepcopy(icons)
    table.insert(module.icons, {
        icon = "__lilys-cubeine__/graphics/icons/speed-module-mask-overclocked.png",
        icon_size = 64,
        --tint = {0.5, 0.5, 0.5, 0.5}
    })
    add_oc_icons(module.icons, level)

    module.effect = effectutils.overclock_effect(module.category, module.effect, level, m.subgroup == "module-degraded")
    module.subgroup = "module-overclocked"

    module.localised_name = { "?", { "", { "module-strings.overclocked" }, " ", { "?", { "item-name." .. m.name }, { "item-name." .. tostring(string.gsub(m.name, "%-degraded", "")) } },  " (" .. tostring(level) .. ")"}, { "module-strings.overclocked-fallback" } }
    module.localised_description = { "?", { "", { "?", { "item-name." .. m.name }, { "item-name." .. tostring(string.gsub(m.name, "%-degraded", "")) } }, " ", { "module-strings.overclocked-desc" } }, { "module-strings.overclocked-fallback-desc" } }
    module.spoil_ticks = (oc[level].t / tier) * (m.subgroup == "module-degraded" and 0.5 or 1)
    --module.spoil_to_trigger = get_spoil_effect(m, module, level, m.subgroup == "module-degraded")
    module.spoil_result = nil

    if module.beacon_tint ~= nil then
        if not module.beacon_tint.primary then
            module.beacon_tint.primary = {1, 0, 0}
        end
        module.beacon_tint.primary[1] = 1
        module.beacon_tint.primary[2] = module.beacon_tint.primary[2] and (module.beacon_tint.primary[2] / 2) or 0
        module.beacon_tint.primary[3] = module.beacon_tint.primary[3] and (module.beacon_tint.primary[2] / 3) or 0
        if not module.beacon_tint.secondary then
            module.beacon_tint.secondary = {1, 0, 0}
        end
        module.beacon_tint.secondary[1] = 1
        module.beacon_tint.secondary[2] = module.beacon_tint.secondary[2] and (module.beacon_tint.secondary[2] / 2) or 0
        module.beacon_tint.secondary[3] = module.beacon_tint.secondary[3] and (module.beacon_tint.secondary[3] / 2) or 0
    else
        module.beacon_tint = {primary = {1, 0, 0}, secondary = {1, 0, 0}}
    end
    return module
end

local effects = {}
local function create_oc_recipe(module, level)
    local is_degraded = not (module.subgroup == "module")

    local recipe = {
        type = "recipe",
        name = module.name .. "-overclocked-" .. tostring(level),
        localised_name = { "?", { "", { "module-strings.overclocking" }, " ", { "?", { "item-name." .. module.name }, { "item-name." .. tostring(string.gsub(module.name, "%-degraded", "")) } },  " (" .. tostring(level) .. ")" }, { "module-strings.overclocking-fallback" } },
        subgroup = is_degraded and "module-degraded-overclocked" or "module-overclocked",
        enabled = false,
        energy_required = level * module.tier,
        category = mods["lilys-injector"] and "injection" or "crafting-with-fluid",
        ingredients = {
            {type = "item", name = module.name, amount = 1},
            {type = "fluid", name = "cubeine-solution", amount = 10 * module.tier * level * level * (is_degraded and 2 or 1)}
        },
        results = { { type = "item", name = module.name .. "-overclocked-" .. tostring(level), amount = 1 } },
        allow_productivity = false,
        allow_quality = false,
        order = "n[cubeine]-k[module-overclocking]-" .. module.tier .. "-" .. level,
        --hide_from_signal_gui = false,
        main_product = module.name .. "-overclocked-" .. tostring(level),
        crafting_machine_tint = {
            primary = { r = 0.882, g = 0.6, b = 0.675, a = 1.000 }, --#e199ac
            secondary = { r = 0.655, g = 0.349, b = 0.459, a = 1.000 }, --#a75975
            tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 }, --#9e1725
            quaternary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 }, --#9e1725
        },
        auto_recycle = false
    }
    table.insert(effects, {
        type = "unlock-recipe",
        recipe = recipe.name
    })
    data:extend({recipe})
end





-- only speed module prototype tables ...unless
local function add_overclocking(module)
    local name = module.name
    local icons
    if module.icon == nil then
    icons = module.icons
    else
        icons = {{
            icon = module.icon,
        }}
    end
    if module.icon_size then
        icons[1].icon_size = module.icon_size
    end
    --local tier = tonumber(string.match(name, "[^0-9]*([0-9])[^0-9]*") or "1")
    local tier = module.tier
    local degraded_version = create_degraded(module, tier, icons)
    local destroyed_version = create_destroyed(module, tier, icons)
    local hyper_version = create_hyper(module, tier, icons)

    local oc_list = {}
    local d_oc_list = {}

    for _, data in ipairs(oc) do

        if (_ <= settings.startup["max-overclock"].value) then

            local oc1 = create_overclocked(module, tier, icons, _)
            local oc2 = create_overclocked(degraded_version, tier, degraded_version.icons, _)
            table.insert(oc_list, oc1)
            table.insert(d_oc_list, oc2)
            create_oc_recipe(module, _)
            create_oc_recipe(degraded_version, _)
            rsl.register_spoilable_item(oc1, nil, degraded_version.name)
            rsl.register_spoilable_item(oc2, nil, degraded_version.name)
        end
    end

    --data:extend(oc_list)
    --data:extend(d_oc_list)


    data:extend({degraded_version, destroyed_version, hyper_version})
end



local tech = {
    type = "technology",
    name = "cubeine-overclocking",
    icon_size = 64,
    icons = {
        {
            icon = "__base__/graphics/icons/speed-module-3.png",
            scale = 4,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/speed-module-mask-overclocked.png",
            scale = 4,
        }
    },
    
    prerequisites = { "cubeine-solution", "agricultural-science-pack", "electromagnetic-science-pack" },

    unit = {
        count = 5000,
        ingredients =
        {
            { "automation-science-pack",   1 },
            { "logistic-science-pack",     1 },
            { "chemical-science-pack",     1 },
            { "production-science-pack",   1 },
            { "agricultural-science-pack", 1 },
            { "electromagnetic-science-pack" , 1}
        },
        time = 60

    },

    effects = effects
    
}
--[[
local allrecipes = data.raw["recipe"]
for name, recipe in pairs(allrecipes) do
    if (string.find(name, "overclocked") ~= nil) and (recipe.subgroup == "module-overclocked" or recipe.subgroup == "module-degraded-overclocked") then
        table.insert(tech.effects, {
            type = "unlock-recipe",
            recipe = name
        })
    end
end
--]]

if settings.startup["max-overclock"].value > 0 then
    data:extend({tech})


    local allmodules = data.raw["module"]
    local modules = {}

    local categories = {}
    categories["speed"] = true
    categories["productivity"] = settings.startup["overclock-all"].value
    categories["quality"] = settings.startup["overclock-all"].value
    categories["efficiency"] = settings.startup["overclock-all"].value
    categories["overclock"] = settings.startup["overclock-all"].value

    for name, module in pairs(allmodules) do
        if categories[module.category] then
        table.insert(modules, module) 
        end
    end

    for _, module in ipairs(modules) do
        if module.tier > 0 and (not module.hidden)then
            add_overclocking(module)
        end
    end
end