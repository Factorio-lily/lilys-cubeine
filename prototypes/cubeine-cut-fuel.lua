local cuburn1 = {
    {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                {
                    type = "create-entity",
                    entity_name = "cubeine-flame",
                    probability = 0.1
                }
            }
        }
    },
    {
        type = "area",
        radius = 4,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "create-entity",
                    entity_name = "cubeine-flame",
                    probability = 0.1
                }
            }
        }
    },
    {
        type = "cluster",
        cluster_count = 4,
        distance = 4,
        distance_deviation = 20,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "create-entity",
                    entity_name = "cubeine-flame",
                    probability = 0.1
                }
            }
        }
    }
}

local cuburn2 = {
    {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                {
                    type = "create-entity",
                    entity_name = "cubeine-flame",
                    probability = 0.3
                }
            }
        }
    },
    {
        type = "area",
        radius = 8,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "create-entity",
                    entity_name = "cubeine-flame",
                    probability = 0.3
                }
            }
        }
    },
    {
        type = "cluster",
        cluster_count = 16,
        distance = 8,
        distance_deviation = 40,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "create-entity",
                    entity_name = "cubeine-flame",
                    probability = 0.3
                }
            }
        }
    }
}


local cuburn3 = {
    {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                {
                    type = "create-entity",
                    entity_name = "cubeine-flame",
                    probability = 1
                },
                --[[{
                    type = "nested-result",
                    action = {
                        type = "area",
                        radius = 12,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "create-entity",
                                    entity_name = "cubeine-flame",
                                    probability = 1
                                }
                            }
                        }
                    }
                },
                {
                    type = "nested-result",
                    action = {
                        type = "cluster",
                        cluster_count = 64,
                        distance = 12,
                        distance_deviation = 80,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "create-entity",
                                    entity_name = "cubeine-flame",
                                    probability = 1
                                }
                            }
                        }
                    }
                }--]]
            }
        }
    },
    {
        type = "area",
        radius = 12,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "create-entity",
                    entity_name = "cubeine-flame",
                    probability = 1
                }
            }
        }
    },
    {
        type = "cluster",
        cluster_count = 64,
        distance = 12,
        distance_deviation = 80,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "create-entity",
                    entity_name = "cubeine-flame",
                    probability = 1
                }
            }
        }
    }
}
















-----------------------------------------------
--rocket fuel
 
local rf = table.deepcopy(data.raw["item"]["rocket-fuel"])
rf.name = rf.name .. "-cut"
rf.fuel_value = "120MJ"
rf.fuel_acceleration_multiplier = (rf.fuel_acceleration_multiplier - 1) * 1.5 + 1.2
rf.fuel_top_speed_multiplier = (rf.fuel_top_speed_multiplier - 1) * 1.5 + 1.1
rf.fuel_emissions_multiplier = 2
rf.order = rf.order .. "-cut"
rf.icon = "__lilys-cubeine__/graphics/icons/rocket-fuel-cut.png"
rf.burnt_result = "rf-dummy"
rf.spoil_ticks = hour --  hour
rf.spoil_to_trigger_result = {
    items_per_trigger = 1,
    trigger = {
        {
            type = "direct",
            action_delivery = {
                type = "instant",
                source_effects = {
                    {
                        type = "create-entity"	,
                        entity_name = "fire-flame"
                    },
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            radius = 2,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    {
                                        type = "create-entity"	,
                                        entity_name = "fire-flame"
                                    }
                                }
                            }
                        }
                    },
                }
            }
        },
        cuburn1[1],
        cuburn1[2],
        cuburn1[3],
    }
}

local rf_dummy = {
    type = "item",
    name = "rf-dummy",
    icon = rf.icon,
    hidden = true,
    spoil_ticks = 1,
    stack_size = 1,
    weight = 10000 * kg,
    spoil_to_trigger_result = {
    items_per_trigger = 1,
        trigger = {
            cuburn1[1],
            cuburn1[2],
            cuburn1[3],
        }
            
    }
}

local rf_r = {
    type = "recipe",
    name = "cutting-rocket-fuel",
    enabled = false,
    energy_required = 1,
    pollution_multiplier = 10,
    ingredients = {
        { type = "item", name = "rocket-fuel", amount = 1},
        { type = "item", name = "cubeine-powder", amount = 1},
    },
    results = {
        { type = "item", name = "rocket-fuel-cut", amount = 1 },
    },
    --main_product = "cubeine-powder",
    allow_productivity = false,
    allow_quality = true,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    order = "n[cubeine]-c[cutting]-a[rocket-fuel]"
}

data:extend({rf, rf_r, rf_dummy})
-----------------------------------------------------------------------
--nuclear fuel


local nf = table.deepcopy(data.raw["item"]["nuclear-fuel"])
nf.name = nf.name .. "-cut"
nf.fuel_value = "1.44GJ"
nf.fuel_acceleration_multiplier = (nf.fuel_acceleration_multiplier - 1) * 1.5 + 1.2
nf.fuel_top_speed_multiplier = (nf.fuel_top_speed_multiplier - 1) * 1.5 + 1.1
nf.fuel_emissions_multiplier = 2
nf.order = nf.order .. "-cut"
nf.icon = "__lilys-cubeine__/graphics/icons/nuclear-fuel-cut.png"
nf.burnt_result = "nf-dummy"
nf.spoil_ticks = hour --1 hour
nf.spoil_to_trigger_result = {
    items_per_trigger = 1,
    trigger = {
        data.raw["projectile"]["explosive-uranium-cannon-projectile"].final_action,
        cuburn2[1],
        cuburn2[2],
        cuburn2[3],
    }
}


local nf_dummy = {
    type = "item",
    name = "nf-dummy",
    icon = nf.icon,
    hidden = true,
    spoil_ticks = 1,
    stack_size = 1,
    weight = 10000 * kg,
    spoil_to_trigger_result = {
        items_per_trigger = 1,
        trigger = {
            cuburn2[1],
            cuburn2[2],
            cuburn2[3],
        }
    }
}


local nf_r = {
    type = "recipe",
    name = "cutting-nuclear-fuel",
    enabled = false,
    energy_required = 12,
    pollution_multiplier = 1,
    ingredients = {
        { type = "item", name = "nuclear-fuel", amount = 1},
        { type = "item", name = "cubeine-powder", amount = 12},
    },
    results = {
        { type = "item", name = "nuclear-fuel-cut", amount = 1 },
    },
    allow_productivity = false,
    allow_quality = true,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    order = "n[cubeine]-c[cutting]-b[nuclear-fuel]"
}

data:extend({nf, nf_r, nf_dummy})
-----------------------------------------------------------------------
--plutonium fuel

if mods["Cerys-Moon-of-Fulgora"] then
    
local pf = table.deepcopy(data.raw["item"]["plutonium-fuel"])
pf.name = pf.name .. "-cut"
pf.fuel_value = "5GJ"
pf.fuel_acceleration_multiplier = (pf.fuel_acceleration_multiplier - 1) * 1.5 + 1.2
pf.fuel_top_speed_multiplier = (pf.fuel_top_speed_multiplier - 1) * 1.5 + 1.1
pf.fuel_emissions_multiplier = 2
pf.order = pf.order .. "-cut"
pf.icon = "__lilys-cubeine__/graphics/icons/plutonium-fuel-cut.png"
pf.burnt_result = "pf-dummy"
    pf.spoil_ticks = hour -- hour
    pf.spoil_to_trigger_result = {
        items_per_trigger = 1,
        trigger = {
            data.raw["projectile"]["atomic-rocket"].action,
            cuburn3[1],
            cuburn3[2],
            cuburn3[3],
        }
    }
    

local pf_dummy = {
    type = "item",
    name = "pf-dummy",
    icon = pf.icon,
    hidden = true,
    spoil_ticks = 1,
    stack_size = 1,
    weight = 10000 * kg,
    spoil_to_trigger_result = {
        items_per_trigger = 1,
        trigger = {
            cuburn3[1],
            cuburn3[2],
            cuburn3[3],
        }
    }       
}



local pf_r = {
    type = "recipe",
    name = "cutting-plutonium-fuel",
    enabled = false,
    energy_required = 40,
    pollution_multiplier = 1,
    ingredients = {
        { type = "item", name = "plutonium-fuel", amount = 1},
        { type = "item", name = "cubeine-powder", amount = 40},
    },
    results = {
        { type = "item", name = "plutonium-fuel-cut", amount = 1 },
    },
    allow_productivity = false,
    allow_quality = true,
    hide_from_signal_gui = false,
    show_amount_in_title = false,
    order = "n[cubeine]-c[cutting]-c[plutonium-fuel]"
}


data:extend({pf, pf_r, pf_dummy})
end

-------

-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-cut-fuel",
        icon_size = 256,
        icon = "__lilys-cubeine__/graphics/technology/cubeine-cut-fuel.png",
        prerequisites = { "cubeine-crystallization", "rocket-fuel" },

        unit = {
            count = 500,
            ingredients =
            {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
            
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
            },
            time = 30
        
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cutting-rocket-fuel"
            },
            {
                type = "unlock-recipe",
                recipe = "cutting-nuclear-fuel"
            }
        }
    }
})

if mods["Cerys-Moon-of-Fulgora"] then

table.insert(data.raw["technology"]["cubeine-cut-fuel"].effects, 
            {
                type = "unlock-recipe",
                recipe = "cutting-plutonium-fuel"
            })

end


local cubeine_flame = table.deepcopy(data.raw["fire"]["fire-flame"])
cubeine_flame.name = "cubeine-flame"
cubeine_flame.initial_lifetime = 1200
cubeine_flame.lifetime_increase_by = 1500
cubeine_flame.maximum_lifetime = 18000
cubeine_flame.emissions_per_second = { pollution = 1}
cubeine_flame.flame_alpha = 0.6
cubeine_flame.light.color = { 1, 0.1, 0.2, 1 }
for _, picture in ipairs(cubeine_flame.pictures) do
    picture.tint = {1, 0.1, 0.2, 1}
end

for _, picture in ipairs(cubeine_flame.smoke_source_pictures) do
    picture.tint = { 1, 0.1, 0.2, 1 }
end

data:extend({cubeine_flame})
