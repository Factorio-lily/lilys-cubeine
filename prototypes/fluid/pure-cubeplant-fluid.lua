local fluid = {
    type = "fluid",
    name = "pure-cubeplant-fluid",
    icon = "__lilys-cubeine__/graphics/icons/fluid/pure-cubeplant-fluid.png",
    subgroup = "fluid",
    default_temperature = 25,
    order = "a[fluid]-f[cubeine]-c[pure-fluid]",

    base_color = { 1, 0.169, 0.169, 1 },     --#ff2b2b
    flow_color = { 1, 0.067, 0.067, 1 }, --#ff1111

    fuel_value = data.raw["fluid"]["light-oil"].fuel_value and tostring(util.parse_energy(data.raw["fluid"]["light-oil"].fuel_value) / 100) .. "kJ" or
    "5MJ",
    emissions_multiplier = 10
}
data:extend({fluid})
