

if mods["se-space-trains"] then
    
    local battery_discharged = data.raw["item"]["space-train-discharged-battery-pack"]
    local c_battery_discharged = data.raw["item"]["cubeine-space-train-discharged-battery-pack"]

    c_battery_discharged.weight = battery_discharged.weight

    local battery_charged = data.raw["item"]["space-train-battery-pack"]
    local c_battery_charged = data.raw["item"]["space-train-battery-pack"]

    c_battery_charged.weight = battery_charged.weight

    local battery_fried = data.raw["item"]["space-train-destroyed-battery-pack"]
    local c_battery_fried = data.raw["item"]["cubeine-space-train-destroyed-battery-pack"]

    if (battery_fried) then 
        c_battery_fried.weight = battery_fried.weight
    else
        c_battery_fried.weight = battery_discharged.weight
    end


end
