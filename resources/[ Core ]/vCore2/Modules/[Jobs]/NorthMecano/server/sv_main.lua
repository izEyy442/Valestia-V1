ESX = nil

local TimeoutJob = {};

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

RegisterNetEvent('izeyy:ljmotors:spawnVehicle', function(model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'mecano3' then
        xPlayer.ban(0, '(izeyy:ljmotors:spawnVehicle)')
        return
    end

    -- TONIO HERE
    ESX.SpawnVehicle(GetHashKey(model), vector3(124.29821777344, 6594.998046875, 31.977998733521), 270.1304931640625, nil, false, nil, function(vehicle)
        TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
    end)
end)

RegisterServerEvent('Ouvre:Mecano3')
AddEventHandler('Ouvre:Mecano3', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano3" then
            xPlayer.ban(0, '(Ouvre:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "North Mecano", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Le North Mecano est désormais Ouvert~s~ !", 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
		xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ouvre:Mecano3')
AddEventHandler('Ouvre:Mecano3', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano3" then
            xPlayer.ban(0, '(Ouvre:Mecano3)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "North Mecano", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Le North Mecano  est désormais Ouvert~s~ !", 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
		xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:Mecano3')
AddEventHandler('Ferme:Mecano3', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano3" then
            xPlayer.ban(0, '(Ferme:Mecano3)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "North Mecano", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Le North Mecano  est désormais Fermer~s~ !", 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:Mecano3')
AddEventHandler('Recrutement:Mecano3', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano3" then
            xPlayer.ban(0, '(Recrutement:Mecano3)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "North Mecano", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Les Recrutement en cours, rendez-vous au North Mecano  !", 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)