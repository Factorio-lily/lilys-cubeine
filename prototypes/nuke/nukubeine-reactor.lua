local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
require("nukubeine-reactor-pictures")
--require("__base__.prototypes.entity.pipecovers")
--require("__base__.circuit-connector-sprites")
--require("__base__.prototypes.entity.entity-util")

local heated_pipes_tint = { 0.75, 0.2, 0.1, 0.75 }
local heat_glow_tint = { 1, 0.6, 0.6, 1 }

apply_heat_pipe_glow = function(layer)
  layer.tint = heated_pipes_tint
  local light_layer = util.copy(layer)
  light_layer.draw_as_light = true
  light_layer.tint = heat_glow_tint
  return
  {
    layers =
    {
      layer,
      light_layer
    }
  }
end



local reactor = {
    type = "reactor",
    name = "nukubeine-reactor",
    icon  = "__lilys-cubeine__/graphics/entity/reactor/research-center-icon.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "nukubeine-reactor"},
    fast_replaceable_group = "reactor",
    max_health = 5000,
    resistances =
    {
      {
        type = "fire",
        percent = 99
      }, 
      {
        type = "physical",
        percent = 60
      }, 
      {
        type = "poison",
        percent = 100
      }, 
      {
        type = "explosion",
        percent = 60
      }
    },

    surface_conditions = {
        {property = "pressure", min = 1},
        {property = "magnetic-field", max = 200 }
    },
    heating_energy = "1W",
    neighbour_bonus = 0,
    corpse = "nuclear-reactor-remnants",
    dying_explosion = "nuclear-reactor-explosion",
    consumption = "1GW",
    energy_source =
    {
      type = "burner",
      fuel_categories = {"cubic"},
      emissions_per_minute = {pollution = 10},
      effectivity = 1,
      fuel_inventory_size = 1,
      burnt_inventory_size = 1,
      light_flicker =
      {
        color = {1,0.01,0.1},
        minimum_intensity = 0.7,
        maximum_intensity = 0.95
      }
    },
    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    damaged_trigger_effect = hit_effects.entity(),
    light  = {
      intensity = 0.5,
      size = 40,
      color = {
        r = 1.00,
        g = 0.01,
        b = 0.2,
        a = 1
      }
    },
    lower_layer_picture  =
    {
      layers = {
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
        width = 320,
        height = 316,
        scale = 0.5,
        shift = { 2, 2},
        tint = {1, 0.6, 0.6, 1}
      },
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
        width = 320,
        height = 316,
        scale = 0.5,
        shift = { -2, 2 },
        tint = {1, 0.6, 0.6, 1}
      },
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
        width = 320,
        height = 316,
        scale = 0.5,
        shift = {2.1, -2.2},
      tint = { 1, 0.6, 0.6, 1 }
      },
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
        width = 320,
        height = 316,
        scale = 0.5,
        shift = { -2.1, -2.2 },
      tint = { 1, 0.6, 0.6, 1 }
      },
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
        width = 320,
        height = 316,
        scale = 0.5,
        shift = { 0, -2.2 },
        tint = { 1, 0.6, 0.6, 1 }
      },
    }
    },
    heat_lower_layer_picture = 
    {
      layers = {
    apply_heat_pipe_glow {
          filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes-heated.png",
          width = 320,
          height = 316,
          scale = 0.5,
          shift = { 2, 2 },
          tint = { 1, 0.6, 0.6, 1 }
      },
    apply_heat_pipe_glow {
          filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes-heated.png",
          width = 320,
          height = 316,
          scale = 0.5,
          shift = { -2, 2 },
          tint = { 1, 0.6, 0.6, 1 }
        },
    apply_heat_pipe_glow{
      filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes-heated.png",
      width = 320,
      height = 316,
      scale = 0.5,
      shift = { 2.1, -2.2 },
      tint = { 1, 0.6, 0.6, 1 }
    },
    apply_heat_pipe_glow {
      filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes-heated.png",
      width = 320,
      height = 316,
      scale = 0.5,
      shift = { -2.1, -2.2 },
      tint = { 1, 0.6, 0.6, 1 }
    },
      apply_heat_pipe_glow {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes-heated.png",
        width = 320,
        height = 316,
        scale = 0.5,
        shift = { 0, -2.2 },
        tint = { 1, 0.6, 0.6, 1 }
      },
  }
    },

  connection_patches_connected         =
  {
    sheet =
    {
      filename = "__lilys-cubeine__/graphics/entity/reactor/reactor-connect-patches-large.png",
      width = 64,
      height = 64,
      variation_count = 21,
      scale = 0.5,
      tint = { 1, 0.6, 0.6, 1 }
    }
  },

  connection_patches_disconnected      =
  {
    sheet =
    {
      filename = "__lilys-cubeine__/graphics/entity/reactor/reactor-connect-patches-large.png",
      width = 64,
      height = 64,
      variation_count = 21,
      y = 64,
      scale = 0.5,
      tint = { 1, 0.6, 0.6, 1 }
    }
  },

  heat_connection_patches_connected    =
  {
    sheet = apply_heat_pipe_glow
        {
          filename = "__lilys-cubeine__/graphics/entity/reactor/reactor-connect-patches-heated-large.png",
          width = 64,
          height = 64,
          variation_count = 21,
          scale = 0.5,
          tint = { 1, 0.6, 0.6, 1 }
        }
  },

  heat_connection_patches_disconnected =
  {
    sheet = apply_heat_pipe_glow
        {
          filename = "__lilys-cubeine__/graphics/entity/reactor/reactor-connect-patches-heated-large.png",
          width = 64,
          height = 64,
          variation_count = 21,
          y = 64,
          scale = 0.5,
          tint = { 1, 0.6, 0.6, 1 }
        }
  },


  
    picture =
    { 
      layers =
      {
      {
        filename = "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-animation-1.png",
        width = 590,
        height = 640,
        scale = 0.5,
        shift = { 0, -0.5 },
        --tint = { 0.5, 0.5, 0.5, 0.5 }
        --shift = util.by_pixel(-5, -7)
      },
        {
          filename = "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-shadow.png",
          width = 1200,
          height = 700,
          scale = 0.5,
          shift = { 0, -0.5 },
          draw_as_shadow = true
        }
      }
    },

    --[[working_light_picture =
    {
    filenames = {
      "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-emission-1.png",
      "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-emission-2.png"
    },
    lines_per_file = 8,
      blend_mode = "additive",
    line_length = 8,
    frame_count = 80,
    animation_speed = 0.5,
      draw_as_glow = true,
        width = 590,
        height = 640,
        scale = 0.5,
        shift = { 0, -0.5 },
        tint = {1, 0, 1, 1}
      --shift = { -0.03125, -0.1875 },
    },--]]

    heat_buffer =
    {
      max_temperature = 3000,
      specific_heat = "200MJ",
      max_transfer = "100GW",
      minimum_glow_temperature = 350,
    connections =
    {
      {
        position = { -4.0, -4.0 },
        direction = defines.direction.north
      },
      {
        position = { -2.0, -4.0 },
        direction = defines.direction.north
      },
      {
        position = { 0, -4.0 },
        direction = defines.direction.north
      },
      {
        position = { 2.0, -4.0 },
        direction = defines.direction.north
      },
      {
        position = { 4.0, -4.0 },
        direction = defines.direction.north
      },
      {
        position = { 0, 1 },
        direction = defines.direction.north --internal
      },
      {
        position = { 4, -4 },
        direction = defines.direction.east
      },
      {
        position = { 4, -2 },
        direction = defines.direction.east
      },
      {
        position = { 4, 0 },
        direction = defines.direction.east
      },
      {
        position = { 4, 2 },
        direction = defines.direction.east
      },
      {
        position = { 4, 4 },
        direction = defines.direction.east
      },
      {
        position = { -4, 4 },
        direction = defines.direction.south
      },
      {
        position = { -2, 4 },
        direction = defines.direction.south
      },
      {
        position = { 0, 4 },
        direction = defines.direction.south
      }, 
      {
      position = { 2, 4 },
      direction = defines.direction.south
      }, 
      {
      position = { 4, 4 },
      direction = defines.direction.south
      },
      {
        position = { -4, -4 },
        direction = defines.direction.west
      },
      {
        position = { -4, -2 },
        direction = defines.direction.west
      },
      {
        position = { -4, 0 },
        direction = defines.direction.west
      }, 
      {
      position = { -4, 2 },
      direction = defines.direction.west
      }, 
      {
        position = { -4, 4 },
        direction = defines.direction.west
      },
      --[[{
      position = { -1, 0 },
      direction = defines.direction.east --internal
      },
      {
        position = { 0, 1 },
        direction = defines.direction.west --internal
      },
      {
        position = { 0, -1 },
        direction = defines.direction.south --internal
      },
      {
        position = { 0, 1 },
        direction = defines.direction.north --internal
      },--]]
    },
      --[[heat_picture = {
        filename = "__lilys-cubeine__/graphics/entity/reactor/research-center-hr-emission-1.png",
        mode = "additive-soft",
        tint = {1, 0.4, 0.1, 1},
      render_layer = "higher-object-above",
      width = 590,
      height = 640,
      draw_as_glow = true
      }--]]
    },
    impact_category            = "metal-large",
    open_sound                 = { filename = "__base__/sound/open-close/nuclear-open.ogg", volume = 0.8 },
    close_sound                = { filename = "__base__/sound/open-close/nuclear-close.ogg", volume = 0.8 },
    working_sound              =
    {
---@diagnostic disable-next-line: undefined-global
        sound = sound_variations("__base__/sound/nuclear-reactor", 2, 0.55, volume_multiplier("main-menu", 0.8)),
        max_sounds_per_prototype = 3,
        fade_in_ticks = 4,
        fade_out_ticks = 20
    },

    meltdown_action =
    {
      data.raw["projectile"]["atomic-rocket"].action,
      {
        type = "cluster",
        cluster_count = 32,
        distance = 60,
        distance_deviation = 160,
        action_delivery = {
          type = "projectile",
          projectile = "nukubeine-boom-shard",
          starting_speed_deviation = 0.4,
          starting_speed = 0.5
        }
      }
  
    },

    default_temperature_signal = { type = "virtual", name = "signal-T" },
    circuit_wire_max_distance  = reactor_circuit_wire_max_distance * 2,
    circuit_connector          = circuit_connector_definitions["nuclear-reactor"],
    
}


local item = {

    type = "item",
    name = "nukubeine-reactor",
    icons = { 
        {
            icon = "__lilys-cubeine__/graphics/entity/reactor/research-center-icon.png",
            icon_size = 64,
            tint = { 1, 0.8, 0.8, 1 },
        },
        {
          icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
          icon_size = 64,
          scale = 0.25,
          shift = { 6, 6 }
        }
   },
    place_result = "nukubeine-reactor",
    subgroup = "energy",
    order = "z[cubic-energy]-a[reactor]",
    inventory_move_sound = item_sounds.reactor_inventory_move,
    pick_sound = item_sounds.reactor_inventory_pickup,
    drop_sound = item_sounds.reactor_inventory_move,
    stack_size = 1,
    default_import_location = "nauvis",
    weight = 1000 * kg,
}

local pipe = table.deepcopy(data.raw["heat-pipe"]["heat-pipe"])
pipe.name = "cubeine-heat-pipe"
pipe.minable.result = "cubeine-heat-pipe"

pipe.icons = {
  {
    icon = pipe.icon,
    icon_size = 64,
    tint = {1, 0.6, 0.6, 1}
  }, 
  {
    icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
    icon_size = 64,
    scale = 0.25,
    shift = { 6, 6 }
  }
}
pipe.icon = nil
pipe.max_health = 500
pipe.heat_buffer =
{
  max_temperature = 2000,
  specific_heat = "2MJ",
  max_transfer = "20GW",
  minimum_glow_temperature = 350,
  connections =
  {
    {
      position = { 0, 0 },
---@diagnostic disable-next-line: assign-type-mismatch
      direction = defines.direction.north
    },
    {
      position = { 0, 0 },
---@diagnostic disable-next-line: assign-type-mismatch
      direction = defines.direction.east
    },
    {
      position = { 0, 0 },
---@diagnostic disable-next-line: assign-type-mismatch
      direction = defines.direction.south
    },
    {
      position = { 0, 0 },
---@diagnostic disable-next-line: assign-type-mismatch
      direction = defines.direction.west
    }
  }
}
pipe.heating_radius = 2

for _, res in ipairs(pipe.resistances) do
  if res.type == "fire" then
    res.percent = 100
  end
end




for name, array in pairs(pipe.connection_sprites) do
  for _, sprite in ipairs(array) do
    sprite.tint = {1, 0.6, 0.6, 1}
  end  
end

for name, array in pairs(pipe.heat_glow_sprites) do
  for _, sprite in ipairs(array) do
    if sprite.layers then
      sprite.layers[1].tint = {0.75, 0.2, 0.1, 0.75}
      sprite.layers[2].tint = {1, 0.6, 0.6, 1 }
    else
      sprite.tint = { 1, 0.6, 0.6, 1 }
    end
  end
end




local pipe_item = {
  type = "item",
  name = "cubeine-heat-pipe",
  icons = {
    {
      icon = "__base__/graphics/icons/heat-pipe.png",
      icon_size = 64,
      tint = { 1, 0.6, 0.6, 1 }
    },
    {
      icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
      icon_size = 64,
      scale = 0.25,
      shift = { 6, 6 }
    }
  },
  subgroup = "energy",
  order = "z[cubic-energy]-b[heat-pipe]",
  inventory_move_sound = item_sounds.metal_small_inventory_move,
  pick_sound = item_sounds.metal_small_inventory_pickup,
  drop_sound = item_sounds.metal_small_inventory_move,
  place_result = "cubeine-heat-pipe",
  stack_size = 50,
  weight = 40 * kg,
}


--recipe
local recipe = {

    type = "recipe",
    name = "nukubeine-reactor",
    subgroup = "energy",
    enabled = false,
    energy_required = 120,
    emissions_multiplier = 10,
    ingredients = {
        { type = "item", name = "tungsten-plate",  amount = 500 },
        { type = "item", name = "tungsten-carbide",  amount = 500 },
        { type = "item",  name = "cubeine-crystal", amount = 100 },
        { type = "item",  name = "carbon-fiber", amount = 100 },
        { type = "item",  name = "quantum-processor", amount = 100 },
        { type = "fluid",  name = "cubeine-solution",     amount = 10000 },
        { type = "fluid",  name = "fluoroketone-cold",   amount = 10000},
        { type = "fluid",  name = "lubricant",   amount = 10000},
    },
    results = {
        { type = "item", name = "nukubeine-reactor", amount = 1 },
    },
    category = "cryogenics",
    main_product = "nukubeine-reactor",
    allow_productivity = false,
    --preserve_products_in_machine_output = true,
    order = "nk[nukubeine]-a[reactor]",
    --hide_from_signal_gui = false
}

--recipe
local pipe_recipe = {

  type = "recipe",
  name = "cubeine-heat-pipe",
  enabled = false,
  energy_required = 10,
  emissions_multiplier = 1,
  ingredients = {
    { type = "item",  name = "heat-pipe",    amount = 10 },
    { type = "item",  name = "tungsten-plate",    amount = 10 },
    { type = "item",  name = "tungsten-carbide",  amount = 10 },
    { type = "item",  name = "cubeine-crystal",   amount = 1 },
    { type = "item",  name = "carbon-fiber",      amount = 10 },
    { type = "fluid", name = "cubeine-solution",  amount = 100 },
    { type = "fluid", name = "fluoroketone-cold", amount = 100 },
    { type = "fluid", name = "lubricant",         amount = 100 },
  },
  results = {
    { type = "item", name = "cubeine-heat-pipe", amount = 1 },
  },
  category = "cryogenics",
  allow_productivity = false,
  --preserve_products_in_machine_output = true,
  order = "nk[nukubeine]-b[heat-pipe]",
  --hide_from_signal_gui = false
}



data:extend({reactor, item, recipe, pipe, pipe_item, pipe_recipe})

-- technology
data:extend({
    {
        type = "technology",
        name = "nukubeine-reactor",
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/entity/reactor/research-center-icon-big.png",
                icon_size = 640,
                --scale = 640/256,
            }
        },
        prerequisites = { "nukubeine-production", "fusion-reactor" },

        unit = {
            count = 10000,
            ingredients =
            {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "chemical-science-pack",     1 },
                { "production-science-pack",   1 },
                { "utility-science-pack",   1 },
                { "metallurgic-science-pack", 1 },
                { "agricultural-science-pack", 1 },
                { "electromagnetic-science-pack", 1 },
                { "cryogenic-science-pack", 1 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "nukubeine-reactor"
            },
            {
              type = "unlock-recipe",
              recipe = "cubeine-heat-pipe"
            },
        }
    }
})


for i = 1, 80, 1 do
  data:extend({{
    type = "heat-pipe",
    name = "nukubeine-reactor-vhp-"..i,
    max_health = 10000000,
    heating_radius = i,
    hidden = true,
    collision_mask = { layers = {} },
    collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
    selection_box = { { 0, 0 }, { 0, 0 } },
    fast_replaceable_group = "vhp",
    heat_buffer = {
      max_temperature = 3000,
      specific_heat = "50MJ",
      max_transfer = "50GW",
      minimum_glow_temperature = 350,
      connections =
      {
        {
          position = { 0, 0 },
          ---@diagnostic disable-next-line: assign-type-mismatch
          direction = defines.direction.north
        },
        {
          position = { 0, 0 },
          ---@diagnostic disable-next-line: assign-type-mismatch
          direction = defines.direction.east
        },
        {
          position = { 0, 0 },
          ---@diagnostic disable-next-line: assign-type-mismatch
          direction = defines.direction.south
        },
        {
          position = { 0, 0 },
          ---@diagnostic disable-next-line: assign-type-mismatch
          direction = defines.direction.west
        }
      }
    }
  },
  {
      type = "lamp",
      name = "nukubeine-reactor-vlt-" .. i,
      collision_mask = { layers = {} },
      max_health = 10000000,
      flags = { "not-on-map", "placeable-off-grid" },
      light = {
        intensity = 1 + 0.1 * i,
        size = i * 4,
        color = {
          r = 1.00,
          g = 0.5,
          b = 0.2,
          a = 1
        }
      },
      fast_replaceable_group = "vlt",
      energy_usage_per_tick = "1kJ",
      energy_source = { type = "void" },
      collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
      selection_box = { { 0, 0 }, { 0, 0 } },
      always_on = true,
      hidden = true
  }
})
end
