

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeplant-processing",
        icon_size = 256,
        icon = "__lilys-incendiaries__/graphics/graphics/technology/cubeplant-processing.png",
        prerequisites = { "agriculture" },

        research_trigger =
        {
            type = "mine-entity",
            entity = "redleaf-cubeplant"
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeplant-flower"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeplant-slurry"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeplant-slurry-filtering"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeplant-slurry-distillation"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-extraction"
            },
        }
    }
})

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeplant-crystallization",
        icon_size = 64,
        icon = "__lilys-incendiaries__/graphics/icons/cubeine-crystal.png",
        scale = 4,
        prerequisites = { "agriculture" },

        research_trigger =
        {
            type = "craft-item",
            item = "cubeine-powder",
            amount = 100
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-crystal-forging"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-crystal-cryoforging"
            }
        }
    }
})
