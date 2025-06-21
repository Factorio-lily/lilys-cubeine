
--recipe
local raw_slurry = {
    type = "recipe",
    name = "cubeplant-slurry",
    subgroup = "cubeplant-processing",
    enabled = false,
    energy_required = 20,
    crafting_machine_tint = {
        primary = { r = 0.282, g = 0.004, b = 0.043, a = 1.000 },     --#48010b
        secondary = { r = 0.318, g = 1.000, b = 0.490, a = 1.000 },   --#510610
        tertiary = { r = 0.57, g = 0.024, b = 0.063, a = 1.000 },   -- 
        quaternary = { r = 1.0, g = 0.73, b = 0.007, a = 1.000 }, -- 
    },
    ingredients = {
        { type = "item",  name = "cubeplant-branch", amount = 40},
        { type = "fluid", name = "light-oil",      amount = 600 },
    },
    results = {
        { type = "fluid", name = "raw-cubeplant-slurry", amount = 600 },
    },
    category = mods["maraxsis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "raw-cubeplant-slurry",
    allow_productivity = true
}


--recipe
local filtered_slurry = {

    type = "recipe",
    name = "cubeplant-slurry-filtering",
    subgroup = "cubeplant-processing",
    enabled = false,
    energy_required = 40,
    crafting_machine_tint = {
        primary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },    --#9e1725
        secondary = { r = 0.671, g = 0.125, b = 0.161, a = 1.000 },  --#ab2029
        tertiary = { r = 0.282, g = 0.004, b = 0.043, a = 1.000 },     --#48010b
        quaternary = { r = 0.318, g = 1.000, b = 0.490, a = 1.000 },   --#510610
    },
    ingredients = {
        { type = "fluid", name = "raw-cubeplant-slurry", amount = 600 },
        { type = "item",  name = "cubeslurry-filter",    amount = 1, ignored_by_stats = 1 },
    },
    results = {
        { type = "fluid", name = "filtered-cubeplant-slurry", amount = 600 },
        { type = "item", name = "cubeslurry-filter-dirty",         amount = 1, ignored_by_stats = 1},
    },
    category = mods["maraxsis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "filtered-cubeplant-slurry",
    allow_productivity = false

}


--recipe
local pure_fluid = {

    type = "recipe",
    name = "cubeplant-slurry-distillation",
    subgroup = "cubeplant-processing",
    enabled = false,
    energy_required = 20,
    crafting_machine_tint = {
        primary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },     --#ff2b2b
        secondary = { r = 1, g = 0.067, b = 0.067, a = 1.000 },   --#ff1111
        tertiary = { r = 0.62, g = 0.09, b = 0.145, a = 1.000 },    --#9e1725
        quaternary = { r = 0.671, g = 0.125, b = 0.161, a = 1.000 },  --#ab2029
    },
    emissions_multiplier = 10,
    ingredients = {
        { type = "fluid", name = "filtered-cubeplant-slurry", amount = 1200 },
        { type = "fluid", name = "steam", amount = 1200, minimum_temperature = 150 },
    },
    results = {
        { type = "fluid", name = "pure-cubeplant-fluid", amount = 60 },
        { type = "fluid", name = "petroleum-gas",        amount = 960 },
        { type = "fluid", name = "lubricant",            amount = 180 },
    },
    category = (mods["Age-of-Production"] and "petrochemistry-or-oil-processing" or "oil-processing"),
    main_product = "pure-cubeplant-fluid",
    allow_productivity = true

}


--recipe
local cubeine = {
    icon = "__lilys-cubeine__/graphics/icons/cubeine.png",
    icon_size = 64,
    type = "recipe",
    name = "cubeine-extraction",
    subgroup = "cubeplant-processing",
    enabled = false,
    energy_required = 5,
    crafting_machine_tint = {
        primary = { r = 1.000, g = 0.700, b = 0.700, a = 1.000 },    -- #ffcccc
        secondary = { r = 1.000, g = 0.700, b = 0.700, a = 1.000 },  -- #ffcccc
        tertiary = { r = 1, g = 0.169, b = 0.169, a = 1.000 },     --#ff2b2b
        quaternary = { r = 1, g = 0.067, b = 0.067, a = 1.000 },   --#ff1111
    },
    emissions_multiplier = 10,
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
    category = mods["maraxsis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    --main_product = "cubeine-powder",
    allow_productivity = true,
    order = "n[cubeine]-a[powder-extraction]"
}

data:extend{raw_slurry, filtered_slurry, pure_fluid, cubeine}