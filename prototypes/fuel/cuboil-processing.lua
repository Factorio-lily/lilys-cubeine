data:extend({
    {
        type = "recipe",
        name = "cuboil",
        enabled = false,
        energy_required = 10,
        emissions_multiplier = 10,
        category = (mods["Age-of-Production"] and "petrochemistry-or-oil-processing" or "oil-processing"),
        ingredients = {
            { type = "fluid", name = "light-oil", amount = 50 },
            { type = "fluid", name = "heavy-oil", amount = 250 },
            { type = "item", name = "cubeine-powder", amount = 10 },
        },
        results = {
            { type = "fluid", name = "cuboil", amount = 300 },
        },
        allow_productivity = true,
        allow_quality = true,
        hide_from_signal_gui = false,
        show_amount_in_title = false,
        --order = "n[cubeine]-n[fuel]-a[cuboil]"
    },
    {
        type = "technology",
        name = "cuboil",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/fluid/cuboil.png",
        prerequisites = { "cubeine-cut-fuel" },

        unit = {
            count = 500,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },

                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
            },
            time = 30

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cuboil"
            },
        }
    }
})

