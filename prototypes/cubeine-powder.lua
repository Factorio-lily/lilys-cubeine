local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

local effect_duration = 20 * 60
local wd_duration = 100 * 60
local wd_speed = 0.5
local boost = 2.0
local dps = 20

local item = {

    type = "capsule",
    name = "cubeine-powder",
    icon = "__lilys-cubeine__/graphics/icons/cubeine.png",
    subgroup = "agriculture-processes",
    order = "b[agriculture]-g[cubeine-powder]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 1000,
    default_import_location = "nauvis",
    weight = 10,
    fuel_category = "chemical",
    fuel_value = "2MJ",
    fuel_acceleration_multiplier = 5,
    fuel_top_speed_multiplier = 2,
    fuel_emissions_multiplier = 10,
    capsule_action = {
        type = "use-on-self",
        attack_parameters =
        {
            type = "projectile",
            activation_type = "consume",
            ammo_category = "capsule",
            cooldown = 60*4,
            range = 0,
            ammo_type =
            {
                target_type = "position",
                action =
                {
                    type = "direct",
                    action_delivery =
                    {
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "create-sticker",
                                    sticker = "cubeine-powder-sticker",
                                    show_in_tooltip = true
                                },
                                {
                                    type = "create-sticker",
                                    sticker = "cubeine-powder-sticker-2",
                                },
                                {
                                    type = "play-sound",
                                    sound = sounds.eat_fish,
                                },
                                {
                                    type = "script",
                                    effect_id = "cubeine-powder-consumed"
                                }

                            }
                        },
                        {
                            type = "delayed",
                            delayed_trigger = "cubeinepowder-wd"
                        }
                    }
                }
            }
        }
    }
  }

local sticker1 = {
    type = "sticker",
    name = "cubeine-powder-sticker",
    flags = { "not-on-map" },
    hidden = true,
    single_particle = true,
    duration_in_ticks = effect_duration,
    target_movement_modifier = boost,
    damage_interval = 30,
    damage_per_tick = { amount = dps / 2, type = "poison"},
    animation =
        util.sprite_load("__lilys-cubeine__/graphics/sticker/whirl_front",
            {
                priority = "high",
                frame_count = 50,
                scale = 0.5,
                animation_speed = 1.5,
                shift = util.by_pixel(0, 16),
                tint = {0.5, 0, 0, 0.5},
                draw_as_glow = true
            }
        )
}
local sticker2 = {
    type = "sticker",
    name = "cubeine-powder-sticker-2",
    flags = { "not-on-map" },
    hidden = true,
    single_particle = true,
    duration_in_ticks = effect_duration,
    render_layer = "object-under",
    animation =
        util.sprite_load("__lilys-cubeine__/graphics/sticker/whirl_back",
            {
                priority = "high",
                frame_count = 50,
                scale = 0.5,
                animation_speed = 1.5,
                shift = util.by_pixel(0, 16),
                tint = { 0.5, 0, 0, 0.5 },
                draw_as_glow = true
            }
        )
}


local sticker3 = {
    type = "sticker",
    name = "cubeine-powder-sticker-3",
    flags = { "not-on-map" },
    hidden = true,
    single_particle = true,
    duration_in_ticks = wd_duration,
    target_movement_modifier = wd_speed,
    target_movement_modifier_to = 1,
    ground_target = true
}


local delayed_trigger = {
    type = "delayed-active-trigger",
    name = "cubeinepowder-wd",
    delay = effect_duration,
    action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                {
                    type = "create-sticker",
                    sticker = "cubeine-powder-sticker-3",
                },
            }
        }

    }
}

  data:extend{item, sticker1, sticker2, sticker3, delayed_trigger}