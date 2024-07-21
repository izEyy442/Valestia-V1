RegisterNetEvent('izeyy:spawnVehicle2', function(model, position, heading)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'postop' then
		-- TONIO HERE
		ESX.SpawnVehicle(GetHashKey(model), position, heading, nil, false, nil, function(vehicle)
			TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
		end)
	end
end)

function GetServerTime()
    local currentTimestamp = os.time()
    local modifiedTimestamp = currentTimestamp + ((Config.ServerTimezoneOffsetHours or 0) * 60 * 60)
    return modifiedTimestamp
end

function SendLogs(name, title, message, web)
    local local_date = os.date('%H:%M:%S', os.time())
  
	local embeds = {
		{
			["title"]= title,
			["description"]= message,
			["type"]= "rich",
			["color"] = 652101,
			["footer"]=  {
				["text"]= "Powered by Valestia ©   |  "..local_date.."",
				["icon_url"] = "https://i.imgur.com/uyNntjE.png"
			},
		}
	}
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

print([[

		^4.____________                    
		|__\____    /____ ___.__.___.__. 
		|  | /     // __ <   |  <   |  | 
		|  |/     /\  ___/\___  |\___  | 
		|__/_______ \___  > ____|/ ____| 
				\/   \/\/     \/      
		^0
		GitHub : ^4https://github.com/izEyy442^0
		Discord : ^4https://discord.gg/gsiderp^0

]])