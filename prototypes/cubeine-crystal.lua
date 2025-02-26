local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

local effect_duration = 60 * 60
local boost = 5
local dps = 50

local item = {

    type = "capsule",
    name = "cubeine-crystal",
    icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
    subgroup = "agriculture-processes",
    order = "b[agriculture]-g[cubeine-crystal]",
    inventory_move_sound = space_age_item_sounds.ice_inventory_move,
    pick_sound = space_age_item_sounds.ice,
    drop_sound = space_age_item_sounds.ice_inventory_move,
    stack_size = 1000,
    default_import_location = "nauvis",
    weight = 1,
    fuel_category = "chemical",
    fuel_value = "100MJ",
    fuel_acceleration_multiplier = 20,
    fuel_top_speed_multiplier = 10,
    fuel_emissions_multiplier = 100,
    capsule_action = {
        type = "use-on-self",
        attack_parameters =
        {
            type = "projectile",
            activation_type = "consume",
            ammo_category = "capsule",
            cooldown = 60 * 4,
            range = 0,
            ammo_type =
            {
                target_type = "position",
                action =
                {
                    type = "direct",
                    action_delivery =
                    {
                        type = "instant",
                        target_effects =
                        {
                            {
                                type = "create-sticker",
                                sticker = "cubeine-crystal-sticker",
                                show_in_tooltip = true
                            },
                            {
                                type = "create-sticker",
                                sticker = "cubeine-crystal-sticker-2",
                            },
                            {
                                type = "play-sound",
                                sound = sounds.eat_fish,
                            }
                        }
                    }
                }
            }
        }
    }
}

local sticker1 = {
    type = "sticker",
    name = "cubeine-crystal-sticker",
    flags = { "not-on-map" },
    hidden = true,
    single_particle = true,
    duration_in_ticks = effect_duration,
    target_movement_modifier = boost,
    damage_interval = 60,
    damage_per_tick = { amount = dps, type = "physical" },
    animation =
        util.sprite_load("__space-age__/graphics/sticker/jellynut-speed/whirl_front",
            {
                priority = "high",
                frame_count = 50,
                scale = 0.5,
                animation_speed = 3,
                shift = util.by_pixel(0, 16),
                tint = { 1, 0, 0, 1 }
            }
        )
}
local sticker2 = {
    type = "sticker",
    name = "cubeine-crystal-sticker-2",
    flags = { "not-on-map" },
    hidden = true,
    single_particle = true,
    duration_in_ticks = effect_duration,
    render_layer = "object-under",
    animation =
        util.sprite_load("__space-age__/graphics/sticker/jellynut-speed/whirl_back",
            {
                priority = "high",
                frame_count = 50,
                scale = 0.5,
                animation_speed = 3,
                shift = util.by_pixel(0, 16),
                tint = { 1, 0, 0, 1 }
            }
        )
}

data:extend { item, sticker1, sticker2 }
