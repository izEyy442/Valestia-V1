local AntiSpamLimit = {}

RegisterNetEvent("vCore1:identitypapers:request", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config["IdentityPapers"]["Price"]

    if xPlayer then

        if xPlayer.getAccount('cash').money >= price then

            if (not AntiSpamLimit[xPlayer.identifier]) then
                AntiSpamLimit[xPlayer.identifier] = true

                MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @identifier AND type = @type', {
                    ['@identifier'] = xPlayer.identifier,
                    ['@type'] = "id"
                },function(result)
                    if not result[1] then
                        xPlayer.removeAccountMoney('cash', price)
                        MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
                            ['@type'] = "id",
                            ['@owner'] = xPlayer.identifier
                        })
                        xPlayer.showNotification("Vous avez reçu votre piece d'identité")
                    else
                        xPlayer.showNotification("Vous avez déjà votre pièce d'identité")
                    end
                end)

            end

        else
            xPlayer.showNotification("Vous n'avez pas assez d'argent sur vous")
        end

    end
end)