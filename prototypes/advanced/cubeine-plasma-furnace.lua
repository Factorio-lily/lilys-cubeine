local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")



local base_tint = { r = 1, g = 0.8, b = 0.8, a = 1 }
local emissive_tint = { r = 1, g = 0.1, b = 0.2, a = 1 }




data:extend({
    {
        type = "item",
        name = "cubeine-plasma-furnace",
        icons = {
            {
                icon = "__lilys-cubeine-asset-pack__/graphics/entity/furnace/arc-furnace-icon.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.25,
                shift = { 6, 6 }
            }
        },
        subgroup = "smelting-machine",
        order = "l[cubeine-plasma-furnace]",
        inventory_move_sound = item_sounds.electric_large_inventory_move,
        pick_sound = item_sounds.electric_large_inventory_pickup,
        drop_sound = item_sounds.electric_large_inventory_move,
        place_result = "cubeine-plasma-furnace",
        stack_size = 5,
        weight = 1000*kg
    },
    {
        type = "furnace",
        name = "cubeine-plasma-furnace",
        icons = {
            {
                icon = "__lilys-cubeine-asset-pack__/graphics/entity/furnace/arc-furnace-icon.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.25,
                shift = { 6, 6 }
            }
        },
        
        flags = { "placeable-neutral", "placeable-player", "player-creation", "not-rotatable" },
        minable = { mining_time = 0.2, result = "cubeine-plasma-furnace" },
        max_health = 2000,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        collision_box = { { -2.1, -2.1 }, { 2.1, 2.1 } },
        selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
        crafting_categories = data.raw["furnace"]["electric-furnace"].crafting_categories,


        fast_replaceable_group = "furnace",
        ---@diagnostic disable-next-line: undefined-global
        circuit_wire_max_distance = furnace_circuit_wire_max_distance,
        ---@diagnostic disable-next-line: undefined-global
        circuit_connector = circuit_connector_definitions["electric-furnace"],
        resistances =
        {
            {
                type = "fire",
                percent = 99
            }
        },
        damaged_trigger_effect = hit_effects.entity(),
        module_slots = 8,
        icon_draw_specification = { shift = { 0, -0.1 } },
        allowed_effects = { "consumption", "speed", "productivity", "pollution", "quality" },
        result_inventory_size = 3,
        burns_fluid = false,
        crafting_speed = 20,
        energy_usage = "100MW",
        source_inventory_size = 1,
        energy_source =
        {
            type = "fluid",
            burns_fluid = false,
            effectivity = 1,
            fluid_usage_per_tick = 10,
            scale_fluid_usage = true,
            fluid_box = {
                volume = 1000,
                filter = "cubeine-fusion-plasma",
                draw_only_when_connected = true,
                --minimum_temperature = 1100000,
                ---@diagnostic disable-next-line: undefined-global
                --pipe_covers = pipecoverspictures(),
                pipe_picture = {
                    north = {
                        layers = {
                            {--do not use
                                filename = "__lilys-cubeine-asset-pack__/graphics/entity/plasma-pipes/cubeine-fusion-pipe-cover-west.png",
                                width = 64,
                                height = 64,
                                scale = 0.5,
                                --shift = util.by_pixel(18, 0)
                            }
                        }
                    },
                    west = {
                        layers = {
                            {
                                filename = "__lilys-cubeine-asset-pack__/graphics/entity/plasma-pipes/cubeine-fusion-pipe-cover-west.png",
                                width = 64,
                                height = 64,
                                scale = 0.5,
                                shift = {0.95, 0}
                                --shift = util.by_pixel(18, 0)
                            }
                        }
                    },
                    east = {
                        layers = {
                            {
                                filename = "__lilys-cubeine-asset-pack__/graphics/entity/plasma-pipes/cubeine-fusion-pipe-cover-east.png",
                                width = 64,
                                height = 64,
                                scale = 0.5,
                                shift = { -0.95, 0 }
                                --shift = util.by_pixel(-18, 0)
                            }
                        }
                    },
                    south = {--do not use
                        layers = {
                            {
                                filename = "__lilys-cubeine-asset-pack__/graphics/entity/plasma-pipes/cubeine-fusion-pipe-cover-east.png",
                                width = 17,
                                height = 63,
                                scale = 0.5,
                                --shift = util.by_pixel(-18, 0)
                            }
                        }
                    },
                },
                render_layer = "object-under",
                pipe_connections =
                {
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    { flow_direction = "input-output", direction = defines.direction.west, position = { -2.0, 1 }, connection_category = { "fusion-plasma" }, enable_working_visualisations= {"1"} },
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    { flow_direction = "input-output", direction = defines.direction.east, position = { 2.0, 1 },   connection_category = { "fusion-plasma" }, enable_working_visualisations = {"2"} },
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    { flow_direction = "input-output", direction = defines.direction.west, position = { -2.0, -1 }, connection_category = { "fusion-plasma" }, enable_working_visualisations = {"3"} },
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    { flow_direction = "input-output", direction = defines.direction.east, position = { 2.0, -1 },  connection_category = { "fusion-plasma" }, enable_working_visualisations = {"4"} },
                },
                
                production_type = "input",
                --destroy_non_fuel_fluid = true

            },

            emissions_per_minute = { pollution = 50 }
        },
        impact_category = "metal",
        open_sound = sounds.metal_large_open,
        close_sound = sounds.metal_large_close,
        heating_energy = "300kW",
        effect_receiver = {
            base_effect = {
                productivity = 1.0
            }
        },
        working_sound =
        {
            main_sounds = {
                {
                    sound = {
                        filename = "__space-age__/sound/entity/fusion/fusion-generator.ogg"
                    }
                },
                {
                    sound = {
                        filename = "__base__/sound/accumulator-discharging.ogg"
                    }
                }
            },
            sound =
            {
                filename = "__space-age__/sound/entity/fusion/fusion-generator.ogg",
                volume = 10,
                --speed_smoothing_window_size = 60,
                --advanced_volume_control = { attenuation = "exponential" },
                audible_distance_modifier = 1.8,
            },
            use_doppler_shift = false,
            match_speed_to_activity = true,
            activity_to_speed_modifiers = { multiplier = 1.5 },
            match_volume_to_activity = true,
            max_sounds_per_prototype = 10,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        },
        graphics_set =
        {
            animation =
            {
                layers =
                {
                    {
                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/furnace/arc-furnace-hr-animation-1.png",
                        priority = "high",
                        width = 320,
                        height = 320,
                        frame_count = 50,
                        line_length = 8,
                        animation_speed = 1,
                        --shift = util.by_pixel(0.75, 5.75),
                        scale = 0.5,
                    },
                    {
                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/furnace/arc-furnace-hr-shadow.png",
                        priority = "high",
                        width = 600,
                        height = 400,
                        draw_as_shadow = true,
                        frame_count = 1,
                        line_length = 1,
                        lines_per_file = 1,
                        repeat_count = 50,
                        --shift = util.by_pixel(11.25, 7.75),
                        scale = 0.5
                    }
                }
            },
            working_visualisations =
            {
                {
                    fadeout = true,
                    animation =
                    {
                        layers =
                        {
                            {
                                filename =
                                "__lilys-cubeine-asset-pack__/graphics/entity/furnace/arc-furnace-hr-emission-1.png",
                                priority = "high",
                                width = 320,
                                height = 320,
                                frame_count = 50,
                                line_length = 8,
                                animation_speed = 1,
                                draw_as_glow = true,
                                blend_mode="additive",
                                --shift = util.by_pixel(1.75, 32.75),
                                scale = 0.5,
                            },
                            {
                                filename =
                                "__lilys-cubeine-asset-pack__/graphics/entity/furnace/arc-furnace-hr-emission-1.png",
                                priority = "high",
                                width = 320,
                                height = 320,
                                frame_count = 50,
                                line_length = 8,
                                animation_speed = 1,
                                draw_as_glow = true,
                                blend_mode = "additive",
                                --shift = util.by_pixel(1.75, 32.75),
                                scale = 0.5,
                            },
                        }
                    },
                },
                {
                    animation = {
                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/plasma-pipes/cubeine-fusion-pipe-cover-west-glow.png",
                        width = 64,
                        height = 64,
                        scale = 0.5,
                        shift = { -2.05, 1 },
                        blend_mode = "additive",
                        draw_as_glow = true,
                    },
                    enabled_by_name = true,
                    name = "1"
                },
                {
                    animation = {
                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/plasma-pipes/cubeine-fusion-pipe-cover-west-glow.png",
                        width = 64,
                        height = 64,
                        scale = 0.5,
                        shift = {2.05, 1},
                        blend_mode = "additive",
                        draw_as_glow = true,
                    },
                    enabled_by_name = true,
                    name = "2"
                },
                {
                    animation = {
                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/plasma-pipes/cubeine-fusion-pipe-cover-east.png",
                        width = 64,
                        height = 64,
                        scale = 0.5,
                        shift = {-2.05, -1},
                        blend_mode = "additive",
                        draw_as_glow = true,
                    },
                    enabled_by_name = true,
                    name = "3"
                },
                {
                    animation = {
                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/plasma-pipes/cubeine-fusion-pipe-cover-east.png",
                        width = 64,
                        height = 64,
                        scale = 0.5,
                        shift = { -2.05, 1 },
                        blend_mode = "additive",
                        draw_as_glow = true,
                    },
                    enabled_by_name = true,

                    name = "4"
                }
            },
            water_reflection =
            {
                pictures =
                {
                    filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
                    priority = "extra-high",
                    width = 24,
                    height = 24,
                    shift = util.by_pixel(5, 40),
                    variation_count = 1,
                    scale = 5
                },
                rotate = false,
                orientation_to_variation = false
            }
        }
    },
    {
        type = "recipe",
        name = "cubeine-plasma-furnace",
        category = "metallurgy",
        energy_required = 60,
        enabled = false,
        ingredients =
        {
            { type = "item",  name = "electric-furnace",        amount = 10 },
            { type = "item",  name = "cubeine-crystal",       amount = 50 },
            { type = "item",  name = "tungsten-carbide", amount = 200 },
            { type = "item",  name = "tungsten-plate",     amount = 200 },
            { type = "fluid", name = "cubeine-solution",      amount = 1000 },
            { type = "fluid", name = "pure-cubeplant-fluid",  amount = 50 },
        },
        results = { { type = "item", name = "cubeine-plasma-furnace", amount = 1 } },
        requester_paste_multiplier = 1,
        crafting_machine_tint =
        {
            primary = { r = 0.298, g = 0.442, b = 0.518, a = 1.000 },    -- #4c7084ff
            secondary = { r = 1, g = 0.306, b = 0.402, a = 1.000 },      -- #dc8444ff
            tertiary = { r = 0.159, g = 0.136, b = 0.207, a = 1.000 },   -- #282234ff
            quaternary = { r = 0.945, g = 0.170, b = 0.200, a = 1.000 }, -- #f12e44ff
        }
    },
    {
        type = "technology",
        name = "cubeine-plasma-furnace",
        icons = {
            {
                icon = "__lilys-cubeine-asset-pack__/graphics/entity/furnace/arc-furnace-icon-big.png",
                icon_size = 640,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            }
        },
        prerequisites = { "cubeine-fusion-reactor" },

        unit = {
            count = 5000,
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
                recipe = "cubeine-plasma-furnace"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-plasma-furnace-cold"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-plasma-furnace-cold-not"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-fusion-generator-cold"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-fusion-generator-cold-not"
            },
        }
    }
})

local furnace_cold_item = table.deepcopy(data.raw["item"]["cubeine-plasma-furnace"])
furnace_cold_item.name = furnace_cold_item.name .. "-cold"
furnace_cold_item.place_result = furnace_cold_item.place_result .. "-cold"
furnace_cold_item.order = "m[cubeine-plasma-furnace-cold]"
furnace_cold_item.hidden = true

local furnace_cold = table.deepcopy(data.raw["furnace"]["cubeine-plasma-furnace"])
furnace_cold.name = furnace_cold.name .. "-cold"
furnace_cold.order = "m[cubeine-plasma-furnace-cold]"
furnace_cold.minable.result = furnace_cold.minable.result .. "-cold"
furnace_cold.energy_source.burns_fluid = true
furnace_cold.hidden = true

table.insert(furnace_cold_item.icons,
    {
        icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-blue.png",
        icon_size = 64,
        tint = { 0.65, 0.65, 0.65, 0.65 }
    })


data:extend({
---@diagnostic disable-next-line: assign-type-mismatch
    furnace_cold, furnace_cold_item,
    {
        type = "recipe",
        name = "cubeine-plasma-furnace-cold",
        hidden = true,
        icons = {
            {
                icon = "__lilys-cubeine-asset-pack__/graphics/entity/furnace/arc-furnace-icon.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.25,
                shift = { 6, 6 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-blue.png",
                icon_size = 64,
                tint = { 0.65, 0.65, 0.65, 0.65 }
            },
        },
        energy_required = 1,
        enabled = false,
        ingredients =
        {
            { type = "item", name = "cubeine-plasma-furnace", amount = 1 },
        },
        results = { { type = "item", name = "cubeine-plasma-furnace-cold", amount = 1 } },
        allow_productivity = false,
        allow_quality = false,
    },
    {
        type = "recipe",
        name = "cubeine-plasma-furnace-cold-not",
        hidden = true,
        icons = {
            {
                icon = "__lilys-cubeine-asset-pack__/graphics/entity/furnace/arc-furnace-icon.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.25,
                shift = { 6, 6 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-blue.png",
                icon_size = 64,
                tint = { 0.65, 0.65, 0.65, 0.65 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/misc/signal-deny.png",
                icon_size = 64,
                tint = { 0.65, 0.65, 0.65, 0.65 }
            }
        },
        energy_required = 1,
        enabled = false,
        ingredients =
        {
            { type = "item", name = "cubeine-plasma-furnace-cold", amount = 1 },
        },
        results = { { type = "item", name = "cubeine-plasma-furnace", amount = 1 } },
        allow_productivity = false,
        allow_quality = false,
    },
})