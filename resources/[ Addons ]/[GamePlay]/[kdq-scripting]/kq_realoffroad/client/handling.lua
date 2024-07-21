Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetPlayerVeh(), -1) == playerPed then
            local veh = GetPlayerVeh()

            if CURRENT_DEPTH > 0.05 and not IsBlacklisted(veh) then
                local generalUpgrade = GetVehicleGeneralUpgrades(veh)
                local turningUpgrade = math.floor(math.abs(GetVehicleSteeringAngle(veh)) / 1.5)

                local offroadTireUpgrade = 0
                if HasOffroadTires(veh) then
                    offroadTireUpgrade = Config.offroadTires.upgradeValue
                end

                local totalUpgrades = generalUpgrade + turningUpgrade + offroadTireUpgrade

                if IsAwd(veh) then
                    totalUpgrades = (totalUpgrades + (Config.awdUpgrade or 25)) * 1.3
                end

                local configMultiplier = Config.generalDepthDifficulty / 100
                local totalSlowdown = math.floor(math.max(0, (math.floor(CURRENT_DEPTH * 820 * configMultiplier) * (math.max(0.9, CURRENT_SOFTNESS / 70))) - totalUpgrades))

                if (math.abs(GetVehicleThrottleOffset(veh)) > 0.1) then
                    local dirtness = GetVehicleDirtLevel(veh)
                    SetVehicleDirtLevel(veh, dirtness + 0.1)
                end

                if IsMotorcycle(veh) then
                    SetVehicleHandbrake(veh, true)
                    Citizen.Wait(math.min(200, totalSlowdown))
                    SetVehicleHandbrake(veh, false)
                else
                    SetVehicleBurnout(veh, true)
                    Citizen.Wait(totalSlowdown)

                    SetVehicleBurnout(veh, false)

                    if (totalSlowdown > 250) then
                        SetVehicleBurnout(veh, true)
                    end
                end

                sleep = 40
            else
                sleep = 500
            end

        end

        Citizen.Wait(sleep)
    end
end)

if Config.generalTractionLoss > 0 then
    Citizen.CreateThread(function()
        while true do
            local sleep = 1000
            local playerPed = PlayerPedId()

            if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetPlayerVeh(), -1) == playerPed then
                sleep = 500
                local veh = GetVehiclePedIsIn(playerPed, false)

                if not IsBlacklisted(veh) and not IsInBlacklistedArea(veh) then
                    local traction = CURRENT_TRACTION

                    local driftThreshold = 1.3

                    if HasOffroadTires(veh) then
                        driftThreshold = 1.7
                        if CURRENT_SOFTNESS < 10 then
                            traction = traction + Config.offroadTires.tractionOnHard
                        else
                            traction = traction + Config.offroadTires.tractionOnSoft
                        end
                    end

                    if Config.roadSideHelper.enabled then
                        local nearestRoad = GetNearestRoadDistance()
                        if nearestRoad <= Config.roadSideHelper.distanceThreshold then
                            traction = 100 - math.floor((100 - traction) * Config.roadSideHelper.tractionMultiplier)
                        end
                    end

                    if traction <= 95 then
                        local drift = GetVehicleDrift(veh)

                        if drift > driftThreshold and (math.abs(GetVehicleThrottleOffset(veh)) > 0.1 or GetEntitySpeed(veh) > 5.0) and math.abs(GetVehicleSteeringAngle(veh)) > 0.2 then
                            if traction > 80 then
                                Citizen.Wait(100)
                            end
                            SetVehicleReduceTraction(veh, 1)
                            SetVehicleReduceGrip(veh, 1)
                            Citizen.Wait(200 - (CURRENT_TRACTION * (Config.generalTractionLoss / 100)))
                            SetVehicleReduceTraction(veh, 0)
                            SetVehicleReduceGrip(veh, 0)

                            if GetEntitySpeed(veh) > 8.0 then
                                SetVehicleHandbrake(veh, true)
                                Citizen.Wait(2)
                                SetVehicleHandbrake(veh, false)
                            end
                            sleep = 150
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function GetVehicleGeneralUpgrades(veh)
    return UseCache('generalUpgrades_' .. veh, function()
        local wheelSizeUpgrade = GetWheelSizeUpgrade(CURRENT_WHEELSIZE)
        local suspensionHeightUpgrade = math.floor((math.max(0.0, GetVehicleSuspenionHeight(veh) - 1.6)) * 150)
        local wheelCountUpgrade = math.max(0, (GetVehicleNumberOfWheels(veh) - 4)) * 9
        local massUpgrade = math.floor(GetMassUpgrade(veh))
        local classUpgrade = GetVehicleModelUgrade(veh)

        return wheelSizeUpgrade + suspensionHeightUpgrade + wheelCountUpgrade + massUpgrade + classUpgrade
    end, 500)
end

function GetWheelSizeUpgrade(wheelSize)
    return UseCache('wheelSizeMultiplier' .. wheelSize, function ()
        wheelSize = math.max(-0.05, wheelSize - 0.35)
        
        return math.max(1, math.floor(wheelSize * 250))
    end, 60000)
end
