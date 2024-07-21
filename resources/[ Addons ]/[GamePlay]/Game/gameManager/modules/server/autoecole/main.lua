--[[
  This file is part of Exelity RolePlay.
  Copyright (c) Exelity RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

RegisterServerEvent('autoecole:pay')
AddEventHandler('autoecole:pay', function(price)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('bank').money >= price then
        xPlayer.removeAccountMoney('bank', price)
    else
        xPlayer.showNotification("Vous n'avez pas assez d'argent en banque")
    end
end)

local AntiSpamLimit = {}

RegisterServerEvent('addpermis')
AddEventHandler('addpermis', function(permis)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if (not AntiSpamLimit[xPlayer.identifier] or GetGameTimer() - AntiSpamLimit[xPlayer.identifier] > 300000) then
        AntiSpamLimit[xPlayer.identifier] = GetGameTimer()
        MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @identifier AND type = @type', {
            ['@identifier'] = xPlayer.identifier,
            ['@type'] = permis
        },function(result)
            if result[1] then
                return
            else
                MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
                    ['@type'] = permis,
                    ['@owner'] = xPlayer.identifier
                })
            end
        end)
    end
end)