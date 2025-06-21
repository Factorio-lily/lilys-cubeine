local tcs = {
        type = "string-setting",
        name = "technology-condition",
        setting_type = "startup",
        allowed_values = {"lubricant", "agriculture"},
        default_value = "lubricant",
        minimum_value = 1,
        maximum_value = 100,
        order = "b"
}

data:extend({
    {
        type = "bool-setting",
        name = "nauvis-spawn",
        setting_type = "startup",
        default_value = true,
        order = "aa"
    },
    {
        type = "bool-setting",
        name = "gleba-spawn",
        setting_type = "startup",
        default_value = true,
        order = "ab"
    },
    tcs,
    {
        type = "int-setting",
        name = "max-overclock",
        setting_type = "startup",
        default_value = 6,
        allowed_values = {0, 1, 2, 3, 4, 5, 6}
    },
    {
        type = "bool-setting",
        name = "hyper-allowed",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "overclock-all",
        setting_type = "startup",
        default_value = false
    }
})


if mods["cubium"] then
    data:extend({
        {
        type = "bool-setting",
        name = "cubium-spawn",
        setting_type = "startup",
        default_value = true,
        order = "ac"
    },
    table.insert(tcs.allowed_values, "planet-discovery-cubium")
})
end

if mods["terrapalus"] then
    data:extend({
        {
        type = "bool-setting",
        name = "terrapalus-spawn",
        setting_type = "startup",
        default_value = true,
        order = "ad"
    },
    table.insert(tcs.allowed_values, "planet-discovery-terrapalus")
})
end

if mods["Moshine"] then
    data:extend({
        {
        type = "bool-setting",
        name = "moshine-spawn",
        setting_type = "startup",
        default_value = true,
        order = "ae"
    },
    table.insert(tcs.allowed_values, "planet-discovery-moshine")
})
end