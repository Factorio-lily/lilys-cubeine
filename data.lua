local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

require("prototypes.core-tech")

require("prototypes.plant.cubeplant")
require("prototypes.plant.branch")
require("prototypes.plant.flower")

require("prototypes.fluid.raw-cubeplant-slurry")
require("prototypes.fluid.filtered-cubeplant-slurry")
require("prototypes.fluid.pure-cubeplant-fluid")
require("prototypes.fluid.cubeine-fuel")
require("prototypes.fluid.cubeine-solution")


require("prototypes.core-tech")
require("prototypes.main-processing")
require("prototypes.filters")
require("prototypes.cubeine-powder")

require("prototypes.cubeine-crystal")
require("prototypes.crystal-processing")

-- debug
data:extend({
    {
        type = "recipe",
        name = "cubeplant-flower-debug",
        category = "recycling-or-hand-crafting",
        subgroup = "agriculture",
        crafting_machine_tint = {
            primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 },    -- #ffbba4ff
            secondary = { r = 0.749, g = 0.557, b = 0.490, a = 1.000 },  -- #bf8e7dff
            tertiary = { r = 0.637, g = 0.637, b = 0.637, a = 1.000 },   -- #a2a2a2ff
            quaternary = { r = 0.283, g = 0.283, b = 0.283, a = 1.000 }, -- #484848ff
        },
        allow_productivity = false,
        enabled = true,
        energy_required = 1,
        ingredients =
        {

        },
        results = { { type = "item", name = "cubeplant-flower", amount = 1 } }
    }
})
