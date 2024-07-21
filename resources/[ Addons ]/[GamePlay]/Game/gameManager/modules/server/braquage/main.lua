--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local rob = false
local robbers = {}

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_holdupbank:toofar')
AddEventHandler('esx_holdupbank:toofar', function(robb)
	local source = source
	TriggerEvent("ratelimit", source, "esx_holdupbank:toofar")

	local xPlayers = ESX.GetPlayers()
	rob = false

	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

 		if xPlayer and xPlayer.job.name == 'police' or xPlayer and xPlayer.job.name == 'bcso' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], "braquage annulé à " .. Banks[robb].nameofbank)
			TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
		end
	end

	if (robbers[source]) then
		TriggerClientEvent('esx_holdupbank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, "Braquage annulé: " .. Banks[robb].nameofbank)
	end
end)

RegisterServerEvent('esx_holdupbank:rob')
AddEventHandler('esx_holdupbank:rob', function(robb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	if Banks[robb] then
		if (os.time() - Banks[robb].lastrobbed) < 600 and Banks[robb].lastrobbed ~= 0 then
			TriggerClientEvent('esx:showNotification', _source, "Cet endroit à déjà été voler, merci de patienter " .. (1800 - (os.time() - Banks[robb].lastrobbed)) .. " secondes")
			return
		end

		local cops = 0

		for i = 1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer and xPlayer.job.name == 'police' or xPlayer and xPlayer.job.name == 'bcso' then
				cops = cops + 1
			end
		end

		if not rob then
			if cops >= ConfigBraco.NumberOfCopsRequired then
				rob = true

				for i = 1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

					if xPlayer and xPlayer.job.name == 'police' or xPlayer and xPlayer.job.name == 'bcso' then
						TriggerClientEvent('esx:showNotification', xPlayers[i], "braquage en cours à " .. Banks[robb].nameofbank)
						TriggerClientEvent('esx_holdupbank:setblip', xPlayers[i], Banks[robb].position)
					end
				end

				TriggerClientEvent('esx:showNotification', _source, "Votre braquagé à débuté à " .. Banks[robb].nameofbank .. " ne bougez pas !")
				TriggerClientEvent('esx:showNotification', _source, "L'alarme a été déclanchée")
				TriggerClientEvent('esx:showNotification', _source, "tenez la position pendant 5min et l'argent est à vous!")
				TriggerClientEvent('esx_holdupbank:currentlyrobbing', _source, robb)
				Banks[robb].lastrobbed = os.time()
				robbers[_source] = robb

				SetTimeout(300000, function()
					if robbers[_source] then
						rob = false
						TriggerClientEvent('esx_holdupbank:robberycomplete', _source, job)

						if xPlayer then
							xPlayer.addAccountMoney('dirtycash', Banks[robb].reward)

-- here
							local webhookLink = "https://discord.com/api/webhooks/1236626462640177213/rY_svu3yaoSiuFW4Hgr_XbzIefHWY_D7YFks0x9ko5PvxeRJYA8EYSGJCyBkrnXNOfdy"
							local local_date = os.date('%H:%M:%S', os.time())
                
							local content = {
								{
									["title"] = "**Braquage Banque :**",
									["fields"] = {
										{ name = "**- Date & Heure :**", value = local_date },
										{ name = "- Joueur :", value = pseudo.." ["..xPlayer.identifier.."]" },
										{ name = "- Argent gagner :", value = Banks[robb].reward },
									},
									["type"]  = "rich",
									["color"] = 2061822,
									["footer"] =  {
									["text"] = "By t0nnnio | Valestia",
									},
								}
							}
							PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs Superette", embeds = content}), { ['Content-Type'] = 'application/json' })

							local xPlayers = ESX.GetPlayers()

							for i = 1, #xPlayers, 1 do
								local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

								if xPlayer and xPlayer.job.name == 'police' or xPlayer and xPlayer.job.name == 'bcso' then
									TriggerClientEvent('esx:showNotification', xPlayers[i], "braquage complété à " .. Banks[robb].nameofbank)
									TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
								end
							end
						end
					end
				end)
			else
				TriggerClientEvent('esx:showNotification', _source, "besoin de " .. ConfigBraco.NumberOfCopsRequired .. " policiers pour braquer")
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Un braquage est déjà en cours.")
		end
	end
end)

--Bijouterie
PlayersCrafting    = {}
local CopsConnected  = 0

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if (ESX.IsPlayerValid(xPlayers[i]) and type(xPlayer) == "table") then
			if xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
				CopsConnected = CopsConnected + 1
			end
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('esx_vangelico_robbery:toofar')
AddEventHandler('esx_vangelico_robbery:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer and xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], "braquage annulé à " .. Stores[robb].nameofstore)
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, "votre braquage à été annulé à " .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('esx_vangelico_robbery:endrob')
AddEventHandler('esx_vangelico_robbery:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer and xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], "La bijouterie a été braquéée!")
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, "Braquage terminé " .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('esx_vangelico_robbery:rob')
AddEventHandler('esx_vangelico_robbery:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < ConfigBraco.SecBetwNextRob and store.lastrobbed ~= 0 then

            TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
			TriggerClientEvent('esx:showNotification', source, "les bijoux ont déjà été volés. Veuillez attendre: " .. (ConfigBraco.SecBetwNextRob - (os.time() - store.lastrobbed)) .. " secondes.")
			return
		end

		if rob == false then

			rob = true
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer and xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
					TriggerClientEvent('esx:showNotification', xPlayers[i], "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ Braquage en cours à: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" .. store.nameofstore)
					TriggerClientEvent('esx_vangelico_robbery:setblip', xPlayers[i], Stores[robb].position)
				end
			end

			TriggerClientEvent('esx:showNotification', source, "Votre braquagé à débuté à " .. store.nameofstore .. ", prenez les bijoux dans les vitrines !")
			TriggerClientEvent('esx:showNotification', source, "L'alarme a été déclanchée")
			TriggerClientEvent('esx:showNotification', source, "tenez la position pendant 5min et l'argent est à vous!")
			TriggerClientEvent('esx_vangelico_robbery:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Un braquage est déjà en cours.")
		end
	end
end)

RegisterServerEvent('esx_vangelico_robbery:gioielli')
AddEventHandler('esx_vangelico_robbery:gioielli', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local coords = GetEntityCoords(GetPlayerPed(source))
	RobBijoux = vector3(-1385.1687, -255.0314, 43.1555)
	ZoneSize = 300
	if rob == true then
		if #(coords - RobBijoux) < ZoneSize / 2 then
			xPlayer.addInventoryItem('jewels', math.random(ConfigBraco.MinJewels, ConfigBraco.MaxJewels))
		else
			xPlayer.ban(0, '(esx_vangelico_robbery:gioielli)');
		end
	else
		xPlayer.ban(0, '(esx_vangelico_robbery:gioielli');
	end
end)

RegisterNetEvent('lester:vendita', function()

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local reward = math.floor(ConfigBraco.PriceForOneJewel * ConfigBraco.MaxJewelsSell)
	SellBijoux = vector3(-1164.7128, -2022.2787, 13.1605)
	ZoneSize2 = 30

	if #(coords - SellBijoux) < ZoneSize2 / 2 then
		if xPlayer.getInventoryItem('jewels').count >= ConfigBraco.MaxJewelsSell then
			xPlayer.removeInventoryItem('jewels', ConfigBraco.MaxJewelsSell)
			xPlayer.addAccountMoney('cash', reward)
		end
	else
		xPlayer.ban(0, '(lester:vendita');
	end
end)

ESX.RegisterServerCallback('esx_vangelico_robbery:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

local playersTimed = {};

RegisterNetEvent("vCore3:ClaquetteChausette", function()
	local ptitePute = source;
	local xPlayer = ESX.GetPlayerFromId(ptitePute);
	local item = xPlayer.getInventoryItem('jewels');

	if (xPlayer) then
		if (CopsConnected >= ConfigBraco.RequiredCopsSell) then
			if (not playersTimed[xPlayer.identifier] or GetGameTimer() - playersTimed[xPlayer.identifier] > 10000) then
				playersTimed[xPlayer.identifier] = GetGameTimer();
				local ped = GetPlayerPed(ptitePute);
				local coords = GetEntityCoords(ped);
				FreezeEntityPosition(ped, true);
				SetTimeout(10000, function()
					FreezeEntityPosition(ped, false);
					xPlayer.triggerEvent("vCore3:ClaquetteChausetteV2");
				end);
				if (item) then
					local reward = math.floor(ConfigBraco.PriceForOneJewel * ConfigBraco.MaxJewelsSell)
					local SellBijoux = vector3(-1164.7128, -2022.2787, 13.1605);
					if #(coords - SellBijoux) < 15 then
						if item.count >= ConfigBraco.MaxJewelsSell then
							xPlayer.showNotification("Bijoux: vente en cours...");
							xPlayer.removeInventoryItem('jewels', ConfigBraco.MaxJewelsSell);
							xPlayer.addAccountMoney('dirtycash', reward);
						else
							FreezeEntityPosition(ped, false);
							xPlayer.showNotification("Vous n'avez pas assez de bijoux sur vous.");
						end
					else
						xPlayer.ban(0, '(vCore3:ClaquetteChausette)');
					end
				end
			else
				xPlayer.showNotification("Vous devez attendre 10 secondes avant de pouvoir vendre à nouveau.");
			end
		else
			xPlayer.triggerEvent("vCore3:ClaquetteChausetteV2");
			xPlayer.showNotification("Lester n'est pas disponible pour le moment.");
		end
	end
end);
