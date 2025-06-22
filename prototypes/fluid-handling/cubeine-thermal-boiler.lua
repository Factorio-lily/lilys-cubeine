require("util")
require("__base__/prototypes/entity/pipecovers")
require("circuit-connector-sprites")
require("__base__/prototypes/entity/assemblerpipes")
local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")
local movement_triggers = require("__base__/prototypes/entity/movement-triggers")
local cargo_pod_procession_catalogue = require("__base__/prototypes/entity/cargo-pod-catalogue")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")

function make_4way_animation_from_spritesheet(animation)
    local function make_animation_layer(idx, anim)
        local frame_count = anim.frame_count or 1
        local start_frame = frame_count * idx
        local x = 0
        local y = 0
        if anim.line_length then
            y = anim.height * math.floor(start_frame / (anim.line_length or 1))
            if anim.line_length > frame_count then
                error("single line must not contain animations for multiple directions when line_lenght is specified: " ..
                anim.filename)
            end
        else
            x = idx * anim.width
        end
        return
        {
            filename = anim.filename,
            priority = anim.priority or "high",
            flags = anim.flags,
            x = x,
            y = y,
            width = anim.width,
            height = anim.height,
            frame_count = anim.frame_count,
            line_length = anim.line_length,
            repeat_count = anim.repeat_count,
            shift = anim.shift,
            draw_as_shadow = anim.draw_as_shadow,
            draw_as_glow = anim.draw_as_glow,
            draw_as_light = anim.draw_as_light,
            apply_runtime_tint = anim.apply_runtime_tint,
            tint_as_overlay = anim.tint_as_overlay or false,
            animation_speed = anim.animation_speed,
            scale = anim.scale or 1,
            tint = anim.tint,
            blend_mode = anim.blend_mode,
            load_in_minimal_mode = anim.load_in_minimal_mode,
            premul_alpha = anim.premul_alpha,
            generate_sdf = anim.generate_sdf
        }
    end

    local function make_animation(idx)
        if animation.layers then
            local tab = { layers = {} }
            for k, v in ipairs(animation.layers) do
                table.insert(tab.layers, make_animation_layer(idx, v))
            end
            return tab
        else
            return make_animation_layer(idx, animation)
        end
    end

    return
    {
        north = make_animation(0),
        east = make_animation(1),
        south = make_animation(2),
        west = make_animation(3)
    }
end


data:extend {
    {
        name = "cubeine-thermal-boiler",
        type = "item",
        place_result = "cubeine-thermal-boiler",
        icons = {
            {
                icon = "__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-icon.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.25,
                shift = { 6, 6 }
            }

        },
        subgroup = "energy",
        order = "t[thermal-energy]-b[reactor-fluid]",
        inventory_move_sound = item_sounds.reactor_inventory_move,
        pick_sound = item_sounds.reactor_inventory_pickup,
        drop_sound = item_sounds.reactor_inventory_move,
        stack_size = 5,
        default_import_location = "nauvis",
        weight = 200 * kg,
    },
    {
        name = "cubeine-thermal-boiler",
        type = "assembling-machine",
        icon = "__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-icon.png",
        icon_size = 64,
        flags = { "placeable-neutral", "placeable-player", "player-creation" },
        minable = {
            mining_time = 0.5,
            results = { { type = "item", name = "cubeine-thermal-boiler", amount = 1 } }
        },
        max_health = 1000,
        corpse = "medium-remnants",
        dying_explosion = "medium-explosion",
        ---@diagnostic disable-next-line: undefined-global
        circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
        circuit_connector = circuit_connector_definitions["chemical-plant"],
        collision_box = { { -1.6, -1.6 }, { 1.6, 1.6 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        resistances =
        {
            {
                type = "fire",
                percent = 90
            },
            {
                type = "explosion",
                percent = 30
            },
            {
                type = "impact",
                percent = 30
            }
        },
        --map_color = ei_data.colors.assembler,
        crafting_categories = { "cubeine-boiling" },
        fluid_boxes = {
            {
                production_type = "input",
                pipe_picture = require("__space-age__.prototypes.entity.electromagnetic-plant-pictures").pipe_pictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                ---@diagnostic disable-next-line: assign-type-mismatch
                pipe_connections = { { direction = defines.direction.south, flow_direction = "input-output", position = { -0.5, 1.5 } } },
                secondary_draw_orders = { north = -1 },
            },
            {
                production_type = "input",
                pipe_picture = require("__space-age__.prototypes.entity.electromagnetic-plant-pictures").pipe_pictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                ---@diagnostic disable-next-line: assign-type-mismatch
                pipe_connections = { { direction = defines.direction.east, flow_direction = "input-output", position = { 1.5, -0.5 } } },
                secondary_draw_orders = { north = -1 },
            },
            {
                production_type = "output",
                pipe_picture = require("__space-age__.prototypes.entity.electromagnetic-plant-pictures").pipe_pictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                ---@diagnostic disable-next-line: assign-type-mismatch
                pipe_connections = { { direction = defines.direction.north, flow_direction = "input-output", position = { 0.5, -1.5 } } },
                secondary_draw_orders = { north = -1 },
            },
            {
                production_type = "output",
                pipe_picture = require("__space-age__.prototypes.entity.electromagnetic-plant-pictures").pipe_pictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                ---@diagnostic disable-next-line: assign-type-mismatch
                pipe_connections = { { direction = defines.direction.west, flow_direction = "input-output", position = { -1.5, 0.5 } } },
                secondary_draw_orders = { north = -1 },
            },
        },
        crafting_speed = 1,
        --[[energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = { pollution = 4 },
            drain = "50kW",
        },--]]
        energy_source =
        {
            type = "heat",
            max_temperature = 2000,
            specific_heat = "5MJ",
            max_transfer = "20GW",
            min_working_temperature = 1000,
            minimum_glow_temperature = 350,
            connections =
            {
                {
                    position = { 0.5, 1.5 },
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    direction = defines.direction.south
                },
                {
                    position = { -1.5, -0.5 },
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    direction = defines.direction.west
                },
                {
                    position = { -0.5, -1.5 },
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    direction = defines.direction.north
                },
                {
                    position = { 1.5, 0.5 },
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    direction = defines.direction.east
                }

            },
            --[[pipe_covers =
                make_4way_animation_from_spritesheet(
                    {
                        filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
                        width = 64,
                        height = 64,
                        direction_count = 4,
                        scale = 0.5
                    }),
            heat_pipe_covers =
                make_4way_animation_from_spritesheet(
                    apply_heat_pipe_glow {
                        filename = "__base__/graphics/entity/heat-exchanger/heatex-endings-heated.png",
                        width = 64,
                        height = 64,
                        direction_count = 4,
                        scale = 0.5
                    }),--]]
            --[[heat_picture =
            {
                north = apply_heat_pipe_glow
                    {
                        filename = "__base__/graphics/entity/heat-exchanger/heatex-N-heated.png",
                        priority = "extra-high",
                        width = 44,
                        height = 96,
                        shift = util.by_pixel(-0.5, 8.5),
                        scale = 0.5
                    },
                east = apply_heat_pipe_glow
                    {
                        filename = "__base__/graphics/entity/heat-exchanger/heatex-E-heated.png",
                        priority = "extra-high",
                        width = 80,
                        height = 80,
                        shift = util.by_pixel(-21, -13),
                        scale = 0.5
                    },
                south = apply_heat_pipe_glow
                    {
                        filename = "__base__/graphics/entity/heat-exchanger/heatex-S-heated.png",
                        priority = "extra-high",
                        width = 28,
                        height = 40,
                        shift = util.by_pixel(-1, -30),
                        scale = 0.5
                    },
                west = apply_heat_pipe_glow
                    {
                        filename = "__base__/graphics/entity/heat-exchanger/heatex-W-heated.png",
                        priority = "extra-high",
                        width = 64,
                        height = 76,
                        shift = util.by_pixel(23, -13),
                        scale = 0.5
                    }
            }--]]
        },
        impact_category = "metal",
        open_sound = { filename = "__base__/sound/open-close/fluid-open.ogg", volume = 0.55 },
        close_sound = { filename = "__base__/sound/open-close/fluid-close.ogg", volume = 0.54 },
        energy_usage = "394MW",
        quality_affects_energy_usage = true,
        heating_energy = nil,
        module_slots = 0,
        source_inventory_size = 1,
        allowed_effects = {},
        effect_receiver = {},
        graphics_set = {
            animation = {
                layers = {
                    {
                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-hr-shadow.png",
                        priority = "high",
                        width = 700,
                        height = 500,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 60,
                        animation_speed = 1,
                        --shift = util.by_pixel(4, -12),
                        draw_as_shadow = true,
                        scale = 0.5,
                    },
                    {
                        priority = "high",
                        width = 280,
                        height = 320,
                        frame_count = 60,
                        lines_per_file = 8,
                        animation_speed = 1,
                        scale = 0.5,
                        shift = util.by_pixel(0, -14),
                        stripes = {
                            {
                                filename = "__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-hr-animation-1.png",
                                width_in_frames = 8,
                                height_in_frames = 8
                            }
                        }
                    },
                    {
                        priority = "high",
                        width = 280,
                        height = 320,
                        frame_count = 60,
                        lines_per_file = 8,
                        animation_speed = 1,
                        scale = 0.5,
                        shift = util.by_pixel(0, -14),
                        stripes = {
                            {
                                filename = "__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-hr-color1-1.png",
                                width_in_frames = 8,
                                height_in_frames = 8
                            }
                        }
                    },

                }
            },
            recipe_not_set_tint = { primary = { r = 0.0, g = 0.6, b = 0.6, a = 1 } },
            working_visualisations = {
                {
                    fadeout = true,
                    animation = {
                        layers = {
                            --[[{
                                priority = "high",
                                width = 280,
                                height = 320,
                                frame_count = 60,
                                lines_per_file = 8,
                                animation_speed = 1,
                                scale = 0.5,
                                shift = util.by_pixel(0, -14),
                                stripes = {
                                    {
                                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-hr-animation-1.png",
                                        width_in_frames = 8,
                                        height_in_frames = 8
                                    }
                                }
                            },--]]
                            {
                                priority = "high",
                                draw_as_glow = true,
                                blend_mode = "additive",
                                width = 280,
                                height = 320,
                                frame_count = 60,
                                lines_per_file = 8,
                                animation_speed = 1,
                                scale = 0.5,
                                shift = util.by_pixel(0, -14),
                                stripes = {
                                    {
                                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-hr-emission-1.png",
                                        width_in_frames = 8,
                                        height_in_frames = 8
                                    }
                                }
                            },
                            {
                                priority = "high",
                                width = 280,
                                height = 320,
                                frame_count = 60,
                                lines_per_file = 8,
                                animation_speed = 1,
                                scale = 0.5,
                                shift = util.by_pixel(0, -14),
                                stripes = {
                                    {
                                        filename = "__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-hr-color2-1.png",
                                        width_in_frames = 8,
                                        height_in_frames = 8
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        --[[{
            light = {
              type = "basic",
              intensity = 1,
              size = 15
            }
          }]]
        --},
        working_sound =
        {
            sound = { filename = "__base__/sound/heat-exchanger.ogg", volume = 1.5 },
            apparent_volume = 1,
        },
        fixed_recipe = "lubricated-boiling"
    },
    {
        type = "recipe-category",
        name = "cubeine-boiling"
    },
    {
        type = "recipe",
        name = "lubricated-boiling",
        subgroup = "energy",
        enabled = true,
        energy_required = 1,
        ingredients = {
            { type = "fluid", name = "water",     amount = 190 },
            { type = "fluid", name = "lubricant", amount = 40 },
        },
        results = {
            { type = "fluid", name = "steam",                    amount = 1000, temperature = 1000 },
            { type = "fluid", name = "residue-cubeine-solution", amount = 100,  temperature = 1000 },
        },
        category = "cubeine-boiling",
        main_product = "steam",
        allow_productivity = false,
        hidden = true
    },
    {

        type = "recipe",
        name = "cubeine-thermal-boiler",
        subgroup = "energy",
        enabled = false,
        energy_required = 30,
        emissions_multiplier = 10,
        ingredients = {
            { type = "item",  name = "low-density-structure", amount = 50 },
            { type = "item",  name = "cubeine-crystal",       amount = 50 },
            { type = "item",  name = "steel-plate",           amount = 500 },
            { type = "item",  name = "advanced-circuit",      amount = 100 },
            { type = "item",  name = "refined-concrete",      amount = 200 },
            { type = "item",  name = "heat-pipe",             amount = 50 },
            { type = "item",  name = "heat-exchanger",        amount = 8 },
            { type = "fluid", name = "lubricant",             amount = 1000 },
        },
        results = {
            { type = "item", name = "cubeine-thermal-boiler", amount = 1 },
        },
        category = "advanced-crafting",
        main_product = "cubeine-thermal-boiler",
        allow_productivity = false,
        order = "c[cubeine]-b[boiler-fluid]",
    },
    {
        type = "technology",
        name = "cubeine-thermal-boiler",
        icons = {
            {
                icon = "__lilys-cubeine-asset-pack__/graphics/entity/oxidizer/oxidizer-icon-big.png",
                icon_size = 640,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            }
        },
        prerequisites = { "cubeine-combustion-center" },

        unit = {
            count = 1000,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 },
            },
            time = 30

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-thermal-boiler"
            },
        }
    }

}
