

local greenhouse_recipe = {
    type = "recipe",
    name = "aop-cubeplant-planting",
    icon = "__lilys-cubeine__/graphics/technology/cubeplant-processing.png",
    icon_size = 256,
    subgroup = "aop-advanced-agriculture",
    enabled = false,
    energy_required = 600,
    ingredients = {
        { type = "item",  name = "cubeplant-flower", amount = 1 },
        { type = "fluid",  name = "petroleum-gas",     amount = 300 },
        { type = "fluid", name = "water",         amount = 50 },
    },
    results = {
        { type = "item", name = "cubeplant-branch", amount = 200 },
    },
    allow_productivity = false,
    category = "agriculture",
    auto_recycle = false,
    show_amount_in_title = false,
    surface_conditions = { { property = "pressure", min = 500, max = 3000 } },
    crafting_machine_tint =
    {
        primary = { r = 0.905, g = 0.201, b = 0.193, a = 1.000 },
        secondary = { r = 0.976, g = 0.206, b = 0.110, a = 1.000 },
    }
}
data:extend({greenhouse_recipe})


local tech = data.raw["technology"]["aop-greenhouse"]
table.insert(tech.effects, 3, {
    type = "unlock-recipe",
    recipe = "aop-cubeplant-planting"
})

local tech2 = data.raw["technology"]["aop-agriculture-productivity"]
table.insert(tech2.effects, {
    type = "change-recipe-productivity",
    recipe = "aop-cubeplant-planting",
    change = 0.1
})
