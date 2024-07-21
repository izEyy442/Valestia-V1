ESX = nil

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})
end)

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		local user, skin = users[1]

		local jobSkin = {
			skin_male = xPlayer.job.skin_male,
			skin_female = xPlayer.job.skin_female
		}

		if user.skin then
			skin = json.decode(user.skin)
		end

		cb(skin, jobSkin)
	end)
end)

exports["vCore3"]:RegisterCommand("skin", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    elseif (xPlayer ~= nil and xPlayer.source ~= player_selected_data.source and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), player_selected_data.getGroup())) then
        return
    end

    player_selected_data.triggerEvent("esx_skin:openSaveableMenu")

    if (xPlayer ~= nil) then
        xPlayer.showNotification(("Vous avez fait ouvrir le menu skin au joueur ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(player_selected_data.getName()))
    end

end, {help = "Permet de faire changer le skin d'un joueur", params = {
    {name = 'player_id', help = 'ID du joueur'}
}}, {
    permission = "player_skin"
})