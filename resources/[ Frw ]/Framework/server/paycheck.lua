ESX.StartPayCheck = function()
	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i = 1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer then
				local salary = xPlayer.job.grade_salary

				if salary > 0 then
					if xPlayer.job.grade_name == 'unemployed' then
						xPlayer.addAccountMoney('bank', salary)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary), 'CHAR_BANK_FLEECA', 9)
					elseif Config.EnableSocietyPayouts then
						local society = ESX.DoesSocietyExist(xPlayer.job.name);
						if society ~= nil then
							if ESX.GetSocietyMoney(xPlayer.job.name) >= salary then
								xPlayer.addAccountMoney('bank', salary)
								ESX.RemoveSocietyMoney(xPlayer.job.name, tonumber(salary));

								TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, xPlayer.job.name, _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_FLEECA', 9)
							else
								TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, xPlayer.job.name, _U('bank'), _U('company_nomoney'), 'CHAR_BANK_FLEECA', 1)
							end
						else
							TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, xPlayer.job.name, '', "Une erreur est survenue, Code erreur ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_not_exist_error'~s~. Veuillez contacter un ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~administrateur~s~.", 'CHAR_BANK_FLEECA', 1)
						end
					end
				end
			end
		end
		SetTimeout(Config.PaycheckInterval, payCheck)
	end
	SetTimeout(Config.PaycheckInterval, payCheck)
end
