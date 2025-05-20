

--recipe
local fuel = {
    type = "recipe",
    name = "liquid-cubonium",
    --subgroup = "space-platform",
    enabled = false,
    energy_required = 5,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },     --#9e1725
        secondary = { r = 0.937, b = 0.335, g = 0.496, a = 1.000 }, --#f0567f
        tertiary = { r = 0.898, g = 0.261, b = 0.535, a = 1.000 },  --#e64389
        quaternary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },  --#9e1725
    },
    ingredients = {
        { type = "fluid", name = "cubonium-gas",      amount = 1000 },
        { type = "fluid", name = "fluoroketone-cold", amount = 200, ignored_by_stats = 200 },
    },
    results = {
        { type = "fluid", name = "liquid-cubonium",  amount = 100, ignored_by_productivity = 10000 },
        { type = "fluid", name = "fluoroketone-hot", amount = 200, ignored_by_stats = 200 },
    },
    category = "cryogenics",
    main_product = "liquid-cubonium",
    allow_productivity = false

}

--recipe
local no_fuel = {
    type = "recipe",
    name = "liquid-cubonium-evaporation",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/fluid/liquid-cubonium.png",
            icon_size = 64
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/fluid/cubonium-gas.png",
            icon_size = 64,
            tint = { 0.8, 0.8, 0.8, 0.8 }
        }
    },
    --subgroup = "space-platform",
    enabled = false,
    energy_required = 5,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },     --#9e1725
        secondary = { r = 0.937, b = 0.335, g = 0.496, a = 1.000 }, --#f0567f
        tertiary = { r = 0.898, g = 0.261, b = 0.535, a = 1.000 },  --#e64389
        quaternary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },  --#9e1725
    },
    ingredients = {
        { type = "fluid", name = "liquid-cubonium", amount = 100 },
    },
    results = {
        { type = "fluid", name = "cubonium-gas", amount = 1000, ignored_by_productivity = 10000 },
    },
    category = "cryogenics",
    main_product = "cubonium-gas",
    allow_productivity = false

}

data:extend({ fuel, no_fuel })

-- technology
data:extend({
    {
        type = "technology",
        name = "liquid-cubonium",

        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/fluid/liquid-cubonium.png",
                icon_size = 64,
            }

        },
        prerequisites = { "cubonium-gas", "cryogenic-science-pack" },

        unit = {
            count = 5000,
            ingredients =
            {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "cryogenic-science-pack",       2 },
            },
            time = 60

        },

        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "liquid-cubonium"
            },
            {
                type = "unlock-recipe",
                recipe = "liquid-cubonium-evaporation"
            }
        }
    }
})
