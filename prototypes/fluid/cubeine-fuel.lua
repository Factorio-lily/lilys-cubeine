local fluid = {
    type = "fluid",
    name = "cubeine-fuel",
    icon = "__lilys-cubeine__/graphics/icons/fluid/cubeine-fuel.png",
    subgroup = "fluid",
    default_temperature = 25,
    order = "a[fluid]-f[cubeine]-d[fuel]",
    fuel_value = "50kJ",
    base_color = { 0.996, 0.059, 0.22, 1 }, --#fe0f38
    flow_color = { 0.984, 0.176, 0.153, 1 }, --#fb2d27
}
data:extend({fluid})
