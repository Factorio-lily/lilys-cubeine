local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")

local item = {
    type = "item",
    name = "cubeplant-flower",
    icon = "__lilys-cubeine__/graphics/icons/cubeplant-flower.png",
    subgroup = "agriculture-processes",
    order = "a[seeds]-d[cubeplant-flower]",
    plant_result = "redleaf-cubeplant",
    place_result = "redleaf-cubeplant",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 10,
    weight = 10 * kg,
    fuel_category = "chemical",
    fuel_value = "100kJ",
    fuel_emissions_multiplier = 10
}
data:extend({ item })

data:extend({
    {
        type = "recipe",
        name = "cubeplant-flower",
        category = "organic-or-assembling",
        subgroup = "cubeplant-processing",
        crafting_machine_tint = {
            primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 },    -- #ffbba4ff
            secondary = { r = 0.749, g = 0.557, b = 0.490, a = 1.000 },  -- #bf8e7dff
            tertiary = { r = 0.637, g = 0.637, b = 0.637, a = 1.000 },   -- #a2a2a2ff
            quaternary = { r = 0.283, g = 0.283, b = 0.283, a = 1.000 }, -- #484848ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item", name = "cubeplant-branch", amount = 1 }
        },
        results = { { type = "item", name = "cubeplant-flower", amount = 1 } }
    }
})



local item_super = {
    type = "item",
    name = "cubeplant-flower-super",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeplant-flower.png",
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeplant-flower-mask.png",
            tint = { 0.5, 0, 0, 0.5 },
            blend_mode = "additive"
        }
    },
    pictures = {
        layers = {
            {
                filename = "__lilys-cubeine__/graphics/icons/cubeplant-flower.png",
                width = 64,
                height = 64,
                scale = 0.5,
            },
            {
                filename = "__lilys-cubeine__/graphics/icons/cubeplant-flower-mask.png",
                width = 64,
                height = 64,
                scale = 0.5,
                tint = { 0.5, 0, 0, 0.5 },
                blend_mode = "additive",
                draw_as_glow = true
            }
        }
    },
    subgroup = "agriculture-processes",
    order = "a[seeds]-d[cubeplant-flower-super]",
    plant_result = "redleaf-cubeplant-super",
    place_result = "redleaf-cubeplant-super",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 10,
    weight = 10 * kg,
    fuel_category = "chemical",
    fuel_value = "100kJ",
    fuel_emissions_multiplier = 10
}
data:extend({ item_super })

data:extend({
    {
        type = "recipe",
        name = "cubeplant-flower-super",
        category = "organic",
        subgroup = "cubeplant-processing",
        crafting_machine_tint = {
            primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 }, -- #ffbba4ff
            secondary = { r = 1, g = 0.557, b = 0.490, a = 1.000 },   -- #bf8e7dff
            tertiary = { r = 1, g = 0.637, b = 0.637, a = 1.000 },    -- #a2a2a2ff
            quaternary = { r = 1, g = 0.283, b = 0.283, a = 1.000 },  -- #484848ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item",  name = "cubeplant-branch", amount = 10 },
            { type = "fluid", name = "liquid-cubonium",  amount = 20 },
            { type = "fluid", name = "heavy-oil",        amount = 200 }
        },
        results = { { type = "item", name = "cubeplant-flower-super", amount = 1 } }
    }
})

if mods["cubium"] then
    local item_blue = {
        type = "item",
        name = "cubeplant-flower-blue",
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeplant-flower-blue.png",
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeplant-flower-mask.png",
                tint = { 0, 0, 0.5, 0.5 },
                blend_mode = "additive"
            }
        },
        pictures = {
            layers = {
                {
                    filename = "__lilys-cubeine__/graphics/icons/cubeplant-flower-blue.png",
                    width = 64,
                    height = 64,
                    scale = 0.5,
                },
                {
                    filename = "__lilys-cubeine__/graphics/icons/cubeplant-flower-mask.png",
                    width = 64,
                    height = 64,
                    scale = 0.5,
                    tint = { 0, 0, 0.5, 0.5 },
                    blend_mode = "additive",
                    draw_as_glow = true
                }
            }
        },
        subgroup = "agriculture-processes",
        order = "a[seeds]-d[cubeplant-flower-super]",
        plant_result = "redleaf-cubeplant-blue",
        place_result = "redleaf-cubeplant-blue",
        inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
        pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
        drop_sound = space_age_item_sounds.agriculture_inventory_move,
        stack_size = 10,
        weight = 10 * kg,
        fuel_category = "chemical",
        fuel_value = "100kJ",
        fuel_emissions_multiplier = 0.1
    }
    data:extend({ item_blue })

    data:extend({
        {
            type = "recipe",
            name = "cubeplant-flower-blue-lava",
            category = "organic",
            subgroup = "cubeplant-processing",
            crafting_machine_tint = {
                primary = { r = 0.643, g = 0.735, b = 1, a = 1.000 }, -- #ffbba4ff
                secondary = { r = 0.490, g = 0.557, b = 1, a = 1.000 }, -- #bf8e7dff
                tertiary = { r = 0.637, g = 0.637, b = 1, a = 1.000 }, -- #a2a2a2ff
                quaternary = { r = 0.283, g = 0.283, b = 1, a = 1.000 }, -- #484848ff
            },
            allow_productivity = false,
            enabled = false,
            energy_required = 10,
            ingredients =
            {
                { type = "item",  name = "cubeplant-branch", amount = 20 },
                { type = "fluid", name = "ultradense-lava",  amount = 1000 }
            },
            results = { { type = "item", name = "cubeplant-flower-blue", amount = 1 } }
        }
    })


    data:extend({
        {
            type = "recipe",
            name = "cubeplant-flower-blue",
            category = "organic",
            subgroup = "cubeplant-processing",
            crafting_machine_tint = {
                primary = { r = 0.643, g = 0.735, b = 1, a = 1.000 },    -- #ffbba4ff
                secondary = { r = 0.490, g = 0.557, b = 1, a = 1.000 },  -- #bf8e7dff
                tertiary = { r = 0.637, g = 0.637, b = 1, a = 1.000 },   -- #a2a2a2ff
                quaternary = { r = 0.283, g = 0.283, b = 1, a = 1.000 }, -- #484848ff
            },
            allow_productivity = false,
            enabled = false,
            energy_required = 1,
            ingredients =
            {
                { type = "item", name = "cubeplant-branch-blue", amount = 1 },
            },
            results = { { type = "item", name = "cubeplant-flower-blue", amount = 1 } }
        }
    })
end
