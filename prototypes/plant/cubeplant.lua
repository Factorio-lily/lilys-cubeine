local util = require('util')
local sounds = require("__base__.prototypes.entity.sounds")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")

local seconds = 60
local minutes = 60*seconds

local plant_emissions = { pollution = -0.001 }
local plant_flags = {"placeable-neutral", "placeable-off-grid", "breaths-air", "not-flammable"}

local leaf_sound = sounds.tree_leaves
local leaf_sound_trigger =
{
    {
        type = "play-sound",
        sound = leaf_sound,
        damage_type_filters = "fire"
    }
}



local plant = {
    type = "plant",
    name = "redleaf-cubeplant", 
    icon = "__lilys-cubeine__/graphics/technology/cubeplant-processing.png",
    icon_size = 256,
    scale = 0.25,
    flags = plant_flags,
    minable =
    {
        mining_particle = "wooden-particle",
        mining_time = 0.5,
        results = { { type = "item", name = "cubeplant-branch", amount = 20 } },
        mining_trigger =
        {
            {
                type = "direct",
                action_delivery =
                {
                    {
                        type = "instant",
                        target_effects = leaf_sound_trigger
                    }
                }
            }
        }
    },
    mining_sound = sound_variations("__space-age__/sound/mining/axe-mining-teflilly", 5, 0.5),
    mined_sound = sound_variations("__space-age__/sound/mining/mined-teflilly", 5, 0.5),
    growth_ticks = 5 * minutes,
    harvest_emissions = { spores = 50, pollution = 50 },
    emissions_per_second = plant_emissions,
    max_health = 50,
    resistances = {
        {
            type = "fire",
            amount = 50,
            percent = 90
        }
    },
    dying_trigger_effect = {
        type = "create-fire",
        entity_name = "fire-flame"
    },
    collision_box = { { -0.8, -0.8 }, { 0.8, 0.8 } },
    --collision_mask = {layers={player=true, ground_tile=true, train=true}},
    selection_box = { { -1, -1 }, { 1, 1 } },
    --drawing_box_vertical_extension = 0.8,
    subgroup = "trees",
    order = "a[tree]-c[nauvis-gleba]-a[seedable]-d[redleaf-cubeplant]",
    impact_category = "tree",
    autoplace = {
        control = "redleaf-cubeplants",
        order = "a[plant]-b[redleaf-cubeplant]",
        probability_expression = "redleaf_cubeplant_probability",
        richness_expression = "redleaf_cubeplant_richness",
        tile_restriction =
        {
            --Nauvis
            "grass-1", "grass-2", "grass-3", "grass-4",
            "dry-dirt", "dirt-1", "dirt-2", "dirt-3", "dirt-4", "dirt-5", "dirt-6", "dirt-7",
            "red-desert-0", "red-desert-1", "red-desert-2", "red-desert-3",
            -- Gleba
            "highland-dark-rock", "highland-dark-rock-2", "highland-yellow-rock", "pit-rock"
        }
    },
    --[[{
        control = "trees",
        order = "a[tree]-b[forest]-a",
        probability_expression = "min(0.2, 0.3 * (1 - gleba_plants_noise) * control:gleba_plants:size)",
        richness_expression = "random_penalty_at(3, 1)",
        tile_restriction = { "natural-yumako-soil", "artificial-yumako-soil", "overgrowth-yumako-soil" }
    },--]]
    colors = {
      {r = 255, g = 255, b =  255},
      {r = 255, g = 255, b =  255},
      {r = 255, g = 220, b =  255},
      {r = 255, g = 255, b =  220},
      {r = 255, g = 220, b =  255},
      {r = 255, g = 220, b =  220},
      {r = 255, g = 255, b =  220},
      {r = 255, g = 200, b =  255},
      {r = 255, g = 220, b =  255},
      {r = 255, g = 200, b =  255},
    },
    pictures = {
        layers = {
            {
                filename = "__lilys-cubeine__/graphics/entity/cubeplant-shadow.png",
                width = 500,
                height = 356,
                scale = 0.25,
                shift = util.by_pixel(20, 0),
                draw_as_shadow = true
            }, 
            {
                filename = "__lilys-cubeine__/graphics/entity/cubeplant.png",
                width = 500,
                height = 356,
                scale = 0.25,
                shift = util.by_pixel(20, 0)
            },
        }
    },
    agricultural_tower_tint =
    {
        primary = { r = 0.852, g = 0.218, b = 0.218, a = 1.000 }, -- #bb3737ff
        secondary = { r = 0.861, g = 0.613, b = 0.308, a = 1.000 }, -- #bb4f4eff
    },
    -- tile_buildability_rules = { {area = {{-0.55, -0.55}, {0.55, 0.55}}, required_tiles = {"natural-yumako-soil", "artificial-yumako-soil"}, remove_on_collision = true} },
    ambient_sounds =
    {
        sound =
        {
            variations = sound_variations("__space-age__/sound/world/plants/teflilly", 8, 0.7),
            advanced_volume_control =
            {
                fades = { fade_in = { curve_type = "cosine", from = { control = 0.5, volume_percentage = 0.0 }, to = { 1.5, 100.0 } } }
            }
        },
        radius = 7.5,
        min_entity_count = 2,
        max_entity_count = 10,
        entity_to_sound_ratio = 0.3,
        average_pause_seconds = 8
    },
    surface_conditions = {
        {
            property = "pressure",
            min = 1000,
            max = 3000
        }
},
    map_color = { 255, 160, 160 }, --#ffa0a0
}

if mods["cubium"] and plant.autoplace.tile_restriction then
    local tiles = {"cubium-ash-soil", "cubium-soil-light", "cubium-soil-dark", "cubium-ash-cracks", "cubium-volcanic-pumice-stones", "cubium-volcanic-ash-flats", "cubium-volcanic-ash-light"}

    for _, tile in ipairs(tiles) do
        table.insert(plant.autoplace.tile_restriction, tile)
    end
end


data:extend({plant})