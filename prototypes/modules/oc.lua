--overclock effect table, lines = overclock levels
-- b - boost effect
-- d - degrade chance
-- x - destroy chance
-- t - effect duration
-- db - degraded boost effect
-- dx - degraded destroy chance
local hour = 60 * 60 * 60
return {
    { b = 1.2, t = hour,         d = 0.2, x = 0,   db = 1.4, dx = 0,   su = 0 },                                                         --safe
    { b = 1.5, t = hour,         d = 0.5, x = 0,   db = 2,   dx = 0,   su = 0 },                                                         --mostly safe
    { b = 1.8, t = hour,         d = 0.8, x = 0,   db = 2.2, dx = 0.2, su = 0 },                                                         -- unsafe
    { b = 2.5, t = hour,         d = 1,   x = 0.2, db = 3,   dx = 0.5, su = settings.startup["hyper-allowed"].value and 0.01 or 0 },     -- dangerous
    { b = 4,   t = hour * 2 / 3, d = 1,   x = 0.4, db = 6,   dx = 0.7, su = settings.startup["hyper-allowed"].value and 0.03 or 0 },     --extreme
    { b = 6,   t = hour / 2,     d = 1,   x = 1,   db = 10,  dx = 1,   su = settings.startup["hyper-allowed"].value and 0.05 or 0 },     --burnout
}
