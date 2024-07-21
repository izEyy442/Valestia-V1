local ESX = nil
local jobsData = {};

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

RegisterNetEvent('jobbuilder:restarted', function(player)

    ESX.PlayerData = player
    PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end);

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

local JobBuilder = {
    Garage = {},
};

function GarageMenu()
    local MenuG = RageUIJob.CreateMenu("", JobBuilder.Garage.Label)

      RageUIJob.Visible(MenuG, not RageUIJob.Visible(MenuG))

          while MenuG do

              Citizen.Wait(0)

                  RageUIJob.IsVisible(MenuG, true, true, true, function()

                      RageUIJob.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                          if dist4 < 4 then
                              DeleteEntity(veh)
                              end
                          end
                      end)

                      RageUIJob.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~↓ Véhicule disponible ↓")


                    for k,v in pairs(json.decode(JobBuilder.Garage.vehInGarage)) do
                      RageUIJob.ButtonWithStyle(v.label, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                            -- TONIO HERE
                              SpawnCar(v.model, JobBuilder.Garage.Label)
                              RageUIJob.CloseAll()
                            end
                        end)
                    end


                  end, function()
                  end)

              if not RageUIJob.Visible(MenuG) then
                MenuG = RMenu:DeleteType("MenuG", true)
          end
      end
end

function SpawnCar(car, name)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local PosSpawn = vector3(json.decode(JobBuilder.Garage.PosVehSpawn).x, json.decode(JobBuilder.Garage.PosVehSpawn).y, json.decode(JobBuilder.Garage.PosVehSpawn).z)
    local vehicle = CreateVehicle(car, PosSpawn, GetEntityHeading(PlayerPedId()), true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for k,v in pairs(jobsData) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name then
                local plyPos = GetEntityCoords(PlayerPedId())
                local Garage = vector3(json.decode(v.PosGarage).x, json.decode(v.PosGarage).y, json.decode(v.PosGarage).z)
                local dist = #(plyPos-Garage)
                if dist <= 20.0 then
                    Timer = 0
                    DrawMarker(2, Garage, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 45,110,185, 255, 0, 1, 0, 0, nil, nil, 0)
                end
                if dist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage")
                    if IsControlJustPressed(1,51) then
                        JobBuilder.Garage = v
                        local coords = json.decode(v.PosVehSpawn);
                        ESX.OpenSocietyGarage(v.Name, vector4(coords.x, coords.y, coords.z, coords.w));
                        --GarageMenu()
                    end
                end
            end
        end
        Citizen.Wait(Timer)
    end
end)

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for k,v in pairs(jobsData) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name then

                local coords = json.decode(v.vehInGarage);
                local coords_decode = vector3(coords.x, coords.y, coords.z);

                local ped = PlayerPedId()
                local plyPos = GetEntityCoords(PlayerPedId());
                local dist = #(plyPos-coords_decode);

                local vehicle = GetVehiclePedIsIn(ped, false);

                if (dist <= 30.0) then

                    Timer = 0

                    if (vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped) then

                        if dist <= 20.0 then
                            DrawMarker(2, coords_decode, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 45,110,185, 255, 0, 1, 0, 0, nil, nil, 0)
                        end

                        if dist <= 3.0 then

                            local plate = GetVehicleNumberPlateText(vehicle);

                            ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour ranger le garage")
                            if IsControlJustPressed(1,51) then
                                ESX.ParkSocietyVehicle(v.Name, plate);
                                --GarageMenu()
                            end
                        end
                    end

                end

            end
        end
        Citizen.Wait(Timer)
    end
end)