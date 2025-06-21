local fluid = {
    type = "fluid",
    name = "acidic-cubeplant-slurry",
    icon = "__lilys-cubeine__/graphics/icons/fluid/acidic-cubeplant-slurry.png",
    subgroup = "fluid",
    default_temperature = 25,
    order = "a[fluid]-f[cubeine]-za[acidic-slurry]",

    base_color = { 0.043, 0.204, 0.682, 1 }, --#0b0148
    flow_color = { 0.063, 0.224, 0.418, 1 }, --#100651
}
data:extend({ fluid })
