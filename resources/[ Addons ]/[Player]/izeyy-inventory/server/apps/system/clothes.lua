RegisterNetEvent('izey:renameItem')
AddEventHandler('izey:renameItem', function(id, name)   
	local source = source
	MySQL.Sync.execute('UPDATE izey_clothes SET name = @name WHERE id = @id', {
		['@id'] = id,   
		['@name'] = name        
	})
end)


RegisterNetEvent('lgd_inv:buyClothData')
AddEventHandler('lgd_inv:buyClothData', function(type, name, index, clothes, index2, variation)
  	local xPlayer = GetPlayerFromId(source)
	local identifier = GetPlayerLicense(xPlayer)

  	dataClothe = {[index]=tonumber(clothes),[index2]=tonumber(variation)} 

	MySQL.Async.execute('INSERT INTO izey_clothes (identifier, type, name, data) VALUES (@identifier, @type, @name, @data)', { 
		['@identifier']   = identifier,
    	['@type']   = type,
    	['@name']   = name,
    	['@data'] = json.encode(dataClothe)
	})

	sendToDiscordWithSpecialURL(
		"🚮 Buy cloth",
		"\n\n``🔢``ID : ``["..source.."] | "..xPlayer.getName().."``\n``💿``Licence: ``"..GetPlayerLicense(xPlayer).."``\n``💬``Action: ``buy cloth "..name.." ``", 
		webhooks['buyCloth'].color, 
		webhooks['buyCloth'].webhook
	)
end)


RegisterNetEvent('lgd_inv:addCloth')
AddEventHandler('lgd_inv:addCloth', function(type, name, clothe)
	print(type, name, clothe)
	local xPlayer = GetPlayerFromId(source)
	local identifier = GetPlayerLicense(xPlayer)
	MySQL.Async.execute('INSERT INTO izey_clothes (identifier, type, name, data) VALUES (@identifier, @type, @name, @data)',{
		['@identifier'] = identifier,
    	['@type'] = type,
    	['@name'] = name,
    	['@data'] = json.encode(clothe)
		}, function(rowsChanged) 
	end)

	sendToDiscordWithSpecialURL(
		"🚮 Buy cloth",
		"\n\n``🔢``ID : ``["..source.."] | "..xPlayer.getName().."``\n``💿``Licence: ``"..GetPlayerLicense(xPlayer).."``\n``💬``Action: ``buy cloth "..name.." ``", 
		webhooks['buyCloth'].color, 
		webhooks['buyCloth'].webhook
	)
end)

RegisterServerCallback("lgd_clothes:getmoney",function(source, cb, price)
    local xPlayer = GetPlayerFromId(source)

    if getAccount(xPlayer, Config.ClothTypeMoney) >= price then
        removeMoney(xPlayer, Config.ClothTypeMoney, price)
        cb(true)
    else
        cb(false)
    end
end)