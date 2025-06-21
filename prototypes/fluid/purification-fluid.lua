local fluid = {
    type = "fluid",
    name = "purification-fluid",
    icon = "__lilys-cubeine__/graphics/icons/fluid/purification-fluid.png",
    subgroup = "fluid",
    default_temperature = 25,
    order = "a[fluid]-f[cubeine]-g[cuboil]",
    base_color = { 0, 0.831, 0.498, 1 },     --#00d47f
    flow_color = { 0.047, 0.969, 0.902, 1 }, --#0cf7e6
}
data:extend({ fluid })
