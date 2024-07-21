--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil
TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
pSociety = {}
pSociety.Trad = pSocietyTranslation[pSocietyCFG.Language]

local RegisteredSocieties = {}

pSociety.GetSociety = function(name)
	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			return RegisteredSocieties[i]
		end
	end
end

pSociety.getMaximumGrade = function(jobname)
	local queryDone, queryResult = false, nil

	MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @jobname ORDER BY `grade` DESC ;', {
		['@jobname'] = jobname
	}, function(result)
		queryDone, queryResult = true, result
	end)

	while not queryDone do
		Citizen.Wait(10)
	end

	if queryResult[1] then
		return queryResult[1].grade
	end

	return nil
end

AddEventHandler('pSociety:getSocieties', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('pSociety:getSociety', function(name, cb)
	cb(pSociety.GetSociety(name))
end)

--RegisterServerEvent('pSociety:registerSociety')
--AddEventHandler('pSociety:registerSociety', function(name, label, account, datastore, inventory, data)
--	local found = false
--
--	local society = {
--		name      = name,
--		label     = label,
--		account   = account,
--		datastore = datastore,
--		inventory = inventory,
--		data      = data
--	}
--
--	for i=1, #RegisteredSocieties, 1 do
--		if RegisteredSocieties[i].name == name then
--			found = true
--			RegisteredSocieties[i] = society
--			break
--		end
--	end
--
--	if not found then
--		table.insert(RegisteredSocieties, society)
--	end
--
--	ESX.Logs.Info(("Society ^4%s^0 has been registered"):format(label));
--end)

ESX.RegisterServerCallback('pSociety:getSocietyMoney', function(source, cb, societyName)
	local society = ESX.DoesSocietyExist(societyName)

	if (society) then

		cb(ESX.GetSocietyMoney(societyName));

	else

		cb(0);

	end
	--local society = pSociety.GetSociety(societyName)
	--
	--if society then
	--	TriggerEvent(pSocietyCFG.AddonAccount, society.account, function(account)
	--		cb(account.money)
	--	end)
	--else
	--	cb(0)
	--end
end)

RegisterServerEvent('pSociety:withdrawMoney')
AddEventHandler('pSociety:withdrawMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = pSociety.GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))
	money = ESX.Math.GroupDigits(amount)..""..pSociety.Trad["money_symbol"]

	if xPlayer.job.name == society.name then
		TriggerEvent(pSocietyCFG.AddonAccount, society.account, function(account)
			if amount > 0 and account.money >= amount then
				SendLogs("Entreprise", "Valestia | Entreprise", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de récupérer "..amount.."$ de l'entreprise **"..society.name.."**", "https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
				account.removeMoney(amount)
				xPlayer.addAccountMoney('cash', amount)

				TriggerClientEvent("RageUIv1:Popup", source, {message= pSociety.Trad["withdrew"].." "..money})
			else
				TriggerClientEvent("RageUIv1:Popup", source, {message= pSociety.Trad["impossible_action"]})
			end
		end)
	else
		print(('pSociety: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('pSociety:depositMoney')
AddEventHandler('pSociety:depositMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = pSociety.GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))
	money = ESX.Math.GroupDigits(amount)..""..pSociety.Trad["money_symbol"]

	if xPlayer.job.name == society.name then
		if amount > 0 and xPlayer.getAccount('cash').money >= amount then
			TriggerEvent(pSocietyCFG.AddonAccount, society.account, function(account)
				SendLogs("Entreprise", "Valestia | Entreprise", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de déposer "..amount.."$ de l'entreprise **"..society.name.."**", "https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
				xPlayer.removeAccountMoney('cash', amount)
				account.addMoney(amount)
			end)

			TriggerClientEvent("RageUIv1:Popup", source, {message= pSociety.Trad["deposed"].." "..money})
			--TriggerEvent("pSociety:SendLogs", source, pSociety.Trad["log_action"], pSociety.Trad["log_deposed"].." "..money.." \n"..pSociety.Trad["log_company"].." "..society.label)
		else
			TriggerClientEvent("RageUIv1:Popup", source, {message= pSociety.Trad["impossible_action"]})
		end
	else
		print(('pSociety: %s attempted to call depositMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('pSociety:washMoney')
AddEventHandler('pSociety:washMoney', function(society, amount, tax)
	local xPlayer = ESX.GetPlayerFromId(source)
	local societyy = pSociety.GetSociety(society)
	local account = xPlayer.getAccount(pSocietyCFG.BlackMoney)
	tax = ESX.Math.Round(tonumber(amount*tax))
	amount = ESX.Math.Round(tonumber(amount))
	finalamount = ESX.Math.Round(tonumber(amount-tax))
	money = ESX.Math.GroupDigits(amount)..""..pSociety.Trad["money_symbol"]

	if xPlayer.job.name == society then
		if amount and xPlayer.getAccount(pSocietyCFG.BlackMoney).money >= amount then
			TriggerEvent(pSocietyCFG.AddonAccount, societyy.account, function(sctyacc)
				xPlayer.removeAccountMoney(pSocietyCFG.BlackMoney, amount)
				sctyacc.addMoney(finalamount)
				TriggerClientEvent("RageUIv1:Popup", source, {message= pSociety.Trad["washed"].." "..money})
				--TriggerEvent("pSociety:SendLogs", source, pSociety.Trad["log_action"], pSociety.Trad["log_washed"].." "..money.." \n"..pSociety.Trad["log_company"].." "..societyy.label)
			end)
		else
			TriggerClientEvent("RageUIv1:Popup", source, {message= pSociety.Trad["impossible_action"]})
		end
	else
		print(('pSociety: %s attempted to call washMoney!'):format(xPlayer.identifier))
	end
end)

local Jobs = {}

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

	for i=1, #result, 1 do
		Jobs[result[i].name]        = result[i]
		Jobs[result[i].name].grades = {}
	end

	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

	for i=1, #result2, 1 do
		Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
	end
end)

ESX.RegisterServerCallback('pSociety:getEmployees', function(source, cb, society)

	MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, job, job_grade FROM users WHERE job = @job ORDER BY job_grade DESC', {
		['@job'] = society
	}, function (results)
		local employees = {}
		local lbl = nil

		for i=1, #results, 1 do
			if results[i].firstname == nil or results[i].lastname == nil then lbl = results[i].name else lbl = results[i].firstname .. ' ' .. results[i].lastname end
			table.insert(employees, {
				name       = lbl,
				identifier = results[i].identifier,
				job = {
					name        = results[i].job,
					label       = Jobs[results[i].job].label,
					grade       = results[i].job_grade,
					grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
					grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label
				}
			})
		end

		cb(employees)
	end)
end)

ESX.RegisterServerCallback('pSociety:getJob', function(source, cb, society)
	local job    = json.decode(json.encode(Jobs[society]))
	local grades = {}

	for k,v in pairs(job.grades) do
		table.insert(grades, v)
	end

	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	job.grades = grades

	cb(job)
end)

ESX.RegisterServerCallback('pSociety:setJob', function(source, cb, identifier, job, grade)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'boss'

	if isBoss then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)

		if grade ~= tonumber(pSociety.getMaximumGrade(job)) or job == "unemployed" then
			if xTarget then
				xTarget.setJob(job, grade)

				TriggerClientEvent("RageUIv1:Popup", xTarget, {message=pSociety.Trad["profession_evolved"]})
				TriggerClientEvent("RageUIv1:Popup", source, {message=pSociety.Trad["modified_profession"]})

				--TriggerEvent("pSociety:SendLogs", source, pSociety.Trad["log_action"], pSociety.Trad["log_setjob"].." "..identifier.." --> "..job.." "..grade)
				cb()
			else
				MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
					['@job']        = job,
					['@job_grade']  = grade,
					['@identifier'] = identifier
				}, function(rowsChanged)
					TriggerClientEvent("RageUIv1:Popup", source, {message= pSociety.Trad["modified_profession"]})
					--TriggerEvent("pSociety:SendLogs", source, pSociety.Trad["log_action"], pSociety.Trad["log_setjob"].." "..identifier.."  -->  "..job.." "..grade)
					cb()
				end)
			end
		else
			TriggerClientEvent("RageUIv1:Popup", source, {message=pSociety.Trad["cannot_assign_profession"]})
			cb(false)
		end
	else
		print(('pSociety: %s attempted to setJob'):format(xPlayer.identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('pSociety:setJobSalary', function(source, cb, job, grade, salary)
	local isBoss = pSociety.isPlayerBoss(source, job)
	local identifier = ESX.GetPlayerFromId(source).identifier

	if isBoss then
        MySQL.Async.execute('UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND grade = @grade', {
            ['@salary']   = salary,
            ['@job_name'] = job,
            ['@grade']    = grade
        }, function(rowsChanged)
            Jobs[job].grades[tostring(grade)].salary = salary
            local xPlayers = ESX.GetPlayers()

            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

                if xPlayer and xPlayer.job.name == job and xPlayer.job.grade == grade then
                    xPlayer.setJob(job, grade)
                end
            end

            cb()
        end)
	else
		print(('pSociety: %s attempted to setJobSalary'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('pSociety:isBoss', function(source, cb, job)
	cb(pSociety.isPlayerBoss(source, job))
end)

pSociety.isPlayerBoss = function(playerId, job)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer.job.name == job and xPlayer.job.grade_name == 'boss' then
		return true
	else
		print(('pSociety: %s attempted open a society boss menu!'):format(xPlayer.identifier))
		return false
	end
end

RegisterServerEvent("pSociety:RequestSetRecruit")
AddEventHandler("pSociety:RequestSetRecruit", function(target, job)
	local xPlayer = ESX.GetPlayerFromId(source)
	local Player = ESX.GetPlayerFromId(ply)
	local society = pSociety.GetSociety(job)

	if xPlayer.job.grade_name == 'boss' then
		TriggerClientEvent("pSociety:SendRequestRecruit", target, society.label, job)
		TriggerClientEvent("RageUIv1:Popup", source, {message=pSociety.Trad["request_sent"]})
	end
end)

pSociety.GetPlayerDetails = function(src)
	local player_id = src
	local ids = pSociety.ExtractIdentifiers(player_id)
	if pSocietyLOG.Discord then if ids.discord ~= "" then _discordID ="**Discord:** "..ids.discord.." <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "**Discord:** N/A" end else _discordID = "" end
	if pSocietyLOG.Steam then  if ids.steam ~= "" then _steamID = "**SteamID:** ["..ids.steam.."](https://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16)..")" else _steamID = "**SteamID:** N/A" end else _steamID = "" end
	if pSocietyLOG.identifier then if ids.identifier ~= "" then _identifier ="**identifier:** " ..ids.identifier else _identifier = "**identifier :** N/A" end else _identifier = "" end
	if pSocietyLOG.Ip then if ids.ip ~= "" then _ip = "**IP:** [||"..ids.ip:gsub("ip:", "").."||](https://www.ip-tracker.org/locator/ip-lookup.php?ip=" ..ids.ip:gsub("ip:", "")..")" else _ip = "**IP :** N/A" end else _ip = "" end
	return _steamID..' \n'.. _discordID..' \n'.._identifier..' \n'.._ip
end
pSociety.ExtractIdentifiers = function(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        identifier = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "identifier") then
            identifiers.identifier = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end