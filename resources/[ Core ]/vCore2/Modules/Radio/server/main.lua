RegisterNetEvent("vCore1:radio:resquestMenu", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        local hasRadio = xPlayer.hasInventoryItem("radio", 1)
        if xPlayer.job.name == "police" or xPlayer.job.name == "bcso" or xPlayer.job.name == "fib" or xPlayer.job.name == "fib" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "gouv" then
            hasRadio = true
        end
        TriggerClientEvent("vCore1:radio:player:resquestMenu", source, hasRadio)
    end

end)