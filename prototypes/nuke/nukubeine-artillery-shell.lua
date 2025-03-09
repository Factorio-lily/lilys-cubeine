local item_sounds = require("__base__.prototypes.item_sounds")

local nukubeine = data.raw["item"]["nukubeine-crystal"]

item = {
    type = "ammo",
    name = "nukubeine-artillery-shell",
    icon = "__lilys-cubeine__/graphics/icons/nukubeine-artillery-shell-icon.png",
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
                projectile = "nukubeine-artillery-projectile",
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
    order = "d[explosive-cannon-shell]-x[artillery]-nukubeine",
    inventory_move_sound = item_sounds.artillery_large_inventory_move,
    pick_sound = item_sounds.artillery_large_inventory_pickup,
    drop_sound = item_sounds.artillery_large_inventory_move,
    stack_size = 1,
    weight = 1000 * kg,
    spoil_ticks = nukubeine.spoil_ticks * 2,
    spoil_to_trigger_result = nukubeine.spoil_to_trigger_result
}

local shell = {
    type = "artillery-projectile",
    name = "nukubeine-artillery-projectile",
    flags = { "not-on-map" },
    hidden = true,
    reveal_map = true,
    map_color = { 1, 0, 1 },
    picture =
    {
        filename = "__lilys-cubeine__/graphics/entity/nukubeine-artillery-shell.png",
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
        filename = "__lilys-cubeine__/graphics/icons/cubeine-crystal-radiant.png",
        flags = { "icon" },
        width = 64,
        height = 64,
        priority = "high",
        scale = 0.25
    },
    action = nukubeine.spoil_to_trigger_result.trigger,
    height_from_ground = 280 / 64
}


data:extend({ item, shell })


data:extend({ {
    type = "recipe",
    name = "nukubeine-artillery-shell",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
        { type = "item",  name = "artillery-shell",     amount = 1 },
        { type = "item",  name = "nukubeine-crystal", amount = 1 }
    },
    results = { { type = "item", name = "nukubeine-artillery-shell", amount = 1 } }
} })


-- technology
data:extend({
    {
        type = "technology",
        name = "nukubeine-artillery-shells",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/nukubeine-artillery-shell-icon.png",
        prerequisites = {"artillery"},

        research_trigger =
        {
            type = "craft-item",
            item = "nukubeine-crystal",
            amount = 1
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "nukubeine-artillery-shell"
            }
        }
    }
})
