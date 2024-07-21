local local_date = os.date('%H:%M:%S', os.time())

Text               = {}
BanList            = {}
BanListLoad        = false
BanListHistory     = {}
BanListHistoryLoad = false
Text = cfg_banSQL.TextFr 

CreateThread(function()
	while true do
		Wait(1000)
        if BanListLoad == false then
			loadBanList()
			if BanList ~= {} then
				BanListLoad = true
			else
			end
		end
		if BanListHistoryLoad == false then
			loadBanListHistory()
            if BanListHistory ~= {} then
				BanListHistoryLoad = true
			else
			end
		end
	end
end)

CreateThread(function()
	while cfg_banSQL.MultiServerSync do
		Wait(30000)
		MySQL.Async.fetchAll(
		'SELECT * FROM banlist',
		{},
		function (data)
			if #data ~= #BanList then
			  BanList = {}

			  for i=1, #data, 1 do
				table.insert(BanList, {
					license    = data[i].license,
					ban_id     = data[i].ban_id,
					identifier = data[i].identifier,
					liveid     = data[i].liveid,
					xblid      = data[i].xblid,
					discord    = data[i].discord,
					playerip   = data[i].playerip,
					reason     = data[i].reason,
					added      = data[i].added,
					expiration = data[i].expiration,
					sourceplayername = data[i].sourceplayername,
					permanent  = data[i].permanent
				  })
			  end
			loadBanListHistory()
			TriggerClientEvent('BanSql:Respond', -1)
			end
		end
		)
	end
end)


ESX.AddGroupCommand('ban', 'moderateur', function (source, args, user)
	cmdban(source, args)
end, {help = Text.ban, params = {{name = "id"}, {name = "heure", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

ESX.AddGroupCommand('unban', 'moderateur', function (source, args, user)
	cmdunban(source, args)
end, {help = Text.unban, params = {{name = "name", help = Text.steamname}}})

ESX.AddGroupCommand('banoff', 'moderateur', function (source, args, user)
	cmdbanoffline(source, args)
end, {help = Text.banoff, params = {{name = "license", help = Text.permid}, {name = "heure", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

RegisterCommand("deban", function(source, args, raw)
	if source == 0 then
		deban(source, args)
	end
end, true)

RegisterServerEvent('tF:Protect')
AddEventHandler('tF:Protect', function(source, reason)
	local idplayer = ESX.GetPlayerFromId(source)
	local sourceplayername = "🛡️ tF-Protect"
	local duree = 0
	local banid = (math.random(100, 99999)..'-'..math.random(100, 99999))
	local xPlayer = ESX.GetPlayerFromId(source)
	local targetplayername = xPlayer.name
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			identifier = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end


	local xPlayer = ESX.GetPlayerFromId(source)
	local webhookLink = cfg_webhook.LogsProtect

		local content = {
			{
				["title"] = "**Logs Ban :**",
				["fields"] = {
					{ name = "**- Date & Heure :**", value = local_date },
					{ name = "- Joueurs ban :", value = xPlayer.name.." ["..xPlayer.identifier.."]" },
					{ name = "", value = "**Durée du bannissement :**\nPermanent\n\n**Raison du bannissement :**\nTentative de cheat sur event : "..reason.."\n\n**Auteur du ban :**\n"..sourceplayername.." | Anti Trigger\n\n**BAN-ID :**\n"..banid},
				},
				["type"]  = "rich",
				["color"] = 16711680,
				["footer"] =  {
				["text"] = "By t0nnnio | ValestiaRP",
				},
			}
		}
		PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs BAN", embeds = content}), { ['Content-Type'] = 'application/json' })


	--ban(source,banid,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1)
	TriggerClientEvent('PlaySoundForBan')
	Wait(1000)
	--DropPlayer(source, Text.yourpermban .. "\n\nTentative de cheat sur event : "..reason)
end)

RegisterServerEvent('BanSql:CheckMe')
AddEventHandler('BanSql:CheckMe', function()
	doublecheck(source)
end)

-- console / rcon can also utilize es:command events, but breaks since the source isn't a connected player, ending up in error messages
AddEventHandler('bansql:sendMessage', function(source, message)
	if source ~= 0 then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1Banlist ', message } } )
	else
		-- print('SqlBan: ' .. message)
	end
end)

AddEventHandler('playerConnecting', function (playerName,setKickReason)
	local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	--Si Banlist pas chargée
	if (Banlist == {}) then
		Citizen.Wait(1000)
	end

    if steamID == "n/a" and cfg_banSQL.ForceSteam then
		setKickReason(Text.invalidsteam)
		CancelEvent()
    end

	for i = 1, #BanList, 1 do
		if ((tostring(BanList[i].license)) == tostring(license) 
			or (tostring(BanList[i].identifier)) == tostring(steamID) 
			or (tostring(BanList[i].liveid)) == tostring(liveid) 
			or (tostring(BanList[i].xblid)) == tostring(xblid) 
			or (tostring(BanList[i].discord)) == tostring(discord)
			or (tostring(BanList[i].playerip)) == tostring(playerip))
		then
			local sourceplayername
			if BanList[i].sourceplayername ~= nil then
				sourceplayername = BanList[i].sourceplayername
			else
				sourceplayername = "Inconue"
			end
			if (tonumber(BanList[i].permanent)) == 1 then
				setKickReason(Text.yourpermban.."\n\n🆔 Votre ID de ban : "..BanList[i].ban_id.."\n🔱 Vous avez etait bannis par le staff : "..sourceplayername.."\n🕜 Temps de ban restant : Permanent\n❓ Raison du bannissement : "..BanList[i].reason.."\n\n")
				CancelEvent()
				break
			elseif (tonumber(BanList[i].expiration)) > os.time() then

				local tempsrestant     = (((tonumber(BanList[i].expiration)) - os.time())/60)
				if tempsrestant >= 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = (day - math.floor(day)) * 24
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason(Text.yourban.."\n\n🆔 Votre ID de ban : "..BanList[i].ban_id.."\n🔱 Vous avez etait bannis par le staff : "..sourceplayername.."\n🕜 Temps de ban restant : "..txtday..Text.day..txthrs..Text.hour..txtminutes..Text.minute.."\n❓ Raison du bannissement : "..BanList[i].reason.."\n\n")
						CancelEvent()
						break
				elseif tempsrestant >= 60 and tempsrestant < 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = tempsrestant / 60
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason(Text.yourban.."\n\n🆔 Votre ID de ban : "..BanList[i].ban_id.."\n🔱 Vous avez etait bannis par le staff : "..sourceplayername.."\n🕜 Temps de ban restant : "..txtday..Text.day..txthrs..Text.hour..txtminutes..Text.minute.."\n❓ Raison du bannissement : "..BanList[i].reason.."\n\n")
						CancelEvent()
						break
				elseif tempsrestant < 60 then
					local txtday     = 0
					local txthrs     = 0
					local txtminutes = math.ceil(tempsrestant)
						setKickReason(Text.yourban.."\n\n🆔 Votre ID de ban : "..BanList[i].ban_id.."\n🔱 Vous avez etait bannis par le staff : "..sourceplayername.."\n🕜 Temps de ban restant : "..txtday..Text.day..txthrs..Text.hour..txtminutes..Text.minute.."\n❓ Raison du bannissement : "..BanList[i].reason.."\n\n")
						CancelEvent()
						break
				end

			elseif (tonumber(BanList[i].expiration)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then
				deletebanned(license)
				break
			end
		end
	end
end)

AddEventHandler('esx:playerLoaded', function(source)
	local license,steamID,liveid,xblid,discord,playerip
	local playername = GetPlayerName(source)

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {
		['@license'] = license
	}, function(data)
	local found = false
		for i=1, #data, 1 do
			if data[i].license == license then
				found = true
			end
		end
		if not found then
			MySQL.Async.execute('INSERT INTO baninfo (license,identifier,liveid,xblid,discord,playerip,playername) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername)', 
				{ 
				['@license']    = license,
				['@identifier'] = steamID,
				['@liveid']     = liveid,
				['@xblid']      = xblid,
				['@discord']    = discord,
				['@playerip']   = playerip,
				['@playername'] = playername
				},
				function ()
			end)
		else
			MySQL.Async.execute('UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername WHERE `license` = @license', 
				{ 
				['@license']    = license,
				['@identifier'] = steamID,
				['@liveid']     = liveid,
				['@xblid']      = xblid,
				['@discord']    = discord,
				['@playerip']   = playerip,
				['@playername'] = playername
				},
				function ()
			end)
		end
	end)

	if cfg_banSQL.MultiServerSync then
		doublecheck(source)
	end
end)