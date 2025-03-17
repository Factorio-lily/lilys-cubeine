local fluid = {
    type = "fluid",
    name = "raw-cubeplant-slurry",
    icon = "__lilys-cubeine__/graphics/icons/fluid/raw-cubeplant-slurry.png",
    subgroup = "fluid",
    default_temperature = 25,
    order = "a[fluid]-f[cubeine]-a[raw-slurry]",

    base_color = { 0.282, 0.004, 0.043, 1 }, --#48010b
    flow_color = { 0.318, 0.024, 0.063, 1 }, --#510610

    fuel_value = data.raw["fluid"]["light-oil"].fuel_value or "500kJ",
    emissions_multiplier = 10
}
data:extend({fluid})