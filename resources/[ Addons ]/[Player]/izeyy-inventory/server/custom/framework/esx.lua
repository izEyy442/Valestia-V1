--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

if Config.esxVersion == 'new' then
	ESX = exports['es_extended']:getSharedObject()
elseif Config.esxVersion == 'old' then
    ESX = nil
    TriggerEvent(Config.Trigger["getSharedObject"], function(obj) ESX = obj end)
end


userColumns = 'users'

licenseTable = 'user_licenses'
idLicenseTable = 'owner'
typeLicenseTable = 'type'

vehiclesTable = 'owned_vehicles' 
idVehTable = 'owner' 
plateVehTable = 'plate' 

phoneTable = 'phone_phones'
idPhoneTable = 'id'
numberTable = 'phone_number' 

function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function GetPlayerInventory(player)
    return player.getInventory()
end

function GetPlayerWeapon(player)
    return player.getLoadout()
end

function GetPlayerMoney(player)
    return player.getAccounts()
end

function GetPlayerWeight(player)
    return player.getWeight()
end

function GetPlayerMaxWeight(player)
    return player.maxWeight
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetJob(player)
    if player == nil then return "unemployed" end
	if ESX.GetPlayerFromId(player) == nil then 
		return "unemployed"
	else
		local tempJob = ESX.GetPlayerFromId(player).job
		tempJob.onduty = true
		return tempJob
	end
end

function GetPlayerLicense(player)
	return player.identifier
end

function math.round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function GetPlayers()
	return ESX.GetPlayers()
end

function GetItemLabel(name)
	return ESX.GetItemLabel(name)
end

function GetInfoIdCard(player)
	local identifier = GetPlayerLicense(player)
	result = MySQL.Sync.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height  FROM `'..userColumns..'` WHERE identifier = @identifier', {
		['@identifier'] = player
	})
	if result[1] then
		return result
	end

end

-- weight

function getWeight(player, name, count)
	return player.canCarryItem(name, count)
end

-- item

function AddItem(xPlayer, item, count)
	xPlayer.addInventoryItem(item, count)
end

function RemoveItem(player, item, count)
	player.removeInventoryItem(item, count)
end

function GetItem(player, item)
	return player.getInventoryItem(item)
end

function GetItemAmount(item)
	return item.count
end

function GetWeightPlayer(player, item, count)
	return player.canCarryItem(item, count)
end

-- weapon

function hasWeapon(player, item)
	return player.hasWeapon(item)
end

function addWeapon(player, item, count)
	player.addWeapon(item, count)
end

function removeWeapon(player, item)
	player.removeWeapon(item)
end

function getWeapon(player, weapon)
	return player.hasWeapon(weapon)
end

function infoWeapon(player, weapon)
	return player.getWeapon(weapon)
end

function addWeaponComponent(player, itemName, component)
	return player.addWeaponComponent(itemName, component)
end


-- money 

function addMoney(player, item, count)
	player.addAccountMoney(item, count)
end

function removeMoney(player, account, count)
	player.removeAccountMoney(account, count)
end

function getAccount(player, account)
	return player.getAccount(account).money
end


function showNotification(player, msg, type)
	TriggerClientEvent('inv:Notification', player.source, msg, type)
end