local item_sounds = require("__base__.prototypes.item_sounds")

local beam = table.deepcopy(data.raw["explosion"]["railgun-beam"])
beam.name = "cubeine-railgun-beam"
if beam.animations[0] then
    beam.animations[0].filename = "__lilys-cubeine__/graphics/entity/railgun-beam-hypervelocity.png"
end
if beam.animations[1] then
    beam.animations[1].filename = "__lilys-cubeine__/graphics/entity/railgun-beam-hypervelocity.png"
end
beam.light = { intensity = 4, size = 30, color = { r = 1, g = 0, b = 0.05 } }

local item = table.deepcopy(data.raw["ammo"]["railgun-ammo"])
item.name = "cubeine-railgun-ammo"
item.icon = "__lilys-cubeine__/graphics/icons/railgun-ammo-hypervelocity.png"
item.ammo_type = {
    target_type = "direction",
    range_modifier = 2,
    cooldown_modifier = 1 / 0.8,
    clamp_position = true,
    action =
    {
        type = "line",
        range = 150,
        width = 1,
        range_effects =
        {
            type = "create-explosion",
            entity_name = "cubeine-railgun-beam"
        },
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "damage",
                    damage = { amount = 20000, type = "physical" }
                },
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
item.order = "e[railgun-ammo]-c[hypervelocity]"
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
        name = "cubeine-railgun-ammo",
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
            { type = "item",  name = "railgun-ammo",      amount = 1 },
            { type = "item", name = "cubeine-crystal", amount = 2 },
        },
        results = { { type = "item", name = "cubeine-railgun-ammo", amount = 1 } }
    }
})


data:extend({
    {
        type = "technology",
        name = "cubeine-railgun-ammo",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/railgun-ammo-hypervelocity.png",
        scale = 4,
        prerequisites = { "cubeine-military-1" },

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
                recipe = "cubeine-railgun-ammo"
            },
        }
    }
})