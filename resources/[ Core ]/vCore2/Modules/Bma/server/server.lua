RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM bmaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('Bma:setAccess', source)
            TriggerClientEvent("Bma:AddBlips", source)
        end
        
    end)
end)

WlLicense = {
    ["license:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"] = true
}

RegisterServerEvent("Bma:CheckAccess")
AddEventHandler("Bma:CheckAccess", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM bmaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('Bma:OpenMenu', src,result[1].lvl)
        else
            xPlayer.showNotification("~r~Vous n'avez pas accès à ce menu")
        end
         
    end)
end)

ESX.RegisterServerCallback("Bma:GetBmaCoords", function(source, cb)
    cb(vector3(3725.276,4525.367,22.47048))
end)

RegisterCommand("AddBmaLicense", function(source, args)
    local src = source
    local text = args[1]
    if src == 0 then
        if args[1] == nil then
            print("^1[Bma] Vous devez spécifier une license^7")
            return
        elseif tonumber(args[2]) == 1 or tonumber(args[2]) == 2 then
            if string.sub(text, 1, 8) == "license:" then
                MySQL.Async.fetchAll("SELECT * FROM bmaaccess WHERE license = @license", {
                    ["@license"] = args[1]
                }, function(result)
                    if result[1] then
                        print("^1[Bma] Cette license a déjà accès au menu^7")
                    else
                        MySQL.Async.execute("INSERT INTO bmaaccess (license,lvl) VALUES (@license,@lvl)", {
                            ["@license"] = args[1],
                            ["@lvl"] = args[2]
                        }, function(result)
                            if result then
                                print("^1[Bma]^7 Vous avez ajouté l'accès à ^2"..args[1])
                            else
                                print("^1[Bma]^7 Une erreur est survenue")
                            end
                        end)
                    end
                end)
            else
                print("[Bma] Vous devez spécifier une license")
            end
        else
            print("[Bma] Vous devez spécifier un niveau 1 ou 2 ou une license")
        end
       
    else
        local xPlayer = ESX.GetPlayerFromId(source)

        if WlLicense[xPlayer.identifier] then
            if args[1] == nil then
                xPlayer.showNotification("~r~Vous devez spécifier une license")
                return
            elseif tonumber(args[2]) == 1 or tonumber(args[2]) == 2 then
                if string.sub(text, 1, 8) == "license:" then
                    if xPlayer.getGroup() == "founder" then
                        MySQL.Async.fetchAll("SELECT * FROM bmaaccess WHERE license = @license", {
                            ["@license"] = args[1]
                        }, function(result)
                            if result[1] then
                                xPlayer.showNotification("~r~Cette license a déjà accès au menu")
                            else
                                MySQL.Async.execute("INSERT INTO bmaaccess (license,lvl) VALUES (@license,@lvl)", {
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
RegisterServerEvent("Bma:BuyWeapon")
AddEventHandler("Bma:BuyWeapon", function(weapon,price,weaponlabel)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM bmaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            if xPlayer.getWeapon(weapon) then
                xPlayer.showNotification("~r~Vous avez déjà cette arme")
                return
            else
                if xPlayer.getAccount("dirtycash").money >= price then
                    xPlayer.removeAccountMoney("dirtycash",price)
                    xPlayer.addWeapon(weapon, 12)
                    xPlayer.showNotification("Vous avez acheté "..weaponlabel.." pour "..price.."$")
                else
                    xPlayer.showNotification("Vous n'avez pas assez d'argent")
                end
            end
        else
            xPlayer.ban(0,"Bma:BuyWeapon")
        end
         
    end)
    
end)

RegisterServerEvent("Bma:BuyItem")
AddEventHandler("Bma:BuyItem", function(item,price,itemlabel)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM bmaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            if not xPlayer.canCarryItem(item, 1) then
                xPlayer.showNotification("~Vous ne pouvez pas porter plus de d'objets")
                return
            else
                if xPlayer.getAccount("dirtycash").money >= price then
                    xPlayer.removeAccountMoney("dirtycash",price)
                    xPlayer.addInventoryItem(item, 1)
                    xPlayer.showNotification("Vous avez acheté "..itemlabel.." pour "..price.."$")
                else
                    xPlayer.showNotification("Vous n'avez pas assez d'argent")
                end
            end
        else
            xPlayer.ban(0,"Bma:BuyItem")
        end
         
    end)
    
end)