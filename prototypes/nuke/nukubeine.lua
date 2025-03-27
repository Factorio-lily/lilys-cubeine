local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

local cuburn3 = {
    {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                {
                    type = "create-entity",
                    entity_name = "nukubeine-flame",
                    probability = 1
                },
            }
        }
    },
    {
        type = "area",
        radius = 12,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "create-entity",
                    entity_name = "nukubeine-flame",
                    probability = 1
                }
            }
        }
    },
    {
        type = "cluster",
        cluster_count = 64,
        distance = 12,
        distance_deviation = 80,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "create-entity",
                    entity_name = "nukubeine-flame",
                    probability = 1
                }
            }
        }
    }
}

local category = {
    type = "fuel-category",
    name = "cubic"
}


local item = {

    type = "item",
    name = "nukubeine-crystal",
    icons = { { icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant.png"

    } },
    pictures = {
        layers = {
            {
                filename = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant.png",
                size = 64,
                scale = 0.5,
                draw_as_glow = true
            }
        }
    },
    subgroup = "cubeine-products",
    order = "b[agriculture]-ga[nukubeine-crystal]",
    inventory_move_sound = space_age_item_sounds.ice_inventory_move,
    pick_sound = space_age_item_sounds.ice,
    drop_sound = space_age_item_sounds.ice_inventory_move,
    stack_size = 1,
    default_import_location = "nauvis",
    weight = 1000 * kg,
    fuel_category = "cubic",
    fuel_value = "1TJ",
    fuel_acceleration_multiplier = 100,
    fuel_top_speed_multiplier = 20,
    fuel_emissions_multiplier = 100,
    spoil_ticks = hour / 3,
    spoil_to_trigger_result = {
        items_per_trigger = 1,
        trigger = {
            data.raw["projectile"]["atomic-rocket"].action,
            {
                type = "cluster",
                cluster_count = 16,
                distance = 40,
                distance_deviation = 80,
                action_delivery = {
                    type = "stream",
                    stream = "nukubeine-boom-shard",
                    starting_speed_deviation = 0.4,
                    starting_speed = 0.1
                }
            }
        }
    }
}

--[[data:extend{
    {
        type = "projectile",
        name = "nukubeine-boom-shard",
        acceleration = 0.001,
        animation = {
            filename = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant.png",
            size = 64,
            scale = 0.25,
            draw_as_glow = true
        },
        light = {color = {1, 0.1, 0.2, 1}, intensity = 0.8, size = 16},
        rotatable = true,
        height = 20,
        action = {
            data.raw["projectile"]["atomic-rocket"].action,
            cuburn3[1],
            cuburn3[2],
            cuburn3[3],
        }
    }
}--]]
data:extend {
    {
        type = "stream",
        name = "nukubeine-boom-shard",
        particle_spawn_interval = 5,
        particle_horizontal_speed = 0.2,
        particle_horizontal_speed_deviation = 0.15,
        particle_vertical_acceleration = 0.005,
        particle_buffer_size = 1,
        particle_spawn_timeout = 2,
        particle = {
            filename = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant.png",
            size = 64,
            scale = 0.25,
            draw_as_glow = true
        },
        shadow = {
            filename = "__lilys-cubeine__/graphics/icons/cubeine-crystal-shadow.png",
            size = 64,
            scale = 0.25,
            draw_as_shadow = true
        },
        stream_light = { color = { 1, 0.1, 0.2, 1 }, intensity = 0.8, size = 16 },
        ground_light = { color = { 1, 0.1, 0.2, 1 }, intensity = 1, size = 4 },
        target_position_deviation = 10,
        oriented_particle = true,
        action = {
            data.raw["projectile"]["atomic-rocket"].action,
            cuburn3[1],
            cuburn3[2],
            cuburn3[3],
        }
    }
}



--recipe
local cube = {

    type = "recipe",
    name = "nukubeine-crystal",
    subgroup = "cubeine-products",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant.png",
            icon_size = 64,
        }
    },
    enabled = false,
    energy_required = 60,
    emissions_multiplier = 10,
    ingredients = {
        { type = "item",  name = "cubeine-crystal", amount = 10 },
        { type = "item", name = "cubeine-powder",  amount = 100 },
        { type = "item",  name = "uranium-235",     amount = 100 },
        { type = "item",  name = "uranium-238",   amount = 1000,  ignore_in_stats = 900 },
        { type = "item",  name = "quantum-processor",   amount = 100,  ignore_in_stats = 100 },
    },
    results = {
        { type = "item", name = "nukubeine-crystal", amount = 1 },
        { type = "item", name = "uranium-238",       amount = 900, ignore_in_stats = 900,ignored_by_productivity = 900 },
        { type = "item",  name = "quantum-processor",   amount = 100,  ignore_in_stats = 100, ignored_by_productivity = 1000},
    },
    category = "centrifuging",
    main_product = "nukubeine-crystal",
    allow_productivity = false,
    preserve_products_in_machine_output = true,
    order = "nk[nukubeine]-f[crystal]",
    --hide_from_signal_gui = false
}

--recipe
local cooling = {

    type = "recipe",
    name = "nukubeine-crystal-cooling",
    subgroup = "cubeine-products",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-blue.png",
            icon_size = 64,
            tint = { 0.9, 0.9, 0.9, 0.9 }
        }
    },
    enabled = false,
    energy_required = 10,
    emissions_multiplier = 1,
    ingredients = {
        { type = "item",  name = "nukubeine-crystal", amount = 1 },
        { type = "fluid",  name = "fluoroketone-cold",     amount = 2000, ignore_in_stats = 2000 },
    },
    results = {
        { type = "item", name = "nukubeine-crystal", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 2000, ignore_in_stats = 2000 },
    },
    category = "cryogenics",
    main_product = "nukubeine-crystal",
    allow_productivity = false,
    allow_quality = false,
    result_is_always_fresh = true,
    preserve_products_in_machine_output = true,
    order = "nk[nukubeine]-f[crystal]",
    hide_from_signal_gui = false
}


data:extend({category, item, cube, cooling})

-- technology
data:extend({
    {
        type = "technology",
        name = "nukubeine-production",
        icon_size = 64,
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant.png",
                scale = 4,
            }
        },
        prerequisites = { "cubeine-crystallization", "fusion-reactor" },

        unit = {
            count = 10000,
            ingredients =
            {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "chemical-science-pack",     1 },
                { "production-science-pack",   1 },
                { "utility-science-pack",   1 },
                { "metallurgic-science-pack", 1 },
                { "agricultural-science-pack", 1 },
                { "electromagnetic-science-pack", 1 },
                { "cryogenic-science-pack", 1 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "nukubeine-crystal"
            },
            {
                type = "unlock-recipe",
                recipe = "nukubeine-crystal-cooling"
            }
        }
    }
})


local nukubeine_flame = table.deepcopy(data.raw["fire"]["fire-flame"])
nukubeine_flame.name = "nukubeine-flame"
nukubeine_flame.initial_lifetime = 12000
nukubeine_flame.lifetime_increase_by = 1500
nukubeine_flame.maximum_lifetime = 180000
nukubeine_flame.emissions_per_second = { pollution = 10, spores = 1 }
nukubeine_flame.flame_alpha = 0.8
nukubeine_flame.light.color = { 1, 0.1, 0.8, 1 }
nukubeine_flame.maximum_damage_multiplier = 100
nukubeine_flame.damage_multiplier_increase_per_added_fuel = 1
nukubeine_flame.damage_per_tick.amount = nukubeine_flame.damage_per_tick.amount * 10
--nukubeine_flame.spawn_entity = "nukubeine-flame"

for _, picture in ipairs(nukubeine_flame.pictures) do
    picture.tint = { 1, 0.1, 1, 1 }
end

for _, picture in ipairs(nukubeine_flame.smoke_source_pictures) do
    picture.tint = { 1, 0.1, 1, 1 }
end

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ nukubeine_flame })
