RegisterNetEvent('izeyy:locajetski')
AddEventHandler('izeyy:locajetski', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local argentdujoueurcash = xPlayer.getAccount('cash').money
    local prix = 500
    local model = "seashark"
    if argentdujoueurcash >= prix then
        xPlayer.removeAccountMoney('cash', 500)
        TriggerClientEvent('esx:showNotification', source, "Tient ton SeaShark !")
        ESX.SpawnVehicle(model, vector3(-1628.315, -1166.165, 0.1403382), 119.50224304199, nil, false, nil, function(vehicle)
            TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
        end)
    else
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent.')
    end
end)
