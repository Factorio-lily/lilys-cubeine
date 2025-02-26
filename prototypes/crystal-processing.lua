

--recipe
local hot = {

    type = "recipe",
    name = "cubeine-crystal-forging",
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
    pollution_multiplier = 10,
    ingredients = {
        { type = "fluid", name = "pure-cubeplant-fluid", amount = 50 },
        { type = "item",  name = "cubeine-powder",       amount = 10},
        { type = "item",  name = "calcite",       amount = 10},
        { type = "item",  name = "water",       amount = 1000,  },
    },
    results = {
        { type = "item", name = "cubeine-crystal", amount = 1 },
        { type = "fluid", name = "steam", amount = 9001, temperature = 165 },
    },
    category = "forging",
    main_product = "cubeine-crystal",
    allow_productivity = true

}

--recipe
local cold = {

    type = "recipe",
    name = "cubeine-crystal-cryoforging",
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
    pollution_multiplier = 1,
    ingredients = {
        { type = "fluid", name = "pure-cubeplant-fluid", amount = 50 },
        { type = "item",  name = "cubeine-powder",       amount = 8 },
        { type = "item", name = "calcite",              amount = 2 },
        { type = "fluid",  name = "fluoroketone-cold",   amount = 4000, ignored_by_stats = 3500},
    },
    results = {
        { type = "item", name = "cubeine-crystal", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 3500, ignored_by_stats = 3500 },
    },
    category = "cryogenics",
    main_product = "cubeine-crystal",
    allow_productivity = true

}

data:extend { hot, cold }
