data:extend({
    {
        type = "recipe",
        name = "glow-cubeplant-extraction",
        icons = { {
            icon = "__lilys-cubeine__/graphics/icons/cubeplant-branch.png",
            icon_size = 64,
        },
            {
                icon = "__lilys-cubeine__/graphics/icons/fluid/pure-cubeplant-fluid.png",
                icon_size = 64,
                scale = 0.25,
                shift = { 6, 6 }
            }, },
        category = "organic",
        subgroup = "cubeplant-processing",
        crafting_machine_tint = {
            primary = { r = 1.000, g = 0.235, b = 0.243, a = 1.000 }, -- #ffbba4ff
            secondary = { r = 1, g = 0.557, b = 0.490, a = 1.000 },   -- #bf8e7dff
            tertiary = { r = 1, g = 0.637, b = 0.637, a = 1.000 },    -- #a2a2a2ff
            quaternary = { r = 1, g = 0.283, b = 0.283, a = 1.000 },  -- #484848ff
        },
        allow_productivity = false,
        enabled = false,
        energy_required = 30,
        ingredients =
        {
            { type = "item", name = "cubeplant-branch-super", amount = 100 },
        },
        results = { { type = "item", name = "cubeplant-branch", amount = 100, ignored_by_productivity = 1000 },
            { type = "fluid", name = "pure-cubeplant-fluid", amount = 100 } }
    }
})

-- technology
data:extend({
    {
        type = "technology",
        name = "glow-cubeine-agriculture",
        icon_size = 256,
        icon = "__lilys-cubeine__/graphics/technology/cubeplant-processing-2.png",
        prerequisites = { "cubeplant-processing", "liquid-cubonium", "synthetic-cubeplant" },

        unit = {
            count = 10000,
            ingredients =
            {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "utility-science-pack",         1 },
                { "metallurgic-science-pack",     1 },
                { "agricultural-science-pack",    2 },
                { "electromagnetic-science-pack", 1 },
                { "cryogenic-science-pack",       2 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "glow-cubeplant-extraction"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeplant-flower-super"
            }
        }
    }
})
