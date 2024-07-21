local ESX
local fishSafety = {}

TriggerEvent(Config.ESX, function(obj)
    ESX = obj
end)

RegisterNetEvent("startFishing")
AddEventHandler("startFishing", function(fishingZoneId)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local coords = GetEntityCoords(GetPlayerPed(_src))
    local startZone = vector3(2073.23, 4554.31, 31.31)
    if not xPlayer.canCarryItem('saumon', 1) or not xPlayer.canCarryItem('cabillaud', 1) or not xPlayer.canCarryItem('sardine', 1) or not xPlayer.canCarryItem('truite', 1) or not xPlayer.canCarryItem('thon', 1) or not xPlayer.canCarryItem('brochet', 1) then
        TriggerClientEvent("stopFishing", _src, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas assez de place dans votre inventaire")
        return
    end
    if xPlayer.getInventoryItem(Config.Peche.fishingRod).count <= 0 then
        TriggerClientEvent("setFishingState", _src, false, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas de canne à pêche")
        return
    end
    if fishSafety[_src] == nil then
        fishSafety[_src] = {
            isDoing = false
        }
    end
    if fishSafety[_src].isDoing == true then
        xPlayer.ban(0, '(startFishing (1))');
        return
    end
    fishSafety[_src] = {
        isDoing = true
    }
	if #(coords - startZone) > 30 / 2 then
        xPlayer.ban(0, '(startFishing');
        return
    end
    TriggerClientEvent("startFishing", _src, fishingZoneId, "yes")
    Wait(1000)
    SetTimeout(math.random(1, 20000), function()
        xPlayer = ESX.GetPlayerFromId(_src)
        if not xPlayer then return end
        local reward = Config.Peche.availableFish[math.random(#Config.Peche.availableFish)]
        local rewardCount = 1
        xPlayer.addInventoryItem(reward.name, rewardCount)
        TriggerClientEvent("stopFishing", _src, "Vous avez pêché ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..rewardCount.." ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..reward.label.." ~w~!")
    end)
    fishSafety[_src] = {
        isDoing = false
    }
end)

local maxFishMoney = 300

RegisterNetEvent("sellfishs")
AddEventHandler("sellfishs", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local total = 0
    local gang = xPlayer.job2.name
    local name1 = xPlayer.getFirstName()
    local name2 = xPlayer.getLastName()
    if #(GetEntityCoords(GetPlayerPed(source))-vector3(1961.89, 5184.36, 47.98)) > 10 then
        TriggerEvent("tF:Protect", source, "(sellfishs) : 67") 
    return end
    for k,v in pairs(Config.Peche.availableFish) do
        local haveItem = xPlayer.getInventoryItem(v.name)
        if haveItem then
            if haveItem.count > 0 then
                xPlayer.removeInventoryItem(v.name, 1)
                total = (v.price)
                TriggerClientEvent("esx:showNotification", _src, "~g~Vous avez vendu "..v.name.." pour "..total.."$")
            end
        end
    end
    if total <= 0 then
        TriggerClientEvent("esx:showNotification", _src, "~r~Vous n'avez rien vendu !")
        return
    end
    if (total > maxFishMoney) then
        TriggerEvent("tF:Protect", source, "(sellfishs) : 78") 
    end
    xPlayer.addAccountMoney('cash', total)
    SendLogsPeche("Pêche Vente","Vente","Vente Total : **"..total.."$**\n**Nom RP du joueur : **".. name1.." "..name2.."**\n Groupe / Gang du Joueur : **"..gang.."**\nLicense du joueur : **"..xPlayer.identifier,"https://discord.com/api/webhooks/1236626021139349574/WI-k3LXA9LCafrZ3iMt1iftkkOpVRSdqJtc-VliPKpkwvdeLR8ILZjG1rsmeJ3JsZO79")
end)

function SendLogsPeche(name, title, message, web)
    local local_date = os.date('%H:%M:%S', os.time())
  
	local embeds = {
		{
			["title"]= title,
			["description"]= message,
			["type"]= "rich",
			["color"] = 16776960,
			["footer"]=  {
			["text"]= "Powered for Valestia ©   |  "..local_date.."",
			},
		}
	}
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
-- here