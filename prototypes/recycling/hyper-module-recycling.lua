if mods["quality"] then
    local recycling = require("__quality__/prototypes/recycling.lua")

    local hyper_modules = {}

    for name, module in pairs(data.raw["module"]) do
        if module.tier > 0 and module.subgroup == "module-hyper" and (string.find(name, "module") ~= nil) and (string.find(name, "hyper") ~= nil) then
            table.insert(hyper_modules, module)
        end
    end

    local allrecipes = data.raw["recipe"]
    
    --hyper module recycling
    for name, module in pairs(hyper_modules) do
        recycling.generate_self_recycling_recipe(module)
    end

    for name, recipe in pairs(allrecipes) do
        if recipe.category == "recycling" and recipe.ingredients and recipe.ingredients[1] then
            if (string.find(recipe.ingredients[1].name, "module") ~= nil) and (string.find(recipe.ingredients[1].name, "hyper") ~= nil) then
                local original_name = string.gsub(recipe.ingredients[1].name, "%-hyper", "")
                local original_recipe = data.raw["recipe"][original_name .. "-recycling"]
                recipe.results[1].probability = 0.75
                recipe.energy_required = math.ceil(original_recipe.energy_required) * 10
                recipe.show_amount_in_title = false
                hyper_modules[recipe.ingredients[1].name] = nil
            end
        end
    end
end
