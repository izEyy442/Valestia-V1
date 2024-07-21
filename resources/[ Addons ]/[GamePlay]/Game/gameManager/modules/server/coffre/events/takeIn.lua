---
--- @author Azagal
--- Create at [23/10/2022] 12:08:13
--- Current project [Valestia-V1]
--- File name [takeIn]
---

RegisterNetEvent("VehicleTrunk:takeIn", function(netId, itemType, itemName, itemCount)
    local playerSrc = source
    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer or not netId or netId == 0) then
        return
    end

    local selectedEntity = NetworkGetEntityFromNetworkId(netId)
    if (selectedEntity == 0) then
        return
    end

    local vehiclePlate = GetVehicleNumberPlateText(selectedEntity)
    local vehicleModel = GetEntityModel(selectedEntity)

    local playerCoords = GetEntityCoords(GetPlayerPed(playerSrc))
    local entityCoords = GetEntityCoords(selectedEntity)
    if (#(playerCoords-entityCoords) > 10.0) then
        return
    end

    local selectedTrunk = VehicleTrunk.GetTrunkFromPlate(vehiclePlate)
    if (selectedTrunk ~= nil) then
        if (selectedTrunk:getModel() ~= vehicleModel) then
            return
        elseif (tonumber(selectedTrunk.inTrunk) ~= tonumber(playerSrc)) then
            return
        end

        if (xPlayer ~= nil) then
            if (itemType == "weapon" and xPlayer.hasWeapon(itemName)) then
                return xPlayer.showNotification("Vous avez déjà cette arme sur vous.")
            elseif (itemType == "weapon" and itemCount > 1) then
                itemCount = 1
            end

            if (itemType == "standard" and not xPlayer.canCarryItem(itemName, itemCount)) then
                return xPlayer.showNotification("Vous n'avez pas assez de place sur vous.")
            end

            selectedTrunk:removeItem(itemType, itemName, itemCount, function()
                if (itemType == "standard") then
                    xPlayer.addInventoryItem(itemName, itemCount)
                    xPlayer.showNotification("Vous avez retiré ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x"..itemCount.." "..ESX.GetItem(itemName).label.."~s~ du coffre.")
                elseif (itemType == "weapon") then
                    xPlayer.addWeapon(itemName, 0)
                    xPlayer.showNotification("Vous avez retiré ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x1 "..ESX.GetWeaponLabel(itemName).."~s~ du coffre.")
                end
                selectedTrunk:refreshForPlayer(playerSrc)
                --VehicleTrunk:logToDiscord("VehiculeTrunk (takeIn)", "Le joueur ("..playerSrc.." - "..GetPlayerName(playerSrc)..") ["..xPlayer.getIdentifier().."] vient de prendre un item ("..itemType..", "..itemName..", "..itemCount..") dans le coffre ["..selectedTrunk:getModel()..", "..selectedTrunk:getPlate().."].")
                SendLogs("Coffre Voiture", "Valestia | Trunk", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre "..itemCount.." item(s) (***"..itemType..", "..itemName.."***) dans le coffre avec la plaque **"..selectedTrunk:getPlate().."**", "https://discord.com/api/webhooks/1226957617939615774/7cET4s863aLjvIWabhtAv-xAFOK28BXltkoCCHRKXNanlbj9RUp5L0L6eAnxclfZOIrT")
            end)
        end
    else
        return
    end
end)