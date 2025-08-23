local oc = require("prototypes.modules.oc")
require("util")


local function cleanup_virtual()
    local names = {

    }
    for i = 0, 80, 1 do
        table.insert(names, "nukubeine-reactor-vhp-" .. i)
        table.insert(names, "nukubeine-reactor-vlt-" .. i)
    end


    local all = {}
    for _, surface in pairs(game.surfaces) do
        local nodes = surface.find_entities_filtered { name = names }

        for _, node in ipairs(nodes or {}) do
            all[node] = true
        end
    end

    for vhp, data in pairs(storage.vhp) do
        all[vhp] = nil
    end

    for vlt, data in pairs(storage.vlt) do
        all[vlt] = nil
    end

    for v, _ in pairs(all) do
        if v.valid then
            v.destroy()
        end
    end
end



function OnInit()
    storage = storage or {}
    storage.reactors = storage.reactors or {}
    storage.vhp = storage.vhp or {}         --virtual heatpipes
    storage.vlt = storage.vlt or {}         --virtual lights
    storage.vhp_del = storage.vhp_del or {} --virtual heatpipes - to be deleted
    storage.fusion = storage.fusion or {}
    cleanup_virtual()
end

--script.on_load(call_rsl)
script.on_init(OnInit)
script.on_configuration_changed(OnInit)


script.on_event(defines.events.on_built_entity, function(event)
    if event.entity.name == "nukubeine-reactor" then
        reactor = event.entity
        local frozen = rendering.draw_animation {
            animation = "nukubeine-reactor-frozen-animation",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = { 0, -0.5 },
            visible = false,
            render_layer = "higher-object-above"
        }
        local base = rendering.draw_animation {
            animation = "nukubeine-reactor-base-animation",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = { 0, -0.5 },
            visible = true,
            render_layer = "higher-object-above"
        }
        local emi = rendering.draw_animation {
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
        local heat_glow = rendering.draw_animation {
            animation = "nukubeine-reactor-heat-glow",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = { 0, -0.5 },
            --tint = { 1, 0.4, 0.1, 1 },
            render_layer = "higher-object-above",
            width = 590,
            height = 640,
            draw_as_glow = true
        }
        storage.reactors[reactor] = {
            vhp = nil,
            vlt = nil,
            frozen = frozen,
            base = base,
            emissive = emi,
            heat_glow =
                heat_glow
        }
    end
end
)

script.on_event(defines.events.on_robot_built_entity, function(event)
    if event.entity.name == "nukubeine-reactor" then
        reactor = event.entity
        local frozen = rendering.draw_animation {
            animation = "nukubeine-reactor-frozen-animation",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = { 0, -0.5 },
            visible = false,
            render_layer = "higher-object-above"
        }
        local base = rendering.draw_animation {
            animation = "nukubeine-reactor-base-animation",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = { 0, -0.5 },
            visible = true,
            render_layer = "higher-object-above"
        }
        local emi = rendering.draw_animation {
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
        local heat_glow = rendering.draw_animation {
            animation = "nukubeine-reactor-heat-glow",
            animation_speed = 0,
            target = reactor,
            surface = reactor.surface,
            scale = 0.5,
            shift = { 0, -0.5 },
            --tint = { 1, 0.4, 0.1, 1 },
            render_layer = "higher-object-above",
            width = 590,
            height = 640,
            draw_as_glow = true
        }
        storage.reactors[reactor] = {
            vhp = nil,
            vlt = nil,
            frozen = frozen,
            base = base,
            emissive = emi,
            heat_glow =
                heat_glow
        }
    end
end
)

local function validate_storage(tick)
    if not storage.fusion then
        storage.fusion = {}
    end

    for num, data in pairs(storage.fusion) do
        if not game.get_entity_by_unit_number(num).valid then
            storage.fusion[num] = nil
        end
    end







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
    if not storage.vhp_del then
        storage.vhp_del = {}
    end
    for vhp, data in pairs(storage.vhp_del) do
        if not vhp.valid then
            storage.vhp_del = nil
        end

        if vhp.valid and data.tick < tick then
            vhp.destroy()
        else
            if data.reactor and data.reactor.valid and vhp.valid then
                vhp.temperature = data.reactor.temperature
            end
        end
    end
end


local function manage_reactors(tick)
    for reactor, data in pairs(storage.reactors) do
        if not reactor.valid then
            return nil
        end
        data.acc_ticks = data.acc_ticks or 0
        data.last_managed = data.last_managed or tick

        data.acc_ticks = data.acc_ticks + tick - data.last_managed
        data.last_managed = tick

        data.current_radius = data.current_radius or -1

        local t = reactor.temperature
        local trigger_chance = t > 1000 and math.pow((t - 1200) / 5000, 2) or 0

        local light_radius = math.floor(6e-6 * t * t + 0)
        local heat_radius = math.ceil(6e-6 * t * t + 5)
        local danger_radius = 6e-6 * t * t / 1.8
        local danger_intensity = (t / 300) * (t / 300)
        local safe_radius = 10

        local shc = 0.2
        local k = 0.4e-15


        local temp_decrease = t ^ 4 * k / shc
        reactor.temperature = reactor.temperature - temp_decrease

        if (data.vhp ~= nil and data.vhp.valid and heat_radius ~= data.heat_radius) then
            local nvhp = reactor.surface.create_entity({
                name = "nukubeine-reactor-vhp-" .. tostring(heat_radius),
                position = reactor.position,
                force = reactor.force,
                create_build_effect_smoke = false,
                --fast_replace = true
            })
            if data.vhp.valid and data.vhp ~= nvhp then
                if not storage.vhp_del then
                    storage.vhp_del = {}
                end
                data.vhp.temperature = t

                storage.vhp_del[data.vhp] = { tick = tick + 60, reactor = reactor }
                --data.vhp.destroy()
            end
            data.vhp = nvhp
            data.vhp.temperature = t
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
                local danger_entities = reactor.surface.find_entities_filtered { position = reactor.position, radius = danger_radius }
                local safe_entities = reactor.surface.find_entities_filtered { position = reactor.position, radius = safe_radius }
                local safe = {}
                for key, value in pairs(safe_entities) do
                    if value.valid and value.unit_number then
                        safe[value.unit_number] = true
                    end
                end

                for _, entity in pairs(danger_entities) do
                    if entity.valid and ((entity.unit_number and safe[entity.unit_number] == nil) or entity.unit_number == nil) and entity.max_health ~= nil and entity.type ~= 'construction-robot' and entity.type ~= 'logistic-robot' then
                        if (math.random() < danger_intensity / 100.0) then
                            if (entity.type == "tree" or entity.type == "plant") and not entity.has_flag("not-flammable") then
                                reactor.surface.create_entity({
                                    name = "cubeine-flame",
                                    position = entity.position,
                                    force = "neutral"
                                })
                            elseif entity.health then
                                local damage = math.min(t,
                                    math.max(0,
                                        t * (1 - util.distance(reactor.position, entity.position) / danger_radius)))
                                entity.damage(damage, reactor.force, "fire", reactor, reactor)
                                --[[entity.damage{
                                    damage = damage,
                                    force = reactor.force,
                                    type = "fire",
                                    source = reactor,
                                    cause = reactor
                                }--]]
                            end
                        end
                    end
                end


                --[[for i = 1, danger_intensity, 1 do
                    angle = math.pi * 2 * math.random()
                    range = safe_radius + math.random() * (danger_radius - safe_radius)

                    reactor.surface.create_entity({
                        name = "cubeine-flame",
                        position = { reactor.position.x + math.cos(angle) * range, reactor.position.y + math.sin(angle) * range },
                        force = "neutral"
                    })
                end--]]
            end
        end

        local working_animation_speed = 0.5
        if reactor and reactor.valid then
            working_animation_speed = working_animation_speed + reactor.quality.level * 0.3 * working_animation_speed
        end

        if data.heat_glow and data.heat_glow.valid then
            local a = math.min(1, t < 300 and 0 or math.pow((t - 100) / 2700, 4))
            data.heat_glow.color = { math.sqrt(a), a * math.sqrt(a), a * a, math.sqrt(a) }
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
                    data.frozen.animation_speed = working_animation_speed
                    data.base.animation_speed = working_animation_speed
                    data.emissive.animation_speed = working_animation_speed
                    data.heat_glow.animation_speed = working_animation_speed
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
        if not storage.last_consumed then
            storage.last_consumed = {}
        end


        if event.cause_entity and event.cause_entity.valid and event.cause_entity.stickers then
            for _, sticker in ipairs(event.cause_entity.stickers or {}) do
                if sticker.valid and (string.find(sticker.name, "cubeine%-powder%-sticker%-wd") or string.find(sticker.name, "cubeine%-crystal%-sticker%-wd")) then
                    sticker.destroy()
                end
                if sticker.valid and (not string.find(sticker.name, "%-back")) and (string.find(sticker.name, "cubeine%-powder%-sticker") or string.find(sticker.name, "cubeine%-crystal%-sticker")) then
                    if not storage.last_consumed[event.cause_entity.unit_number] then
                        storage.last_consumed[event.cause_entity.unit_number] = {
                            sticker_name = sticker.name,
                            level = sticker.quality.level,
                            ttl = sticker.time_to_live
                        }
                    elseif (not storage.last_consumed[event.cause_entity.unit_number].ttl) or (storage.last_consumed[event.cause_entity.unit_number].ttl < sticker.time_to_live) then
                        storage.last_consumed[event.cause_entity.unit_number] = {
                            sticker_name = sticker.name,
                            level = math.max(sticker.quality.level,
                                storage.last_consumed[event.cause_entity.unit_number].level),
                            ttl = sticker.time_to_live
                        }
                    end
                    sticker.destroy()
                end
                if sticker.valid and (string.find(sticker.name, "%-back")) and (string.find(sticker.name, "cubeine%-powder%-sticker") or string.find(sticker.name, "cubeine%-crystal%-sticker")) then
                    sticker.destroy()
                end
            end

            local name = storage.last_consumed[event.cause_entity.unit_number].sticker_name
            local name2 = string.sub(name, 1, #name - 1)

            if storage.last_consumed[event.cause_entity.unit_number] then
                local sticker = event.cause_entity.surface.create_entity {
                    name = name2 .. tostring(storage.last_consumed[event.cause_entity.unit_number].level),
                    position = event.cause_entity.position,
                    cause = event.cause_entity,
                    force = event.cause_entity.force,
                    source = event.cause_entity,
                    target = event.cause_entity
                }
                event.cause_entity.surface.create_entity {
                    name = name2 .. "back",
                    position = event.cause_entity.position,
                    cause = event.cause_entity,
                    force = event.cause_entity.force,
                    source = event.cause_entity,
                    target = event.cause_entity
                }
            end
        end
    end

    if event.effect_id == "cubeine-powder-wd" or event.effect_id == "cubeine-crystal-wd" then
        if not storage.last_consumed then
            storage.last_consumed = {}
        end


        if event.cause_entity and event.cause_entity.valid then
            local found = false
            for _, sticker in ipairs(event.cause_entity.stickers or {}) do
                if sticker.valid and (string.find(sticker.name, "cubeine%-powder%-sticker") or string.find(sticker.name, "cubeine%-crystal%-sticker")) then
                    found = true
                end
            end

            local name = storage.last_consumed[event.cause_entity.unit_number].sticker_name
            local name2 = string.sub(name, 1, #name - 1)

            if not found and storage[event.cause_entity.unit_number].last_consumed then
                local sticker = event.cause_entity.surface.create_entity {
                    name = name2 .. "wd-" .. tostring(storage.last_consumed[event.cause_entity.unit_number].level),
                    position = event.cause_entity.position,
                    cause = event.cause_entity,
                    force = event.cause_entity.force,
                    source = event.cause_entity,
                    target = event.cause_entity
                }
                storage[event.cause_entity.unit_number].last_consumed = nil
            end
        end
    end
end
)

script.on_event(defines.events.on_tick, function(event)
    validate_storage(event.tick)
    manage_reactors(event.tick)


    --[[for num, data in pairs(storage.fusion) do
        local reactor =  game.get_entity_by_unit_number(num)

        for _, box in ipairs(reactor.fluidbox) do
            if box.amount and box.amount > 0 and box.name == "cubeine-fusion-plasma" and box.temperature < 2000000 then
                box.temperature = 2000000
            end
        end
    end--]]
end)
