local common = require("__Cerys-Moon-of-Fulgora__/common")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")




if data.raw["reactor"]["cerys-radiative-tower"] then
    local tower = table.deepcopy(data.raw["reactor"]["cerys-radiative-tower"])
    tower.name = "cubeine-cerys-radiative-tower"
    tower.order = "z-da[radiative-tower-cubeine]"
    energy_source = {
        type = "burner",
        fuel_categories = { "cubic" },
        
        emissions_per_minute = { pollution = 5 },
        effectivity = 0.75,
        fuel_inventory_size = 2, -- not too high so you can see the fuel on belts
        burnt_inventory_size = 1,
    }
end


local category = {
    type = "fuel-category",
    name = "cubic"
}


local item = {

    type = "item",
    name = "radiant-cubeine-crystal",
    icons = { { icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-2.png" 

} },
    subgroup = "agriculture-processes",
    order = "b[agriculture]-ga[cubeine-crystal-radiant]",
    inventory_move_sound = space_age_item_sounds.ice_inventory_move,
    pick_sound = space_age_item_sounds.ice,
    drop_sound = space_age_item_sounds.ice_inventory_move,
    stack_size = 10,
    default_import_location = "nauvis",
    weight = 50,
    fuel_category = "cubic",
    fuel_value = "10GJ",
    fuel_acceleration_multiplier = 20,
    fuel_top_speed_multiplier = 5,
    fuel_emissions_multiplier = 100,
}

--recipe
local cube = {

    type = "recipe",
    name = "radiant-cubeine-crystal",
    subgroup = "agriculture-processes",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant-2.png",
            icon_size = 64,
        }
    },
    enabled = false,
    energy_required = 60,
    emissions_multiplier = 10,
    ingredients = {
        { type = "fluid", name = "cubeine-powder", amount = 100 },
        { type = "item",  name = "cubeine-crystal",      amount = 1 },
        { type = "item",  name = "uranium-235",           amount = 20 },
        { type = "item", name = "plutonium-239",          amount = 1, ignore_in_stats = 1},
    },
    results = {
        { type = "item",  name = "radiant-cubeine-crystal", amount = 1 },
        { type = "item", name = "plutonium-239",          amount = 1, ignore_in_stats = 1},
    },
    category = "centrifuging",
    main_product = "radiant-cubeine-crystal",
    allow_productivity = false,
    order = "n[cubeine]-f[crystal-radiant]",
    hide_from_signal_gui = false
}
