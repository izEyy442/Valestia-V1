---
--- @author Azagal
--- Create at [01/11/2022] 19:03:20
--- Current project [Silky-V1]
--- File name [storeVehicle]
---

RegisterNetEvent("Taxi:Store:Vehicle", function()
    local playerSrc = source
    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    local playerJob = xPlayer.getJob()
    if (playerJob ~= nil and playerJob.name ~= "taxi") then
        return
    end

    local playerPed = GetPlayerPed(playerSrc)
    local playerCoords = GetEntityCoords(playerPed)

    local playerIsOnPos = false
    local storePosition = Taxi.Config.vehicle.storePosition
    for i = 1, #storePosition do
        local currentPosition = storePosition[i]
        if (currentPosition ~= nil) then
            if (#(playerCoords-currentPosition) < 2.0) then
                playerIsOnPos = true
            end
        end
    end

    if (not playerIsOnPos) then
        return
    end

    local currentPedVehicle = GetVehiclePedIsIn(playerPed, false)
    if (currentPedVehicle ~= 0 and DoesEntityExist(currentPedVehicle) and GetEntityModel(currentPedVehicle) == Taxi.Config.vehicle.model[GetEntityModel(currentPedVehicle)].model) then
        DeleteEntity(currentPedVehicle)
        xPlayer.showNotification("Vous avez ~g~rangé~s~ votre ~y~véhicule~s~.")
    end
end)