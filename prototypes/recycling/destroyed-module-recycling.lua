if mods["quality"] then
    local recycling = require("__quality__/prototypes/recycling.lua")

    local destroyed_modules = {}

    for name, module in pairs(data.raw["module"]) do
        if module.tier > 0 and module.subgroup == "module-destroyed" and (string.find(name, "module") ~= nil) and (string.find(name, "destroyed") ~= nil) then
            table.insert(destroyed_modules, module)
        end
    end

    local allrecipes = data.raw["recipe"]
    for name, recipe in pairs(allrecipes) do
        if recipe.category == "recycling" and recipe.ingredients and recipe.ingredients[1] then
            if (string.find(recipe.ingredients[1].name, "module") ~= nil) and (string.find(recipe.ingredients[1].name, "destroyed") ~= nil) then
                local original_name = string.gsub(recipe.ingredients[1].name, "%-destroyed", "")
                local original_recipe = data.raw["recipe"][original_name .. "-recycling"]
                recipe.results = original_recipe.results
                recipe.energy_required = original_recipe.energy_required * 2
                destroyed_modules[recipe.ingredients[1].name] = nil
            end
        end
    end


    --destroyed module recycling
    for name, module in pairs(destroyed_modules) do
        recycling.generate_self_recycling_recipe(module)
    end

    for name, recipe in pairs(allrecipes) do
        if recipe.category == "recycling" and recipe.ingredients and recipe.ingredients[1] then
            if (string.find(recipe.ingredients[1].name, "module") ~= nil) and (string.find(recipe.ingredients[1].name, "destroyed") ~= nil) then
                local original_name = string.gsub(recipe.ingredients[1].name, "%-destroyed", "")
                local original_recipe = data.raw["recipe"][original_name .. "-recycling"]
                recipe.results = original_recipe.results
                recipe.energy_required = original_recipe.energy_required * 2
                destroyed_modules[recipe.ingredients[1].name] = nil
            end
        end
    end

    for name, module in pairs(destroyed_modules) do
        local original_name = string.gsub(name, "%-destroyed", "")
        local original_recipe = data.raw["recipe"][original_name .. "-recycling"]
        if original_recipe then
            local new_recipe = table.deepcopy(data.raw["recipe"][original_name .. "-recycling"])
            new_recipe.name = name .. "-recycling"
            new_recipe.ingredients[1] = name
            new_recipe.energy_required = new_recipe.energy_required * 2
            new_recipe.icons = module.icons
            table.insert(new_recipe.icons, 1, { icon = "__quality__/graphics/icons/recycling.png" })
            table.insert(new_recipe.icons, { icon = "__quality__/graphics/icons/recycling-top.png" })
            ---@diagnostic disable-next-line: assign-type-mismatch
            data:extend({ new_recipe })
        end
    end
end
