--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

RegisterServerEvent('menotterForGouv')
AddEventHandler('menotterForGouv', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'gouv' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('menotterlejoueur', target)
            end
        end
    else
        xPlayer.ban(0, '(menotterForGouv)');
    end
end);

RegisterServerEvent('escorterGouv')
AddEventHandler('escorterGouv', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'gouv' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('actionescorter', target, source)
            end
        end
    else
        xPlayer.ban(0, '(escorterGouv)');
    end
end);

RegisterServerEvent('messageGouv', function(player)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pName = xPlayer.getName()
    if (xPlayer.job.name == "gouv" and player) then
        if (#(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(player))) < 5.0) then
            TriggerClientEvent('esx:showNotification', player, "Une personne vous fouille")
        end
    end
end);

RegisterNetEvent('confiscatePlayerItemGouv', function(target, itemType, itemName, amount)
    local source = source
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if (not sourceXPlayer or not targetXPlayer) then return end

    local ped = GetPlayerPed(sourceXPlayer.source);
    local targetPed = GetPlayerPed(targetXPlayer.source);

    if sourceXPlayer.job.name ~= 'gouv' then
        xPlayer.ban(0, '(confiscatePlayerItemGouv)');
    else
        if (#(GetEntityCoords(targetPed) - GetEntityCoords(ped)) < 4.0) then
            if itemType == 'item_standard' then
                local sourceItem = sourceXPlayer.getInventoryItem(itemName)
                TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouv', function(inventory)
                    if (amount and tonumber(amount) and sourceItem and sourceItem.count and tonumber(sourceItem.count)) then
                        if sourceItem.count >= amount and amount > 0 then 
                            inventory.addItem(itemName, amount);
                            targetXPlayer.removeInventoryItem(itemName, amount);
                            TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..amount..' '..sourceItem.label.."~s~.")
                            TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..amount..' '..sourceItem.label.."~s~.")
                            SendLogs("Gouv", "Valestia | Gouv", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://discord.com/api/webhooks/1226956866655879349/6lOUDYSHAAC3DvrsErZ5KeNyc_cTTtxJHimKY8pX_4RWKO5_MaO0GrkNWKbxs-W-5P07")
                        else
                            TriggerClientEvent('esx:showNotification', source, "Quantité invalide");
                        end
                    end
                end);
            end         
            if itemType == 'item_account' then
                local targetAccount = targetXPlayer.getAccount(itemName)
                if (targetAccount and targetAccount.money >= amount) then
                    targetXPlayer.removeAccountMoney(itemName, amount);
                    TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..amount.."$ ~s~argent non déclaré~s~.");
                    TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..amount.."$ ~s~argent non déclaré~s~.");
                    SendLogs("Gouv", "Valestia | Gouv", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://discord.com/api/webhooks/1226956866655879349/6lOUDYSHAAC3DvrsErZ5KeNyc_cTTtxJHimKY8pX_4RWKO5_MaO0GrkNWKbxs-W-5P07")
                else
                    TriggerClientEvent('esx:showNotification', source, "Quantité invalide");
                end
            end
        
            if itemType == 'item_weapon' then
                if (targetXPlayer.hasWeapon(string.upper(itemName))) then
                    targetXPlayer.removeWeapon(itemName, 0);
                    TriggerEvent('esx_datastore:getSharedDataStore', 'society_gouv', function(store)
                        local weapons = store.get('weapons') or {}
                        local foundWeapon = false

                        for i=1, #weapons, 1 do
                            if weapons[i].name == itemName then
                                weapons[i].count = weapons[i].count + 1
                                foundWeapon = true
                                break
                            end
                        end

                        if not foundWeapon then
                            table.insert(weapons, {
                                name  = itemName,
                                count = 1
                            })
                        end                    
                        store.set('weapons', weapons)
                    end)
                    SendLogs("Gouv", "Valestia | Gouv", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://discord.com/api/webhooks/1226956866655879349/6lOUDYSHAAC3DvrsErZ5KeNyc_cTTtxJHimKY8pX_4RWKO5_MaO0GrkNWKbxs-W-5P07")
                end
            end
        end
    end
end);
