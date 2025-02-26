--[[data:extend({
    {
        type = "int-setting",
        name = "radar_flight_range",
        setting_type = "startup",
        default_value = 3,
        minimum_value = 1,
        maximum_value = 64,
        order = "a"
    },
    {
        type = "int-setting",
        name = "radar_landed_range",
        setting_type = "startup",
        default_value = 8,
        minimum_value = 1,
        maximum_value = 100,
        order = "b"
    },
    {
        type = "int-setting",
        name = "radar_landed_lifetime",
        setting_type = "startup",
        default_value = 60,
        minimum_value = 1,
        maximum_value = 3600,
        order = "c"
    }
})
--]]