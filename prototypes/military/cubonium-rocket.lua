local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
    type = "ammo",
    name = "cubonium-rocket",
    icon = "__lilys-cubeine__/graphics/icons/cubonium-missile.png",
    ammo_category = "rocket",
    ammo_type =
    {
        range_modifier = 1.5,
        target_type = "entity",
        action = {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "cubonium-rocket",
                starting_speed = 0.5,
                source_effects =
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-d[cubonium]",
    inventory_move_sound = item_sounds.ammo_large_inventory_move,
    pick_sound = item_sounds.ammo_large_inventory_pickup,
    drop_sound = item_sounds.ammo_large_inventory_move,
    stack_size = 100,
    weight = 40 * kg
}
data:extend({ item })

--entity
local missile = table.deepcopy(data.raw["projectile"]["rocket"])
missile.name = "cubonium-rocket"
missile.action = {
    type = "direct",
    action_delivery =
    {
        type = "instant",
        target_effects =
        {
            {
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
                                entity_name = "shockwave-2"
                            },
                            {
                                type = "damage",
                                damage = { amount = 100, type = "explosion" }
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
                                radius = 3.5                     -- large radius for demostrative purposes
                            },
                            {
                                type = "nested-result",
                                action =
                                {
                                    type = "area",
                                    radius = 6,
                                    action_delivery =
                                    {
                                        type = "instant",
                                        target_effects =
                                        {
                                            {
                                                type = "damage",
                                                damage = { amount = 200, type = "explosion" }
                                            },
                                            {
                                                type = "create-entity",
                                                entity_name = "explosion"
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
                                    radius = 12,
                                    action_delivery =
                                    {
                                        type = "instant",
                                        target_effects =
                                        {
                                            {
                                                type = "damage",
                                                damage = { amount = 100, type = "explosion" }
                                            },
                                            {
                                                type = "create-entity",
                                                entity_name = "explosion"
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
                                    radius = 18,
                                    action_delivery =
                                    {
                                        type = "instant",
                                        target_effects =
                                        {
                                            {
                                                type = "damage",
                                                damage = { amount = 50, type = "explosion" }
                                            },
                                            {
                                                type = "create-entity",
                                                entity_name = "explosion"
                                            }
                                        }
                                    }
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
                include_soft_decoratives = true,     -- soft decoratives are decoratives with grows_through_rail_path = true
                include_decals = false,
                invoke_decorative_trigger = true,
                decoratives_with_trigger_only = false,     -- if true, destroys only decoratives that have trigger_effect set
                radius = 4                                 -- large radius for demostrative purposes
            }
        }
    }
}
missile.animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({ 1.0, 0, 0.5 })
missile.animation.layers[3].tint = { 1.0, 0, 0.5 }
missile.acceleration = missile.acceleration * 2
missile.turn_speed = missile.turn_speed * 2

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ missile })


-- recipe
data:extend({
    {
        type = "recipe",
        name = "cubonium-rocket",
        category = "advanced-crafting",
        subgroup = "ammo",
        crafting_machine_tint = {
            primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 },    -- #ffbba4ff
            secondary = { r = 1.000, g = 0.557, b = 0.490, a = 1.000 },  -- #ff8e7dff
            tertiary = { r = 1.000, g = 0.637, b = 0.637, a = 1.000 },   -- #ffa2a2ff
            quaternary = { r = 1.000, g = 0.283, b = 0.283, a = 1.000 }, -- #ff4848ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 10,
        ingredients =
        {
            { type = "item",  name = "rocket",           amount = 1 },
            { type = "item",  name = "liquid-cubonium-barrel", amount = 1 },
        },
        results = { { type = "item", name = "cubonium-rocket", amount = 1 } }
    }
})

