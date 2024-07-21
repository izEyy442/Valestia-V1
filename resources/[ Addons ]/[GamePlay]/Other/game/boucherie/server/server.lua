ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local items = {
    ["viande_1"] = {price = 125, sell = true},
    ["viande_2"] = {price = 150, sell = true},
}

RegisterNetEvent("Boucherie:sellItem", function(item, selectCount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer == nil then return end

    local verifItem = items[item]
    if verifItem == nil then return end
    if verifItem.sell ~= true then return end

    local itemCount = xPlayer.getInventoryItem(item).count
    if selectCount > itemCount then return TriggerClientEvent("esx:showNotification", source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas cela sur vous !") end
    local totalPrice = verifItem.price*selectCount
    if #(GetEntityCoords(GetPlayerPed(source))-vector3(961.11407470703,-2111.4272460938,31.944053649902)) > 2.0 then 
        xPlayer.ban(0, '(Boucherie:sellItem)');
        return
    end
    xPlayer.removeInventoryItem(item, selectCount)
    xPlayer.addAccountMoney('cash', totalPrice)
    TriggerClientEvent("esx:showNotification", source, "Vous avez vendue ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x"..selectCount.." Viande(s)~s~ pour "..totalPrice.."~g~$~s~ !")
end)