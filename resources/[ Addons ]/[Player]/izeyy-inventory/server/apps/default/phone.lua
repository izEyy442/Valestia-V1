
RegisterNetEvent('izey:CreatePhone')
AddEventHandler('izey:CreatePhone', function()   
	local source = source
	local number = math.random(1000000000, 9999999999)
	local xPlayer = GetPlayerFromId(source)
	local identifier = GetPlayerLicense(xPlayer)
	RemoveItem(xPlayer, Config.ItemPhoneName, 1)
	MySQL.Sync.execute('INSERT INTO '..phoneTable..' ('..idPhoneTable..', '..numberTable..') VALUES (@'..idPhoneTable..', @'..numberTable..')', {
		['@'..idPhoneTable] = identifier,   
		['@'..numberTable] = number       
	})
	showNotification(xPlayer, (Locales[Config.Language]['phone_cardSim']):format(formatPhoneNumber(tonumber(number))), 'success')

end)

function formatPhoneNumber(phoneNumber)
    local formattedNumber = string.format("(%s) %s-%s",
        string.sub(phoneNumber, 1, 3),
        string.sub(phoneNumber, 4, 6),
        string.sub(phoneNumber, 7, 10)
    )
    return formattedNumber
end

function getNumberInBDD(identifier, callback)
    local phoneData = {}
    MySQL.Async.fetchAll('SELECT '..numberTable..' FROM '..phoneTable..' WHERE '..idPhoneTable..' = @'..idPhoneTable..'', {
        ['@'..idPhoneTable] = identifier
    }, function(phone) 
        if phone[1] then
			for _, entry in ipairs(phone) do
                local phoneNumber = entry[numberTable]  -- Utilize the value of numberTable as a key
                table.insert(phoneData, {
                    number = phoneNumber,
					numberLabel = formatPhoneNumber(phoneNumber)
                })
            end
			
        end
        -- Call the callback function and pass the phoneData as an argument
        callback(phoneData)
    end)
end



-- -- Fichier : server.lua

-- -- Fichier : server.lua

-- -- Fonction pour exécuter une requête SQL côté serveur
-- function executeSQL(sqlQuery, callback)
--     MySQL.Async.execute(sqlQuery, {}, function(rowsChanged)
--         if callback then
--             callback(rowsChanged)
--         end
--     end)
-- end

-- -- Vérifie si la clé primaire existe dans la table phone_phones
-- function checkPrimaryKeyExists(callback)
--     local sqlQuery = "SHOW KEYS FROM phone_phones WHERE 'id' = 'PRIMARY';"
--     MySQL.Async.fetchAll(sqlQuery, {}, function(result)
--         if result and #result > 0 then
--             -- La clé primaire existe, on peut l'exécuter
--             callback(true)
--         else
--             -- La clé primaire n'existe pas, on ne l'exécute pas pour éviter les erreurs
--             callback(false)
--         end
--     end)
-- end

-- -- Événement déclenché lorsque la resource démarre
-- AddEventHandler('onResourceStart', function(resource)
--     if resource == GetCurrentResourceName() then
--         -- Vérifier si la clé primaire existe avant de l'exécuter
--         checkPrimaryKeyExists(function(primaryKeyExists)
--             if primaryKeyExists then
-- 				print(primaryKeyExists)
--                 local sqlQuery = "ALTER TABLE phone_phones DROP PRIMARY KEY;"
--                 executeSQL(sqlQuery, function(rowsChanged)
--                     print('Requête exécutée avec succès! Lignes modifiées : ' .. rowsChanged)
--                 end)
--             else
--                 print("La clé primaire existe déjà. La requête ALTER TABLE ne sera pas exécutée.")
--             end
--         end)
--     end
-- end)
