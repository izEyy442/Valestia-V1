local playerTimed = {};

RegisterNetEvent("Bank:hackATM", function(animation, success, coords)
    local playerSrc = source

    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    local hasBrouilleur = xPlayer.getInventoryItem("brouilleur")
    local deleteBrouilleur = math.random(0, 10)
    if (hasBrouilleur == nil or hasBrouilleur.count == 0) then
        xPlayer.showAdvancedNotification("Notification", "Bruteforce", "Vous n'avez aucun moyen de pirater cette ATM !")
    else
        if deleteBrouilleur == 2 or deleteBrouilleur == 9 then
            xPlayer.removeInventoryItem("brouilleur")
        end
        
        if (not playerTimed[xPlayer.identifier] or GetGameTimer() - playerTimed[xPlayer.identifier] > 3600000) then
            if animation then
                TriggerClientEvent("Bank:startBruteForce", playerSrc)
                playerTimed[xPlayer.identifier] = nil
            else
                if success then
                    local amount = math.random(2500, 3000)
                    local chance = math.random(0, 10)
                    local xPlayers = ESX.GetPlayers()
                    playerTimed[xPlayer.identifier] = GetGameTimer()
                    xPlayer.addAccountMoney('cash', amount)
                    xPlayer.showAdvancedNotification("Notification", "Bruteforce", "Vous avez terminé avec succès le Bruteforce")
                    xPlayer.showAdvancedNotification("Notification", "Bruteforce", "Vous avez gagné "..amount.." ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~$")
                    if chance > 7 then
                        for i = 1, #xPlayers do
                            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

                            if (xPlayer) then

                                if xPlayer and xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
                                    TriggerClientEvent("Bank:PoliceBlip", xPlayers[i], coords, 45)
                                end

                            end
                        end
                    end
                else
                    xPlayer.showAdvancedNotification("Notification", "Bruteforce", "Vous avez raté le Bruteforce")
                end
            end
            
            Wait(3600000)
            local playerTimed = {};

        else
            xPlayer.showAdvancedNotification("Notification", "Bruteforce", "Ce distributeur a été récemment cambriolé et n'a plus d'argent, revenez plus tard.")
        end
    end
end)