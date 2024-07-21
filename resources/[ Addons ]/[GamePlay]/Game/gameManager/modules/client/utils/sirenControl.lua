---
--- @author Azagal
--- Create at [03/11/2022] 11:16:13
--- Current project [Valestia-V1]
--- File name [sirenControl]
---

local sirenControl = {}
sirenControl.config = nil

CreateThread(function()
    while ESX == nil do
        Wait(0)
    end

    while ESX.GetPlayerData() == nil or ESX.GetPlayerData().job == nil do
        Wait(0)
    end

    TriggerServerEvent("SirenControl:Request:LoadConfig")

    while (sirenControl.config == nil) do
        Wait(0)
    end

    while (not DecorIsRegisteredAsType("sirenControl.state", 2)) do
        DecorRegister("sirenControl.state", 2)
        Wait(0)
    end

    RegisterKeyMapping('sirenControl.active', 'Activer/Désactiver la sirène.', 'keyboard', 'LMENU')
    RegisterCommand("sirenControl.active", function()
        local playerPed = PlayerPedId()

        if (playerPed == 0 or not DoesEntityExist(playerPed)) then
            return
        end

        local playerVehicle = GetVehiclePedIsIn(playerPed, false)
        if (playerVehicle == 0) then
            return
        end

        local vehicleModel = GetEntityModel(playerVehicle)
        local findModel = false
        for i = 1, #sirenControl.config.vehicle do
            local currentModel = GetHashKey(sirenControl.config.vehicle[i])
            if (currentModel == vehicleModel) then
                findModel = true
            end
        end

        if (not findModel) then
            return
        end

        if (not DecorExistOn(playerVehicle, "sirenControl.state")) then
            DecorSetBool(playerVehicle, "sirenControl.state", true)
        end

        local currentSirensState = DecorGetBool(playerVehicle, "sirenControl.state")
        if (currentSirensState == 1) then
            currentSirensState = true
        elseif (currentSirensState == 1) then
            currentSirensState = false
        end

        TriggerServerEvent("SirenControl:Active", not currentSirensState)
    end)
end)

RegisterNetEvent("SirenControl:ManageState", function(netId, sirenState)
    if (netId == nil or tonumber(sirenState) == nil) then
        return
    end

    local selectedEntity = NetworkGetEntityFromNetworkId(netId)
    if (selectedEntity == 0 or not DoesEntityExist(selectedEntity)) then
        return
    end

    local sirenStateBool
    if (sirenState == 0) then
        sirenStateBool = true
    elseif (sirenState == 1) then
        sirenStateBool = false
    end

    DecorSetBool(selectedEntity, "sirenControl.state", sirenStateBool)
    SetVehicleHasMutedSirens(selectedEntity, sirenState)
end)

RegisterNetEvent("SirenControl:LoadConfig", function(loadedConfig)
    if (sirenControl.config == nil) then
        sirenControl.config = loadedConfig or {}
    end
end)