-- Cubeine integration probe.
--
-- on_init (which --create runs, with no ticks) flattens a patch of Nauvis and places every
-- Cubeine building whose texture sheets were re-mastered, so the save the GUI run loads
-- already contains the scene.  The screenshot schedule then fires on absolute ticks while
-- the real renderer is up: three zoom levels on the two buildings the asset card named
-- (the drill and the fusion reactor) plus one wide shot of the whole row.
--
-- A GUI load that reaches tick 60 proves the sprite atlas built, i.e. no missing file and
-- no sprite rectangle outside its texture -- the one class of error no headless run sees.

local SUBJECTS = {
    { label = "drill",      name = "cubeine-giga-thermal-drill", position = { -14, -12 } },
    { label = "reactor",    name = "cubeine-fusion-reactor",     position = { 0, -12 } },
    { label = "generator",  name = "cubeine-fusion-generator",   position = { 13, -12 } },
    { label = "tower",      name = "cubeine-agricultural-tower", position = { -14, 2 } },
    { label = "biochamber", name = "cubeine-biochamber",         position = { 0, 2 } },
    { label = "combustion", name = "cubeine-combustion-center",  position = { 11, 2 } },
    { label = "furnace",    name = "cubeine-plasma-furnace",     position = { -14, 14 } },
    { label = "turbine",    name = "cubeine-gas-turbine",        position = { 0, 14 } },
    { label = "railgun",    name = "cubeine-railgun-turret",     position = { 10, 14 } },
}

local SHOT_GROUPS = {
    -- zoom rises = closer in on this build (measured: 0.25 shows 4x more world than 1.0),
    -- so 1.0 is the "looks the same" reference and 2.0 / 4.0 are the zoomed-past-1:1 checks.
    { label = "drill",   position = { -14, -12 }, zooms = { 1.0, 2.0, 4.0 } },
    { label = "reactor", position = { 0, -12 },   zooms = { 1.0, 2.0, 4.0 } },
    { label = "scene",   position = { -1, 1 },    zooms = { 1.0 } },
}

local SHOTS, LAST_TICK = {}, nil
do
    local tick = 60
    for _, group in ipairs(SHOT_GROUPS) do
        for _, zoom in ipairs(group.zooms) do
            SHOTS[#SHOTS + 1] = { tick = tick, label = group.label,
                                  position = group.position, zoom = zoom }
            tick = tick + 40                    -- 40 ticks apart: the engine renders between shots
        end
    end
    LAST_TICK = tick
end

local function pr(msg)
    log("[integprobe] " .. msg)
end

local function build_scene()
    local surface = game.surfaces[1]
    surface.request_to_generate_chunks({ 0, 0 }, 6)
    surface.force_generate_chunk_requests()

    local tiles = {}
    for x = -34, 34 do
        for y = -24, 24 do
            tiles[#tiles + 1] = { position = { x, y }, name = "refined-concrete" }
        end
    end
    surface.set_tiles(tiles)

    for _, e in pairs(surface.find_entities_filtered {
        area = { { -36, -26 }, { 36, 26 } },
        type = { "tree", "simple-entity", "unit", "unit-spawner", "resource", "cliff" },
    }) do
        e.destroy()
    end

    local placed, failed = 0, {}
    for _, subject in ipairs(SUBJECTS) do
        local ok, entity = pcall(surface.create_entity, {
            name = subject.name, position = subject.position,
            force = game.forces.player, raise_built = true,
        })
        if ok and entity and entity.valid then
            placed = placed + 1
            pr(string.format("placed %s (%s) at %s", subject.label, subject.name,
                serpent.line(subject.position)))
        else
            failed[#failed + 1] = subject.name .. ": " .. tostring(entity)
        end
    end
    pr(string.format("scene built: %d/%d placed", placed, #SUBJECTS))
    for _, line in ipairs(failed) do
        pr("PLACE FAILED " .. line)
    end
end

script.on_init(build_scene)

local function take(shot)
    local path = string.format("integ/%s-z%s.png", shot.label,
                               string.format("%.2f", shot.zoom))
    local ok, err = pcall(game.take_screenshot, {
        player = game.players[1],
        position = shot.position,
        resolution = { 1920, 1080 },
        zoom = shot.zoom,
        path = path,
        show_gui = false,
        hide_fog = true,
        hide_health_bars = true,
        hide_clouds = true,
    })
    pr(string.format("shot %s zoom=%.2f path=%s ok=%s %s", shot.label, shot.zoom, path,
                     tostring(ok), ok and "" or tostring(err)))
end

script.on_nth_tick(20, function(event)
    for _, shot in ipairs(SHOTS) do
        if shot.tick == event.tick then
            take(shot)
        end
    end
    if event.tick == LAST_TICK + 60 then
        pr("INTEG PROBE DONE")
    end
end)
