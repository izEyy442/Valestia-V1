-- This function is responsible for all the tooltips displayed on top right of the screen, you could
-- replace it with a custom notification etc.
function ShowTooltip(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, 2000)
end

-- This function is responsible for drawing all the 3d texts ('Press [E] to ...' e.g)
function Draw3DText(coords, textInput)
    SetTextScale(0.25, 0.25)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentSubstringKeyboardDisplay(textInput)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


if Config.debug then
    local surfaceDebug = false

    RegisterCommand('surfaceDebug', function(s, args)
        if args[1] and (args[1] == 'off' or args[1] == 'false') then
            surfaceDebug = false
        else
            surfaceDebug = true
        end
    end)

    local wheelBones = {
        'hub_lf',
        'hub_rf',
        'hub_rr',
        'hub_lr',
    }

    Citizen.CreateThread(function()
        while true do
            local sleep = 3000
            local playerPed = PlayerPedId()

            if surfaceDebug and IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetPlayerVeh(), -1) == playerPed  then
                sleep = 0

                local veh = GetPlayerVeh()
                local vehCoords = GetEntityCoords(veh)
    
                local nearestRoad = GetNearestRoadDistance()
                Draw3DText(vehCoords + vector3(0.0, 0.0, -0.3), '~w~Closest road: ' .. nearestRoad)
                
                
                local zoneHash = GetNameOfZone(vehCoords)
                local zoneData = GetZoneData(zoneHash)
                if zoneData then
                    Draw3DText(vehCoords, '~y~Zone: ' .. zoneHash .. ' ~w~(' .. zoneData.name .. ' | dpth: x' .. zoneData.depthMultiplier .. ' | trcn: x' .. zoneData.tractionMultiplier .. ')')
                else
                    Draw3DText(vehCoords, '~y~Zone: ' .. zoneHash)
                end

                Draw3DText(vehCoords + vector3(0.0, 0.0, -0.4), '~b~Traction: ' .. (CURRENT_TRACTION or 100))

                local isBlacklistedArea, blacklistArea = IsInBlacklistedArea(veh)
                if isBlacklistedArea then
                    DrawSphere(blacklistArea.coords, blacklistArea.radius, 200, 0, 0, 0.5)
                    Draw3DText(vehCoords - vector3(0.0, 0.0, -0.4), '~r~In blacklisted area')
                end

                for index = 0, GetVehicleNumberOfWheels(veh) -1 do
                    local surfaceId = GetVehicleWheelSurfaceMaterial(veh, index)

                    if index + 1 <= #wheelBones then
                        local boneIndex = GetEntityBoneIndexByName(veh, wheelBones[index + 1])
                        local coords = GetWorldPositionOfEntityBone(veh, boneIndex)

                        if Config.surfaces[surfaceId] then
                            local data = Config.surfaces[surfaceId]
                            Draw3DText(coords, '~g~[~w~' .. surfaceId .. '~g~]\n~w~' .. data.name .. '~g~\nTraction ' .. data.traction .. '\nDepth ' .. data.depth .. '\nSoftness ' .. data.softness)
                        else
                            Draw3DText(coords, '~r~' .. surfaceId)
                        end
                    end
                end
            end

            Citizen.Wait(sleep)
        end
    end)
end

function GetNearestRoadDistance()
    return UseCache('nearestRoad', function()
        local coords = GetEntityCoords(PlayerPedId())
        local ret, p5, p6 = GetClosestRoad(coords.x, coords.y, coords.z, 1.0, 0, 1)
        local dist1 = GetDistanceBetweenCoords(p5, coords, false)
        local dist2 = GetDistanceBetweenCoords(p6, coords, false)
    
        return math.min(dist1, dist2)
    end, 1000)
end

function HasOffroadTires(veh)
    return UseCache('hasOffroadTires_' .. veh, function()
        return GetVehicleWheelType(veh) == 4
    end, 5000)
end

function GetVehicleSuspenionHeight(veh)
    local min, max = GetVehicleSuspensionBounds(veh)
    return math.abs(min.z) + max.z
end

function GetMassUpgrade(veh)
    return UseCache('weightUpgrade' .. veh, function()
        local mass = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fMass')
        
        local upgrade = 0
        if mass > 1300 then
            upgrade = (1300 - mass) / 60
        else
            upgrade = (1300 - mass) / 10
        end

        if GetWheelCount(veh) == 2 then
            upgrade = upgrade * 0.15
        elseif GetWheelCount(veh) == 3 then
            upgrade = upgrade * 0.35
        end

            return upgrade
        end, 60000)
end

function IsMotorcycle(veh)
    return UseCache('isMotorbike_' .. veh, function()
        return GetVehicleClass(veh) == 8
    end, 60000)
end

function IsInBlacklistedArea(veh)
    return UseCache('isInBlacklistedArea_' .. veh, function()
        local coords = GetEntityCoords(veh)

        for k, area in pairs(Config.areaBlacklist) do
            local distance = GetDistanceBetweenCoords(coords, area.coords)
            if distance <= area.radius then
                return true, area
            end
        end

        return false
    end, 1000)
end

function GetVehicleModelUgrade(veh)
    return UseCache('vehicleModelUpgrade_' .. veh, function()
        for model, handling in pairs(Config.depthHandlingQuality.models) do
            if GetEntityModel(veh) == GetHashKey(model) then
                return handling
            end
        end
        
        local vehClass = GetVehicleClass(veh)
        if Config.depthHandlingQuality.classes[vehClass] then
            return Config.depthHandlingQuality.classes[vehClass]
        end
    
        return 0
    end, 60000)
end

function IsBlacklisted(veh)
    return UseCache('vehicleBlacklisted' .. veh, function()
        for _, model in pairs(Config.blacklist.models) do
            if GetEntityModel(veh) == GetHashKey(model) then
                return true
            end
        end
        
        local vehClass = GetVehicleClass(veh)
        if Config.blacklist.classes[vehClass] then
            return true
        end
    
        return false
    end, 60000)
end

function GetCurrentDepth()
    return CURRENT_DEPTH
end

exports('GetCurrentDepth', GetCurrentDepth);
