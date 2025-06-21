local fluid = {
    type = "fluid",
    name = "liquid-azure",
    icon = "__lilys-cubeine__/graphics/icons/fluid/liquid-azure.png",
    subgroup = "fluid",
    default_temperature = -150,
    order = "a[fluid]-f[cubeine]-zk[liquid-azure]",
    fuel_value = "15MJ",
    base_color = { 0.333, 0.898, 0.941, 1 },  --#55e5f0
    flow_color = { 0.263, 0.898, 0.839, 1 }, --#43e5d6
    gas_temperature = 100,
    emissions_multiplier = -0.1
}

fluid.fuel_value = tostring(0.2 * util.parse_energy(data.raw["fluid"]["cubonium-gas"].fuel_value) / 100) .. "kJ"
data:extend({ fluid })
