require("prototypes.fluid.acidic-cubeplant-slurry")
require("prototypes.fluid.liquid-azure")
require("prototypes.fluid.purification-fluid")
require("prototypes.mod-compat.blukubeine")
require("prototypes.mod-compat.purification")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")


--recipe
local raw_slurry = {
    type = "recipe",
    name = "acidic-cubeplant-slurry",
    subgroup = "cubeplant-processing",
    enabled = false,
    energy_required = 20,
    crafting_machine_tint = {
        primary = { r = 0, g = 0.004, b = 0.282, a = 1.000 },       --#48010b
        secondary = { r = 0.418, g = 1.000, b = 1.000, a = 1.000 }, --#510610
        tertiary = { r = 0.063, g = 0.024, b = 0.630, a = 1.000 },  --
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 },   --
    },
    ingredients = {
        { type = "item",  name = "cubeplant-branch-blue", amount = 40 },
        { type = "fluid", name = "sulfuric-acid",         amount = 600 },
    },
    results = {
        { type = "fluid", name = "acidic-cubeplant-slurry", amount = 600 },
    },
    category = mods["maraxsis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "acidic-cubeplant-slurry",
    allow_productivity = true
}


--recipe
local slurry_neutralization = {
    type = "recipe",
    name = "acidic-slurry-neutralization",
    subgroup = "cubeplant-processing",
    enabled = false,
    energy_required = 20,
    crafting_machine_tint = {
        primary = { r = 0, g = 0.004, b = 0.282, a = 1.000 },       --#48010b
        secondary = { r = 0.418, g = 1.000, b = 1.000, a = 1.000 }, --#510610
        tertiary = { r = 0.063, g = 0.024, b = 0.630, a = 1.000 },  --
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 },   --
    },
    ingredients = {
        { type = "item",  name = "inverted-cube-jelly",     amount = 20 },
        { type = "fluid", name = "acidic-cubeplant-slurry", amount = 600 },
    },
    results = {
        { type = "item", name = "cubeine-jelly", amount = 20 },
        { type = "fluid", name = "water", amount = 200 },
    },
    category = "chemistry",
    additional_categories = { "organic" },
    main_product = "cubeine-jelly",
    allow_productivity = true
}

local jelly = {
    type = "item",
    name = "cubeine-jelly",
    icon = "__lilys-cubeine__/graphics/icons/cubeine-jelly.png",
    subgroup = "cubic",
    order = "j[cubic-cubeine-jelly]",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    fuel_category = "chemical",
    fuel_value = "1MJ",
    stack_size = 100,
    default_import_location = "cubium",
    spoil_ticks = 4 * minute,
    spoil_result = "cubeine-powder",
    weight = 0.5 * kg,
}

--recipe
local cube_forging = {
    type = "recipe",
    name = "cubeine-crystal-jellyforging",
    subgroup = "cubeine-processes",
    enabled = false,
    energy_required = 20,
    crafting_machine_tint = {
        primary = { r = 0, g = 0.004, b = 0.282, a = 1.000 },       --#48010b
        secondary = { r = 0.418, g = 1.000, b = 1.000, a = 1.000 }, --#510610
        tertiary = { r = 0.063, g = 0.024, b = 0.630, a = 1.000 },  --
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 },   --
    },
    ingredients = {
        { type = "item", name = "cubeine-jelly",       amount = 10 },
        { type = "item", name = "carbon",              amount = 50 },
        { type = "item", name = "energized-microcube", amount = 1 },
    },
    results = {
        { type = "item", name = "cubeine-crystal",   amount = 1 },
        { type = "item", name = "dormant-microcube", amount = 1, ignored_by_productivity = 100 },
    },
    category = "cubic",
    order = "n[cubeine]-e[crystal-jellyforging]",
    main_product = "cubeine-crystal",
    allow_productivity = true
}

data:extend({ raw_slurry, jelly, slurry_neutralization, cube_forging })
-- technology
data:extend({
    {
        type = "technology",
        name = "blue-cubeplant-processing",
        icon_size = 256,
        icon = "__lilys-cubeine__/graphics/technology/cubeplant-processing-3.png",
        prerequisites = { "cubeine-crystallization", "planet-discovery-cubium" },

        research_trigger =
        {
            type = "craft-item",
            item = "cube-smasher"
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeplant-flower-blue"
            }, 
            {
                type = "unlock-recipe",
                recipe = "cubeplant-flower-blue-lava"
            }, 
            {
                type = "unlock-recipe",
                recipe = "acidic-cubeplant-slurry"
            },
            {
                type = "unlock-recipe",
                recipe = "acidic-slurry-neutralization"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-crystal-jellyforging"
            }
        }
    }
})
