local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
--require("__base__.prototypes.entity.pipecovers")
--require("__base__.circuit-connector-sprites")
--require("__base__.prototypes.entity.entity-util")

local heated_pipes_tint = { 0.75, 0.2, 0.1, 0.75 }
local heat_glow_tint = { 1, 0.6, 0.6, 1 }

local base_tint = { r = 1, g = 0.8, b = 0.8, a = 1 }
local emissive_tint = { r = 1, g = 0.2, b = 0.2, a = 1 }

local smoke = table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"])
smoke.name = "cubeine-combustion-center-smoke"
smoke.color = { 0.3, 0.1, 0.1, 0.6 }
smoke.start_scale = smoke.start_scale / 2
smoke.duration = smoke.duration * 4
smoke.cyclic = true
---@diagnostic disable-next-line: assign-type-mismatch
data:extend({smoke})

apply_heat_pipe_glow = function(layer)
    layer.tint = heated_pipes_tint
    local light_layer = util.copy(layer)
    light_layer.draw_as_light = true
    light_layer.tint = heat_glow_tint
    return
    {
        layers =
        {
            layer,
            light_layer
        }
    }
end

data:extend({
    {
        type = "corpse",
        name = "cubeine-combustion-center-remnants",
        icon = "__lilys-cubeine__/graphics/icons/heating-tower.png",
        flags = { "placeable-neutral", "not-on-map" },
        hidden_in_factoriopedia = true,
        subgroup = "environmental-protection-remnants",
        order = "c[heating-tower]",
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        tile_width = 3,
        tile_height = 3,
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15, -- 15 minutes
        expires = false,
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/heating-tower-remnants",
            {
                scale = 2.5 / 3,
                direction_count = 1
            })
    },
})

local reactor = {
    type                                 = "reactor",
    name                                 = "cubeine-combustion-center",
    icon                                 = "__lilys-cubeine__/graphics/icons/heating-tower.png",
    flags                                = { "placeable-neutral", "player-creation" },
    minable                              = { mining_time = 0.5, result = "cubeine-combustion-center" },
    fast_replaceable_group               = "reactor",
    max_health                           = 1000,
    resistances                          =
    {
        {
            type = "fire",
            percent = 99
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

    surface_conditions                   = {
        { property = "pressure",       min = 500 },
        { property = "magnetic-field", max = 200 }
    },
    neighbour_bonus                      = 0.25,
    corpse                               = "cubeine-combustion-center-remnants",
    dying_explosion                      = "nuclear-reactor-explosion",
    consumption                          = "750MW",
    energy_source                        =
    {
        type = "fluid",
        burns_fluid = true,
        emissions_per_minute = { pollution = 1000 },
        effectivity = 1.5,
        scale_fluid_usage = true,
        --fluid_usage_per_tick = 50,
        smoke = {
            {
                name = "cubeine-combustion-center-smoke",
                frequency = 120,
                vertical_speed_slowdown = 0.5,
                starting_vertical_speed = 2,
                starting_vertical_speed_deviation = 0.5,
                position = {-0.75, -1.0}
            }
        },
        light_flicker =
        {
            color = { 1, 0.02, 0 },
            minimum_intensity = 0.5,
            maximum_intensity = 1,
            minimum_light_size = 10
        },
        fluid_box = {
            production_type = "input",
            pipe_picture = require("__space-age__.prototypes.entity.electromagnetic-plant-pictures").pipe_pictures,
            pipe_picture_frozen = require("__space-age__.prototypes.entity.electromagnetic-plant-pictures")
                .pipe_pictures_frozen,
            pipe_covers = pipecoverspictures(),
            volume = 2000,
            secondary_draw_orders = { north = -1, west = -1, east = -1 },
            pipe_connections = {
                { direction = defines.direction.south, position = { 1, 2 } },
                { direction = defines.direction.south, position = { -1, 2 } },
                { direction = defines.direction.east,  position = { 2, 1 } },
                { direction = defines.direction.east,  position = { 2, -1 } },
                { direction = defines.direction.north, position = { 1, -2 } },
                { direction = defines.direction.north, position = { -1, -2 } },
                { direction = defines.direction.west,  position = { -2, 1 } },
                { direction = defines.direction.west,  position = { -2, -1 } },
            }
        },

    },
    collision_box                        = { { -2.2, -2.2 }, { 2.2, 2.2 } },
    selection_box                        = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    damaged_trigger_effect               = hit_effects.entity(),
    light                                = {
        intensity = 0.5,
        size = 40,
        color = {
            r = 1.00,
            g = 0.1,
            b = 0.0,
            a = 1
        }
    },
    lower_layer_picture                  =
    {
        layers = {
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
                width = 320,
                height = 316,
                scale = 0.5,
                shift = util.by_pixel(-1, -5),
                tint = heat_glow_tint
            },
        }
    },
    heat_lower_layer_picture             =
    {
        layers = {
            apply_heat_pipe_glow {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes-heated.png",
                width = 320,
                height = 316,
                scale = 0.5,
                shift = util.by_pixel(-0.5, -4.5),
                tint = heat_glow_tint
            },
        }
    },

    connection_patches_connected         =
    {
        sheet =
        {
            filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches.png",
            width = 64,
            height = 64,
            variation_count = 12,
            scale = 0.5,
            tint = { 1, 0.6, 0.6, 1 }
        }
    },

    connection_patches_disconnected      =
    {
        sheet =
        {
            filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches.png",
            width = 64,
            height = 64,
            variation_count = 12,
            y = 64,
            scale = 0.5,
            tint = { 1, 0.6, 0.6, 1 }
        }
    },

    heat_connection_patches_connected    =
    {
        sheet = apply_heat_pipe_glow
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches-heated.png",
                width = 64,
                height = 64,
                variation_count = 12,
                scale = 0.5,
                tint = { 1, 0.6, 0.6, 1 }
            }
    },

    heat_connection_patches_disconnected =
    {
        sheet = apply_heat_pipe_glow
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches-heated.png",
                width = 64,
                height = 64,
                variation_count = 12,
                y = 64,
                scale = 0.5,
                tint = { 1, 0.6, 0.6, 1 }
            }
    },

    picture                              = {
        layers =
        {
            util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/reactor", {
                scale = 0.5,
                shift = { 0.25, -0.2 }
            }),
            util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/reactor", {
                scale = 0.5,
                shift = { -0.5, 0 }
            }),
            util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/heating-tower-main", {
                scale = 2.5 / 3
            }),
            util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/heating-tower-shadow", {
                scale = 2.5 / 3,
                draw_as_shadow = true
            })
        }
    },



    working_light_picture =
    {
        layers = {
            util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/heating-tower-working-fire", {
                frame_count = 24,
                scale = 2.5 / 3,
                blend_mode = "additive",
                draw_as_glow = true,
                animation_speed = 0.5
            }),
            util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/heating-tower-working-light", {
                frame_count = 1,
                repeat_count = 24,
                scale = 2.5 / 3,
                blend_mode = "additive",
                draw_as_glow = true
            }),
            util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/heating-tower-working-light", {
                frame_count = 1,
                repeat_count = 24,
                scale = 2.5 / 3,
                blend_mode = "additive",
                draw_as_glow = true
            }),
            util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/heating-tower-working-fire", {
                frame_count = 24,
                scale = 2.5 / 3,
                blend_mode = "additive",
                draw_as_glow = true,
                animation_speed = 0.5
            }),
        }
    },



    heating_radius             = 3,
    heat_buffer                = {
        max_temperature = 2000,
        specific_heat = "20MJ",
        max_transfer = "20GW",
        minimum_glow_temperature = 500,
        connections =
        {
            {
                position = { -2, -2 },
                direction = defines.direction.north
            },
            {
                position = { 0, -2.0 },
                direction = defines.direction.north
            },
            {
                position = { 2, -2.0 },
                direction = defines.direction.north
            },
            {
                position = { 2.0, -2.0 },
                direction = defines.direction.east
            },
            {
                position = { 2.0, 0.0 },
                direction = defines.direction.east
            },
            {
                position = { 2, 2 },
                direction = defines.direction.east
            },
            {
                position = { -2, 2 },
                direction = defines.direction.south
            },
            {
                position = { 0, 2 },
                direction = defines.direction.south
            },
            {
                position = { 2, 2 },
                direction = defines.direction.south
            },
            {
                position = { -2, -2 },
                direction = defines.direction.west
            },
            {
                position = { -2, 0 },
                direction = defines.direction.west
            },
            {
                position = { -2, 2 },
                direction = defines.direction.west
            },


        },

        heat_picture = apply_heat_pipe_glow(
            util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower/heating-tower-glow", {
                scale = 2.5 / 3,
                blend_mode = "additive"
            }))


    },
    impact_category            = "metal-large",
    open_sound                 = { filename = "__base__/sound/open-close/nuclear-open.ogg", volume = 0.8 },
    close_sound                = { filename = "__base__/sound/open-close/nuclear-close.ogg", volume = 0.8 },
    working_sound              =
    {
        sound = { filename = "__space-age__/sound/entity/heating-tower/heating-tower-loop.ogg", volume = 1.75 },
        max_sounds_per_type = 2,
        fade_in_ticks = 4,
        fade_out_ticks = 20
    },

    meltdown_action            =
    {
        {
            type = "area",
            radius = 12,
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        damage = {
                            type = "explosion",
                            amount = 1000
                        },
                        lower_damage_modifier = 0.5,
                    }
                }
            }
        },
        {
            type = "cluster",
            cluster_count = 16,
            distance = 8,
            distance_deviation = 16,
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-fire",
                        entity_name = "cubeine-flame",
                        initial_ground_flame_count = 8
                    }
                }
            }
        }

    },

    default_temperature_signal = { type = "virtual", name = "signal-T" },
    ---@diagnostic disable-next-line: undefined-global
    circuit_wire_max_distance  = reactor_circuit_wire_max_distance * 2,
    ---@diagnostic disable-next-line: undefined-global
    circuit_connector          = circuit_connector_definitions["nuclear-reactor"],

}
for _, pic in pairs(reactor.energy_source.fluid_box.pipe_covers or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end
for _, pic in pairs(reactor.energy_source.fluid_box.pipe_picture or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end

local item = {

    type = "item",
    name = "cubeine-combustion-center",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/heating-tower.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        }
    },
    place_result = "cubeine-combustion-center",
    subgroup = "energy",
    order = "c[chemical-energy]-b[reactor-fluid]",
    inventory_move_sound = item_sounds.reactor_inventory_move,
    pick_sound = item_sounds.reactor_inventory_pickup,
    drop_sound = item_sounds.reactor_inventory_move,
    stack_size = 5,
    default_import_location = "nauvis",
    weight = 200 * kg,
}
--[[
local pipe = table.deepcopy(data.raw["heat-pipe"]["heat-pipe"])
pipe.name = "cubeine-heat-pipe"
pipe.minable.result = "cubeine-heat-pipe"

pipe.icons = {
    {
        icon = pipe.icon,
        icon_size = 64,
        tint = { 1, 0.6, 0.6, 1 }
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 6, 6 }
    }
}
pipe.icon = nil
pipe.max_health = 500
pipe.heat_buffer =
{
    max_temperature = 2000,
    specific_heat = "2MJ",
    max_transfer = "20GW",
    minimum_glow_temperature = 350,
    connections =
    {
        {
            position = { 0, 0 },
            ---@diagnostic disable-next-line: assign-type-mismatch
            direction = defines.direction.north
        },
        {
            position = { 0, 0 },
            ---@diagnostic disable-next-line: assign-type-mismatch
            direction = defines.direction.east
        },
        {
            position = { 0, 0 },
            ---@diagnostic disable-next-line: assign-type-mismatch
            direction = defines.direction.south
        },
        {
            position = { 0, 0 },
            ---@diagnostic disable-next-line: assign-type-mismatch
            direction = defines.direction.west
        }
    }
}
pipe.heating_radius = 2

for _, res in ipairs(pipe.resistances) do
    if res.type == "fire" then
        res.percent = 100
    end
end




for name, array in pairs(pipe.connection_sprites) do
    for _, sprite in ipairs(array) do
        sprite.tint = { 1, 0.6, 0.6, 1 }
    end
end

for name, array in pairs(pipe.heat_glow_sprites) do
    for _, sprite in ipairs(array) do
        if sprite.layers then
            sprite.layers[1].tint = { 0.75, 0.2, 0.1, 0.75 }
            sprite.layers[2].tint = { 1, 0.6, 0.6, 1 }
        else
            sprite.tint = { 1, 0.6, 0.6, 1 }
        end
    end
end




local pipe_item = {
    type = "item",
    name = "cubeine-heat-pipe",
    icons = {
        {
            icon = "__base__/graphics/icons/heat-pipe.png",
            icon_size = 64,
            tint = { 1, 0.6, 0.6, 1 }
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        }
    },
    subgroup = "energy",
    order = "z[cubic-energy]-b[heat-pipe]",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    place_result = "cubeine-heat-pipe",
    stack_size = 50,
    weight = 40 * kg,
}
--]]

--recipe
local recipe = {

    type = "recipe",
    name = "cubeine-combustion-center",
    subgroup = "energy",
    enabled = false,
    energy_required = 30,
    emissions_multiplier = 10,
    ingredients = {
        { type = "item", name = "low-density-structure", amount = 50 },
        { type = "item", name = "cubeine-crystal",       amount = 50 },
        { type = "item", name = "steel-plate",           amount = 500 },
        { type = "item", name = "advanced-circuit",      amount = 100 },
        { type = "item", name = "refined-concrete",      amount = 200 },
        { type = "item", name = "heat-pipe",             amount = 50 },
        { type = "item", name = "heating-tower",         amount = 1 },
    },
    results = {
        { type = "item", name = "cubeine-combustion-center", amount = 1 },
    },
    category = "advanced-crafting",
    main_product = "cubeine-combustion-center",
    allow_productivity = false,
    --preserve_products_in_machine_output = true,
    order = "c[cubeine]-f[reactor-fluid]",
    --hide_from_signal_gui = false
}

--recipe
--[[
local pipe_recipe = {

    type = "recipe",
    name = "cubeine-heat-pipe",
    enabled = false,
    energy_required = 10,
    emissions_multiplier = 1,
    ingredients = {
        { type = "item",  name = "heat-pipe",         amount = 10 },
        { type = "item",  name = "tungsten-plate",    amount = 10 },
        { type = "item",  name = "tungsten-carbide",  amount = 10 },
        { type = "item",  name = "cubeine-crystal",   amount = 1 },
        { type = "item",  name = "carbon-fiber",      amount = 10 },
        { type = "fluid", name = "cubeine-solution",  amount = 100 },
        { type = "fluid", name = "fluoroketone-cold", amount = 100 },
        { type = "fluid", name = "lubricant",         amount = 100 },
    },
    results = {
        { type = "item", name = "cubeine-heat-pipe", amount = 1 },
    },
    category = "cryogenics",
    allow_productivity = false,
    --preserve_products_in_machine_output = true,
    order = "nk[nukubeine]-b[heat-pipe]",
    --hide_from_signal_gui = false
}
--]]

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ reactor, item, recipe })

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-combustion-center",
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/technology/heating-tower.png",
                icon_size = 256,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            }
        },
        prerequisites = { "cuboil" },

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
                recipe = "cubeine-combustion-center"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-heat-pipe"
            },
        }
    }
})
