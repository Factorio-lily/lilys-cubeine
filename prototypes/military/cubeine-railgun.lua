
require("prototypes.military.railgun-util")



local item = table.deepcopy(data.raw["item"]["railgun-turret"])
item.name = "cubeine-railgun-turret"
item.place_result = "cubeine-railgun-turret"
item.order = item.order .. "-cubeine"
item.icon = "__lilys-cubeine__/graphics/icons/railgun-turret.png"
item.icons = {
    {
        icon = "__lilys-cubeine__/graphics/icons/railgun-turret.png",
        icon_size = 64
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 6, 6 }
    }
}




local turret = table.deepcopy(data.raw["ammo-turret"]["railgun-turret"])
turret.name = "cubeine-railgun-turret"
turret.minable.result = "cubeine-railgun-turret"
turret.icon = "__lilys-cubeine__/graphics/icons/railgun-turret.png"
turret.icons = {
    {
        icon = "__lilys-cubeine__/graphics/icons/railgun-turret.png",
        icon_size = 64
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 6, 6 }
    }
}
turret.max_health = 10000
turret.corpse = "cubeine-railgun-turret-remnants"

turret.energy_source =
{
  type = "electric",
  buffer_capacity = "25MJ",
  input_flow_limit = "50MW",
  usage_priority = "primary-input"
}
turret.energy_per_shot = "25MJ"
turret.rotation_speed = 0.005 * 4
turret.preparing_speed = 0.04 * 8
turret.folding_speed = 0.04 * 2
turret.attacking_speed = 0.35 * 1
turret.starting_attack_speed = 0.02 * 10
turret.ending_attack_speed = 0.05 * 10

turret.graphics_set =
{
  base_visualisation =
  {
        animation = require("__lilys-cubeine__.prototypes.military.railgun-turret-pictures").base_picture
  }
}
turret.preparing_animation = require("__lilys-cubeine__.prototypes.military.railgun-turret-pictures").neutral_animation
turret.prepared_animation = require("__lilys-cubeine__.prototypes.military.railgun-turret-pictures").aiming_animation
turret.starting_attack_animation = require("__lilys-cubeine__.prototypes.military.railgun-turret-pictures").warmup_animation
turret.attacking_animation = require("__lilys-cubeine__.prototypes.military.railgun-turret-pictures").shooting_animation
turret.ending_attack_animation = require("__lilys-cubeine__.prototypes.military.railgun-turret-pictures").cooldown_animation
turret.folding_animation = require("__lilys-cubeine__.prototypes.military.railgun-turret-pictures").neutral_animation
turret.folded_animation = require("__lilys-cubeine__.prototypes.military.railgun-turret-pictures").neutral_animation
turret.resource_indicator_animation = require("__lilys-cubeine__.prototypes.military.railgun-turret-pictures").resource_indicator_animation

turret.attack_parameters.cooldown = turret.attack_parameters.cooldown / 2
turret.attack_parameters.min_range = 5
turret.attack_parameters.range = 50

turret.attack_parameters.shell_particle.name = "cubeine-railgun-shell-particle"
turret.resistances = {
    {
        type = "physical",
        decrease = 100,
        percent = 50
    },
    {
        type = "explosion",
        decrease = 1000,
        percent = 90
    },
    {
        type = "acid",
        decrease = 20,
        percent = 90
    },
    {
        type = "fire",
        decrease = 0,
        percent = 100
    },
    {
        type = "impact",
        decrease = 500,
        percent = 90
    },
    {
        type = "poison",
        decrease = 0,
        percent = 100
    },
    {
        type = "electric",
        decrease = 0,
        percent = 95
    },
    {
        type = "laser",
        decrease = 50,
        percent = 30
    }
}

local recipe = {
    type = "recipe",
    name = "cubeine-railgun-turret",
    enabled = false,
    energy_required = 60,
    category = "metallurgy",
    ingredients = {
        { type = "item", name = "railgun-turret",     amount = 1 },
        { type = "item", name = "refined-concrete", amount = 1000 },
        { type = "item", name = "tungsten-plate", amount = 500 },
        { type = "item", name = "low-density-structure", amount = 500 },
        { type = "item", name = "cubeine-crystal",       amount = 100 },
        { type = "item", name = "speed-module-3",       amount = 20 },
        { type = "fluid", name = "lubricant",        amount = 5000 },
        { type = "fluid", name = "fluoroketone-cold",        amount = 5000 },
     },
    results = { { type = "item", name = "cubeine-railgun-turret", amount = 1 } }
}

local tech = {
    type = "technology",
    name = "cubeine-railgun-turret",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/technology/railgun.png",
            icon_size = 256,
        }

    },
    prerequisites = { "cubeine-military-2", "railgun" },

    unit = {
        count = 50000,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "military-science-pack",   2 },
            { "metallurgic-science-pack",  2 },
            { "electromagnetic-science-pack",  2 },
            { "cryogenic-science-pack",  1 },
        },
        time = 60

    },

    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "cubeine-railgun-turret"
        },
    }
}

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({item, turret, recipe, tech})