-- --[[
--   This file is part of Valestia RolePlay.
--   Copyright (c) Valestia RolePlay - All Rights Reserved
--   Unauthorized using, copying, modifying and/or distributing of this file,
--   via any medium is strictly prohibited. This code is confidential.
-- --]]

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- local TimeoutJob4 = {};
-- local isDancing = false

-- RegisterServerEvent('Ouvre:unicorn')
-- AddEventHandler('Ouvre:unicorn', function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local xPlayers	= ESX.GetPlayers()
--     if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
-- 		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
--         if xPlayer.job.name ~= "unicorn" then
--             xPlayer.ban(0, '(Ouvre:unicorn)');
--             return
--         end
--         for i=1, #xPlayers, 1 do
--             TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'L\'Unicorn est désormais Ouvert~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
--         end
--     else
--         xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
--     end
-- end)

-- RegisterServerEvent('Ferme:unicorn')
-- AddEventHandler('Ferme:unicorn', function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local xPlayers	= ESX.GetPlayers()
--     if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
-- 		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
--         if xPlayer.job.name ~= "unicorn" then
--             xPlayer.ban(0, '(Ferme:unicorn)');
--             return
--         end
--         for i=1, #xPlayers, 1 do
--             TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'L\'Unicorn est désormais Fermer~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
--         end
--     else
--         xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
--     end
-- end)

-- RegisterServerEvent('Recrutement:unicorn')
-- AddEventHandler('Recrutement:unicorn', function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local xPlayers	= ESX.GetPlayers()
--     if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
-- 		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
--         if xPlayer.job.name ~= "unicorn" then
--             xPlayer.ban(0, '(Recrutement:unicorn)');
--             return
--         end
--         for i=1, #xPlayers, 1 do
--             TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Les Recrutement en cours, rendez-vous au Vanilla Unicorn !', 'CHAR_MP_STRIPCLUB_PR', 8)
--         end
--     else
--         xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
--     end
-- end)


-- RegisterServerEvent('esx_unicornjob:prendreitems')
-- AddEventHandler('esx_unicornjob:prendreitems', function(itemName, count)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local sourceItem = xPlayer.getInventoryItem(itemName)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(esx_unicornjob:prendreitems)');
--         return
--     end

-- 	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
-- 		local inventoryItem = inventory.getItem(itemName)

-- 		-- is there enough in the society?
-- 		if count > 0 and inventoryItem.count >= count then

-- 			-- can the player carry the said amount of x item?
-- 			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
-- 				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
-- 			else
-- 				inventory.removeItem(itemName, count)
-- 				xPlayer.addInventoryItem(itemName, count)
-- 				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
-- 			end
-- 		else
-- 			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
-- 		end
-- 	end)
-- end)


-- RegisterNetEvent('esx_unicornjob:stockitem')
-- AddEventHandler('esx_unicornjob:stockitem', function(itemName, count)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local sourceItem = xPlayer.getInventoryItem(itemName)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(esx_unicornjob:stockitem)');
--         return
--     end

-- 	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
-- 		local inventoryItem = inventory.getItem(itemName)

-- 		-- does the player have enough of the item?
-- 		if sourceItem.count >= count and count > 0 then
-- 			xPlayer.removeInventoryItem(itemName, count)
-- 			inventory.addItem(itemName, count)
-- 			TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")
-- 		else
-- 			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
-- 		end
-- 	end)
-- end)

-- ESX.RegisterServerCallback('esx_unicornjob:inventairejoueur', function(source, cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local items   = xPlayer.inventory

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(esx_unicornjob:inventairejoueur)');
--         return
--     end

-- 	cb({items = items})
-- end)

-- ESX.RegisterServerCallback('esx_unicornjob:prendreitem', function(source, cb)
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(esx_unicornjob:prendreitem)');
--         return
--     end

-- 	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
-- 		cb(inventory.items)
-- 	end)
-- end)

-- --Shop Unicorn
-- RegisterNetEvent('Unicorn:BuyEau', money)
-- AddEventHandler('Unicorn:BuyEau', function(money)
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyEau)');
--         return
--     end

--     if xPlayer.canCarryItem('water', 1) then
--         xPlayer.addInventoryItem('water', 1)
--         ESX.RemoveSocietyMoney("unicorn", money);
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyIceTea', money)
-- AddEventHandler('Unicorn:BuyIceTea', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyIceTea)');
--         return
--     end

--     if xPlayer.canCarryItem('icetea', 1) then
--         xPlayer.addInventoryItem('icetea', 1)
--         ESX.RemoveSocietyMoney("unicorn", money);
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyLimonade', money)
-- AddEventHandler('Unicorn:BuyLimonade', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyLimonade)');
--         return
--     end

--     if xPlayer.canCarryItem('limonade', 1) then
--         ESX.RemoveSocietyMoney("unicorn", money);
--         xPlayer.addInventoryItem('limonade', 1)
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--         return
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyVine', money)
-- AddEventHandler('Unicorn:BuyVine', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyVine)');
--         return
--     end

--     if xPlayer.canCarryItem('vine', 1) then
--         ESX.RemoveSocietyMoney("unicorn", money);
--         xPlayer.addInventoryItem('vine', 1)
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyWhiskycoca', money)
-- AddEventHandler('Unicorn:BuyWhiskycoca', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyWhiskycoca)');
--         return
--     end

--     if xPlayer.canCarryItem('wiskycoca', 1) then
--         ESX.RemoveSocietyMoney("unicorn", money);
--         xPlayer.addInventoryItem('wiskycoca', 1)
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyMojito', money)
-- AddEventHandler('Unicorn:BuyMojito', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyMojito)');
--         return
--     end
--     if xPlayer.canCarryItem('mojito', 1) then
--         xPlayer.addInventoryItem('mojito', 1)
--         ESX.RemoveSocietyMoney("unicorn", money);
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyCoca', money)
-- AddEventHandler('Unicorn:BuyCoca', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyCoca)');
--         return
--     end

--     if xPlayer.canCarryItem('coca', 1) then
--         xPlayer.addInventoryItem('coca', 1)
--         ESX.RemoveSocietyMoney("unicorn", money);
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyFanta', money)
-- AddEventHandler('Unicorn:BuyFanta', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyFanta)');
--         return
--     end

--     if xPlayer.canCarryItem('fanta', 1) then
--         ESX.RemoveSocietyMoney("unicorn", money);
--         xPlayer.addInventoryItem('fanta', 1)
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyChips', money)
-- AddEventHandler('Unicorn:BuyChips', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyChips)');
--         return
--     end

--     if xPlayer.canCarryItem('chips', 1) then
--         ESX.RemoveSocietyMoney("unicorn", money);
--         xPlayer.addInventoryItem('chips', 1)
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyCacahuete', money)
-- AddEventHandler('Unicorn:BuyCacahuete', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyCacahuete)');
--         return
--     end

--     if xPlayer.canCarryItem('cacahuete', 1) then
--         ESX.RemoveSocietyMoney("unicorn", money);
--         xPlayer.addInventoryItem('cacahuete', 1)
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:BuyOlive', money)
-- AddEventHandler('Unicorn:BuyOlive', function(money)

--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:BuyOlive)');
--         return
--     end

--     if xPlayer.canCarryItem('olive', 1) then
--         ESX.RemoveSocietyMoney("unicorn", money);
--         xPlayer.addInventoryItem('olive', 1)
--         TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Achats effectué !")
--     else
--         TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
--     end
-- end)

-- RegisterNetEvent('Unicorn:StartDance')
-- AddEventHandler('Unicorn:StartDance', function()
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if (xPlayer) then

--         if xPlayer.job.name ~= "unicorn" then
--             xPlayer.ban(0, '(Unicorn:StartDance)');
--             return
--         end

--         if (not isDancing) then
--             isDancing = true
--             TriggerClientEvent('Unicorn:StartStrip', -1)
--             TriggerClientEvent('Unicorn:StartBoucleMoney', -1)
--         else
--             xPlayer.showNotification("La striptiseuse est déjà en train de danser")
--         end

--     end

-- end)

-- RegisterNetEvent('Unicorn:StopDance')
-- AddEventHandler('Unicorn:StopDance', function()

--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "unicorn" then
--         xPlayer.ban(0, '(Unicorn:StopDance)');
--         return
--     end

--     if (isDancing) then
--         isDancing = false
--         TriggerClientEvent('Unicorn:StopStrip', -1)
--     else
--         xPlayer.showNotification("La striptiseuse n'est pas en train de danser")
--     end
-- end)

-- RegisterNetEvent('Unicorn:PayStrip')
-- AddEventHandler('Unicorn:PayStrip', function()
--     local source = source
--     local price = 1000
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.getAccount('cash').money >= price then

--         local society = ESX.DoesSocietyExist("unicorn");

--         if (society) then

--             xPlayer.removeAccountMoney('cash', price);
--             ESX.AddSocietyMoney("unicorn", price);

--         end

--     else
--         TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas de cash sur vous !")
--     end
-- end)