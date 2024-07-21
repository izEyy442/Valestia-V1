-- local WeaponAClear = {
--     ['WEAPON_COMPACTRIFLE'] = true,
--     ["WEAPON_SAWNOFFSHOTGUN"] = true,
-- }

-- Citizen.CreateThread(function()
--     local load = 0
--     MySQL.Async.fetchAll('SELECT * FROM users', {}, function(result)
--         for o,n in pairs(result) do
--             local Weapon = {}
--             local caca = json.decode(n.loadout)
--             if (caca) then
--                 for k,v in pairs(caca) do
--                     if not WeaponAClear[v.name] then
--                         table.insert(Weapon, v)
--                         MySQL.Async.execute('UPDATE users SET `loadout` = @loadout WHERE identifier = @identifier', {
--                             ['@loadout'] = json.encode(Weapon),
--                             ['@identifier'] = n.identifier,
--                         })
--                     end
--                     load = load +1
--                     print(load..' WE SALE FDP LARME EST SUPPR')

--                  end
--             end
--         end
--     end)
-- end)

local playersmax = 20
local participantss = 0
local lastPart = nil
local EventEnCours = false

local playersInEvent = {}
local playersInTimeout = {}
local countFinish = 0

RegisterNetEvent("splayer_staff_event:SendInfo")
AddEventHandler("splayer_staff_event:SendInfo", function(startPos, endPos, desc, playerevent, _vehiculeevent, prix, ArgentPropre)

    participantss = 0
    playersmax = playerevent
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer and xPlayer.job.name ~= 'police' or xPlayer.job.name ~= 'bcsd' then
            TriggerClientEvent("splayer_staff_event:GetInfo", xPlayers[i], startPos, endPos, desc, playerevent, _vehiculeevent, prix, ArgentPropre)
            sendToStaffMenuEvent('Valestia - LOGS', '[STAFF MENU EVENT] \nLe Staff viens de faire un event avec son Menu Event'..GetPlayerName(source)..'\nDesc : '..desc..'\nVéhicule : '.._vehiculeevent.. '\nPrix : '..prix, 4640644)
        end
    end
    EventEnCours = true
end)

RegisterNetEvent("splayer_staff_event:AddPlayer")
AddEventHandler("splayer_staff_event:AddPlayer", function()
    local _source = source
    if lastPart ~= _source then
        lastPart = _source
        table.insert(playersInEvent, _source)
        participantss = participantss + 1
        if participantss >= playersmax then
            TriggerClientEvent("splayer_staff_event:MaxPlayerReach", -1)
        end
    end
end)

RegisterNetEvent("splayer_staff_eventS:Finish")
AddEventHandler("splayer_staff_eventS:Finish", function(prix, ArgentPropre)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local found = false

    if not playersInTimeout[source] then
        playersInTimeout[source] = 0
    else
        playersInTimeout[source] = playersInTimeout[source]+1
    end

    if playersInTimeout[source] > 5 then
        DropPlayer(_source, "Ce n'est pas bien d'essayer de se give :(")
        return
    end

    if EventEnCours == true then
        print(GetPlayerName(source).." viens de faire l'EVENT est à gagné "..prix)
        sendToStaffMenuEvent('Valestia - LOGS', '[STAFF MENU EVENT] \nLe joueur viens de faire levent '..GetPlayerName(source)..'\nPrix : '..prix, 4640644)
        for k, v in pairs(playersInEvent) do
            if v == _source then
                found = true
            end
        end

        Wait(200)

        if found then
            countFinish = countFinish + 1
            if ArgentPropre then
                xPlayer.addAccountMoney('cash', prix)
                print("sa a donné le cash")
            end

            -- fini event
            if #playersInEvent == countFinish then
                playersInEvent = {}
                EventEnCours = false
                countFinish = 0
            end
        else
            DropPlayer(_source, "Vous n'avez pas participé à cet événement")
        end

    else
        DropPlayer(_source, "Evénement non commencé")
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(15000)
        playersInTimeout = {}
    end
end)

function sendToStaffMenuEvent (name,message,color)
    date_local1 = os.date('%H:%M:%S', os.time())
    local date_local = date_local1
    local DiscordWebHook = "https://discord.com/api/webhooks/1226971212102631534/iQZGYV-yNt9bRpxeN4ObfkxnQu8ZfNTcRk-MJYkj6cdeH4vuMOza9GLjdG4Rglqt39uX"
    local embeds = {
        {

            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] =  {
            ["text"] = "Heure: " ..date_local.. "",
        },
    }
  }

if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end