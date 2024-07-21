RegisterNetEvent("vCore1:police:handcuff", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name == "police" then

            if (target ~= -1 and xTarget) then

                if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
                    TriggerClientEvent("vCore1:police:player:handcuff", target)
                end

            end

        else
            xPlayer.ban(0, "(vCore1:police:handcuff)")
        end
    end
end)

RegisterNetEvent("vCore1:police:escort", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name == "police" then

            if (target ~= -1 and xTarget) then

                if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
                    TriggerClientEvent("vCore1:police:player:escort", target, source)
                end

            end

        else
            xPlayer.ban(0, "(vCore1:police:escort)")
        end
    end
end)

RegisterNetEvent("vCore1:police:putInVehicle", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name == "police" then

            if (target ~= -1 and xTarget) then

                if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
                    TriggerClientEvent("vCore1:police:player:putInVehicle", target)
                end

            end

        else
            xPlayer.ban(0, "(vCore1:police:putInVehicule)")
        end
    end
end)

RegisterNetEvent("vCore1:police:putOutVehicle", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name == "police" then

            if (target ~= -1 and xTarget) then

                if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
                    TriggerClientEvent("vCore1:police:player:putOutVehicle", target)
                end

            end

        else
            xPlayer.ban(0, "(vCore1:police:putInVehicule)")
        end
    end
end)

RegisterNetEvent("vCore1:police:sendFine", function(target, type)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromId(target)
	local price = 0

    if (not xPlayer) then return; end
    if (not xTarget) then return; end

    if xPlayer.job.name ~= "police" then
        xPlayer.ban(0, "(vCore1:police:sendFine)")
        return
    end

    local society = ESX.DoesSocietyExist("police")

    if (not society) then return; end

    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then

        for k, v in pairs(Config["PoliceJob"]["Fine"]) do
            if v.label == type then
                price = v.price
                break
            end
        end

        xTarget.removeAccountMoney("bank", price)
        ESX.AddSocietyMoney("police", price)
        xTarget.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~.")
        xPlayer.showNotification("Vous avez donné une amende de "..price.."~g~$~s~")
        SendLogs("Facture", "Valestia | Facture", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient d'envoyer une facture de "..price.."$ au joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***) pour l'entreprise **Police** ", "https://discord.com/api/webhooks/1198453750684209202/SmtUOwCmR_0moJU_IKFpSkU9NhrFJpdp886R8MKgigJ6czT33F8LN3XuGKnUD8Zsayw4")
        SendLogs("Bill", "Valestia | Bill", ("%s %s (***%s***) vient d'envoyer une amende de **%s** $ à %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, price, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["police"]["send_bill"])
        return;
    end
    xPlayer.showNotification("Une erreur est survenue, lors de l'envoi de l'amende veuillez refaire la requête")
end)

RegisterNetEvent("vCore1:police:requestVehicleInfo", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then

        if xPlayer.job.name ~= "police" then
            xPlayer.ban(0, "(vCore1:police:requestVehicleInfo)")
            return
        end

        MySQL.Async.fetchAll("SELECT owner, vehicle FROM owned_vehicles WHERE plate = @plate", {
            ["@plate"] = plate
        }, function(result)
            local requestVehicleInfo = {
                plate = plate,
                owner = nil,
                vehicle = nil
            }

            if result[1] then
                MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier",  {
                    ["@identifier"] = result[1].owner
                }, function(result2)
                    requestVehicleInfo.owner = result2[1].firstname .. " " .. result2[1].lastname
                    requestVehicleInfo.vehicle = json.decode(result[1].vehicle)
                    TriggerClientEvent("vCore1:police:player:vehicleInfo", 1, requestVehicleInfo.plate, requestVehicleInfo.owner, requestVehicleInfo.vehicle)
                end)

            else
                TriggerClientEvent("vCore1:police:player:receiveVehicleInfo", 1, requestVehicleInfo.plate)
            end

        end)

    end
end)

local poundTimeout = {}
RegisterNetEvent("vCore1:police:putInPound", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then

        if xPlayer.job.name ~= "police" then
            xPlayer.ban(0, "(vCore1:police:putInPound)")
            return
        end

        if (not poundTimeout[xPlayer.identifier] or GetGameTimer() - poundTimeout[xPlayer.identifier] > 10000) then
            poundTimeout[xPlayer.identifier] = GetGameTimer()

            local playerCoord = GetEntityCoords(GetPlayerPed(source))
            local vehicle = {}

            for k,v in pairs(GetAllVehicles()) do
                local entityCoord = GetEntityCoords(v)
                local dist = #(playerCoord - entityCoord)

                if vehicle.dist == nil and DoesEntityExist(v) then
                    vehicle.dist = dist
                    vehicle.entity = v
                end

                if DoesEntityExist(v) and vehicle.dist > dist then
                    vehicle.dist = dist
                    vehicle.entity = v
                end
            end

            if vehicle.dist < 5 then
                DeleteEntity(vehicle.entity)
            end

        else
            xPlayer.showNotification("Vous devez attendre 10 secondes avant de faire appel à une dépanneuse à nouveau")
        end
    end
end)

local backupTimeout = {}
RegisterNetEvent("vCore1:police:callBackup", function(coords, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    if xPlayer and xPlayers then

        if xPlayer.job.name ~= "police" then
            xPlayer.ban(0, "(vCore1:police:callBackup)")
            return
        end

        if (not backupTimeout[xPlayer.identifier] or GetGameTimer() - backupTimeout[xPlayer.identifier] > 15000) then
            backupTimeout[xPlayer.identifier] = GetGameTimer()

            for i = 1, #xPlayers, 1 do
                local player = ESX.GetPlayerFromId(xPlayers[i]);
                if (player) then
                    if player.job.name == "police" then
                        TriggerClientEvent("vCore1:police:player:receiveBackupAlert", player.source, coords, type);
                    end
                end
            end
        else
            xPlayer.showNotification("Vous devez attendre 60 secondes avant de faire une demande à nouveau")
        end
    end
end)

RegisterNetEvent("vCore1:police:requestInventory", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "police" then
            xPlayer.ban(0, "(vCore1:police:requestInventory)")
            return
        end

        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then

            local data = {
                inventory = xTarget.getInventory(),
                accounts = xTarget.getAccounts(),
                weapons = xTarget.getLoadout()
            }

            xTarget.showNotification("Une personne est entrain de vous fouiller")
            TriggerClientEvent("vCore1:police:player:receiveInventory", source, data)

        end

    end
end)

RegisterNetEvent("vCore1:police:takeItem", function(target, type, itemName, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local society = "police"

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "police" then
            xPlayer.ban(0, "(vCore1:police:takeItem)")
            return
        end

        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then

            if type == "item" then
                local sourceItem = xTarget.getInventoryItem(itemName)
                if tonumber(amount) > 0 then
                    if (amount and tonumber(amount) and sourceItem and sourceItem.count and tonumber(sourceItem.count)) then
                        if sourceItem.count >= amount and amount > 0 then
                            exports["vCore3"]:AddSocietyItem(society, itemName, amount)
                            xTarget.removeInventoryItem(itemName, amount)
                            xTarget.showNotification("Une personne vous a pris "..amount.." objet(s) ("..Shared:ServerColorCode()..""..sourceItem.label.."~s~)")
                            xPlayer.showNotification("Vous avez confisqué "..amount.." objet(s) ("..Shared:ServerColorCode()..""..sourceItem.label.."~s~)")
                            SendLogs("Police", "Valestia | Police", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***)", "https://discord.com/api/webhooks/1198454272694698104/HmmY5pjt7GCHtur28-eaoKx25U-VIvoKQWLAIZBqn1bt5fgw7e6DX0ohZOMbD6nL1zCq")
                            SendLogs("TakeItem", "Valestia | TakeItem", ("%s %s (***%s***) vient de prendre **%s** ***%s*** sur %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, amount, sourceItem.label, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["police"]["take_items"])
                        else
                            xPlayer.showNotification("Quantité invalide")
                        end
                    end
                end
            end

            if type == "money" then
                local account = xTarget.getAccount(itemName)
                if tonumber(amount) > 1 then
                    if account and account.money >= amount then
                        xTarget.removeAccountMoney(itemName, amount)
                        exports["vCore3"]:AddSocietyDirtyMoney(society, amount)
                        xTarget.showNotification("Une personne vous a pris "..amount.." ~g~$ ~s~("..Shared:ServerColorCode().."argent sale~s~)")
                        xPlayer.showNotification("Vous avez confisqué "..amount.." ~g~$ ~s~("..Shared:ServerColorCode().."argent sale~s~)")
                        SendLogs("Police", "Valestia | Police", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***)", "https://discord.com/api/webhooks/1198454272694698104/HmmY5pjt7GCHtur28-eaoKx25U-VIvoKQWLAIZBqn1bt5fgw7e6DX0ohZOMbD6nL1zCq")
                        SendLogs("TakeMoney", "Valestia | TakeMoney", ("%s %s (***%s***) vient de prendre **%s** $ (argent sale) sur %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, amount, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["police"]["take_items"])
                    end
                end
            end

            if type == "weapon" then
                if (xTarget.hasWeapon(string.upper(itemName))) then
                    local hasWeapon, playerWeapon = xTarget.getWeapon(itemName)
                    if hasWeapon then
                        exports["vCore3"]:AddSocietyWeapon(society, playerWeapon)
                        xTarget.removeWeapon(itemName, 0)
                        xTarget.showNotification("Une personne vous a pris une arme ("..Shared:ServerColorCode()..""..playerWeapon.label.."~s~)")
                        xPlayer.showNotification("Vous avez confisqué une arme ("..Shared:ServerColorCode()..""..playerWeapon.label.."~s~)")
                        SendLogs("Police", "Valestia | Police", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***)", "https://discord.com/api/webhooks/1198454272694698104/HmmY5pjt7GCHtur28-eaoKx25U-VIvoKQWLAIZBqn1bt5fgw7e6DX0ohZOMbD6nL1zCq")
                        SendLogs("TakeWeapon", "Valestia | TakeWeapon", ("%s %s (***%s***) vient de prendre un **%s** sur %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, itemName, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["police"]["take_items"])
                    end
                end
            end

        end
    end
end)

RegisterNetEvent("vCore1:police:takeArmoryWeapon", function(weapon, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = GetPlayerPed(source)
	local coords = GetEntityCoords(player)
    local hasWeapon = xPlayer.hasWeapon(weapon)
    local correctWeapon = false

    if xPlayer then

        if xPlayer.job.name ~= "police" then
            xPlayer.ban(0, "(vCore1:police:takeArmoryWeapon) (job)")
            return
        end

        for k, v in pairs(Config["PoliceJob"]["ArmoryWeapon"]) do
            if weapon == v.weapon and label == v.label then
                correctWeapon = true
                break
            end
        end

        if correctWeapon then

            if #(coords - Config["PoliceJob"]["Armory"]) < 15 then

                if not hasWeapon then
                    xPlayer.addWeapon(weapon, 250)
                    xPlayer.addWeaponComponent(weapon, "flashlight")
                else
                    xPlayer.showNotification("Vous possédez déjà cette arme ("..label..")")
                end

            else
                xPlayer.ban(0, "(vCore1:police:takeArmoryWeapon) (coords)")
            end

        else
            xPlayer.ban(0, "(vCore1:police:takeArmoryWeapon) (correctWeapon)")
        end

    end
end)

AddEventHandler("playerDropped", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        for k, v in pairs(Config["PoliceJob"]["ArmoryWeapon"]) do
            if xPlayer.hasWeapon(v.weapon) then
                xPlayer.removeWeapon(v.weapon)
            end
        end
    end
end)

local spawnTimeout = {}
RegisterNetEvent("vCore1:police:spawnVehicle", function(model, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = GetPlayerPed(source)
	local coords = GetEntityCoords(player)
    local correctVehicle = false

    if xPlayer then

        if xPlayer.job.name ~= "police" then
            xPlayer.ban(0, "(vCore1:police:spawnVehicle) (job)")
            return
        end

        if (not spawnTimeout[xPlayer.identifier] or GetGameTimer() - spawnTimeout[xPlayer.identifier] > 10000) then
            spawnTimeout[xPlayer.identifier] = GetGameTimer()

            for k, v in pairs(Config["PoliceJob"]["GarageVehicle"]) do
                if model == v.vehicle and label == v.label then
                    correctVehicle = true
                    break
                end
            end

            if correctVehicle then

                if #(coords - Config["PoliceJob"]["Garage"]) < 15 then
                    -- TONIO HERE
                    ESX.SpawnVehicle(model, Config["PoliceJob"]["GarageSpawn"], Config["PoliceJob"]["GarageHeading"], nil, false, nil, function(vehicle)
                        TaskWarpPedIntoVehicle(player, vehicle, -1)
                    end)
                else
                    xPlayer.ban(0, "(vCore1:police:spawnVehicle) (coords)")
                end

            else
                xPlayer.ban(0, "(vCore1:police:spawnVehicle) (correctVehicle)")
            end

        else
            xPlayer.showNotification("Vous devez attendre 10 secondes avant de faire appel à un véhicule à nouveau")
        end

    end
end)

playerInCell = {}

RegisterNetEvent("vCore1:police:putInCell", function(target, position, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "police" then
            xPlayer.ban(0, "(vCore1:police:putInCell)")
            return
        end

        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
            if playerInCell[xTarget.identifier] == nil then
                TriggerClientEvent("vCore1:police:player:sendToCell", target, time*60, position.x, position.y, position.z)
                local currentTime = os.time()
                playerInCell[xTarget.identifier] = {}
                playerInCell[xTarget.identifier].time = time*60
                playerInCell[xTarget.identifier].entryTime = currentTime
                playerInCell[xTarget.identifier].position = position
                playerInCell[xTarget.identifier].job = "police"
                SendLogs("Cell", "Valestia | Cell", ("%s %s (***%s***) vient de mettre en cellule %s %s (***%s***) pour **%s** minutes"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier, time), Config["Log"]["Job"]["police"]["put_in_cell"])
            else
                xPlayer.showNotification("La personne est déjà en cellule")
            end
        end

    end
end)

RegisterNetEvent("vCore1:police:checkIsAllowed", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if playerInCell[xPlayer.identifier].isAllowed then
            playerInCell[xPlayer.identifier] = nil
            return true
        else
            xPlayer.ban(0, "(vCore1:police:checkCell)")
        end
    end
end)

RegisterNetEvent("vCore1:police:removeToCell", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "police" then
            xPlayer.ban(0, "(vCore1:police:removeToCell)")
            return
        end

        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then

            if playerInCell[xTarget.identifier] ~= nil then
                MySQL.Async.fetchAll("SELECT * FROM cell WHERE identifier = @identifier", {
                    ["@identifier"] = xTarget.identifier
                },function(result)
                    if result[1] then
                        MySQL.Async.execute("DELETE FROM cell WHERE identifier = @identifier", {
                            ["@identifier"] = xTarget.identifier,
                        })
                    end
                end)
                TriggerClientEvent("vCore1:"..playerInCell[xTarget.identifier].job..":player:removeToCell", target)
                playerInCell[xTarget.identifier] = {}
                playerInCell[xTarget.identifier].isAllowed = true
            else
                xPlayer.showNotification("La personne ne se trouve pas en cellule")
            end

        end

    end
end)

RegisterServerEvent("vCore1:police:onConnecting", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM cell WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.identifier
    },function(result)
        if result[1] then
            if tonumber(result[1].remainingTime) > 0 then
                TriggerClientEvent("vCore1:police:player:sendToCell", source, result[1].remainingTime, result[1].position_x, result[1].position_y, result[1].position_z)
                local position = vector3(result[1].position_x, result[1].position_y, result[1].position_z)

                playerInCell[xPlayer.identifier] = {}
                playerInCell[xPlayer.identifier].time = result[1].remainingTime
                playerInCell[xPlayer.identifier].entryTime = os.time()
                playerInCell[xPlayer.identifier].position = position
                playerInCell[xPlayer.identifier].job = result[1].job
            end
        end
    end)
end)

AddEventHandler("playerDropped", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if playerInCell[xPlayer.identifier] ~= nil then
            local currentTime = os.time()
            local timePassed = tonumber(currentTime) - tonumber(playerInCell[xPlayer.identifier].entryTime)
            local cellTime = playerInCell[xPlayer.identifier].time
            local x,y,z = table.unpack(playerInCell[xPlayer.identifier].position)
            local saveTime = cellTime - timePassed
            local job = playerInCell[xPlayer.identifier].job

            MySQL.Async.fetchAll("SELECT * FROM cell WHERE identifier = @identifier", {
                ["@identifier"] = xPlayer.identifier
            },function(result)
                if result[1] then
                    MySQL.Async.execute("UPDATE cell SET remainingTime = @remainingTime WHERE identifier = @identifier", {
                        ["@identifier"] = xPlayer.identifier,
                        ["@remainingTime"] = saveTime
                    })
                else
                    MySQL.Async.execute("INSERT INTO cell (identifier, remainingTime, position_x, position_y, position_z, job) VALUES (@identifier, @remainingTime, @position_x, @position_y, @position_z, @job)", {
                        ["@identifier"] = xPlayer.identifier,
                        ["@remainingTime"] = saveTime,
                        ["@position_x"] = x,
                        ["@position_y"] = y,
                        ["@position_z"] = z,
                        ["@job"] = job,

                    })
                end
            end)

            playerInCell[xPlayer.identifier] = nil

        end
    end
end)

exports["vCore3"]:RegisterCommand("uncell", function(xPlayer, args)
    local playerSelected = tonumber(args[1])
    local playerSelectedData = (xPlayer == nil or xPlayer.source ~= playerSelected) and ESX.GetPlayerFromId(playerSelected) or xPlayer

    if (playerSelectedData == nil) then
        return
    end

    if (playerInCell[playerSelectedData.identifier] ~= nil) then

        MySQL.Async.fetchAll("SELECT * FROM cell WHERE identifier = @identifier", {
            ["@identifier"] = playerSelectedData.identifier
        },function(result)
            if result[1] then
                MySQL.Async.execute("DELETE FROM cell WHERE identifier = @identifier", {
                    ["@identifier"] = playerSelectedData.identifier,
                })
            end
        end)

        playerInCell[playerSelectedData.identifier] = {}
        playerInCell[playerSelectedData.identifier].isAllowed = true
        TriggerClientEvent("vCore1:police:player:removeToCell", playerSelectedData.source)

    else
        if (xPlayer ~= nil) then
            xPlayer.showNotification("La personne ne se trouve pas en cellule")
        end
    end

    if (xPlayer ~= nil) then
		xPlayer.showNotification(("Vous avez retirer le joueur "..Shared:ServerColorCode().."%s~s~ de la cellule"):format(player_selected_data.getName()))
	end

end, {help = "Retirer un joueur de la cellule", params = {
	{name = "id", help = "Id du joueur"}}
}, {
	inMode = true,
	permission = "player_uncell"
})