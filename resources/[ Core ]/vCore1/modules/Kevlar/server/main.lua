playerArmour = {}
isLoaded = false

ESX.RegisterUsableItem('kevlar', function(source)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)
    local armour = GetPedArmour(ped)

    if (xPlayer) then

        if armour <= 0 then
            SetPedArmour(ped, 100)
            xPlayer.removeInventoryItem("kevlar", 1)
            playerArmour[xPlayer.identifier] = true
            TriggerClientEvent("Kevlar:Add", source, 4.5)
        else
            xPlayer.showNotification("Vous avez deja du kevlar sur vous")
        end

    end
end)

ESX.RegisterUsableItem('kevlarmid', function(source)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)
    local armour = GetPedArmour(ped)

    if (xPlayer) then

        if armour <= 0 then
            SetPedArmour(ped, 50)
            xPlayer.removeInventoryItem("kevlarmid", 1)
            playerArmour[xPlayer.identifier] = true
            TriggerClientEvent("Kevlar:Add", source, 5.0)
        else
            xPlayer.showNotification("Vous avez deja du kevlar sur vous")
        end

    end
end)

ESX.RegisterUsableItem('kevlarlow', function(source)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)
    local armour = GetPedArmour(ped)

    if (xPlayer) then

        if armour <= 0 then
            SetPedArmour(ped, 25)
            xPlayer.removeInventoryItem("kevlarlow", 1)
            playerArmour[xPlayer.identifier] = true
            TriggerClientEvent("Kevlar:Add", source, 6.0)
        else
            xPlayer.showNotification("Vous avez deja du kevlar sur vous")
        end

    end
end)

RegisterNetEvent("vCore1:kevlar:verif", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)
    local armour = GetPedArmour(ped)

    if (xPlayer) then

        if not playerArmour[xPlayer.identifier] and isLoaded then
            xPlayer.ban(0, '(add armour client side)')
        else
            if armour <= 0 then
                playerArmour[xPlayer.identifier] = nil
            end
        end

    end
end)

RegisterNetEvent("vCore1:kevlar:remove", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)

    if (xPlayer) then
        playerArmour[xPlayer.identifier] = nil
        TriggerClientEvent("vCore1:kevlar:removetoclient", source)
        SetPedArmour(ped, 0)
    end
end)

RegisterNetEvent("vCore1:kevlar:addforjob", function(job, value)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)

    if (xPlayer) then

        if job == "police" or job == "bcso" or job == "fib" then

            if xPlayer.job.name ~= job then
                xPlayer.ban(0, '(Kevlar:AddForJob)')
                return
            end

            SetPedArmour(ped, value)
            playerArmour[xPlayer.identifier] = true

        else
            xPlayer.ban(0, '(Kevlar:AddForJob)')
            return
        end

    end
end)

AddEventHandler('esx:playerLoaded', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        playerArmour[xPlayer.identifier] = nil
        isLoaded = true
        SetPedArmour(ped, 0)
    end
end)