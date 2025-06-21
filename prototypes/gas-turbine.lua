require("util")

function make_rotated_animation_variations_from_sheet(variation_count, sheet) --makes remnants work with more than 1 variation
    local result = {}

    local function set_y_offset(variation, i)
        local frame_count = variation.frame_count or 1
        local line_length = variation.line_length or frame_count
        if (line_length < 1) then
            line_length = frame_count
        end

        local height_in_frames = math.floor((frame_count * variation.direction_count + line_length - 1) / line_length)
        -- if (height_in_frames ~= 1) then
        --   log("maybe broken sheet: h=" .. height_in_frames .. ", vc=" .. variation_count .. ", " .. variation.filename)
        -- end
        variation.y = variation.height * (i - 1) * height_in_frames
    end

    for i = 1, variation_count do
        local variation = util.table.deepcopy(sheet)

        if variation.layers then
            for _, layer in pairs(variation.layers) do
                set_y_offset(layer, i)
            end
        else
            set_y_offset(variation, i)
        end

        table.insert(result, variation)
    end
    return result
end


local emissive_tint = { r = 1, g = 0.2, b = 0.2, a = 1 }


local base_tint = { r = 1, g = 0.6, b = 0.7, a = 1 }

local pipe_picture = table.deepcopy(require("__space-age__.prototypes.entity.electromagnetic-plant-pictures")
    .pipe_pictures)
for _, pic in pairs(pipe_picture or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end
local pipe_covers = table.deepcopy(pipecoverspictures())
for _, pic in pairs(pipe_covers or {}) do
    if not pic.layers then
        pic.tint = base_tint
    else
        pic.layers[1].tint = base_tint
    end
end


data.extend({
    {
        type = "corpse",
        name = "cubeine-turbine-remnants",
        icon = "__lilys-cubeine__/graphics/icons/gas-turbine.png",
        flags = { "placeable-neutral", "not-on-map" },
        hidden_in_factoriopedia = true,
        subgroup = "energy-remnants",
        order = "a-h-a",
        selection_box = { { -1.5, -2.5 }, { 1.5, 2.5 } },
        tile_width = 3,
        tile_height = 5,
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15, -- 15 minutes
        expires = false,
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = make_rotated_animation_variations_from_sheet(1,
            {
                filename = "__lilys-cubeine-asset-pack__/graphics/entity/steam-turbine/remnants/steam-turbine-remnants.png",
                line_length = 1,
                width = 460,
                height = 408,
                direction_count = 4,
                shift = util.by_pixel(6, 0),
                scale = 0.5
            })
    },
})


local item1 = table.deepcopy(data.raw["item"]["steam-turbine"])
item1.order = "e[energy]-x[gas-turbine]"
item1.name = "lilys-gas-turbine"
item1.place_result = "lilys-gas-turbine"
item1.icons = {
    {
        icon = "__base__/graphics/icons/steam-turbine.png",
        icon_size = 64,
    },
    {
        icon = "__base__/graphics/icons/fluid/petroleum-gas.png",
        icon_size = 64,
        scale = 0.25,
        shift = { -6, -6 }
        --tint = { 0.7, 0.7, 0.7, 0.7 }
    },

}
local entity1 = table.deepcopy(data.raw["generator"]["steam-turbine"])
entity1.name = "lilys-gas-turbine"
entity1.minable.result = "lilys-gas-turbine"
entity1.effectivity = 2
entity1.burns_fluid = true
entity1.fluid_box.filter = "petroleum-gas"
entity1.fluid_box.minimum_temperature = nil
entity1.icons = table.deepcopy(item1.icons)
entity1.scale_fluid_usage = true
entity1.fluid_usage_per_tick = entity1.fluid_usage_per_tick / 5
entity1.max_power_output = "7.2MW"
entity1.smoke[1].name = "lilys-gas-turbine-smoke"
entity1.energy_source.emissions_per_minute = { ["pollution"] = 5 }
entity1.surface_conditions = {
    {
        property = "pressure",
        min = 800
    }
}


local smoke1 = table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"])
smoke1.name = "lilys-gas-turbine-smoke"
smoke1.color = { 0.1, 0.1, 0.1, 0.3 }



local item2 = table.deepcopy(data.raw["item"]["steam-turbine"])
item2.order = "e[energy]-y[cubeine-gas-turbine]"
item2.name = "cubeine-gas-turbine"
item2.place_result = "cubeine-gas-turbine"
item2.icons = {
    {
        icon = "__lilys-cubeine__/graphics/icons/gas-turbine.png",
        icon_size = 64,
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/fluid/cubonium-gas.png",
        icon_size = 64,
        scale = 0.25,
        shift = { -6, -6 }
        --tint = { 0.7, 0.7, 0.7, 0.7 }
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 6, 6 }
    }
}
local entity2 = table.deepcopy(data.raw["generator"]["steam-turbine"])
entity2.name = "cubeine-gas-turbine"
entity2.max_health = 600
entity2.minable.result = "cubeine-gas-turbine"
entity2.corpse = "cubeine-turbine-remnants"
entity2.effectivity = 2
entity2.burns_fluid = true
entity2.fluid_box.pipe_covers = pipe_covers
entity2.fluid_box.filter = "cubonium-gas"
entity2.fluid_box.minimum_temperature = nil
entity2.icons = table.deepcopy(item2.icons)
entity2.scale_fluid_usage = true
entity1.fluid_usage_per_tick = entity2.fluid_usage_per_tick / 5
entity2.max_power_output = "36MW"
entity2.horizontal_animation.layers[1].filename = 
"__lilys-cubeine-asset-pack__/graphics/entity/steam-turbine/steam-turbine-H.png"
entity2.vertical_animation.layers[1].filename =
"__lilys-cubeine-asset-pack__/graphics/entity/steam-turbine/steam-turbine-V.png"
--[[entity2.horizontal_animation =
    {
      layers =
      {
        {
          filename = "__lilys-cubeine-asset-pack__/graphics/entity/steam-turbine/steam-turbine-H.png",
          width = 320,
          height = 245,
          frame_count = 8,
          line_length = 4,
          shift = util.by_pixel(0, -2.75),
          run_mode = "backward",
          scale = 0.5
        },
        {
          filename = "__lilys-cubeine-asset-pack__/graphics/entity/steam-turbine/steam-turbine-H-shadow.png",
          width = 435,
          height = 150,
          repeat_count = 8,
          line_length = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(28.5, 18),
          run_mode = "backward",
          scale = 0.5
        }
      }
    }
entity2.vertical_animation =
    {
     layers =
     {
        {
          filename = "__lilys-cubeine-asset-pack__/graphics/entity/steam-turbine/steam-turbine-V.png",
          width = 217,
          height = 347,
          frame_count = 8,
          line_length = 4,
          shift = util.by_pixel(4.75, -32),
          run_mode = "backward",
          scale = 0.5
        },
        {
          filename = "__lilys-cubeine-asset-pack__/graphics/entity/steam-turbine/steam-turbine-V-shadow.png",
          width = 302,
          height = 260,
          repeat_count = 8,
          line_length = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(39.5, 24.5),
          run_mode = "backward",
          scale = 0.5
        }
      }
    }
    --]]
--entity2.horizontal_animation.layers[1].tint = base_tint
--entity2.vertical_animation.layers[1].tint = base_tint
entity2.smoke[1].name = "cubeine-gas-turbine-smoke"
entity2.energy_source.emissions_per_minute = { ["pollution"] = 10 }
--[[entity2.surface_conditions = {
    {
        property = "pressure",
        min = 300
    }
}--]]


local smoke2 = table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"])
smoke2.name = "cubeine-gas-turbine-smoke"
smoke2.color = { 0.3, 0.1, 0.1, 0.4 }


---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ item1, entity1, smoke1, item2, entity2, smoke2, })


data:extend({
    {
        type = "recipe",
        name = "lilys-gas-turbine",
        enabled = false,
        energy_required = 6,
        category = "crafting-with-fluid",
        ingredients = {
            { type = "item",  name = "iron-gear-wheel", amount = 50 },
            { type = "item",  name = "copper-plate",    amount = 50 },
            { type = "item",  name = "pipe",            amount = 20 },
            { type = "item",  name = "steel-plate",     amount = 100 },
            { type = "fluid", name = "lubricant",       amount = 500 },
        },
        results = { { type = "item", name = "lilys-gas-turbine", amount = 1 } }
    },
    {
        type = "recipe",
        name = "cubeine-gas-turbine",
        enabled = false,
        energy_required = 18,
        ingredients = {
            { type = "item", name = "lilys-gas-turbine",     amount = 1 },
            { type = "item", name = "low-density-structure", amount = 50 },
            { type = "item", name = "cubeine-crystal",       amount = 5 } },
        results = { { type = "item", name = "cubeine-gas-turbine", amount = 1 } }
    },
    {
        type = "technology",
        name = "cubeine-gas-turbine",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/gas-turbine.png",
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/gas-turbine.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/fluid/cubonium-gas.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, -48 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            } },
        prerequisites = { "cubonium-gas" },

        unit = {
            count = 3000,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },

                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 },
                { "space-science-pack",      1 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "lilys-gas-turbine"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-gas-turbine"
            },
        }
    }
})
