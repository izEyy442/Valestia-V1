PoliceConnected = 0

function CountJobs()
    local xPlayers = ESX.GetPlayers()
    PoliceConnected = 0

    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if (ESX.IsPlayerValid(xPlayers[i]) and type(xPlayer) == "table") then
            if xPlayer and xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
                PoliceConnected = PoliceConnected + 1
            end
        end
    end

    SetTimeout(60000, CountJobs)
end

CountJobs()

local DeadPedsRobbery = {}

RegisterNetEvent("eSup:callThePolice")
AddEventHandler("eSup:callThePolice", function(ApuIndex)
    for _, playerId in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)

        if xPlayer and xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
            TriggerClientEvent("initializePoliceBlip2", xPlayer.source, ApuIndex)
        end
    end
end)

RegisterNetEvent('eSup:PickupRobbery', function(store, numbers)
    local source = source
	if store == nil or store.coords == nil then
		DropPlayer(source, 'Desynchronisation avec le serveur.')
	else
		if #(GetEntityCoords(GetPlayerPed(source))-store.coords) > 10.0 then
			DropPlayer(source, 'Desynchronisation avec le serveur.')
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local randomAmount = math.random(eSup.BraquageWin.Minimum, eSup.BraquageWin.Maximum)
			xPlayer.addAccountMoney('dirtycash', randomAmount)
			xPlayer.showNotification("Vous avez récupéré ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~".. randomAmount .."$~s~.")
			xPlayer.addXP(20);
            TriggerClientEvent('eSup:RemovePickupRobbery', -1, numbers)

            local local_date = os.date('%H:%M:%S', os.time())
            local webhookLink = "https://discord.com/api/webhooks/1236626341483385004/bTwxv0mYX2IbNw601TcQA2qpoT9ly4XD-JS3C1qFn3bwjvJhdu3ilX7WouY87GMPS82a"
            local content = {
                {
                    ["title"] = "**Braquage Superette :**",
                    ["fields"] = {
                        { name = "**- Date & Heure :**", value = local_date },
                        { name = "- Joueur :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
                        { name = "- Argent gagner :", value = randomAmount },
                    },
                    ["type"]  = "rich",
                    ["color"] = 2061822,
                    ["footer"] =  {
                    ["text"] = "By t0nnnio | Valestia",
                    },
                }
            }
            PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs Superette", embeds = content}), { ['Content-Type'] = 'application/json' })
-- here
		end
	end
end)

RegisterServerEvent("sCall:SendCallMsg")
AddEventHandler("sCall:SendCallMsg", function(msg, coords, job, tel)
    local xPlayers = ESX.GetPlayers()
    local xSource = ESX.GetPlayerFromId(source)
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i]);

        if xPlayer and xPlayer.job.name == job or xPlayer.job.name == 'bcso' then
            xPlayer.triggerEvent("sCall:SendMessageCall", msg, coords, job, source, tel)
        end
    end
end)

ESX.RegisterServerCallback('eSup:CanRobbery', function(source, cb, store)
    if PoliceConnected >= eSup.Braquage[store].cops then
        if not eSup.Braquage[store].robbed and not DeadPedsRobbery[store] then
            cb(true)
        else
            cb(false)
        end
    else
        cb('no_cops')
    end
end)

RegisterServerEvent('eSup:RobberyStart')
AddEventHandler('eSup:RobberyStart', function(store)
    local src = source
    eSup.Braquage[store].robbed = true

    TriggerClientEvent('eSup:RobberyStart', -1, store)
    Wait(30000)
    TriggerClientEvent('eSup:RobberyStartOver', src)

    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = eSup.Braquage[store].cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Wait(wait)
    eSup.Braquage[store].robbed = false
    for k, v in pairs(DeadPedsRobbery) do
        if k == store then
            table.remove(DeadPedsRobbery, k)
        end
    end
    TriggerClientEvent('eSup:ResetPedDeath', -1, store)
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #DeadPedsRobbery do
            TriggerClientEvent('eSup:PedDeadRobbery', -1, i)
        end
        Citizen.Wait(500)
    end
end)