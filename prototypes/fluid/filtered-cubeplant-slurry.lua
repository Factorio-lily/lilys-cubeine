local fluid = {
    type = "fluid",
    name = "filtered-cubeplant-slurry",
    icon = "__lilys-cubeine__/graphics/icons/fluid/filtered-cubeplant-slurry.png",
    subgroup = "fluid",
    default_temperature = 25,
    order = "a[fluid]-f[cubeine]-b[filtered-slurry]",

    base_color = { 0.62, 0.09, 0.145, 1 },   --#9e1725
    flow_color = { 0.671, 0.125, 0.161, 1 }, --#ab2029

    fuel_value = data.raw["fluid"]["light-oil"].fuel_value or "500kJ",
    emissions_multiplier = 6
}
data:extend({fluid})
