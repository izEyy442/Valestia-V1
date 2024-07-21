--[[
--Created Date: Thursday July 28th 2022
--Author: vCore3
--Made with ❤
-------
--Last Modified: Thursday July 28th 2022 1:58:37 pm
-------
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

RegisterCommand("setweather", function(source, args)
    if source == 0 then
        if not args[1] then return print("^7[^1WEATHER SYSTEM^7]^3 Usage: /setweather <weather>") end
        if not Weather:setCurrentWeather((args[1]):upper()) then
			-- print("^7[^1WEATHER SYSTEM^7]^3 This weather is ^1blacklisted^3.^7")
		end
	end
end)

RegisterCommand("freezeweather", function(source)
	if source == 0 then
		Weather:freezeWeather(nil, function(active)
			if active then
				-- print("^7[^1WEATHER SYSTEM^7]^3 Weather sync thread is now ^1INACTIVE^3 and weather has been frozen.^7")
			else
				-- print("^7[^1WEATHER SYSTEM^7]^3 Weather sync thread is now ^4ACTIVE^3 and weather has been unfrozen.^7")
			end
		end)
	end
end)

--TIME SYSTEM
RegisterCommand("time", function(source, args)
	if source == 0 then
		if not args[1] or not args[2] then 
			return print("^7[^1TIME SYSTEM^7]^3 Usage: /settime <hour, minute>") 
		end
		Time:setCurrentTime(tonumber(args[1]), tonumber(args[2]))
		print("^7[^1TIME SYSTEM^7]^3 Time is now ^7'^4" .. args[1] .. ":" .. args[2] .. "^7'^3.^7")
	end
end)

RegisterCommand("freezetime", function(source)
	if source == 0 then
		Time:freezeTime(nil, nil, function(active)
			if active then
				print("^7[^1TIME SYSTEM^7]^3 Time sync thread is now ^1INACTIVE^3 and time has been frozen.^7")
			else
				print("^7[^1TIME SYSTEM^7]^3 Time sync thread is now ^4ACTIVE^3 and time has been unfrozen.^7")
			end
		end) 
	end
end)