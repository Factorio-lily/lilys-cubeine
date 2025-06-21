---@diagnostic disable: assign-type-mismatch
require("sound-util")
require("circuit-connector-sprites")
require("util")
require("__space-age__.prototypes.entity.circuit-network")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local meld = require("meld")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")
local procession_graphic_catalogue_types = require("__base__/prototypes/planet/procession-graphic-catalogue-types")


local biochamber_pictures = require("__lilys-cubeine__.prototypes.biochamber-pictures")


data:extend({
    {
        type = "corpse",
        name = "cubeine-biochamber-remnants",
        icon = "__lilys-cubeine__/graphics/icons/biochamber.png",
        flags = { "placeable-neutral", "not-on-map" },
        hidden_in_factoriopedia = true,
        subgroup = "agriculture-remnants",
        order = "b[biochamber]-cubeine",
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        tile_width = 3,
        tile_height = 3,
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15, -- 15 minutes
        expires = false,
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/biochamber/biochamber-remnants",
            {
                scale = 0.5,
                frame_count = 1,
                direction_count = 1,
            }),
    }
})




local biochamber_item = {

    type = "item",
    name = "cubeine-biochamber",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/biochamber.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        }

    },
    subgroup = "agriculture",
    order = "b[cubeine-biochamber]",
    inventory_move_sound = item_sounds.fluid_inventory_move,
    pick_sound = item_sounds.fluid_inventory_pickup,
    drop_sound = item_sounds.fluid_inventory_move,
    place_result = "cubeine-biochamber",
    stack_size = 20,
    default_import_location = "gleba"
}





--local biochamber = table.deepcopy(data.raw["assembling-machine"]["biochamber"])

local biochamber = {
    type = "assembling-machine",
    icon = "__lilys-cubeine__/graphics/icons/biochamber.png",
    name = "cubeine-biochamber",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.1, result = "cubeine-biochamber" },
    fast_replaceable_group = "biochamber",
    crafting_speed = 3,
    energy_source = {
        type = "fluid",
        burns_fluid = true,
        fuel_categories = { "nutrients" },
        effectivity = 1,
        scale_fluid_usage = true,
        emissions_per_minute = { pollution = 10 },
        light_flicker = biochamber_pictures.light_flicker,
        fluid_box = {
            volume = 1000,
            filter = "cubeine-solution",
            draw_only_when_connected = true,
            ---@diagnostic disable-next-line: undefined-global
            pipe_covers = pipecoverspictures(),
            pipe_connections =
            {
                { flow_direction = "input-output", direction = defines.direction.west, position = { -1, 0 } },
                { flow_direction = "input-output", direction = defines.direction.east, position = { 1, 0 } }
            },
            production_type = "input"
        }
    },
    energy_usage = "1MW",
    graphics_set = biochamber_pictures.graphics_set,
    max_health = 300,
    corpse = "cubeine-biochamber-remnants",
    dying_explosion = "biochamber-explosion",
    icon_draw_specification = { shift = { 0, -0.3 } },
    ---@diagnostic disable-next-line: undefined-global
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["biochamber"],
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box_vertical_extension = 0.4,
    module_slots = 4,
    allowed_effects = { "consumption", "speed", "productivity", "pollution", "quality" },
    effect_receiver = { base_effect = { productivity = 0.5 } },

    impact_category = "metal-large",
    open_sound = { filename = "__base__/sound/open-close/fluid-open.ogg", volume = 0.55 },
    close_sound = { filename = "__base__/sound/open-close/fluid-close.ogg", volume = 0.54 },
    working_sound =
    {
        sound = { filename = "__space-age__/sound/entity/biochamber/biochamber-loop.ogg", volume = 0.4 },
        max_sounds_per_prototype = 3,
        fade_in_ticks = 4,
        fade_out_ticks = 20
    },
    heating_energy = "100kW",
    crafting_categories = { "organic", "organic-or-hand-crafting", "organic-or-assembling", "organic-or-chemistry" },
    fluid_boxes_off_when_no_fluid_recipe = true,
    fluid_boxes =
    {
        {
            production_type = "input",
            pipe_picture = biochamber_pictures.pipe_pictures_1,
            pipe_picture_frozen = biochamber_pictures.pipe_pictures_1_frozen,
            mirrored_pipe_picture = biochamber_pictures.pipe_pictures_2,
            mirrored_pipe_picture_frozen = biochamber_pictures.pipe_pictures_2_frozen,
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
                {
                    flow_direction = "input",
                    direction = defines.direction.north,
                    position = { -1, -1 }
                }
            }
        },
        {
            production_type = "input",
            pipe_picture = biochamber_pictures.pipe_pictures_2,
            pipe_picture_frozen = biochamber_pictures.pipe_pictures_2_frozen,
            mirrored_pipe_picture = biochamber_pictures.pipe_pictures_1,
            mirrored_pipe_picture_frozen = biochamber_pictures.pipe_pictures_1_frozen,
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
                {
                    flow_direction = "input",
                    direction = defines.direction.north,
                    position = { 1, -1 }
                }
            }
        },
        {
            production_type = "output",
            pipe_picture = biochamber_pictures.pipe_pictures_1,
            pipe_picture_frozen = biochamber_pictures.pipe_pictures_1_frozen,
            mirrored_pipe_picture = biochamber_pictures.pipe_pictures_2,
            mirrored_pipe_picture_frozen = biochamber_pictures.pipe_pictures_2_frozen,
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
                {
                    flow_direction = "output",
                    direction = defines.direction.south,
                    position = { 1, 1 }
                }
            }
        },
        {
            production_type = "output",
            pipe_picture = biochamber_pictures.pipe_pictures_2,
            pipe_picture_frozen = biochamber_pictures.pipe_pictures_2_frozen,
            mirrored_pipe_picture = biochamber_pictures.pipe_pictures_1,
            mirrored_pipe_picture_frozen = biochamber_pictures.pipe_pictures_1_frozen,
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
                {
                    flow_direction = "output",
                    direction = defines.direction.south,
                    position = { -1, 1 }
                }
            }
        }
    },
    water_reflection =
    {
        pictures =
        {
            filename = "__base__/graphics/entity/chemical-plant/chemical-plant-reflection.png",
            priority = "extra-high",
            width = 28,
            height = 36,
            shift = util.by_pixel(5, 60),
            variation_count = 4,
            scale = 5
        },
        rotate = false,
        orientation_to_variation = true
    },
    production_health_effect = nil
}


data:extend({ biochamber_item, biochamber })


--recipe
local recipe = {
    type = "recipe",
    name = "cubeine-biochamber",
    subgroup = "agriculture",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },      --#9e1725
        secondary = { r = 0.882, g = 0.6, b = 0.675, a = 1.000 },    --#e199ac
        tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },     --#9e1725
        quaternary = { r = 0.655, g = 0.349, b = 0.459, a = 1.000 }, --#a75975
    },
    ingredients = {
        { type = "item",  name = "biochamber",            amount = 1 },
        { type = "fluid", name = "cubeine-solution",      amount = 2000 },
        { type = "item",  name = "cubeine-powder",        amount = 50 },
        { type = "item",  name = "low-density-structure", amount = 100 },
    },
    results = {
        { type = "item", name = "cubeine-biochamber", amount = 1 },
    },
    category = "organic-or-assembling",
    main_product = "cubeine-biochamber",
    allow_productivity = false

}

data:extend({ recipe })

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-biochamber",

        icons = {
            {
                icon = "__lilys-cubeine__/graphics/technology/biochamber.png",
                icon_size = 256,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            }

        },
        prerequisites = { "cubeine-solution", "agricultural-science-pack" },

        unit = {
            count = 1000,
            ingredients =
            {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "chemical-science-pack",     1 },
                { "production-science-pack",   1 },
                { "agricultural-science-pack", 1 }
            },
            time = 60

        },

        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-biochamber"
            }
        }
    }
})
