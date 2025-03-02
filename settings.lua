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
    tcs
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