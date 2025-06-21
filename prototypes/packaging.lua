local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")


local powder_bag =  {

    type = "item",
    name = "cubeine-powder-bag",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine.png",
            scale = 0.375
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/plastic-bag.png",
            scale = 0.5
        }
    },
    subgroup = "cubeine-processes",
    order = "b[agriculture]-g[cubeine-powder-bag]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 4,
    default_import_location = "nauvis",
    weight = 10000
}

local crystal_bag = {

    type = "item",
    name = "cubeine-crystal-bag",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            scale = 0.375
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/plastic-bag.png",
            scale = 0.5
        }
    },
    subgroup = "cubeine-processes",
    order = "b[agriculture]-g[cubeine-crystal-bag]",
    inventory_move_sound = space_age_item_sounds.ice_inventory_move,
    pick_sound = space_age_item_sounds.ice,
    drop_sound = space_age_item_sounds.ice_inventory_move,
    stack_size = 4,
    default_import_location = "nauvis",
    weight = 5000,
}

data:extend({powder_bag, crystal_bag})

--recipe
data:extend({{
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine.png",
            scale = 0.375
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/plastic-bag.png",
            scale = 0.5,
            draw_background = true
        }
    },
    type = "recipe",
    name = "cubeine-powder-packing",
    subgroup = "cubeine-processes",
    enabled = false,
    energy_required = 1,
    emissions_multiplier = 1,
    ingredients = {
        { type = "item", name = "cubeine-powder", amount = 1000, ignored_by_stats = 1000 },
        { type = "item", name = "plastic-bar", amount = 1,  },
    },
    results = {
        { type = "item", name = "cubeine-powder-bag",      amount = 1, ignored_by_stats = 1 },
    },
    --main_product = "cubeine-powder",
    allow_productivity = false,
    allow_quality = false,
    order = "n[cubeine]-x[powder-packing]",
---@diagnostic disable-next-line: assign-type-mismatch
    auto_recycle = false,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    overload_multiplier = 2,
    allow_decomposition = false
}
})

--recipe
data:extend({{
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            scale = 0.375
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/plastic-bag.png",
            scale = 0.5,
            draw_background = true
        }
    },
    type = "recipe",
    name = "cubeine-crystal-packing",
    subgroup = "cubeine-processes",
    enabled = false,
    energy_required = 1,
    emissions_multiplier = 1,
    ingredients = {
        { type = "item", name = "cubeine-crystal", amount = 100, ignored_by_stats = 100 },
        { type = "item", name = "plastic-bar",    amount = 1, },
    },
    results = {
        { type = "item", name = "cubeine-crystal-bag", amount = 1, ignored_by_stats = 1 },
    },
    --main_product = "cubeine-powder",
    allow_productivity = false,
    allow_quality = false,
    order = "n[cubeine]-x[crystal-packing]",
    ---@diagnostic disable-next-line: assign-type-mismatch
    auto_recycle = false,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    overload_multiplier = 2,
    allow_decomposition = false
}})



--recipe
data:extend({{
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine.png",
            scale = 0.375
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/plastic-bag-torn.png",
            scale = 0.5,
            draw_background = true
        }
    },
    type = "recipe",
    name = "cubeine-powder-unpacking",
    subgroup = "cubeine-processes",
    enabled = false,
    energy_required = 1,
    emissions_multiplier = 1,
    ingredients = {
        { type = "item", name = "cubeine-powder-bag", amount = 1,    ignored_by_stats = 1 },
    },
    results = {
        { type = "item", name = "cubeine-powder", amount = 1000, ignored_by_stats = 1000 },
    },
    --main_product = "cubeine-powder",
    allow_productivity = false,
    allow_quality = false,
    order = "n[cubeine]-x[powder-unpacking]",
    ---@diagnostic disable-next-line: assign-type-mismatch
    auto_recycle = false,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    overload_multiplier = 2,
    allow_decomposition = false
}})

--recipe
data:extend({{
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            scale = 0.375
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/plastic-bag-torn.png",
            scale = 0.5,
            draw_background = true
        }
    },
    type = "recipe",
    name = "cubeine-crystal-unpacking",
    subgroup = "cubeine-processes",
    enabled = false,
    energy_required = 1,
    emissions_multiplier = 1,
    ingredients = {
        { type = "item", name = "cubeine-crystal-bag", amount = 1,   ignored_by_stats = 1 },
    },
    results = {
        { type = "item", name = "cubeine-crystal", amount = 100, ignored_by_stats = 100 },
    },
    
    allow_productivity = false,
    allow_quality = false,
    order = "n[cubeine]-x[crystal-unpacking]",
    ---@diagnostic disable-next-line: assign-type-mismatch
    auto_recycle = false,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    overload_multiplier = 2,
    allow_decomposition = false
}})


--technology
data:extend({
    {
        type = "technology",
        name = "cubeine-packing",
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine.png",
                icon_size = 64,
                scale = 3,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/plastic-bag.png",
                icon_size = 64,
                scale = 4,
            },
        },
        
        prerequisites = { "cubeplant-processing", "plastics" },

        research_trigger =
        {
            type = "craft-item",
            item = "cubeine-powder",
            amount = 1000
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-powder-packing"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-powder-unpacking"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-crystal-packing"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-crystal-unpacking"
            }
        }
    }
})
