local item_sounds = require("__base__.prototypes.item_sounds")

local beam = table.deepcopy(data.raw["explosion"]["railgun-beam"])
beam.name = "cubonium-railgun-beam"
if beam.animations[0] then
    beam.animations[0].filename = "__lilys-cubeine__/graphics/entity/railgun-beam-cubonium.png"
end
if beam.animations[1] then
    beam.animations[1].filename = "__lilys-cubeine__/graphics/entity/railgun-beam-cubonium.png"
end
beam.light = { intensity = 4, size = 30, color = { r = 1, g = 0, b = 0.25 } }

local item = table.deepcopy(data.raw["ammo"]["railgun-ammo"])
item.name = "cubonium-railgun-ammo"
item.icon = "__lilys-cubeine__/graphics/icons/railgun-ammo-cubonium.png"
item.ammo_type = {
    target_type = "direction",
    range_modifier = 1,
    cooldown_modifier = 1,
    clamp_position = true,
    action =
    {
        type = "line",
        range = 50,
        width = 1,
        range_effects =
        {
            {
                type = "create-explosion",
                entity_name = "cubonium-railgun-beam"
            },
        },
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "damage",
                    damage = { amount = 5000, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 5000, type = "explosion" }
                },
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
                                    type = "create-entity",
                                    entity_name = "shockwave-1"
                                },
                                {
                                    type = "show-explosion-on-chart",
                                    scale = 4 * 8 / 32
                                }
                            }

                        }
                    },
                }
            },
            source_effects =
            {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
            }
        }
    }
}
item.subgroup = "ammo"
item.order = "e[railgun-ammo]-d[cubonium]"
item.inventory_move_sound = item_sounds.ammo_large_inventory_move
item.pick_sound = item_sounds.ammo_large_inventory_pickup
item.drop_sound = item_sounds.ammo_large_inventory_move
item.stack_size = 10
item.weight = 100 * kg

data:extend({ beam, item })


-- recipe
data:extend({
    {
        type = "recipe",
        name = "cubonium-railgun-ammo",
        category = "advanced-crafting",
        subgroup = "ammo",
        crafting_machine_tint = {
            primary = { r = 1, g = 0.5, b = 0.643, a = 1.000 },    -- #ff99a4ff
            secondary = { r = 1, g = 0.5, b = 0.490, a = 1.000 },  -- #ff997dff
            tertiary = { r = 1, g = 0.5, b = 0.637, a = 1.000 },   -- #ff99a2ff
            quaternary = { r = 1, g = 0.5, b = 0.283, a = 1.000 }, -- #ff9948ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 8,
        ingredients =
        {
            { type = "item", name = "railgun-ammo",    amount = 1 },
            { type = "item", name = "liquid-cubonium-barrel", amount = 4 }
        },
        results = { { type = "item", name = "cubonium-railgun-ammo", amount = 1 } }
    }
})


data:extend({
    {
        type = "technology",
        name = "cubonium-railgun-ammo",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/railgun-ammo-cubonium.png",
        scale = 4,
        prerequisites = { "cubeine-military-2" },

        research_trigger =
        {
            type = "craft-item",
            item = "railgun-ammo",
            amount = 10
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubonium-railgun-ammo"
            },
        }
    }
})
