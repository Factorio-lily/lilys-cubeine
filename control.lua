
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