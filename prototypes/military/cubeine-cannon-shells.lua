local item_sounds = require("__base__.prototypes.item_sounds")


-- standard shell
local shell = table.deepcopy(data.raw["ammo"]["cannon-shell"])

shell.name = "cubeine-cannon-shell"
shell.icon = "__lilys-cubeine__/graphics/icons/cannon-shell-hypervelocity.png"
shell.order = shell.order .. "-hypervelocity"

shell.ammo_type =
    {
      range_modifier = 1.25 * 2,
      cooldown_modifier = 1 / 0.8,
      target_type = "direction",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "cubeine-cannon-projectile",
          starting_speed = 5,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 100,
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
    name = "cubeine-cannon-projectile",
    flags = { "not-on-map" },
    hidden = true,
    collision_box = { { -0.3, -1.1 }, { 0.3, 1.1 } },
    acceleration = 0,
    direction_only = true,
    piercing_damage = 1000 * 4,
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
                    damage = { amount = 1000 * 1.5, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 100, type = "explosion" }
                },
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
                    entity_name = "small-scorchmark-tintable",
                    check_buildability = true
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
        tint = { 1, 0, 0, 1 }
    }
}

data.extend({ shell, proj })


-- recipe
data:extend({
    {
        type = "recipe",
        name = "cubeine-cannon-shell",
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
            { type = "item",  name = "cannon-shell", amount = 1 },
            { type = "item",  name = "cubeine-crystal",       amount = 1 }
        },
        results = { { type = "item", name = "cubeine-cannon-shell", amount = 1 } }
    }
})



















-- uranium shell
local ushell = table.deepcopy(data.raw["ammo"]["uranium-cannon-shell"])

ushell.name = "cubeine-uranium-cannon-shell"
ushell.icon = "__lilys-cubeine__/graphics/icons/uranium-cannon-shell-hypervelocity.png"
ushell.order = ushell.order .. "-hypervelocity"

ushell.ammo_type =
{
    range_modifier = 1.25 * 2,
    cooldown_modifier = 1 / 0.8,
    target_type = "direction",
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "projectile",
            projectile = "cubeine-uranium-cannon-projectile",
            starting_speed = 5,
            direction_deviation = 0.1,
            range_deviation = 0.1,
            max_range = 200,
            min_range = 5,
            source_effects =
            {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
            }
        }
    }
}

-- uranium shell projectile
local uproj = {
    type = "projectile",
    name = "cubeine-uranium-cannon-projectile",
    flags = { "not-on-map" },
    hidden = true,
    collision_box = { { -0.3, -1.1 }, { 0.3, 1.1 } },
    acceleration = 0,
    direction_only = true,
    piercing_damage = 2200 * 4,
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
                    damage = { amount = 2000 * 1.5, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 200, type = "explosion" }
                },
                {
                    type = "create-entity",
                    entity_name = "uranium-cannon-explosion"
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
                    entity_name = "small-scorchmark-tintable",
                    check_buildability = true
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
        tint = { 1, 0.5, 0, 1 }
    }
}

data.extend({ ushell, uproj })




-- recipe
data:extend({
    {
        type = "recipe",
        name = "cubeine-uranium-cannon-shell",
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
            { type = "item", name = "uranium-cannon-shell", amount = 1 },
            { type = "item",  name = "cubeine-crystal",          amount = 1 }
        },
        results = { { type = "item", name = "cubeine-uranium-cannon-shell", amount = 1 } }
    }
})

