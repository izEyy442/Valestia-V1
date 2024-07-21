playerInService = {}

RegisterNetEvent("vCore1:job:takeService", function(job, active)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if (xPlayer.job.name ~= job) then
            xPlayer.ban(0, "(vCore1:job:takeService)")
            return
        end

        for k, v in pairs(Config["Log"]["Job"]) do
            if (k == job) then
                local webhook = v["take_service"]

                if (webhook) then

                    if active then
                        if (playerInService[xPlayer.identifier] == nil) then
                            playerInService[xPlayer.identifier] = {}
                            playerInService[xPlayer.identifier].job = job
                            playerInService[xPlayer.identifier].inService = true
                            SendLogs("TakeService", "Valestia | TakeService", ("%s %s (***%s***) viens de prendre son service"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier), webhook)
                        end
                    else
                        if (playerInService[xPlayer.identifier] ~= nil) then
                            playerInService[xPlayer.identifier] = nil
                            SendLogs("LeaveService", "Valestia | LeaveService", ("%s %s (***%s***) viens de quitter son service"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier), webhook)
                        end
                    end

                end

            end

        end

    end

end)

AddEventHandler("playerDropped", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        
        if (playerInService[xPlayer.identifier] ~= nil) then
            local job = xPlayer.job.name

            for k, v in pairs(Config["Log"]["Job"]) do

                if (k == job) then

                    local webhook = v["take_service"]

                    if (webhook) then

                        if (playerInService[xPlayer.identifier] ~= nil) then
                            playerInService[xPlayer.identifier] = nil
                            SendLogs("LeaveService", "Valestia | LeaveService", ("%s %s (***%s***) viens de quitter son service"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier), webhook)
                        end

                    end
                    
                end

            end

        end

    end

end)

exports("GetPlayerInService", function(identifier)

    if (playerInService[identifier] ~= nil) then
        return playerInService[identifier]
    else
        return nil
    end

end)