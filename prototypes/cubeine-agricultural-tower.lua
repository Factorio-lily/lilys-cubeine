data:extend({ {
    type = "corpse",
    name = "cubeine-agricultural-tower-remnants",
    icon = "__lilys-cubeine__/graphics/icons/cubeine-agricultural-tower.png",
    flags = { "placeable-neutral", "not-on-map" },
    hidden_in_factoriopedia = true,
    subgroup = "agriculture-remnants",
    order = "a[agricultural-tower]",
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation =
    {
        filename = "__lilys-cubeine-asset-pack__/graphics/entity/agricultural-tower/agricultural-tower-remnants.png",
        line_length = 1,
        width = 250,
        height = 250,
        frame_count = 1,
        direction_count = 1,
        shift = util.by_pixel(0, 0),
        scale = 0.5
    }
}
})

local item = table.deepcopy(data.raw.item["agricultural-tower"])
item.name = "cubeine-agricultural-tower"
item.place_result = "cubeine-agricultural-tower"
item.icon = "__lilys-cubeine__/graphics/icons/cubeine-agricultural-tower.png"
item.order = item.order .. "-cubeine"

local tower = table.deepcopy(data.raw["agricultural-tower"]["agricultural-tower"])
tower.name = "cubeine-agricultural-tower"
tower.icon = "__lilys-cubeine__/graphics/icons/cubeine-agricultural-tower.png"
tower.minable.result = "cubeine-agricultural-tower"
tower.max_health = tower.max_health * 4
tower.crane = require("prototypes.agricultural-tower-crane")

tower.corpse = "cubeine-agricultural-tower-remnants"

tower.input_inventory_size = 6
tower.output_inventory_size = 6
tower.radius = 4
tower.energy_usage = "1000kW"
tower.crane_energy_usage = "1000kW"

tower.surface_conditions =
{
    {
        property = "pressure",
        min = 500,
        max = 3000
    }
}

tower.graphics_set.animation = {

    layers =
    {
        util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/agricultural-tower/agricultural-tower-base",
            {
                priority = "high",
                animation_speed = 0.25,
                frame_count = 64,
                scale = 0.5
            }),
        util.sprite_load(
            "__lilys-cubeine-asset-pack__/graphics/entity/agricultural-tower/agricultural-tower-base-shadow",
            {
                priority = "high",
                frame_count = 1,
                repeat_count = 64,
                draw_as_shadow = true,
                scale = 0.5
            })
    }

}

tower.graphics_set.working_visualisations = {
    {
        always_draw = true,
        fog_mask = { rect = { { -30, -30 }, { 30, -2.75 } }, falloff = 1 },
        animation = util.sprite_load(
            "__lilys-cubeine-asset-pack__/graphics/entity/agricultural-tower/agricultural-tower-base",
            {
                frame_count = 1,
                scale = 0.5
            }),
    },

    {
        --constant_speed = true,
        always_draw = true,
        apply_recipe_tint = "primary",
        animation = util.sprite_load(
            "__lilys-cubeine-asset-pack__/graphics/entity/agricultural-tower/agricultural-tower-base-plant-mask",
            {
                priority = "high",
                frame_count = 64,
                animation_speed = 0.25,
                tint_as_overlay = true,
                scale = 0.5
            }),
    },
    {
        --constant_speed = true,
        apply_recipe_tint = "secondary",
        effect = "flicker",
        fadeout = true,
        animation = util.sprite_load(
            "__lilys-cubeine-asset-pack__/graphics/entity/agricultural-tower/agricultural-tower-base-light",
            {
                priority = "high",
                frame_count = 64,
                animation_speed = 0.25,
                blend_mode = "additive",
                scale = 0.5
            }),
    },
    {
        effect = "flicker",
        fadeout = true,
        light = { intensity = 1.0, size = 6, shift = { -0.45, -0.25 }, color = { r = 1, g = 1, b = 1 } }
    },
    {
        apply_recipe_tint = "secondary",
        effect = "flicker",
        fadeout = true,
        light = { intensity = 1.0, size = 16, shift = { -1.2, -0.5 }, color = { r = 1, g = 1, b = 1 } }
    }
}

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ item, tower })

--recipe
local recipe = {
    type = "recipe",
    name = "cubeine-agricultural-tower",
    subgroup = "agriculture",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },      --#9e1725
        secondary = { r = 0.882, g = 0.6, b = 0.675, a = 1.000 },    --#e199ac
        tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },     --#9e1725
        quaternary = { r = 0.655, g = 0.349, b = 0.459, a = 1.000 }, --#a75975
    },
    ingredients = {
        { type = "item",  name = "agricultural-tower",    amount = 1 },
        { type = "fluid", name = "cubeine-solution",      amount = 2000 },
        { type = "item",  name = "cubeine-powder",        amount = 50 },
        { type = "item",  name = "low-density-structure", amount = 100 },
    },
    results = {
        { type = "item", name = "cubeine-agricultural-tower", amount = 1 },
    },
    category = "organic-or-assembling",
    main_product = "cubeine-agricultural-tower",
    allow_productivity = false

}

data:extend({ recipe })

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-agricultural-tower",

        icons = {
            {
                icon = "__lilys-cubeine__/graphics/technology/cubeine-agricultural-tower.png",
                icon_size = 256,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            }

        },
        prerequisites = { "cubeine-biochamber" },

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
                recipe = "cubeine-agricultural-tower"
            }
        }
    }
})
