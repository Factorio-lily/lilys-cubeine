
--recipe
local solution = {

    type = "recipe",
    name = "cubeine-solution-mixing",
    subgroup = "cubeine-processes",
    enabled = false,
    energy_required = 2,
    crafting_machine_tint = {
        primary = { r = 0.882, g = 0.6, b = 0.675, a = 1.000 },       --#e199ac
        secondary = { r = 0.655, g = 0.349, b = 0.459, a = 1.000 },   --#a75975
        tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },      --#9e1725
        quaternary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },  --#9e1725
    },
    ingredients = {
        { type = "fluid", name = "water", amount = 100 },
        { type = "fluid", name = "lubricant", amount = 20 },
        { type = "item", name = "cubeine-powder", amount = 10 },
    },
    results = {
        { type = "fluid", name = "cubeine-solution", amount = 120 },
    },
    category = mods["maraxsis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "cubeine-solution",
    allow_productivity = false

}

data:extend({solution})

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-solution",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/fluid/cubeine-solution.png",
        scale = 4,
        prerequisites = { "cubeplant-processing", "agricultural-science-pack" },

        unit = {
            count = 1000,
            ingredients =
            {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "chemical-science-pack",     1 },
                { "production-science-pack",   1 },
                { "agricultural-science-pack", 1 }
            },
            time = 60

        },
        
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-solution-mixing"
            }
        }
    }
})
