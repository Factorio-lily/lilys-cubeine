--recipe
local recipe = {
    type = "recipe",
    name = "synthetic-cubeplant",
    subgroup = "cubeine-processes",
    enabled = false,
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/synthetic-cubeplant.png",
            icon_size = 64
        },
    },
    energy_required = 120,
    pollution_multiplier = 10,
    ingredients = {
        { type = "item",  name = "uranium-235",       amount = 20, },
        { type = "item",  name = "wood",              amount = 200, },
        { type = "fluid", name = "heavy-oil",         amount = 1000, },
        { type = "fluid", name = "fluoroketone-cold", amount = 1000, ignored_by_stats = 1000 },
    },
    results = {
        { type = "item",  name = "cubeplant-branch", amount = 40, },
        { type = "item",  name = "spoilage",         amount = 50 },
        { type = "fluid", name = "fluoroketone-hot", amount = 1000, ignored_by_stats = 1000, ignored_by_productivity = 10000 },
    },
    category = "cryogenics",
    main_product = "cubeplant-branch",
    allow_productivity = true,
    allow_quality = true,
    auto_recycle = false,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    result_is_always_fresh = true,
    preserve_products_in_machine_output = true,
    order = "n[cubeine]-s[synthesis]"
}
data:extend({ recipe })

-- technology
data:extend({
    {
        type = "technology",
        name = "synthetic-cubeplant",
        icon = "__lilys-cubeine__/graphics/icons/synthetic-cubeplant.png",
        icon_size = 64,
        prerequisites = { "biolab", "kovarex-enrichment-process", "cryogenic-science-pack" },

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
                recipe = "synthetic-cubeplant"
            }
        }
    }
})
