local base_tint = { r = 1, g = 0.6, b = 0.6, a = 1 }

local function make_cubeine_version(item, entity)
    local i = table.deepcopy(item)
    i.name = "cubeine-" .. i.name
    i.localised_name = { "", { "mod-cube-strings.cubeine" }, { "entity-name." .. item.name } }
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
    p.localised_name = { "", { "mod-cube-strings.cubeine" }, { "entity-name." .. entity.name } }
    p.icons = table.deepcopy(i.icons)
    p.minable.result = "cubeine-" .. p.minable.result
    p.max_health = p.max_health * 5
    p.heating_energy = nil
    if not p.resistances then
        p.resistances = {}
    end
    local f = false
    local e = false
    for _, value in pairs(p.resistances or {}) do
        if value.type == "fire" then
            value.percent = 100
            f = true
        elseif value.type == "explosion" then
            value.percent = value.percent + (100 - value.percent) / 2
            value.decrease = (value.decrease or 0) + 100
            e = true
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
    if not e then
        table.insert(p.resistances, {
            type = "explosion",
            percent = 50,
            decrease = 100
        })
    end


    if (p.type == "pipe-to-ground") then
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
            if pic.layers then
                pic.layers[1].tint = base_tint
            elseif p.pictures.picture.sheets and #p.pictures.picture.sheets > 0 then
                pic[1].tint = base_tint
            else
                pic.tint = base_tint
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


local tank_i, tank = make_cubeine_version(data.raw.item["storage-tank"], data.raw["storage-tank"]["storage-tank"])
local tank_r = {
    type = "recipe",
    name = "cubeine-storage-tank",
    localised_name = { "", { "mod-cube-strings.cubeine" }, { "entity-name.storage-tank" } },
    enabled = false,
    energy_required = 10,
    pollution_multiplier = 1,
    ingredients = {
        { type = "item", name = "low-density-structure", amount = 20 },
        { type = "item", name = "cubeine-crystal",       amount = 5, },
        { type = "item", name = "storage-tank",          amount = 1 },
    },
    results = {
        { type = "item", name = "cubeine-storage-tank", amount = 1 },

    },
    category = "metallurgy-or-assembling",
    main_product = "cubeine-storage-tank",
    allow_productivity = false,
    allow_quality = true,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    order = "n[cubeine]-t[storage-tank]"
}

data:extend({ tank, tank_i, tank_r })

local tech = data.raw["technology"]["cubeine-fluid-handling"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "cubeine-storage-tank"
})


if mods["zithorian-extra-storage-tanks-port"] then
    local tank1_i, tank1 = make_cubeine_version(data.raw.item["fluid-tank-1x1"],
        data.raw["storage-tank"]["fluid-tank-1x1"])
    local tank1_r = {
        type = "recipe",
        name = "cubeine-fluid-tank-1x1",
        localised_name = { "", { "mod-cube-strings.cubeine" }, { "entity-name.fluid-tank-1x1" } },
        enabled = false,
        energy_required = 10,
        pollution_multiplier = 1,
        ingredients = {
            { type = "item", name = "low-density-structure", amount = 5 },
            { type = "item", name = "cubeine-crystal",       amount = 1, },
            { type = "item", name = "fluid-tank-1x1",        amount = 1 },
        },
        results = {
            { type = "item", name = "cubeine-fluid-tank-1x1", amount = 1 },

        },
        category = "metallurgy-or-assembling",
        main_product = "cubeine-fluid-tank-1x1",
        allow_productivity = false,
        allow_quality = true,
        hide_from_signal_gui = false,
        show_amount_in_title = false,
        order = "n[cubeine]-t[storage-tank]"
    }
    data.extend({ tank1, tank1_i, tank1_r })
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "cubeine-fluid-tank-1x1"
    })




    local tank2_i, tank2 = make_cubeine_version(data.raw.item["fluid-tank-2x2"],
        data.raw["storage-tank"]["fluid-tank-2x2"])
    local tank2_r = {
        type = "recipe",
        name = "cubeine-fluid-tank-2x2",
        localised_name = { "", { "mod-cube-strings.cubeine" }, { "entity-name.fluid-tank-2x2" } },
        enabled = false,
        energy_required = 10,
        pollution_multiplier = 1,
        ingredients = {
            { type = "item", name = "low-density-structure", amount = 15 },
            { type = "item", name = "cubeine-crystal",       amount = 2, },
            { type = "item", name = "fluid-tank-2x2",        amount = 1 },
        },
        results = {
            { type = "item", name = "cubeine-fluid-tank-2x2", amount = 1 },

        },
        category = "metallurgy-or-assembling",
        main_product = "cubeine-fluid-tank-2x2",
        allow_productivity = false,
        allow_quality = true,
        hide_from_signal_gui = false,
        show_amount_in_title = false,
        order = "n[cubeine]-t[storage-tank]"
    }
    data.extend({ tank2, tank2_i, tank2_r })
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "cubeine-fluid-tank-2x2"
    })



    local tank3_i, tank3 = make_cubeine_version(data.raw.item["fluid-tank-3x4"],
        data.raw["storage-tank"]["fluid-tank-3x4"])
    local tank3_r = {
        type = "recipe",
        name = "cubeine-fluid-tank-3x4",
        localised_name = { "", { "mod-cube-strings.cubeine" }, { "entity-name.fluid-tank-3x4" } },
        enabled = false,
        energy_required = 10,
        pollution_multiplier = 1,
        ingredients = {
            { type = "item", name = "low-density-structure", amount = 24 },
            { type = "item", name = "cubeine-crystal",       amount = 12, },
            { type = "item", name = "fluid-tank-3x4",        amount = 1 },
        },
        results = {
            { type = "item", name = "cubeine-fluid-tank-3x4", amount = 1 },

        },
        category = "metallurgy-or-assembling",
        main_product = "cubeine-fluid-tank-3x4",
        allow_productivity = false,
        allow_quality = true,
        hide_from_signal_gui = false,
        show_amount_in_title = false,
        order = "n[cubeine]-t[storage-tank]"
    }
    data.extend({ tank3, tank3_i, tank3_r })
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "cubeine-fluid-tank-3x4"
    })




    local tank4_i, tank4 = make_cubeine_version(data.raw.item["fluid-tank-5x5"],
        data.raw["storage-tank"]["fluid-tank-5x5"])
    local tank4_r = {
        type = "recipe",
        name = "cubeine-fluid-tank-5x5",
        localised_name = { "", { "mod-cube-strings.cubeine" }, { "entity-name.fluid-tank-5x5" } },
        enabled = false,
        energy_required = 10,
        pollution_multiplier = 1,
        ingredients = {
            { type = "item", name = "low-density-structure", amount = 40 },
            { type = "item", name = "cubeine-crystal",       amount = 20, },
            { type = "item", name = "fluid-tank-5x5",        amount = 1 },
        },
        results = {
            { type = "item", name = "cubeine-fluid-tank-5x5", amount = 1 },

        },
        category = "metallurgy-or-assembling",
        main_product = "cubeine-fluid-tank-5x5",
        allow_productivity = false,
        allow_quality = true,
        hide_from_signal_gui = false,
        show_amount_in_title = false,
        order = "n[cubeine]-t[storage-tank]"
    }
    data.extend({ tank4, tank4_i, tank4_r })
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "cubeine-fluid-tank-5x5"
    })
end
