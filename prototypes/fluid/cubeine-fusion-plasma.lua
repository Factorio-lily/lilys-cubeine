
local fluid = table.deepcopy(data.raw["fluid"]["fusion-plasma"])

fluid.name = "cubeine-fusion-plasma"
fluid.icons = {
    {
        icon = fluid.icon,
        icon_size = fluid.icon_size,
        tint = {1, 0.2, 0.2, 1}
    }
}

fluid.default_temperature = fluid.default_temperature
fluid.max_temperature = fluid.max_temperature * 20
fluid.heat_capacity = tostring(util.parse_energy(fluid.heat_capacity) / 100) .. "J"
fluid.emissions_multiplier = 2

fluid.base_color = { 1, fluid.base_color[2] * 0.2, fluid.base_color[3] * 0.5 , 1}
fluid.flow_color = { 1, fluid.flow_color[2] * 0.2, fluid.flow_color[3] * 0.3, 1 }

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({fluid})

local residue = table.deepcopy(data.raw["fluid"]["cubeine-solution"])
residue.name = "residue-cubeine-solution"
residue.default_temperature = 1000
residue.max_temperature = 2000
residue.gas_temperature = 150
residue.fuel_value = nil
residue.base_color = { 0.8, 1, 0.9, 1 }
residue.flow_color = { 0.9, 1, 0.9, 1 }
residue.icon = "__lilys-cubeine__/graphics/icons/fluid/cubeine-residue.png"
---@diagnostic disable-next-line: assign-type-mismatch
data:extend({residue})