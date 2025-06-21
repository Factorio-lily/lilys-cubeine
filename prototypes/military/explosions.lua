data:extend({
    {
        type = "explosion",
        name = "shockwave-1",
        localised_name = { "entity-name.shockwave" },
        icons =
        {
            { icon = "__lilys-cubeine__/graphics/icons/shockwave40.png", icon_size = 256 }
        },
        order = "z-c-a",
        flags = { "not-on-map" },
        hidden = true,
        subgroup = "explosions",
        animations = {
            {
                filename = "__lilys-cubeine__/graphics/entity/shockwave.png",
                width = 256,
                height = 256,
                frame_count = 51,
                line_length = 7,
                tint = { 0.4, 0.4, 0.4, 0.4 },
                animation_speed = 1.5,
                scale = 3,
                blend_mode = "additive"
            }
        },
        sound = {
            filename = "__lilys-cubeine__/sounds/shockwave.wav",
            priority = 10,
            min_volume = 1.7,
            max_volume = 2.3,
            audible_distance_modifier = 3
        }
    },
    {
        type = "explosion",
        name = "shockwave-2",
        localised_name = { "entity-name.shockwave" },
        icons =
        {
            { icon = "__lilys-cubeine__/graphics/icons/shockwave40.png", icon_size = 256 }
        },
        order = "z-c-b",
        flags = { "not-on-map" },
        hidden = true,
        subgroup = "explosions",
        animations = {
            {
                filename = "__lilys-cubeine__/graphics/entity/shockwave.png",
                width = 256,
                height = 256,
                frame_count = 51,
                line_length = 7,
                tint = { 0.2, 0.2, 0.2, 0.2 },
                animation_speed = 1.5 * 4 / 6 ,
                scale = 3 * 6 / 4,
                blend_mode = "additive"
            }
        },
        sound = {
            filename = "__lilys-cubeine__/sounds/shockwave.wav",
            priority = 15,
            min_volume = 1.2,
            max_volume = 1.7,
            audible_distance_modifier = 2
        }
    },
    {
        type = "explosion",
        name = "shockwave-3",
        localised_name = { "entity-name.shockwave" },
        icons =
        {
            { icon = "__lilys-cubeine__/graphics/icons/shockwave40.png", icon_size = 256 }
        },
        order = "z-c-a",
        flags = { "not-on-map" },
        hidden = true,
        subgroup = "explosions",
        animations = {
            {
                filename = "__lilys-cubeine__/graphics/entity/shockwave.png",
                width = 256,
                height = 256,
                frame_count = 51,
                line_length = 7,
                tint = { 0.2, 0.2, 0.2, 0.2 },
                animation_speed = 1.5,
                scale = 3,
                blend_mode = "additive"
            }
        },
        sound = {
            filename = "__lilys-cubeine__/sounds/shockwave.wav",
            priority = 20,
            min_volume = 0.7,
            max_volume = 1.3,
            audible_distance_modifier = 2
        }
    },
})
