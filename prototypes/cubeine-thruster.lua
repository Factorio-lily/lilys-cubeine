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
    name = "cubeine-thruster",
    icons = {
        {
            icon = "__space-age__/graphics/icons/thruster.png",
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
    subgroup = "space-platform",
    order = "f[cubeine-thruster]",
    inventory_move_sound = space_age_item_sounds.rocket_inventory_move,
    pick_sound = space_age_item_sounds.rocket_inventory_pickup,
    drop_sound = space_age_item_sounds.rocket_inventory_move,
    place_result = "cubeine-thruster",
    stack_size = 10,
    weight = 200*kg
  }
  

local thruster = table.deepcopy(data.raw["thruster"]["thruster"])
thruster.icon = nil
thruster.icons = {
    {
        icon = "__space-age__/graphics/icons/thruster.png",
        tint = { 1, 0.8, 0.8, 1 },
    }
}
thruster.name = "cubeine-thruster"
thruster.minable.result = "cubeine-thruster"
thruster.max_health = 600
thruster.min_performance = {fluid_volume = 0.1, fluid_usage = 0.5, effectivity = 0.6}
thruster.max_performance = {fluid_volume = 0.5, fluid_usage = 5, effectivity = 0.4}

thruster.fuel_fluid_box =
{
    filter = "cubeine-fuel",
    production_type = "input",
    -- pipe_covers = pipecoverspictures(),
    draw_only_when_connected = true,
    volume = 2000,
    pipe_connections =
    {
---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.west, position = { -1.5, -2 }, enable_working_visualisations = { "pipe-4" } },
---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.east, position = { 1.5, 0 }, enable_working_visualisations = { "pipe-2" } },
    }
}
thruster.oxidizer_fluid_box =
    {
      filter = "thruster-oxidizer",
      production_type = "input",
      -- pipe_covers = pipecoverspictures(),
      draw_only_when_connected = true,
      volume = 2000,
      pipe_connections =
      {
---@diagnostic disable-next-line: assign-type-mismatch
        {flow_direction = "input-output", direction = defines.direction.east, position = { 1.5, -2}, enable_working_visualisations = { "pipe-1" }},
---@diagnostic disable-next-line: assign-type-mismatch
        {flow_direction = "input-output", direction = defines.direction.west, position = {-1.5,  0}, enable_working_visualisations = { "pipe-3" }},
      }
    }

thruster.graphics_set.animation.animation_speed = 1
thruster.graphics_set.animation.animation_speed = 1
thruster.graphics_set.animation.tint = {1, 0.8, 0.8, 1}


for _, vis in ipairs(thruster.graphics_set.working_visualisations) do
    if _ == 5 then
        vis.animation.tint = { 1, 0.4, 0.4, 1 }
        vis.animation.animation_speed = 1
    end
    
end
thruster.graphics_set.flame_effect.filename = "__lilys-cubeine__/graphics/entity/thruster-flame.png"
thruster.plumes.stateless_visualisations[2].animation.tint = {1, 0.1, 0.1, 1}

data:extend({ thruster_item, thruster })



--recipe
local recipe = {
    icons = {
        {
            icon = "__space-age__/graphics/icons/thruster.png",
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
    name = "cubeine-thruster",
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
        { type = "item",  name = "thruster",            amount = 1 },
        { type = "item", name = "tungsten-plate",      amount = 100 },
        { type = "item",  name = "cubeine-crystal",       amount = 10 },
        { type = "item",  name = "low-density-structure", amount = 100 },
    },
    results = {
        { type = "item", name = "cubeine-thruster", amount = 1 },
    },
    category = "advanced-crafting",
    --main_product = "cubeine-assembler",
    allow_productivity = false

}




--recipe
local fuel = {

    type = "recipe",
    name = "cubeine-fuel-mixing",
    subgroup = "space-platform",
    enabled = false,
    energy_required = 15,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },    --#9e1725
        secondary = {r = 1, g = 0.767, b = 0.605, a = 1}, -- #ffc39aff
        tertiary = {r = 1, g = 0.649, b = 0.542, a = 1}, -- #ffa58aff
        quaternary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },  --#9e1725
    },
    ingredients = {
        { type = "fluid", name = "thruster-fuel",          amount = 10000 },
        { type = "item",  name = "cubeine-powder", amount = 10 },
    },
    results = {
        { type = "fluid", name = "cubeine-fuel", amount = 10000 },
    },
    category = mods["maraxsis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "cubeine-fuel",
    allow_productivity = false

}

data:extend({ recipe, fuel })

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-thruster",

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
            }

        },
        prerequisites = { "cubeine-solution", "agricultural-science-pack", "metallurgic-science-pack" },

        unit = {
            count = 2000,
            ingredients =
            {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "chemical-science-pack",     1 },
                { "production-science-pack",   1 },
                { "agricultural-science-pack", 1 },
                { "metallurgic-science-pack" , 1 }
            },
            time = 60

        },

        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-thruster"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-fuel-mixing"
            }
        }
    }
})
