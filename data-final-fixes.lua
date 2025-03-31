

if mods["se-space-trains"] then
    
    local battery_discharged = data.raw["item"]["space-train-discharged-battery-pack"]
    local c_battery_discharged = data.raw["item"]["cubeine-space-train-discharged-battery-pack"]

    c_battery_discharged.weight = battery_discharged.weight

    local battery_charged = data.raw["item"]["space-train-battery-pack"]
    local c_battery_charged = data.raw["item"]["space-train-battery-pack"]

    c_battery_charged.weight = battery_charged.weight

    local battery_fried = data.raw["item"]["space-train-destroyed-battery-pack"]
    local c_battery_fried = data.raw["item"]["cubeine-space-train-destroyed-battery-pack"]

    if (battery_fried) then 
        c_battery_fried.weight = battery_fried.weight
    else
        c_battery_fried.weight = battery_discharged.weight
    end


end




local rsc = data.raw["reactor"]["nukubeine-reactor"].surface_conditions or {}

for _, cond in ipairs(rsc) do
    if cond.property == "magnetic-field" then
       cond.max = 200 
    end
end


local plasma = data.raw["fluid"]["cubeine-fusion-plasma"]
if plasma then
    plasma.fuel_value = tostring(plasma.default_temperature / 1000000 * util.parse_energy(plasma.heat_capacity)) .. "MJ"
end




local fuel_fluids = {"cuboil", "cubonium-gas", "cubeine-fuel", "raw-cubeine-fluid"}
local fuel_fluids2 = {}
for _, value in ipairs(fuel_fluids) do
    fuel_fluids2[value] = true
end

for name, value in pairs(data.raw["item"]) do
    if string.find(name, "%-barrel") then
        local name2 = string.gsub(name, "%-barrel", "")
        if fuel_fluids2[name2] then
            local fluid = data.raw["fluid"][name2]
            value.fuel_emissions_multiplier = fluid.emissions_multiplier
            value.burnt_result = "barrel"
            value.fuel_value = tostring(50 * util.parse_energy(fluid.fuel_value) / 1000) .. "kJ"
            value.fuel_category = "chemical"
        end


    end
    
end