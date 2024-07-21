-- --[[
--   This file is part of Valestia RolePlay.
--   Copyright (c) Valestia RolePlay - All Rights Reserved
--   Unauthorized using, copying, modifying and/or distributing of this file,
--   via any medium is strictly prohibited. This code is confidential.
-- --]]

-- -- RegisterNetEvent('vCore3:playerHurt', function()
-- -- 	local vCore1_la_pute = source;
-- -- 	local vCore1_player = ESX.GetPlayerFromId(vCore1_la_pute);
-- -- 	vCore1_player.setHurt(true);
-- -- end);

-- --- Retour au source 🤡

-- local commands = {};
-- local lastCodes = {};

-- ---@param player xPlayer
-- local function show_warning(player)
-- 	if (player) then
-- 		player.showNotification("~r~runcode:~s~ Remember this is a beta version, bug may appear.");
-- 	else
-- 		ESX.Logs.Info("^1runcode:^7 Remember this is a beta version, bug may appear.");
-- 	end
-- end

-- ---@param command_name string
-- ---@param raw_command string
-- local function get_args(command_name, raw_command)
-- 	local str, index = raw_command:gsub(command_name, "");
-- 	local final_str, _ = str:gsub(" ", "", 1);
-- 	return final_str;
-- end

-- ---@param player xPlayer
-- ---@param err string
-- local function show_error(player, err)
-- 	if (player) then
-- 		player.showNotification(("An error occured while executing command 'runcode'. Stack: %s"):format(tostring(err)));
-- 	else
-- 		ESX.Logs.Info(("An error occured while executing command 'runcode'. Stack: %s"):format(tostring(err)));
-- 	end
-- end

-- ---@param name string
-- ---@param func fun(player: xPlayer, raw: string)
-- local function register_subcommand(name, func)
-- 	commands[name:lower()] = func;
-- end

-- ---@param source number | xPlayer
-- local function get_last_code_key(source)
-- 	return (type(source) == "table" and source.identifier or "source");
-- end

-- ---@param str_code string
-- ---@param player xPlayer
-- local function execute_code(str_code, player)
-- 	local success, result = pcall(load, str_code);

-- 	if (not success) then
-- 		show_error(player, result);
-- 		return;
-- 	end

-- 	local success2, result2 = pcall(result);

-- 	if (not success2) then
-- 		show_error(player, result2);
-- 		return;
-- 	end

-- 	lastCodes[get_last_code_key(player)] = str_code;

-- 	if (player) then
-- 		player.showNotification("Command 'runcode' executed successfully.");
-- 	else
-- 		ESX.Logs.Info("Command 'runcode' executed successfully.");
-- 	end
-- end

-- ---@param source number
-- ---@param args string[]
-- ---@param rawCommand string
-- RegisterCommand("runcode", function(source, args, rawCommand)
-- 	local player;

-- 	if (type(source) == "number" and source > 0) then
-- 		player = ESX.GetPlayerFromId(source);
-- 		if (not player) then return; end
-- 		if (not ESX.IsAllowedForDanger(player)) then
-- 			xPlayer.showNotification("You are not allowed to use this command.");
-- 			return;
-- 		end
-- 	end

-- 	show_warning(player);

-- 	if (not args[1] or not commands[args[1]:lower()]) then
-- 		if (player) then
-- 			player.showNotification("Invalid command.");
-- 		else
-- 			ESX.Logs.Info("Invalid command.");
-- 		end
-- 		return;
-- 	end

-- 	local name = args[1]:lower();
-- 	local success, result = pcall(
-- 		commands[args[1]:lower()],
-- 		player,
-- 		get_args(
-- 			name,
-- 			get_args(
-- 				"runcode",
-- 				rawCommand
-- 			)
-- 		)
-- 	);

-- 	if (not success) then
-- 		show_error(player, result);
-- 	end

-- end);

-- register_subcommand("help", function(player)
-- 	if (player) then
-- 		player.showNotification("Available commands: ~s~(~g~help~s~, ~g~start~s~, ~g~reload~s~, ~g~last~s~)");
-- 	else
-- 		ESX.Logs.Info("Available commands: ^7(^3help^7, ^3start^7, ^3reload^7, ^3last^7)");
-- 	end
-- end);

-- register_subcommand("start", function(player, raw_command)
-- 	execute_code(get_args("runcode", raw_command), player);
-- end);

-- register_subcommand("reload", function(player, raw)
-- 	execute_code(lastCodes[get_last_code_key(player)], player);
-- end);

-- register_subcommand("last", function (player)
-- 	local code = lastCodes[get_last_code_key(player)];

-- 	if (not code) then
-- 		if (player) then
-- 			player.showNotification("No code previously executed.");
-- 		else
-- 			ESX.Logs.Info("No code previously executed.");
-- 		end
-- 		return;
-- 	end

-- 	if (player) then
-- 		player.showNotification(("Last code: ~r~%s"):format(code));
-- 	else
-- 		ESX.Logs.Info(("Last code: ^1%s^7"):format(code));
-- 	end
-- end);