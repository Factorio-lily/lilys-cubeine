local item_sounds = require("__base__.prototypes.item_sounds")


item = {
    type = "ammo",
    name = "cubonium-artillery-shell",
    icon = "__lilys-cubeine__/graphics/icons/cubonium-artillery-shell-icon.png",
    ammo_category = "artillery-shell",
    ammo_type =
    {
        target_type = "position",
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "artillery",
                projectile = "cubonium-artillery-projectile",
                starting_speed = 1,
                direction_deviation = 0,
                range_deviation = 0,
                source_effects =
                {
                    type = "create-explosion",
                    entity_name = "artillery-cannon-muzzle-flash"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[explosive-cannon-shell]-x[artillery]-cubonium",
    inventory_move_sound = item_sounds.artillery_large_inventory_move,
    pick_sound = item_sounds.artillery_large_inventory_pickup,
    drop_sound = item_sounds.artillery_large_inventory_move,
    stack_size = 1,
    weight = 100 * kg,
}

local shell = {
    type = "artillery-projectile",
    name = "cubonium-artillery-projectile",
    flags = { "not-on-map" },
    hidden = true,
    reveal_map = true,
    map_color = { 1, 0, 1 },
    picture =
    {
        filename = "__lilys-cubeine__/graphics/entity/cubonium-artillery-shell.png",
        draw_as_glow = true,
        width = 64,
        height = 64,
        scale = 0.5
    },
    shadow =
    {
        filename = "__lilys-cubeine__/graphics/entity/shell-shadow.png",
        width = 64,
        height = 64,
        scale = 0.5
    },
    chart_picture =
    {
        filename = "__lilys-cubeine__/graphics/entity/cubonium-artillery-shoot-map-visualization.png",
        flags = { "icon" },
        width = 64,
        height = 64,
        priority = "high",
        scale = 0.25
    },
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        radius = 4.0,
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "damage",
                                    damage = { amount = 1000, type = "physical" }
                                },
                                {
                                    type = "damage",
                                    damage = { amount = 2000, type = "explosion" }
                                }
                            }
                        }
                    }
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        radius = 8.0,
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "damage",
                                    damage = { amount = 1000, type = "explosion" }
                                }
                            }
                        }
                    }
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        radius = 12.0,
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "damage",
                                    damage = { amount = 500, type = "explosion" }
                                }
                            }
                        }
                    }
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "cluster",
                        distance_deviation = 12,
                        cluster_count = 16,
                        distance = 6,
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "create-fire",
                                    entity_name = "cubeine-flame"
                                }
                            }
                        }
                    }
                },
                {
                    type = "create-trivial-smoke",
                    smoke_name = "artillery-smoke",
                    initial_height = 0,
                    speed_from_center = 0.05,
                    speed_from_center_deviation = 0.005,
                    offset_deviation = { { -4, -4 }, { 4, 4 } },
                    max_radius = 12,
                    repeat_count = 4 * 4 * 60
                },
                {
                    type = "create-explosion",
                    entity_name = "massive-explosion"
                },
                {
                    type = "create-explosion",
                    entity_name = "heating-tower-explosion"
                },
                {
                    type = "create-entity",
                    entity_name = "big-artillery-explosion"
                },
                {
                    type = "show-explosion-on-chart",
                    scale = 4*8 / 32
                }
            }
            
        }
    },
    final_action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "create-entity",
                    entity_name = "huge-scorchmark-tintable",
                    check_buildability = true
                },
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                },
                {
                    type = "destroy-decoratives",
                    from_render_layer = "decorative",
                    to_render_layer = "object",
                    include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                    include_decals = false,
                    invoke_decorative_trigger = true,
                    decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                    radius = 10                 -- large radius for demostrative purposes
                }
            }
        }
    },
    height_from_ground = 280 / 64
}


data:extend({ item, shell })


data:extend({ {
    type = "recipe",
    name = "cubonium-artillery-shell",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
        { type = "item", name = "artillery-shell",   amount = 1 },
        { type = "item", name = "liquid-cubonium-barrel", amount = 4 }
    },
    results = { { type = "item", name = "cubonium-artillery-shell", amount = 1 } }
} })


-- technology
data:extend({
    {
        type = "technology",
        name = "cubonium-artillery-shell",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/cubonium-artillery-shell-icon.png",
        prerequisites = { "artillery", "cubonium-monopropellant-thruster" },

        research_trigger =
        {
            type = "craft-item",
            item = "liquid-cubonium-barrel",
            amount = 1
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubonium-artillery-shell"
            }
        }
    }
})
