local fluid = {
    type = "fluid",
    name = "liquid-cubonium",
    icon = "__lilys-cubeine__/graphics/icons/fluid/liquid-cubonium.png",
    subgroup = "fluid",
    default_temperature = -150,
    order = "a[fluid]-f[cubeine]-k[liquid-cubonium]",
    fuel_value = "15MJ",
    base_color = { 0.937, 0.335, 0.496, 1 }, --#f0567f
    flow_color = { 0.898, 0.261, 0.535, 1 }, --#e64389
    gas_temperature = -100,
    emissions_multiplier = 2
}

fluid.fuel_value = tostring(util.parse_energy(data.raw["fluid"]["cubonium-gas"].fuel_value) / 100) .. "kJ"
data:extend({ fluid })
