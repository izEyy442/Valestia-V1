

RegisterServerCallback("izeyko:getPlayerOtherInventory", function(source, cb, target)
	local xPlayer = GetPlayerFromId(target)
	local identifier = GetPlayerLicense(xPlayer)
	-- local bag = xPlayer.getInventoryItem('sac').count
	local clothes = {}
	local idcardData = {}
	-- if Config.ActivePhoneUnique then
	-- 	getNumberInBDD(identifier, function(phoneData)
	-- 		dataPhone = phoneData
	-- 	end)
	-- end
	local infoIdCard = GetInfoIdCard(identifier)
	if xPlayer ~= nil then

		MySQL.Async.fetchAll('SELECT * FROM izey_clothes WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result) 
			MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
				['@owner'] = identifier
			}, function(result2) 
				if result[1] then
					for i = 1, #result, 1 do  
						table.insert(clothes, {      
							type      = result[i].type,  
							clothe      = result[i].clothe,
							id      = result[i].id,
							label      = result[i].nom,
						})
					end
				end
				if result2[1] then
					for k,v in pairs(result2) do
						table.insert(idcardData, {
							type = v.type,
							information = infoIdCard[1]
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
		end)  
	-- 	if targetXPlayer ~= nil then
	-- 		-- cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.getLoadout(), weight = targetXPlayer.getWeight(), maxWeight = targetXPlayer.maxWeight, cards = result, idcard = result2})

	-- 		cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.getLoadout(), weight = targetXPlayer.getWeight(), maxWeight = targetXPlayer.maxWeight})
	else
		cb(nil)
	end
	-- end
end)


RegisterServerEvent("izey:putToPlayer")
AddEventHandler("izey:putToPlayer",function(data, count)
	local _source = data.player
	local target = data.target
	local sourceXPlayer = GetPlayerFromId(_source)
	local targetXPlayer = GetPlayerFromId(target)
	if data.type == "item_standard" then
		local sourceItem = GetItem(sourceXPlayer, data.name)
		local targetItem = GetItem(targetXPlayer, data.name)
		if count > 0 and sourceItem.count >= count then
            if GetWeightPlayer(targetXPlayer, data.name, count) then
			    RemoveItem(sourceXPlayer, data.name, count)
			    AddItem(targetXPlayer, data.name, count)
                showNotification(targetXPlayer, (Locales[Config.Language]['trade_from_item']):format(count, data.label), 'success')
                showNotification(sourceXPlayer, (Locales[Config.Language]['trade_target_item']):format(count, data.label), 'success')

            else
                showNotification(targetXPlayer, Locales[Config.Language]['trade_weight_max'], 'error')
            end
		end
	elseif data.type == "item_account" then
		if count > 0 and getAccount(sourceXPlayer, data.name) >= count then
			removeMoney(sourceXPlayer, data.name, count)
			addMoney(targetXPlayer, data.name, count)

            showNotification(targetXPlayer, (Locales[Config.Language]['trade_from_account']):format(count, Config.AccountName[data.name]), 'success')
            showNotification(sourceXPlayer, (Locales[Config.Language]['trade_target_account']):format(count, Config.AccountName[data.name]), 'success')

		end
	elseif data.type == "item_weapon" then
		if not getWeapon(targetXPlayer, data.name) then
			local pos, playerWeapon = infoWeapon(sourceXPlayer, data.name)
			local components = playerWeapon.components
			removeWeapon(sourceXPlayer, data.name)
			addWeapon(targetXPlayer, data.name, count)
			if components == nil then
				components = {}
			end
			for i = 1, #components do
				addWeaponComponent(targetXPlayer, data.name, components[i])
			end
            showNotification(targetXPlayer, (Locales[Config.Language]['trade_from_weapon']):format(count, data.label), 'success')
            showNotification(sourceXPlayer, (Locales[Config.Language]['trade_target_weapon']):format(count, data.label), 'success')
		end
    elseif data.type == "item_vetement" then
		MySQL.Sync.execute('UPDATE izey_clothes SET identifier = @identifier WHERE id = @id', {
			['@id'] = data.id,   
			['@identifier'] = GetPlayerLicense(targetXPlayer)
		})
        showNotification(targetXPlayer, Locales[Config.Language]['trade_from_clothes'], 'success')
        showNotification(sourceXPlayer, Locales[Config.Language]['trade_target_clothes'], 'success')

	end
end)