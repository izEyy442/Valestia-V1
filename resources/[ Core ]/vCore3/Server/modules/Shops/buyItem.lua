---
--- @author Kadir#6666
--- Create at [19/04/2023] 13:12:34
--- Current project [Valestia-V1]
--- File name [buyItem]
---

RegisterNetEvent("Shops:BuyItem", function(shpId, item_type, item_name, count)

    local playerSrc = source
    count = tonumber(count) or 1

    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (xPlayer == nil or count == nil) then return end

    local selectedShp = ShopsManager.GetFromId(shpId)
    if (selectedShp == nil) then
        return
    end

    local playerIsOnPos
    for pos = 1, #selectedShp.positions do

        if (#(GetEntityCoords(GetPlayerPed(playerSrc))-selectedShp.positions[pos]) < 3.0) then

            playerIsOnPos = true
            break

        end

    end

    if (not playerIsOnPos) then
        return
    end

    local licenseExist = false;
    if (item_type == "license") then
        Shared.Events:Trigger("esx_license:getLicense", item_name, function()
            licenseExist = true;
        end)
    end

    local itemExist = ((item_type == "standard" and ESX.GetItem(item_name)) or (item_type == "weapon" and ESX.GetWeapon(item_name))) ~= nil and true or false
    if (not itemExist and not licenseExist) then
        return
    end

    local selectedItem = selectedShp.items[item_name]
    if (selectedItem == nil) then
        return
    end

    if (((selectedItem.type or "standard") ~= item_type) or (selectedItem.cat == "vip" and xPlayer.getVIP() == 0)) then
        return
    end

    local player_have_license
    if (item_type == "license") then
        Shared.Events:Trigger("esx_license:checkLicense", xPlayer.source, item_name, function(state)
            player_have_license = state;
        end)
    end

    while (item_type == "license" and player_have_license == nil) do
        Wait(1000)
    end

    if ((item_type == "standard" and not xPlayer.canCarryItem(item_name, count)) or (item_type == "weapon" and xPlayer.hasWeapon(item_name)) or (player_have_license == true)) then
        return
        xPlayer.showNotification("Désolé, mais vous n'avez pas assez de place dans votre sac.")
    end

    local totalPrice = (selectedItem.price * count)
    if (totalPrice ~= nil) then

        local buyAccount = {}

        buyAccount.list = {}
        buyAccount.list["cash"] = xPlayer.getAccount('cash').money
        buyAccount.list["bank"] = xPlayer.getAccount('bank').money
        buyAccount.current = nil

        if (buyAccount.list["cash"] > buyAccount.list["bank"]) then
            buyAccount.current = "cash"
        else
            buyAccount.current = "bank"
        end

        if (buyAccount.list[buyAccount.current] >= totalPrice) then

            if (item_type == "standard") then
                xPlayer.addInventoryItem(item_name, count)
            elseif (item_type == "weapon") then
                xPlayer.addWeapon(item_name, 12)
            elseif (item_type == "license") then
                Shared.Events:Trigger("esx_license:addLicense", xPlayer.source, item_name, function()
                    xPlayer.triggerEvent("Shops:UpdateLicenses")
                end)
            end

            xPlayer.removeAccountMoney(buyAccount.current, totalPrice)
            xPlayer.showNotification(("Vous avez acheté ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%sx %s~s~ pour un total de %s~g~$~s~."):format(count, selectedItem.label, totalPrice))

        else

            xPlayer.showNotification(("Désolé, mais il vous manque %s~g~$~s~."):format((totalPrice-buyAccount.list[buyAccount.current])))

        end

    end

end)