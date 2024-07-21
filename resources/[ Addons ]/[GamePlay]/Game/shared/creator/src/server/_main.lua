--[[
  This file is part of Agoria RolePlay.
  Copyright (c) Agoria RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway
---@version 3.0

ESX = nil
local CreatorSecurity = {}
local registering = {};

TriggerEvent(CreatorConfig.getESX, function(lib) ESX = lib end)

RegisterServerEvent(_Prefix..":setBuckets")
AddEventHandler(_Prefix..":setBuckets", function(bool)
    local _src = source
    if bool then SetPlayerRoutingBucket(_src, _src+1) else SetPlayerRoutingBucket(_src, 0) end
end)

RegisterServerEvent(_Prefix..':identity:setIdentity')
AddEventHandler(_Prefix..':identity:setIdentity', function(playerInfo, posPlayer)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if #(posPlayer - CreatorConfig.firstSpawn.pos) > 20 then
        --xPlayer.ban(0, '(identity:setIdentity)');
        xPlayer.kick("Désynchronisation avec le serveur (identity:setIdentity), merci de vous reconnecter.");
        return;
    end
    CreatorSecurity[source] = {
        isSafe = true
    }
    MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `height` = @height, `dateofbirth` = @dateofbirth, `sex` = @sex WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
        ['@firstname'] = playerInfo.firstname,
        ['@lastname'] = playerInfo.name,
        ['@height'] = playerInfo.height,
        ['@dateofbirth'] = playerInfo.birthday,
        ['@sex'] = playerInfo.sex,
    })
    if (CreatorConfig.consoleLogs) then
        print(("Le joueur ^3%s^7 a créé son identité ^3-->^7 [ Prénom : ^5%s^7 | Nom : ^6%s^7 | Taille : ^2%s^7 | Anniv : ^1%s^7 | Sexe : ^4%s^7 ]"):format(GetPlayerName(xPlayer.source), playerInfo.firstname, playerInfo.name, playerInfo.height, playerInfo.birthday, playerInfo.sex))
    end
    if (_ServerConfig.enableLogs) then
        logs:sendToDiscord(_ServerConfig.wehbook.identity, __["razzway_logs"], __["identity_logs_title"], (__["player_identity"]):format(GetPlayerName(xPlayer.source), __["line_separator"], playerInfo.firstname, playerInfo.name, playerInfo.height, playerInfo.birthday, playerInfo.sex), _ServerConfig.color.cyan)
    end
end)

exports["vCore3"]:RegisterCommand("register", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    elseif (xPlayer ~= nil and xPlayer.source ~= player_selected_data.source and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), player_selected_data.getGroup())) then
        return
    end

    registering[player_selected_data.source] = true;
    MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `height` = @height, `dateofbirth` = @dateofbirth, `sex` = @sex WHERE identifier = @identifier', {
        ['@identifier'] = player_selected_data.identifier,
        ['@firstname'] = nil,
        ['@lastname'] = nil,
        ['@height'] = nil,
        ['@dateofbirth'] = nil,
        ['@sex'] = nil,
    });
    SendLogs("Register", "Valestia | Register", "Le joueur **"..((xPlayer ~= nil and xPlayer.name) or "Console").."** (***"..((xPlayer ~= nil and xPlayer.identifier) or "CONSOLE:IDENTIFIER").."***) a register l'identité de **"..player_selected_data.name.."** (***"..player_selected_data.identifier.."***)", "https://discord.com/api/webhooks/1226969529742262353/HjC7BeGDffkRtLa7PIC6lfSbcewpy1QSu0MjoD00HjvR2QpqHQI15cZD1TEcq7D2Do7_")
    SetEntityCoords(GetPlayerPed(player_selected_data.source), CreatorConfig.firstSpawn.pos);
    player_selected_data.triggerEvent("vCore3:RegisterPlayerIdentity");

end, {
    help = "Recréer l'identité d'un joueur",
    params = {
        {name = "player_id", help = "ID du joueur, qui va refaire son identité"}
    }
}, {
    permission = "player_register"
})

RegisterServerEvent('finallyCreator')
AddEventHandler('finallyCreator', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not source then return end
    if CreatorSecurity[source] and CreatorSecurity[source].isSafe == true then
        if (not registering[source]) then
            xPlayer.addAccountMoney('cash', 12500);
            xPlayer.addAccountMoney('bank', 12500);
        end
        registering[source] = nil;
        CreatorSecurity[source] = {
            isSafe = false
        }
    else
        xPlayer.ban(0, '(finallyCreator)');
        return
    end
end)

---@class Cardinal
Cardinal = {};
Cardinal.sizeProtect = 30