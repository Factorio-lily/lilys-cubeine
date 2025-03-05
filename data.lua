local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

require("prototypes.core-tech")

require("prototypes.plant.cubeplant")
require("prototypes.plant.branch")
require("prototypes.plant.flower")
require("prototypes.plant.autoplace")

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

require("prototypes.cubeine-purification")

require("prototypes.packaging")

require("prototypes.cubeine-cut-solution")
require("prototypes.cubeine-biochamber")
require("prototypes.cubeine-module-boost")
require("prototypes.cubeine-cut-fuel")
require("prototypes.cubeine-thruster")


if mods["astroponics"] then
    require("prototypes.mod-compat.astroponics")
end
if mods["se-space-trains"] then
    require("prototypes.mod-compat.space-trains")
end

-- debug 
--[[
data:extend({
    {
        type = "recipe",
        name = "cubeplant-flower-debug",
        subgroup = "agriculture",
        crafting_machine_tint = {
            primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 },    -- #ffbba4ff
            secondary = { r = 0.749, g = 0.557, b = 0.490, a = 1.000 },  -- #bf8e7dff
            tertiary = { r = 0.637, g = 0.637, b = 0.637, a = 1.000 },   -- #a2a2a2ff
            quaternary = { r = 0.283, g = 0.283, b = 0.283, a = 1.000 }, -- #484848ff
        },
        allow_productivity = false,
        enabled = true,
        energy_required = 10,
        ingredients =
        {
            { type = "item", name = "wood", amount = 1000 },
            { type = "item", name = "uranium-235", amount = 10 }
        },
        results = { { type = "item", name = "cubeplant-flower", amount = 10 } }
    }
})--]]
