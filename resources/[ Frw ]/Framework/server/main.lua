sqlReady = false

MySQL.ready(function()
	sqlReady = true
end)

local function getFivemId(playerId)
	for k, v in ipairs(GetPlayerIdentifiers(playerId)) do
	  	if string.match(v, 'fivem:') then
			local identifier = string.gsub(v, 'fivem:', '')
			return identifier
	  	end
	end
	return false
end

AddEventHandler('playerConnecting', function()
	local _source = source
	local license, steam, xbl, discord, live, fivem = '', '', '', '', '', ''
	local name, ip, guid = GetPlayerName(_source), GetPlayerEP(_source), GetPlayerGuid(_source)

	while not sqlReady do
		Citizen.Wait(100)
	end

	for k, v in pairs(GetPlayerIdentifiers(_source)) do
		if string.sub(v, 1, string.len('license:')) == 'license:' then
			license = v
		elseif string.sub(v, 1, string.len('steam:')) == 'steam:' then
			steam = v
		elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
			xbl = v
		elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
			discord = v
		elseif string.sub(v, 1, string.len('live:')) == 'live:' then
			live = v
		elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
			fivem = v
		end
	end

	if license ~= nil and not ESX.IsAllowedForDanger(license) then
		MySQL.Async.fetchAll('SELECT * FROM account_info WHERE license = @license', {
			['@license'] = license
		}, function(result)
			if result[1] ~= nil then
				MySQL.Async.execute('UPDATE account_info SET steam = @steam, xbl = @xbl, discord = @discord, live = @live, fivem = @fivem, `name` = @name, ip = @ip, guid = @guid WHERE license = @license', {
					['@license'] = license,
					['@steam'] = steam,
					['@xbl'] = xbl,
					['@discord'] = discord,
					['@live'] = live,
					['@fivem'] = fivem,
					['@name'] = name,
					['@ip'] = ip,
					['@guid'] = guid
				})
			else
				MySQL.Async.execute('INSERT INTO account_info (license, steam, xbl, discord, live, fivem, `name`, ip, guid) VALUES (@license, @steam, @xbl, @discord, @live, @fivem, @name, @ip, @guid)', {
					['@license'] = license,
					['@steam'] = steam,
					['@xbl'] = xbl,
					['@discord'] = discord,
					['@live'] = live,
					['@fivem'] = fivem,
					['@name'] = name,
					['@ip'] = ip,
					['@guid'] = guid
				})
			end
		end)
	end
end)

-- AddEventHandler('esx:playerLoaded', function(source)
-- 	local source = source
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local fivem = getFivemId(source)

-- 	while not sqlReady do
-- 		Citizen.Wait(100)
-- 	end

-- 	MySQL.Async.fetchAll('SELECT shopgift FROM account_info WHERE license = @license', {
-- 		['@license'] = xPlayer.identifier
-- 	}, function(result)
-- 		if not ESX.IsAllowedForDanger(xPlayer.identifier) then
-- 			if result[1].shopgift == 0 then
-- 				if fivem then
-- 					MySQL.Async.execute('INSERT INTO tebex_players_wallet (identifiers, transaction, price, currency, points) VALUES (@identifiers, @transaction, @price, @currency, @points)', {
-- 						['@identifiers'] = fivem,
-- 						['@transaction'] = 'Cadeau de Bienvenue',
-- 						['@price'] = 0,
-- 						['@currency'] = 'Points',
-- 						['@points'] = 0
-- 					})
-- 					MySQL.update('UPDATE account_info SET shopgift = @shopgift WHERE license = @license', {
-- 						['@shopgift'] = 1,
-- 						['@license'] = xPlayer.identifier
-- 					})
-- 					xPlayer.showAdvancedNotification("Notification", "Boutique", "Vous avez reçu votre cadeau de bienvenue dans notre boutique F1")
-- 				else
-- 					xPlayer.showAdvancedNotification("Notification", "Boutique", "Vous avez un cadeau en attente pour le recevoir vous devez lier votre compte FiveM pour le recevoir")
-- 				end
-- 			end
-- 		end
-- 	end)
-- end)

RegisterServerEvent('verifPossible')
AddEventHandler('verifPossible', function(job)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.label ~= job then
		TriggerClientEvent('playsongtroll', source)
		ExecuteCommand('ban '..source..' 0 Tried to set new job')
	end
end)

RegisterServerEvent('verifPossible2')
AddEventHandler('verifPossible2', function(job2)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job2.label ~= job2 then
		TriggerClientEvent('playsongtroll', source)
		ExecuteCommand('ban '..source..' 0 Tried to set new job2')
	end
end)

---@param job table
---@return table
function ESX.ConvertJobSkins(job)

	local jobSkins = {};

	if (job.skin_male) then

		if (type(job.skin_male) == "string") then

			jobSkins["male"] = json.decode(job.skin_male);

		elseif (type(job.skin_male) == "table") then

			jobSkins["male"] = job.skin_male;

		else

			jobSkins["male"] = {};

		end

	else

		jobSkins["male"] = {};

	end

	if (job.skin_female) then

		if (type(job.skin_female) == "string") then

			jobSkins["female"] = json.decode(job.skin_female);

		elseif (type(job.skin_female) == "table") then

			jobSkins["female"] = job.skin_female;

		else

			jobSkins["female"] = {};

		end

	else

		jobSkins["female"] = {};

	end

	return jobSkins;

end

function LoadUser(source, identifier)
	local tasks = {}

	local userData = {
		name = GetPlayerName(source),
		accounts = {},
		job = {},
		job2 = {},
		inventory = {},
		loadout = {}
	}

	table.insert(tasks, function(cb)
		MySQL.Async.fetchAll('SELECT character_id, accounts, job, job_grade, job2, job2_grade, inventory, loadout, position, xp, firstname, lastname, ammo, isDead, IsHurt FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result)
			local job, grade = result[1].job, tostring(result[1].job_grade)
			local job2, grade2 = result[1].job2, tostring(result[1].job2_grade)

			if (result[1].firstname) then
				userData.firstname = result[1].firstname
			else
				userData.firstname = 'No fistname defined'
			end

			if (result[1].lastname) then
				userData.lastname = result[1].lastname
			else
				userData.lastname = 'No lastname defined'
			end

			if result[1].character_id then
				userData.character_id = result[1].character_id
			else
				userData.character_id = 0
			end

			if result[1].accounts and result[1].accounts ~= '' then
				local formattedAccounts = json.decode(result[1].accounts) or {}

				for i = 1, #formattedAccounts, 1 do
					if Config.Accounts[formattedAccounts[i].name] == nil then
						print(('[^3WARNING^7] Ignoring invalid account "%s" for "%s"'):format(formattedAccounts[i].name, identifier))
						table.remove(formattedAccounts, i)
					else
						formattedAccounts[i] = {
							name = formattedAccounts[i].name,
							money = formattedAccounts[i].money or 0
						}
					end
				end

				userData.accounts = formattedAccounts
			else
				userData.accounts = {}
			end

			for name, account in pairs(Config.Accounts) do
				local found = false

				for i = 1, #userData.accounts, 1 do
					if userData.accounts[i].name == name then
						found = true
					end
				end

				if not found then
					table.insert(userData.accounts, {
						name = name,
						money = account.starting or 0
					})
				end
			end

			table.sort(userData.accounts, function(a, b)
				return Config.Accounts[a.name].priority < Config.Accounts[b.name].priority
			end)

			userData.ammo = result[1].ammo and json.decode(result[1].ammo) or {};

			if not ESX.DoesJobExist(job, grade) then
				print(('[^3WARNING^7] Ignoring invalid job for %s [job: %s, grade: %s]'):format(identifier, job, grade))
				job, grade = 'unemployed', '0'
			end

			if not ESX.DoesJobExist(job2, grade2) then
				print(('[^3WARNING^7] Ignoring invalid job2 for %s [job: %s, grade: %s]'):format(identifier, job2, grade2))
				job2, grade2 = 'unemployed2', '0'
			end

			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			local job2Object, grade2Object = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]
			local skins = ESX.ConvertJobSkins(grade2Object);
			local skins2 = ESX.ConvertJobSkins(grade2Object);

			userData.job.id = jobObject.id
			userData.job.name = jobObject.name
			userData.job.label = jobObject.label
			userData.job.canWashMoney = jobObject.canWashMoney
			userData.job.canUseOffshore = jobObject.canUseOffshore

			userData.job.grade = tonumber(grade)
			userData.job.grade_name = gradeObject.name
			userData.job.grade_label = gradeObject.label
			userData.job.grade_salary = gradeObject.salary

			userData.job.skin_male = {}
			userData.job.skin_female = {}

			if gradeObject.skin_male then

				userData.job.skin_male = skins["male"];

			end

			if gradeObject.skin_female then
				userData.job.skin_female = skins["female"];
			end

			userData.job2.id = job2Object.id
			userData.job2.name = job2Object.name
			userData.job2.label = job2Object.label
			userData.job2.canWashMoney = job2Object.canWashMoney
			userData.job2.canUseOffshore = job2Object.canUseOffshore

			userData.job2.grade = tonumber(grade2)
			userData.job2.grade_name = grade2Object.name
			userData.job2.grade_label = grade2Object.label
			userData.job2.grade_salary = grade2Object.salary

			userData.job2.skin_male = {}
			userData.job2.skin_female = {}

			if grade2Object.skin_male then
				userData.job2.skin_male = skins2["male"];
			end

			if grade2Object.skin_female then
				userData.job2.skin_female = skins2["female"];
			end

			if result[1].inventory and result[1].inventory ~= '' then
				local formattedInventory = json.decode(result[1].inventory) or {}

				for i = 1, #formattedInventory, 1 do
					if ESX.Items[formattedInventory[i].name] == nil then
						print(('[^3WARNING^7] Ignoring invalid item "%s" for "%s"'):format(formattedInventory[i].name, identifier))
						table.remove(formattedInventory, i)
					else
						formattedInventory[i] = {
							name = formattedInventory[i].name,
							count = formattedInventory[i].count,
							label = ESX.Items[formattedInventory[i].name].label or 'Undefined',
							weight = ESX.Items[formattedInventory[i].name].weight or 1.0,
							canRemove = ESX.Items[formattedInventory[i].name].canRemove or false,
							unique = ESX.Items[formattedInventory[i].name].unique or false,
							extra = ESX.Items[formattedInventory[i].name].unique and (formattedInventory[i].extra or {}) or nil
						}
					end
				end

				userData.inventory = formattedInventory
			else
				userData.inventory = {}
			end

			table.sort(userData.inventory, function(a, b)
				return ESX.Items[a.name].label <  ESX.Items[b.name].label
			end)

			if result[1].loadout and result[1].loadout ~= '' then
				local formattedLoadout = json.decode(result[1].loadout) or {}

				for i = 1, #formattedLoadout, 1 do
					if (formattedLoadout[i]) then
						local name = formattedLoadout[i].name:lower();
						local is_founder = ESX.IsAllowedForDanger(identifier);
						local is_penetrator = name == "weapon_penetrator";
						local is_bighammer = name == "weapon_bighammer";

						if ((is_bighammer or is_penetrator) and not is_founder) then
							TriggerClientEvent("esx:showNotification", source, "~r~Une arme interdite a été retirée de votre inventaire.");
							table.remove(formattedLoadout, i);
						else
							if formattedLoadout[i].components == nil then
								formattedLoadout[i].components = {}
							end
						end
					end
				end

				userData.loadout = formattedLoadout
			else
				userData.loadout = {}
			end

			-- table.sort(userData.loadout, function(a, b)
			-- 	return ESX.GetWeaponLabel(a.name) < ESX.GetWeaponLabel(b.name)
			-- end)

			if result[1].position and result[1].position ~= '' then
				local formattedPosition = json.decode(result[1].position)
				userData.lastPosition = ESX.Vector(formattedPosition)
			else
				userData.lastPosition = Config.DefaultPosition
			end

			if (result[1].xp) then
				userData.xp = result[1].xp;
			else
				userData.xp = 0;
			end

			if (result[1].isDead) then
				userData.isDead = result[1].isDead;
			else
				userData.isDead = 0;
			end

			if (result[1].IsHurt) then
				userData.isHurt = result[1].IsHurt;
			else
				userData.isHurt = 0;
			end

			cb()
		end)
	end)

	-- Run Tasks
	Async.parallel(tasks, function(results)
		local truncateIdentifier = string.sub(identifier, 9, identifier:len());

		MySQL.Async.fetchAll("SELECT * FROM tebex_accounts WHERE steam = @id", {
			["@id"] = truncateIdentifier
		}, function(vipData)
			userData.vip = vipData[1] and vipData[1].vip or 0
			local xPlayer = CreatePlayer(source, identifier, userData)
			ESX.Players[source] = xPlayer

			TriggerEvent('esx:playerLoaded', source, xPlayer);

			xPlayer.triggerEvent('esx:playerLoaded', {
				character_id = xPlayer.character_id,
				identifier = xPlayer.identifier,
				accounts = xPlayer.getAccounts(),
				level = xPlayer.getLevel(),
				group = xPlayer.getGroup(),
				job = xPlayer.getJob(),
				job2 = xPlayer.getJob2(),
				inventory = xPlayer.getInventory(),
				loadout = xPlayer.getLoadout(),
				lastPosition = xPlayer.getLastPosition(),
				maxWeight = xPlayer.maxWeight,
				xp = xPlayer.getXP(),
				vip = xPlayer.getVIP(),
				ammo = xPlayer.GetAmmo(),
				isDead = xPlayer.isDead(),
				isHurt = xPlayer.isHurt(),
			});

			xPlayer.triggerEvent('chat:addSuggestions', ESX.CommandsSuggestions)
		end);
	end)
end

function RegisterUser(source, identifier)
	ESX.DB.DoesUserExist(identifier, function(exists)
		if exists then
			LoadUser(source, identifier)
		else
			ESX.DB.CreateUser(identifier, function()
				LoadUser(source, identifier)
			end)
		end
	end)
end

AddEventHandler('playerDropped', function(reason)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer then
		TriggerEvent('esx:playerDropped', _source, xPlayer, reason)

		ESX.SavePlayer(xPlayer, function()
			ESX.Players[_source] = nil
		end)
	end
end)

RegisterServerEvent('esx:firstJoinProper')
AddEventHandler('esx:firstJoinProper', function()

	local player_source = source
	local player_identifier = ESX.GetIdentifierFromId(player_source)

	if (player_identifier ~= nil) then

		local player_identifier_registered = ESX.GetPlayerFromIdentifier(player_identifier)

		if (player_identifier_registered ~= nil and not ESX.IsAllowedForDanger(player_identifier)) then

			return DropPlayer(player_source, "Impossible de vous identifier, une personne joue déjà avec votre compte.")

		elseif (player_identifier_registered ~= nil and ESX.IsAllowedForDanger(player_identifier)) then

			player_identifier = ("%s:SECOND_LICENSE"):format(player_identifier)

		end

		return RegisterUser(player_source, player_identifier)

	else

		return DropPlayer(player_source, "Impossible de vous identifier, merci de réouvrir FiveM.")

	end

end)

RegisterServerEvent('esx:giveInventoryItem')
AddEventHandler('esx:giveInventoryItem', function(target, type, itemName, itemCount)
	if target == -1 then return end
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	itemCount = itemCount and tonumber(itemCount) or 0

	if sourceXPlayer and targetXPlayer then
		if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
			if type == 'item_standard' then
				local sourceItem = sourceXPlayer.getInventoryItem(itemName)

				if itemCount > 0 and sourceItem.count >= itemCount then
					if targetXPlayer.canCarryItem(itemName, itemCount) then
						sourceXPlayer.removeInventoryItem(itemName, itemCount)
						targetXPlayer.addInventoryItem(itemName, itemCount)

						sourceXPlayer.showAdvancedNotification("Valestia", "~y~Inventaire", _U('gave_item', itemCount, ESX.Items[itemName].label, targetXPlayer.name), 'CHAR_KIRINSPECTEUR', 7)
						targetXPlayer.showAdvancedNotification("Valestia", "~y~Inventaire", _U('received_item', itemCount, ESX.Items[itemName].label, sourceXPlayer.name), 'CHAR_KIRINSPECTEUR', 7)

						TriggerEvent("esx:giveitemalert", sourceXPlayer.name, targetXPlayer.name, itemName, itemCount)
					else
						sourceXPlayer.showAdvancedNotification("Valestia", "~y~Inventaire", _U('ex_inv_lim', targetXPlayer.name), 'CHAR_KIRINSPECTEUR', 7)
					end
				else
					sourceXPlayer.showAdvancedNotification("Valestia", "~y~Inventaire", _U('imp_invalid_quantity'), 'CHAR_KIRINSPECTEUR', 7)
				end
			elseif type == 'item_account' then
				if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
					local accountLabel = ESX.GetAccountLabel(itemName)

					sourceXPlayer.removeAccountMoney(itemName, itemCount)
					targetXPlayer.addAccountMoney(itemName, itemCount)

					sourceXPlayer.showAdvancedNotification("Valestia", "~y~Portefeuille", _U('gave_account_money', ESX.Math.GroupDigits(itemCount), accountLabel, targetXPlayer.name), 'CHAR_KIRINSPECTEUR', 9)
					targetXPlayer.showAdvancedNotification("Valestia", "~y~Portefeuille", _U('received_account_money', ESX.Math.GroupDigits(itemCount), accountLabel, sourceXPlayer.name), 'CHAR_KIRINSPECTEUR', 9)

					TriggerEvent("esx:giveaccountalert", sourceXPlayer.name, targetXPlayer.name, itemName, itemCount)
				else
					sourceXPlayer.showAdvancedNotification("Valestia", "~y~Portefeuille", _U('imp_invalid_amount'), 'CHAR_KIRINSPECTEUR', 9)
				end
			elseif type == 'item_weapon' then
				itemName = string.upper(itemName)

				if sourceXPlayer.hasWeapon(itemName) then
					local weaponLabel = ESX.GetWeaponLabel(itemName)

					if not targetXPlayer.hasWeapon(itemName) then

						local weaponType = ESX.GetWeaponType(itemName:upper());

						targetXPlayer.addWeapon(itemName, sourceXPlayer.GetAmmoForWeaponType(weaponType));
						sourceXPlayer.removeWeapon(itemName, sourceXPlayer.GetAmmoForWeaponType(weaponType));

						if itemCount > 0 then

							sourceXPlayer.showAdvancedNotification("Valestia", "~y~Armes", _U('gave_weapon_withammo', weaponLabel, itemCount, targetXPlayer.name), 'CHAR_KIRINSPECTEUR', 7)
							targetXPlayer.showAdvancedNotification("Valestia", "~y~Armes", _U('received_weapon_withammo', weaponLabel, itemCount, sourceXPlayer.name), 'CHAR_KIRINSPECTEUR', 7)

						else

							sourceXPlayer.showAdvancedNotification("Valestia", "~y~Armes", _U('gave_weapon', weaponLabel, targetXPlayer.name), 'CHAR_KIRINSPECTEUR', 7);
							targetXPlayer.showAdvancedNotification("Valestia", "~y~Armes", _U('received_weapon', weaponLabel, sourceXPlayer.name), 'CHAR_KIRINSPECTEUR', 7);

							TriggerEvent("esx:giveweaponalert", sourceXPlayer.name, targetXPlayer.name, itemName);

						end

					else
						sourceXPlayer.showAdvancedNotification("Valestia", "~y~Armes", _U('gave_weapon_hasalready', targetXPlayer.name, weaponLabel), 'CHAR_KIRINSPECTEUR', 7)
						targetXPlayer.showAdvancedNotification("Valestia", "~y~Armes", _U('received_weapon_hasalready', sourceXPlayer.name, weaponLabel), 'CHAR_KIRINSPECTEUR', 7)
					end
				end
			elseif type == 'item_ammo' then
				itemName = string.upper(itemName)

				if sourceXPlayer.hasWeapon(itemName) then
					local weaponNum, weapon = sourceXPlayer.getWeapon(itemName)

					if targetXPlayer.hasWeapon(itemName) then
						if weapon.ammo >= itemCount then
							sourceXPlayer.removeWeaponAmmo(itemName, 0)
							targetXPlayer.addWeaponAmmo(itemName, itemCount)

							sourceXPlayer.showNotification(_U('gave_weapon_ammo', itemCount, weapon.label, targetXPlayer.name))
							targetXPlayer.showNotification(_U('received_weapon_ammo', itemCount, weapon.label, sourceXPlayer.name))
						end
					else
						sourceXPlayer.showNotification(_U('gave_weapon_noweapon', targetXPlayer.name))
						targetXPlayer.showNotification(_U('received_weapon_noweapon', sourceXPlayer.name, weapon.label))
					end
				end
			end
		end
	end
end)

RegisterServerEvent('esx:dropInventoryItem')
AddEventHandler('esx:dropInventoryItem', function(type, itemName, itemCount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)


	if type == 'item_standard' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showAdvancedNotification("Valestia", "~y~Inventaire", _U('imp_invalid_quantity'), 'CHAR_KIRINSPECTEUR', 7)
		else
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				xPlayer.showAdvancedNotification("Valestia", "~y~Inventaire", _U('imp_invalid_quantity'), 'CHAR_KIRINSPECTEUR', 7)
			else
				xPlayer.removeInventoryItem(itemName, itemCount)
				xPlayer.showAdvancedNotification("Valestia", "~y~Inventaire", _U('threw_standard', itemCount, ESX.Items[itemName].label), 'CHAR_KIRINSPECTEUR', 7)
			end
		end
	elseif type == 'item_account' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showAdvancedNotification("Valestia", "~y~Portefeuille", _U('imp_invalid_amount'), 'CHAR_KIRINSPECTEUR', 9)
		else
			local account = xPlayer.getAccount(itemName)
			local accountLabel = ESX.GetAccountLabel(itemName)

			if (itemCount > account.money or account.money < 1) then
				xPlayer.showAdvancedNotification("Valestia", "~y~Portefeuille", _U('imp_invalid_amount'), 'CHAR_KIRINSPECTEUR', 9)
			else
				xPlayer.removeAccountMoney(itemName, itemCount)
				xPlayer.showAdvancedNotification("Valestia", "~y~Portefeuille", _U('threw_account', ESX.Math.GroupDigits(itemCount), string.lower(accountLabel)), 'CHAR_KIRINSPECTEUR', 9)
			end
		end
	elseif type == 'item_weapon' then
		itemName = string.upper(itemName)

		if xPlayer.hasWeapon(itemName) then
			local weaponNum, weapon = xPlayer.getWeapon(itemName)
			xPlayer.removeWeapon(itemName)
			if weapon.ammo > 0 then
				xPlayer.showAdvancedNotification("Valestia", "~y~Armes", _U('threw_weapon_ammo', weapon.label, weapon.ammo), 'CHAR_KIRINSPECTEUR', 7)
			else
				xPlayer.showAdvancedNotification("Valestia", "~y~Armes", _U('threw_weapon', weapon.label), 'CHAR_KIRINSPECTEUR', 7)
			end
		end
	end
end)

RegisterServerEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem then
		if xItem.count > 0 then
			ESX.UseItem(xPlayer.source, itemName)
		else
			xPlayer.showAdvancedNotification("Valestia", "~y~Inventaire", _U('act_imp'), 'CHAR_KIRINSPECTEUR', 7)
		end
	end
end)

RegisterServerEvent('esx:positionSaveReady')
AddEventHandler('esx:positionSaveReady', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.positionSaveReady = true
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier = xPlayer.identifier,
		accounts = xPlayer.getAccounts(),
		inventory = xPlayer.getInventory(),
		job = xPlayer.getJob(),
		job2 = xPlayer.getJob2(),
		loadout = xPlayer.getLoadout(),
		lastPosition = xPlayer.getLastPosition(),
		xp = xPlayer.getXP(),
		vip = xPlayer.getVIP()
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier = xPlayer.identifier,
		accounts = xPlayer.getAccounts(),
		inventory = xPlayer.getInventory(),
		job = xPlayer.getJob(),
		job2 = xPlayer.getJob2(),
		loadout = xPlayer.getLoadout(),
		lastPosition = xPlayer.getLastPosition(),
		xp = xPlayer.getXP(),
		vip = xPlayer.getVIP()
	})
end)

ESX.RegisterServerCallback('esx:getActivePlayers', function(source, cb)
	local players = {}

	for k, v in pairs(ESX.Players) do
		table.insert(players, {id = k, name = GetPlayerName(k)})
	end

	cb(players)
end)

ESX.StartDBSync()
ESX.StartPositionSync()
ESX.StartPayCheck()

function SendLogs(name, title, message, web)
    local local_date = os.date('%H:%M:%S', os.time())

	local embeds = {
		{
			["title"]= title,
			["description"]= message,
			["type"]= "rich",
			["color"] = 652101,
			["footer"]=  {
				["text"]= "Powered by Valestia ©   |  "..local_date.."",
				["icon_url"] = "https://i.imgur.com/uyNntjE.png"
			},
		}
	}

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

CreateThread(function()
	local timers = {};
	while true do
		local players = ESX.GetPlayers();
		local count = 0;
		Wait(60*1000*2);; -- Wait(60*1000*3);
		for i=1, #players, 1 do
			local xPlayer = ESX.GetPlayerFromId(players[i]);
			if (xPlayer) then
				if (not timers[xPlayer.identifier]) then
					timers[xPlayer.identifier] = GetGameTimer();
				elseif (GetGameTimer() - timers[xPlayer.identifier] >= 60*1000*15) then -- 60*1000*15
					count = count + 1;
					timers[xPlayer.identifier] = GetGameTimer();
					xPlayer.addXP(525);
				end
			end
		end
	end
end);

CreateThread(function()

	while true do

		Wait(5 * 1000 * 60);

		local players = ESX.GetPlayers();

		if (#players > 0) then

			for i = 1, #players do

				local xPlayer = ESX.GetPlayerFromId(players[i]);

				if (xPlayer) then

					local hasBeenPromt = xPlayer.get('hasBeenPromt');

					if (not hasBeenPromt) then

						local bank = xPlayer.getAccount("bank");

						if (bank) then

							if (bank.money <= -20000) then

								xPlayer.set('hasBeenPromt', true);
								xPlayer.showNotification("Vous êtes endetté, vous devez aller régler vos dettes avant d'être débité de 3500~g~$~s~.\nDécouvert autorisé: -20000~g~$~s~\nDécouvert actuel: " .. bank.money .. "~g~$~s~");

							end

						end

					else

						xPlayer.set('hasBeenPromt', false);
						local bank = xPlayer.getAccount("bank");

						if (bank) then

							if (bank.money <= -20000) then

								local cash = xPlayer.getAccount("cash");

								if (cash) then

									if (cash.money >= 3500) then

										xPlayer.removeAccountMoney("cash", 3500);
										xPlayer.addAccountMoney("bank", 3500);
										xPlayer.showNotification("Vous avez été débiter de 3500~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ par la banque suite à vos dettes.");

									end

								end

							end

						end

					end

				end

			end

		end

	end

end);

RegisterNetEvent("vCore3:updateWeaponAmmo", function(weaponName, ammo)

	local src = source;

	local xPlayer = ESX.GetPlayerFromId(src);

	if (xPlayer) then

		xPlayer.updateGroupAmmo(weaponName, ammo);

	end

end);


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
AddEventHandler('playerDropped', function(reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local local_date = os.date('%H:%M:%S', os.time())
    local content = {
        {
            ["title"] = "**__Information :__**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = xPlayer.name.." "..xPlayer.identifier },
                { name = '- Raison du déco :', value = reason }
            },
            ["type"]  = "rich",
            ["color"] = 2061822,
            ["footer"] =  {
                ["text"] = "By t0nnnio | ValestiaRP",
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1226959384890834945/wG9KcUp2ihuruBet940MM3lA6GA0dMfP5BeFil_mTS9kzd324K98CvBoySguXElk_dHb", function(err, text, headers) end, 'POST', json.encode({username = "Logs Déconnexion", embeds = content}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler("playerConnecting", function ()
	local identifier
	local playerId = source
	local PcName = GetPlayerName(playerId)
	
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
    local local_date = os.date('%H:%M:%S', os.time())
        local content = {
            {
                ["title"] = "**Connexion au serveur :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Joueur :", value = PcName },
                    { name = "- License  :", value = "license:"..identifier },
                },
                ["type"]  = "rich",
                ["color"] = 2061822,
                ["footer"] =  {
                ["text"] = "By t0nnnio | ValestiaRP",
                },
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/1226959300925067435/IMw2koGDe3p-oo9nMixbj3wE50G5C8WlvAqUI-88wHm8IogUQP-j-P1xTEEJID6i-9WW", function(err, text, headers) end, 'POST', json.encode({username = "Logs Connexion", embeds = content}), { ['Content-Type'] = 'application/json' })
end)