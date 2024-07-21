--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway

RegisterNetEvent(_Prefix..':accessories:pay')
AddEventHandler(_Prefix..':accessories:pay', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = _Config.clotheshop.accessoriesPrice
    if xPlayer.getAccount('cash').money >= price then
        xPlayer.removeAccountMoney('cash', price)
        TriggerClientEvent('esx:showNotification', source,"~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Nouvel accessoire~s~\n~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..price.." $~s~ vous ont été prélevés de votre portefeuille.")
        TriggerClientEvent(_Prefix..':saveSkin', source)
    else
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Il semblerait que vous ne possédiez pas l'argent nécessaire.")
    end
end)

RegisterNetEvent(_Prefix..':outfit:pay')
AddEventHandler(_Prefix..':outfit:pay', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = _Config.clotheshop.price
    if xPlayer.getAccount('cash').money >= price then
        xPlayer.removeAccountMoney('cash', price)
        TriggerClientEvent('esx:showNotification', source,"~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vêtement - Nouvelle tenue~s~\n~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..price.." $~s~ vous ont été prélevés de votre portefeuille.")
        TriggerClientEvent(_Prefix..':saveSkin', source)
    else
        TriggerClientEvent('esx:showNotification', source, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Il semblerait que vous ne possédiez pas l'argent nécessaire.")
    end
end)