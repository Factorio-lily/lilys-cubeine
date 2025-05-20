-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-military-1",
        localised_name = {"technology-name.cubeine-military-1"},
        localised_description = {"technology-description.cubeine-military-1"},
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/cannon-shell-hypervelocity.png",
                icon_size = 64,
            }

        },
        prerequisites = { "tank", "cubeine-crystallization" },

        unit = {
            count = 2000,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "military-science-pack",  2 },
            },
            time = 30

        },

        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-cannon-shell"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-uranium-cannon-shell"
            }
        }
    },
    {
        type = "technology",
        name = "cubeine-military-2",
        localised_name = { "technology-name.cubeine-military-2" },
        localised_description = { "technology-description.cubeine-military-2" },
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/explosive-cubonium-cannon-shell.png",
                icon_size = 64,
            }

        },
        prerequisites = { "cubeine-military-1", "liquid-cubonium" },

        unit = {
            count = 10000,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "military-science-pack",   2 },
                { "cryogenic-science-pack",  2 },
            },
            time = 30

        },

        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubonium-cannon-shell"
            },
            {
                type = "unlock-recipe",
                recipe = "cubonium-rocket"
            }
        }
    }
})
