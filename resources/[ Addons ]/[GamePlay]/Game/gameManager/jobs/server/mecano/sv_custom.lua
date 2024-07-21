--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

local JobCustoms = {
    ["mecano"] = true,
    ["lscustoms"] = true
}

RegisterServerEvent("BuyLsCustoms")
AddEventHandler("BuyLsCustoms", function(newVehProps, amount)
        local _src = source
        local xPlayer = ESX.GetPlayerFromId(_src)
        local job = xPlayer.job.name
        local societyAccount = nil
        local price = tonumber(amount)

        if JobCustoms[job] then
            TriggerEvent("GetMoneySv", job, function(account)
                local societyAccount = account

                if societyAccount ~= nil and tonumber(societyAccount) >= price then
                    TriggerClientEvent("Mecano:installMod", _src)
                    TriggerEvent("RemoveMoneySociety", job, price)

                    xPlayer.showNotification(
                        "Vous avez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~installé~s~ toutes ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~les modifications~s~."
                    )
                    xPlayer.showNotification(
                        "Vous avez modifier le véhicule ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" ..
                            price .. "$~s~ on été retiré de l'entreprise."
                    )
                else
                    TriggerClientEvent("CancelLsCustoms", _src)
                end
            end)
        end
    end
)

ESX.RegisterServerCallback(
    "Valestia:PayCustom",
    function(source, cb, tplayer, price, societyName)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer == nil then
            return
        end

        -- if xPlayer.job.name ~= "mecano" or xPlayer.job.name ~= "mecano2" then
        --     return xPlayer.ban(0, "(Valestia:PayCustom)")
        -- end

        local tPlayer = ESX.GetPlayerFromId(tplayer)
        local job = xPlayer.job.name
        local societyExists = ESX.DoesSocietyExist(job)

        if tPlayer then
            if societyExists then
                if tPlayer.getAccount("bank").money >= price then
                    tPlayer.removeAccountMoney("bank", price)
                    tPlayer.showNotification("Vous avez payé ~g~" .. price .. "$~s~.")
                    ESX.AddSocietyMoney(job, price)
                    xPlayer.showNotification("le client a payé ~g~" .. price .. "$~s~.")
                    print(tPlayer.getAccount("bank").money)
                    cb(true)
                else
                    cb(false)
                end
            else
                cb(false)
            end
        else
            cb(false)
        end
    end
)

RegisterNetEvent(
    "Mecano:refreshOwnedVehicle",
    function(myCar)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)

        if (xPlayer.job.name ~= "mecano" or xPlayer.job.name ~= "mecano2") then
            return xPlayer.ban(0, "(Mecano:refreshOwnedVehicle)")
        end

        MySQL.Async.fetchAll(
            "SELECT * FROM owned_vehicles WHERE @plate = plate",
            {
                ["@plate"] = myCar.plate
            },



            function(result)
                if result[1] then
                    local props = json.decode(result[1].props)

                    if props.model == myCar.model and props.plate == myCar.plate then
                        MySQL.Async.execute(
                            "UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate",
                            {
                                ["@plate"] = myCar.plate,
                                ["@vehicle"] = json.encode(myCar)
                            }
                        )

                        local licenseThePlayer = result[1].owner
                        local lePrixFacture = price*2
                        local content = {
                            {
                                ["title"] = "**__Buy Custom__**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Information :", value = "["..licenseThePlayer.."]"},
                                    { name = "- Plaque véhicule :", value = "["..myCar.plate.."]" },
                                    { name = "- Prix Facture :", value = lePrixFacture.."$" },
                                },
                                ["type"]  = "rich",
                                ["color"] = 16711680,
                                ["footer"] =  {
                                    ["text"] = "By t0nnnio | Valestia",
                                },
                            }
                        }
                        PerformHttpRequest("https://discord.com/api/webhooks/1236628373271220256/zBh4XI9UIMIADj5p3UAaa3I4QgK-H7ZhCi4rOpYr__cK3QEuRKVekWlVMGblrfqNeMxL", function(err, text, headers) end, 'POST', json.encode({username = "Buy Custom", embeds = content}), { ['Content-Type'] = 'application/json' })

                    else
                        print(
                            ("sCustom: %s a tenté de mettre à niveau un véhicule dont le modèle ou la plaque n'était pas assorti !"):format(
                                xPlayer.identifier
                            )
                        )
                    end
                end
            end
        )
    end
)

RegisterServerEvent(
    "vCore3:mechanic:requestPlayerBillsState",
    function(target_player_source)
        if (type(target_player_source) ~= "number") then
            return
        end

        local player_source = source
        local player_source_data = ESX.GetPlayerFromId(player_source)
        local target_player_source_data = ESX.GetPlayerFromId(target_player_source)

        if (player_source_data ~= nil and target_player_source_data ~= nil) then
            MySQL.Async.fetchAll(
                "SELECT * FROM billing WHERE identifier = @a",
                {
                    ["@a"] = target_player_source_data.getIdentifier()
                },
                function(player_bills)
                    if (player_bills[1] ~= nil) then
                        player_source_data.showNotification(
                            "La personne sélectionner a déjà une ou plusieurs factures impayées."
                        )
                        target_player_source_data.showNotification("Vous avez déjà une ou plusieurs factures impayées.")
                        player_source_data.triggerEvent("vCore3:mechanic:receivePlayerBillsState", false)
                    else
                        player_source_data.triggerEvent("vCore3:mechanic:receivePlayerBillsState", true)
                    end
                end
            )
        end
    end
)
