---
--- @author Azagal
--- Create at [28/10/2022] 15:08:31
--- Current project [Silky-V1]
--- File name [_main]
---

Taxi = Taxi or {}
Taxi.Config = nil;
local loopLaunched = false

local function initPlayer()
    local playerData = ESX.GetPlayerData()
    loopLaunched = true

    while playerData ~= nil and playerData.job ~= nil and playerData.job.name == "taxi" do
        local loopInterval = 1000
        playerData = ESX.GetPlayerData()

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if (#(playerCoords-Taxi.Config.vehicle.menuPosition) < 2.0) then
            loopInterval = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.")
                if IsControlJustPressed(0, 51) then
                    CreateThread(function()
                        Taxi:vehicleMenu()
                    end)
                end
        elseif (#(playerCoords-Taxi.Config.vehicle.menuPosition) < 10.0) then
            loopInterval = 0
            DrawMarker(Config.Get.Marker.Type, Taxi.Config.vehicle.menuPosition, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
        end

        local storePosition = Taxi.Config.vehicle.storePosition
        for i = 1, #storePosition do
            local currentPosition = storePosition[i]
            if (currentPosition ~= nil) then
                local currentPedVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if currentPedVehicle ~= 0 and DoesEntityExist(currentPedVehicle) then
                    loopInterval = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule.")
                    if IsControlJustPressed(0, 51) then
                        TriggerServerEvent("Taxi:Store:Vehicle")
                    end
                end
            end
        end

        Wait(loopInterval)
    end

    loopLaunched = false
end

CreateThread(function()
    while (ESX == nil) do
        Wait(0)
    end

    while (ESX.GetPlayerData() == nil or ESX.GetPlayerData().job == nil) do
        Wait(0)
    end

    TriggerServerEvent("Taxi:request:loadConfig")

    while (Taxi.Config == nil) do
        Wait(0)
    end

    local playerData = ESX.GetPlayerData()
    if (playerData ~= nil) then
        if (playerData.job ~= nil and playerData.job.name == "taxi" and not loopLaunched) then
            initPlayer()
        end
    end
end)

AddEventHandler('esx:setJob', function(job)
    if (job ~= nil and job.name == "taxi" and not loopLaunched) then
        while (ESX.GetPlayerData().job["name"] ~= job.name) do
            Wait(0)
        end
        initPlayer()
    end
end)

RegisterNetEvent("Taxi:loadConfig", function(taxiConfig)
    Taxi.Config = taxiConfig;

    local enterpriseData = Taxi.Config["enterprise"]
    if (enterpriseData ~= nil) then
        local createdBlip = AddBlipForCoord(enterpriseData.position)
        SetBlipSprite(createdBlip, enterpriseData.blip.sprite)
        SetBlipDisplay(createdBlip, enterpriseData.blip.display)
        SetBlipScale(createdBlip, enterpriseData.blip.scale)
        SetBlipAsShortRange(createdBlip, true)
        SetBlipColour(createdBlip, enterpriseData.blip.coulour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(enterpriseData.label)
        EndTextCommandSetBlipName(createdBlip)
    end
end)