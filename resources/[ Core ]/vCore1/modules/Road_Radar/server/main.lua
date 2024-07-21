local bypassJob = Config["Road_Radar"]["BypassJob"] and Config["Road_Radar"]["BypassJob"] or {}

RegisterNetEvent('vCore1:radar:sendbill', function(playerSpeed, speedDif, speedLimit)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = ESX.DoesSocietyExist("police")
    local price = Config["Road_Radar"]["PriceL1"]

    if xPlayer then
        local job = xPlayer.getJob().name

        for i = 1, #bypassJob or 1 do

            if bypassJob[i] == job then
                xPlayer.showNotification("Votre employeur sera notifié de cette excès de vitesse")
                return
            end
            
        end

        if society then
            local bank = xPlayer.getAccount('bank')

            if bank and bank.money then

                if speedDif < 20 then
                    price = Config["Road_Radar"]["PriceL1"]
                elseif speedDif < 30 then
                    price = Config["Road_Radar"]["PriceL2"]
                elseif speedDif < 50 then
                    price = Config["Road_Radar"]["PriceL3"]
                else
                    price = Config["Road_Radar"]["PriceL4"]
                end

                xPlayer.removeAccountMoney('bank', price)
                ESX.AddSocietyMoney("police", price)
                xPlayer.showNotification("Excès de vitesse: "..Shared:ServerColorCode()..""..playerSpeed.." Km/h ~c~au lieu de "..Shared:ServerColorCode()..""..speedLimit.." Km/h.")
                xPlayer.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~")

            end
        end
    end
end)