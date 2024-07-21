ESX = nil

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

RegisterServerEvent('brinks:payWeapon')
AddEventHandler('brinks:payWeapon', function(prix, name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= "brinks" then
        xPlayer.ban(0, '(brinks:payWeapon)');
        return
    end
    if xPlayer.getAccount('cash').money >= prix then
        xPlayer.removeAccountMoney('cash', prix)
        xPlayer.addWeapon(name, 250)
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n\'avez pas assez d\'argent')
    end
end)

RegisterServerEvent('brinks:annonce')
AddEventHandler('brinks:annonce', function(annonce)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Rockford-brinks', annonce, 'CHAR_brinks', 8)
    end
end)
