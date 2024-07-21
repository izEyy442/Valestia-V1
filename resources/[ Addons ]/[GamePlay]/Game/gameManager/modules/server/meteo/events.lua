--[[
--Created Date: Wednesday July 27th 2022
--Author: vCore3
--Made with ❤
-------
--Last Modified: Wednesday July 27th 2022 1:52:24 pm
-------
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        Wait(1000)
        Weather:syncWeather()
        Time:sync()
        local hour, minute = Time:getCurrentTime()
        TriggerClientEvent("weather:onPlayerJoined", -1, {
            hour = hour,
            minute = minute,
            weather = Weather:getCurrentWeather()
        })
    end
end)

AddEventHandler("esx:playerLoaded", function(playerSource)
    local hour, minute = Time:getCurrentTime()
    TriggerClientEvent("weather:setWeather", playerSource, Weather:getCurrentWeather())
    TriggerClientEvent("weather:setClockTime", playerSource, hour, minute)
    TriggerClientEvent("weather:onPlayerJoined", playerSource, {
        hour = hour,
        minute = minute,
        weather = Weather:getCurrentWeather()
    })
end)