local playerInWaiting = {}
local isPassed = false

RegisterNetEvent(
    "vCore1:ltd:buy",
    function(target, data, paymentType)
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(target)

        if (xPlayer and xTarget) then
            for k, v in ipairs(Config["LTDShop"]["AllowedJob"]) do
                if (xPlayer.job.name == v) then
                    isPassed = true
                    break
                end
            end

            if (isPassed) then
                if (data ~= nil) then
                    local totalItems = {}
                    local totalPrice = 0

                    for k, v in ipairs(data) do
                        totalPrice = totalPrice + v.price
                        table.insert(totalItems, {item = v.item, count = v.count, price = v.price})
                    end

                    playerInWaiting[xTarget.source] = {}
                    playerInWaiting[xTarget.source].society = data[1].society
                    playerInWaiting[xTarget.source].seller = xPlayer.source
                    playerInWaiting[xTarget.source].paymentType = paymentType
                    playerInWaiting[xTarget.source].totalPrice = totalPrice
                    playerInWaiting[xTarget.source].totalItems = totalItems
                    playerInWaiting[xTarget.source].isWaiting = true
                    TriggerClientEvent(
                        "vCore1:player:ltd:receiveBill",
                        xTarget.source,
                        playerInWaiting[xTarget.source].totalPrice
                    )
                end
            else
                xPlayer.ban(0, "(vCore1:ltd:buy)")
            end
        end
    end
)

RegisterNetEvent(
    "vCore1:ltd:payBill",
    function(bool)
        local xPlayer = ESX.GetPlayerFromId(source)
        local xSeller = ESX.GetPlayerFromId(playerInWaiting[xPlayer.source].seller)

        if (xPlayer) then
            if bool == true then
                local societyName = playerInWaiting[xPlayer.source].society
                local society = ESX.DoesSocietyExist(societyName)
                local paymentType = playerInWaiting[xPlayer.source].paymentType
                local price = playerInWaiting[xPlayer.source].totalPrice

                if (society) then
                    if (playerInWaiting[xPlayer.source].isWaiting) then
                        for k, v in ipairs(playerInWaiting[xPlayer.source].totalItems) do
                            local item = v.item
                            local count = tonumber(v.count)
                            local price = tonumber(v.price)

                            if (item and count and price) then
                                if xPlayer.canCarryItem(item, count) then
                                    xPlayer.addInventoryItem(item, count)
                                    xPlayer.removeAccountMoney(paymentType, price)
                                    local finalPrice = price - price * 30/100
                                    print(finalPrice)
                                    ESX.AddSocietyMoney(societyName, finalPrice)
                                else
                                    xPlayer.showNotification(
                                        ("Vous pouvez pas prendre autant de %s sur vous"):format(ESX.GetItemLabel(item))
                                    )
                                    xSeller.showNotification(
                                        ("La personne peux pas prendre autant de %s sur lui"):format(
                                            ESX.GetItemLabel(item)
                                        )
                                    )
                                    playerInWaiting[xPlayer.source] = nil
                                    return
                                end
                            end
                        end

                        xPlayer.showNotification(("Vous avez payé votre facture de %s ~g~$~s~"):format(price))
                        xSeller.showNotification(
                            ("Une facture de %s ~g~$~s~ à été payer par %s"):format(price, xPlayer.getFirstName())
                        )
                        SendLogs(
                            "LTD",
                            "Valestia | SellItems",
                            ("%s %s (***%s***) vient d'effectuer une vente pour **%s** $"):format(
                                xSeller.getLastName(),
                                xSeller.getFirstName(),
                                xSeller.identifier,
                                price
                            ),
                            Config["Log"]["Job"][societyName]["sell_items"]
                        )
                        playerInWaiting[xPlayer.source] = nil
                    end
                end
            else
                xPlayer.showNotification("Vous avez refusé de payer la facture")
                xSeller.showNotification("La personne a refusé de payer la facture")
                playerInWaiting[xPlayer.source] = nil
            end
        end
    end
)

local timeoutAnnounce = {}

RegisterNetEvent(
    "vCore1:ltd:sendAnnounce",
    function(type)
        local xPlayer = ESX.GetPlayerFromId(source)

        if (xPlayer) then
            if
                (not timeoutAnnounce[xPlayer.identifier] or
                    GetGameTimer() - timeoutAnnounce[xPlayer.identifier] > 600000)
             then
                timeoutAnnounce[xPlayer.identifier] = GetGameTimer()

                local job = xPlayer.job.name

                if (type == "open") then
                    TriggerClientEvent("vCore1:ltd:player:sendAnnounce", -1, Config["LTDShop"]["Announce"]["open"][job])
                elseif (type == "close") then
                    TriggerClientEvent(
                        "vCore1:ltd:player:sendAnnounce",
                        -1,
                        Config["LTDShop"]["Announce"]["close"][job]
                    )
                elseif (type == "recruitment") then
                    TriggerClientEvent(
                        "vCore1:ltd:player:sendAnnounce",
                        -1,
                        Config["LTDShop"]["Announce"]["recruitment"][job]
                    )
                end
            else
                xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau")
            end
        end
    end
)
