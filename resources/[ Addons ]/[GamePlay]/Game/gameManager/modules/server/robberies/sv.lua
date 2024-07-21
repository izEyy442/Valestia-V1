--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

local housesStates = {}

Citizen.CreateThread(function()
    for _,house in pairs(robberiesConfiguration.houses) do
        table.insert(housesStates, {state = true, robbedByID = nil})
    end
end)

RegisterNetEvent("esx_robberies:houseRobbed")
AddEventHandler("esx_robberies:houseRobbed",function(houseID)
    local _src = source

    local pseudo  = GetPlayerName(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local steamhex = xPlayer.identifier
    local local_date = os.date('%H:%M:%S', os.time())

    local content = {
        {
            ["title"] = "**Cambriolages :**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = pseudo.." [".._src.."] ["..steamhex.."]" },
                { name = "- Maison braquer :", value = houseID },
                -- { name = "- Argent Gagner :", value = price.."$" },
            },
            ["type"]  = "rich",
            ["color"] = 14673055,
            ["footer"] =  {
            ["text"] = "By t0nnnio | Valestia",
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1236626395963199579/ftWcNneDWkkbXHvHstByBE1__h3hdbYFq3w3BGHKF9yf9DVBzIMnBAOGEwrJ5rQFq2-w", function(err, text, headers) end, 'POST', json.encode({username = "Logs SHOP", embeds = content}), { ['Content-Type'] = 'application/json' })
-- here
    housesStates[houseID].state = false
    housesStates[houseID].robbedByID = _src
    Citizen.SetTimeout((1000*60)*robberiesConfiguration.houseRobRegen, function()
        housesStates[houseID].state = true
        housesStates[houseID].robbedByID = nil
    end)
end)


RegisterNetEvent("esx_robberies:callThePolice")
AddEventHandler("esx_robberies:callThePolice", function(houseIndex)
    local authority = robberiesConfiguration.houses[houseIndex].authority
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer and xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
            TriggerClientEvent("initializePoliceBlip",xPlayers[i], houseIndex, robberiesConfiguration.houses[houseIndex].policeBlipDuration)
        end
    end
end)

RegisterNetEvent("esx_robberies:getHousesStates")
AddEventHandler("esx_robberies:getHousesStates", function()
    local _src = source
    TriggerClientEvent("esx_robberies:getHousesStates", _src, housesStates)
end)

local players = {};

RegisterNetEvent('esx_robberies:money', function(robbItems)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (type(robbItems) ~= "table") then return; end

    if (not players[xPlayer.identifier] or GetGameTimer() - players[xPlayer.identifier] > 60000) then

        local finalReward = 0

        for _, itemData in pairs(robberiesConfiguration.items) do

            for i = 1, #robbItems do

                local item = robbItems[i];

                if (type(item) == "table" and type(item.name) == "string" and type(item.resell) == "number") then
                    if ( (itemData.name == item.name) and (itemData.resellerValue == item.resell) ) then
                        finalReward = finalReward + item.resell;
                    end
                end

            end

        end

        players[xPlayer.identifier] = GetGameTimer();

        if (finalReward == 0) then return; end

        xPlayer.addAccountMoney('dirtycash', finalReward);
        xPlayer.addXP(250)
        xPlayer.showAdvancedNotification(
            "Gary McKinnon",
            "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cambriolage",
            "Félicitations tu as reçus ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..finalReward.."$ ~s~grâce aux objects que tu as volé! Je te recontacterai",
            "CHAR_HACKEUR",
            9
        );

        local _src = source
        local pseudo  = GetPlayerName(source)
        local steamhex = xPlayer.identifier
        local local_date = os.date('%H:%M:%S', os.time())
        local content = {
            {
                ["title"] = "**Argent Gagner :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Joueur :", value = pseudo.." [".._src.."] ["..steamhex.."]" },
                    { name = "- Argent Gagner :", value = finalReward.."$" },
                },
                ["type"]  = "rich",
                ["color"] = 000000,
                ["footer"] =  {
                ["text"] = "By t0nnnio | Valestia",
                },
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/1236626395963199579/ftWcNneDWkkbXHvHstByBE1__h3hdbYFq3w3BGHKF9yf9DVBzIMnBAOGEwrJ5rQFq2-w", function(err, text, headers) end, 'POST', json.encode({username = "Logs SHOP", embeds = content}), { ['Content-Type'] = 'application/json' })

    else
        xPlayer.ban(0, "(esx_robberies:money)")
    end
end)