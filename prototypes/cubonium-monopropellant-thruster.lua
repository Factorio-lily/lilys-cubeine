require("sound-util")
require("circuit-connector-sprites")
require("util")
require("__space-age__.prototypes.entity.circuit-network")
local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")


local biochamber_pictures = require("__space-age__.prototypes.entity.biochamber-pictures")

local thruster_item = {
    type = "item",
    name = "cubonium-monopropellant-thruster",
    icons = {
        {
            icon = "__space-age__/graphics/icons/thruster.png",
            icon_size = 64,
            tint = { 1, 0.6, 0.9, 1 },
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/fluid/liquid-cubonium.png",
            icon_size = 64,
            scale = 0.25,
            shift = { -6, -6 }
        }
    },
    subgroup = "space-platform",
    order = "g[cubonium-monopropellant-thruster]",
    inventory_move_sound = space_age_item_sounds.rocket_inventory_move,
    pick_sound = space_age_item_sounds.rocket_inventory_pickup,
    drop_sound = space_age_item_sounds.rocket_inventory_move,
    place_result = "cubonium-monopropellant-thruster",
    stack_size = 10,
    weight = 200 * kg
}


local thruster = table.deepcopy(data.raw["thruster"]["thruster"])
thruster.icon = nil
thruster.
icons = {
    {
        icon = "__space-age__/graphics/icons/thruster.png",
        icon_size = 64,
        tint = { 1, 0.6, 0.9, 1 },
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 6, 6 }
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/fluid/liquid-cubonium.png",
        icon_size = 64,
        scale = 0.25,
        shift = { -6, -6 }
    }

}
thruster.name = "cubonium-monopropellant-thruster"
thruster.minable.result = "cubonium-monopropellant-thruster"
thruster.max_health = 600
thruster.min_performance = { fluid_volume = 0.1, fluid_usage = 2.0/60, effectivity = 1 }
thruster.max_performance = { fluid_volume = 0.8, fluid_usage = 6.0/60, effectivity = 2/3.0 }

thruster.fuel_fluid_box =
{
    filter = "liquid-cubonium",
    production_type = "input",
    -- pipe_covers = pipecoverspictures(),
    draw_only_when_connected = true,
    volume = 500,
    pipe_connections =
    {
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.west, position = { -1.5, -2 }, enable_working_visualisations = { "pipe-4" } },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.east, position = { 1.5, 0 },   enable_working_visualisations = { "pipe-2" } },
    }
}
thruster.oxidizer_fluid_box =
{
    filter = "liquid-cubonium",
    production_type = "input",
    -- pipe_covers = pipecoverspictures(),
    draw_only_when_connected = true,
    volume = 500,
    pipe_connections =
    {
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.east, position = { 1.5, -2 }, enable_working_visualisations = { "pipe-1" } },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.west, position = { -1.5, 0 }, enable_working_visualisations = { "pipe-3" } },
    }
}

thruster.graphics_set.animation.animation_speed = 1
thruster.graphics_set.animation.animation_speed = 1
thruster.graphics_set.animation.tint = { 1, 0.6, 0.9, 1 }


for _, vis in ipairs(thruster.graphics_set.working_visualisations) do
    if _ == 5 then
        vis.animation.tint = { 1, 0.7, 1, 1 }
        vis.animation.animation_speed = 1.5
    end
end
thruster.graphics_set.flame_effect.filename = "__lilys-cubeine__/graphics/entity/thruster-flame-3.png"
thruster.plumes = nil
--thruster.plumes.stateless_visualisations[2].animation.tint = { 1, 0.1, 0.1, 0 }

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ thruster_item, thruster })



--recipe
local recipe = {
    icons = {
        {
            icon = "__space-age__/graphics/icons/thruster.png",
            icon_size = 64,
            tint = { 1, 0.6, 0.9, 1 },
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/fluid/liquid-cubonium.png",
            icon_size = 64,
            scale = 0.25,
            shift = { -6, -6 }
        }
    },
    type = "recipe",
    name = "cubonium-monopropellant-thruster",
    subgroup = "space-platform",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },      --#9e1725
        secondary = { r = 0.882, g = 0.6, b = 0.675, a = 1.000 },    --#e199ac
        tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },     --#9e1725
        quaternary = { r = 0.655, g = 0.349, b = 0.459, a = 1.000 }, --#a75975
    },
    ingredients = {
        { type = "item", name = "cubeine-thruster",  amount = 1 },
        { type = "item", name = "tungsten-plate",    amount = 100 },
        { type = "item", name = "nukubeine-crystal", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 100 },
    },
    results = {
        { type = "item", name = "cubonium-monopropellant-thruster", amount = 1 },
    },
    category = "cryogenics",
    --main_product = "cubeine-assembler",
    allow_productivity = false

}




--recipe
local fuel = {
    type = "recipe",
    name = "liquid-cubonium",
    --subgroup = "space-platform",
    enabled = false,
    energy_required = 5,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },     --#9e1725
        secondary = { r = 0.937, b = 0.335, g = 0.496, a = 1.000 }, --#f0567f
        tertiary = { r = 0.898, g = 0.261, b = 0.535, a = 1.000 },  --#e64389
        quaternary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },  --#9e1725
    },
    ingredients = {
        { type = "fluid", name = "cubonium-gas",      amount = 1000 },
        { type = "fluid", name = "fluoroketone-cold", amount = 200, ignored_by_stats = 200 },
    },
    results = {
        { type = "fluid", name = "liquid-cubonium",  amount = 100 },
        { type = "fluid", name = "fluoroketone-hot", amount = 200, ignored_by_stats = 200 },
    },
    category = "cryogenics",
    main_product = "liquid-cubonium",
    allow_productivity = false

}

--recipe
local no_fuel = {
    type = "recipe",
    name = "liquid-cubonium-evaporation",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/fluid/liquid-cubonium.png",
            icon_size = 64
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/fluid/cubonium-gas.png",
            icon_size = 64,
            tint = {0.8, 0.8, 0.8, 0.8}
        }
    },
    --subgroup = "space-platform",
    enabled = false,
    energy_required = 5,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },     --#9e1725
        secondary = { r = 0.937, b = 0.335, g = 0.496, a = 1.000 }, --#f0567f
        tertiary = { r = 0.898, g = 0.261, b = 0.535, a = 1.000 },  --#e64389
        quaternary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },  --#9e1725
    },
    ingredients = {
        { type = "fluid", name = "liquid-cubonium",   amount = 100 },
    },
    results = {
        { type = "fluid", name = "cubonium-gas",     amount = 1000 },
    },
    category = "cryogenics",
    main_product = "cubonium-gas",
    allow_productivity = false

}

data:extend({ recipe, fuel, no_fuel })

-- technology
data:extend({
    {
        type = "technology",
        name = "cubonium-monopropellant-thruster",

        icons = {
            {
                icon = "__space-age__/graphics/technology/space-platform-thruster.png",
                icon_size = 256,
                tint = { 1, 0.8, 0.8, 1 },
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/fluid/liquid-cubonium.png",
                icon_size = 64,
                scale = 1,
                shift = { -48, -48 }
            }

        },
        prerequisites = { "nukubeine-production", "cubeine-gas-turbine", "cubeine-thruster" },

        unit = {
            count = 10000,
            ingredients =
            {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "utility-science-pack",         1 },
                { "metallurgic-science-pack",     1 },
                { "agricultural-science-pack",    1 },
                { "electromagnetic-science-pack", 1 },
                { "cryogenic-science-pack",       2 },
            },
            time = 60

        },

        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubonium-monopropellant-thruster"
            },
            {
                type = "unlock-recipe",
                recipe = "liquid-cubonium"
            },
            {
                type = "unlock-recipe",
                recipe = "liquid-cubonium-evaporation"
            }
        }
    }
})
