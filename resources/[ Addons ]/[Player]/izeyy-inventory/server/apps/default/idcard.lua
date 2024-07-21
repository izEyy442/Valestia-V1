RegisterNetEvent('izeyko:lookCard')
AddEventHandler('izeyko:lookCard', function(target, player, data)
    
    local xTarget = GetPlayerFromId(target)

    TriggerClientEvent('izey:lookCard', xTarget.source, player, data)
end)



function getCardInBDD(identifier, callback)
    local cardData = {}
	local infoIdCard = GetInfoIdCard(identifier)

	MySQL.Async.fetchAll('SELECT * FROM '..licenseTable..' WHERE '..idLicenseTable..' = @'..idLicenseTable..'', {
		['@'..idLicenseTable] = identifier
	}, function(card) 
        if card[1] then
			for k,v in pairs(card) do
				table.insert(cardData, {
					type = v[typeLicenseTable],
					information = infoIdCard[1]
				})
			end
			
        end
        -- Call the callback function and pass the phoneData as an argument
        callback(cardData)
    end)
end


-- RegisterNetEvent('izey:addIdCard')
-- AddEventHandler('izey:addIdCard', function(type)
-- 	local source = source
-- 	local xPlayer = GetPlayerFromId(source)
-- 	local count = 0
-- 	DataPlayer = {}
-- 	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM '..userColumns..' WHERE identifier = @identifier', {
-- 		['@identifier'] = GetPlayerLicense(xPlayer)
-- 	}, function(user) 
-- 		DataPlayer = {
-- 			firstname = user[1].firstname,
-- 			lastname = user[1].lastname,
-- 			date = user[1].dateofbirth,
-- 			sex = user[1].sex,
-- 			taile = user[1].height,
-- 		}
-- 		MySQL.Async.execute('INSERT INTO lgd_idcard (identifier, type, information) VALUES (@identifier, @type, @information)',
-- 		{
-- 			['@identifier'] = GetPlayerLicense(xPlayer),
-- 			['@type'] = type,
-- 			['@information'] = json.encode(DataPlayer),
-- 		}, function(rowsChanged) 

-- 		end)
-- 	end)
-- end)