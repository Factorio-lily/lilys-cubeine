

local base_animation = {
    type = "animation",
    name = "nukubeine-reactor-base-animation",
    width = 590,
    height = 640,

    filenames = {
        "__lilys-cubeine-asset-pack-2__/graphics/entity/reactor/research-center-hr-animation-1.png",
        "__lilys-cubeine-asset-pack-2__/graphics/entity/reactor/research-center-hr-animation-2.png"
    }, 
    scale = 0.5,
    lines_per_file = 8,
    priority = "medium",
    line_length = 8,
    frame_count = 80,
    shift = { 0, -0.5 },

}

local emissive_animation = {
    type = "animation",
    name = "nukubeine-reactor-emissive-animation",

    filenames = {
        "__lilys-cubeine-asset-pack-2__/graphics/entity/reactor/research-center-hr-emission-1.png",
        "__lilys-cubeine-asset-pack-2__/graphics/entity/reactor/research-center-hr-emission-2.png"
    },
    scale = 0.5,
    lines_per_file = 8,
    width = 590,
    height = 640,

    priority = "medium",
    line_length = 8,
    frame_count = 80,
    --tint = { 1, 0.1, 0.8, 1 },
    blend_mode = "additive",
    shift = { 0, -0.5 },
    draw_as_glow = true

}

local frozen_animation = {
    type = "animation",
    name = "nukubeine-reactor-frozen-animation",
    width = 590,
    height = 640,

    filenames = {
        "__lilys-cubeine-asset-pack-2__/graphics/entity/reactor/research-center-hr-frozen-1.png",
        "__lilys-cubeine-asset-pack-2__/graphics/entity/reactor/research-center-hr-frozen-2.png"
    },
    scale = 0.5,
    lines_per_file = 8,
    priority = "medium",
    line_length = 8,
    frame_count = 80,
    shift = { 0, -0.5 },
    --blend_mode = "replace"

}


local heat_animation = {
    type = "animation",
    name = "nukubeine-reactor-heat-glow",
    width = 590,
    height = 640,
    filenames = {
        "__lilys-cubeine-asset-pack-2__/graphics/entity/reactor/research-center-hr-animation-bwl-1.png",
        "__lilys-cubeine-asset-pack-2__/graphics/entity/reactor/research-center-hr-animation-bwl-2.png"
    },
    blend_mode = "additive",
    --tint = { 0.5, 0.2, 0.5, 0.5 },

    scale = 0.5,
    lines_per_file = 8,
    priority = "medium",
    line_length = 8,
    frame_count = 80,
    shift = { 0, -0.5 },
    apply_runtime_tint = true,
    --premul_alpha = false
}

data.extend({base_animation, emissive_animation, frozen_animation, heat_animation})