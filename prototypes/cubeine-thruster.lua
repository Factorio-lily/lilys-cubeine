require("sound-util")
require("circuit-connector-sprites")
require("util")
require("__space-age__.prototypes.entity.circuit-network")
local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")



data:extend({
    {
        type = "corpse",
        name = "cubeine-thruster-remnants",
        icon = "__lilys-cubeine__/graphics/icons/thruster-1.png",
        flags = { "placeable-neutral", "not-on-map" },
        hidden_in_factoriopedia = true,
        subgroup = "space-platform-remnants",
        order = "d",
        selection_box = { { -2, -2.5 }, { 2, 5.5 } },
        collision_box = { { -1.7, -2.2 }, { 1.7, 2.2 } },
        tile_width = 4,
        tile_height = 5,
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15, -- 15 minutes
        expires = false,
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-remnants", {
            scale = 0.5,
            direction_count = 1,
            line_length = 1,
            shift = { 0, 3 }
        }),
    },
})



local thruster_item = {
    type = "item",
    name = "cubeine-thruster",
    icon = "__lilys-cubeine__/graphics/icons/thruster-1.png",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/thruster-1.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        }
    },
    subgroup = "space-platform",
    order = "f[cubeine-thruster]",
    inventory_move_sound = space_age_item_sounds.rocket_inventory_move,
    pick_sound = space_age_item_sounds.rocket_inventory_pickup,
    drop_sound = space_age_item_sounds.rocket_inventory_move,
    place_result = "cubeine-thruster",
    stack_size = 10,
    weight = 200 * kg
}


local thruster = table.deepcopy(data.raw["thruster"]["thruster"])
thruster.icon = "__lilys-cubeine__/graphics/icons/thruster-1.png"
thruster.icons = {
    {
        icon = "__lilys-cubeine__/graphics/icons/thruster-1.png",
        icon_size = 64,
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 6, 6 }
    }
}
thruster.name = "cubeine-thruster"
thruster.minable.result = "cubeine-thruster"
thruster.max_health = 600
thruster.min_performance = { fluid_volume = 0.1, fluid_usage = 0.5, effectivity = 0.6 }
thruster.max_performance = { fluid_volume = 0.5, fluid_usage = 5, effectivity = 0.4 }

thruster.fuel_fluid_box =
{
    filter = "cubeine-fuel",
    production_type = "input",
    -- pipe_covers = pipecoverspictures(),
    draw_only_when_connected = true,
    volume = 2000,
    pipe_connections =
    {
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.west, position = { -1.5, -2 }, enable_working_visualisations = { "pipe-4" } },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.east, position = { 1.5, 0 },   enable_working_visualisations = { "pipe-2" } },
    }
}
thruster.oxidizer_fluid_box =
{
    filter = "thruster-oxidizer",
    production_type = "input",
    -- pipe_covers = pipecoverspictures(),
    draw_only_when_connected = true,
    volume = 2000,
    pipe_connections =
    {
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.east, position = { 1.5, -2 }, enable_working_visualisations = { "pipe-1" } },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.west, position = { -1.5, 0 }, enable_working_visualisations = { "pipe-3" } },
    }
}

thruster.corpse = "cubeine-thruster-remnants"
thruster.graphics_set =
    {
      animation = util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster",
                  {
                    animation_speed = 1,
                    frame_count = 64,
                    scale = 0.5,
                    shift = {0,3}
                  }),

      integration_patch_render_layer = "floor",
      integration_patch = util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-bckg",
                          {
                            scale = 0.5,
                            shift = {0,3}
                          }),

      working_visualisations =
      {
        {
          always_draw = true,
          name = "pipe-1",
          enabled_by_name = true,
          animation =
          {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-pipe-connection-1.png",
            width = 384,
            height = 832,
            shift = util.by_pixel(0, 95),
            scale = 0.5
          }
        },
        {
          always_draw = true,
          name = "pipe-2",
          enabled_by_name = true,
          animation =
          {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-pipe-connection-2.png",
            width = 384,
            height = 832,
            shift = util.by_pixel(0, 96),
            scale = 0.5
          }
        },
        {
          always_draw = true,
          name = "pipe-3",
          enabled_by_name = true,
          animation =
          {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-pipe-connection-3.png",
            width = 384,
            height = 832,
            shift = util.by_pixel(0, 96),
            scale = 0.5
          }
        },
        {
          always_draw = true,
          name = "pipe-4",
          enabled_by_name = true,
          animation =
          {
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-pipe-connection-4.png",
            width = 384,
            height = 832,
            shift = util.by_pixel(0, 95),
            scale = 0.5
          }
        },

        {
          -- effect = "flicker",
			    fadeout = true,
			    animation = util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-light",
				              {
				                animation_speed = 1,
				                frame_count = 64,
				                blend_mode = "additive",
				                draw_as_glow = true,
				                scale = 0.5,
				                shift = {0,3}
				              }),
        },
      },
      flame_effect =
      {
        filename = "__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-flame.png",
        width = 384,
        height = 832
      },
      flame_position = {0, 5.5},
      flame_half_height = 0,
      flame_effect_height = 1000 / 32,
      flame_effect_width = 384 / 64,
      flame_effect_offset = 50 / 32,
    }
    thruster.plumes =
    {
      render_box = {{-15, -10}, {15, 100}},
      min_probability = 0.08,
      max_probability = 1,
      min_y_offset = -4,
      max_y_offset = 0,
      stateless_visualisations =
      {
        {
          offset_x = { -0.1, 0.1 },
          offset_y = { 10.5, 10.5 },
          offset_z = { 0.0 , 0.0 },

          speed_x = { -0.014, 0.014 },
          speed_y = { 0.5, 0.7 },
          speed_z = { -0.014, 0.014 },

          probability = 0.3,
          count = 3,
          age_discrimination = -10,
          period = 200,
          fade_in_progress_duration = 0.25,
          fade_out_progress_duration = 0.6,
          spread_progress_duration = 0.375,
          begin_scale = 0.25,
          end_scale = 1.25,
          affected_by_wind = false,
          render_layer = "smoke",
          can_lay_on_the_ground = false,
          animation =
          {
            width = 253,
            height = 210,
	          scale = 0.5,
            line_length = 8,
            frame_count = 60,
            shift = {0, 0},
            priority = "high",
            animation_speed = 0.25,
            tint = {r = 1, b = 0.95, g = 0.97, a = 0.5},
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-smoke.png",
            flags = { "smoke" }
          }
        },
        {
          offset_x = { -0.2, 0.2 },
          offset_y = { 14.5, 14.5 },
          offset_z = { 0.0 , 0.0 },

          speed_x = { -0.014, 0.014 },
          speed_y = { 0.55, 0.65 },
          speed_z = { -0.014, 0.014 },

          probability = 0.5,
          period = 60,
          age_discrimination = -6,
          fade_in_progress_duration = 0.5,
          fade_out_progress_duration = 0.5,
          begin_scale = 0.5,
          end_scale = 1.25,
          affected_by_wind = false,
          render_layer = "smoke",
          can_lay_on_the_ground = false,
          animation =
          {
            width = 2024/8,
            height = 1216/8,
            line_length = 8,
            frame_count = 60,
            shift = {0, 0},
            priority = "high",
            animation_speed = 0.25,
            tint = {r = 0.75, b = 0.75, g = 0.75, a = 1},
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-smoke-glow.png",
            flags = { "smoke" },
            draw_as_glow = true
          }
        },
        {
          offset_x = { -0.25, 0.25 },
          offset_y = { 13.0, 13.0 },
          offset_z = { 0.0 , 0.0 },

          speed_x = { -0.014, 0.014 },
          speed_y = { 0.5, 0.7 },
          speed_z = { -0.014, 0.014 },

          probability = 0.2,
          count = 2,
          period = 200,
          --age_discrimination = 0,
          fade_in_progress_duration = 0.3,
          fade_out_progress_duration = 0.7,
          begin_scale = 0.5,
          end_scale = 3.0,
          affected_by_wind = false,
          render_layer = "smoke",
          can_lay_on_the_ground = false,
          animation =
          {
            width = 253,
            height = 210,
            line_length = 8,
            frame_count = 60,
            shift = {0, 0},
            priority = "high",
            animation_speed = 0.1,
            tint = {r = 1, b = 0.95, g = 0.97, a = 1.0},
            filename = "__lilys-cubeine-asset-pack__/graphics/entity/thruster-1/thruster-smoke.png",
            flags = { "smoke" }
          }
        }
      }
    }


---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ thruster_item, thruster })



--recipe
local recipe = {
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/thruster-1.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        }
    },
    type = "recipe",
    name = "cubeine-thruster",
    subgroup = "space-platform",
    enabled = false,
    energy_required = 30,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },      --#9e1725
        secondary = { r = 0.882, g = 0.6, b = 0.675, a = 1.000 },    --#e199ac
        tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },     --#9e1725
        quaternary = { r = 0.655, g = 0.349, b = 0.459, a = 1.000 }, --#a75975
    },
    ingredients = {
        { type = "item", name = "thruster",              amount = 1 },
        { type = "item", name = "tungsten-plate",        amount = 100 },
        { type = "item", name = "cubeine-crystal",       amount = 10 },
        { type = "item", name = "low-density-structure", amount = 100 },
    },
    results = {
        { type = "item", name = "cubeine-thruster", amount = 1 },
    },
    category = "advanced-crafting",
    --main_product = "cubeine-assembler",
    allow_productivity = false

}




--recipe
local fuel = {

    type = "recipe",
    name = "cubeine-fuel-mixing",
    subgroup = "space-platform",
    enabled = false,
    energy_required = 15,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },    --#9e1725
        secondary = { r = 1, g = 0.767, b = 0.605, a = 1 },        -- #ffc39aff
        tertiary = { r = 1, g = 0.649, b = 0.542, a = 1 },         -- #ffa58aff
        quaternary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 }, --#9e1725
    },
    ingredients = {
        { type = "fluid", name = "thruster-fuel",  amount = 10000 },
        { type = "item",  name = "cubeine-powder", amount = 10 },
    },
    results = {
        { type = "fluid", name = "cubeine-fuel", amount = 10000 },
    },
    category = mods["maraxsis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "cubeine-fuel",
    allow_productivity = false

}

data:extend({ recipe, fuel })

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-thruster",

        icons = {
            {
                icon = "__lilys-cubeine__/graphics/technology/space-platform-thruster-1.png",
                icon_size = 256,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            }

        },
        prerequisites = { "cubeine-solution", "agricultural-science-pack", "metallurgic-science-pack" },

        unit = {
            count = 2000,
            ingredients =
            {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "chemical-science-pack",     1 },
                { "production-science-pack",   1 },
                { "agricultural-science-pack", 1 },
                { "metallurgic-science-pack",  1 }
            },
            time = 60

        },

        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-thruster"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-fuel-mixing"
            }
        }
    }
})
