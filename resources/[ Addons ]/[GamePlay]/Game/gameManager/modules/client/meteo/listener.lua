--[[
--Created Date: Wednesday July 27th 2022
--Author: vCore3
--Made with ❤
-------
--Last Modified: Wednesday July 27th 2022 1:35:54 am
-------
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

jSync = {}
jSync.currentHour = 0
jSync.currentMinute = 0
jSync.currentWeather = ""

--LISTENERS
RegisterNetEvent("weather:onPlayerJoined", function(data)
    jSync.currentHour = data.hour
    jSync.currentMinute = data.minute
    jSync.currentWeather = data.weather
end)

RegisterNetEvent("weather:setWeather", function(weather)
    if jSync.currentWeather ~= weather then
        SetWeatherTypeOvertimePersist(weather, 15.0)
        Wait(15000)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(weather)
        SetWeatherTypeNow(weather)
        SetWeatherTypeNowPersist(weather)
        jSync.currentWeather = weather
    end
end)

RegisterNetEvent("weather:setClockTime", function(hour, minute)
    NetworkOverrideClockTime(hour, minute, 0)
    SetClockTime(hour, minute, 0)
    jSync.currentHour = hour
    jSync.currentMinute = minute
end)

--FUNCTIONS

---@param msg string
function jSync.showNotification(msg)
	BeginTextCommandThefeedPost('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandThefeedPostTicker(0,1)
end

function jSync.getCurrentWeather()
    return jSync.currentWeather
end

function jSync.getCurrentHour()
    return jSync.currentHour
end

function jSync.getCurrentMinute()
    return jSync.currentMinute
end

--EXPORTS THINGS

AddEventHandler("weather:getSharedObject", function(cb)
    cb(jSync)
end)

RegisterNetEvent("weather:showNotification", jSync.showNotification)

RegisterNetEvent("weather:getCurrentWeather", function(cb)
    cb(jSync.currentWeather)
end)

RegisterNetEvent("weather:getCurrentTime", function(cb)
    cb(jSync.currentHour, jSync.currentMinute)
end)

exports('getSharedObject', function()
	return jSync
end)