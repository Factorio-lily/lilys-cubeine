require ("sound-util")
require ("circuit-connector-sprites")
require ("util")
require ("__space-age__.prototypes.entity.circuit-network")
local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")


local biochamber_pictures = require("__space-age__.prototypes.entity.biochamber-pictures")

local biochamber_item = {
    
        type = "item",
        name = "cubeine-biochamber",
        icons = {
            {
                icon = "__space-age__/graphics/icons/biochamber.png",
                icon_size = 64,
                tint = { 1, 0.8, 0.8, 1 },
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.25,
                shift = {6, 6}
            }

        },
        subgroup = "agriculture",
        order = "b[cubeine-biochamber]",
        inventory_move_sound = item_sounds.fluid_inventory_move,
        pick_sound = item_sounds.fluid_inventory_pickup,
        drop_sound = item_sounds.fluid_inventory_move,
        place_result = "cubeine-biochamber",
        stack_size = 20,
        default_import_location = "gleba"
}





local biochamber = table.deepcopy(data.raw["assembling-machine"]["biochamber"])
biochamber.icon = nil
biochamber.icons = {
    {
        icon = "__space-age__/graphics/icons/biochamber.png",
        tint = { 1, 0.8, 0.8, 1 },
    }
}
biochamber.name = "cubeine-biochamber"
biochamber.minable.result = "cubeine-biochamber"
biochamber.crafting_speed = 3
biochamber.energy_source = {
    type = "fluid",
    burns_fluid = true,
    fuel_categories = { "nutrients" },
    effectivity = 1,
    scale_fluid_usage = true,
    emissions_per_minute = { pollution = 10 },
    light_flicker = require("__space-age__.prototypes.entity.biochamber-pictures").light_flicker,
    fluid_box = {
        volume = 1000,
        filter = "cubeine-solution",
        draw_only_when_connected = true,
        pipe_covers = pipecoverspictures(),
        pipe_connections =
        {
            { flow_direction = "input-output", direction = defines.direction.west, position = { -1, 0 } },
            { flow_direction = "input-output", direction = defines.direction.east, position = { 1, 0 } }
        },
        production_type = "input"
    }
}
biochamber.energy_usage = "1MW"

for _, layer in ipairs(biochamber.graphics_set.animation.layers) do
    if _ == 1 or _ == 2 then
        layer.tint = {1, 0.8, 0.8, 1}
    end
    layer.animation_speed = 1.5
end
biochamber.name = "cubeine-biochamber"

data:extend({biochamber_item, biochamber})


--recipe
local recipe = {
    icons = {
        {
            icon = "__space-age__/graphics/icons/biochamber.png",
            icon_size = 64,
            tint = { 1, 0.8, 0.8, 1 },
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        }
    },
    type = "recipe",
    name = "cubeine-biochamber",
    subgroup = "agriculture",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },    --#9e1725
        secondary = { r = 0.882, g = 0.6, b = 0.675, a = 1.000 },     --#e199ac
        tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },  --#9e1725
        quaternary = { r = 0.655, g = 0.349, b = 0.459, a = 1.000 }, --#a75975
    },
    ingredients = {
        { type = "item",  name = "biochamber",   amount = 1 },
        { type = "fluid", name = "cubeine-solution", amount = 4000 },
        { type = "item",  name = "cubeine-crystal", amount = 10 },
        { type = "item",  name = "low-density-structure",  amount = 100 },
    },
    results = {
        { type = "item", name = "cubeine-biochamber", amount = 1 },
    },
    category = "organic-or-assembling",
    --main_product = "cubeine-biochamber",
    allow_productivity = false

}

data:extend({ recipe })

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-biochamber",
        
        icons = {
            {
                icon = "__space-age__/graphics/technology/biochamber.png",
                icon_size = 256,
                tint = {1, 0.8, 0.8, 1},
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = {48, 48}
            }

        },
        prerequisites = { "cubeine-solution", "agricultural-science-pack" },

        unit = {
            count = 1000,
            ingredients =
            {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "chemical-science-pack",     1 },
                { "production-science-pack",   1 },
                { "agricultural-science-pack", 1 }
            },
            time = 60

        },

        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-biochamber"
            }
        }
    }
})
