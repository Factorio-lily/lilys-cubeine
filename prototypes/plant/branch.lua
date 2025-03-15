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
