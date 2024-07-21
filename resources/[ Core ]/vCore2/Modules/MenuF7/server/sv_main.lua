-- ESX = nil

-- TriggerEvent(Config.ESX, function(obj) ESX = obj end)

ESX.RegisterServerCallback('getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, "~r~~Quelqu'un vous fouille")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)

RegisterNetEvent('confiscatePlayerItemF7', function(target, itemType, itemName, amount)
    Wait(1735)
    local source = source
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if (not sourceXPlayer or not targetXPlayer) then return end

    local ped = GetPlayerPed(sourceXPlayer.source);
    local targetPed = GetPlayerPed(targetXPlayer.source);

    if sourceXPlayer.job2.name == 'unemployed2' or sourceXPlayer.job2.name == 'unemployed' then
        xPlayer.ban(0, '(confiscatePlayerItemF7)');
    else
        if (#(GetEntityCoords(targetPed) - GetEntityCoords(ped)) < 4.0) then
            if itemType == 'item_standard' then
                local targetItem = targetXPlayer.getInventoryItem(itemName)
                local sourceItem = sourceXPlayer.getInventoryItem(itemName)

                if (targetItem and targetItem.count >= amount) then
                    if (sourceXPlayer.canCarryItem(itemName, amount)) then
                        targetXPlayer.removeInventoryItem(itemName, amount);
                        sourceXPlayer.addInventoryItem(itemName, amount);
                        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~p~"..amount..' '..sourceItem.label.."~s~.")
                        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~p~"..amount..' '..sourceItem.label.."~s~.")
                        
                        

                        local link = "https://discord.com/api/webhooks/1226977859353182230/zONvb7Lh-6tigbOxDJmQKoQjSzGNxHgCjWgz8-3BAEWuQB5pyB_XCfOq-brDpPvaqy43"
                        local steamhex = xPlayer.identifier
                        local LicenseNmDeux = target.identifier
                        local _src = source
                        local local_date = os.date('%H:%M:%S', os.time())
                        local content = {
                            {
                                ["title"] = "**__Information :__**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Personne ayant dérober :", value = source.." [".._src.."] ["..steamhex.."]" },
                                    { name = "- Personne qui c'est fait dérober :", value = target.."["..LicenseNmDeux.."]" },
                                    { name = "- Item type :", value = "Item" },
                                    { name = "- Item pris :", value = sourceItem.label },
                                    { name = "- Quantité :", value = amount },
                    
                                },
                                ["type"]  = "rich",
                                ["color"] = 16711680,
                                ["footer"]=  {
                                    ["text"] = "Logs",
                                },
                            }
                        }
                        PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "LOGS Dérobation", embeds = content}), { ['Content-Type'] = 'application/json' })
                        
                    else
                        TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez de place dans votre inventaire.");
                    end
                end
            end
                
            if itemType == 'item_account' then
                local targetAccount = targetXPlayer.getAccount(itemName)
                if (targetAccount and targetAccount.money >= amount) then
                    targetXPlayer.removeAccountMoney(itemName, amount);
                    sourceXPlayer.addAccountMoney(itemName, amount);
                    
                    TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~p~"..amount.."$ ~s~argent non déclaré~s~.");
                    TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~p~"..amount.."$ ~s~argent non déclaré~s~.");

                    local link = "https://discord.com/api/webhooks/1226977859353182230/zONvb7Lh-6tigbOxDJmQKoQjSzGNxHgCjWgz8-3BAEWuQB5pyB_XCfOq-brDpPvaqy43"
                    local local_date = os.date('%H:%M:%S', os.time())
                    local content = {
                        {
                            ["title"] = "**__Information :__**",
                            ["fields"] = {
                                { name = "**- Date & Heure :**", value = local_date },
                                { name = "- Personne ayant dérober :", value = sourceXPlayer.name },
                                { name = "- Personne qui c'est fait dérober :", value = targetXPlayer.name },
                                { name = "- Item type :", value = "Argent Sale" },
                                --{ name = "- Item pris :", value = sourceItem.label },
                                { name = "- Quantité :", value = amount },
                
                            },
                            ["type"]  = "rich",
                            ["color"] = 16711680,
                            ["footer"]=  {
                                ["text"] = "Logs",
                            },
                        }
                    }
                    PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "LOGS Dérobation", embeds = content}), { ['Content-Type'] = 'application/json' })

                end
            end
        
            if itemType == 'item_weapon' then
                if (targetXPlayer.hasWeapon(string.upper(itemName))) then
                    if (not sourceXPlayer.hasWeapon(string.upper(itemName))) then
                        targetXPlayer.removeWeapon(itemName, 0);
                        sourceXPlayer.addWeapon(itemName, amount);
                        local link = "https://discord.com/api/webhooks/1226977859353182230/zONvb7Lh-6tigbOxDJmQKoQjSzGNxHgCjWgz8-3BAEWuQB5pyB_XCfOq-brDpPvaqy43"
                        local local_date = os.date('%H:%M:%S', os.time())
                        local content = {
                            {
                                ["title"] = "**__Information :__**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Personne ayant dérober :", value = sourceXPlayer.name },
                                    { name = "- Personne qui c'est fait dérober :", value = targetXPlayer.name },
                                    { name = "- Item type :", value = "Weapon" },
                                    { name = "- Item pris :", value = itemName },
                                    { name = "- Quantité :", value = amount },
                    
                                },
                                ["type"]  = "rich",
                                ["color"] = 16711680,
                                ["footer"]=  {
                                    ["text"] = "Logs",
                                },
                            }
                        }
                        PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "LOGS Dérobation", embeds = content}), { ['Content-Type'] = 'application/json' })
                    else
                        TriggerClientEvent("esx:showNotification", source, "Vous avez déjà cette arme.");
                    end
                end
            end
        end
    end
end);

ESX.RegisterServerCallback('getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then
			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				--if Config.EnableESXIdentity then
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
			--	else
					retrivedInfo.owner = result2[1].name
				--end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)