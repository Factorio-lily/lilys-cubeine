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
        local degraded_chance = oc[level].d
        if degraded_chance + oc[level].x > 1 then
            degraded_chance = 1 - oc[level].x
        end
        local base_chance = 1 - degraded_chance - oc[level].x

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
    storage.vlt = storage.vlt or {} --virtual lights
    call_rsl()
end



script.on_load(OnInit)
script.on_init(OnInit)
script.on_configuration_changed(OnInit)


script.on_event(defines.events.on_built_entity, function(event)
    if event.entity.name == "nukubeine-reactor" then
        reactor = event.entity
        local frozen = rendering.draw_animation{
            animation = "nukubeine-reactor-frozen-animation",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = {0, -0.5},
            visible = false,
            render_layer = "higher-object-above"
        }
        local base = rendering.draw_animation{
            animation = "nukubeine-reactor-base-animation",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = { 0, -0.5 },
            visible = true,
            render_layer = "higher-object-above"
        }
        local emi = rendering.draw_animation{
            animation = "nukubeine-reactor-emissive-animation",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = { 0, -0.5 },
            visible = false,
            render_layer = "higher-object-above",
            draw_as_glow = true,
            blend_mode = "additive"
        }
        local heat_glow = rendering.draw_animation{
            animation = "nukubeine-reactor-heat-glow",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = { 0, -0.5 },
            tint = { 1, 0.4, 0.1, 1 },
            render_layer = "higher-object-above",
            width = 590,
            height = 640,
            draw_as_glow = true
        }
        storage.reactors[reactor] = {vhp = nil, vlt = nil, frozen = frozen, base = base, emissive = emi, heat_glow = heat_glow}
    end
end
)

local function validate_storage()
    for reactor, data in pairs(storage.reactors) do
        if not reactor.valid then

--Remove any scripted effects here
            if data.frozen and data.frozen.valid then
                        data.frozen.destroy()
            end
            if data.base and data.base.valid then
                data.base.destroy()
            end
            if data.emissive and data.emissive.valid then
                data.emissive.destroy()
            end
            if data.heat_glow and data.heat_glow.valid then
                data.heat_glow.destroy()
            end
    
            storage.reactors[reactor] = nil
        end
    end

    --vhp
    for vhp, data in pairs(storage.vhp) do
        if not vhp.valid then
            storage.vhp[vhp] = nil
        end

        if vhp.reactor == nil or not (vhp.reactor.valid) then
            vhp.destroy()
        end

    end
    --vlt
    for vlt, data in pairs(storage.vlt) do
        if not vlt.valid then
            storage.vhp[vlt] = nil
        end

        if vlt.reactor == nil or not (vlt.reactor.valid) then
            vlt.destroy()
        end
    end

end


local function manage_reactors(tick)
    for reactor, data in pairs(storage.reactors) do
        data.acc_ticks = data.acc_ticks or 0
        data.last_managed = data.last_managed or tick

        data.acc_ticks = data.acc_ticks + tick - data.last_managed
        data.last_managed = tick

        data.current_radius = data.current_radius or -1
        
        local t = reactor.temperature
        local trigger_chance = t > 1000 and math.pow((t - 1000) / 5000, 2) or 0
        
        local light_radius = math.ceil(0.73 * math.sqrt(t) + 0)
        local heat_radius = math.ceil(0.73 * math.sqrt(t) + 5)
        local danger_radius = 0.73 * math.sqrt(t) / 1.8
        local danger_intensity = (t / 300) ^ 2
        local safe_radius = 10

        local shc = 0.2
        local k = 0.5e-14


        local temp_decrease = t^4 * k * shc
        reactor.temperature = reactor.temperature - temp_decrease

        if (data.vhp ~= nil and data.vhp.valid and heat_radius ~= data.heat_radius) then
            local nvhp = reactor.surface.create_entity({
                name = "nukubeine-reactor-vhp-" .. tostring(heat_radius),
                position = reactor.position,
                force = reactor.force,
                create_build_effect_smoke = false,
                fast_replace = true
            })
            if data.vhp.valid and data.vhp ~= nvhp then
                data.vhp.destroy()
            end
            data.vhp = nvhp
            data.heat_radius = heat_radius
        end
        if (data.vhp == nil or (not data.vhp.valid)) then
            data.vhp = reactor.surface.create_entity({
                name = "nukubeine-reactor-vhp-" .. tostring(heat_radius),
                position = reactor.position,
                force = reactor.force,
                create_build_effect_smoke = false
            })
            data.vhp.temperature = t
            data.heat_radius = heat_radius
        end

        if (data.vlt ~= nil and data.vlt.valid and light_radius ~= data.light_radius) then
            data.vlt.destroy()
            data.vlt = nil
        end
        if (data.vlt == nil or (not data.vlt.valid)) then
            data.vlt = reactor.surface.create_entity({
                name = "nukubeine-reactor-vlt-" .. tostring(light_radius),
                position = reactor.position,
                force = reactor.force,
                create_build_effect_smoke = false
            })
            data.light_radius = light_radius
        end



        while (data.acc_ticks > 120) do
            data.acc_ticks = data.acc_ticks - 120

            local num = math.random()
            if (num < trigger_chance) then
                for i = 1, danger_intensity, 1 do
                    angle = math.pi * 2 * math.random()
                    range = safe_radius + math.random() * (danger_radius - safe_radius)

                    reactor.surface.create_entity({
                        name = "cubeine-flame",
                        position = { reactor.position.x + math.cos(angle) * range, reactor.position.y + math.sin(angle) * range },
                        force = "neutral"
                    })
                end
            end
        end
        

        if data.heat_glow and data.heat_glow.valid then
            local a = math.min(1, t < 300 and 0 or math.pow((t - 300) / 2700, 4))
            data.heat_glow.color = {a, 0.4 * a, 0.1 * a, a}
        end
        
        if (data.frozen and data.base and data.emissive and data.heat_glow) and (data.frozen.valid and data.base.valid and data.emissive.valid and data.heat_glow.valid) then
            if reactor.frozen then
                data.frozen.animation_speed = 0
                data.base.animation_speed = 0
                data.emissive.animation_speed = 0
                data.heat_glow.animation_speed = 0
                data.frozen.visible = true       
                data.base.visible = false
                data.emissive.visible = false
                data.heat_glow.visible = false
            else
                if reactor.burner.currently_burning == nil then
                    data.frozen.animation_speed = 0
                    data.base.animation_speed = 0
                    data.emissive.animation_speed = 0
                    data.heat_glow.animation_speed = 0
                    data.frozen.visible = false
                    data.base.visible = true
                    data.emissive.visible = false
                    data.heat_glow.visible = true
                else
                    data.frozen.animation_speed = 0.5
                    data.base.animation_speed = 0.5
                    data.emissive.animation_speed = 0.5
                    data.heat_glow.animation_speed = 0.5
                    data.frozen.visible = false
                    data.base.visible = true
                    data.emissive.visible = true
                    data.heat_glow.visible = true
                end

            
            end
        else
            game.print("Warning: Nukubeine reactor animation error")
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
    manage_reactors(event.tick)


end)