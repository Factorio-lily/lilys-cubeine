require ("sound-util")
require ("circuit-connector-sprites")
require ("util")
require ("__space-age__.prototypes.entity.circuit-network")



local biochamber_pictures = require("__space-age__.prototypes.entity.biochamber-pictures")

local biochamber = table.deepcopy(data.raw["assembling-machine"]["biochamber"])
biochamber.icon = nil
biochamber.icons = {
    {
        icon = "__space-age__/graphics/icons/biochamber.png",
        tint = { 0.2, 0, 0, 0.2 }
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
        layer.tint = {0.2, 0, 0, 0.2}
    end
    layer.animation_speed = 1.5
end


data:extend({biochamber})


--recipe
local recipe = {

    type = "recipe",
    name = "cubeine-biochamber",
    subgroup = "agriculture-processes",
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
        { type = "item",  name = "low-density-strcture",  amount = 100 },
    },
    results = {
        { type = "item", name = "cubeine-biochamber", amount = 1 },
    },
    category = "organic-or-assembling",
    main_product = "cubeine-biochamber",
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
                icon = "__spage-age__/graphics/technology/biochamber.png",
                icon_size = 256,
                tint = {0.2, 0, 0, 0.2}
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                shift = {-1.5, -1.5}
            }

        },
        prerequisites = { "cubeplant-solution", "agricultural-science-pack" },

        unit = {
            count = 1000,
            ingredients =
            {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "military-science-pack",     1 },
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
