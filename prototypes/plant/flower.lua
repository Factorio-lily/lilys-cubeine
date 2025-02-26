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
    fuel_value = "100kJ"
  }
  data:extend({item})



