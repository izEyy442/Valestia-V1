
function GetVehicleRealWheelSize(veh, index)
    return UseCache('GetVehicleRealWheelSize' .. veh .. '_' .. index, function()
        local sizeState = GetWheelSizeState(index)

        local wheelSize = UseCache(sizeState .. ' ' .. veh, function()
            return Entity(veh).state[sizeState]
        end, 99999999999999)

        if not wheelSize then
            wheelSize = GetVehicleWheelTireColliderSize(veh, index)
            if not Entity(veh).state[sizeState] then
                TriggerServerEvent('kq_realoffroad:server:createStatebag', NetworkGetNetworkIdFromEntity(veh), sizeState, wheelSize)
                Entity(veh).state[sizeState] = wheelSize
            else
                wheelSize = Entity(veh).state[sizeState]
            end
        end

        return wheelSize
    end, 20000)
end

function GetWheelDepthState(index)
    return WHEEL_DEPTH .. index
end

function GetWheelSizeState(index)
    return WHEEL_SIZE .. index
end

function GetPlayerVeh()
    return GetVehiclePedIsIn(PlayerPedId(), false)
end

function GetVehicleMass(veh)
    return UseCache('vehMass_' .. veh, function ()
        return GetVehicleHandlingFloat(veh, 'CHandlingData', 'fMass')
    end, 60000)
end

function IsAwd(veh)
    return UseCache('isAwd_' .. veh, function()
        local bias = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveBiasFront')
        return bias > 0.3 and bias < 0.7
    end, 60000)
end

function GetWheelCount(veh)
    return UseCache('wheelCount_' .. veh, function()
        return GetVehicleNumberOfWheels(veh)
    end, 60000)
end

function GetZoneMultiplier(zone)
    return UseCache('zoneMultiplier_' .. zone, function()
        local zoneData = GetZoneData(zone)

        if zoneData then
           return zoneData.depthMultiplier
        end

        return 1
    end, 60000)
end

function GetZoneTraction(zone)
    return UseCache('zoneMultiplier_' .. zone, function()
        local zoneData = GetZoneData(zone)

        if zoneData then
           return zoneData.tractionMultiplier
        end

        return 1
    end, 60000)
end

function GetZoneData(zone)
    return UseCache('zoneData_' .. zone, function()
        for k, zoneData in pairs(Config.zones) do
            for _, zoneName in pairs(zoneData.zones) do
                if zoneName == zone then
                    return zoneData
                end
            end
        end

        return nil
    end, 60000)
end

function GetVehicleDrift(veh)
    return UseCache('vehDrift_' .. veh, function()
        return math.abs(GetVehicleWheelTractionVectorLength(veh, 3)) + math.abs(GetVehicleWheelTractionVectorLength(veh, 2))
    end, 400)
end

function L(text)
    if Locale and Locale[text] then
        return Locale[text]
    end

    return text
end

function Debug(...)
    if Config.debug then
        print(...)
    end
end

function Contains(tab, val)
    if not tab then
        return false
    end

    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function ContainsVehicleModel(tab, val)
    if not tab then
        return false
    end

    for index, value in ipairs(tab) do
        if GetHashKey(value) == val then
            return true
        end
    end

    return false
end
