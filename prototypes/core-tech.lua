


-- technology
data:extend({
    {
        type = "technology",
        name = "cubeplant-replanting",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/cubeplant-flower.png",
        prerequisites = {} ,

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
            }
        }
    }
})



-- technology
data:extend({
    {
        type = "technology",
        name = "cubeplant-processing",
        icon_size = 256,
        icon = "__lilys-cubeine__/graphics/technology/cubeplant-processing.png",
        prerequisites = { "advanced-oil-processing", settings.startup["technology-condition"].value .. "" },

        research_trigger =
        {
            type = "mine-entity",
            entity = "redleaf-cubeplant"
        },
        effects =
        {
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
        name = "cubeine-crystallization",
        icon_size = 64,
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        scale = 4,
        prerequisites = { "cubeplant-processing" },

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
