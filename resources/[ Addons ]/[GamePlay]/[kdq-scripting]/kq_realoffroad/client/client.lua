local SINK_DEPTH = {}
local WHEELDEPTH = {}
local SENT_STATEBAGS = {}

CURRENT_DEPTH = 0.0
CURRENT_TRACTION = 100
CURRENT_SOFTNESS = 0
CURRENT_WHEELSIZE = 0.0

local REFRESH_RATE = math.max(100, math.min(500, Config.refreshRate or 200))

local wheelBones = {
    'hub_lf',
    'hub_rf',
    'hub_rr',
    'hub_lr',
}

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetPlayerVeh(), -1) == playerPed then
            local veh = GetPlayerVeh()
            if not IsBlacklisted(veh) then
                sleep = REFRESH_RATE

                if CURRENT_DEPTH == 0.0 then
                    sleep = sleep * 2
                end


                local vehCoords = GetEntityCoords(veh)

                local rain = UseCache('rainLevel', function()
                    return GetRainLevel()
                end, 10000)

                local mass = GetVehicleMass(veh)
                local vehSpeed = GetEntitySpeed(veh)

                local anyChanges = false

                local averageDepth = 0
                local averageWheelSizes = 0
                local averageTraction = 0
                local averageSoftness = 0

                local wheelCount = GetWheelCount(veh)

                for index = 0, wheelCount - 1 do
                    local surface = GetWheelSurface(veh, index)
                    local blacklisted = IsInBlacklistedArea(veh)

                    if surface then
                        local wheelSize = GetVehicleRealWheelSize(veh, index)

                        if wheelSize < 0.75 then
                            local realDepth = (surface.depth * 0.001)

                            if blacklisted then
                                realDepth = 0.0
                            end

                            if Config.roadSideHelper.enabled then
                                local nearestRoad = GetNearestRoadDistance()
                                if nearestRoad <= Config.roadSideHelper.distanceThreshold then
                                    realDepth = realDepth * Config.roadSideHelper.depthMultiplier
                                end
                            end

                            local zoneHash = GetNameOfZone(vehCoords)
                            local zoneMultiplier = GetZoneMultiplier(zoneHash)
                            realDepth = realDepth * zoneMultiplier

                            if not SINK_DEPTH[veh] then
                                SINK_DEPTH[veh] = {}
                            end

                            if not SINK_DEPTH[veh][index + 1] then
                                local wheelDepthState = GetWheelDepthState(index)
                                SINK_DEPTH[veh][index + 1] = Entity(veh).state[wheelDepthState] or 0.0
                            end

                            local sinkageSpeed = (0.003 * ((rain * 2) + 1)) * (1 + (surface.softness / 25))


                            local realWheelSpeed = GetVehicleWheelSpeed(veh, index) - vehSpeed

                            sinkageSpeed = sinkageSpeed * (math.max(1, realWheelSpeed)) * (math.max(600, math.min(2200, mass)) / 2000)

                            if realWheelSpeed < 1 and vehSpeed > 4 then
                                sinkageSpeed = sinkageSpeed - (0.01 * (vehSpeed / 2))
                            end

                            sinkageSpeed = sinkageSpeed * (REFRESH_RATE / 200)

                            if HasOffroadTires(veh) then
                                sinkageSpeed = sinkageSpeed * 0.7
                            end

                            if sinkageSpeed > 0 then
                                sinkageSpeed = sinkageSpeed * (Config.generalSinkageSpeed / 100)
                            end

                            if realDepth > SINK_DEPTH[veh][index + 1] or sinkageSpeed < 0 then
                                SINK_DEPTH[veh][index + 1] = math.max(0, SINK_DEPTH[veh][index + 1] + (realDepth * sinkageSpeed))
                            end

                            if SINK_DEPTH[veh][index + 1] > realDepth then
                                SINK_DEPTH[veh][index + 1] = realDepth
                            end

                            local wheelDepth = math.max(wheelSize - SINK_DEPTH[veh][index + 1], 0.12)

                            averageWheelSizes = averageWheelSizes + wheelSize
                            averageDepth = averageDepth + (wheelSize - wheelDepth)
                            averageSoftness = averageSoftness + surface.softness

                            local zoneTraction = GetZoneTraction(zoneHash)
                            local traction = 100 - math.floor((100 - surface.traction) * (zoneTraction or 1))
                            averageTraction = averageTraction + traction


                            if not WHEELDEPTH[veh] then
                                WHEELDEPTH[veh] = {}
                            end

                            if EasyRound(WHEELDEPTH[veh][index + 1] or 0) ~= EasyRound(wheelDepth) then
                                anyChanges = true

                                if not SENT_STATEBAGS[veh] then
                                    SENT_STATEBAGS[veh] = {}
                                end

                                local wheelDepthState = GetWheelDepthState(index)
                                if not SENT_STATEBAGS[veh][wheelDepthState] then
                                    SENT_STATEBAGS[veh][wheelDepthState] = true
                                    TriggerServerEvent('kq_realoffroad:server:createStatebag', NetworkGetNetworkIdFromEntity(veh), wheelDepthState, wheelDepth)
                                else
                                    Entity(veh).state:set(wheelDepthState, wheelDepth, true)
                                end
                            end

                            WHEELDEPTH[veh][index + 1] = wheelDepth
                        else
                            if CURRENT_DEPTH > 0.0 then
                                CURRENT_DEPTH = 0.0
                                CURRENT_WHEELSIZE = 0.0
                            end
                        end
                    end
                end

                if anyChanges then
                    HandleVehicleDepth(veh, true)
                end

                averageWheelSizes = averageWheelSizes / wheelCount
                averageDepth = averageDepth / wheelCount
                averageTraction = averageTraction / wheelCount
                averageSoftness = averageSoftness / wheelCount
                CURRENT_DEPTH = averageDepth
                CURRENT_WHEELSIZE = averageWheelSizes
                CURRENT_TRACTION = averageTraction
                CURRENT_SOFTNESS = averageSoftness
            elseif #SINK_DEPTH > 0 then
                SINK_DEPTH = {}
                CURRENT_DEPTH = 0.0
                CURRENT_TRACTION = 100
            end
        else
            if #SINK_DEPTH > 0 then
                SINK_DEPTH = {}
            end
        end
        Citizen.Wait(sleep)
    end
end)

function GetWheelSurface(veh, index)
    return UseCache('vehSurface_' .. veh .. '_' .. index, function()
        local surfaceId = GetVehicleWheelSurfaceMaterial(veh, index)
        local surface = Config.surfaces[surfaceId];
        if not surface then
            surface = Config.fallbackSurface
        end

        return surface
    end, 500)
end

local playerVehicles = {}
Citizen.CreateThread(function()
    while true do
        local newVehicles = {}
        local players = GetActivePlayers()
        local playerPed = PlayerPedId()

        for i = 1, #players, 1 do
            local ped = GetPlayerPed(players[i])
            if ped ~= playerPed then
                if IsPedInAnyVehicle(ped) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped)) < 75.0 then
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    if not Contains(newVehicles, vehicle) then
                        table.insert(newVehicles, vehicle)
                    end
                end
            end
        end

        playerVehicles = newVehicles

        Citizen.Wait(2500)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1500

        for i, veh in pairs(playerVehicles) do
            if DoesEntityExist(veh) then
                local didAnything = HandleVehicleDepth(veh, false)
                if didAnything then
                    sleep = math.floor(Config.refreshRate * 2.5)
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

function HandleVehicleDepth(veh, isCurrentVehicle)
    local didAnything = false

    if DoesEntityExist(veh) then
        local state = {}

        if isCurrentVehicle then
            state = WHEELDEPTH[veh]
        else
            state = Entity(veh).state
        end

        for index = 0, GetWheelCount(veh) -1 do
            local wheelDepth = 0
            if isCurrentVehicle then
                wheelDepth = state[index + 1]
            else
                local wheelDepthState = GetWheelDepthState(index)
                wheelDepth = state[wheelDepthState]
            end

            if GetWheelCount(veh) >= 3 then
                if wheelDepth ~= nil and wheelDepth > 0.01 and wheelDepth <= 1.5 then
                    if (EasyRound(wheelDepth) ~= EasyRound(GetVehicleWheelTireColliderSize(veh, index))) then
                        didAnything = true
                        SetVehicleWheelTireColliderSize(veh, index, wheelDepth + 0.0)

                        if Config.suspensionRefresh.enabled then
                            if Config.suspensionRefresh.type == 'force' then
                                SetVehicleDamage(veh, 0.0, 0.0, -100.0, 1000.0, 1.0, 1)
                            else
                                local flag = GetVehicleWheelFlags(veh, index)
                                if flag > 0 then
                                    SetVehicleWheelFlags(veh, index, flag + 2048)
                                    Citizen.Wait(1)
                                    if not DoesEntityExist(veh) then
                                        return false
                                    end
                                    SetVehicleWheelFlags(veh, index, flag)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return didAnything
end

function EasyRound(number)
    number = number * 1000

    if (number - (number % 0.1)) - (number - (number % 1)) < 0.5 then
        number = number - (number % 1)
    else
        number = (number - (number % 1)) + 1
    end
    return number / 1000
end
