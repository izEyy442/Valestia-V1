local goFast = {

    Time = 0,
    playerSource = nil,
    playerInGoFast = nil,
    isActive = false,
    carPlate = nil,
    vehicle = nil

}

local function CallPolice()
    while true do
        local xPlayers = ESX.GetPlayers();

        if goFast.isActive then
            for i = 1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i]);

                if (xPlayer and xPlayer.job.name == 'police' or xPlayer and xPlayer.job.name == 'bcso') then
                    local ped = GetPlayerPed(goFast.playerSource)
                    local coords = GetEntityCoords(ped)

                    TriggerClientEvent('vCore1:gofast:sendalert', xPlayer.source, "Gofast en cours, un véhicule avec la plaque ("..goFast.carPlate..") est placé sur votre GPS", coords);
                end
            end
        else
            for i = 1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i]);

                if xPlayer and xPlayer.job.name == 'police' or xPlayer and xPlayer.job.name == 'bcso' then
                    TriggerClientEvent('vCore1:gofast:sendalert', xPlayer.source, "Nous avons perdu la trace du suspect", nil)
                end

            end
            break;
        end
        Wait(1000 * 30 * Config["GoFast"]["PoliceAlertTime"]);
    end
end

RegisterServerEvent("vCore1:gofast:start")
AddEventHandler("vCore1:gofast:start", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local pos = Config["GoFast"]["StartPos"]
    local car = Config["GoFast"]["SpawnCar"]

    if (xPlayer) then

        if #(coords - pos) < 5 then

            local timeInMilliseconds = Config["GoFast"]["Time"] * 60000
            local timeElapsed = GetGameTimer() - goFast.Time
            local timeRemaining = math.max(0, timeInMilliseconds - timeElapsed)
            local timeRemainingMinutes = timeRemaining / 60000

            if (goFast.Time == 0 or timeElapsed > timeInMilliseconds) then

                goFast.Time = GetGameTimer()
                goFast.playerInGoFast = xPlayer.identifier
                goFast.isActive = true
                goFast.playerSource = source

                ESX.SpawnVehicle(car, Config["GoFast"]["SpawnPosCar"], Config["GoFast"]["SpawnHeading"], nil, false, nil, function(vehicle)

                    TaskWarpPedIntoVehicle(ped, vehicle, -1)
                    goFast.carPlate = GetVehicleNumberPlateText(vehicle)
                    goFast.vehicle = vehicle

                end)

                xPlayer.triggerEvent('vCore1:gofast:startendzone')
                xPlayer.showNotification("Prenez le véhicule et allez à la position demander sur votre GPS")

                SetTimeout(2500, function()
                    CallPolice()
                end)

            else
                xPlayer.showNotification("Veuillez revenir dans " .. math.floor(timeRemainingMinutes) .. " minutes pour faire le Go fast")
            end

        else
            xPlayer.ban(0, "vCore1:gofast:start")
        end
    end
end)

RegisterServerEvent("vCore1:gofast:end")
AddEventHandler("vCore1:gofast:end", function(vehiclePlate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local pos = Config["GoFast"]["EndPos"]
    local reward = Config["GoFast"]["Reward"]

    if (xPlayer) then

        if #(coords - pos) < 10 then

            if goFast.playerInGoFast == xPlayer.identifier then

                if goFast.carPlate ~= nil and vehiclePlate ~= nil then

                    if goFast.carPlate == vehiclePlate then

                        if goFast.isActive then

                            goFast.playerInGoFast = nil
                            goFast.isActive = false
                            goFast.playerSource = nil

                            xPlayer.addAccountMoney("dirtycash", reward)
                            xPlayer.showNotification("Vous avez reçu "..reward.." ~g~$")

                            SetTimeout(2500, function()
                                DeleteEntity(goFast.vehicle)
                                goFast.vehicle = nil
                            end)

                        else
                            xPlayer.ban(0, "vCore1:gofast:end (not active)")
                        end

                    else
                        xPlayer.showNotification("Hein ? C'est quoi ça ? C'est pas la voiture du GoFast !")
                    end

                end

            else
                xPlayer.ban(0, "vCore1:gofast:end (not playerInGoFast)")
            end

        else
            xPlayer.ban(0, "vCore1:gofast:end (coords)")
        end
    end
end)

AddEventHandler('playerDropped', function (reason)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if goFast.playerInGoFast == xPlayer.identifier then

            goFast.playerInGoFast = nil
            goFast.isActive = false
            goFast.playerSource = nil

            DeleteEntity(goFast.vehicle)
            goFast.vehicle = nil

        end
    end
end)