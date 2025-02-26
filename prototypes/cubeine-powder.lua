local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

local effect_duration = 20 * 60
local boost = 2.0
local dps = 10

local item = {

    type = "capsule",
    name = "cubeine-powder",
    icon = "__lilys-cubeine__/graphics/icons/cubeine.png",
    subgroup = "agriculture-processes",
    order = "b[agriculture]-g[cubeine-powder]",
    inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
    pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
    drop_sound = space_age_item_sounds.agriculture_inventory_move,
    stack_size = 1000,
    default_import_location = "nauvis",
    weight = 1,
    fuel_category = "chemical",
    fuel_value = "10MJ",
    fuel_acceleration_multiplier = 5,
    fuel_top_speed_multiplier = 3,
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
    name = "cubeine-powder-sticker",
    flags = { "not-on-map" },
    hidden = true,
    single_particle = true,
    duration_in_ticks = effect_duration,
    target_movement_modifier = boost,
    damage_interval = 60,
    damage_per_tick = { amount = dps, type = "physical"},
    animation =
        util.sprite_load("__space-age__/graphics/sticker/jellynut-speed/whirl_front",
            {
                priority = "high",
                frame_count = 50,
                scale = 0.5,
                animation_speed = 1.5,
                shift = util.by_pixel(0, 16),
                tint = {0.5, 0, 0, 0.5}
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
        util.sprite_load("__space-age__/graphics/sticker/jellynut-speed/whirl_back",
            {
                priority = "high",
                frame_count = 50,
                scale = 0.5,
                animation_speed = 1.5,
                shift = util.by_pixel(0, 16),
                tint = { 0.5, 0, 0, 0.5 }
            }
        )
}

  data:extend{item, sticker1, sticker2}