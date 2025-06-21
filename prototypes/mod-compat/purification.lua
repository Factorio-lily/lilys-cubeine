local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
--require("__base__.prototypes.entity.pipecovers")
--require("__base__.circuit-connector-sprites")
--require("__base__.prototypes.entity.entity-util")


local base_tint = { r = 0.6, g = 0.8, b = 1, a = 1 }
local emissive_tint = { r = 0.2, g = 0.5, b = 1, a = 1 }

data:extend({
    {
        type = "recipe-category",
        name = "purification"
    }
})

data:extend({
    {
        type = "corpse",
        name = "purification-tower-remnants",
        icon = "__lilys-cubeine__/graphics/icons/purification-tower.png",
        flags = { "placeable-neutral", "not-on-map" },
        hidden_in_factoriopedia = true,
        subgroup = "environmental-protection-remnants",
        order = "c[purification-tower]",
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        tile_width = 3,
        tile_height = 3,
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15, -- 15 minutes
        expires = false,
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = util.sprite_load(
            "__lilys-cubeine-asset-pack__/graphics/entity/heating-tower-2/heating-tower-remnants",
            {
                scale = 0.5,
                direction_count = 1
            })
    },
})

local tower = {
    type                   = "assembling-machine",
    name                   = "purification-tower",
    icon                   = "__lilys-cubeine__/graphics/icons/purification-tower.png",
    flags                  = { "placeable-neutral", "player-creation" },
    minable                = { mining_time = 0.5, result = "purification-tower" },
    fast_replaceable_group = "assembling-machine",
    max_health             = 500,

    surface_conditions     = {
        { property = "pressure",       min = 0 },
        { property = "magnetic-field", max = 200 }
    },
    corpse                 = "purification-tower-remnants",
    dying_explosion        = "medium-explosion",
    energy_usage           = "1MW",
    crafting_speed         = 1,
    crafting_categories    = { "purification" },
    allowed_effects        = { "consumption", "pollution", "productivity", "speed" },
    module_slots           = 2,
    --allowed_module_categories = { "speed", "consumption", "pollution" },
    energy_source          =
    {
        type = "electric",
        buffer_capacity = "1MJ",
        usage_priority = "secondary-input",
        drain = "1kW",
        emissions_per_minute = { pollution = -1000, spores = -200 },
        effectivity = 1,
        light_flicker =
        {
            color = { 0.2, 0.5, 1 },
            minimum_intensity = 0.5,
            maximum_intensity = 1,
            minimum_light_size = 5
        },
    },
    fluid_boxes            = {
        {
            production_type = "input",
            pipe_picture = require("__space-age__.prototypes.entity.electromagnetic-plant-pictures").pipe_pictures,
            pipe_picture_frozen = require("__space-age__.prototypes.entity.electromagnetic-plant-pictures")
                .pipe_pictures_frozen,
            --pipe_covers = pipecoverspictures(),
            volume = 100,
            draw_only_when_connected = true,
            secondary_draw_orders = { north = -1, west = -1, east = -1 },
            pipe_connections = {
                { direction = defines.direction.south, position = { 0, 1 } },
                { direction = defines.direction.east,  position = { 1, 0 } },
                { direction = defines.direction.north, position = { 0, -1 } },
                { direction = defines.direction.west,  position = { -1, 0 } },
            }
        },
    },
    collision_box          = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box          = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    light                  = {
        intensity = 0.5,
        size = 10,
        color = {
            r = 1.00,
            g = 0.1,
            b = 0.0,
            a = 1
        }
    },
    show_recipe_icon       = false,
    fixed_recipe           = "purification-tower-operation",
    heating_energy         = "1kW",

    graphics_set           = {
        idle_animation = {
            layers = {
                util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower-2/heating-tower-main", {
                    scale = 0.5,
                    frame_count = 1,
                    repeat_count = 24,
                }),
                util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower-2/heating-tower-shadow", {
                    scale = 0.5,
                    draw_as_shadow = true,
                    frame_count = 1,
                    repeat_count = 24,
                })
            }
        },
        animation = {
            layers = {
                util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower-2/heating-tower-main", {
                    scale = 0.5,
                    frame_count = 1,
                    repeat_count = 24,
                }),
                util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/heating-tower-2/heating-tower-shadow", {
                    scale = 0.5,
                    draw_as_shadow = true,
                    frame_count = 1,
                    repeat_count = 24,
                }),
            }
        },
        --always_draw_idle_animation = true,
        working_visualisations = {
            {
                --effect = "flicker",
                --fadeout = true,
                --draw_as_glow = true,
                animation = {
                    layers = {
                        util.sprite_load(
                            "__lilys-cubeine-asset-pack__/graphics/entity/heating-tower-2/heating-tower-working-fire",
                            {
                                frame_count = 24,
                                scale = 0.5,
                                blend_mode = "additive",
                                draw_as_glow = true,
                                animation_speed = 0.5
                            }),
                        util.sprite_load(
                            "__lilys-cubeine-asset-pack__/graphics/entity/heating-tower-2/heating-tower-working-light",
                            {
                                frame_count = 1,
                                repeat_count = 24,
                                scale = 0.5,
                                blend_mode = "additive",
                                draw_as_glow = true
                            }),
                    }
                }
            }
        }
    },

    impact_category        = "metal-large",
    open_sound             = { filename = "__base__/sound/open-close/nuclear-open.ogg", volume = 0.8 },
    close_sound            = { filename = "__base__/sound/open-close/nuclear-close.ogg", volume = 0.8 },
    working_sound          =
    {
        sound = { filename = "__lilys-cubeine__/sounds/turbopump.wav", volume = 0.75 },
        max_sounds_per_type = 2,
        fade_in_ticks = 4,
        fade_out_ticks = 20
    },


    ---@diagnostic disable-next-line: undefined-global
    circuit_wire_max_distance = reactor_circuit_wire_max_distance,
    ---@diagnostic disable-next-line: undefined-global
    circuit_connector         = circuit_connector_definitions["assembling-machine"],

}

--[[for _, pic in pairs(tower.fluid_boxes[1].pipe_covers or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end--]]
for _, pic in pairs(tower.fluid_boxes[1].pipe_picture or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end

local item = {

    type = "item",
    name = "purification-tower",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/purification-tower.png",
            icon_size = 64,
        },
    },
    place_result = "purification-tower",
    subgroup = "energy",
    order = "c[chemical-energy]-z[purification]",
    inventory_move_sound = item_sounds.reactor_inventory_move,
    pick_sound = item_sounds.reactor_inventory_pickup,
    drop_sound = item_sounds.reactor_inventory_move,
    stack_size = 10,
    default_import_location = "cubium",
    weight = 100 * kg,
}


--recipe
local recipe = {

    type = "recipe",
    name = "purification-tower",
    enabled = false,
    energy_required = 10,
    ingredients = {
        { type = "item", name = "inverted-microcube", amount = 1 },
        { type = "item", name = "heating-tower",      amount = 1 },
    },
    results = {
        { type = "item", name = "purification-tower",         amount = 1 },
        { type = "item", name = "inverted-dormant-microcube", amount = 1, ignored_by_productivity = 100 },
    },
    category = "advanced-crafting",
    main_product = "purification-tower",
    allow_productivity = false,
    --preserve_products_in_machine_output = true,
    --hide_from_signal_gui = false
}

--recipe
local operation_recipe = {

    type = "recipe",
    name = "purification-tower-operation",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/fluid/purification-fluid.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-recycle.png",
            icon_size = 64,
            tint = { 0.65, 0.65, 0.65, 0.65 }
        },
    },
    enabled = true,
    energy_required = 6,
    emissions_multiplier = 1,
    ingredients = {
        { type = "fluid", name = "purification-fluid", amount = 50 },
    },
    results = {

    },
    category = "purification",
    allow_productivity = true,
    allow_quality = false,
    --preserve_products_in_machine_output = true,
    hidden = true
    --hide_from_signal_gui = false
}
--]]

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ tower, item, recipe, operation_recipe })

-- technology
data:extend({
    {
        type = "technology",
        name = "purification-tower",
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/technology/purification-tower.png",
                icon_size = 256,
            },
        },
        prerequisites = { "heating-tower", "nukubeine-inversion" },


        research_trigger = {
            type = "craft-fluid",
            fluid = "purification-fluid",
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "purification-tower"
            },
        }
    }
})
