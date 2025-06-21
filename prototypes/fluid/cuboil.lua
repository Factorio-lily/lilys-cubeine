local fluid = {
    type = "fluid",
    name = "cuboil",
    icon = "__lilys-cubeine__/graphics/icons/fluid/cuboil.png",
    subgroup = "fluid",
    default_temperature = 25,
    order = "a[fluid]-f[cubeine]-g[cuboil]",
    fuel_value = "60kJ",
    base_color = { 0.539, 0.144, 0.000, 1 }, --#8a2500
    flow_color = { 0.746, 0.214, 0.023, 1 }, --#bf3706
    emissions_multiplier = 10
}


if not data.raw["fluid"]["light-oil"].fuel_value then
    data.raw["fluid"]["light-oil"].fuel_value = "1MJ"
end
fluid.fuel_value = tostring(math.max(10 * util.parse_energy(data.raw["fluid"]["light-oil"].fuel_value) / 1000, 10000)) .. "kJ"
data:extend({ fluid })
