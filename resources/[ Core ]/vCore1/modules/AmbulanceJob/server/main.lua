local playerDead = {}
local playerHasCall = {}

local function removeByIdentifier(tbl, identifier)
    for i = #tbl, 1, -1 do
        if tbl[i].player == identifier then
            local xPlayers = ESX.GetPlayers()
            table.remove(playerHasCall, i)
            for i = 1, #xPlayers, 1 do
                local player = ESX.GetPlayerFromId(xPlayers[i])
    
                if (player and player.job.name == "ambulance") then
                    TriggerClientEvent("vCore1:player:receiveCall", player.source, playerHasCall, false)
                end 
            end
        end
    end
end

AddEventHandler("vCore3:Valestia:playerRevived", function(src)

    local player = ESX.GetPlayerFromId(src)

    if (player) then

        if (playerDead[player.identifier] ~= nil) then

            if (playerDead[player.identifier].canRevive) then
                playerDead[player.identifier] = nil
                removeByIdentifier(playerHasCall, player.identifier)
                TriggerClientEvent("vCore1:player:DeadMenu", src, false)
            end

        end

    end

end)

AddEventHandler("vCore3:Valestia:playerDied", function(src)

    local player = ESX.GetPlayerFromId(src)

    if (player) then

        if (playerDead[player.identifier] == nil) then
            playerDead[player.identifier] = {}
            playerDead[player.identifier].timer = GetGameTimer()
            playerDead[player.identifier].isDead = true
            playerDead[player.identifier].canRevive = false
            TriggerClientEvent("vCore1:player:DeadMenu", src, true)

        end

    end

end)

RegisterNetEvent("vCore1:ambulance:heal", function(target, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local price = Config["AmbulanceJob"]["Price"][type]
    local targetPed = GetPlayerPed(target)
	local targetMaxHealth = GetEntityMaxHealth(targetPed)
	local targetHealth = GetEntityHealth(targetPed)

    if (xPlayer and xTarget) then

        if (xPlayer.job.name ~= "ambulance") then
            xPlayer.ban(0, "(vCore1:ambulance:heal)")
            return
        end

        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then

            if (type == "resuscitation") then

                if (playerDead[xTarget.identifier] ~= nil) then
                    if (playerDead[xTarget.identifier].isDead) then
                        playerDead[xTarget.identifier].canRevive = true
                    end
                else
                    xPlayer.showNotification("La personne n'est pas morte")
                    return
                end

            elseif (type == "small" or type == "big") then

                if (targetHealth >= targetMaxHealth) then
                    xPlayer.showNotification("La personne n'a pas besoin de soin")
                    return
                end

            end

            for k, v in pairs(Config["AmbulanceJob"]["PharmacyShop"]) do

                if (v.utility == type) then
                    if xPlayer.hasInventoryItem(v.item, 1) then
                        xPlayer.removeInventoryItem(v.item, 1)
                        break
                    else
                        xPlayer.showNotification(("Vous ne possédez pas de "..Shared:ServerColorCode().."%s~s~ sur vous"):format(v.label))
                        return
                    end
                end

            end

            TriggerClientEvent("vCore1:player:playAnimation", source, type)

            SetTimeout(10000, function()
                xTarget.removeAccountMoney("bank", price)
                ESX.AddSocietyMoney("ambulance", price)
                xTarget.showNotification(("Vous avez payé %s ~g~$~s~ pour le soin"):format(price))
                xPlayer.showNotification(("Vous avez fait une facture de %s ~g~$~s~ pour le soin effectuer"):format(price))
                TriggerClientEvent("vCore1:player:heal", target, type)
                SendLogs("Heal", "Valestia | Heal", ("%s %s (***%s***) vient d'éffectuer un soin pour **%s** $"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, price), Config["Log"]["Job"]["ambulance"]["heal_player"])
            end)

        end

    end

end)

RegisterNetEvent("vCore1:ambulance:check", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if (playerDead[xPlayer.identifier] ~= nil) then

            if (not playerDead[xPlayer.identifier].canRevive) then
                xPlayer.ban(0, "(vCore1:ambulance:check)")
            end

        end

    end

end)

callTimeOut = {}

RegisterNetEvent("vCore1:ambulance:callEmergency", function(coords)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    if (xPlayer and xPlayers) then
        if (not callTimeOut[xPlayer.identifier] or GetGameTimer() - callTimeOut[xPlayer.identifier] > Config["AmbulanceJob"]["RespawnTime"]*1000) then
            callTimeOut[xPlayer.identifier] = GetGameTimer()
            if (playerDead[xPlayer.identifier] ~= nil) then
                if (playerDead[xPlayer.identifier].isDead) then
                    table.insert(playerHasCall, {coords = coords, player = xPlayer.identifier})
                    for i = 1, #xPlayers, 1 do
                        local player = ESX.GetPlayerFromId(xPlayers[i]);

                        if (player) then
                            if (player.job.name == "ambulance") then
                                if exports["vCore1"]:GetPlayerInService(player.identifier) then
                                    TriggerClientEvent("vCore1:player:receiveCall", player.source, playerHasCall, true)
                                end
                            end
                            xPlayer.showNotification("Votre appel a été envoyé")
                        end
                    end
                else
                    xPlayer.ban(0, "(vCore1:ambulance:callEmergency)")
                end
            end
        else
            xPlayer.showNotification("Vous devez attendre avant de pouvoir appeler à nouveau")
        end
    end
end)

RegisterNetEvent("vCore1:ambulance:respawn", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerPosition = GetEntityCoords(GetPlayerPed(source))
    local closestDistance = -1
    local closestPosition = nil

    if (xPlayer) then

        if (playerDead[xPlayer.identifier] ~= nil) then

            if (GetGameTimer() - playerDead[xPlayer.identifier].timer > Config["AmbulanceJob"]["RespawnTime"]* 1000) then
                playerDead[xPlayer.identifier].canRevive = true

                for i, respawnPosition in ipairs(Config["AmbulanceJob"]["RespawnPosition"]) do
                    local distance = #(playerPosition - vector3(respawnPosition.x, respawnPosition.y, respawnPosition.z))

                    if closestDistance == -1 or distance < closestDistance then
                        closestDistance = distance
                        closestPosition = respawnPosition
                    end

                end

                xPlayer.onRevive()
                TriggerClientEvent("vCore1:player:heal", source, "respawn", closestPosition)
            else
                xPlayer.ban(0, "(vCore1:ambulance:respawn)")
            end

        end

    end
end)

RegisterNetEvent("vCore1:ambulance:removeCall", function(number)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    if (xPlayer and xPlayers) then
        for i = 1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])

            if (player and player.job.name == "ambulance") then
                table.remove(playerHasCall, number)
                TriggerClientEvent("vCore1:player:receiveCall", player.source, playerHasCall, false)
            end

        end
    end
end)

local carSpawnTimeout = {}

RegisterNetEvent("vCore1:ambulance:spawnVehicle", function(model, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = GetPlayerPed(source)
	local coords = GetEntityCoords(player)
    local correctVehicle = false

    if xPlayer then

        if (not carSpawnTimeout[xPlayer.identifier] or GetGameTimer() - carSpawnTimeout[xPlayer.identifier] > 10000) then
            carSpawnTimeout[xPlayer.identifier] = GetGameTimer()

            if xPlayer.job.name ~= "ambulance" then
                xPlayer.ban(0, "(vCore1:ambulance:spawnVehicle)")
                return
            end

            for k, v in pairs(Config["AmbulanceJob"]["GarageVehicle"] ) do
                if model == v.vehicle and label == v.label then
                    correctVehicle = true
                    break
                end
            end

            if correctVehicle then

                if #(coords - Config["AmbulanceJob"]["Garage"]) < 10 then
                    print("good")
                    -- ESX.SpawnVehicle(model, Config["AmbulanceJob"]["GarageSpawn"], Config["AmbulanceJob"]["GarageHeading"], nil, false, nil, function(vehicle)
                    --     TaskWarpPedIntoVehicle(player, vehicle, -1)
                    -- end)
                else
                    xPlayer.ban(0, "(vCore1:ambulance:spawnVehicle)")
                end

            else
                xPlayer.ban(0, "(vCore1:ambulance:spawnVehicle)")
            end

        else
            xPlayer.showNotification("Vous devez attendre avant de spawn une nouvelle voiture")
        end

    end
end)

RegisterNetEvent("vCore1:ambulance:buyItem", function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0

    if (xPlayer) then

        if (xPlayer.job.name ~= "ambulance") then
            xPlayer.ban(0, "(vCore1:ambulance:buyItem)")
            return
        end

        for i = 1, #Config["AmbulanceJob"]["PharmacyShop"] do

            if (Config["AmbulanceJob"]["PharmacyShop"][i].item == item) then
                price = Config["AmbulanceJob"]["PharmacyShop"][i].price
                price = price * count
                break
            end

        end

        if (price > 0) then

            local society = ESX.DoesSocietyExist("ambulance")

            if (society) then

                local societyMoney = ESX.GetSocietyMoney("ambulance")

                if (societyMoney >= price) then
                    if xPlayer.canCarryItem(item, count) then
                        ESX.RemoveSocietyMoney("ambulance", tonumber(price));
                        xPlayer.addInventoryItem(item, count)
                        xPlayer.showNotification(("L'entreprise a payé %s ~g~$~s~ pour l'achat de %s"):format(price, item))
                        SendLogs("PharmacyShop", "Valestia | PharmacyShop", ("%s %s (***%s***) vient d'acheter **%s** pour **%s** $"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, item, price), Config["Log"]["Job"]["ambulance"]["buy_pharmacy"])
                    else
                        xPlayer.showNotification("Vous n'avez pas assez de place dans votre inventaire")
                    end
                else
                    xPlayer.showNotification("L'entreprise ne possède pas assez d'argent")
                end

            else
                xPlayer.showNotification("error_ambulance_242: veuillez contacter un administrateur")
            end

        else
            xPlayer.ban(0, "(vCore1:ambulance:buyItem)")
        end

    end

end)

local callTimeoutNPC = {}

RegisterNetEvent("vCore1:ambulance:buyNPC", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config["AmbulanceJob"]["Price"]["big"]
    local Ped = GetPlayerPed(source)
	local MaxHealth = GetEntityMaxHealth(Ped)
	local Health = GetEntityHealth(Ped)
    local isDead = false

    if (xPlayer) then

        if (Health >= MaxHealth) then
            xPlayer.showNotification("Vous avez pas besoin de soin")
            return
        end

        if (not callTimeoutNPC[xPlayer.identifier] or GetGameTimer() - callTimeoutNPC[xPlayer.identifier] > Config["AmbulanceJob"]["RespawnTime"]*1000) then
            callTimeoutNPC[xPlayer.identifier] = GetGameTimer()

            if #(GetEntityCoords(GetPlayerPed(source)) - Config["AmbulanceJob"]["DoctorPed"]) < 10.0 then

                if (playerDead[xPlayer.identifier]) then

                    if (playerDead[xPlayer.identifier].isDead) then
                        playerDead[xPlayer.identifier].canRevive = true
                        isDead = true
                        price = Config["AmbulanceJob"]["Price"]["resuscitation"]
                    end

                end

                if xPlayer.getAccount('bank').money >= price then

                    if isDead then
                        TriggerClientEvent("vCore1:player:heal", source, "respawn", Config["AmbulanceJob"]["RespawnDoctorPosition"])
                    else
                        TriggerClientEvent("vCore1:player:heal", source, "big")
                    end

                    xPlayer.removeAccountMoney('bank', price)
                    xPlayer.showNotification(("Vous avez payer %s ~g~$~s~ pour le soin"):format(price))

                else
                    xPlayer.showNotification("Vous n'avez pas assez d'argent sur vous")
                end

            end

        else
            xPlayer.showNotification("Vous devez attendre avant de pouvoir appeler à nouveau")
        end

    end
end)

local TimeoutJail = {}

RegisterNetEvent("vCore1:ambulance:jailRevive", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if (not TimeoutJail[xPlayer.identifier] or GetGameTimer() - TimeoutJail[xPlayer.identifier] > 60000) then
            TimeoutJail[xPlayer.identifier] = GetGameTimer()

            if #(GetEntityCoords(GetPlayerPed(source)) - vector3(956.63323974609, 24.14598274231, 116.16425323486)) < 700.0 then

                if (playerDead[xPlayer.identifier] ~= nil) then

                    if (playerDead[xPlayer.identifier].isDead) then
                        playerDead[xPlayer.identifier].canRevive = true
                        TriggerClientEvent("vCore1:player:heal", source, "resuscitation")
                    end

                end

            else
                xPlayer.ban(0, '(vCore1:ambulance:jailRevive)')
            end

        else
            xPlayer.showNotification("Veuillez attendre avant d'utiliser cette fonction à nouveau")
        end

    end

end)

AddEventHandler("playerDropped", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if (playerDead[xPlayer.identifier] ~= nil) then
            removeByIdentifier(playerHasCall, xPlayer.identifier)
            playerDead[xPlayer.identifier] = nil
        end

    end
end)

ESX.RegisterUsableItem('medikit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if (xPlayer) then

		xPlayer.removeInventoryItem('medikit', 1)
        TriggerClientEvent("vCore1:player:heal", source, "big")
		xPlayer.showNotification("Vous avez été soigné")

	end

end)

ESX.RegisterUsableItem('bandage', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if (xPlayer) then

		xPlayer.removeInventoryItem('bandage', 1)
        TriggerClientEvent("vCore1:player:heal", source, "small")
        xPlayer.showNotification("Vous avez été soigné")

	end

end)

exports["vCore3"]:RegisterCommand("revive", function(xPlayer, args)
    local playerSelected = tonumber(args[1])
    local playerSelectedData = (xPlayer == nil or xPlayer.source ~= playerSelected) and ESX.GetPlayerFromId(playerSelected) or xPlayer

    if (playerSelectedData == nil) then
        return
    end

    if (playerDead[playerSelectedData.identifier] ~= nil) then

        if (playerDead[playerSelectedData.identifier].isDead == true) then
            playerDead[playerSelectedData.identifier].canRevive = true

            playerSelectedData.triggerEvent("vCore1:player:heal", "resuscitation")
            SendLogs("Revive", "Valestia | Revive", ("___%s___ vient de faire revivre ***%s***."):format(((xPlayer ~= nil and xPlayer.getName()) or "Console"), playerSelectedData.getName()), "https://discord.com/api/webhooks/1226952666551291944/bu6PAvZReEgy5ueYVJteSq4rHMhiSjubz89WAd26d5xr4tWkiV2uvSQ2GZKqMhWRIENJ")

            playerSelectedData.setHurt(false)

            if (xPlayer ~= nil) then
                xPlayer.showNotification(("Vous avez revive le joueur "..Shared:ServerColorCode().."%s~s~."):format(playerSelectedData.getName()))
            end

        else

            if (xPlayer ~= nil) then
                xPlayer.showNotification(("Le joueur "..Shared:ServerColorCode().."%s~s~ n'est pas mort."):format(playerSelectedData.getName()))
            end

        end

    else
        if (xPlayer ~= nil) then
            xPlayer.showNotification(("Le joueur "..Shared:ServerColorCode().."%s~s~ n'est pas mort."):format(playerSelectedData.getName()))
        end
    end

end, {help = "Faire revivre un joueur", params = {
    {name = "id", help = "Id du joueur"}}
}, {
    inMode = true
})

exports["vCore3"]:RegisterCommand("heal", function(xPlayer, args)
    local playerSelected = tonumber(args[1])
    local playerSelectedData = (xPlayer == nil or xPlayer.source ~= playerSelected) and ESX.GetPlayerFromId(playerSelected) or xPlayer

    if (playerSelectedData == nil) then
		return
	end

    if (playerDead[playerSelectedData.identifier] == nil) then

        playerSelectedData.triggerEvent("vCore1:player:heal", "big")
        playerSelectedData.setHurt(false)

        playerSelectedData.showNotification("Vous avez été soigné.")
        xPlayer.showNotification(("Vous avez soigné "..Shared:ServerColorCode().."%s~s~."):format(playerSelectedData.getName()))
        SendLogs("Heal", "Valestia | Heal", ("___%s___ vient de soigner ***%s***."):format(xPlayer.getName(), playerSelectedData.getName()), "https://discord.com/api/webhooks/1226952810285760603/wro6O6ISLV2jK9TRX3xvdMPTb-aGW7qyNTdw6aGZcOglAJvIvjrUvBI9chIfifkz3DaY")

    else
        if (xPlayer ~= nil) then
            xPlayer.showNotification(("Le joueur "..Shared:ServerColorCode().."%s~s~ est mort."):format(playerSelectedData.getName()))
        end
    end

end, {help = "Heal un joueur", params = {
	{name = "id", help = "Id du joueur, qui va être soigné"}}
}, {
	inMode = true
})

exports["vCore3"]:RegisterCommand("revivezone", function(xPlayer, args)
    local players = GetPlayers()
    local count = 0

    args[1] = args[1] ~= nil and tonumber(args[1]) or 10

    if (xPlayer) then

        if (tonumber(args[1]) <= 500 and tonumber(args[1]) >= 0) then

            for i = 1, #players do
                local targetPlayers = ESX.GetPlayerFromId(players[i])

                if (targetPlayers) then
                    local coords = GetEntityCoords(GetPlayerPed(players[i]))
					local distance = #(coords - xPlayer.getCoords())

                    if (distance <= tonumber(args[1])) then

                        if (playerDead[targetPlayers.identifier] ~= nil) then

                            if (playerDead[targetPlayers.identifier].isDead == true) then

                                playerDead[targetPlayers.identifier].canRevive = true
                                count = count + 1
                                targetPlayers.triggerEvent("vCore1:player:heal", "resuscitation")
                                targetPlayers.setHurt(false)

                            end

						end

                    end

                end

            end

            if (count > 0) then
                xPlayer.showNotification(("Vous venez de revive "..Shared:ServerColorCode().."%s joueur(s)~h~ dans ce rayon"):format(count))
				SendLogs("ReviveZone", "Valestia | ReviveZone", "**"..admin.getName().."** vient de revive **"..count.."** joueurs", "https://discord.com/api/webhooks/1226952973784187020/F8fP_SRCvyzqfnFZVyB8SwpCIf6WhiJqMxbJEEYlhmZ76lWne2z54S5ZKadeCFhscEsN")
            end

        else
			xPlayer.showNotification("Veuillez saisir un nombre entre 0 et 500");
		end
    end
end, {help = "Faire revivre tout les joueurs d'une zone", params = {
    {name = "radius", help = "Rayon dans lequel cette action va s'effectuer"}}
}, {
    inMode = true
})

exports["vCore3"]:RegisterCommand("slay", function(xPlayer, args)
    local playerSelected = tonumber(args[1])
    local playerSelectedData = (xPlayer == nil or xPlayer.source ~= playerSelected) and ESX.GetPlayerFromId(playerSelected) or xPlayer

    if (playerSelectedData == nil) then
        return
    elseif (xPlayer ~= nil and xPlayer.source ~= playerSelectedData.source and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), playerSelectedData.getGroup())) then
        return
    end

    playerSelectedData.triggerEvent("vCore1:player:heal", "slay")

    if (xPlayer ~= nil) then
		xPlayer.showNotification(("Vous avez slay le joueur "..Shared:ServerColorCode().."%s~s~"):format(player_selected_data.getName()))
	end

end, {help = "Tuer un joueur", params = {
	{name = "id", help = "Id du joueur"}}
}, {
	inMode = true,
	permission = "player_slay"
})