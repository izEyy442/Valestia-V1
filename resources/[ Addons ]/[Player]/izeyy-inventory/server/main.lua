

RegisterServerCallback("izeyko:getPlayerInventory", function(source, cb)
	local xPlayer = GetPlayerFromId(source)
	if xPlayer ~= nil then
		local identifier = GetPlayerLicense(xPlayer)
		-- local bag = xPlayer.getInventoryItem('sac').count
		local clothes = {}
		if Config.ActivePhoneUnique then
			getNumberInBDD(identifier, function(phoneData)
				dataPhone = phoneData
			end)
		end
		if Config.ActiveIdCard then
			getCardInBDD(identifier, function(cardData)
				idcardData = cardData
			end)
		end

		MySQL.Async.fetchAll('SELECT * FROM izey_clothes WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result) 

				if result[1] then
					for i = 1, #result, 1 do  
						table.insert(clothes, {      
							type      = result[i].type,  
							clothe      = result[i].data,
							id      = result[i].id,
							label      = result[i].name,
						})
					end
				end

				-- if bag >= 1 then 
				-- 	weightInv = 60
				-- else
				-- 	weightInv = GetPlayerMaxWeight(xPlayer)
				-- end


				cb({
					inventory = GetPlayerInventory(xPlayer), 
					accounts = GetPlayerMoney(xPlayer), 
					weapons = GetPlayerWeapon(xPlayer), 
					weight = GetPlayerWeight(xPlayer), 
					maxWeight = GetPlayerMaxWeight(xPlayer),
					clothes = clothes,
					idcard = idcardData,
					phone = dataPhone,
				})
		end)  
	-- 	if targetXPlayer ~= nil then
	-- 		-- cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.getLoadout(), weight = targetXPlayer.getWeight(), maxWeight = targetXPlayer.maxWeight, cards = result, idcard = result2})

	-- 		cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.getLoadout(), weight = targetXPlayer.getWeight(), maxWeight = targetXPlayer.maxWeight})
	else
		cb(nil)
	end
	-- end
end)






RegisterNetEvent('izey:removeItem')
AddEventHandler('izey:removeItem', function(info, name, count)
	local source = source
	local xPlayer = GetPlayerFromId(source)
	if info == 'item_standard' then
		local x_Item = GetItem(xPlayer, name)
		if count > 0 and GetItemAmount(x_Item) >= count then		
			RemoveItem(xPlayer, name, count)
		end
	elseif info == 'item_weapon' then
		if getWeapon(xPlayer, name) then
			removeWeapon(xPlayer, name)
		end
	elseif info == 'item_account' then
		if count > 0 and getAccount(xPlayer, name) >= count then
			removeMoney(xPlayer, name, count)
		end
	elseif info == 'item_vetement' then
		MySQL.Async.execute('DELETE FROM izey_clothes WHERE id = @id', { 
			['@id'] = name 
		}) 
	elseif info == 'item_phone' then
		MySQL.Sync.execute('DELETE FROM '..phoneTable..' WHERE '..numberTable..' = @'..numberTable..'', {
			['@'..numberTable] = name,   
		})
	end
	sendToDiscordWithSpecialURL(
		"🚮 Delete Item",
		"\n\n``🔢``ID : ``["..source.."] | "..xPlayer.getName().."``\n``💿``Licence: ``"..GetPlayerLicense(xPlayer).."``\n``💬``Action: ``delete "..name.." x"..count.." ``", 
		webhooks['removeItem'].color, 
		webhooks['removeItem'].webhook
	)
end)


RegisterNetEvent('izey:giveItem')
AddEventHandler('izey:giveItem', function(target, name, count, type, label)
	local source = source
	local xPlayer = GetPlayerFromId(source)
	local xTarget = GetPlayerFromId(target)
	if type == 'item_standard' then
		local x_Item = GetItem(xPlayer, name)
		if count > 0 and GetItemAmount(x_Item) >= count then
			if getWeight(xTarget, name, count) then
				RemoveItem(xPlayer, name, count)
				AddItem(xTarget, name, count)
				showNotification(xPlayer, (Locales[Config.Language]['give_from_item']):format(count, GetItemLabel(name)), 'success')
				showNotification(xTarget, (Locales[Config.Language]['give_target_item']):format(count, GetItemLabel(name)), 'success')
			else
				showNotification(xPlayer, Locales[Config.Language]['give_error_weight'], 'error')
			end
		end

	elseif type == 'item_account' then
		if count > 0 and getAccount(xPlayer, name) >= count then

			removeMoney(xPlayer, name, count)
			showNotification(xPlayer, (Locales[Config.Language]['give_from_account']):format(count, Config.AccountName[name]), 'success')
			addMoney(xTarget, name, count)
			showNotification(xTarget, (Locales[Config.Language]['give_target_account']):format(count, Config.AccountName[name]), 'success')
		else
			showNotification(xPlayer, Locales[Config.Language]['give_error_account'], 'error')

		end
	elseif type == 'item_vetement' then
		MySQL.Sync.execute('UPDATE izey_clothes SET identifier = @identifier WHERE id = @id', {
			['@id'] = name,   
			['@identifier'] = GetPlayerLicense(xTarget)
		})
		showNotification(xPlayer, Locales[Config.Language]['give_from_clothes'], 'success')
		showNotification(xTarget, Locales[Config.Language]['give_target_clothes'], 'success')
	elseif type == 'item_phone' then
		MySQL.Sync.execute('UPDATE '..phoneTable..' SET '..idPhoneTable..' = @'..idPhoneTable..' WHERE '..numberTable..' = @'..numberTable..'', {
			['@'..numberTable] = name,   
			['@'..idPhoneTable] = GetPlayerLicense(xTarget)
		})
		showNotification(xPlayer, (Locales[Config.Language]['give_from_phone']):format(formatPhoneNumber(name)), 'success')
		showNotification(xTarget, (Locales[Config.Language]['give_target_phone']):format(formatPhoneNumber(name)), 'success')
	elseif type == 'item_weapon' then
		if not getWeapon(xTarget, name) then
			removeWeapon(xPlayer, name)
			showNotification(xPlayer, (Locales[Config.Language]['give_from_weapon']):format(label), 'success')
			addWeapon(xTarget, name, 255)
			showNotification(xTarget, (Locales[Config.Language]['give_target_weapon']):format(label), 'success')
		else
			showNotification(xPlayer, Locales[Config.Language]['give_error_weapon'], 'error')
		end
	end
	sendToDiscordWithSpecialURL(
		"🧩 Give Item",
		"\n\n``🔢``ID : ``["..source.."] "..xPlayer.getName().." ``\n``💿``Licence: ``"..GetPlayerLicense(xPlayer).."``\n``💬``Action: ``a donné "..name.." x"..count.." ``\n``🎮``Receveur ``["..xTarget.source.."] "..xTarget.getName().."``", 
		webhooks['giveItem'].color, 
		webhooks['giveItem'].webhook
	)

end)






RegisterNetEvent('Malette')
AddEventHandler('Malette', function(type)
	local xPlayer = GetPlayerFromId(source)
	local defaultMaxWeight = ESX.GetConfig().MaxWeight
	if type == 1 then
		xPlayer.setMaxWeight(defaultMaxWeight + 2000)
		showNotification(xPlayer, "~r~Informations~s~\nVous avez maintenant une capacité en plus de : "..(math.floor(2000/1000)).."KG")
	elseif type == 2 then
		xPlayer.setMaxWeight(defaultMaxWeight + 3000)
		showNotification(xPlayer, "~r~Informations~s~\nVous avez maintenant une capacité en plus de : "..(math.floor(3000/1000)).."KG")
	elseif type == 3 then
		xPlayer.setMaxWeight(defaultMaxWeight)
	end
end)


