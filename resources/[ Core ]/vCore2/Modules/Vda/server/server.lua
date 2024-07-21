RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('Vda:setAccess', source)
            TriggerClientEvent("Vda:AddBlips", source)
        end

    end)
end)

WlLicense = {
    ["license:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"] = true
}

RegisterServerEvent("Vda:CheckAccess")
AddEventHandler("Vda:CheckAccess", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('Vda:OpenMenu', src,result[1].lvl)
        else
            xPlayer.showNotification("~r~Vous n'avez pas accès à ce menu")
        end

    end)
end)

ESX.RegisterServerCallback("Vda:GetVdaCoords", function(source, cb)
    cb(vector3(1653.1994628906,4746.4150390625,42.021224975586))
end)

RegisterCommand("AddVdaLicense", function(source, args)
    local src = source
    local text = args[1]
    if src == 0 then
        if args[1] == nil then
            print("^1[VDA] Vous devez spécifier une license^7")
            return
        elseif tonumber(args[2]) == 1 or tonumber(args[2]) == 2 or tonumber(args[2]) == 3 then
            if string.sub(text, 1, 8) == "license:" then
                MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
                    ["@license"] = args[1]
                }, function(result)
                    if result[1] then
                        print("^1[VDA] Cette license a déjà accès au menu^7")
                    else
                        MySQL.Async.execute("INSERT INTO vdaaccess (license,lvl) VALUES (@license,@lvl)", {
                            ["@license"] = args[1],
                            ["@lvl"] = args[2]
                        }, function(result)
                            if result then
                                print("^1[VDA]^7 Vous avez ajouté l'accès à ^2"..args[1])
                            else
                                print("^1[VDA]^7 Une erreur est survenue")
                            end
                        end)
                    end
                end)
            else
                print("[VDA] Vous devez spécifier une license")
            end
        else
            print("[VDA] Vous devez spécifier un niveau 1 ou 2 ou une license")
        end

    else
        local xPlayer = ESX.GetPlayerFromId(source)

        if WlLicense[xPlayer.identifier] then
            if args[1] == nil then
                xPlayer.showNotification("~r~Vous devez spécifier une license")
                return
            elseif tonumber(args[2]) == 1 or tonumber(args[2]) == 3 then
                if string.sub(text, 1, 8) == "license:" then
                    if xPlayer.getGroup() == "founder" then
                        MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
                            ["@license"] = args[1]
                        }, function(result)
                            if result[1] then
                                xPlayer.showNotification("~r~Cette license a déjà accès au menu")
                            else
                                MySQL.Async.execute("INSERT INTO vdaaccess (license,lvl) VALUES (@license,@lvl)", {
                                    ["@license"] = args[1],
                                    ["@lvl"] = args[2]
                                }, function(result)
                                    if result then
                                        xPlayer.showNotification("~g~Vous avez ajouté l'accès à "..args[1])
                                    else
                                        xPlayer.showNotification("~r~Une erreur est survenue")
                                    end
                                end)
                            end
                        end)
                    end
                else
                    xPlayer.showNotification("~r~Vous devez spécifier une license")
                end
            else
                xPlayer.showNotification("~r~Vous devez spécifier un niveau 1 ou 2 une license")
            end
        else
            xPlayer.showNotification("~r~Vous n'avez pas accès à cette commande")
        end
    end
end)
RegisterServerEvent("Vda:BuyWeapon")
AddEventHandler("Vda:BuyWeapon", function(weapon,price,weaponlabel)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            if xPlayer.getWeapon(weapon) then
                xPlayer.showNotification("Vous avez déjà cette arme")
                return
            else
                if xPlayer.getAccount("dirtycash").money >= price then
                    xPlayer.removeAccountMoney("dirtycash",price)
                    xPlayer.addWeapon(weapon, 12)
                    xPlayer.showNotification("Vous avez acheté une "..weaponlabel.." pour "..price.."$")
                else
                    xPlayer.showNotification("Vous n'avez pas assez d'argent")
                end
            end
        else
            xPlayer.ban(0,"Vda:BuyWeapon")
        end

    end)

end)

RegisterServerEvent("Vda:BuyItem")
AddEventHandler("Vda:BuyItem", function(item,price,itemlabel)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            if not xPlayer.canCarryItem(item, 1) then
                xPlayer.showNotification("~r~Vous ne pouvez pas porter plus de d'objets")
                return
            else
                if xPlayer.getAccount("dirtycash").money >= price then
                    xPlayer.removeAccountMoney("dirtycash",price)
                    xPlayer.addInventoryItem(item, 1)
                    xPlayer.showNotification("~g~Vous avez acheté un "..itemlabel.." pour "..price.."$")
                else
                    xPlayer.showNotification("~r~Vous n'avez pas assez d'argent")
                end
            end
        else
            xPlayer.ban(0,"Vda:BuyItem")
        end

    end)

end)