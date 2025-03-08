local oc = {
    { b = 1.2, t = 60 * 60 * 60 * 2,     d = 0.2, x = 0,   db = 1.4, dx = 0 },     --safe
    { b = 1.5, t = 60 * 60 * 60 * 2,     d = 0.5, x = 0,   db = 2,   dx = 0 },     --mostly safe
    { b = 1.8, t = 60 * 60 * 60 * 2,     d = 0.8, x = 0,   db = 2.2, dx = 0.2 },   -- unsafe
    { b = 2.5, t = 60 * 60 * 60 * 2,     d = 1,   x = 0.2, db = 3,   dx = 0.5 },   -- dangerous
    { b = 4,   t = 60 * 60 * 60 * 4 / 3, d = 1,   x = 0.6, db = 6,   dx = 1 },     --extreme
    { b = 10,  t = 60 * 60 * 60,         d = 1,   x = 1,   db = 16,  dx = 1 },     --burnout
}



local function call_rsl()
    local list1 = prototypes.get_item_filtered({{filter = "type", type = "module"}, {filter = "subgroup", subgroup = "module-overclocked", mode = "and"}})
    local list2 = prototypes.get_item_filtered({ { filter = "type", type = "module" }, { filter = "subgroup", subgroup = "module-degraded-overclocked", mode = "and" } })

    for name, proto in pairs(list1) do
        local level = tonumber(string.sub(name, string.len(name)))
        local base_name = string.gsub(name, "%-overclocked%-" .. tostring(level), "")
        local degraded_name = base_name .. "-degraded"
        local destroyed_name = base_name .. "-destroyed"
        local base_chance = 1 - oc[level].d - oc[level].x

        remote.call("rsl_registry", "register_rsl_definition", name,
            { -- You call the "rsl_registry" to use "register_rsl_definition" and pass it the name of your custom item "mutation-a"
                mode = { random = true, conditional = false, weighted = true },
                condition = true,
                possible_results = {
                    [true] = { { name = base_name, weight = base_chance }, { name = degraded_name, weight = oc[level].d }, { name = destroyed_name, weight = oc[level].x } },
                [false] = {}
                }
            }
        )
    end

    for name, proto in pairs(list2) do
        local level = tonumber(string.sub(name, string.len(name)))
        local degraded_name = string.gsub(name, "%-overclocked%-" .. tostring(level), "")
        local destroyed_name = string.gsub(degraded_name, "%-degraded", "-destroyed")
        local base_chance = 1 - oc[level].dx

        remote.call("rsl_registry", "register_rsl_definition", name,
            { -- You call the "rsl_registry" to use "register_rsl_definition" and pass it the name of your custom item "mutation-a"
                mode = { random = true, conditional = false, weighted = true },
                condition = true,
                possible_results = {
                    [true] = {{ name = degraded_name, weight = base_chance }, { name = destroyed_name, weight = oc[level].dx } },
                    [false] = {}
                }
            }
        )
    end

    
end




function OnInit()
    storage = storage or {}
    storage.reactors = storage.reactors or {}
    storage.vhp = storage.vhp or {} --virtual heatpipes
    call_rsl()
end



script.on_load(OnInit)
script.on_init(OnInit)
script.on_configuration_changed(OnInit)


script.on_event(defines.events.on_built_entity, function(event)
    if event.entity.name == "nukubeine-reactor" then
        storage.reactors[event.entity] = {vhp = nil}
    end
end
)

local function validate_storage()
    for reactor, data in pairs(storage.reactors) do
        if not reactor.valid then

--Remove any scripted effects here



            storage.reactors[reactor] = nil
        end
    end

    for vhp, data in pairs(storage.vhp) do
        if not vhp.valid then
            storage.vhp[vhp] = nil
        end

        if vhp.reactor == nil or not (vhp.reactor.valid) then
            vhp.destroy()
        end

    end

end


local function manage_reactors()
    for reactor, data in pairs(storage.reactors) do
        if reactor.frozen then
            rendering.draw_animation({
                animation = "nukubeine-reactor-frozen-animation",
                animation_speed = 0,
                target = reactor,
                surface = reactor.surface,
                time_to_live = 1
            })
        end


        
        
    end
end


script.on_event(defines.events.on_script_trigger_effect, function(event)
    if event.effect_id == "cubeine-powder-consumed" or event.effect_id == "cubeine-crystal-consumed" then
        if event.cause_entity and event.cause_entity.stickers then
            
            for _, sticker in ipairs(event.cause_entity.stickers) do
                if sticker.valid and (sticker.name == "cubeine-powder-sticker-3" or sticker.name == "cubeine-crystal-sticker-3") then
                    sticker.destroy()
                end
            end

        end
end

end
)

script.on_event(defines.events.on_tick, function(event)
    validate_storage()
    manage_reactors()


end)