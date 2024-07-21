
if Config.ActiveBoombox then
    ESX.RegisterUsableItem(Config.BoomboxItem, function(source)
        local xPlayer = GetPlayerFromId(source)
        if UseBoombox(source) then
            TriggerClientEvent('lgd_boombox:useBoombox', source)
            RemoveItem(xPlayer, Config.BoomboxItem, 1)
        end
    end)
end


RegisterNetEvent("lgd_boombox:soundStatus")
AddEventHandler("lgd_boombox:soundStatus", function(type, musicId, data)
    TriggerClientEvent("lgd_boombox:soundStatus", -1, type, musicId, data)
end)

RegisterServerEvent('lgd_boombox:deleteObj', function(netId)
    TriggerClientEvent('lgd_boombox:deleteObj', -1, netId)
end)

RegisterServerEvent('lgd_boombox:objDeleted', function()
    local xPlayer = GetPlayerFromId(source)
    AddItem(xPlayer, Config.BoomboxItem, 1)
end)

RegisterNetEvent("lgd_boombox:syncActive")
AddEventHandler("lgd_boombox:syncActive", function(activeRadios)
    TriggerClientEvent("lgd_boombox:syncActive", -1, activeRadios)
end)

RegisterNetEvent("lgd_boombox:soundStatus")
AddEventHandler("lgd_boombox:soundStatus", function(type, musicId, data)
    TriggerClientEvent("lgd_boombox:soundStatus", -1, type, musicId, data)
end)