TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local jobs = {};

AddEventHandler('onResourceStart', function(resource)

	if (resource ~= GetCurrentResourceName()) then
		return;
	end

	local players = GetPlayers();

	for i = 1, #players do

		local src = tonumber(players[i]);

		if (type(src) == 'number') then

			local player = ESX.GetPlayerFromId(src);

			if (type(player) == 'table') then
				TriggerClientEvent('jobbuilder:restarted', src, player);
			end

		end

	end

end);

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM jobbuilder', {}, function(r)
		for i = 1, #r do
			jobs[r[i].name] = r[i];
		end
	end);
end);

Citizen.CreateThread(function()
	while ESX == nil do Citizen.Wait(100) end

	ESX.RegisterServerCallback('JobBuilder:getUsergroup', function(source, cb)
		local _src = source
		local xPlayer = ESX.GetPlayerFromId(_src)
		local plyGroup = xPlayer.getGroup()
		cb(plyGroup)
	end)

	RegisterNetEvent('JobBuilder:addJob', function(job)

		local src = source;
		local xPlayer = ESX.GetPlayerFromId(src);

		if (not xPlayer) then
			return;
		end

		if (xPlayer.getGroup() == "founder") then

			ESX.AddSociety(job.Name, job.Label, 1, 0, 1, function(esxSociety)
				if (type(esxSociety) == 'table') then

					MySQL.Async.execute([[
						INSERT INTO `items` (`name`, `label`) VALUES (@nameitemrecolte, @labelitemrecolte);
						INSERT INTO `items` (`name`, `label`) VALUES (@nameitemtraitement, @labelitemtraitement);
						INSERT INTO `jobbuilder` (name, label, society, posboss, posveh, poscoffre, posspawncar, nameitemrecolte, labelitemrecolte, posrecolte, nameitemtraitement, labelitemtraitement, postraitement, vehingarage, posvente, prixvente) VALUES (@jobName, @jobLabel, @jobSociety, @posboss, @posveh, @poscoffre, @posspawncar, @nameitemrecolte, @labelitemrecolte, @posrecolte, @nameitemtraitement, @labelitemtraitement, @postraitement, @vehingarage, @posvente, @prixvente);
					]], {
						['jobName'] = job.Name,
						['jobLabel'] = job.Label,
						['jobSociety'] = 'society_' .. job.Name,
						['posboss'] = json.encode(job.PosBoss),
						['posveh'] = json.encode(job.PosVeh),
						['poscoffre'] = json.encode(job.PosCoffre),
						['posspawncar'] = json.encode(job.PosSpawnVeh),
						['nameitemrecolte'] = job.nameItemR,
						['labelitemrecolte'] = job.labelItemR,
						['posrecolte'] = json.encode(job.PosRecolte),
						['nameitemtraitement'] = job.nameItemT,
						['labelitemtraitement'] = job.labelItemT,
						['postraitement'] = json.encode(job.PosTraitement),
						['posvente'] = json.encode(job.PosVente),
						['vehingarage'] = json.encode(job.vehInGarage),
						['prixvente'] = job.PrixVente,
					}, function(rowsChanged)
						print('Job enregistrer >> '..job.Label);
						xPlayer.showNotification('Job enregistrer >> '..job.Label);
					end);

				else
					print('Erreur lors de la création de la société');
					xPlayer.showNotification('Erreur lors de la création de la société');
				end
			end);

		end

	end);

	ESX.RegisterServerCallback("JobBuilder:getAllJobs", function(source, cb)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local Jobs = {}

		MySQL.Async.fetchAll("SELECT * FROM jobbuilder", {}, function(res)
			for _, v in pairs(res) do
				table.insert(Jobs, {
					Name = v.name,
					Label = v.label,
					SocietyName = v.society,
					PosBoss = v.posboss,
					PosGarage = v.posveh,
					PosCoffre = v.poscoffre,
					PosVehSpawn = v.posspawncar,
					PosRecolte = v.posrecolte,
					PosTraitement = v.postraitement,
					PosVente = v.posvente,
					PrixVente = v.prixvente,
					nameitemR = v.nameitemrecolte,
					labelitemR = v.labelitemrecolte,
					nameitemT = v.nameitemtraitement,
					labelitemT = v.labelitemtraitement,
					vehInGarage = v.vehingarage,
				})
			end
			cb(Jobs)
		end)
	end)

	ESX.RegisterServerCallback("JobBuilder:getAllJobsForF6", function(source, cb)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local playerJob = xPlayer.getJob()
		local Jobs2 = {}

		MySQL.Async.fetchAll('SELECT * FROM jobbuilder WHERE name = @name', {
			['@name'] = playerJob.name,
		},function(result)
			for _, v in pairs(result) do
				table.insert(Jobs2, {
					Name = v.name,
					Label = v.label,
					SocietyName = v.society,
					PosBoss = v.posboss,
					PosGarage = v.posveh,
					PosCoffre = v.poscoffre,
					PosVehSpawn = v.posspawncar,
					PosRecolte = v.posrecolte,
					PosTraitement = v.postraitement,
					PosVente = v.posvente,
					PrixVente = v.prixvente,
					nameitemR = v.nameitemrecolte,
					labelitemR = v.labelitemrecolte,
					nameitemT = v.nameitemtraitement,
					labelitemT = v.labelitemtraitement,
					vehInGarage = v.vehingarage,
				});
			end
			cb(Jobs2)
			Jobs2 = {}
		end)
	end)

	RegisterNetEvent('JobBuilder:recolte', function(source, item)
		local source = source
		local xPlayer = ESX.GetPlayerFromId(source);

		if (jobs[xPlayer.job.name]) then
			if xPlayer.canCarryItem(item, 1) then
				xPlayer.addInventoryItem(item, 1);
				xPlayer.addXP(10);
			else
				TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire')
			end
		end
	end)

	RegisterNetEvent('JobBuilder:processing', function(source, itemProcessing, itemReward)
		local source = source
		local xPlayer = ESX.GetPlayerFromId(source)
		local xItem = xPlayer.getInventoryItem(itemProcessing)

		if (jobs[xPlayer.job.name]) then

			if xItem and xItem.count > 0 then
				if (xPlayer.canCarryItem(itemReward, 1)) then
					xPlayer.removeInventoryItem(itemProcessing, 1)
					xPlayer.addInventoryItem(itemReward, 1)
					xPlayer.addXP(10);
				else
					TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de place dans votre inventaire');
				end
			else
				TriggerClientEvent("esx:showNotification", source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de '..itemProcessing..' pour faire cela.')
			end

		end
	end)

	RegisterNetEvent('JobBuilder:sell', function(source, item, reward, societyName, societyLabel)

		local source = source
		local xPlayer = ESX.GetPlayerFromId(source);
		local xItem = xPlayer.getInventoryItem(item);

		local society = ESX.DoesSocietyExist(societyName);

		if (society) then

			if (jobs[xPlayer.job.name]) then

				if (xItem) then

					if (xItem.count > 0) then
						xPlayer.removeInventoryItem(item, 1);
						ESX.AddSocietyMoney(societyName, reward);
						xPlayer.addXP(10);
						TriggerClientEvent("esx:showNotification", source, "+"..reward.."~g~$~w~ pour votre entreprise "..societyLabel.." ");
					else
						TriggerClientEvent("esx:showNotification", source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez de '..item..' pour faire cela.');
					end

				else

					xPlayer.showNotification(("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Une erreur est survenue, Code Erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'job_builder_sell_error_%s'~s~. Veuillez contacter un administrateur."):format(societyName));

				end

			end

		else

			xPlayer.showNotification(("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Une erreur est survenue, Code Erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'job_builder_sell_error_society_not_found_%s'~s~. Veuillez contacter un administrateur."):format(societyName));

		end

	end);

	--- MenuBoss

	RegisterServerEvent('JobBuilder:withdrawMoney')
	AddEventHandler('JobBuilder:withdrawMoney', function(societyName, amount)
		local _src = source
		local xPlayer = ESX.GetPlayerFromId(_src)

		local society = ESX.DoesSocietyExist(societyName);

		if (society) then
			if amount > 0 and ESX.GetSocietyMoney(societyName) >= amount then
				ESX.RemoveSocietyMoney(societyName, amount);
				xPlayer.addAccountMoney('cash', amount)
				TriggerClientEvent('esx:showNotification', _src, "Vous avez retiré ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~$"..ESX.Math.GroupDigits(amount))
				--JobBuilderLogs("[Entreprise Payante] "..GetPlayerName(_src).." a retiré "..amount.." de l'entreprise "..societyName.."")
				SendLogs("Entreprise", "Valestia | JobBuilder", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a retiré "..amount.."$ dans le coffre de l'entreprise "..society.."", "https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
			else
				TriggerClientEvent('esx:showNotification', _src, "Montant invalide")
			end
		end
	end)

	RegisterServerEvent('JobBuilder:depositMoney')
	AddEventHandler('JobBuilder:depositMoney', function(societyName, amount)
		local _src = source
		local xPlayer = ESX.GetPlayerFromId(source)

			if amount > 0 then
				if xPlayer.getAccount('cash').money >= amount then

					local society = ESX.DoesSocietyExist(societyName);

					if (society) then
						ESX.AddSocietyMoney(societyName, amount);
						xPlayer.removeAccountMoney('cash', amount)
						TriggerClientEvent('esx:showNotification', _src, "Vous avez déposé ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~$"..ESX.Math.GroupDigits(amount))
						--JobBuilderLogs("[Entreprise Payante] "..GetPlayerName(_src).." a déposé "..amount.." dans l'entreprise "..societyName.."")
						SendLogs("Entreprise", "Valestia | JobBuilder", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a déposé "..amount.."$ dans le coffre de l'entreprise "..society.."", "https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
					end

				else
					TriggerClientEvent("esx:showNotification", xPlayer.source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas assez d'argent.")
				end
		else
			TriggerClientEvent('esx:showNotification', _src, "Montant invalide")
		end
	end)


	ESX.RegisterServerCallback('JobBuilder:getSocietyMoney', function(source, cb, societyName)
		if societyName then
			local society = ESX.DoesSocietyExist(societyName);

			if (society) then

				cb(ESX.GetSocietyMoney(societyName))

			end

		else
			cb(0)
		end
	end)

	ESX.RegisterServerCallback('JobBuilder:GetJobsEmploye', function(source, cb, society)
		local xPlayer = ESX.GetPlayerFromId(source)
		local EmployesduJob = {}

		MySQL.Async.fetchAll('SELECT * FROM users WHERE job = @job', {
			['@job'] = society
		},
			function(result)
			for _,v in pairs(result) do
				if v.job_grade ~= 3 then
				table.insert(EmployesduJob, {
					Name = v.firstname.." "..v.lastname,
					InfoMec = v.identifier,
					Job = v.job,
					Grade = v.job_grade,
				})
				end
			end
			cb(EmployesduJob)
		end)
	end)


	RegisterServerEvent('JobBuilder:Bossvirer')
	AddEventHandler('JobBuilder:Bossvirer', function(target)
		local _src = source
		local sourceXPlayer = ESX.GetPlayerFromId(_src)
		local sourceJob = sourceXPlayer.getJob()

		if sourceJob.grade_name == 'boss' then
			local targetXPlayer = ESX.GetPlayerFromIdentifier(target)

			if targetXPlayer == nil then
				return TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Le joueur n'est pas en ligne.")
			end

			local targetJob = targetXPlayer.getJob()

			if sourceJob.name == targetJob.name then
				targetXPlayer.setJob('unemployed', 0)
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~viré %s.'):format(targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', targetXPlayer.source, ('Vous avez été ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~viré par %s.'):format(sourceXPlayer.name))
				JobBuilderLogs("[Entreprise Payante] "..sourceXPlayer.name.." a viré "..targetXPlayer.name.." de l'entreprise "..sourceJob.name.."")
			else
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre entreprise.')
			end
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~l\'autorisation.')
		end
	end)


	RegisterServerEvent('JobBuilder:Bosspromouvoir')
	AddEventHandler('JobBuilder:Bosspromouvoir', function(target)
		local _src = source
		local sourceXPlayer = ESX.GetPlayerFromId(_src)
		local sourceJob = sourceXPlayer.getJob()

		if sourceJob.grade_name == 'boss' then
			local targetXPlayer = ESX.GetPlayerFromIdentifier(target)

			if targetXPlayer == nil then
				return TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Le joueur n'est pas en ligne.")
			end

			local targetJob = targetXPlayer.getJob()

			if sourceJob.name == targetJob.name then
				local newGrade = tonumber(targetJob.grade) + 1


				if newGrade ~= sourceJob.grade then
					targetXPlayer.setJob(targetJob.name, newGrade)

					TriggerClientEvent('esx:showNotification', _src, ('Vous avez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~promu %s.'):format(targetXPlayer.name))
					TriggerClientEvent('esx:showNotification', target.source, ('Vous avez été ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~promu par %s.'):format(sourceXPlayer.name))
					JobBuilderLogs("[Entreprise Payante] "..sourceXPlayer.name.." a promu "..targetXPlayer.name.." de l'entreprise "..sourceJob.name.."")
				else
					TriggerClientEvent('esx:showNotification', _src, 'Vous devez demander une autorisation ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Gouvernementale.')
				end
			else
				TriggerClientEvent('esx:showNotification', _src, 'Le joueur n\'es pas dans votre entreprise.')
			end
		else
			TriggerClientEvent('esx:showNotification', _src, 'Vous n\'avez pas ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~l\'autorisation.')
		end
	end)

	RegisterServerEvent('JobBuilder:Bossdestituer')
	AddEventHandler('JobBuilder:Bossdestituer', function(target)
		local _src = source
		local sourceXPlayer = ESX.GetPlayerFromId(source)
		local sourceJob = sourceXPlayer.getJob()

		if sourceJob.grade_name == 'boss' then
			local targetXPlayer = ESX.GetPlayerFromIdentifier(target)

			if targetXPlayer == nil then
				return TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Le joueur n'est pas en ligne.")
			end

			local targetJob = targetXPlayer.getJob()

			if sourceJob.name == targetJob.name then
				local newGrade = tonumber(targetJob.grade) - 1

				if newGrade >= 0 then
					targetXPlayer.setJob(targetJob.name, newGrade)

					TriggerClientEvent('esx:showNotification', _src, ('Vous avez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~rétrogradé %s.'):format(targetXPlayer.name))
					TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~rétrogradé par %s.'):format(sourceXPlayer.name))
					JobBuilderLogs("[Entreprise Payante] "..sourceXPlayer.name.." a rétrogradé "..targetXPlayer.name.." de l'entreprise "..sourceJob.name.."")
				else
					TriggerClientEvent('esx:showNotification', _src, 'Vous ne pouvez pas ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~rétrograder d\'avantage.')
				end
			else
				TriggerClientEvent('esx:showNotification', _src, 'Le joueur n\'es pas dans votre entreprise.')
			end
		else
			TriggerClientEvent('esx:showNotification', _src, 'Vous n\'avez pas ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~l\'autorisation.')
		end
	end)

	ESX.RegisterServerCallback('JobBuilder:getStockItems', function(source, cb, society)
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..society, function(inventory)
			cb(inventory.items)
		end)
	end)

	RegisterNetEvent('JobBuilder:getStockItem')
	AddEventHandler('JobBuilder:getStockItem', function(itemName, count, society)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)

		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..society, function(inventory)
			local inventoryItem = inventory.getItem(itemName)

			if count > 0 and inventoryItem.count >= count then

				if (xPlayer.canCarryItem(itemName, count)) then
					inventory.removeItem(itemName, count);
					xPlayer.addInventoryItem(itemName, count);
					TriggerClientEvent('esx:showAdvancedNotification', _source, 'Coffre', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Informations~s~', 'Vous avez retiré ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..inventoryItem.label.." x"..count, 'CHAR_KIRINSPECTEUR', 8)
					--JobBuilderLogs("[Entreprise Payante] "..GetPlayerName(_source).." a retiré x"..count.." "..inventoryItem.label.." dans le coffre de l'entreprise "..society.."")
					SendLogs("Entreprise", "Valestia | JobBuilder", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a retiré x"..count.." "..inventoryItem.label.." dans le coffre de l'entreprise "..society.."", "https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
				else
					TriggerClientEvent('esx:showAdvancedNotification', _source, 'Coffre', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Informations~s~', "Vous n'avez pas assez de place", 'CHAR_KIRINSPECTEUR', 9)
				end
			else
				TriggerClientEvent('esx:showAdvancedNotification', _source, 'Coffre', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Informations~s~', "Quantité ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~invalide", 'CHAR_KIRINSPECTEUR', 9)
			end
		end)
	end)

	ESX.RegisterServerCallback('JobBuilder:getPlayerInventory', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local items   = xPlayer.inventory

		cb({items = items})
	end)

	RegisterNetEvent('JobBuilder:putStockItems')
	AddEventHandler('JobBuilder:putStockItems', function(itemName, count, society)
		local _src = source
		local xPlayer = ESX.GetPlayerFromId(source)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..society, function(inventory)
			local inventoryItem = inventory.getItem(itemName)

			-- does the player have enough of the item?
			if sourceItem.count >= count and count > 0 then
				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				TriggerClientEvent('esx:showAdvancedNotification', _src, 'Coffre', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Informations~s~', 'Vous avez déposé ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..inventoryItem.label.." x"..count, 'CHAR_KIRINSPECTEUR', 8)
				--JobBuilderLogs("[Entreprise Payante] "..GetPlayerName(_src).." a déposé x" ..count.. " "..inventoryItem.label.." dans le coffre de l'entreprise "..society.."")
				SendLogs("Entreprise", "Valestia | JobBuilder", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a déposé x"..count.." "..inventoryItem.label.." dans le coffre de l'entreprise "..society.."", "https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
			else
				TriggerClientEvent('esx:showAdvancedNotification', _src, 'Coffre', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Informations~s~', "Quantité ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~invalide", 'CHAR_KIRINSPECTEUR', 9)
			end
		end)
	end)


	RegisterNetEvent('JobBuilder:editJob', function(item, valeur, where)
		local source = source
		local sourceXPlayer = ESX.GetPlayerFromId(source)

		if (xPlayer.getGroup() == "founder") then
			if item == "Posgarage" then
				MySQL.Async.execute('UPDATE `jobbuilder` SET `posveh` = @posveh  WHERE name = @name', {
					['@name'] = where,
					['@posveh'] = json.encode(valeur)
				}, function(rowsChange)
					TriggerClientEvent('esx:showNotification', source, 'Position du garage modifier')
				end)
			end

			if item == "Posspawn" then
				MySQL.Async.execute('UPDATE `jobbuilder` SET `posspawncar` = @posspawncar  WHERE name = @name', {
					['@name'] = where,
					['@posspawncar'] = json.encode(valeur)
				}, function(rowsChange)
					TriggerClientEvent('esx:showNotification', source, 'Position spawn véhicule modifier')
				end)
			end

			if item == "PosBoss" then
				MySQL.Async.execute('UPDATE `jobbuilder` SET `posboss` = @posboss  WHERE name = @name', {
					['@name'] = where,
					['@posboss'] = json.encode(valeur)
				}, function(rowsChange)
					TriggerClientEvent('esx:showNotification', source, 'Position du menu boss modifier')
				end)
			end

			if item == "PosCoffre" then
				MySQL.Async.execute('UPDATE `jobbuilder` SET `poscoffre` = @poscoffre  WHERE name = @name', {
					['@name'] = where,
					['@poscoffre'] = json.encode(valeur)
				}, function(rowsChange)
					TriggerClientEvent('esx:showNotification', source, 'Position du coffre modifier')
				end)
			end

			if item == "PosRecolte" then
				MySQL.Async.execute('UPDATE `jobbuilder` SET `posrecolte` = @posrecolte  WHERE name = @name', {
					['@name'] = where,
					['@posrecolte'] = json.encode(valeur)
				}, function(rowsChange)
					TriggerClientEvent('esx:showNotification', source, 'Position de la récolte modifier')
				end)
			end

			if item == "PosTraitement" then
				MySQL.Async.execute('UPDATE `jobbuilder` SET `postraitement` = @postraitement  WHERE name = @name', {
					['@name'] = where,
					['@postraitement'] = json.encode(valeur)
				}, function(rowsChange)
					TriggerClientEvent('esx:showNotification', source, 'Position du traitement modifier')
				end)
			end

			if item == "PosVente" then
				MySQL.Async.execute('UPDATE `jobbuilder` SET `posvente` = @posvente  WHERE name = @name', {
					['@name'] = where,
					['@posvente'] = json.encode(valeur)
				}, function(rowsChange)
					TriggerClientEvent('esx:showNotification', source, 'Position de la vente modifier')
				end)
			end

			if item == "PrixVente" then
				MySQL.Async.execute('UPDATE `jobbuilder` SET `prixvente` = @prixvente  WHERE name = @name', {
					['@name'] = where,
					['@prixvente'] = valeur
				}, function(rowsChange)
					TriggerClientEvent('esx:showNotification', source, 'Position de la vente modifier')
				end)
			end
		end
	end)
end)

function JobBuilderLogs(message)
    local DiscordWebHook = "https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA"
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 2061822,
            ["footer"]=  {
                ["text"]= "Coffre Entreprises payantes",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Entreprise", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

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