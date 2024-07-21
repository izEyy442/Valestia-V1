RegisterServerEvent('scrapjob:scrap:find')
AddEventHandler('scrapjob:scrap:find', function()
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(source)

    if #(GetEntityCoords(GetPlayerPed(source))-vector3(-511.76,-1753.97,17.9)) > 100 then 
        TriggerEvent("tF:Protect", source, "(scrapjob:scrap:find)")
        return 
    end

   xPlayer.addInventoryItem('scrap', 1)
end)

local ScrapJobTimeout = {}

RegisterServerEvent('sCore:scrap:sell')
AddEventHandler('sCore:scrap:sell', function(src, token)
    if #(GetEntityCoords(GetPlayerPed(source))-vector3(-505.48559570313,-1736.7546386719,18.947526931763)) > 100 then 
        TriggerEvent("tF:Protect", source, "(scrapjob:scrap:sell)")
        return 
    end

    if not ScrapJobTimeout[source] then 
        ScrapJobTimeout[source] = 0 
    else
        ScrapJobTimeout[source] = ScrapJobTimeout[source]+1
    end

    if ScrapJobTimeout[source] > 5 then 
        TriggerEvent("tF:Protect", source, "(scrapjob:scrap:sell2)")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    local argent_win = math.random(60, 80)
    xPlayer.addAccountMoney('cash', argent_win)
    xPlayer.removeInventoryItem('scrap', 1)
    xPlayer.showNotification('Tu as réussi une tâche et reçu : ~g~'..argent_win..'$')
    sendToScrapJob('CACA - LOGS', '[CACA] \n[' ..GetPlayerName(source).. '] viens de faire le Trigger Scrap Vente\nPrix : ' ..argent_win, 3644644)
end)

Citizen.CreateThread(function()
   while true do 
       Wait(15000)
       ScrapJobTimeout = {}
   end
end)

function sendToScrapJob (name,message,color)
    date_local1 = os.date('%H:%M:%S', os.time())
        local date_local = date_local1
        local DiscordWebHook = ""
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