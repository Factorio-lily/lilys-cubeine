local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
require("__base__.prototypes.entity.pipecovers")

local default_collision_masks = data.raw["utility-constants"]["default"].default_collision_masks
local base_tint = { r = 1, g = 0.8, b = 0.8, a = 1 }
local emissive_tint = { r = 1, g = 0.2, b = 0.2, a = 1 }


local function animationLayer()
    return {
        priority = "high",
        width = 704,
        height = 704,
        frame_count = 120,
        lines_per_file = 8,
        animation_speed = 0.5,
        --shift = util.by_pixel(0, -8),
        scale = 0.5,
        stripes = {
            {
                filename = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-animation-1.png",
                width_in_frames = 8,
                height_in_frames = 8
            },
            {
                filename = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-animation-2.png",
                width_in_frames = 8,
                height_in_frames = 7
            }
        }
    }
end

local pipepictures = {
    north =
    {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-up.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        shift = { 0, 0.75 },
        --shift = util.by_pixel(2.25, 13.5),
        scale = 0.5
    },
    east =
    {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-right.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        shift = { -0.75, 0 },
        --shift = util.by_pixel(-24.5, 1),
        scale = 0.5
    },
    south =
    {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-down.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        shift = { 0, -0.75 },
        --shift = util.by_pixel(0, -31.25),
        scale = 0.5
    },
    west =
    {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-left.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        shift = { 0.75, 0 },
        --shift = util.by_pixel(25.75, 1.25),
        scale = 0.5
    }
}

local drill_item = {
    type = "item",
    name = "cubeine-giga-thermal-drill",
    icon = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-icon.png",
    icons = {
        {
            icon = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-icon.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        },
    },
    place_result = "cubeine-giga-thermal-drill",
    subgroup = "extraction-machine",
    order = "a[items]-h[cubeine-giga-thermal-drill]",
    inventory_move_sound = item_sounds.drill_inventory_move,
    pick_sound = item_sounds.drill_inventory_pickup,
    drop_sound = item_sounds.drill_inventory_move,
    stack_size = 1,
    default_import_location = "vulcanus",
    weight = 1000 * kg
}





local drill = {
    type = "mining-drill",
    name = "cubeine-giga-thermal-drill",
    icon = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-icon.png",
    icons = {
        {
            icon = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-icon.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        },
    },
    resistances =
    {
        {
            type = "fire",
            percent = 100
        },
        {
            type = "physical",
            percent = 60
        },
        {
            type = "poison",
            percent = 100
        },
        {
            type = "explosion",
            percent = 60
        }
    },

    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 1, result = "cubeine-giga-thermal-drill" },
    resource_categories = { "basic-fluid", "basic-solid", "hard-solid" },
    max_health = 15000,
    corpse = "big-remnants",
    dying_explosion = "big-explosion",
    collision_box = { { -4.2, -4.2 }, { 4.2, 4.2 } },
    selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box_vertical_extension = 10,
    vector_to_place_result = { 0, -6, x = 0, y = -6 },
    resource_searching_radius = 32,
    energy_source =
    {
        type = "heat",
        max_temperature = 2000,
        specific_heat = "5MJ",
        max_transfer = "5GJ",
        min_working_temperature = 990,
        minimum_glow_temperature = 900,

        connections =
        {
            {
                position = { -4.0, -4.0 },
                direction = defines.direction.north
            },
            {
                position = { -2.0, -4.0 },
                direction = defines.direction.north
            },
            {
                position = { 0, -4.0 },
                direction = defines.direction.north
            },
            {
                position = { 2.0, -4.0 },
                direction = defines.direction.north
            },
            {
                position = { 4.0, -4.0 },
                direction = defines.direction.north
            },
            {
                position = { 4, -4 },
                direction = defines.direction.east
            },
            {
                position = { 4, -2 },
                direction = defines.direction.east
            },
            {
                position = { 4, 0 },
                direction = defines.direction.east
            },
            {
                position = { 4, 2 },
                direction = defines.direction.east
            },
            {
                position = { 4, 4 },
                direction = defines.direction.east
            },
            {
                position = { -4, 4 },
                direction = defines.direction.south
            },
            {
                position = { -2, 4 },
                direction = defines.direction.south
            },
            {
                position = { 0, 4 },
                direction = defines.direction.south
            },
            {
                position = { 2, 4 },
                direction = defines.direction.south
            },
            {
                position = { 4, 4 },
                direction = defines.direction.south
            },
            {
                position = { -4, -4 },
                direction = defines.direction.west
            },
            {
                position = { -4, -2 },
                direction = defines.direction.west
            },
            {
                position = { -4, 0 },
                direction = defines.direction.west
            },
            {
                position = { -4, 2 },
                direction = defines.direction.west
            },
            {
                position = { -4, 4 },
                direction = defines.direction.west
            }

        },

        heat_picture =
        {
            filename = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-animation-heat-1.png",
            width = 704,
            height = 704,
            scale = 0.5,
            tint = { 0.25, 0.025, 0.01, 0.25 },
            draw_as_glow = true,
            blend_mode = "additive"
        },
        heat_glow = {
            filename = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-animation-heat-1.png",
            width = 704,
            height = 704,
            scale = 0.5,
            tint = { 0.25, 0.025, 0.01, 0.25 },
            draw_as_glow = true,
            blend_mode = "additive"
        },

    },
    output_fluid_box =
    {
        volume = 10000,
        pipe_picture = pipepictures,
        secondary_draw_orders = { north = -1, east = -1, west = -1 },
        --pipe_covers = pipecoverspictures(),
        pipe_connections =
        {
            {
                direction = defines.direction.south,
                position = { -1, 4 },
                flow_direction = "output"
            },
            {
                direction = defines.direction.south,
                position = { -3, 4 },
                flow_direction = "output"
            },
            {
                direction = defines.direction.south,
                position = { 1, 4 },
                flow_direction = "output"
            },
            {
                direction = defines.direction.south,
                position = { 3, 4 },
                flow_direction = "output"
            },
        }
    },
    resource_drain_rate_percent = 50,
    drops_full_belt_stacks = true,
    input_fluid_box =
    {
        pipe_picture = pipepictures,
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        secondary_draw_orders = { north = -1, east = -1, west = -1 },
        pipe_connections =
        {
            { direction = defines.direction.west, position = { -4, -3 } },
            { direction = defines.direction.east, position = { 4, -3 } },
            { direction = defines.direction.west, position = { -4, 3 } },
            { direction = defines.direction.east, position = { 4, 3 } },
        }

    },
    energy_usage = "500MW",
    mining_speed = 40,
    module_slots = 8,
    heating_energy = "5MW",
    monitor_visualization_tint = { 78, 173, 255 },
    base_render_layer = "lower-object-above-shadow",
    base_picture =
    {
        layers = {
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
                width = 320,
                height = 316,
                scale = 0.5,
                shift = { 2, 2 },
                tint = { 1, 0.6, 0.6, 1 }
            },
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
                width = 320,
                height = 316,
                scale = 0.5,
                shift = { -2, 2 },
                tint = { 1, 0.6, 0.6, 1 }
            },
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
                width = 320,
                height = 316,
                scale = 0.5,
                shift = { 2.1, -2.2 },
                tint = { 1, 0.6, 0.6, 1 }
            },
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
                width = 320,
                height = 316,
                scale = 0.5,
                shift = { -2.1, -2.2 },
                tint = { 1, 0.6, 0.6, 1 }
            },
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
                width = 320,
                height = 316,
                scale = 0.5,
                shift = { 0, -2.2 },
                tint = { 1, 0.6, 0.6, 1 }
            },
        }
    },
    graphics_set =
    {
        frozen_patch = {
            filename = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-frozen-1.png",
            width = 704,
            height = 704,
            scale = 0.5,
        },
        animation =
        {
            layers = {
                {
                    filename = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-shadow.png",
                    priority = "high",
                    width = 1400,
                    height = 1400,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 120,
                    animation_speed = 1,
                    --shift = util.by_pixel(0, -8),
                    draw_as_shadow = true,
                    scale = 0.5
                },
                animationLayer()
            },
        },
        working_visualisations = {
            {
                name = "drill-animation",
                fadeout = true,
                animation = {
                    layers = {
                        animationLayer(),
                        {
                            priority = "high",
                            draw_as_glow = true,
                            blend_mode = "additive",
                            width = 704,
                            height = 704,
                            frame_count = 120,
                            lines_per_file = 8,
                            animation_speed = 0.5,
                            --shift = util.by_pixel(0, -8),
                            scale = 0.5,
                            stripes = {
                                {
                                    filename =
                                    "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-emission-1.png",
                                    width_in_frames = 8,
                                    height_in_frames = 8
                                },
                                {
                                    filename =
                                    "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-emission-2.png",
                                    width_in_frames = 8,
                                    height_in_frames = 7
                                }
                            }
                        }
                    }
                }
            },
            {
                name = "light",
                --fadeout = true,
                light = { color = { 1, 0.5, 0.5, 1 }, size = 20, intensity = 0.6 }
            },
            {
                name = "drill-animation-2",
                animation = {
                    layers = {
                        {
                            filenames = {
                                "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-emission-1.png",
                                "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-hr-emission-2.png",
                            },
                            priority = "high",
                            draw_as_glow = true,
                            blend_mode = "additive",
                            width = 704,
                            height = 704,
                            frame_count = 120,
                            lines_per_file = 8,
                            line_length = 8,
                            animation_speed = 0.5,
                            --shift = util.by_pixel(0, -8),
                            scale = 0.5,
                        }
                    }
                }
            }
        }
    },
    working_sound =
    {
        main_sounds =
        {
            sound = { filename = "__space-age__/sound/entity/big-mining-drill/big-mining-drill-working-loop.ogg", volume = 1.3 },
            fade_in_ticks = 4,
            fade_out_ticks = 30
        },
        sound_accents =
        {
            {
                sound = { filename = "__space-age__/sound/entity/big-mining-drill/big-mining-drill-start.ogg", volume = 1.75, audible_distance_modifier = 0.3 },
                play_for_working_visualisation = "drill-animation",
                frame = 8,
            }
        },
        max_sounds_per_prototype = 1
    },
    drilling_sound =
    {
        sound =
        {
            filename = "__space-age__/sound/entity/big-mining-drill/big-mining-drill-loop.ogg",
            volume = 2.7,
            aggregation = { max_count = 20, remove = true, count_already_playing = true }
        },
        fade_ticks = 100
    },
    moving_sound =
    {
        sound =
        {
            filename = "__space-age__/sound/entity/big-mining-drill/big-mining-drill-moving-loop.ogg",
            volume = 1.0,
            aggregation = { max_count = 2, remove = true, count_already_playing = true },
            audible_distance_modifier = 0.5
        },
        stopped_sound = { filename = "__space-age__/sound/entity/big-mining-drill/big-mining-drill-moving-stop.ogg", volume = 1.4 },
        minimal_sound_duration_for_stopped_sound = 33, -- at least third of the movement duration (which is drilling_frames / animation_speed)
        fade_ticks = 2
    },
    drilling_sound_animation_start_frame = 20,
    drilling_sound_animation_end_frame = 80,
    open_sound = sounds.drill_open,
    close_sound = sounds.drill_close,


    fast_replaceable_group = "giga-mining-drill",
    radius_visualisation_picture =
    {
        filename = "__space-age__/graphics/entity/big-mining-drill/big-mining-drill-radius-visualization.png",
        width = 10,
        height = 10
    },

    filter_count = 5,
    circuit_connector = table.deepcopy(circuit_connector_definitions["big-mining-drill"]),
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    collision_mask = default_collision_masks["mining-drill"],
}
drill.wet_graphics_set = drill.graphics_set
if drill.tile_buildability_rules and drill.tile_buildability_rules[1] then
    --drill.tile_buildability_rules[1].required_tiles = {layers = {}}
    drill.tile_buildability_rules = nil
else
    --drill.tile_buildability_rules = { { area = table.deepcopy(drill.collision_box), required_tiles = { layers = {} } } }
    drill.tile_buildability_rules = nil
end

drill.collision_mask.layers["water_tile"] = nil
drill.collision_mask.layers["lava_tile"] = nil
drill.collision_mask.layers["meltable"] = nil
drill.collision_mask.layers["is_object"] = nil
drill.collision_mask.layers["is_lower_object"] = nil

data:extend({ drill_item, drill })
drill.tile_buildability_rules = nil
drill.collision_mask = { layers = { object = true } }

data:extend({
    {
        type = "recipe",
        name = "cubeine-giga-thermal-drill",
        category = "metallurgy",
        energy_required = 60,
        enabled = false,
        ingredients =
        {
            { type = "item",  name = "big-mining-drill",      amount = 20 },
            { type = "item",  name = "cubeine-crystal",       amount = 200 },
            { type = "item",  name = "low-density-structure", amount = 200 },
            { type = "fluid", name = "cubeine-solution",      amount = 5000 },
            { type = "item",  name = "tungsten-plate",        amount = 500 },
            { type = "item",  name = "tungsten-carbide",      amount = 500 },
            { type = "item",  name = "carbon-fiber",          amount = 100 },
            { type = "fluid", name = "lubricant",             amount = 10000 },
        },
        results = { { type = "item", name = "cubeine-giga-thermal-drill", amount = 1 } },
        requester_paste_multiplier = 1,
        crafting_machine_tint =
        {
            primary = { r = 0.298, g = 0.442, b = 0.518, a = 1.000 },    -- #4c7084ff
            secondary = { r = 1, g = 0.306, b = 0.402, a = 1.000 },      -- #dc8444ff
            tertiary = { r = 0.159, g = 0.136, b = 0.207, a = 1.000 },   -- #282234ff
            quaternary = { r = 0.945, g = 0.170, b = 0.200, a = 1.000 }, -- #f12e44ff
        },
        allow_productivity = false,
    },
    {
        type = "technology",
        name = "cubeine-giga-thermal-drill",
        icons = {
            {
                icon = "__lilys-cubeine-asset-pack-2__/graphics/entity/drill/core-extractor-icon-big.png",
                icon_size = 640,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            }
        },
        prerequisites = { "nukubeine-reactor" },

        unit = {
            count = 10000,
            ingredients =
            {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "utility-science-pack",         1 },
                { "metallurgic-science-pack",     4 },
                { "agricultural-science-pack",    1 },
                { "electromagnetic-science-pack", 1 },
                { "cryogenic-science-pack",       1 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-giga-thermal-drill"
            },
        }
    }
})
