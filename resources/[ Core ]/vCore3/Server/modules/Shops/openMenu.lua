---
--- @author Kadir#6666
--- Create at [19/04/2023] 12:46:08
--- Current project [Valestia-V1]
--- File name [openMenu]
---

RegisterNetEvent("Shops:RequestToOpen", function(shpId)

    local playerSrc = source

    local selectedShp = ShopsManager.GetFromId(shpId)
    if (selectedShp == nil) then
        return
        -- TODO : Kick Player
    end

    local playerIsOnPos
    for pos = 1, #selectedShp.positions do
        if (#(GetEntityCoords(GetPlayerPed(playerSrc))-selectedShp.positions[pos]) < 3.0) then
            playerIsOnPos = true
            break
        end
    end

    if (playerIsOnPos ~= true) then
        return
        -- TODO : Ban Player
    end
    TriggerClientEvent("Shops:OpeningMenu", playerSrc, shpId, ClientCanAccessFood)

end)