
data:extend({
    {
        type = "autoplace-control",
        name = "redleaf-cubeplants",
        category = "terrain",
        can_be_disabled = true
    },
    {
        type = "noise-expression",
        name = "redleaf_cubeplant_probability",
        intended_property = "probability",
        expression = "spot_noise{x = x,\z
                     y = y,\z
                     density_expression = spot_quantity_expression,\z
                     spot_quantity_expression = spot_quantity_expression,\z
                     spot_radius_expression = spot_radius_expression,\z
                     spot_favorability_expression = 1,\z
                     seed0 = map_seed,\z
                     seed1 = 951753,\z
                     region_size = 512,\z
                     candidate_point_count = 10 * var('control:redleaf-cubeplants:frequency'),\z
                     hard_region_target_quantity = 0,\z
                     basement_value = 0,\z
                     maximum_spot_basement_radius = 128} * (gleba_highland + nauvis_plateaus" .. (mods["Moshine"] and " + fulgora_dunes" or "") .. (mods["cubium"] and " + cubium_ashlands_biome" or "") ..  ")",
        local_expressions =
        {
            spot_radius_expression = "4 * sqrt(var('control:redleaf-cubeplants:size'))",
            spot_quantity_expression = "pi/90 * spot_radius_expression ^ 3"
        }
    },
    {
        type = "noise-expression",
        name = "redleaf_cubeplant_richness",
        intended_property = "richness",
        expression = "clamp(random_penalty_at(6, 1), 0, 1)"
    }
})

if settings.startup["nauvis-spawn"].value then
    local nauvis = data.raw.planet.nauvis
    nauvis.map_gen_settings.autoplace_controls["redleaf-cubeplants"] = {}
end

if settings.startup["gleba-spawn"].value then
    local gleba = data.raw.planet.gleba
    gleba.map_gen_settings.autoplace_controls["redleaf-cubeplants"] = {}
end

if mods["cubium"] and settings.startup["cubium-spawn"].value then
    local cubium = data.raw.planet.cubium
    cubium.map_gen_settings.autoplace_controls["redleaf-cubeplants"] = {}
end

if mods["terrapalus"] and settings.startup["terrapalus-spawn"].value  then
    local cubium = data.raw.planet.terrapalus
    cubium.map_gen_settings.autoplace_controls["redleaf-cubeplants"] = {}
end

if mods["Moshine"] and settings.startup["moshine-spawn"].value then
    local moshine = data.raw.planet.moshine
    moshine.map_gen_settings.autoplace_controls["redleaf-cubeplants"] = {}
end
