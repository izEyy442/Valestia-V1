ESX = nil
local continue = false
local isInTrue = false
TriggerEvent(Config.ESX, function(obj) ESX = obj end)

RegisterServerEvent('illegal:buy')
AddEventHandler('illegal:buy', function(price, type, name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in pairs(Config.Illegal.Items) do
        if v.togivename == name and price == v.price then
            continue = true
        else
            continue = false
        end
        if continue == true then
            isInTrue = true
        end
    end
    if isInTrue == false then
        -- Trigger ban (100% cheateur)
        return
    end
    if type == "item" then
        if xPlayer.getAccount(Config.Illegal.TypeMoneyUse).money >= price then
            xPlayer.removeAccountMoney('dirtycash', price)
            xPlayer.addInventoryItem(name, 1)
        else
            TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas assez d'argent.")
        end

        isInTrue = false
        continue = false
    elseif type == "weapon" then
        if xPlayer.getAccount(Config.Illegal.TypeMoneyUse).money >= price then
            xPlayer.removeAccountMoney('dirtycash', price)
            xPlayer.addWeapon(name, 1)
        else
            TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas assez d'argent.")
        end

        isInTrue = false
        continue = false
    end
end)