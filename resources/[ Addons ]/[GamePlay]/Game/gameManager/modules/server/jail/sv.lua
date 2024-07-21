 --[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

JailX = {}
local allowedByServer = false

RegisterServerEvent('jail:onConnecting')
AddEventHandler('jail:onConnecting', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },function(result)
        if result[1] then
            TriggerClientEvent('jail:PutInBack', source, result[1].remainingTasks, result[1].motif)
        end
    end)
end)

exports["vCore3"]:RegisterCommand("jail", function(xPlayer, args)
    local tPlayer = ESX.GetPlayerFromId(args[1] ~= nil and tonumber(args[1]) or nil)

    --if (xPlayer and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), tPlayer.getGroup())) then
    --    return
    --end

    if not tPlayer or args[1] == nil then 
        if (xPlayer) then
            xPlayer.showNotification("ID incorrecte")
            return;
        else
            ESX.Logs.Warn("ID incorrecte");
            return;
        end
    else
        if (xPlayer) then
            MySQL.Async.fetchAll('SELECT 1 FROM jail WHERE identifier = @identifier', {
                ['@identifier'] = tPlayer.identifier
            },function(result)
                if result[1] then
                    xPlayer.showNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Ce joueur est déjà en prison !")
                else
                    xPlayer.triggerEvent("JailMenu:OpenMenu", args[1])
                end
            end)
            return;
        else
            if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
                TriggerEvent("JailMenu:JailPlayer", args[1], args[2], args[3])
                return
            else
                ESX.Logs.Warn("Certaines valeurs sont incorrectes ou inexistantes")
            end
        end
    end
end, {help = "Mettre un joueur en prison", params = {
    {name = "player_id", help = "Id du joueur, qui va être mis en prison"},
}}, {
    inMode = true,
    permission = "player_jail"
});

exports["vCore3"]:RegisterCommand("unjail", function(xPlayer, args)

    if not tonumber(args[1]) then
        return
    end

    if GetPlayerName(tonumber(args[1])) == nil then

        if (xPlayer) then

            xPlayer.showNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ID incorrecte")

        end

        return

    end

    local id = args[1]
    local tPlayer = ESX.GetPlayerFromId(id)

    allowedByServer = true

    SendLogs("Jail", "Valestia | UnJail", "**"..tPlayer.name.."** (***"..tPlayer.identifier.."***) a été libéré de prison par **"..((xPlayer and xPlayer.name) or "Console").."** (***"..((xPlayer and xPlayer.identifier) or "CONSOLE:IDENTIFIER").."***)", "https://discord.com/api/webhooks/1226958627957641297/sUVfx5E1HfJySwWM6EFB4Ckxlkp_C1NbNINHYL0C2EY2AD-jIM4ycANch51QoONDZ98M")
    MySQL.Async.fetchAll('SELECT remainingTasks FROM jail WHERE identifier = @identifier', {
        ['@identifier'] = tPlayer.identifier
    },function(result)

        if result[1] then

            TriggerClientEvent('jail:UnPut', id)

            if (xPlayer) then

                xPlayer.showNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Le joueur a été sortit de prison !")

            end
        else

            if (xPlayer) then

                xPlayer.showNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Ce joueur n'est pas en prison !")

            end

        end

    end)

end, {help = "Unjail un joueur", params = {
    {name = "player_id", help = "Id du joueur, qui va être enlever de la prison"}
}}, {
    inMode = true,
    permission = "player_unjail"
});

RegisterServerEvent('jail:updateState')
AddEventHandler('jail:updateState', function(time)
    if allowedByServer == true then
        JailX[source] = {
            number = time,
            hasBeenAllowed = true
        }
        allowedByServer = false
        TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
        TriggerClientEvent('esx_status:add', source, 'hunger', 1000000) 
    else
        xPlayer.ban(0, '(jail:updateState');
        return
    end
end)

RegisterServerEvent('jail:removeTask')
AddEventHandler('jail:removeTask', function(nbr)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT remainingTasks FROM jail WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },function(result)
        if result[1] then
            JailX[source] = {
                number = result[1].remainingTasks-1,
                hasBeenAllowed = false
            }
            MySQL.Async.execute("UPDATE jail SET remainingTasks = @b WHERE identifier = @a", {
                ['a'] = xPlayer.identifier,
                ['b'] = nbr
            }, function()
            end)
        end
    end)
end)

RegisterServerEvent('jail:SetInJail')
AddEventHandler('jail:SetInJail', function(jailStay, reason)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    JailX[source] = {
        number = jailStay,
        hasBeenAllowed = false
    }
    MySQL.Async.execute('INSERT INTO jail VALUES (@identifier, @number, @reason)', {  
        ['@identifier'] = xPlayer.identifier,        
        ['@number'] = jailStay,
        ['@reason'] = reason
    }, function(rowsChanged)       
    end)
end)

RegisterServerEvent('jail:SetInJailBack')
AddEventHandler('jail:SetInJailBack', function(jailStay)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    JailX[source] = {
        number = jailStay,
        hasBeenAllowed = false
    }
end)

RegisterServerEvent('jail:HealPlayer')
AddEventHandler('jail:HealPlayer', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if JailX[source] == nil then
        xPlayer.ban(0, '(jail:HealPlayer)');
        return
    end 
    TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
    TriggerClientEvent('esx_status:add', source, 'hunger', 1000000)
end)

RegisterServerEvent('jail:finish')
AddEventHandler('jail:finish', function()
    local source = source
    if not source then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    if JailX[source].number ~= 0 then
        xPlayer.ban(0, '(jail:finish)');
        return
    end
    MySQL.Async.execute("DELETE FROM jail WHERE identifier = @a AND remainingTasks = @b", {
        ['a'] = xPlayer.identifier,
        ['b'] = 0
    }, function()
        TriggerClientEvent('jail:finishAll', source)
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous avez été libéré de après avoir réalisé l'entièreté de vos tâches !")
    end)
end)

RegisterServerEvent('jail:remove')
AddEventHandler('jail:remove', function(timeLeft)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not JailX[source].hasBeenAllowed then
        xPlayer.ban(0, '(jail:remove)');
        return
    end
    MySQL.Async.execute("DELETE FROM jail WHERE identifier = @a AND remainingTasks = @b", {
        ['a'] = xPlayer.identifier,
        ['b'] = timeLeft
    }, function()
       -- TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous avez été libéré de prison !")
    end)
end)