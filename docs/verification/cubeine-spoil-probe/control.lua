-- Scratch harness control stage: prove that Cubeine's overclocked modules spoil
-- into a *rolled* result through Runtime Spoilage Engine.
--
-- Chest A: natural countdown (the probe's data stage shortens spoil_ticks to 120).
-- Chest B: forced through LuaItemStack::spoil() at tick 100.
-- Every 20 ticks both chests are logged with their item counts, so the run shows
-- (a) the roll happening, (b) no item loss, (c) no placeholder left stuck.

local TEST_ITEMS = {
    "speed-module-3-overclocked-1",           -- registration 1: 80 % base / 20 % degraded
    "speed-module-3-overclocked-4",           -- registration 1: degraded / destroyed / hyper mix
    "speed-module-3-degraded-overclocked-1",  -- registration 2: stays degraded or destroyed
}

local FORCED_TICK = 100

local function pr(msg)
    log("[spoilprobe] " .. msg)
end

local function summarise(chest)
    local parts, total = {}, 0
    local contents = chest.get_inventory(defines.inventory.chest).get_contents()
    for _, item in pairs(contents) do
        parts[#parts + 1] = string.format("%s=%d", item.name, item.count)
        total = total + item.count
    end
    table.sort(parts)
    return string.format("%s [%d items]", #parts == 0 and "(empty)" or table.concat(parts, " "), total)
end

local function dump(tag, chest)
    pr(string.format("t=%d %s: %s", game.tick, tag, summarise(chest)))
end

script.on_init(function()
    local surface = game.surfaces[1]
    surface.request_to_generate_chunks({ 0, 0 }, 2)
    surface.force_generate_chunk_requests()

    local force = game.forces.player
    storage.natural = surface.create_entity { name = "iron-chest", position = { -2.5, 0.5 }, force = force }
    storage.forced = surface.create_entity { name = "iron-chest", position = { 2.5, 0.5 }, force = force }
    storage.forced_done = false

    for _, name in ipairs(TEST_ITEMS) do
        local proto = prototypes.item[name]
        if not proto then
            pr("MISSING PROTOTYPE " .. name)
        else
            local count = proto.stack_size
            local placeholder = prototypes.item[name .. "-rse-placeholder"]
            pr(string.format("%s: stack_size=%d placeholder=%s",
                name, count, placeholder and "EXISTS" or "MISSING"))
            storage.natural.insert { name = name, count = count }
            storage.forced.insert { name = name, count = count }
        end
    end

    dump("natural", storage.natural)
    dump("forced ", storage.forced)
end)

script.on_nth_tick(20, function()
    dump("natural", storage.natural)

    if not storage.forced_done and game.tick >= FORCED_TICK then
        storage.forced_done = true
        local inv = storage.forced.get_inventory(defines.inventory.chest)
        local spoiled = 0
        for i = 1, #inv do
            local stack = inv[i]
            if stack.valid_for_read and string.find(stack.name, "overclocked") then
                local ok, err = pcall(function() stack.spoil() end)
                if ok then
                    spoiled = spoiled + 1
                    pr(string.format("forced spoil() on %s (stack of %d) at t=%d", stack.name, stack.count, game.tick))
                    break
                else
                    pr("spoil() failed: " .. tostring(err))
                end
            end
        end
        if spoiled == 0 then pr("forced: no spoilable stack found") end
        dump("forced ", storage.forced)
    end
end)
