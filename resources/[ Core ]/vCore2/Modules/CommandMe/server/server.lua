ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

local lang = Languages[dmeC.language]

local function onMeCommand(source, args)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    local text = "" .. lang.prefix .. table.concat(args, " ") .. ""
    if (string.find(text, "<img src")) then
      xPlayer.ban(0, 'Use /me usebug LOL');
      return
    end
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
end

local function onMeCommand2(source, args)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local text = "" .. lang.prefix .. ""..args .. ""
    if (string.find(text, "<img src")) then
      xPlayer.ban(0, 'Use /me usebug LOL');
      return
    end
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
end

RegisterCommand(lang.commandName, onMeCommand)

ESX.AddGroupCommand('metroll', 'founder', function(source, args, user)

  TriggerClientEvent("troll:me", args[1], table.concat(args, " ",2))
end, {help = 'Permet de troll les joueurs hihi', params = {
	{name = 'playerId', help = 'ID du joueurs'},
	{name = 'message', help = "le message troll "}
}})
