local base_tint = { r = 1, g = 0.6, b = 0.6, a = 1 }

local function make_cubeine_version(item, entity)
    local i = table.deepcopy(item)
    i.name = "cubeine-" .. i.name
    i.localised_name = { "", { "mod-cube-strings.cubeine" }, " ", { "entity-name." .. entity.name } }
    i.icons = {
        {
            icon = i.icon,
            icon_size = i.icon_size,
            tint = base_tint
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
            scale = 0.25,
            shift = { 6, 6 }
        }
    }
    i.place_result = "cubeine-" .. i.place_result

    local p = table.deepcopy(entity)
    p.name = "cubeine-" .. p.name
    p.localised_name = { "", { "mod-cube-strings.cubeine" }, " ", { "entity-name." .. entity.name } }
    p.icons = table.deepcopy(i.icons)
    p.minable.result = "cubeine-" .. p.minable.result
    p.max_health = p.max_health * 2
    p.heating_energy = nil
    if not p.resistances then
        p.resistances = {}
    end
    local f = false
    for _, value in pairs(p.resistances or {}) do
        if value.type == "fire" then
            value.percent = 100
            f = true
        else
            value.decrease = (value.decrease or 0) + 10
            value.percent = math.min(100, (value.percent or 0) + 10)
        end
    end
    if not f then
        table.insert(p.resistances, {
            type = "fire",
            percent = 100
        })
    end


    if (p.type == "pipe-to-ground") then
        for _, conn in ipairs(p.fluid_box.pipe_connections) do
            if conn.connection_type == "underground" then
                conn.max_underground_distance = conn.max_underground_distance * 2
            end
        end
        for _, pic in pairs(p.pictures or {}) do
            if not pic.layers then
                pic.tint = base_tint
            else
                pic.layers[1].tint = base_tint
            end
        end
        for _, pic in pairs(p.fluid_box.pipe_covers or {}) do
            if not pic.layers then
                pic.tint = base_tint
            else
                pic.layers[1].tint = base_tint
            end
        end
    elseif p.type == "storage-tank" then
        for _, pic in pairs(p.pictures.picture or {}) do
            if not pic.layers then
                pic.tint = base_tint
            else
                pic.layers[1].tint = base_tint
            end
        end
        for _, pic in pairs(p.fluid_box.pipe_covers or {}) do
            if not pic.layers then
                pic.tint = base_tint
            else
                pic.layers[1].tint = base_tint
            end
        end
    elseif p.type == "pipe" then
        for key, pic in pairs(p.pictures or {}) do
            if not string.find(key, "frozen") and not string.find(key, "visualisation") then
                if string.find(key, "^straight") or string.find(key, "^corner") or string.find(key, "^t") or string.find(key, "^ending") or string.find(key, "^cross") then
                    if not pic.layers then
                        pic.tint = base_tint
                    else
                        pic.layers[1].tint = base_tint
                    end
                end
            end
        end
    end
    return i, p
end
local pipe_i, pipe = make_cubeine_version(data.raw.item.pipe, data.raw.pipe.pipe)
local pipe_to_ground_i, pipe_to_ground = make_cubeine_version(data.raw.item["pipe-to-ground"],
    data.raw["pipe-to-ground"]["pipe-to-ground"])

local pipe_r = {
    type = "recipe",
    name = "cubeine-pipe",
    enabled = false,
    energy_required = 5,
    pollution_multiplier = 1,
    ingredients = {
        { type = "item", name = "low-density-structure", amount = 1 },
        { type = "item", name = "cubeine-powder",        amount = 1, },
        { type = "item", name = "pipe",                  amount = 1 },
    },
    results = {
        { type = "item", name = "cubeine-pipe", amount = 1 },

    },
    category = "metallurgy-or-assembling",
    main_product = "cubeine-pipe",
    allow_productivity = false,
    allow_quality = true,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    order = "n[cubeine]-p[pipe]"
}

local pipe_to_ground_r = {
    type = "recipe",
    name = "cubeine-pipe-to-ground",
    enabled = false,
    energy_required = 5,
    pollution_multiplier = 1,
    ingredients = {
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "cubeine-powder",        amount = 2, },
        { type = "item", name = "cubeine-pipe",          amount = 20 },
    },
    results = {
        { type = "item", name = "cubeine-pipe-to-ground", amount = 1 },

    },
    category = "metallurgy-or-assembling",
    main_product = "cubeine-pipe-to-ground",
    allow_productivity = false,
    allow_quality = true,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    order = "n[cubeine]-p[pipe-to-ground]"
}
data:extend({ pipe, pipe_i, pipe_r, pipe_to_ground, pipe_to_ground_i, pipe_to_ground_r })


-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-fluid-handling",
        icons = {
            {
                icon = "__base__/graphics/technology/fluid-handling.png",
                tint = base_tint,
                icon_size = 256,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = { 48, 48 }
            }
        },
        icon_size = 64,
        prerequisites = { "cuboil" },

        unit = {
            count = 500,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },

                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-pipe",
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-pipe-to-ground",
            }
        }
    }
})


if mods["Flow Control"] then
    local pipe_straight_i, pipe_straight = make_cubeine_version(data.raw.item["pipe-straight"],
        data.raw["storage-tank"]["pipe-straight"])
    local pipe_elbow_i, pipe_elbow = make_cubeine_version(data.raw.item["pipe-elbow"],
        data.raw["storage-tank"]["pipe-elbow"])
    local pipe_junction_i, pipe_junction = make_cubeine_version(data.raw.item["pipe-junction"],
        data.raw["storage-tank"]["pipe-junction"])

    local pipe_straight_r = {
        type = "recipe",
        name = "cubeine-pipe-straight",
        enabled = false,
        energy_required = 1,
        pollution_multiplier = 1,
        ingredients = {
            { type = "item", name = "cubeine-pipe", amount = 1, },
        },
        results = {
            { type = "item", name = "cubeine-pipe-straight", amount = 1 },

        },
        main_product = "cubeine-pipe-straight",
        allow_productivity = false,
        allow_quality = false,
        hide_from_signal_gui = false,
        show_amount_in_title = false,
        order = "n[cubeine]-p[pipe-straight]"
    }

    local pipe_junction_r = {
        type = "recipe",
        name = "cubeine-pipe-junction",
        enabled = false,
        energy_required = 1,
        pollution_multiplier = 1,
        ingredients = {
            { type = "item", name = "cubeine-pipe", amount = 1, },
        },
        results = {
            { type = "item", name = "cubeine-pipe-junction", amount = 1 },

        },
        main_product = "cubeine-pipe-junction",
        allow_productivity = false,
        allow_quality = false,
        hide_from_signal_gui = false,
        show_amount_in_title = false,
        order = "n[cubeine]-p[pipe-junction]"
    }

    local pipe_elbow_r = {
        type = "recipe",
        name = "cubeine-pipe-elbow",
        enabled = false,
        energy_required = 1,
        pollution_multiplier = 1,
        ingredients = {
            { type = "item", name = "cubeine-pipe", amount = 1, },
        },
        results = {
            { type = "item", name = "cubeine-pipe-elbow", amount = 1 },

        },
        main_product = "cubeine-pipe-elbow",
        allow_productivity = false,
        allow_quality = false,
        hide_from_signal_gui = false,
        show_amount_in_title = false,
        order = "n[cubeine]-p[pipe-elbow]"
    }


    data:extend({ pipe_straight, pipe_straight_i, pipe_straight_r, pipe_junction, pipe_junction_i, pipe_junction_r,
        pipe_elbow, pipe_elbow_i,
        pipe_elbow_r })

    local tech = data.raw["technology"]["cubeine-fluid-handling"]
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "cubeine-pipe-straight"
    })
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "cubeine-pipe-junction"
    })
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "cubeine-pipe-elbow"
    })
end
