data:extend({
    {
        type = "recipe",
        name = "cubonium-gas",
        enabled = false,
        energy_required = 10,
        emissions_multiplier = 10,
        category = (mods["Age-of-Production"] and "petrochemistry-or-oil-processing" or "oil-processing"),
        ingredients = {
            { type = "fluid", name = "petroleum-gas", amount = 2000 },
            { type = "fluid", name = "cubeine-solution",  amount = 100 },
            { type = "item", name = "cubeine-powder", amount = 10 },
        },
        results = {
            { type = "fluid", name = "cubonium-gas", amount = 2000 },
        },
        allow_productivity = true,
        allow_quality = true,
        hide_from_signal_gui = false,
        show_amount_in_title = false,
        crafting_machine_tint = {
            primary = { r = 0.882, g = 0.6, b = 0.675, a = 1.000 }, --#e199ac
            secondary = { r = 0.655, g = 0.349, b = 0.459, a = 1.000 }, --#a75975
            tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 }, --#9e1725
            quaternary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 }, --#9e1725
        },
        --order = "n[cubeine]-n[fuel]-a[cuboil]"
    },
    {
        type = "technology",
        name = "cubonium-gas",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/fluid/cubonium-gas.png",
        prerequisites = { "cubeine-cut-fuel" },

        unit = {
            count = 1500,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },

                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
            },
            time = 30

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubonium-gas"
            },
        }
    }
})
