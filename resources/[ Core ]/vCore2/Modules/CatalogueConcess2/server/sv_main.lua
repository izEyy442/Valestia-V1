ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('getCategoriesNorth', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('getAllVehiclesNorth', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM vehicles', {
    }, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('catalogue:changeBucketNorth')
AddEventHandler('catalogue:changeBucketNorth', function(reason)
    local source = source
    if reason == "enter" then
        SetPlayerRoutingBucket(source, source+1)
    else
        SetPlayerRoutingBucket(source, 0)
    end
end)