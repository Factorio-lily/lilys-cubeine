
--recipe
local purification = {
    type = "recipe",
    name = "cubeine-purification",
    subgroup = "agriculture-processes",
    enabled = false,
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/cubeine.png",
            icon_size = 64
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-recycle.png",
            icon_size = 64,
            --tint = { 0.9, 0.3, 0.1, 0.9 }
        }
    },
    energy_required = 10,
    pollution_multiplier = 10,
    ingredients = {
        { type = "item", name = "cubeine-powder", amount = 5, ignored_by_stats = 5 },
        { type = "fluid", name = "steam",        amount = 1000, minimum_temperature = 500 },
    },
    results = {
        { type = "item", name = "cubeine-powder", amount_min = 3, amount_max = 5, ignored_by_stats = 5 },
        { type = "fluid", name = "water",        amount = 90 },
    },
    category = mods["maraxsis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    --main_product = "cubeine-powder",
    allow_productivity = false,
    allow_quality = true,
    --auto_recycle = false,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    order = "n[cubeine]-b[powder-purification]"
}
data:extend({purification})

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-purification",
        icon_size = 64,
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine.png",
                scale = 4,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/misc/signal-recycle.png",
                scale = 4,
                --tint = {0.9, 0.6, 0.2, 0.9}
            }
        },
        prerequisites = { "cubeine-crystallization", "agricultural-science-pack" },

        unit = {
            count = 1000,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
            
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "agricultural-science-pack", 1 }
            },
            time = 60
        
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-purification"
            }
        }
    }
})
