
data:extend { {
    type = "item",
    name = "cubeslurry-filter",
    icon = "__maraxsis__/graphics/icons/salt-filter.png",
    icon_size = 64,
    stack_size = 50,
} }

data:extend { {
    type = "item",
    name = "cubeslurry-filter-dirty",
    icon = "__maraxsis__/graphics/icons/salt-filter.png",
    icon_size = 64,
    stack_size = 50,
} }


data:extend { {
    type = "item",
    name = "cubeslurry-filter-dirty",
    icon = "__maraxsis__/graphics/icons/salt-filter.png",
    icon_size = 64,
    stack_size = 50,
} }



data:extend {{
    type = "recipe",
    name = "cubeslurry-filter-cleaning",
    enabled = false,
    energy_required = 1.25,
    ingredients = {
        { type = "item",  name = "cubeslurry-filter-dirty", amount = 1,  ignored_by_stats = 1 },
        {type = "fluid", name = "water",                          amount = 500},
    },
    results = {
        {type = "item",  name = "cubeslurry-filter",    amount = 1, probability = 0.95, ignored_by_stats = 1, ignored_by_productivity = 10},
        {type = "item",  name = "steel-plate",            amount = 1, probability = 0.05},
        {type = "item", name = "spoilage", amount = 10},
    },
    category = mods["maraxis"] and "maraxsis-hydro-plant-or-chemistry" or "chemistry",
    main_product = "cubeslurry-filter",
    allow_productivity = true,
    icons = {
        { icon = "__lilys-cubeine__/graphics/technology/filters.png", icon_size = 256},
        { icon = "__lilys-cubeine__/graphics/icons/misc/signal-recycle.png", icon_size = 64, tint = {0.9, 0.9, 0.9, 0.9} },
    }
    ,
    
    allow_decomposition = false,
---@diagnostic disable-next-line: assign-type-mismatch
    auto_recycle = false,
}}

data:extend { {
    type = "recipe",
    name = "cubeslurry-filter",
    enabled = false,
    energy_required = 5,
    ingredients = {
        { type = "item",  name = "steel-plate", amount = 4 },
        { type = "item",  name = "copper-plate", amount = 1 },
        { type = "item", name = "coal",          amount = 10 }
    },
    results = {
        { type = "item", name = "cubeslurry-filter", amount = 1 }
    },
    category = "advanced-crafting",
    main_product = "cubeslurry-filter",
    allow_productivity = true,
    icons = {
        { icon = "__lilys-cubeine__/graphics/technology/filters.png",   icon_size = 256 },
        { icon = "__lilys-cubeine__/graphics/icons/signal-recycle.png", icon_size = 64, tint = { 0.9, 0.9, 0.9, 0.9 } },
    }
} }

local tech = data.raw["technology"]["cubeplant-processing"]
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "cubeslurry-filter"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "cubeslurry-filter-cleaning"
})
