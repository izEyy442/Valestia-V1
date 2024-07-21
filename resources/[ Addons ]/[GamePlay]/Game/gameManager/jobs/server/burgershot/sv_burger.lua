TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local TimeoutJob7 = {};

RegisterServerEvent('Ouvre:BurgerShot')
AddEventHandler('Ouvre:BurgerShot', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "burgershot" then
            xPlayer.ban(0, '(Ouvre:BurgerShot)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BurgerShot', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Le BurgerShot est actuellement ouvert !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:BurgerShot')
AddEventHandler('Ferme:BurgerShot', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "burgershot" then
            xPlayer.ban(0, '(Ferme:BurgerShot)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BurgerShot', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Le BurgerShot est désormais Fermer~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:BurgerShot')
AddEventHandler('Recrutement:BurgerShot', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "burgershot" then
            xPlayer.ban(0, '(Recrutement:BurgerShot)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BurgerShot', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Recrutement en cours, rendez-vous au BurgerShot !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterNetEvent('burgershot:brugerclassique')
AddEventHandler('burgershot:brugerclassique', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ped = GetPlayerPed(_source);
    local coords = GetEntityCoords(ped)
    local craftbruger = vector3(-1199.3, -898.95, 14.0)

    local garnitures = xPlayer.getInventoryItem('garnitures').count
    local painburger = xPlayer.getInventoryItem('painburger').count
	local burgerclassique = xPlayer.getInventoryItem('burgerclassique').count
    local steak = xPlayer.getInventoryItem('steak').count

    if xPlayer.job.name ~= "burgershot" then
        xPlayer.ban(0, '(burgershot:brugerclassique)');
        return
    end

    if #(coords - craftbruger) > 20.0 then
        xPlayer.ban(0, '(burgershot:brugerclassique)');
        return
    end

    if not xPlayer.canCarryItem("burgerclassique", 1) then
        TriggerClientEvent('esx:showNotification', source, 'Vous avez ateint la limite maximum')
    elseif garnitures < 1 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de garnitures pour faire ceci')
    elseif steak < 1 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de garnitures pour faire ceci')
	elseif painburger < 1 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de painburger pour faire ceci')
    else
        xPlayer.removeInventoryItem('garnitures', 1)
		xPlayer.removeInventoryItem('cornichons', 1)
		xPlayer.removeInventoryItem('painburger', 1)
        xPlayer.removeInventoryItem('steak', 1)
        xPlayer.addInventoryItem('burgerclassique', 1)
    end
end)

RegisterNetEvent('burgershot:garnitures')
AddEventHandler('burgershot:garnitures', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ped = GetPlayerPed(_source);
    local coords = GetEntityCoords(ped)
    local craftgarniture = vector3(-1200.94, -896.47, 13.99)

    local tomates = xPlayer.getInventoryItem('tomates').count
	local cornichons = xPlayer.getInventoryItem('cornichons').count
    local salade = xPlayer.getInventoryItem('salade').count

    if xPlayer.job.name ~= "burgershot" then
        xPlayer.ban(0, '(burgershot:garnitures)');
        return
    end

    if #(coords - craftgarniture) > 20.0 then
        xPlayer.ban(0, '(burgershot:garnitures)');
        return
    end

    if not xPlayer.canCarryItem("garnitures", 1) then
        TriggerClientEvent('esx:showNotification', source, 'Vous avez ateint la limite maximum')
    elseif tomates < 1 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de tomates pour faire ceci')
	elseif cornichons < 1 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de cornichons pour faire ceci')
	elseif salade < 1 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de salade pour faire ceci')
    else
        xPlayer.removeInventoryItem('tomates', 1)
		xPlayer.removeInventoryItem('cornichons', 1)
		xPlayer.removeInventoryItem('salades', 1)
        xPlayer.addInventoryItem('garnitures', 1)
    end
end)

RegisterNetEvent('burgershot:BuyItem')
AddEventHandler('burgershot:BuyItem', function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = price
    local item = item

    if xPlayer.job.name ~= "burgershot" then
        xPlayer.ban(0, '(burgershot:BuyCornichons)');
        return
    end

    local society = ESX.DoesSocietyExist("burgershot");

    if (society) then

        if (xPlayer) then
            if xPlayer.canCarryItem(item, 1) then
                xPlayer.addInventoryItem(item, 1)
                ESX.RemoveSocietyMoney("burgershot", price);
                TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats~w~ effectué !")
            else
                TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez de place sur vous")
            end
        end

    end

end)