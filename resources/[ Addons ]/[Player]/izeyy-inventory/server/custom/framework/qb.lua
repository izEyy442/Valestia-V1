--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "qb" then
    return
end

QBCore = exports['qb-core']:GetSharedObject()


userColumns = 'players'

vehiclesTable = 'player_vehicles' 
idVehTable = 'citizenid' 
plateVehTable = 'plate' 

phoneTable = 'phone_phones'
idPhoneTable = 'id'
numberTable = 'phone_number' 

function RegisterServerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function GetPlayerInventory(player)
    return player.PlayerData.items

end

function GetPlayerWeapon(player)
    return
end

function GetPlayerMoney(player)
    return
end

function GetPlayerWeight(player)
    return QBCore.Player.GetTotalWeight(player.PlayerData.items) / 1000
end

function GetPlayerMaxWeight(player)
    return QBCore.Config.Player.MaxWeight / 1000
end


function GetPlayerFromId(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then 
        Player.citizenid = Player.PlayerData.citizenid
        Player.identifier = Player.PlayerData.citizenid
        Player.source = Player.PlayerData.source
	end
    return Player
end

function GetJob(player)
    if not player then return end
    local data = QBCore.Functions.GetPlayer(player)
    if not data then return "unemployed" end
    local ppdata = data.PlayerData
    return ppdata.job
end

function GetPlayerLicense()
    return QBCore.Functions.GetPlayerByCitizenId()
end

function math.round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

-- GetItemLabel

function GetInfoIdCard(player)
    local result = {
        firstname = player.PlayerData.charinfo.firstname,
        lastname = player.PlayerData.charinfo.lastname,
        dateofbirth = player.PlayerData.charinfo.birthdate,
        sex = player.PlayerData.charinfo.gender,
        height = 0
    }
    return result
end

-- item

function AddItem(player, item, count)
	player.Functions.AddItem(item, count)
end

function RemoveItem(player, item, count)
	player.Functions.RemoveItem(item, count)
end

function GetItem(player, item)
	return player.Functions.GetItemByName(item)
end

function GetItemAmount(item)
	return item.amount
end

function GetWeightPlayer(player, item, count)
	return true
end

-- weapon

function addWeapon(player, item, count)
	player.Functions.AddItem(item, count)
end

function removeWeapon(player, item, count)
	player.Functions.RemoveItem(item, count)
end


function getWeapon(player, weapon)
	return player.Functions.GetItemByName(weapon)
end

function infoWeapon(player, weapon)
	return player.Functions.GetItemByName(weapon)
end

function addWeaponComponent(player, itemName, component)
	return player.Functions.AddItem(component)
end

-- money 

function addMoney(player, account, amount)
    return player.Functions.AddMoney(account, amount)
end

function RemoveMoney(player, account, amount)
    return player.Functions.RemoveMoney(account, amount)
end


function getAccount(player, account, count)
	return player.PlayerData.money[account]
end

function showNotification(player, msg, type)
	TriggerClientEvent('inv:Notification', player.source, msg, type)
end