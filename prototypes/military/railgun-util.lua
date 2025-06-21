local part = table.deepcopy(data.raw["optimized-particle"]["railgun-shell-particle"])
part.name = "cubeine-railgun-shell-particle"
part.pictures = {
    sheet =
    {
        filename = "__lilys-cubeine__/graphics/entity/railgun-shell.png",
        width = 42,
        height = 40,
        shift = util.by_pixel(1.0, -1.5),
        line_length = 12,
        frame_count = 12,
        variation_count = 4,
        animation_speed = 1,
        scale = 0.5
    }
}




local remnant = {
    type = "corpse",
    name = "cubeine-railgun-turret-remnants",
    icon = "__lilys-cubeine__/graphics/icons/railgun-turret.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "defensive-structure-remnants",
    order = "a-c-a",
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet (3,
    {
      layers =
      {
        util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/railgun-turret/remnants/railgun-turret-remnants",
        {
          line_length = 1,
          direction_count = 1,
          shift = util.by_pixel(0, 0),
          scale = 0.5
        }),
        util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/railgun-turret/remnants/railgun-turret-remnants-mask",
        {
          priority = "low",
          line_length = 1,
          apply_runtime_tint = true,
          direction_count = 1,
          shift = util.by_pixel(0, 0),
          scale = 0.5
        })
      }
    })
  }

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ part, remnant })
