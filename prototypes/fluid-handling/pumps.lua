require("util")
local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local item_tints = require("__base__.prototypes.item-tints")

local base_tint = { r = 1, g = 0.6, b = 0.6, a = 1 }

local pipe_picture = table.deepcopy(require("__space-age__.prototypes.entity.electromagnetic-plant-pictures")
.pipe_pictures)
for _, pic in pairs(pipe_picture or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end

local pipe_covers = table.deepcopy(pipecoverspictures())
for _, pic in pairs(pipe_covers or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end


data:extend({
    {
        type = "corpse",
        name = "cubeine-pump-remnants",
        icon = "__lilys-cubeine__/graphics/icons/pump.png",
        flags = { "placeable-neutral", "not-on-map" },
        hidden_in_factoriopedia = true,
        subgroup = "energy-pipe-distribution-remnants",
        order = "a-d-a",
        selection_box = { { -0.5, -1 }, { 0.5, 1 } },
        tile_width = 1,
        tile_height = 2,
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15, -- 15 minutes
        expires = false,
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = make_rotated_animation_variations_from_sheet(1,
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/remnants/pump-remnants.png",
                line_length = 1,
                width = 188,
                height = 186,
                direction_count = 4,
                shift = util.by_pixel(2, 2),
                scale = 0.5
            })
    },
})
local pump_i = {
    type = "item",
    name = "cubeine-pump",
    icon = "__lilys-cubeine__/graphics/icons/pump.png",
    subgroup = "energy-pipe-distribution",
    order = "b[pipe]-cc[cubeine-pump]",
    inventory_move_sound = item_sounds.fluid_inventory_move,
    pick_sound = item_sounds.fluid_inventory_pickup,
    drop_sound = item_sounds.fluid_inventory_move,
    place_result = "cubeine-pump",
    stack_size = 50,
    random_tint_color = item_tints.iron_rust
}
local pump = {
    type = "pump",
    name = "cubeine-pump",
    icon = "__lilys-cubeine__/graphics/icons/pump.png",
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "cubeine-pump" },
    max_health = 480,
    heating_energy = nil,
    fast_replaceable_group = "pipe",
    corpse = "cubeine-pump-remnants",
    dying_explosion = "pump-explosion",
    collision_box = { { -0.29, -0.9 }, { 0.29, 0.9 } },
    selection_box = { { -0.5, -1 }, { 0.5, 1 } },
    icon_draw_specification = { scale = 0.5 },
    working_sound =
    {
        sound = { filename = "__base__/sound/pump.ogg", volume = 0.5, audible_distance_modifier = 0.5 },
        max_sounds_per_prototype = 2
    },
    damaged_trigger_effect = hit_effects.entity(),
    resistances =
    {
        {
            type = "fire",
            percent = 100
        },
        {
            type = "impact",
            percent = 50
        }
    },
    fluid_box =
    {
        volume = 400,
        pipe_covers = pipe_covers,
        pipe_connections =
        {
            { direction = defines.direction.north, position = { 0, -0.5 }, flow_direction = "output" },
            { direction = defines.direction.south, position = { 0, 0.5 },  flow_direction = "input" }
        }
    },
    energy_source =
    {
        type = "electric",
        usage_priority = "secondary-input",
        drain = "1kW"
    },
    energy_usage = "100kW",
    pumping_speed = 30,
    impact_category = "metal",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,

    animations =
    {
        north =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-north.png",
            width = 103,
            height = 164,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            animation_speed = 0.5,
            shift = util.by_pixel(8, -0.85)
        },
        east =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-east.png",
            width = 130,
            height = 109,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            animation_speed = 0.5,
            shift = util.by_pixel(-0.5, 1.75)
        },

        south =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-south.png",
            width = 114,
            height = 160,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            animation_speed = 0.5,
            shift = util.by_pixel(12.5, -8)
        },
        west =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-west.png",
            width = 131,
            height = 111,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            animation_speed = 0.5,
            shift = util.by_pixel(-0.25, 1.25)
        }
    },

    fluid_wagon_connector_frame_count = 35,
    fluid_wagon_connector_alignment_tolerance = 2.0 / 32.0,

    fluid_wagon_connector_graphics = require("prototypes.fluid-handling.pump-connector"),

    fluid_animation =
    {
        north =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-north-liquid.png",
            apply_runtime_tint = true,
            width = 38,
            height = 22,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            shift = util.by_pixel(-0.250, -16.750)
        },

        east =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-east-liquid.png",
            width = 35,
            height = 46,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            shift = util.by_pixel(6.25, -8.5)
        },

        south =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-south-liquid.png",
            width = 38,
            height = 45,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            shift = util.by_pixel(0.5, -9.25)
        },
        west =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-west-liquid.png",
            width = 35,
            height = 47,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            shift = util.by_pixel(-6.5, -9.5)
        }
    },

    glass_pictures =
    {
        north =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-north-glass.png",
            width = 64,
            height = 128,
            scale = 0.5
        },
        east =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-east-glass.png",
            width = 128,
            height = 192,
            scale = 0.5
        },
        south =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-south-glass.png",
            width = 64,
            height = 128,
            scale = 0.5
        },
        west =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-west-glass.png",
            width = 192,
            height = 192,
            scale = 0.5,
            shift = util.by_pixel(-16, 0)
        }
    },
    circuit_connector = circuit_connector_definitions["pump"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
}
--[[
for _, pic in pairs(pump.fluid_box.pipe_covers or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end
--]]

local pump_r = {
    type = "recipe",
    name = "cubeine-pump",
    enabled = false,
    energy_required = 10,
    pollution_multiplier = 1,
    ingredients = {
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "cubeine-crystal",       amount = 2, },
        { type = "item", name = "electric-engine-unit",  amount = 1 },
        { type = "item", name = "pump",                  amount = 1 },
    },
    results = {
        { type = "item", name = "cubeine-pump", amount = 1 },

    },
    main_product = "cubeine-pump",
    allow_productivity = false,
    allow_quality = true,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    --order = "n[cubeine]-p[pump]"
}

data:extend({ pump, pump_i, pump_r })

local tech = data.raw["technology"]["cubeine-fluid-handling"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "cubeine-pump"
})



local pump_turbo_i = {
    type = "item",
    name = "cubeine-turbo-pump",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/pump.png",
            icon_size = 64
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-speed.png",
            icon_size = 64,
            tint = { 1, 0.1, 0.1, 0.8 }
        }
    },
    icon = "__lilys-cubeine__/graphics/icons/pump.png",
    subgroup = "energy-pipe-distribution",
    order = "b[pipe]-cd[cubeine-turbo-pump]",
    inventory_move_sound = item_sounds.fluid_inventory_move,
    pick_sound = item_sounds.fluid_inventory_pickup,
    drop_sound = item_sounds.fluid_inventory_move,
    place_result = "cubeine-turbo-pump",
    stack_size = 50,
    random_tint_color = item_tints.iron_rust
}
local pump_turbo = {
    type = "pump",
    name = "cubeine-turbo-pump",
    icon = "__lilys-cubeine__/graphics/icons/pump.png",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/pump.png",
            icon_size = 64
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-speed.png",
            icon_size = 64,
            tint = { 1, 0.1, 0.1, 0.8 }
        }
    },
    heating_energy = nil,
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "cubeine-turbo-pump" },
    max_health = 480,
    fast_replaceable_group = "pipe",
    corpse = "cubeine-pump-remnants",
    dying_explosion = "pump-explosion",
    collision_box = { { -0.29, -1.4 }, { 0.29, 1.4 } },
    selection_box = { { -0.5, -1.5 }, { 0.5, 1.5 } },
    icon_draw_specification = { scale = 0.5 },
    working_sound =
    {
        sound = {
            { filename = "__lilys-cubeine__/sounds/turbopump.wav", volume = 1, audibledistance_modifier = 1 },
            --{ filename = "__base__/sound/pump.ogg", volume = 0.5, audibledistance_modifier = 0.5 },
        },
        max_sounds_per_prototype = 10,
        fade_in_ticks = 60,
        fade_out_ticks = 60,
    },
    damaged_trigger_effect = hit_effects.entity(),
    resistances =
    {
        {
            type = "fire",
            percent = 100
        },
        {
            type = "impact",
            percent = 50
        }
    },
    fluid_box =
    {
        volume = 400,
        pipe_covers = pipe_covers,
        pipe_connections =
        {
            { direction = defines.direction.north, position = { 0, -1 }, flow_direction = "output" },
            { direction = defines.direction.south, position = { 0, 1 },  flow_direction = "input" }
        }
    },
    energy_source =
    {
        type = "fluid",
        burns_fluid = true,
        scale_fluid_usage = true,
        emissions_per_minute = { pollution = 10 },
        fluid_box = {
            volume = 100,
            draw_only_when_connected = true,
            pipe_connections = {
                { direction = defines.direction.west, position = { 0, 1 } },
                { direction = defines.direction.east, position = { 0, 1 } },
            },
            pipe_picture = pipe_picture,
            secondary_draw_orders = { north = -1, west = -1, east = -1 },
        }
    },
    energy_usage = "1000kW",
    pumping_speed = 150,
    impact_category = "metal",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,

    animations =
    {
        north =
        {
            layers = {
                {
                    filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-north.png",
                    width = 103,
                    height = 164,
                    scale = 0.5,
                    line_length = 8,
                    frame_count = 32,
                    animation_speed = 2,
                    shift = util.by_pixel(8, -0.85 - 16)
                },
                {
                    filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/speed/south.png",
                    width = 128,
                    height = 128,
                    scale = 0.5,
                    line_length = 1,
                    repeat_count = 32,
                    animation_speed = 2,
                    shift = util.by_pixel(0, 32)
                }
            }
        },
        east =
        {
            layers = {
                {
                    filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-east.png",
                    width = 130,
                    height = 109,
                    scale = 0.5,
                    line_length = 8,
                    frame_count = 32,
                    animation_speed = 2,
                    shift = util.by_pixel(-0.5 + 16, 1.75)
                },
                {
                    filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/speed/west.png",
                    width = 128,
                    height = 128,
                    scale = 0.5,
                    line_length = 1,
                    repeat_count = 32,
                    animation_speed = 2,
                    shift = util.by_pixel(-32, 0)
                }
            }
        },

        south =
        {
            layers = {
                {
                    filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/speed/north.png",
                    width = 128,
                    height = 128,
                    scale = 0.5,
                    line_length = 1,
                    repeat_count = 32,
                    animation_speed = 2,
                    shift = util.by_pixel(0, -32)
                },
                {
                    filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-south.png",
                    width = 114,
                    height = 160,
                    scale = 0.5,
                    line_length = 8,
                    frame_count = 32,
                    animation_speed = 2,
                    shift = util.by_pixel(12.5, -8 + 16)
                },
            }
        },
        west =
        {
            layers = {
                {
                    filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-west.png",
                    width = 131,
                    height = 111,
                    scale = 0.5,
                    line_length = 8,
                    frame_count = 32,
                    animation_speed = 2,
                    shift = util.by_pixel(-0.25 - 16, 1.25)
                },
                {
                    filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/speed/east.png",
                    width = 128,
                    height = 128,
                    scale = 0.5,
                    line_length = 1,
                    repeat_count = 32,
                    animation_speed = 2,
                    shift = util.by_pixel(32, 0)
                }
            }
        }
    },

    fluid_wagon_connector_frame_count = 35,
    fluid_wagon_connector_alignment_tolerance = 2.0 / 32.0,

    fluid_wagon_connector_graphics = require("prototypes.fluid-handling.pump-connector"),

    fluid_animation =
    {
        north =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-north-liquid.png",
            apply_runtime_tint = true,
            width = 38,
            height = 22,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            shift = util.by_pixel(-0.250, -16.750 - 16)
        },

        east =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-east-liquid.png",
            width = 35,
            height = 46,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            shift = util.by_pixel(6.25 + 16, -8.5)
        },

        south =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-south-liquid.png",
            width = 38,
            height = 45,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            shift = util.by_pixel(0.5, -9.25 + 16)
        },
        west =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-west-liquid.png",
            width = 35,
            height = 47,
            scale = 0.5,
            line_length = 8,
            frame_count = 32,
            shift = util.by_pixel(-6.5 - 16, -9.5)
        }
    },

    glass_pictures =
    {
        north =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-north-glass.png",
            width = 64,
            height = 128,
            scale = 0.5,
            shift = util.by_pixel(0, -16)
        },
        east =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-east-glass.png",
            width = 128,
            height = 192,
            scale = 0.5,
            shift = util.by_pixel(16, 0)
        },
        south =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-south-glass.png",
            width = 64,
            height = 128,
            scale = 0.5,
            shift = util.by_pixel(0, 16)
        },
        west =
        {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-west-glass.png",
            width = 192,
            height = 192,
            scale = 0.5,
            shift = util.by_pixel(-16 - 16, 0)
        }
    },

    circuit_connector = circuit_connector_definitions["pump"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
}
--[[
for _, pic in pairs(pump_turbo.fluid_box.pipe_covers or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end
--]]

local pump_turbo_r = {
    type = "recipe",
    name = "cubeine-turbo-pump",
    enabled = false,
    energy_required = 10,
    pollution_multiplier = 1,
    ingredients = {
        { type = "item",  name = "low-density-structure", amount = 5 },
        { type = "item",  name = "steel-plate",           amount = 20 },
        { type = "item",  name = "cubeine-crystal",       amount = 2, },
        { type = "item",  name = "engine-unit",           amount = 5 },
        { type = "item",  name = "cubeine-pump",          amount = 1 },
        { type = "fluid", name = "lubricant",             amount = 200 },
    },
    results = {
        { type = "item", name = "cubeine-turbo-pump", amount = 1 },

    },
    main_product = "cubeine-turbo-pump",
    category = "crafting-with-fluid",
    allow_productivity = false,
    allow_quality = true,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    --order = "n[cubeine]-p[pump]"
}

data:extend({ pump_turbo, pump_turbo_i, pump_turbo_r })


local pump_turbovac_i = table.deepcopy(data.raw.item["cubeine-turbo-pump"])
pump_turbovac_i.name = "cubeine-turbovac-pump"
pump_turbovac_i.place_result = "cubeine-turbovac-pump"
pump_turbovac_i.order = "b[pipe]-ce[cubeine-turbovac-pump]"
pump_turbovac_i.icons = {
    {
        icon = "__lilys-cubeine__/graphics/icons/pump.png",
        icon_size = 64
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/misc/signal-liquid.png",
        icon_size = 64,
        tint = { 0.8, 0.8, 0.8, 0.8 }
    }
}

local pump_turbovac = table.deepcopy(data.raw.pump["cubeine-turbo-pump"])
pump_turbovac.name = "cubeine-turbovac-pump"
pump_turbovac.minable.result = "cubeine-turbovac-pump"
pump_turbovac.icons = {
    {
        icon = "__lilys-cubeine__/graphics/icons/pump.png",
        icon_size = 64
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/misc/signal-liquid.png",
        icon_size = 64,
        tint = { 0.8, 0.8, 0.8, 0.8 }
    }
}
pump_turbovac.heating_energy = nil
pump_turbovac.pumping_speed = 30
pump_turbovac.flow_scaling = false
pump_turbovac.animations =
{
    north =
    {
        layers = {
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-north.png",
                width = 103,
                height = 164,
                scale = 0.5,
                line_length = 8,
                frame_count = 32,
                animation_speed = 3,
                shift = util.by_pixel(8, 3.5 - 16)
            },
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/vacuum/south.png",
                width = 128,
                height = 128,
                scale = 0.5,
                line_length = 1,
                repeat_count = 32,
                animation_speed = 3,
                shift = util.by_pixel(0, 32)
            }
        }
    },
    east =
    {
        layers = {
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-east.png",
                width = 130,
                height = 109,
                scale = 0.5,
                line_length = 8,
                frame_count = 32,
                animation_speed = 3,
                shift = util.by_pixel(-0.5 + 16, 1.75)
            },
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/vacuum/west.png",
                width = 128,
                height = 128,
                scale = 0.5,
                line_length = 1,
                repeat_count = 32,
                animation_speed = 3,
                shift = util.by_pixel(-32, 0)
            }
        }
    },

    south =
    {
        layers = {
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/vacuum/north.png",
                width = 128,
                height = 128,
                scale = 0.5,
                line_length = 1,
                repeat_count = 32,
                animation_speed = 3,
                shift = util.by_pixel(0, -32)
            },
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-south.png",
                width = 114,
                height = 160,
                scale = 0.5,
                line_length = 8,
                frame_count = 32,
                animation_speed = 3,
                shift = util.by_pixel(12.5, -8 + 16)
            },
        }
    },
    west =
    {
        layers = {
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/pump-west.png",
                width = 131,
                height = 111,
                scale = 0.5,
                line_length = 8,
                frame_count = 32,
                animation_speed = 3,
                shift = util.by_pixel(-0.25 - 16, 1.25)
            },
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/pump/vacuum/east.png",
                width = 128,
                height = 128,
                scale = 0.5,
                line_length = 1,
                repeat_count = 32,
                animation_speed = 3,
                shift = util.by_pixel(32, 0)
            }
        }
    }
}


local pump_turbovac_r = {
    type = "recipe",
    name = "cubeine-turbovac-pump",
    enabled = false,
    energy_required = 10,
    pollution_multiplier = 1,
    ingredients = {
        { type = "item",  name = "low-density-structure", amount = 5 },
        { type = "item",  name = "steel-plate",           amount = 20 },
        { type = "item",  name = "cubeine-crystal",       amount = 2, },
        { type = "item",  name = "engine-unit",           amount = 5 },
        { type = "item",  name = "cubeine-pump",          amount = 1 },
        { type = "fluid", name = "lubricant",             amount = 200 },
    },
    results = {
        { type = "item", name = "cubeine-turbovac-pump", amount = 1 },

    },
    category = "crafting-with-fluid",
    main_product = "cubeine-turbovac-pump",
    allow_productivity = false,
    allow_quality = true,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    --order = "n[cubeine]-p[pump]"
}

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ pump_turbovac, pump_turbovac_i, pump_turbovac_r })


-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-turbopumps",
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/pump.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/misc/signal-speed.png",
                icon_size = 64,
                tint = { 1, 0.1, 0.1, 0.8 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            }
        },
        icon_size = 64,
        prerequisites = { "cubeine-fluid-handling" },

        unit = {
            count = 500,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },

                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 },
                { "space-science-pack",      1 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-turbo-pump",
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-turbovac-pump",
            }
        }
    }
})
