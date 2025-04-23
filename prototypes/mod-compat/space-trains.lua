local item_sounds = require("__base__.prototypes.item_sounds")
local meld = require("meld")
local charger_item = table.deepcopy(data.raw["item"]["space-train-battery-charging-station"])
charger_item.name = "cubeine-space-train-battery-charging-station"
charger_item.place_result = "cubeine-space-train-battery-charging-station"
charger_item.icon = nil
charger_item.icons = {
    {
        icon = "__se-space-trains__/graphics/icons/space-train-charging-station.png",
        icon_size = 64,
        tint = {1, 0.8, 0.8, 1}
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = {6, 6}
    }
}
charger_item.order = charger_item.order .. "-cubeine"



local charger = table.deepcopy(data.raw["assembling-machine"]["space-train-battery-charging-station"])
charger.name = "cubeine-space-train-battery-charging-station"
charger.minable.result = "cubeine-space-train-battery-charging-station"
charger.icon = nil
charger.icons = {
    {
        icon =  "__se-space-trains__/graphics/icons/space-train-charging-station.png",
        icon_size = 64,
        tint = {1, 0.8, 0.8, 1}
    }
}
charger.max_health = 300
charger.energy_usage = "10MW"
charger.crafting_speed = 6
charger.energy_source = {
        type = "electric",
        buffer_capacity = "40MJ",
        usage_priority = "primary-input",
        input_flow_limit = "20MW",
        output_flow_limit = "0kW",
        drain = "1kW"
    }
charger.fixed_recipe = "cubeine-space-train-battery-pack-recharge"
charger.graphics_set.idle_animation.layers[1].tint = {1, 0.8, 0.8, 1}
for _, vis in ipairs(charger.graphics_set.working_visualisations) do
    if vis.light then
        vis.light.color = {1, 0.2, 0.2, 1}
    end
    if vis.animation then
        for i, layer in ipairs(vis.animation.layers) do
            if layer.layers then
                layer.layers[1].tint = { 1, 0.8, 0.8, 1 }
                
            else
                layer.tint = { 1, 0.2, 0.2, 1 }
            end

        end
    end

end



local battery_discharged = table.deepcopy(data.raw["item"]["space-train-discharged-battery-pack"])
battery_discharged.name = "cubeine-space-train-discharged-battery-pack"
battery_discharged.icon = nil
battery_discharged.icons = {
    {
        icon = "__se-space-trains__/graphics/icons/discharged-battery.png",
        icon_size = 64,
        tint = {1, 0.65, 0.65, 1}
    }
}
battery_discharged.order = "s-ba[cubeine-discharged-battery-pack]"


local battery_charged = table.deepcopy(data.raw["item"]["space-train-battery-pack"])
battery_charged.name = "cubeine-space-train-battery-pack"
battery_charged.icon = nil
battery_charged.icons = {
    {
        icon = "__se-space-trains__/graphics/icons/discharged-battery.png",
        icon_size = 64,
        tint = { 1, 0.65, 0.65, 1 }
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/battery_light.png",
        icon_size = 64,
        tint = { 1, 0.2, 0.2, 1 },
        
    }
}
battery_charged.pictures = {
        layers = {{
            size = 64,
            filename = "__se-space-trains__/graphics/icons/battery.png",
            scale = 0.25,
            tint = { 1, 0.65, 0.65, 1 }
        }, 
        {
            draw_as_glow = true,
            size = 64,
            filename = "__lilys-cubeine__/graphics/icons/battery_light.png",
            scale = 0.25,
            tint = { 1, 0.2, 0.2, 1 }
        },
        {
            draw_as_light = true,
            flags = { "light" },
            size = 64,
            filename = "__lilys-cubeine__/graphics/icons/battery_light.png",
            scale = 0.25,
            tint = { 1, 0.2, 0.2, 1 }
        }
    }
    }
battery_charged.order = "s-aa[cubeine-battery-pack]"
battery_charged.fuel_acceleration_multiplier = 2
battery_charged.fuel_top_speed_multiplier = 1.6
battery_charged.burnt_result = "cubeine-space-train-discharged-battery-pack"
battery_charged.spoil_ticks = hour
battery_charged.spoil_result = battery_discharged.name

local battery_fried = {
    type = "item",
    name = "cubeine-space-train-destroyed-battery-pack",
    icons = {
        {
            icon = "__se-space-trains__/graphics/icons/destroyed-battery.png",
            icon_size = 64,
            tint = {1, 0.65, 0.65, 1}
        }
    },
    pictures = {
      layers = { {
        size = 64,
        filename = "__se-space-trains__/graphics/icons/destroyed-battery.png",
        scale = 0.25,
        tint = { 1, 0.65, 0.65, 1 }
      } }
    },
    burnt_result = "cubeine-space-train-discharged-battery-pack",
    subgroup = "intermediate-product",
    order = "s-ca[cubeine-destroyed-battery-pack]",
    stack_size = 60,
    inventory_move_sound = item_sounds.electric_small_inventory_move,
    pick_sound = item_sounds.electric_small_inventory_pickup,
    drop_sound = item_sounds.electric_small_inventory_move
  }



local crafting_battery = {
    type = "recipe",
    name = "cubeine-space-train-battery-pack",
    category = "electromagnetics",
    energy_required = 10,
    enabled = false,
    allow_as_intermediate = false,
    crafting_machine_tint = {
        primary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },    --#ff2b2b
        secondary = { r = 1, g = 0.067, b = 0.067, a = 1.000 },  --#ff1111
        tertiary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },   --#ff2b2b
        quaternary = { r = 1, g = 0.067, b = 0.067, a = 1.000 }, --#ff1111
    },
    ingredients = {
        { type = "item", name = "space-train-discharged-battery-pack", amount = 1 },
        { type = "item", name = "cubeine-crystal",     amount = 1 },
        { type = "item", name = "superconductor",                     amount = 10 },
        { type = "fluid", name = "cubeine-solution",                      amount = 400 }
    },
    localised_name = { "recipe-name.cubeine-space-train-discharged-battery-pack-desc" },
    results = { { type = "item", name = "cubeine-space-train-discharged-battery-pack", amount = 1 } },
}

local crafting_charger = {
    type = "recipe",
    name = "cubeine-space-train-battery-charging-station",
    energy_required = 30,
    enabled = false,
    category = "electromagnetics",
    ingredients = {
        { type = "item", name = "space-train-battery-charging-station", amount = 1 },
        { type = "item", name = "cubeine-crystal", amount = 5 },
        { type = "item", name = "low-density-structure",    amount = 50 },
        { type = "fluid", name = "cubeine-solution",                     amount = 2000 },
    },
    subgroup = "train-transport",
    order = "c[rolling-stock]-ha[cubeine-space-train-battery-charging-station]",
    results = { { type = "item", name = "cubeine-space-train-battery-charging-station", amount = 1 } },
}

local charging = {
  type = "recipe",
  name = "cubeine-space-train-battery-pack-recharge",
  category = "electrical",
  hidden = true,
  energy_required = 30,
  enabled = false,
  crafting_machine_tint = {
      primary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },    --#ff2b2b
      secondary = { r = 1, g = 0.067, b = 0.067, a = 1.000 },  --#ff1111
      tertiary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },   --#ff2b2b
      quaternary = { r = 1, g = 0.067, b = 0.067, a = 1.000 }, --#ff1111
  },
  icons = {
    {
        icon = "__se-space-trains__/graphics/icons/discharged-battery.png",
        icon_size = 64,
        tint = { 1, 0.65, 0.65, 1 }
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/battery_light.png",
        icon_size = 64,
        tint = { 1, 0.2, 0.2, 1 }
    }
 },
  subgroup = "intermediate-product",
  allow_as_intermediate = false,
  ingredients = {
    { type = "item", name = "cubeine-space-train-discharged-battery-pack", amount = 1 },
  },
  results = {
    {
      type = "item",
      name = "cubeine-space-train-destroyed-battery-pack",
      probability = 0.2,
      amount = 1
    },
    {
      type = "item",
      name = "cubeine-space-train-battery-pack",
      probability = 0.8,
      amount = 1
    }
  }
}

local repair = {
    type = "recipe",
    name = "cubeine-space-train-battery-pack-refurbish",
    energy_required = 10,
    enabled = false,
    category = "chemistry",
    crafting_machine_tint = {
        primary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },    --#ff2b2b
        secondary = { r = 1, g = 0.067, b = 0.067, a = 1.000 },  --#ff1111
        tertiary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },   --#ff2b2b
        quaternary = { r = 1, g = 0.067, b = 0.067, a = 1.000 }, --#ff1111
    },
    ingredients = {
        { type = "item",  name = "cubeine-space-train-destroyed-battery-pack", amount = 1 },
        { type = "fluid", name = "sulfuric-acid",                      amount = 20 },
        { type = "fluid", name = "cubeine-solution",                      amount = 200},
    },
    icons = {
        {
            icon = "__se-space-trains__/graphics/icons/destroyed-battery.png",
            icon_size = 64,
            tint = {1, 0.65, 0.65, 1}
        }
    },
    
    allow_as_intermediate = false,
    localised_name = { "recipe-name.cubeine-space-train-battery-pack-refurbish-desc" },
    results = { { type = "item", name = "cubeine-space-train-discharged-battery-pack", amount = 1 } },
}


local tech = {
    type = "technology",
    name = "cubeine-space-trains-power",

    icons = {
        {
            icon = "__se-space-trains__/graphics/icons/space-trains-tech.png",
            icon_size = 256,
            --tint = { 1, 0.8, 0.8, 1 },
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.5,
            shift = { 48, 48 }
        }

    },
    prerequisites = { "cubeine-solution", "electromagnetic-science-pack", "tech-space-trains" },

    unit = {
        count = 1000,
        ingredients =
        {
            { "automation-science-pack",   1 },
            { "logistic-science-pack",     1 },
            { "chemical-science-pack",     1 },
            { "utility-science-pack",   1 },
            { "electromagnetic-science-pack", 1 }
        },
        time = 60

    },

    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "cubeine-space-train-battery-charging-station"
        },
        {
            type = "unlock-recipe",
            recipe = "cubeine-space-train-battery-discharging-station"
        },
        {
            type = "unlock-recipe",
            recipe = "cubeine-space-train-battery-pack"
        },
        {
            type = "unlock-recipe",
            recipe = "cubeine-space-train-battery-pack-recharge"
        },
        {
            type = "unlock-recipe",
            recipe = "cubeine-space-train-battery-pack-refurbish"
        },
    }
}


local discharger_item = table.deepcopy(charger_item)
discharger_item.name = "cubeine-space-train-battery-discharging-station"
discharger_item.place_result = "cubeine-space-train-battery-discharging-station"
discharger_item.icons = {
    {
        icon = "__se-space-trains__/graphics/icons/space-train-charging-station.png",
        icon_size = 64,
        tint = {1, 0.8, 0.8, 1}
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/misc/signal-lightning.png",
        icon_size = 64,
        tint = { 0.8, 0.1, 0.1, 0.8 }
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = {6, 6}
    }
}
local discharger = meld.meld(table.deepcopy(charger), {
    type = "burner-generator",
    name = "cubeine-space-train-battery-discharging-station",
    icons = table.deepcopy(discharger_item.icons),
    energy_source = {
        type = "electric",
        buffer_capacity = "100MJ",
        usage_priority = "secondary-output",
        input_flow_limit = "0MW",
        output_flow_limit = "40MW",
    },
    max_power_output = "40MW",
    burner = {
        type = "burner",
        fuel_inventory_size = 1,
        burnt_inventory_size = 1,
        fuel_categories = { "electrical" },
        effectivity = 0.95,
        initial_fuel_percent = 0,
        light_flicker = {
            minimum_light_size = 9.9,
            color = {
                r = 1,
                g = 0.2,
                b = 0.2,
                a = 1
            }
        }
    },
    idle_animation = table.deepcopy(charger.graphics_set.idle_animation),
    always_draw_idle_animation = true,
    animation = table.deepcopy(charger.graphics_set.working_visualisations[2].animation)
})

local crafting_discharger = {
    type = "recipe",
    name = "cubeine-space-train-battery-discharging-station",
    energy_required = 30,
    enabled = false,
    category = "electromagnetics",
    ingredients = {
        { type = "item",  name = "space-train-battery-discharging-station", amount = 1 },
        { type = "item",  name = "cubeine-crystal",                      amount = 5 },
        { type = "item",  name = "low-density-structure",                amount = 50 },
        { type = "fluid", name = "cubeine-solution",                     amount = 2000 },
    },
    subgroup = "train-transport",
    order = "c[rolling-stock]-hb[cubeine-space-train-battery-discharging-station]",
    results = { { type = "item", name = "cubeine-space-train-battery-discharging-station", amount = 1 } },
}

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({battery_charged, battery_discharged, battery_fried, charger, charger_item, crafting_battery, crafting_charger, charging, repair, discharger_item, discharger, crafting_discharger, tech})