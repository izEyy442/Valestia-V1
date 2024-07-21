--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local TimeoutJob4 = {};

RegisterServerEvent('Ouvre:bahamas')
AddEventHandler('Ouvre:bahamas', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas" then
            TriggerEvent("tF:Protect", source, '(Ouvre:bahamas)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'bahamas', '~r~Annonce', 'bahamas est désormais Ouvert~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:bahamas')
AddEventHandler('Ferme:bahamas', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas" then
            TriggerEvent("tF:Protect", source, '(Ferme:bahamas)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'bahamas', '~r~Annonce', 'L\'bahamas est désormais Fermer~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:bahamas')
AddEventHandler('Recrutement:bahamas', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas" then
            TriggerEvent("tF:Protect", source, '(Recrutement:bahamas)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'bahamas', '~g~Annonce', 'Les Recrutement en cours, rendez-vous au Vanilla bahamas !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterNetEvent('bahamas:BuyItem')
AddEventHandler('bahamas:BuyItem', function(item, price, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = ESX.DoesSocietyExist("bahamas");
    
    if (not TimeoutBuy[xPlayer.identifier] or GetGameTimer() - TimeoutBuy[xPlayer.identifier] > 5000) then
		TimeoutBuy[xPlayer.identifier] = GetGameTimer();

        if xPlayer.job.name ~= "bahamas" then
            xPlayer.ban(0, '(bahamas:BuyItem)');
            return
        end

        if (society) then

            if (tonumber(count)) then
                local total = price*count

                if item == "olive" or item == "cacahuete" or item == "chips" or item == "fanta" or item == "coca" or item == "mojito" or item == "wiskycoca" or item == "vine" or item == "limonade" or item == "icetea" or item == "water" then
                    if xPlayer.canCarryItem(item, count) then
                        xPlayer.addInventoryItem(item, tonumber(count))
                        ESX.RemoveSocietyMoney("bahamas", tonumber(total));
                        TriggerClientEvent('esx:showNotification', source, "Achats effectué !")
                    else
                        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez de place dans votre inventaire")
                    end
                    return
                else
                    xPlayer.ban(0, '(bahamas:BuyItem)');
                    return
                end
            else
                xPlayer.showNotification("Montant invalide");
            end
        else
            xPlayer.showNotification("Une erreur est survenue, Code erreur ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'bahamas_buyItem_error'~s~. Veuillez contacter un ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~administrateur~s~.");
        end
    else
        xPlayer.showNotification("Veuillez patientez 5 secondes avant de pouvoir vous resservir à nouveau.");
    end
end)

local TimeoutSpawn = {}

RegisterNetEvent('bahamas:SpawnVehicle')
AddEventHandler('bahamas:SpawnVehicle', function(model, position, heading)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not TimeoutSpawn[xPlayer.identifier] or GetGameTimer() - TimeoutSpawn[xPlayer.identifier] > 60000) then
		TimeoutSpawn[xPlayer.identifier] = GetGameTimer();

        if xPlayer.job.name ~= "bahamas" then
            xPlayer.ban(0, '(bahamas:SpawnVehicle)');
            return
        end

        if model == "stretch" or model == "patriot2" then
            -- TONIO HERE
            -- ESX.SpawnVehicle(GetHashKey(model), position, heading, nil, false, nil, function(vehicle)
            --     TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
            -- end)
            return
        else
            xPlayer.ban(0, '(bahamas:SpawnVehicle)');
            return
        end
    else
        xPlayer.showNotification("Veuillez patienter 1 minute avant de pouvoir ressortir un véhicule à nouveau.");
    end

end)