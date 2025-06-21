local subgroup = mods["bioprocessing-tab"] and "astroponic-processes" or "fluid-recipes"

data:extend({
  {
    type = "recipe",
    name = "cubeplant-astroponics",
    localised_name = { "recipe-name.cubeplant-astroponics" },
    icons = {
      { icon = "__lilys-cubeine__/graphics/icons/cubeplant-branch.png" },
      { icon = "__astroponics__/graphics/icons/fluid/liquid-fertilizer.png", shift = { -8, -8 }, scale = 0.3 }
    },
    category = "astroponics",
    subgroup = subgroup,
    order = "d[xeno]-e[cubeplant]",
    energy_required = 18,
    enabled = false,
    ---@diagnostic disable-next-line: assign-type-mismatch
    auto_recycle = false,
    allow_productivity = true,
    ingredients = {
      { type = "fluid", name = "liquid-fertilizer", amount = 100, ignored_by_stats = 100 },
      { type = "item", name = "calcite",        amount = 1 },
      { type = "item", name = "cubeplant-flower", amount = 1 }
    },
    results = {
      { type = "item", name = "cubeplant-branch", amount = 10 },
      { type = "fluid", name = "bioslurry",    amount = 40, ignored_by_stats = 40 }
    },
    main_product = "cubeplant-branch"
  } })


data:extend({
  {
    type = "technology",
    name = "cubeplant-astroponics",
    icons = {
      { icon = "__astroponics__/graphics/technology/astroponics.png",          icon_size = 256 },
      { icon = "__lilys-cubeine__/graphics/technology/cubeplant-processing.png", icon_size = 256, shift = { -32, -32 }, scale = 0.3 },
    },
    effects = {
      { type = "unlock-recipe", recipe = "cubeplant-astroponics" },
    },

    prerequisites = { "astroponics", "cubeplant-processing" },
    unit = {
      count = 2000,
      ingredients = {
        { "automation-science-pack",   1 },
        { "logistic-science-pack",     1 },
        { "chemical-science-pack",     1 },
        { "production-science-pack",   1 },
        { "utility-science-pack",      1 },
        { "space-science-pack",        1 },
        { "agricultural-science-pack", 1 },
      },
      time = 60
    }
  }
})
