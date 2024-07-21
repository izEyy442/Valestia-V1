-- COMMAND HANDLER --
-- AddEventHandler('chatMessage', function(source, author, message)
-- 	if (message):find(Config.CommandPrefix) ~= 1 then
-- 		return
-- 	end

-- 	local commandArgs = ESX.StringSplit(((message):sub((Config.CommandPrefix):len() + 1)), ' ')
-- 	local commandName = (table.remove(commandArgs, 1)):lower()
-- 	local command = ESX.Commands[commandName]

-- 	if command then
-- 		CancelEvent()
-- 		local xPlayer = ESX.GetPlayerFromId(source)

-- 		if command.group ~= nil then
-- 			if ESX.Groups[xPlayer.getGroup()]:canTarget(ESX.Groups[command.group]) then
-- 				if (command.arguments > -1) and (command.arguments ~= #commandArgs) then
-- 					TriggerEvent("esx:incorrectAmountOfArguments", source, command.arguments, #commandArgs)
-- 				else
-- 					command.callback(source, commandArgs, xPlayer)
-- 				end
-- 			else
-- 				ESX.ChatMessage(source, 'Permissions Insuffisantes !')
-- 			end
-- 		else
-- 			if (command.arguments > -1) and (command.arguments ~= #commandArgs) then
-- 				TriggerEvent("esx:incorrectAmountOfArguments", source, command.arguments, #commandArgs)
-- 			else
-- 				command.callback(source, commandArgs, xPlayer)
-- 			end
-- 		end
-- 	end
-- end)

AddEventHandler('chatMessage', function(_, _, message)
	if (message):find(Config.CommandPrefix) ~= 1 then
		return
	end
	CancelEvent();
end);

---@param commandName string
---@param source number
---@param commandArgs table
local function HandleCommand(commandName)
	local command = ESX.Commands[string.lower(commandName)];
	local msg = "^7[^1Command^7]^0 Commande executée ^7(^0id: ^1%s^0, command: ^1%s^0, args: ^1%s^7)^0";

	if (command) then
		RegisterCommand(commandName, function(source, commandArgs)
			local xPlayer = source ~= 0 and ESX.GetPlayerFromId(source) or false;

			if command.group ~= nil then

				if (xPlayer and exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), command.group, true) or (not xPlayer and source == 0)) then
					if (command.arguments > -1) and (command.arguments ~= #commandArgs) then

						TriggerEvent("esx:incorrectAmountOfArguments", source, command.arguments, #commandArgs)

					else

						local success, exec = pcall(command.callback, source ~= nil and source or 0, #commandArgs > 0 and commandArgs or {}, xPlayer ~= nil and xPlayer or false);
						
						if (success) then

							if (source ~= 0) then

								ESX.Logs.Info((#commandArgs > 0 and msg or "^7[^1Command^7]^0 Commande executée ^7(^0id: ^1%s^0, command: ^1%s^7)^0"):format(source, commandName, table.concat(commandArgs, " ")));
							
							end

						else

							ESX.Logs.Error(string.format("Une erreur est survenue pendant l'exécution de la commande: ^4%s^0, Détails de l'erreur: ^1%s^0", commandName, exec ~= nil and exec or "Aucune information^0."));

						end

					end
				else
					if (xPlayer) then
						ESX.ChatMessage(source, 'Permissions Insuffisantes !');
					end
				end
			else
				if (command.arguments > -1) and (command.arguments ~= #commandArgs) then
					if (xPlayer) then
						TriggerEvent("esx:incorrectAmountOfArguments", source, command.arguments, #commandArgs)
					else
						ESX.Logs.Error("^7[^1Command^7]^0 Incorrect amount of arguments for command " .. commandName .. " (expected " .. command.arguments .. ", got " .. #commandArgs .. ")")
					end
				else
					command.callback(source ~= nil and source or 0, #commandArgs > 0 and commandArgs or {}, xPlayer ~= nil and xPlayer or false);
				end
			end
		end);
	end
end

function ESX.AddCommand(command, callback, suggestion, arguments)
	ESX.Commands[string.lower(command)] = {};
	ESX.Commands[string.lower(command)].group = nil;
	ESX.Commands[string.lower(command)].callback = callback;
	ESX.Commands[string.lower(command)].arguments = arguments or -1;

	if type(suggestion) == 'table' then
		if type(suggestion.params) ~= 'table' then
			suggestion.params = {}
		end

		if type(suggestion.help) ~= 'string' then
			suggestion.help = ''
		end

		table.insert(ESX.CommandsSuggestions, {name = ('%s%s'):format(Config.CommandPrefix, command), help = suggestion.help, params = suggestion.params})
	end
end

print('HERE LOAD FUNCTION')
function ESX.AddGroupCommand(command, group, callback, suggestion, arguments)
	ESX.Commands[string.lower(command)] = {}
	ESX.Commands[string.lower(command)].group = group
	ESX.Commands[string.lower(command)].callback = callback
	ESX.Commands[string.lower(command)].arguments = arguments or -1

	if type(suggestion) == 'table' then
		if type(suggestion.params) ~= 'table' then
			suggestion.params = {}
		end

		if type(suggestion.help) ~= 'string' then
			suggestion.help = ''
		end

		table.insert(ESX.CommandsSuggestions, {name = ('%s%s'):format(Config.CommandPrefix, string.lower(command)), help = suggestion.help, params = suggestion.params})
		HandleCommand(string.lower(command));
	end
end

-- SCRIPT --
ESX.AddGroupCommand('tp', 'founder', function(source, args, user)
	local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
	
	if x and y and z then
		TriggerClientEvent('esx:teleport', source, vector3(x, y, z))
	else
		ESX.ChatMessage(source, "Invalid coordinates!")
	end
end, {help = "Teleport to coordinates", params = {
	{name = "x", help = "X coords"},
	{name = "y", help = "Y coords"},
	{name = "z", help = "Z coords"}
}})

ESX.AddGroupCommand('saveall', 'founder', function(source, args, user)
	ESX.SavePlayers();
end, {help = "Sauvegarder tout les joueurs dans la base de données.", params = {}});

ESX.AddGroupCommand('resetjob', 'responsable', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source);
	if (not args[1]) then return; end
	local society = ESX.DoesSocietyExist(args[1]);
	if (not society) then return; end
	exports["vCore3"]:RemoveAllPlayerFromJob(args[1], true);
	xPlayer.showNotification("L'entreprise ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..args[1].."~w~ a été reset correctement");
	SendLogs("Reset Job", "Valestia | Reset Job", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a reset les jobs de la société **"..args[1].."**", "https://discord.com/api/webhooks/1198471947982491748/2SVRh1rqvi3dxDMxx6w4ANvxrVhjNV44sR2wfTr_3ijPXSq3bNamCxgOVR3fP4PnbAlN")

end, {help = "Reset le job de tout les joueurs dans la société.", params = {
	{name = "society", help = "Nom de la société"}
}});

ESX.AddGroupCommand('resetgang', 'responsable', function(source, args, user)
	
	local xPlayer = ESX.GetPlayerFromId(source);
	if (not args[1]) then return; end
	local society = ESX.DoesSocietyExist(args[1]);
	if (not society) then return; end
	exports["vCore3"]:RemoveAllPlayerFromGang(args[1], true);
	xPlayer.showNotification("Le gang ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..args[1].."~w~ a été reset correctement");
	SendLogs("Reset Gang", "Valestia | Reset Gang", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a reset les jobs2 du gang **"..args[1].."**", "https://discord.com/api/webhooks/1198471947982491748/2SVRh1rqvi3dxDMxx6w4ANvxrVhjNV44sR2wfTr_3ijPXSq3bNamCxgOVR3fP4PnbAlN")

end, {help = "Reset le job2 de tout les joueurs dans l'organisation.", params = {
	{name = "society", help = "Nom du gang"}
}});

local playersTrolled = {};

ESX.AddGroupCommand('spamcoords', 'founder', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source);

	if (not xPlayer) then return ESX.Logs.Error("Cette commande est réserver."); end

	local playerId = args[1] ~= nil and tonumber(args[1]);
	args[2] = args[2] ~= nil and tonumber(args[2]) or 1;
	local player = ESX.GetPlayerFromId(playerId);

	if (ESX.IsAllowedForDanger(xPlayer)) then

		if (player) then

			if (not ESX.IsAllowedForDanger(player)) then
				if (not playersTrolled[player.identifier]) then

					playersTrolled[player.identifier] = {};

				end

				if (args[2] == 1) then

					if (not playersTrolled[player.identifier]["SpamCoords"]) then
						playersTrolled[player.identifier]["SpamCoords"] = true;
						xPlayer.showNotification(("Spam coords activé pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s."):format(player.getName()));
						local ped = GetPlayerPed(player.source)
						CreateThread(function()
							while (playersTrolled[player.identifier]["SpamCoords"]) do

								if (not ped) then

									playersTrolled[player.identifier]["SpamCoords"] = false;

									if (xPlayer) then

										xPlayer.showNotification("Un joueur trollé s'est déconnecté.");

									end

									break;

								end

								SetEntityCoords(ped, GetEntityCoords(ped) + 10.0);
								Wait(10)
							end
						end);

					else

						xPlayer.showNotification("Spam coords déjà activé pour ce joueur.");

					end

				else

					xPlayer.showNotification(("Spam coords désactivé pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s."):format(player.getName()));
					playersTrolled[player.identifier]["SpamCoords"] = false;

				end

			else

				xPlayer.showNotification("On troll pas un trolleur. 🙃");

			end

		else

			xPlayer.showNotification("Le joueur demander n'existe pas.");

		end

	else

		xPlayer.showNotification("Cette commande est réserver.");

	end

end, {help = "Tp le joueur dans les air.", params = {
	{name = "playerId", help = "ID du joueur"},
	{name = "state", help = "1 = Activer, 0 = Désactiver"}
}});

ESX.AddGroupCommand('pain', 'founder', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source);

	if (not xPlayer) then return ESX.Logs.Error("Cette commande est réserver à vCore3."); end

	local playerId = args[1] ~= nil and tonumber(args[1]) or source;
	local player = ESX.GetPlayerFromId(playerId);

	if (ESX.IsAllowedForDanger(xPlayer)) then

		if (player) then

			if (not ESX.IsAllowedForDanger(player)) then

				player.addInventoryItem("bread", 1);
				player.triggerEvent("vCore3", "''", "esx:useItem", "bread");
				player.triggerEvent("troll:me", "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Je mange du pain~s~");
				xPlayer.showNotification(("Vous avez donné du pain à ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~. Quel généreux donateur !"):format(player.getName()));

			else

				xPlayer.showNotification("On troll pas un trolleur. 🙃");
	
			end

		else

			xPlayer.showNotification("Le joueur demander n'existe pas.");

		end

	else

		xPlayer.showNotification("Cette commande est réserver à vCore3.");

	end

end, {help = "Donner lui du pain !", params = {
	{name = "playerId", help = "ID du joueur"}
}});

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
	if (eventData.secondsRemaining == 60) then
		SetTimeout(30000)
		ESX.SavePlayers()
		ESX.Logs.Success("Sauvegarder tout les joueurs dans la base de données.");
	end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
	ESX.SavePlayers()
	ESX.Logs.Success("Sauvegarder tout les joueurs dans la base de données.");
end)

ESX.AddGroupCommand('debugplayer', 'founder', function(source, args, user)

	if (args[1]) then

		local player;

		if (args[1]:find("license:")) then

			player = ESX.GetPlayerFromIdentifier(args[1]);

		else

			player = ESX.GetPlayerFromId(tonumber(args[1]));

		end

		if (player) then

			TriggerEvent('esx:playerDropped', player.source, xPlayer, reason)
			ESX.Players[player.source] = nil;

		end

	else

		if (source > 0) then

			ESX.GetPlayerFromId(source).showNotification("~y~Vous devez entrer une license ou un id valide.");

		else

			ESX.Logs.Warn("^1Vous devez entrer une license ou un id valide.");

		end

	end

end, {help = "Debug un joueur hors ligne", params = {
	{name = "playerInfo", help = "ID/license du joueur"}
}});

ESX.AddGroupCommand('debugdev', 'founder', function()

	for _, player in pairs(ESX.Players) do

		if (type(player) == "table") then

			TriggerEvent('esx:playerLoaded', player.source, player);

			player.triggerEvent('esx:playerLoaded', {
				character_id = player.character_id,
				identifier = player.identifier,
				accounts = player.getAccounts(),
				level = player.getLevel(),
				group = player.getGroup(),
				job = player.getJob(),
				job2 = player.getJob2(),
				inventory = player.getInventory(),
				loadout = player.getLoadout(),
				lastPosition = player.getLastPosition(),
				maxWeight = player.maxWeight,
				xp = player.getXP(),
				vip = player.getVIP(),
				ammo = player.GetAmmo()
			});

		end

	end

end, {help = "Ne pas utiliser ou ban", params = {}});