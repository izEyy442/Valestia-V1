---
--- @author Azagal
--- Create at [23/10/2022] 12:05:41
--- Current project [Valestia-V1]
--- File name [putIn]
---

RegisterNetEvent("VehicleTrunk:putIn", function(netId, itemType, itemName, itemCount)
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
            local hasItem
            if (itemType == "standard") then
                local playerItem = xPlayer.getInventoryItem(itemName)
                if (playerItem ~= nil and playerItem.count >= itemCount) then
                    hasItem = true
                end
            elseif (itemType == "weapon") then
                local isPermanent = ESX.IsWeaponPermanent(string.upper(itemName))
                local playerHasWeapon = xPlayer.hasWeapon(itemName)
                if (playerHasWeapon and not isPermanent) then
                    hasItem = true
                end
            end

            if (hasItem == true) then
                selectedTrunk:addItem(itemType, itemName, itemCount, function()
                    if (itemType == "standard") then
                        xPlayer.removeInventoryItem(itemName, itemCount)
                        xPlayer.showNotification("Vous avez déposé ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x"..itemCount.." "..ESX.GetItem(itemName).label.."~s~ dans le coffre.")
                    elseif (itemType == "weapon") then
                        xPlayer.removeWeapon(itemName);
                        xPlayer.showNotification("Vous avez déposé ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x1 "..ESX.GetWeaponLabel(itemName).."~s~ dans le coffre.")
                    end
                    selectedTrunk:refreshForPlayer(playerSrc)
                    --VehicleTrunk:logToDiscord("VehiculeTrunk (putIn)", "Le joueur ("..playerSrc.." - "..GetPlayerName(playerSrc)..") ["..xPlayer.getIdentifier().."] vient de déposer un item ("..itemType..", "..itemName..", "..itemCount..") dans le coffre ["..selectedTrunk:getModel()..", "..selectedTrunk:getPlate().."].")
                    SendLogs("Coffre Voiture", "Valestia | Trunk", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de déposer "..itemCount.." item(s) (***"..itemType..", "..itemName.."***) dans le coffre avec la plaque **"..selectedTrunk:getPlate().."**", "https://discord.com/api/webhooks/1226957617939615774/7cET4s863aLjvIWabhtAv-xAFOK28BXltkoCCHRKXNanlbj9RUp5L0L6eAnxclfZOIrT")
                end)
            end
        end
    else
        return
    end
end)