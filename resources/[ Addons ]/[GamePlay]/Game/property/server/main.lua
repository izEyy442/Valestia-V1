--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetProperty(name)
	for i = 1, #ConfigProperty.Properties, 1 do
		if ConfigProperty.Properties[i].name == name then
			return ConfigProperty.Properties[i]
		end
	end
end

function SetPropertyOwned(name, price, rented, owner)
	MySQL.Async.execute('INSERT INTO owned_properties (name, price, rented, owner) VALUES (@name, @price, @rented, @owner)', {
		['@name'] = name,
		['@price'] = price,
		['@rented'] = (rented and 1 or 0),
		['@owner'] = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, true)

			if rented then
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Vendu pour: "..ESX.Math.GroupDigits(price).."$")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Acheté pour: "..ESX.Math.GroupDigits(price).."$")
			end
		end
	end)
end

function RemoveOwnedProperty(name, owner, src, addMoney)
	MySQL.Async.execute('DELETE FROM owned_properties WHERE owner = @owner AND name = @name', {
		['@owner'] = owner,
		['@name'] = name
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, false)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez rendu une propriété")
			if (addMoney) then
				xPlayer.addAccountMoney('cash', priceRender)
			end
		end
	end)
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(properties)
		for i = 1, #properties, 1 do
			local entering = nil
			local exit = nil
			local inside = nil
			local outside = nil
			local isSingle = nil
			local isRoom = nil
			local isGateway = nil
			local roomMenu = nil

			if properties[i].entering ~= nil then
				entering = json.decode(properties[i].entering)
			end

			if properties[i].exit ~= nil then
				exit = json.decode(properties[i].exit)
			end

			if properties[i].inside ~= nil then
				inside = json.decode(properties[i].inside)
			end

			if properties[i].outside ~= nil then
				outside = json.decode(properties[i].outside)
			end

			if properties[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end

			if properties[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end

			if properties[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end

			if properties[i].room_menu ~= nil then
				roomMenu = json.decode(properties[i].room_menu)
			end

			table.insert(ConfigProperty.Properties, {
				name = properties[i].name,
				label = properties[i].label,
				entering = entering,
				exit = exit,
				inside = inside,
				outside = outside,
				ipls = json.decode(properties[i].ipls),
				gateway = properties[i].gateway,
				isSingle = isSingle,
				isRoom = isRoom,
				isGateway = isGateway,
				roomMenu = roomMenu,
				price = properties[i].price
			})
		end

		TriggerClientEvent('esx_property:sendProperties', -1, ConfigProperty.Properties)
	end)
end)

ESX.RegisterServerCallback('esx_property:getProperties', function(source, cb)
	cb(ConfigProperty.Properties)
end)

AddEventHandler('esx_ownedproperty:getOwnedProperties', function(cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(result)
		local properties = {}

		for i = 1, #result, 1 do
			table.insert(properties, {
				id = result[i].id,
				name = result[i].name,
				label = GetProperty(result[i].name).label,
				price = result[i].price,
				rented = (result[i].rented == 1 and true or false),
				owner = result[i].owner
			})
		end

		cb(properties)
	end)
end)

AddEventHandler('esx_property:setPropertyOwned', function(name, price, rented, owner)
	SetPropertyOwned(name, price, rented, owner)
end)

AddEventHandler('esx_property:removeOwnedProperty', function(name, owner)
	RemoveOwnedProperty(name, owner)
end)

RegisterServerEvent('esx_property:rentProperty')
AddEventHandler('esx_property:rentProperty', function(propertyName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)
	local rent = ESX.Math.Round(property.price / 200)

	SetPropertyOwned(propertyName, rent, true, xPlayer.identifier)
end)

RegisterServerEvent('esx_property:buyProperty')
AddEventHandler('esx_property:buyProperty', function(propertyName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)

	if property.price <= xPlayer.getAccount('cash').money then
		xPlayer.removeAccountMoney('cash', property.price)
		SetPropertyOwned(propertyName, property.price, false, xPlayer.identifier)
	else
		TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent")
	end
end)

RegisterNetEvent('esx_property:removeOwnedProperty', function(propertyName, priceRender)
	local source = source;
	local xPlayer = ESX.GetPlayerFromId(source);
	RemoveOwnedProperty(propertyName, xPlayer.identifier, source, true);
end)

AddEventHandler('esx_property:removeOwnedPropertyIdentifier', function(propertyName, identifier)
	RemoveOwnedProperty(propertyName, identifier)
end)

RegisterServerEvent('esx_property:saveLastProperty')
AddEventHandler('esx_property:saveLastProperty', function(property)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = @last_property WHERE identifier = @identifier', {
		['@last_property'] = property,
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_property:deleteLastProperty')
AddEventHandler('esx_property:deleteLastProperty', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_property:putItem')
AddEventHandler('esx_property:putItem', function(owner, type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then
		local i = ESX.GetItem(item);

		if (not i) then return; end
		local playerItem = xPlayer.getInventoryItem(item)

		if playerItem.count >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventory.getItem(item).label))
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de déposer "..count.." "..i.label.."")
				--logToDiscordApart("Property (putIn)", "Le joueur ("..xPlayer.getName()..") ["..xPlayer.getIdentifier().."] vient de déposer un item ("..count..", "..inventory.getItem(item).label..") dans son appartement.")
				SendLogs("Appartement", "Valestia | Property", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de déposer **"..count.."** item (**"..i.label.."**) dans son appartement", "https://discord.com/api/webhooks/1226967777466781706/bkSJQ5iMuXItlSfZWKIriYLyEUZTlR72_tUHbuv6xiZJi6qYFydLHqICqOUMj3z0XNrH")
			end)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Quantité invalide")
		end
	elseif type == 'item_account' then
		local xAccount = xPlayer.getAccount(item)

		if xAccount.money >= count and count > 0 then
			TriggerEvent('esx_addonaccount:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
				xPlayer.removeAccountMoney(item, count)
				account.addMoney(count)
				--logToDiscordApart("Property (putIn)", "Le joueur ("..xPlayer.getName()..") ["..xPlayer.getIdentifier().."] vient de déposer de l'argent ("..count..", "..item..") dans son appartement.")
				SendLogs("Appartement", "Valestia | Property", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de déposer **"..count.."$** (**"..item.."**) dans son appartement", "https://discord.com/api/webhooks/1226967777466781706/bkSJQ5iMuXItlSfZWKIriYLyEUZTlR72_tUHbuv6xiZJi6qYFydLHqICqOUMj3z0XNrH")
			end)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Montant invalide")
		end
	elseif type == 'item_weapon' then
		local weaponName = string.upper(item)

		if xPlayer.hasWeapon(weaponName) then
			local isPermanent = ESX.IsWeaponPermanent(weaponName)
			if not isPermanent then
				TriggerEvent('esx_datastore:getDataStore', 'property', xPlayerOwner.identifier, function(store)
					local weapons = store.get('weapons') or {}

					table.insert(weapons, {
						name = weaponName,
						ammo = count
					})

					store.set('weapons', weapons)
					xPlayer.removeWeapon(weaponName)
					--logToDiscordApart("Property (putIn)", "Le joueur ("..xPlayer.getName()..") ["..xPlayer.getIdentifier().."] vient de déposer une arme ("..weaponName..") dans son appartement.")
					SendLogs("Appartement", "Valestia | Property", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de déposer une arme **"..weaponName.."** dans son appartement", "https://discord.com/api/webhooks/1226967777466781706/bkSJQ5iMuXItlSfZWKIriYLyEUZTlR72_tUHbuv6xiZJi6qYFydLHqICqOUMj3z0XNrH")
				end)
			else
				xPlayer.showNotification('Vous ne pouvez pas déposer cette arme !')
			end
		else
			xPlayer.showNotification('Vous ne possédez pas cette arme !')
		end
	end
end)

RegisterServerEvent('esx_property:getItem')
AddEventHandler('esx_property:getItem', function(owner, type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then
		TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)

			if inventoryItem.count >= count and count > 0 then
				if xPlayer.canCarryItem(item, count) then
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, inventoryItem.label))
					TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez pris: "..count.." "..inventoryItem.label.."")
					--logToDiscordApart("Property (takeIn)", "Le joueur ("..xPlayer.getName()..") ["..xPlayer.getIdentifier().."] vient de prendre un item ("..count..", "..inventory.getItem(item).label..") dans son appartement.")
					SendLogs("Appartement", "Valestia | Property", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre **"..count.."** item (**"..inventory.getItem(item).label.."**) dans son appartement", "https://discord.com/api/webhooks/1226967777466781706/bkSJQ5iMuXItlSfZWKIriYLyEUZTlR72_tUHbuv6xiZJi6qYFydLHqICqOUMj3z0XNrH")
				else
					TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'avez pas assez de place dans votre inventaire")
				end
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Il n'y a pas cette quantité dans la propriété")
			end
		end)
	elseif type == 'item_account' then
		TriggerEvent('esx_addonaccount:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
			if account.money >= count and count > 0 then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
				SendLogs("Appartement", "Valestia | Property", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre **"..count.."$** (**"..item.."**) dans son appartement", "https://discord.com/api/webhooks/1226967777466781706/bkSJQ5iMuXItlSfZWKIriYLyEUZTlR72_tUHbuv6xiZJi6qYFydLHqICqOUMj3z0XNrH")
				--logToDiscordApart("Property (takeIn)", "Le joueur ("..xPlayer.getName()..") ["..xPlayer.getIdentifier().."] vient de prendre de l'argent ("..count..", "..item..") dans son appartement.")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Montant invalide")
			end
		end)
	elseif type == 'item_weapon' then
		TriggerEvent('esx_datastore:getDataStore', 'property', xPlayerOwner.identifier, function(store)
			local weaponName = string.upper(item)

			if not xPlayer.hasWeapon(weaponName) then
				local weapons = store.get('weapons') or {}

				for i = 1, #weapons, 1 do
					if weapons[i].name == weaponName and weapons[i].ammo == count then
						table.remove(weapons, i)

						store.set('weapons', weapons)
						xPlayer.addWeapon(weaponName, count)
						--logToDiscordApart("Property (takeIn)", "Le joueur ("..xPlayer.getName()..") ["..xPlayer.getIdentifier().."] vient de prendre une arme ("..weaponName..") dans son appartement.")
						SendLogs("Appartement", "Valestia | Property", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre une arme **"..weaponName.."** dans son appartement", "https://discord.com/api/webhooks/1226967777466781706/bkSJQ5iMuXItlSfZWKIriYLyEUZTlR72_tUHbuv6xiZJi6qYFydLHqICqOUMj3z0XNrH")
						break
					end
				end
			else
				xPlayer.showNotification('Vous possédez déjà cette arme !')
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_property:getOwnedProperties', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(ownedProperties)
		local properties = {}

		for i = 1, #ownedProperties, 1 do
			table.insert(properties, ownedProperties[i].name)
		end

		cb(properties)
	end)
end)

ESX.RegisterServerCallback('esx_property:getLastProperty', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_property FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_property)
	end)
end)

ESX.RegisterServerCallback('esx_property:getPropertyInventory', function(source, cb, owner)
	local dirtycash, items, weapons = 0, {}, {}

	TriggerEvent('esx_addonaccount:getAccount', 'property_dirtycash', owner, function(account)
		dirtycash = account.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'property', owner, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'property', owner, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		dirtycash = dirtycash,
		items = items,
		weapons = weapons
	})

end)

ESX.RegisterServerCallback('esx_property:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		dirtycash = xPlayer.getAccount('dirtycash').money,
		items = xPlayer.inventory,
		weapons = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('esx_property:getPlayerDressing', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count = store.count('dressing')
		local labels = {}

		for i = 1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('esx_property:getPlayerOutfit', function(source, cb, num)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('esx_property:removeOutfit')
AddEventHandler('esx_property:removeOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)

function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE rented = 1', {}, function(result)
		for i = 1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

			local society = ESX.DoesSocietyExist("realestateagent");

			if (society) then
				if xPlayer then

					xPlayer.removeAccountMoney('bank', result[i].price)
					ESX.AddSocietyMoney("realestateagent", result[i].price);
					--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_rent', ESX.Math.GroupDigits(result[i].price)))
					TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez payer votre location de: "..ESX.Math.GroupDigits(result[i].price).."$")

				else

					MySQL.Async.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier', {
						['@bank'] = result[i].price,
						['@identifier'] = result[i].owner
					});

					ESX.AddSocietyMoney("realestateagent", result[i].price);
				end
			end

		end
	end)
end

function logToDiscordApart(name,message,color)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = 'https://discord.com/api/webhooks/1226967777466781706/bkSJQ5iMuXItlSfZWKIriYLyEUZTlR72_tUHbuv6xiZJi6qYFydLHqICqOUMj3z0XNrH'

    local embeds = {
        {
            ["title"]= message,
            ["type"]= "rich",
            ["color"] = color,
            ["footer"]=  {
                ["text"]= "Heure: " ..local_date,
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end