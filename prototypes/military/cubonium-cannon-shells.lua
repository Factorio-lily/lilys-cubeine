local item_sounds = require("__base__.prototypes.item_sounds")


-- standard shell
local shell = table.deepcopy(data.raw["ammo"]["explosive-cannon-shell"])

shell.name = "cubonium-cannon-shell"
shell.icon = "__lilys-cubeine__/graphics/icons/explosive-cubonium-cannon-shell.png"
shell.order = shell.order .. "-cubonium"

shell.ammo_type =
{
    range_modifier = 1.5,
    cooldown_modifier = 1,
    target_type = "direction",
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "projectile",
            projectile = "cubonium-cannon-projectile",
            starting_speed = 1.5,
            direction_deviation = 0.1,
            range_deviation = 0.1,
            max_range = 60,
            min_range = 5,
            source_effects =
            {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
            }
        }
    }
}

-- standard shell projectile
local proj = {
    type = "projectile",
    name = "cubonium-cannon-projectile",
    flags = { "not-on-map" },
    hidden = true,
    collision_box = { { -0.3, -1.1 }, { 0.3, 1.1 } },
    acceleration = 0,
    direction_only = true,
    piercing_damage = 200,
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "damage",
                    damage = { amount = 300, type = "physical" }
                },
                {
                    type = "create-entity",
                    entity_name = "explosion"
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
                                        damage = { amount = 600, type = "explosion" }
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
                            radius = 12,
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
                        }
                    }
                },
                {
                    type = "create-entity",
                    entity_name = "medium-scorchmark-tintable",
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
                    radius = 4                   -- large radius for demostrative purposes
                }
            }
        }
    },
    animation =
    {
        filename = "__base__/graphics/entity/bullet/bullet.png",
        draw_as_glow = true,
        width = 3,
        height = 50,
        priority = "high",
        tint = { 1, 0, 0.5, 1 }
    }
}

data.extend({ shell, proj })


-- recipe
data:extend({
    {
        type = "recipe",
        name = "cubonium-cannon-shell",
        category = "advanced-crafting",
        subgroup = "ammo",
        crafting_machine_tint = {
            primary = { r = 1.0, g = 0.735, b = 0.643, a = 1.000 },    -- #ffbba4ff
            secondary = { r = 1.0, g = 0.557, b = 0.490, a = 1.000 },  -- #ff8e7dff
            tertiary = { r = 1.0, g = 0.637, b = 0.637, a = 1.000 },   -- #ffa2a2ff
            quaternary = { r = 1.0, g = 0.283, b = 0.283, a = 1.000 }, -- #ff4848ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 8,
        ingredients =
        {
            { type = "item", name = "cannon-shell",    amount = 1 },
            { type = "item", name = "liquid-cubonium-barrel", amount = 1 }
        },
        results = { { type = "item", name = "cubonium-cannon-shell", amount = 1 } }
    }
})
