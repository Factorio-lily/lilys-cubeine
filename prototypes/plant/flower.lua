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
  data:extend({item})

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

