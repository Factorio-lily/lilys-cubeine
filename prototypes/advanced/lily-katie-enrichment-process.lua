--recipe
local recipe = {
    type = "recipe",
    name = "lily-katie-enrichment-process",
    subgroup = "cubeine-processes",
    enabled = false,
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/l-k-enrichment.png",
            icon_size = 64
        },
    },
    energy_required = 240,
    pollution_multiplier = 10,
    ingredients = {
        { type = "item",  name = "nukubeine-crystal",    amount = 1,     ignored_by_stats = 1 },
        { type = "item",  name = "cubeplant-branch",     amount = 200, },
        { type = "fluid", name = "steam",                amount = 4000,  minimum_temperature = 500 },
        { type = "fluid", name = "pure-cubeplant-fluid", amount = 10000, ignored_by_stats = 1000 },
        { type = "fluid", name = "petroleum-gas",        amount = 4000,  ignored_by_stats = 2000 },
    },
    results = {
        { type = "item",  name = "nukubeine-crystal",    amount = 1,     ignored_by_stats = 1,     ignored_by_productivity = 100 },
        { type = "fluid", name = "pure-cubeplant-fluid", amount = 10200, ignored_by_stats = 10000, ignored_by_productivity = 10000 },
        { type = "fluid", name = "petroleum-gas",        amount = 2000,  ignored_by_stats = 2000,  ignored_by_productivity = 10000 },
        { type = "item",  name = "ice",                  amount = 100 },
        { type = "item",  name = "spoilage",             amount = 200 },
        { type = "fluid", name = "lubricant",            amount = 200 },
    },
    category = "cryogenics",
    main_product = "pure-cubeplant-fluid",
    crafting_machine_tint = {
        primary = { r = 1, g = 0.00, b = 0.0, a = 1.000 },           --#ff0000
        secondary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },    --#9e1725
        tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },     --#9e1725
        quaternary = { r = 0.655, g = 0.349, b = 0.459, a = 1.000 }, --#a75975
    },
    allow_productivity = true,
    allow_quality = true,
    auto_recycle = false,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    result_is_always_fresh = true,
    preserve_products_in_machine_output = true,
    order = "n[cubeine]-l-k[enrichment]"
}
data:extend({ recipe })

-- technology
data:extend({
    {
        type = "technology",
        name = "lily-katie-enrichment-process",
        icon = "__lilys-cubeine__/graphics/icons/l-k-enrichment.png",
        icon_size = 64,
        prerequisites = { "cubeine-purification", "nukubeine-production", "cryogenic-science-pack" },

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
                recipe = "lily-katie-enrichment-process"
            }
        }
    }
})
