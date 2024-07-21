ESX = nil

local TimeoutJob = {};

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

RegisterNetEvent('benny:spawnVehicle', function(model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'mecano' then
        xPlayer.ban(0, '(benny:spawnVehicle)')
        return
    end

    -- TONIO HERE
    ESX.SpawnVehicle(GetHashKey(model), vector3(-197.9616, -1301.189, 31.29655), 270.75, nil, false, nil, function(vehicle)
        TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
    end)
end)

RegisterNetEvent('ls:spawnVehicle', function(model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'mecano2' then
        xPlayer.ban(0, '(ls:spawnVehicle)')
        return
    end

    ESX.SpawnVehicle(GetHashKey(model), vector3(-384.4778, -127.9943, 38.07802), 208.34944152832, nil, false, nil, function(vehicle)
        TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
    end)
end)

RegisterServerEvent('Ouvre:Mecano')
AddEventHandler('Ouvre:Mecano', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano" then
            xPlayer.ban(0, '(Ouvre:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if (player) then
                player.showAdvancedNotification("Benny's", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Le Benny's est désormais Ouvert~s~ !", 'CHAR_MP_STRIPCLUB_PR', 8)
            end
        end
    else
		xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:Mecano')
AddEventHandler('Ferme:Mecano', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano" then
            xPlayer.ban(0, '(Ferme:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if (player) then
                player.showAdvancedNotification("Benny's", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Le Benny's est désormais Fermer~s~ !", 'CHAR_MP_STRIPCLUB_PR', 8)
            end
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:Mecano')
AddEventHandler('Recrutement:Mecano', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano" then
            xPlayer.ban(0, '(Recrutement:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if (player) then
                player.showAdvancedNotification("Benny's", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Les Recrutement en cours, rendez-vous au Benny's !", 'CHAR_MP_STRIPCLUB_PR', 8)
            end
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ouvre:Mecano2')
AddEventHandler('Ouvre:Mecano2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano2" then
            xPlayer.ban(0, '(Ouvre:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if (player) then
                player.showAdvancedNotification("Ls Custom", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Le Ls Custom est désormais Ouvert~s~ !", 'CHAR_MP_STRIPCLUB_PR', 8)
            end
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:Mecano2')
AddEventHandler('Ferme:Mecano2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano2" then
            xPlayer.ban(0, '(Ferme:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if (player) then
                player.showAdvancedNotification("Ls Custom", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Le Ls Custom est désormais Fermer~s~ !", 'CHAR_MP_STRIPCLUB_PR', 8)
            end
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:Mecano2')
AddEventHandler('Recrutement:Mecano2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano2" then
            xPlayer.ban(0, '(Recrutement:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if (player) then
                player.showAdvancedNotification("Ls Custom", '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', "Les Recrutement en cours, rendez-vous au Ls Custom !", 'CHAR_MP_STRIPCLUB_PR', 8)
            end
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)
