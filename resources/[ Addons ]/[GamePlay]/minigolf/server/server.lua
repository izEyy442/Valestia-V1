-- Author : Morow
-- Github : https://github.com/Morow73

if Config.USE_ESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)
end

RegisterNetEvent("mrw_minigolf:locateClub")
AddEventHandler("mrw_minigolf:locateClub", function()
    local x_source = source

    if Config.USE_ESX then
        local xPlayer = ESX.GetPlayerFromId(x_source)
        local getPlayerMoney = xPlayer.getAccount('cash').money

        if getPlayerMoney >= Config.club_price then
            TriggerClientEvent("mrw_minigolf:st_game", x_source, 1)
            xPlayer.removeAccountMoney('cash',Config.club_price )
        else
            TriggerClientEvent("mrw_golf:Notification", x_source, translation["no_money"])
        end
    else
        -- IF USE YOUR CUSTOM FRAMEWORK !!
        -- ADD YOUR LINE FOR COMPARE PLAYER MONEY
        TriggerClientEvent("mrw_minigolf:st_game", x_source, 1)
    end
end)