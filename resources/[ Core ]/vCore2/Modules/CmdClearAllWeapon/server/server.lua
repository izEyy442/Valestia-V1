ESX.AddGroupCommand('clearallweapon', 'founder', function(source, args, user)

	if args[1] then
		xPlayer = ESX.GetPlayerFromId(source)
		tPlayer = ESX.GetPlayerFromId(args[1])
	else
		xPlayer = ESX.GetPlayerFromId(source)
		tPlayer = ESX.GetPlayerFromId(source)
	end

	if (tPlayer) then
		tPlayer.removeAllWeapons(nil, true);
        xPlayer.showNotification('Vous avez clear les armes de : '..tPlayer.name)
		SendLogs("Clear", "Valestia | Clear", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a clear les armes de **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://discord.com/api/webhooks/1226971657076211722/pR6daKrbRXxePGVf2aeyOgk1_A70JcImK3uThRMffizgN7vDWx-ak7re65FoUT2sASi8")
	else
		ESX.ChatMessage(source, "Le joueur n'est pas en ligne.")
	end
	
end, {help = ('clear toute les armes y compris les armes perm'), params = {
	{name = "playerId", help = ('command_playerid_param')}
}})
