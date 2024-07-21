ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local isActive = false

AddEventHandler("gameEventTriggered", function(name, args)
    if name == "CEventNetworkPlayerEnteredVehicle" then
        if not isActive then
            while true do
                local playerPed = PlayerPedId()
                if IsPedInAnyVehicle(playerPed, false) then

                    local veh = GetVehiclePedIsIn(playerPed, false)
                    local engin = GetVehicleEngineHealth(veh)
                    local clasee = GetVehicleClass(veh)
                    
                    SetVehicleDamageModifier(veh,2.0)
                    SetDisableVehicleEngineFires(true)
                    if engin > 1 and engin < 500 then
                        ESX.ShowNotification("le moteur du véhicule est ~y~hors-service")
                        local soundId3 = GetSoundId()
                        PlaySoundFrontend(soundId3,"Engine_fail", "DLC_PILOT_ENGINE_FAILURE_SOUNDS", true)
                        SetVehicleEngineHealth(veh,-4000.0)
                        Wait(5000)
                        SetVehicleEngineHealth(veh,0.0)
                    end

                    if clasee == 15 or clasee == 16 then
                        if IsVehicleTyreBurst(veh, 4) then
                            SetEntityMaxSpeed(veh,6.94444)
                        end
                    elseif clasee == 8 then

                        if IsVehicleTyreBurst(veh, 0) and IsVehicleTyreBurst(veh, 4) then
                            SetEntityMaxSpeed(veh,0)
                        elseif  IsVehicleTyreBurst(veh, 0)  or IsVehicleTyreBurst(veh, 4)   then
                            SetEntityMaxSpeed(veh,6.94444)
                        end

                    else

                        if IsVehicleTyreBurst(veh, 0) then
                            rag = 25
                        else
                            rag = 0
                        end

                        if IsVehicleTyreBurst(veh, 1) then
                            rad = 25 
                        else
                            rad = 0
                        end

                        if IsVehicleTyreBurst(veh, 4) then
                            rarg = 25 
                        else
                            rarg = 0
                        end

                        if IsVehicleTyreBurst(veh, 5) then
                            rard = 25
                        else
                            rard = 0
                        end

                        if  rag + rad + rard + rarg >= 50 then
                            SetVehicleEngineOn(veh,false,false,false)
                        end

                    end
                else
                    isActive = false
                    break
                end
                Wait(1000)
            end
        end
    end
end)