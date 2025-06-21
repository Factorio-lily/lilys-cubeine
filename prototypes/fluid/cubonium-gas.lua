local fluid = {
    type = "fluid",
    name = "cubonium-gas",
    icon = "__lilys-cubeine__/graphics/icons/fluid/cubonium-gas.png",
    subgroup = "fluid",
    default_temperature = 25,
    order = "a[fluid]-f[cubeine]-h[cubonium-gas]",
    fuel_value = "1MJ",
    base_color = { 1.000, 0.600, 0.703, 1 }, --#ff99b4
    flow_color = { 0.898, 0.261, 0.535, 1 }, --#e64389
    gas_temperature = -100,
    emissions_multiplier = 2
}

if not data.raw["fluid"]["petroleum-gas"].fuel_value then
    data.raw["fluid"]["petroleum-gas"].fuel_value = "1MJ"
end
fluid.fuel_value = tostring(3 * util.parse_energy(data.raw["fluid"]["petroleum-gas"].fuel_value) /1000) .. "kJ"
data:extend({ fluid })
