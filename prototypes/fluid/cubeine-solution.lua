local fluid = {
    type = "fluid",
    name = "cubeine-solution",
    icon = "__lilys-cubeine__/graphics/icons/fluid/cubeine-solution.png",
    subgroup = "fluid",
    default_temperature = 25,
    order = "a[fluid]-f[cubeine]-e[solution]",
    fuel_category = "nutrients",
    fuel_value = "100kJ",
    base_color = { 0.882, 0.6, 0.675, 1 },   --#e199ac
    flow_color = { 0.655, 0.349, 0.459, 1 }, --#a75975
}
data:extend({fluid})
