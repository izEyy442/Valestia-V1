--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local TimeoutJob4 = {};
local isDancing = false

RegisterServerEvent('Ouvre:yellowjack')
AddEventHandler('Ouvre:yellowjack', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "yellowjack" then
            xPlayer.ban(0, '(Ouvre:yellowjack)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Yellow Jack', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Le Yellow Jack est désormais Ouvert~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:yellowjack')
AddEventHandler('Ferme:yellowjack', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "yellowjack" then
            xPlayer.ban(0, '(Ferme:yellowjack)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Yellow Jack', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Le Yellow Jack est désormais Fermer~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:yellowjack')
AddEventHandler('Recrutement:yellowjack', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "yellowjack" then
            xPlayer.ban(0, '(Recrutement:yellowjack)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Yellow Jack', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Les Recrutement en cours, rendez-vous au Vanilla Yellow Jack !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)


RegisterServerEvent('esx_yellowjackjob:prendreitems')
AddEventHandler('esx_yellowjackjob:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(esx_yellowjackjob:prendreitems)');
        return
    end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yellowjack', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('esx_yellowjackjob:stockitem')
AddEventHandler('esx_yellowjackjob:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(esx_yellowjackjob:stockitem)');
        return
    end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yellowjack', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('esx_yellowjackjob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(esx_yellowjackjob:inventairejoueur)');
        return
    end

	cb({items = items})
end)

ESX.RegisterServerCallback('esx_yellowjackjob:prendreitem', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(esx_yellowjackjob:prendreitem)');
        return
    end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yellowjack', function(inventory)
		cb(inventory.items)
	end)
end)

-------- Boisson --------

RegisterNetEvent('yellowjack:BuyTequila', money)
AddEventHandler('yellowjack:BuyTequila', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyTequila)');
        return
    end

    local moneyGood = ESX.GetSocietyMoney("yellowjack")
    print(moneyGood)
    if moneyGood >= money then
        if xPlayer.canCarryItem('tequila', 1) then
            xPlayer.addInventoryItem('tequila', 1)
            ESX.RemoveSocietyMoney("yellowjack", money);
            TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
        else
            TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
        end
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez d\'argent dans la société')
    end
end)

RegisterNetEvent('yellowjack:BuyJackDaniel', money)
AddEventHandler('yellowjack:BuyJackDaniel', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyJackDaniel)');
        return
    end

    if xPlayer.canCarryItem('jackdaniel', 1) then
        xPlayer.addInventoryItem('jackdaniel', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyPoliakov', money)
AddEventHandler('yellowjack:BuyPoliakov', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyPoliakov)');
        return
    end

    if xPlayer.canCarryItem('poliakov', 1) then
        xPlayer.addInventoryItem('poliakov', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyVin', money)
AddEventHandler('yellowjack:BuyVin', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyVin)');
        return
    end

    if xPlayer.canCarryItem('vine', 1) then
        xPlayer.addInventoryItem('vine', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyDonPapa', money)
AddEventHandler('yellowjack:BuyDonPapa', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyDonPapa)');
        return
    end

    if xPlayer.canCarryItem('donpapa', 1) then
        xPlayer.addInventoryItem('donpapa', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyChampagne', money)
AddEventHandler('yellowjack:BuyChampagne', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyChampagne)');
        return
    end

    if xPlayer.canCarryItem('champagne', 1) then
        xPlayer.addInventoryItem('champagne', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:Buy86', money)
AddEventHandler('yellowjack:Buy86', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:Buy86)');
        return
    end

    if xPlayer.canCarryItem('86', 1) then
        xPlayer.addInventoryItem('86', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyMojito', money)
AddEventHandler('yellowjack:BuyMojito', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyMojito)');
        return
    end

    if xPlayer.canCarryItem('mojito', 1) then
        xPlayer.addInventoryItem('mojito', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuySangria', money)
AddEventHandler('yellowjack:BuySangria', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuySangria)');
        return
    end

    if xPlayer.canCarryItem('sangria', 1) then
        xPlayer.addInventoryItem('sangria', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyLimoncello', money)
AddEventHandler('yellowjack:BuyLimoncello', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyLimoncello)');
        return
    end

    if xPlayer.canCarryItem('limoncello', 1) then
        xPlayer.addInventoryItem('limoncello', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyCoca', money)
AddEventHandler('yellowjack:BuyCoca', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyCoca)');
        return
    end

    if xPlayer.canCarryItem('coca', 1) then
        xPlayer.addInventoryItem('coca', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyIceTea', money)
AddEventHandler('yellowjack:BuyIceTea', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyIceTea)');
        return
    end

    if xPlayer.canCarryItem('icetea', 1) then
        xPlayer.addInventoryItem('icetea', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyCafe', money)
AddEventHandler('yellowjack:BuyCafe', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyCafe)');
        return
    end

    if xPlayer.canCarryItem('cafe', 1) then
        xPlayer.addInventoryItem('cafe', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyDiabolo', money)
AddEventHandler('yellowjack:BuyDiabolo', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyDiabolo)');
        return
    end

    if xPlayer.canCarryItem('diabolo', 1) then
        xPlayer.addInventoryItem('diabolo', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

-------- NOURRITURE --------

RegisterNetEvent('yellowjack:BuyBurrito', money)
AddEventHandler('yellowjack:BuyBurrito', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyBurrito)');
        return
    end

    if xPlayer.canCarryItem('burrito', 1) then
        xPlayer.addInventoryItem('burrito', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyHotDog', money)
AddEventHandler('yellowjack:BuyHotDog', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyHotDog)');
        return
    end

    if xPlayer.canCarryItem('hotdog', 1) then
        xPlayer.addInventoryItem('hotdog', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyCroissant', money)
AddEventHandler('yellowjack:BuyCroissant', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyCroissant)');
        return
    end

    if xPlayer.canCarryItem('croissant', 1) then
        xPlayer.addInventoryItem('croissant', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuySaucisson', money)
AddEventHandler('yellowjack:BuySaucisson', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuySaucisson)');
        return
    end

    if xPlayer.canCarryItem('saucisson', 1) then
        xPlayer.addInventoryItem('saucisson', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyCacahuetes', money)
AddEventHandler('yellowjack:BuyCacahuetes', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyCacahuetes)');
        return
    end

    if xPlayer.canCarryItem('cacahuete', 1) then
        xPlayer.addInventoryItem('cacahuete', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyDoritos', money)
AddEventHandler('yellowjack:BuyDoritos', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyDoritos)');
        return
    end

    if xPlayer.canCarryItem('doritos', 1) then
        xPlayer.addInventoryItem('doritos', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('yellowjack:BuyMonsterMunch', money)
AddEventHandler('yellowjack:BuyMonsterMunch', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "yellowjack" then
        xPlayer.ban(0, '(yellowjack:BuyMonsterMunch)');
        return
    end

    if xPlayer.canCarryItem('monstermunch', 1) then
        xPlayer.addInventoryItem('monstermunch', 1)
        ESX.RemoveSocietyMoney("yellowjack", money);
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
    end
end)