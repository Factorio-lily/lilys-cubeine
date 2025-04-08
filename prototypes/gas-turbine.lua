local base_tint = { r = 1, g = 0.8, b = 0.8, a = 1 }
local emissive_tint = { r = 1, g = 0.2, b = 0.2, a = 1 }



local item1 = table.deepcopy(data.raw["item"]["steam-turbine"])
item1.order = "e[energy]-x[gas-turbine]"
item1.name = "lilys-gas-turbine"
item1.place_result = "lilys-gas-turbine"
item1.icons = {
    {
        icon = "__base__/graphics/icons/steam-turbine.png",
        icon_size = 64,
    },
    {
        icon = "__base__/graphics/icons/fluid/petroleum-gas.png",
        icon_size = 64,
        scale = 0.25,
        shift = { -6, -6 }
        --tint = { 0.7, 0.7, 0.7, 0.7 }
    },

}
local entity1 = table.deepcopy(data.raw["generator"]["steam-turbine"])
entity1.name = "lilys-gas-turbine"
entity1.minable.result = "lilys-gas-turbine"
entity1.effectivity = 2
entity1.burns_fluid = true
entity1.fluid_box.filter = "petroleum-gas"
entity1.fluid_box.minimum_temperature = nil
entity1.icons = table.deepcopy(item1.icons)
entity1.scale_fluid_usage = true
entity1.fluid_usage_per_tick = entity1.fluid_usage_per_tick / 5
entity1.max_power_output = "7.2MW"
entity1.smoke[1].name = "lilys-gas-turbine-smoke"
entity1.energy_source.emissions_per_minute = { ["pollution"] = 5 }
entity1.surface_conditions = {
    {
        property = "pressure",
        min = 300
    }
}


local smoke1 = table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"])
smoke1.name = "lilys-gas-turbine-smoke"
smoke1.color = { 0.1, 0.1, 0.1, 0.1 }



local item2 = table.deepcopy(data.raw["item"]["steam-turbine"])
item2.order = "e[energy]-y[cubeine-gas-turbine]"
item2.name = "cubeine-gas-turbine"
item2.place_result = "cubeine-gas-turbine"
item2.icons = {
    {
        icon = "__base__/graphics/icons/steam-turbine.png",
        icon_size = 64,
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/fluid/cubonium-gas.png",
        icon_size = 64,
        scale = 0.25,
        shift = { -6, -6 }
        --tint = { 0.7, 0.7, 0.7, 0.7 }
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 6, 6 }
    }
}
local entity2 = table.deepcopy(data.raw["generator"]["steam-turbine"])
entity2.name = "cubeine-gas-turbine"
entity2.max_health = 600
entity2.minable.result = "cubeine-gas-turbine"
entity2.effectivity = 2
entity2.burns_fluid = true
entity2.fluid_box.filter = "cubonium-gas"
entity2.fluid_box.minimum_temperature = nil
entity2.icons = table.deepcopy(item2.icons)
entity2.scale_fluid_usage = true
entity1.fluid_usage_per_tick = entity2.fluid_usage_per_tick / 5
entity2.max_power_output = "36MW"
entity2.horizontal_animation.layers[1].tint = base_tint
entity2.vertical_animation.layers[1].tint = base_tint
entity2.smoke[1].name = "cubeine-gas-turbine-smoke"
entity2.energy_source.emissions_per_minute = { ["pollution"] = 10 }
--[[entity2.surface_conditions = {
    {
        property = "pressure",
        min = 300
    }
}--]]


local smoke2 = table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"])
smoke2.name = "cubeine-gas-turbine-smoke"
smoke2.color = { 0.3, 0.5, 0.1, 0.4 }


---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ item1, entity1, smoke1, item2, entity2, smoke2, })


data:extend({
    {
        type = "recipe",
        name = "lilys-gas-turbine",
        enabled = false,
        energy_required = 6,
        category = "crafting-with-fluid",
        ingredients = {
            { type = "item",  name = "iron-gear-wheel", amount = 50 },
            { type = "item",  name = "copper-plate",    amount = 50 },
            { type = "item",  name = "pipe",            amount = 20 },
            { type = "item",  name = "steel-plate",     amount = 100 },
            { type = "fluid", name = "lubricant",       amount = 500 },
        },
        results = { { type = "item", name = "lilys-gas-turbine", amount = 1 } }
    },
    {
        type = "recipe",
        name = "cubeine-gas-turbine",
        enabled = false,
        energy_required = 18,
        ingredients = {
            { type = "item", name = "lilys-gas-turbine",     amount = 1 },
            { type = "item", name = "low-density-structure", amount = 50 },
            { type = "item", name = "cubeine-crystal",       amount = 5 } },
        results = { { type = "item", name = "cubeine-gas-turbine", amount = 1 } }
    },
    {
        type = "technology",
        name = "cubeine-gas-turbine",
        icon_size = 64,
        icon = "__base__/graphics/icons/steam-turbine.png",
        icons = {
            {
                icon = "__base__/graphics/icons/steam-turbine.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/fluid/cubonium-gas.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, -48 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            } },
        prerequisites = { "cubonium-gas" },

        unit = {
            count = 3000,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },

                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 },
                { "space-science-pack",      1 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "lilys-gas-turbine"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-gas-turbine"
            },
        }
    }
})
