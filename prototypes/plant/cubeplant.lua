local util = require('util')
local sounds = require("__base__.prototypes.entity.sounds")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")

local seconds = 60
local minutes = 60 * seconds

local plant_emissions = { pollution = -0.001 }
local plant_flags = { "placeable-neutral", "placeable-off-grid", "breaths-air", "not-flammable" }

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
    ---@diagnostic disable-next-line: undefined-global, undefined-global
    mining_sound = sound_variations("__space-age__/sound/mining/axe-mining-teflilly", 5, 0.5),
    ---@diagnostic disable-next-line: undefined-global
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
        entity_name = "cubeine-flame"
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
            "highland-dark-rock", "highland-dark-rock-2", "highland-yellow-rock", "pit-rock",
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
        { r = 255, g = 255, b = 255 },
        { r = 255, g = 255, b = 255 },
        { r = 255, g = 220, b = 255 },
        { r = 255, g = 255, b = 220 },
        { r = 255, g = 220, b = 255 },
        { r = 255, g = 220, b = 220 },
        { r = 255, g = 255, b = 220 },
        { r = 255, g = 200, b = 255 },
        { r = 255, g = 220, b = 255 },
        { r = 255, g = 200, b = 255 },
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
        primary = { r = 0.852, g = 0.218, b = 0.218, a = 1.000 },   -- #bb3737ff
        secondary = { r = 0.861, g = 0.613, b = 0.308, a = 1.000 }, -- #bb4f4eff
    },
    -- tile_buildability_rules = { {area = {{-0.55, -0.55}, {0.55, 0.55}}, required_tiles = {"natural-yumako-soil", "artificial-yumako-soil"}, remove_on_collision = true} },
    ambient_sounds =
    {
        sound =
        {
            ---@diagnostic disable-next-line: undefined-global
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
            min = 500,
            max = 3000
        }
    },
    map_color = { 255, 160, 160 }, --#ffa0a0
}

--Cubium
if mods["cubium"] and plant.autoplace.tile_restriction then
    local tiles = { "cubium-ash-soil", "cubium-soil-light", "cubium-soil-dark", "cubium-ash-cracks",
        "cubium-volcanic-pumice-stones", "cubium-volcanic-ash-flats", "cubium-volcanic-ash-light" }

    for _, tile in ipairs(tiles) do
        table.insert(plant.autoplace.tile_restriction, tile)
    end
end

--Moshine
if mods["Moshine"] and plant.autoplace.tile_restriction then
    local tiles = { "moshine-dunes", "moshine-sand", "moshine-dust" }

    for _, tile in ipairs(tiles) do
        table.insert(plant.autoplace.tile_restriction, tile)
    end
end

if mods["alien-biomes"] and plant.autoplace.tile_restriction then
    local tiles = data.raw["tile"]

    for name, value in pairs(tiles) do
        local dirt, grass = false, false

        if string.find(name, "mineral%-") and string.find(name, "%-dirt") then
            dirt = true
        end
        if string.find(name, "vegetation%-") and string.find(name, "%-grass") then
            grass = true
        end

        if dirt or grass then
            table.insert(plant.autoplace.tile_restriction, name)
        end
    end
end


if mods["zen-garden"] then
    table.insert(plant.autoplace.tile_restriction, "artificial-grass")
end

data:extend({ plant })










local superplant = table.deepcopy(plant)
superplant.name = "redleaf-cubeplant-super"
superplant.icon = "__lilys-cubeine__/graphics/technology/cubeplant-processing-2.png"
superplant.growth_ticks = 2 * minutes
superplant.harvest_emissions = { spores = 5, pollution = 100 }
superplant.emissions_per_second = { pollution = -0.03 }
superplant.max_health = 500
superplant.resistances = {
    {
        type = "fire",
        amount = 50,
        percent = 99
    },
    {
        type = "explosion",
        amount = 50,
        percent = 99
    }
}
superplant.dying_trigger_effect = {
    type = "nested-result",
    action = {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "create-entity",
                    entity_name = "big-explosion"
                },
                {
                    type = "create-entity",
                    entity_name = "shockwave-3"
                },
                {
                    type = "nested-result",
                    action =
                    {
                        {
                            type = "area",
                            radius = 4,
                            action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                {
                                    {
                                        type = "damage",
                                        damage = { amount = 300, type = "explosion" }
                                    },
                                    {
                                        type = "create-entity",
                                        entity_name = "explosion"
                                    }
                                }
                            }
                        },
                        {
                            type = "area",
                            radius = 8,
                            action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                {
                                    {
                                        type = "damage",
                                        damage = { amount = 150, type = "explosion" }
                                    },
                                    {
                                        type = "create-entity",
                                        entity_name = "explosion"
                                    }
                                }
                            }
                        },
                        {
                            type = "area",
                            radius = 12,
                            action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                {
                                    {
                                        type = "damage",
                                        damage = { amount = 75, type = "explosion" }
                                    },
                                    {
                                        type = "create-entity",
                                        entity_name = "explosion"
                                    }
                                }
                            }
                        }
                    }
                },
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                },
            }
        }
    }
}
superplant.order = "a[tree]-c[nauvis-gleba]-a[seedable]-d[redleaf-cubeplant-super]"
superplant.autoplace.control = nil
superplant.autoplace.probability_expression = "0"
superplant.autoplace.richness_expression = "0"
table.insert(superplant.autoplace.tile_restriction, "landfill")
table.insert(superplant.autoplace.tile_restriction, "nuclear-ground")
table.insert(superplant.autoplace.tile_restriction, "oil-ocean-shallow")
table.insert(superplant.autoplace.tile_restriction, "oil-ocean-deep")
if mods["castra"] then
    table.insert(superplant.autoplace.tile_restriction, "light-oil-ocean-deep")
end
superplant.pictures = {
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
        {
            filename = "__lilys-cubeine__/graphics/entity/cubeplant-mask.png",
            width = 500,
            height = 356,
            scale = 0.25,
            shift = util.by_pixel(20, 0),
            tint = { 1, 0, 0.25, 0.5 },
            draw_as_glow = true,
            blend_mode = "additive"
        },
    }
}
superplant.agricultural_tower_tint =
{
    primary = { r = 1, g = 0.218, b = 0.418, a = 1.000 },
    secondary = { r = 1, g = 0.213, b = 0.408, a = 1.000 },
}
superplant.map_color = { 255, 100, 100 }
superplant.minable.results = { { type = "item", name = "cubeplant-branch-super", amount = 20 } }
superplant.collision_mask = { layers = { train = true, is_object = true, is_lower_object = true, player = true } }
superplant.stateless_visualisation_variations = {
    {
        light = {
            intensity = 0.4,
            size = 15,
            color = {1, 0, 0.05}
        }
    }
}

data:extend({ superplant })



if mods["cubium"] then
    local blueplant = table.deepcopy(plant)
    blueplant.name = "redleaf-cubeplant-blue"
    blueplant.icon = "__lilys-cubeine__/graphics/technology/cubeplant-processing-3.png"
    blueplant.growth_ticks = 2 * minutes
    blueplant.harvest_emissions = { spores = 5, pollution = -50 }
    blueplant.emissions_per_second = { pollution = -0.1 }
    blueplant.dying_trigger_effect = nil
    blueplant.max_health = 500
    blueplant.resistances = {
        {
            type = "fire",
            amount = 50,
            percent = 99
        },
        {
            type = "impact",
            amount = 50,
            percent = 99
        }
    }
    blueplant.order = "a[tree]-c[cubium]-a[seedable]-d[redleaf-cubeplant-blue]"
    blueplant.autoplace.control = nil
    blueplant.autoplace.probability_expression = "0"
    blueplant.autoplace.richness_expression = "0"
    blueplant.autoplace.tile_restriction = {
        "cubium-ash-soil", "cubium-soil-light", "cubium-soil-dark", "cubium-ash-cracks",
        "cubium-volcanic-pumice-stones", "cubium-volcanic-ash-flats", "cubium-volcanic-ash-light",
        "cubium-volcanic-cracks-hot", "cubium-volcanic-cracks-warm", "cubium-volcanic-cracks",
        "cubium-smooth-stone-warm", "cubium-volcanic-smooth-stone", "cubium-folds-warm",
        "cubium-folds", "cubium-volcanic-folds-flat", "cubium-volcanic-jagged-ground",
        "cubium-volcanic-pumice-stones", "cubium-volcanic-ash-dark",
    }

    blueplant.pictures = {
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
                filename = "__lilys-cubeine__/graphics/entity/cubeplant-blue.png",
                width = 500,
                height = 356,
                scale = 0.25,
                shift = util.by_pixel(20, 0)
            },
            {
                filename = "__lilys-cubeine__/graphics/entity/cubeplant-mask.png",
                width = 500,
                height = 356,
                scale = 0.25,
                shift = util.by_pixel(20, 0),
                tint = { 0, 0.25, 1, 0.5 },
                draw_as_glow = true,
                blend_mode = "additive"
            },
        }
    }
    blueplant.agricultural_tower_tint =
    {
        primary = { r = 0.218, g = 0.218, b = 1, a = 1.000 },
        secondary = { r = 0.308, g = 0.613, b = 1, a = 1.000 },
    }
    blueplant.map_color = { 100, 100, 255 }
    blueplant.minable.results = { { type = "item", name = "cubeplant-branch-blue", amount = 20 } }

    blueplant.stateless_visualisation_variations = {
        {
            light = {
                intensity = 0.4,
                size = 15,
                color = { 0, 0.05, 1 }
            }
        }
    }
    data:extend({ blueplant })
end
