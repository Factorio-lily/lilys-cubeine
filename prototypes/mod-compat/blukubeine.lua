local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

local blukubeine = {

    type = "item",
    name = "blukubeine-crystal",
    icons = { { icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-blue-1.png"

    } },
    pictures = {
        layers = {
            {
                filename = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-blue-1.png",
                size = 64,
                scale = 0.5,
                draw_as_glow = true
            },
            {
                filename = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-blue-1.png",
                size = 64,
                scale = 0.5,
                draw_as_glow = true
            }
        }
    },
    subgroup = "cubeine-products",
    order = "b[agriculture]-gb[blukubeine-crystal-a]",
    inventory_move_sound = space_age_item_sounds.ice_inventory_move,
    pick_sound = space_age_item_sounds.ice,
    drop_sound = space_age_item_sounds.ice_inventory_move,
    stack_size = 1,
    default_import_location = "cubium",
    weight = 1000 * kg,
    fuel_category = "cubic",
    fuel_value = "0.1TJ",
    fuel_acceleration_multiplier = 30,
    fuel_top_speed_multiplier = 5,
    fuel_emissions_multiplier = 0,
}

local blukubeine_depleted = {

    type = "item",
    name = "depleted-blukubeine-crystal",
    icons = { { icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-blue-1-depleted.png"

    } },
    pictures = {
        layers = {
            {
                filename = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-blue-1-depleted.png",
                size = 64,
                scale = 0.5,
            },
            {
                filename = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-blue-1-depleted.png",
                size = 64,
                scale = 0.5,
                tint = { 0.25, 0.25, 0.25, 0.25 },
                draw_as_glow = true
            }
        }
    },
    subgroup = "cubeine-products",
    order = "b[agriculture]-gb[blukubeine-crystal-depleted]",
    inventory_move_sound = space_age_item_sounds.ice_inventory_move,
    pick_sound = space_age_item_sounds.ice,
    drop_sound = space_age_item_sounds.ice_inventory_move,
    stack_size = 1,
    default_import_location = "cubium",
    weight = 1000 * kg,
    spoil_ticks = 1 * hour,
    spoil_result = "blukubeine-crystal"
}

--recipe
local inversion = {
    type = "recipe",
    name = "nukubeine-inversion",
    subgroup = "cubic",
    enabled = false,
    energy_required = 300,
    crafting_machine_tint = {
        primary = { r = 0, g = 0.004, b = 0.282, a = 1.000 },       --#48010b
        secondary = { r = 0.418, g = 1.000, b = 1.000, a = 1.000 }, --#510610
        tertiary = { r = 0.063, g = 0.024, b = 0.630, a = 1.000 },  --
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 },   --
    },
    ingredients = {
        { type = "item",  name = "nukubeine-crystal",  amount = 1 },
        { type = "item",  name = "cubeine-crystal",    amount = 42 },
        { type = "item",  name = "inverted-microcube", amount = 6 },
        { type = "fluid", name = "liquid-hope",        amount = 6000 },
        { type = "fluid", name = "liquid-courage",     amount = 6000 },
    },
    results = {
        { type = "item", name = "blukubeine-crystal",         amount = 1 },
        { type = "item", name = "inverted-dormant-microcube", amount = 6, ignored_by_productivity = 100 },
    },
    category = "cubic",
    order = "n[cubeine]-k[nukubeine-inversion]",
    main_product = "blukubeine-crystal",
    allow_productivity = false
}

--recipe
local recharging_hot = {
    type = "recipe",
    name = "blukubeine-hot-recharging",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-blue-1.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-red.png",
            icon_size = 64,
            tint = { 0.9, 0.9, 0.9, 0.9 }
        }
    },
    subgroup = "cubic",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0, g = 0.004, b = 0.282, a = 1.000 },       --#48010b
        secondary = { r = 0.418, g = 1.000, b = 1.000, a = 1.000 }, --#510610
        tertiary = { r = 0.063, g = 0.024, b = 0.630, a = 1.000 },  --
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 },   --
    },
    ingredients = {
        { type = "item",  name = "depleted-blukubeine-crystal", amount = 1 },
        { type = "item",  name = "cubeine-powder",              amount = 10 },
        { type = "item",  name = "carbon",                      amount = 200 },
        { type = "fluid", name = "ultradense-lava",             amount = 6000 },
    },
    results = {
        { type = "item", name = "blukubeine-crystal", amount = 1 },
    },
    category = "organic",
    order = "n[cubeine]-x[blukubeine-hot-charging]",
    main_product = "blukubeine-crystal",
    allow_productivity = false
}

--recipe
local recharging_cold = {
    type = "recipe",
    name = "blukubeine-cold-recharging",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-blue-1.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-blue.png",
            icon_size = 64,
            tint = { 0.9, 0.9, 0.9, 0.9 }
        }
    },
    subgroup = "cubic",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0, g = 0.004, b = 0.282, a = 1.000 },       --#48010b
        secondary = { r = 0.418, g = 1.000, b = 1.000, a = 1.000 }, --#510610
        tertiary = { r = 0.063, g = 0.024, b = 0.630, a = 1.000 },  --
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 },   --
    },
    ingredients = {
        { type = "item", name = "depleted-blukubeine-crystal", amount = 1 },
        { type = "item", name = "cubeine-powder",              amount = 10 },
        { type = "item", name = "cube-jelly",                  amount = 50 },
        { type = "item", name = "ice",                         amount = 100 },
    },
    results = {
        { type = "item", name = "blukubeine-crystal", amount = 1 },
    },
    category = "organic",
    order = "n[cubeine]-x[blukubeine-cold-charging]",
    main_product = "blukubeine-crystal",
    allow_productivity = false
}

--recipe
local cubonium = {
    type = "recipe",
    name = "blukubeine-cubonium-extraction",
    subgroup = "cubic",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0, g = 0.004, b = 0.282, a = 1.000 },       --#48010b
        secondary = { r = 0.418, g = 1.000, b = 1.000, a = 1.000 }, --#510610
        tertiary = { r = 0.063, g = 0.024, b = 0.630, a = 1.000 },  --
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 },   --
    },
    ingredients = {
        { type = "item", name = "blukubeine-crystal", amount = 1 },
        { type = "item", name = "inverted-microcube", amount = 1 },
        { type = "fluid", name = "water",              amount = 3000 },
    },
    results = {
        { type = "item",  name = "depleted-blukubeine-crystal", amount = 1,   ignored_by_productivity = 100 },
        { type = "item",  name = "inverted-dormant-microcube",  amount = 1,   ignored_by_productivity = 100 },
        { type = "fluid", name = "liquid-cubonium",             amount = 3000 },
    },
    category = "organic",
    order = "n[cubeine]-z[blukubeine-cubonium-extraction]",
    main_product = "liquid-cubonium",
    allow_productivity = true
}

--recipe
local azure = {
    type = "recipe",
    name = "blukubeine-azure-extraction",
    subgroup = "cubic",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0, g = 0.004, b = 0.282, a = 1.000 },       --#48010b
        secondary = { r = 0.418, g = 1.000, b = 1.000, a = 1.000 }, --#510610
        tertiary = { r = 0.063, g = 0.024, b = 0.630, a = 1.000 },  --
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 },   --
    },
    ingredients = {
        { type = "item", name = "blukubeine-crystal",  amount = 1 },
        { type = "item", name = "energized-microcube", amount = 1 },
        { type = "fluid", name = "water",               amount = 3000 },
    },
    results = {
        { type = "item",  name = "depleted-blukubeine-crystal", amount = 1,   ignored_by_productivity = 100 },
        { type = "item",  name = "dormant-microcube",           amount = 1,   ignored_by_productivity = 100 },
        { type = "fluid", name = "liquid-azure",                amount = 3000 },
    },
    category = "organic",
    order = "n[cubeine]-z[blukubeine-azure-extraction]",
    main_product = "liquid-azure",
    allow_productivity = true
}
--recipe
local purification = {
    type = "recipe",
    name = "blukubeine-purification-extraction",
    subgroup = "cubic",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0, g = 0.004, b = 0.282, a = 1.000 },       --#48010b
        secondary = { r = 0.418, g = 1.000, b = 1.000, a = 1.000 }, --#510610
        tertiary = { r = 0.063, g = 0.024, b = 0.630, a = 1.000 },  --
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 },   --
    },
    ingredients = {
        { type = "item",  name = "blukubeine-crystal", amount = 1 },
        { type = "fluid", name = "water",              amount = 3000 },
        { type = "fluid", name = "liquid-hope",              amount = 300 },
    },
    results = {
        { type = "item",  name = "depleted-blukubeine-crystal", amount = 1,   ignored_by_productivity = 100 },
        { type = "fluid", name = "purification-fluid",          amount = 3000 },
    },
    category = "organic",
    order = "n[cubeine]-z[blukubeine-purification-extraction]",
    main_product = "purification-fluid",
    allow_productivity = true
}
data:extend({ blukubeine, blukubeine_depleted, inversion, recharging_hot, recharging_cold, cubonium, azure, purification })
-- technology
data:extend({
    {
        type = "technology",
        name = "nukubeine-inversion",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-blue-1.png",
        prerequisites = { "blue-cubeplant-processing", "nukubeine-production" },

        unit = {
            count = 20000,
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
                { "cryogenic-science-pack",       1 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "nukubeine-inversion"
            },
            {
                type = "unlock-recipe",
                recipe = "blukubeine-hot-recharging"
            },
            {
                type = "unlock-recipe",
                recipe = "blukubeine-cold-recharging"
            },
            {
                type = "unlock-recipe",
                recipe = "blukubeine-cubonium-extraction"
            },
            {
                type = "unlock-recipe",
                recipe = "blukubeine-azure-extraction"
            },
            {
                type = "unlock-recipe",
                recipe = "blukubeine-purification-extraction"
            },
        }
    }
})
