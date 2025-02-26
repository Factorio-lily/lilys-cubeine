
--recipe
local raw_slurry = {
    type = "recipe",
    name = "raw-cubeplant-slurry",
    enabled = false,
    energy_required = 20,
    ingredients = {
        { type = "item",  name = "cubeplant-branch", amount = 40},
        { type = "fluid", name = "light-oil",      amount = 600 },
    },
    results = {
        { type = "fluid", name = "raw-cubeplant-slurry", amount = 600 },
    },
    category = mods["maraxis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "raw-cubeplant-slurry",
    allow_productivity = true
}


--recipe
local filtered_slurry = {

    type = "recipe",
    name = "cubeplant-slurry-filtering",
    enabled = false,
    energy_required = 40,
    ingredients = {
        { type = "fluid", name = "raw-cubeplant-slurry", amount = 600 },
        { type = "item",  name = "cubeslurry-filter",    amount = 1, ignored_by_stats = 1 },
    },
    results = {
        { type = "fluid", name = "filtered-cubeplant-slurry", amount = 600 },
        { type = "item", name = "cubeslurry-filter-dirty",         amount = 1, ignored_by_stats = 1},
    },
    category = mods["maraxis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "filtered-cubeplant-slurry",
    allow_productivity = false

}


--recipe
local pure_fluid = {

    type = "recipe",
    name = "cubeplant-slurry-distillation",
    enabled = false,
    energy_required = 20,
    pollution_multiplier = 10,
    ingredients = {
        { type = "fluid", name = "filtered-cubeplant-slurry", amount = 1200 },
        { type = "fluid", name = "steam", amount = 1200, minimum_temperature = 150 },
    },
    results = {
        { type = "fluid", name = "pure-cubeplant-fluid", amount = 60 },
        { type = "fluid", name = "petroleum-gas",        amount = 960 },
        { type = "fluid", name = "lubricant",            amount = 180 },
    },
    category = "oil-processing",
    main_product = "pure-cubeplant-fluid",
    allow_productivity = true

}


--recipe
local cubeine = {

    type = "recipe",
    name = "cubeine-extraction",
    enabled = false,
    energy_required = 5,
    pollution_multiplier = 10,
    ingredients = {
        { type = "fluid", name = "pure-cubeplant-fluid", amount = 10 },
        { type = "fluid", name = "steam",                amount = 100, minimum_temperature = 150 },
        { type = "item", name = "cubeslurry-filter",     amount = 1, ignored_by_stats = 1 },
    },
    results = {
        { type = "item", name = "cubeine-powder", amount = 1 },
        { type = "item", name = "cubeslurry-filter", amount = 1, probability = 0.9, ignored_by_stats = 1 },
        { type = "item", name = "cubeslurry-filter-dirty", amount = 1, probability = 0.1, ignored_by_stats = 1 },
    },
    category = mods["maraxis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "cubeine-powder",
    allow_productivity = true

}

data:extend{raw_slurry, filtered_slurry, pure_fluid, cubeine}