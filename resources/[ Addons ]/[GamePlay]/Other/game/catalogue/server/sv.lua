ESX = nil

TriggerEvent(Config.ESX, function(obj) ESX = obj end)

ESX.RegisterServerCallback('getCategories', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('getAllVehicles', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM vehicles', {
    }, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('catalogue:changeBucket')
AddEventHandler('catalogue:changeBucket', function(reason)
    local source = source
    if reason == "enter" then
        SetPlayerRoutingBucket(source, source+1)
    else
        SetPlayerRoutingBucket(source, 0)
    end
end)