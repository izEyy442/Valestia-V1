local cooldown = 0

RegisterNetEvent('kq_outfitbag:placeBag')
AddEventHandler('kq_outfitbag:placeBag', function(bag)
    if cooldown + 2000 < GetGameTimer() then
        cooldown = GetGameTimer()
        CreateBagObject(bag)
    end
end)

-- This function is responsible for creating the text shown on the bottom of the screen
function DrawMissionText(text, time)
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time or 30000, 1)
end


function TextInput(maxLen)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP9N", "", "", "", "", "", maxLen or 16)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(1);
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    
    return nil
end


-- This function is responsible for drawing all the 3d texts ('Press [E] to prepare for an engine swap' e.g)
function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


--- <!> No need to touch this part unless you know what you're doing <!>
--[[

The following function is called when player is done applying their outfit

`outfitData` is a table containing two values:
    - drawable (sub values = drawable, texture, palette)
    - props (sub values = prop, texture)
        These contain the ids of the drawables and props (key of the element is the drawable id and value is the drawable values)


`name` = name of the outfit that has been applied


This is how the script applies the outfit internally
------------------------------------------------------------
        for k, value in pairs(outfitData.drawable) do
            local id = drawable[k]
            SetPedComponentVariation(playerPed, id, value.drawable, value.texture, value.palette)
        end

        for k, value in pairs(outfitData.props) do
            local id = props[k]
            SetPedPropIndex(playerPed, id, value.prop, value.texture, true)
        end
------------------------------------------------------------
]]--
function OnPlayerApplyOutfit(outfitData, name)

end
