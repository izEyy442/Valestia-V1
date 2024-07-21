---
--- @author Azagal
--- Create at [23/10/2022] 12:06:49
--- Current project [Valestia-V1]
--- File name [open]
---

RegisterNetEvent("VehicleTrunk:open", function(netId)
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

    if (GetVehicleDoorLockStatus(selectedEntity) == 2) then
        return TriggerClientEvent("esx:showNotification", playerSrc, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Ce coffre est fermé.")
    else
        local selectedTrunk = VehicleTrunk.GetTrunkFromPlate(vehiclePlate)
        if (not selectedTrunk) then
            local hasOwner
            MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
                ['@plate'] = vehiclePlate
            }, function(result)
                if (not result[1]) then
                    hasOwner = false
                else
                    result[1].vehicle = json.decode(result[1].vehicle)
                    if (result[1].vehicle["model"] ~= vehicleModel) then
                        hasOwner = false
                    else
                        hasOwner = true
                    end
                end
            end)

            while (hasOwner == nil) do
                Wait(250)
            end

            selectedTrunk = VehicleTrunk:new(vehicleModel, vehiclePlate, hasOwner, false)
        end

        while (not selectedTrunk) do
            Wait(250)
        end

        if (selectedTrunk:getModel() == vehicleModel) then
            selectedTrunk:open(playerSrc, netId)
        else
            return
        end
    end
end)