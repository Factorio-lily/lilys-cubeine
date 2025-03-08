

local base_animation = {
    type = "animation",
    name = "nukubeine-reactor-base-animation",
    width = 590,
    height = 640,

    filenames = {
        "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-animation-1.png",
        "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-animation-2.png"
    },
    lines_per_file = 8,
    priority = "medium",
    line_length = 8,
    frame_count = 80,
    tint = {1, 0.8, 0.8, 1}

}

local emissive_animation = {
    type = "animation",
    name = "nukubeine-reactor-emissive-animation",

    filenames = {
        "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-emission-1.png",
        "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-emission-2.png"
    },
    lines_per_file = 8,
    width = 590,
    height = 640,

    priority = "medium",
    line_length = 8,
    frame_count = 80,
    tint = { 1, 0.1, 0.8, 1 },
    mode = "additive",
    draw_as_glow = true

}

local frozen_animation = {
    type = "animation",
    name = "nukubeine-reactor-frozen-animation",
    width = 590,
    height = 640,

    filenames = {
        "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-animation-1.png",
        "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-animation-2.png"
    },
    lines_per_file = 8,
    priority = "medium",
    line_length = 8,
    frame_count = 80,
    mode = "replace"

}

data.extend({base_animation, emissive_animation, frozen_animation})