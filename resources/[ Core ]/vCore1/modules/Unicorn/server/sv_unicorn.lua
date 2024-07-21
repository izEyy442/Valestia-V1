local TimeoutJob = {};

RegisterServerEvent('CoreVrmtUhq:unicorn:sendOpenAnnounce')
AddEventHandler('CoreVrmtUhq:unicorn:sendOpenAnnounce', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "unicorn" then
            xPlayer.ban(0, '(CoreVrmtUhq:unicorn:sendOpenAnnounce)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showNotification', xPlayers[i], "Le Vanilla Unicorn est Ouvert")
        end
    else
		xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('CoreVrmtUhq:unicorn:sendCloseAnnounce')
AddEventHandler('CoreVrmtUhq:unicorn:sendCloseAnnounce', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
        TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "unicorn" then
            xPlayer.ban(0, '(CoreVrmtUhq:unicorn:sendCloseAnnounce)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showNotification', xPlayers[i], "Le Vanilla Unicorn est Fermé")
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('CoreVrmtUhq:unicorn:sendRecruitAnnounce')
AddEventHandler('CoreVrmtUhq:unicorn:sendRecruitAnnounce', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
        TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "unicorn" then
            xPlayer.ban(0, '(CoreVrmtUhq:unicorn:sendRecruitAnnounce)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showNotification', xPlayers[i], "Le Vanilla Unicorn Recrute")
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('CoreVrmtUhq:unicorn:sendCustomAnnounce')
AddEventHandler('CoreVrmtUhq:unicorn:sendCustomAnnounce', function(text)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
        TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "unicorn" then
            xPlayer.ban(0, '(CoreVrmtUhq:unicorn:sendCustomAnnounce)');
            return
        end
        for i=1, #xPlayers, 1 do
            TriggerClientEvent('esx:showNotification', xPlayers[i], "Vanilla Unicorn : "..text)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterNetEvent("CoreVrmtUhq:unicorn:buyItem", function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0

    if (xPlayer) then

        if (xPlayer.job.name ~= "unicorn") then
            xPlayer.ban(0, "(CoreVrmtUhq:unicorn:buyItem)")
            return
        end

        for i = 1, #Config["Unicorn"]["UnicornBarShop"] do

            if (Config["Unicorn"]["UnicornBarShop"][i].item == item) then
                price = Config["Unicorn"]["UnicornBarShop"][i].price
                count = 1
                break
            end

        end

        if (price > 0) then

            local society = ESX.DoesSocietyExist("unicorn")

            if (society) then

                local societyMoney = ESX.GetSocietyMoney("unicorn")

                if (societyMoney >= price) then
                    if xPlayer.canCarryItem(item, count) then
                        ESX.RemoveSocietyMoney("unicorn", tonumber(price));
                        xPlayer.addInventoryItem(item, count)
                        xPlayer.showNotification(("L'entreprise a payé %s ~g~$~s~ pour l'achat de %s"):format(price, item))
                    else
                        xPlayer.showNotification("Vous n'avez pas assez de place dans votre inventaire")
                    end
                else
                    xPlayer.showNotification("L'entreprise ne possède pas assez d'argent")
                end

            else
                xPlayer.showNotification("error_unicorn_242: veuillez contacter un administrateur")
            end

        else
            xPlayer.ban(0, "(CoreVrmtUhq:unicorn:buyItem)")
        end

    end

end)

RegisterServerEvent('unicorn:payWeapon')
AddEventHandler('unicorn:payWeapon', function(name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= "unicorn" then
        xPlayer.ban(0, '(unicorn:payWeapon)');
        return
    end 
    if xPlayer.hasWeapon(name) then
        xPlayer.showNotification("Vous avez déjà cette arme sur vous")
    else
        xPlayer.addWeapon(name, 250)
        xPlayer.showNotification("Vous avez bien récupéré votre arme")
    end

end)

RegisterNetEvent("CoreVrmtUhq:unicorn:takeVest")
AddEventHandler("CoreVrmtUhq:unicorn:takeVest", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then

        if xPlayer.job.name ~= "unicorn" then
            xPlayer.ban(0, "(CoreVrmtUhq:unicorn:takeVest)")
            return
        end

        if xPlayer.getInventoryItem("kevlar").count <= 0 then
            xPlayer.addInventoryItem("kevlar", 1)
            xPlayer.showNotification("Vous avez bien récupéré votre gilet par balle")
        else
            xPlayer.showNotification("Vous avez déjà un gilet par balle")
        end

    end
end)

AddEventHandler("playerDropped", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        for k, v in pairs(Config["Unicorn"]["ArmoryWeapon"]) do
            if xPlayer.hasWeapon(v.weapon) then
                xPlayer.removeWeapon(v.weapon)
            end
        end
    end
end)

local spawnTimeout = {}

RegisterNetEvent("CoreVrmtUhq:unicorn:spawnVehicle", function(model, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = GetPlayerPed(source)
	local coords = GetEntityCoords(player)
    local correctVehicle = false

    if xPlayer then

        if xPlayer.job.name ~= "unicorn" then
            xPlayer.ban(0, "(CoreVrmtUhq:unicorn:spawnVehicle) (job)")
            return
        end

        if (not spawnTimeout[xPlayer.identifier] or GetGameTimer() - spawnTimeout[xPlayer.identifier] > 10000) then
            spawnTimeout[xPlayer.identifier] = GetGameTimer()

            for k, v in pairs(Config["Unicorn"]["GarageVehicle"]) do
                if model == v.vehicle and label == v.label then
                    correctVehicle = true
                    break
                end
            end

            if correctVehicle then

                if #(coords - Config["Unicorn"]["Garage"]) < 15 then
                    ESX.SpawnVehicle(model, Config["Unicorn"]["GarageSpawn"], Config["Unicorn"]["GarageHeading"], nil, false, nil, function(vehicle)
                        TaskWarpPedIntoVehicle(player, vehicle, -1)
                    end)
                else
                    xPlayer.ban(0, "(CoreVrmtUhq:unicorn:spawnVehicle) (coords)")
                end

            else
                xPlayer.ban(0, "(CoreVrmtUhq:unicorn:spawnVehicle) (correctVehicle)")
            end

        else
            xPlayer.showNotification("Vous devez attendre 10 secondes avant de faire appel à un véhicule à nouveau")
        end

    end
end)

RegisterNetEvent("CoreVrmtUhq:unicorn:requestInventory", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "unicorn" then
            xPlayer.ban(0, "(CoreVrmtUhq:unicorn:requestInventory)")
            return
        end

        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 10.0 then

            local data = {
                inventory = xTarget.getInventory(),
                accounts = xTarget.getAccounts(),
                weapons = xTarget.getLoadout()
            }

            xTarget.showNotification("Une personne est entrain de vous fouiller")
            TriggerClientEvent("CoreVrmtUhq:unicorn:player:receiveInventory", source, data)

        end

    end
end)

RegisterNetEvent("CoreVrmtUhq:unicorn:takeItem", function(target, type, itemName, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local society = "unicorn"

    if xPlayer and xTarget then

        if xPlayer.job.name ~= "unicorn" then
            xPlayer.ban(0, "(CoreVrmtUhq:unicorn:takeItem)")
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
                            SendLogs("Unicorn", "Valestia | Unicorn", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***)", "https://discord.com/api/webhooks/1226949566075768883/YXYeHp0j0wQvHI2_jIDgiltGFti7rZYiNI6-vgdqnJQys_ztHJv1ZtT_uVqYrvrXgEkb")
                            SendLogs("TakeItem", "Valestia | TakeItem", ("%s %s (***%s***) vient de prendre **%s** ***%s*** sur %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, amount, sourceItem.label, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["unicorn"]["take_items"])
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
                        SendLogs("Unicorn", "Valestia | Unicorn", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***)", "https://discord.com/api/webhooks/1226949566075768883/YXYeHp0j0wQvHI2_jIDgiltGFti7rZYiNI6-vgdqnJQys_ztHJv1ZtT_uVqYrvrXgEkb")
                        SendLogs("TakeMoney", "Valestia | TakeMoney", ("%s %s (***%s***) vient de prendre **%s** $ (argent sale) sur %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, amount, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["unicorn"]["take_items"])
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
                        SendLogs("Unicorn", "Valestia | Unicorn", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***)", "https://discord.com/api/webhooks/1226949566075768883/YXYeHp0j0wQvHI2_jIDgiltGFti7rZYiNI6-vgdqnJQys_ztHJv1ZtT_uVqYrvrXgEkb")
                        SendLogs("TakeWeapon", "Valestia | TakeWeapon", ("%s %s (***%s***) vient de prendre un **%s** sur %s %s (***%s***)"):format(xPlayer.getLastName(), xPlayer.getFirstName(), xPlayer.identifier, itemName, xTarget.getLastName(), xTarget.getFirstName(), xTarget.identifier), Config["Log"]["Job"]["unicorn"]["take_items"])
                    end
                end
            end

        end
    end
end)

RegisterNetEvent('CoreVrmtUhq:unicorn:startDance')
AddEventHandler('CoreVrmtUhq:unicorn:startDance', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if xPlayer.job.name ~= "unicorn" then
            xPlayer.ban(0, '(CoreVrmtUhq:unicorn:startDance)');
            return
        end

        if (not isDancing) then
            isDancing = true
            TriggerClientEvent('CoreVrmtUhq:Unicorn:StartStrip', -1)
            xPlayer.showNotification("La striptiseuse rentre en scène")
        else
            xPlayer.showNotification("La striptiseuse est déjà en train de danser")
        end

    end

end)

RegisterNetEvent('CoreVrmtUhq:Unicorn:StopStrip')
AddEventHandler('CoreVrmtUhq:Unicorn:StopStrip', function()

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "unicorn" then
        xPlayer.ban(0, '(CoreVrmtUhq:Unicorn:StopDance)');
        return
    end

    if (isDancing) then
        isDancing = false
        TriggerClientEvent('CoreVrmtUhq:Unicorn:StopStrip', -1)
        xPlayer.showNotification("La striptiseuse a arrêté de danser")
    else
        xPlayer.showNotification("La striptiseuse n'est pas en train de danser")
    end
end)
