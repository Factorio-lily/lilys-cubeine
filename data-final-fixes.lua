

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


if mods["quality"] then
local allrecipes = data.raw["recipe"]
for name, recipe in pairs(allrecipes) do
    if recipe.category == "recycling" and recipe.ingredients and recipe.ingredients[1] then
        if (string.find(recipe.ingredients[1].name, "module") ~= nil) and (string.find(recipe.ingredients[1].name, "destroyed") ~= nil) then
                local original_name = string.gsub(recipe.ingredients[1].name, "%-destroyed", "")
                local original_recipe = data.raw["recipe"][original_name .. "-recycling"]
                recipe.results = original_recipe.results
                recipe.energy_required = original_recipe.energy_required * 2
        end
    end
    

end
end

local rsc = data.raw["reactor"]["nukubeine-reactor"].surface_conditions or {}

for _, cond in ipairs(rsc) do
    if cond.property == "magnetic-field" then
       cond.max = 200 
    end
end