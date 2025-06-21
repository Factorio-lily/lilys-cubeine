local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")

local item = {
    type = "item",
    name = "cubeplant-branch",
    icon = "__lilys-cubeine__/graphics/icons/cubeplant-branch.png",
    subgroup = "agriculture-processes",
    order = "b[agriculture]-c[cubeplant]",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    fuel_category = "chemical",
    fuel_value = "2MJ",
    fuel_emissions_multiplier = 10,
    stack_size = 20,
    default_import_location = "nauvis",
    weight = 20 * kg,
}
data:extend({ item })

local item_super = {
    type = "item",
    name = "cubeplant-branch-super",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeplant-branch.png",
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeplant-branch-mask.png",
            tint = { 0.5, 0, 0, 0.5 },
            blend_mode = "additive"
        }
    },
    pictures = {
        layers = {
            {
                filename = "__lilys-cubeine__/graphics/icons/cubeplant-branch.png",
                width = 64,
                height = 64,
                scale = 0.5,
            },
            {
                filename = "__lilys-cubeine__/graphics/icons/cubeplant-branch-mask.png",
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
    order = "b[agriculture]-c[cubeplant-super]",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    fuel_category = "chemical",
    fuel_value = "4MJ",
    fuel_emissions_multiplier = 10,
    stack_size = 20,
    default_import_location = "nauvis",
    weight = 20 * kg,
}
data:extend({ item_super })

if mods["cubium"] then
    local item_blue = {
        type = "item",
        name = "cubeplant-branch-blue",
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeplant-branch-blue.png",
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeplant-branch-mask.png",
                tint = { 0, 0, 0.5, 0.5 },
                blend_mode = "additive"
            }
        },
        pictures = {
            layers = {
                {
                    filename = "__lilys-cubeine__/graphics/icons/cubeplant-branch-blue.png",
                    width = 64,
                    height = 64,
                    scale = 0.5,
                },
                {
                    filename = "__lilys-cubeine__/graphics/icons/cubeplant-branch-mask.png",
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
        order = "b[agriculture]-c[cubeplant-blue]",
        inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
        pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
        drop_sound = space_age_item_sounds.agriculture_inventory_move,
        fuel_category = "chemical",
        fuel_value = "0.5MJ",
        fuel_emissions_multiplier = 0.5,
        stack_size = 20,
        default_import_location = "cubium",
        weight = 20 * kg,
    }
    data:extend({ item_blue })
end
