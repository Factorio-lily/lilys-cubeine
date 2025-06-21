

--recipe
local hot = {

    type = "recipe",
    name = "cubeine-crystal-forging",
    subgroup = "cubeine-processes",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-red.png",
            icon_size = 64,
            tint = {0.9, 0.9, 0.9, 0.9}
        }
    },
    enabled = false,
    energy_required = 60,
    emissions_multiplier = 10,
    ingredients = {
        { type = "fluid", name = "pure-cubeplant-fluid", amount = 50 },
        { type = "item",  name = "cubeine-powder",       amount = 10},
        { type = "item",  name = "calcite",       amount = 10},
        { type = "fluid", name = "water",                amount = 1000, },
    },
    results = {
        { type = "item", name = "cubeine-crystal", amount = 1 },
        { type = "fluid", name = "steam", amount = 9001, temperature = 165, ignored_by_productivity = 10000 },
    },
    category = "metallurgy",
    --main_product = "cubeine-crystal",
    allow_productivity = true,
    order = "n[cubeine]-c[crystal-forging]",
    hide_from_signal_gui = false,
    crafting_machine_tint = {
        primary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },     --#ff2b2b
        secondary = { r = 1, g = 0.067, b = 0.067, a = 1.000 },   --#ff1111
        tertiary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },     --#ff2b2b
        quaternary = { r = 1, g = 0.067, b = 0.067, a = 1.000 },   --#ff1111
    },
}

--recipe
local cold = {

    type = "recipe",
    name = "cubeine-crystal-cryoforging",
    subgroup = "cubeine-processes",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-blue.png",
            icon_size = 64,
            tint = { 0.9, 0.9, 0.9, 0.9 }
        }
    },
    enabled = false,
    energy_required = 30,
    emissions_multiplier = 1,
    ingredients = {
        { type = "fluid", name = "pure-cubeplant-fluid", amount = 50 },
        { type = "item",  name = "cubeine-powder",       amount = 8 },
        { type = "item", name = "calcite",              amount = 2 },
        { type = "fluid",  name = "fluoroketone-cold",   amount = 4000, ignored_by_stats = 3500},
        { type = "fluid", name = "water",    amount = 4000},
    },
    results = {
        { type = "item", name = "cubeine-crystal", amount = 1 },
        { type = "item",  name = "ice",  amount = 80 },
        { type = "fluid", name = "fluoroketone-hot", amount = 3500, ignored_by_stats = 3500, ignored_by_productivity = 3500 },
    },
    category = "cryogenics",
    --main_product = "cubeine-crystal",
    allow_productivity = true,
    order = "n[cubeine]-d[crystal-cryoforging]",
    hide_from_signal_gui = false,
    crafting_machine_tint = {
        primary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },     --#ff2b2b
        secondary = { r = 1, g = 0.067, b = 0.067, a = 1.000 },   --#ff1111
        tertiary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },     --#ff2b2b
        quaternary = { r = 1, g = 0.067, b = 0.067, a = 1.000 },   --#ff1111
    },
}

data:extend { hot, cold }
