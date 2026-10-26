-- Scratch harness data stage: make the modules spoil fast enough to observe in a
-- short benchmark run. Only the staged copy of the test env is affected.
local SHORT_SPOIL_TICKS = 120 -- 2 s

for name, module in pairs(data.raw["module"] or {}) do
    if string.find(name, "%-overclocked%-") then
        module.spoil_ticks = SHORT_SPOIL_TICKS
    end
end
