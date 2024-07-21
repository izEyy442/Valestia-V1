RegisterNetEvent("vCore1:fib:handcuff", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name == "fib" then

            if (target ~= -1 and xTarget) then

                if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
                    TriggerClientEvent("vCore1:fib:player:handcuff", target)
                end

            end

        else
            xPlayer.ban(0, "(vCore1:fib:handcuff)")
        end
    end
end)

RegisterNetEvent("vCore1:fib:escort", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name == "fib" then

            if (target ~= -1 and xTarget) then

                if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
                    TriggerClientEvent("vCore1:fib:player:escort", target, source)
                end

            end

        else
            xPlayer.ban(0, "(vCore1:fib:escort)")
        end
    end
end)

RegisterNetEvent("vCore1:fib:putInVehicle", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name == "fib" then

            if (target ~= -1 and xTarget) then

                if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
                    TriggerClientEvent("vCore1:fib:player:putInVehicle", target)
                end

            end

        else
            xPlayer.ban(0, "(vCore1:fib:putInVehicule)")
        end
    end
end)

RegisterNetEvent("vCore1:fib:putOutVehicle", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name == "fib" then

            if (target ~= -1 and xTarget) then

                if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
                    TriggerClientEvent("vCore1:fib:player:putOutVehicle", target)
                end

            end

        else
            xPlayer.ban(0, "(vCore1:fib:putInVehicule)")
        end
    end
end)

RegisterNetEvent("vCore1:fib:sendFine", function(target, type)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromId(target)
	local price = 0

    if (not xPlayer) then return; end
    if (not xTarget) then return; end

    if xPlayer.job.name ~= "fib" then
        xPlayer.ban(0, "(vCore1:fib:sendFine)")
        return
    end

    local society = ESX.DoesSocietyExist("fib")
    if (not society) then return; end

    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then

        for k, v in pairs(Config["FibJob"]["Fine"]) do
            if v.label == type then
                price = v.price
                break
            end
        end

        xTarget.removeAccountMoney("bank", price)
        ESX.AddSocietyMoney("fib", price)
        xTarget.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~.")
        xPlayer.showNotification("Vous avez donné une amende de "..price.."~g~$~s~")
        SendLogs("Facture", "Valestia | Facture", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient d'envoyer une facture de "..price.."$ au joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***) pour l'entreprise **FibJob** ", "https://discord.com/api/webhooks/1226953577998716958/9Etq90iDb2huXv1kcKs4qfDPegKL6MThBGu-szbvYh31bBXVkm9L-oXZLJbxvea1IOjE")
        SendLogs("Bill", "Valestia | Bill", ("%s %s (***%s***) vient d'envoyer une amende de **%s** $ à %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, price, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["fib"]["send_bill"])
        return;
    end
    xPlayer.showNotification("Une erreur est survenue, lors de l'envoi de l'amende veuillez refaire la requête")
end)

RegisterNetEvent("vCore1:fib:requestVehicleInfo", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then

        if xPlayer.job.name ~= "fib" then
            xPlayer.ban(0, "(vCore1:fib:requestVehicleInfo)")
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
                    TriggerClientEvent("vCore1:fib:player:vehicleInfo", 1, requestVehicleInfo.plate, requestVehicleInfo.owner, requestVehicleInfo.vehicle)
                end)

            else
                TriggerClientEvent("vCore1:fib:player:receiveVehicleInfo", 1, requestVehicleInfo.plate)
            end

        end)

    end
end)

local poundTimeout = {}
RegisterNetEvent("vCore1:fib:putInPound", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then

        if xPlayer.job.name ~= "fib" then
            xPlayer.ban(0, "(vCore1:fib:putInPound)")
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
RegisterNetEvent("vCore1:fib:callBackup", function(coords, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    if xPlayer and xPlayers then

        if xPlayer.job.name ~= "fib" then
            xPlayer.ban(0, "(vCore1:fib:callBackup)")
            return
        end

        if (not backupTimeout[xPlayer.identifier] or GetGameTimer() - backupTimeout[xPlayer.identifier] > 15000) then
            backupTimeout[xPlayer.identifier] = GetGameTimer()

            for i = 1, #xPlayers, 1 do
                local player = ESX.GetPlayerFromId(xPlayers[i])
                if player and player.job.name == "fib" then
                    TriggerClientEvent("vCore1:fib:player:receiveBackupAlert", player.source, coords, type);
                end
            end

        else
            xPlayer.showNotification("Vous devez attendre 60 secondes avant de faire une demande à nouveau")
        end
    end
end)

RegisterNetEvent("vCore1:fib:requestInventory", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "fib" then
            xPlayer.ban(0, "(vCore1:fib:requestInventory)")
            return
        end

        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then

            local data = {
                inventory = xTarget.getInventory(),
                accounts = xTarget.getAccounts(),
                weapons = xTarget.getLoadout()
            }

            xTarget.showNotification("Une personne est entrain de vous fouiller")
            TriggerClientEvent("vCore1:fib:player:receiveInventory", source, data)

        end

    end
end)

RegisterNetEvent("vCore1:fib:takeItem", function(target, type, itemName, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local society = "fib"

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "fib" then
            xPlayer.ban(0, "(vCore1:fib:takeItem)")
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
                            SendLogs("Fib", "Valestia | Fib", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***)", "https://discord.com/api/webhooks/1226949566075768883/YXYeHp0j0wQvHI2_jIDgiltGFti7rZYiNI6-vgdqnJQys_ztHJv1ZtT_uVqYrvrXgEkb")
                            SendLogs("TakeItem", "Valestia | TakeItem", ("%s %s (***%s***) vient de prendre **%s** ***%s*** sur %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, amount, sourceItem.label, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["fib"]["take_items"])
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
                        SendLogs("Fib", "Valestia | Fib", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***)", "https://discord.com/api/webhooks/1226949566075768883/YXYeHp0j0wQvHI2_jIDgiltGFti7rZYiNI6-vgdqnJQys_ztHJv1ZtT_uVqYrvrXgEkb")
                        SendLogs("TakeMoney", "Valestia | TakeMoney", ("%s %s (***%s***) vient de prendre **%s** $ (argent sale) sur %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, amount, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["fib"]["take_items"])
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
                        SendLogs("Fib", "Valestia | Fib", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***)", "https://discord.com/api/webhooks/1226949566075768883/YXYeHp0j0wQvHI2_jIDgiltGFti7rZYiNI6-vgdqnJQys_ztHJv1ZtT_uVqYrvrXgEkb")
                        SendLogs("TakeWeapon", "Valestia | TakeWeapon", ("%s %s (***%s***) vient de prendre un **%s** sur %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, itemName, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["fib"]["take_items"])
                    end
                end
            end

        end
    end
end)

RegisterNetEvent("vCore1:fib:takeArmoryWeapon", function(weapon, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = GetPlayerPed(source)
	local coords = GetEntityCoords(player)
    local hasWeapon = xPlayer.hasWeapon(weapon)
    local correctWeapon = false

    if xPlayer then

        if xPlayer.job.name ~= "fib" then
            xPlayer.ban(0, "(vCore1:fib:takeArmoryWeapon) (job)")
            return
        end

        for k, v in pairs(Config["FibJob"]["ArmoryWeapon"]) do
            if weapon == v.weapon and label == v.label then
                correctWeapon = true
                break
            end
        end

        if correctWeapon then

            if #(coords - Config["FibJob"]["Armory"]) < 15 then

                if not hasWeapon then
                    xPlayer.addWeapon(weapon, 250)
                    xPlayer.addWeaponComponent(weapon, "flashlight")
                else
                    xPlayer.showNotification("Vous possédez déjà cette arme ("..label..")")
                end

            else
                xPlayer.ban(0, "(vCore1:fib:takeArmoryWeapon) (coords)")
            end

        else
            xPlayer.ban(0, "(vCore1:fib:takeArmoryWeapon) (correctWeapon)")
        end

    end
end)

AddEventHandler("playerDropped", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        for k, v in pairs(Config["FibJob"]["ArmoryWeapon"]) do
            if xPlayer.hasWeapon(v.weapon) then
                xPlayer.removeWeapon(v.weapon)
            end
        end
    end
end)

local spawnTimeout = {}
RegisterNetEvent("vCore1:fib:spawnVehicle", function(model, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = GetPlayerPed(source)
	local coords = GetEntityCoords(player)
    local correctVehicle = false

    if xPlayer then

        if xPlayer.job.name ~= "fib" then
            xPlayer.ban(0, "(vCore1:fib:spawnVehicle) (job)")
            return
        end

        if (not spawnTimeout[xPlayer.identifier] or GetGameTimer() - spawnTimeout[xPlayer.identifier] > 10000) then
            spawnTimeout[xPlayer.identifier] = GetGameTimer()

            for k, v in pairs(Config["FibJob"]["GarageVehicle"]) do
                if model == v.vehicle and label == v.label then
                    correctVehicle = true
                    break
                end
            end

            if correctVehicle then

                if #(coords - Config["FibJob"]["Garage"]) < 10 then
                    -- TONIO HERE
                    ESX.SpawnVehicle(model, Config["FibJob"]["GarageSpawn"], Config["FibJob"]["GarageHeading"], nil, false, nil, function(vehicle)
                        TaskWarpPedIntoVehicle(player, vehicle, -1)
                    end)
                else
                    xPlayer.ban(0, "(vCore1:fib:spawnVehicle) (coords)")
                end

            else
                xPlayer.ban(0, "(vCore1:fib:spawnVehicle) (correctVehicle)")
            end

        else
            xPlayer.showNotification("Vous devez attendre 10 secondes avant de faire appel à un véhicule à nouveau")
        end

    end
end)

RegisterNetEvent("vCore1:fib:putInCell", function(target, position, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "fib" then
            xPlayer.ban(0, "(vCore1:fib:putInCell)")
            return
        end

        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then
            if playerInCell[xTarget.identifier] == nil then
                TriggerClientEvent("vCore1:fib:player:sendToCell", target, time*60, position.x, position.y, position.z)
                local currentTime = os.time()
                playerInCell[xTarget.identifier] = {}
                playerInCell[xTarget.identifier].time = time*60
                playerInCell[xTarget.identifier].entryTime = currentTime
                playerInCell[xTarget.identifier].position = position
                playerInCell[xTarget.identifier].job = "fib"
                SendLogs("Cell", "Valestia | Cell", ("%s %s (***%s***) vient de mettre en cellule %s %s (***%s***) pour **%s** minutes"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier, time), Config["Log"]["Job"]["fib"]["put_in_cell"])
            else
                xPlayer.showNotification("La personne est déjà en cellule")
            end
        end

    end
end)

RegisterNetEvent("vCore1:fib:checkIsAllowed", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if playerInCell[xPlayer.identifier].isAllowed then
            playerInCell[xPlayer.identifier] = nil
            return true
        else
            xPlayer.ban(0, "(vCore1:fib:checkCell)")
        end
    end
end)

RegisterNetEvent("vCore1:fib:removeToCell", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "fib" then
            xPlayer.ban(0, "(vCore1:fib:removeToCell)")
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

                TriggerClientEvent("vCore1:fib:player:removeToCell", target)
                playerInCell[xTarget.identifier] = {}
                playerInCell[xTarget.identifier].isAllowed = true
            else
                xPlayer.showNotification("La personne ne se trouve pas en cellule")
            end

        end

    end
end)

RegisterServerEvent("vCore1:fib:onConnecting", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM cell WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.identifier
    },function(result)
        if result[1] then
            if tonumber(result[1].remainingTime) > 0 then
                TriggerClientEvent("vCore1:fib:player:sendToCell", source, result[1].remainingTime, result[1].position_x, result[1].position_y, result[1].position_z)
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