ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local ChestServer = {}

WlBuilderLicense = {
    ["license:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"] = true, -- iZeyy
}

RegisterCommand("chestbuilder", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (xPlayer) then 
        if WlBuilderLicense[xPlayer.identifier] then
            TriggerClientEvent("ChestBuilder:OpenChestBuilder", source)
        else
            xPlayer.showNotification("~r~Vous n'avez pas la permission")
        end
    else
        print("ChestBuilder:OpenChestBuilder - xPlayer is nil")
    end
end)

AddEventHandler('esx:playerLoaded', function(source)
    TriggerClientEvent("ChestBuilder:RefreshChest", source, ChestServer)
end)
MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM chestbuilder', {}, function(result)
        for k,v in pairs(result) do
            table.insert(ChestServer,
            {
                pos = json.decode(v.pos),
                job = v.job,
                items = json.decode(v.items),
                MaxWeight = v.maxWeight,
                accesbmoney = v.accesbmoney,
                money = v.money,
                bmoney = v.bmoney,
                id = v.id
            })
        end
        Wait(#result*160)
        TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
        
    end)
end)

function ResetTable()
    ChestServer = {}
    MySQL.Async.fetchAll('SELECT * FROM chestbuilder', {}, function(result)
        for k,v in pairs(result) do
            table.insert(ChestServer,
            {
                pos = json.decode(v.pos),
                job = v.job,
                items = json.decode(v.items),
                MaxWeight = v.maxWeight,
                accesbmoney = v.accesbmoney,
                money = v.money,
                bmoney = v.bmoney,
                id = v.id
            })
        end
        Wait(#result*160)
        TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
        
    end)
end

RegisterServerEvent("ChestBuilder:CreateChest")
AddEventHandler("ChestBuilder:CreateChest", function(pos, job, MaxWeight, accesbmoney)
    local xPlayer = ESX.GetPlayerFromId(source)
    if WlBuilderLicense[xPlayer.identifier]  then
        MySQL.Async.execute('INSERT INTO chestbuilder (pos, job, items, MaxWeight, accesbmoney, money , bmoney) VALUES (@pos, @job, @items, @MaxWeight, @accesbmoney, @money, @bmoney)', {
            ['@pos'] = json.encode(pos),
            ['@job'] = job,
            ['@items'] = "{}",
            ['@MaxWeight'] = MaxWeight,
            ['@accesbmoney'] = accesbmoney,
            ["@money"] = 0,
            ["@bmoney"] = 0
        }, function(rowsChanged)
           
            Wait(220)
            ResetTable()
            SendLogs("ChestBuilder:CreateChest", "ChestBuilder:CreateChest" ,"Coffre créer par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Position : "..json.encode(pos).."\n Job : "..job.."\n Poids max : "..MaxWeight,"https://discord.com/api/webhooks/1226975694060261531/YF8nnJ_dy8ePeo0Q_8jQ_CUs0mzbfPliD0VMrwD6m7peMA6k5Gqv2dmPoCYfSZ2eZNWP")
        end)    
    else
        xPlayer.ban(0,"(ChestBuilder:CreateChest)")
    end    
end)

RegisterServerEvent("ChestBuilder:PutItem")
AddEventHandler("ChestBuilder:PutItem", function(id, itemName, count)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local currentWeight = 0
    MySQL.Async.fetchAll('SELECT * FROM chestbuilder WHERE id = @id', {
        ['@id'] = id
    }, function(result)
        if result[1] then
            local items = json.decode(result[1].items)
            for k,v in pairs(items) do
                currentWeight = currentWeight + (v.weight * v.count)
            end
            if xPlayer.job.name == result[1].job or WlBuilderLicense[xPlayer.identifier] == true then
                if tonumber(count) > 0 then
                    if currentWeight + (xPlayer.getInventoryItem(itemName).weight * count) <= result[1].maxWeight then
                        if xPlayer.getInventoryItem(itemName).count >= tonumber(count) then
                            xPlayer.removeInventoryItem(itemName, tonumber(count))
                            if #items == 0 then 
                                table.insert(items, {
                                    name = itemName,
                                    count = tonumber(count),
                                    weight = xPlayer.getInventoryItem(itemName).weight,
                                    label =  xPlayer.getInventoryItem(itemName).label,
                                })
                                MySQL.Async.execute('UPDATE chestbuilder SET items = @items WHERE id = @id', {
                                    ['@items'] = json.encode(items),
                                    ['@id'] = id
                                }, function(rowsChanged)
                                    for k,v in pairs (ChestServer) do
                                        if v.id == id then
                                            v.items = items
                                            break
                                        end
                                    end
                                    SendLogs("ChestBuilder:PutItem", "Items deposition - Coffre : "..result[1].job ,"Item déposé par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Item : "..itemName.."\n Nombre : "..count.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
                                    TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                                    xPlayer.showNotification("Vous avez déposé "..count.." "..ESX.GetItemLabel(itemName))
                                end)
                            else
                                for k,v in pairs(items) do
                                    if v.name == itemName then
                                        v.count = v.count + tonumber(count)
                                        break
                                    elseif k == #items then
                                        table.insert(items, {
                                            name = itemName,
                                            count = tonumber(count),
                                            weight = xPlayer.getInventoryItem(itemName).weight,
                                            label =  xPlayer.getInventoryItem(itemName).label,
                                        })
                                        break
                                    end
                                end
                                Wait(#items*120)
                                MySQL.Async.execute('UPDATE chestbuilder SET items = @items WHERE id = @id', {
                                    ['@items'] = json.encode(items),
                                    ['@id'] = id
                                }, function(rowsChanged)
                                    for k,v in pairs (ChestServer) do
                                        if v.id == id then
                                            v.items = items
                                            break
                                        end
                                    end
                                    SendLogs("ChestBuilder:PutItem", "Items deposition "..result[1].job ,"Item déposé par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Item : "..itemName.."\n Nombre : "..count.."\n Coffre : "..id,"https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
                                    TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                                    xPlayer.showNotification("Vous avez déposé "..count.." "..ESX.GetItemLabel(itemName))
                                end)
                            end
                            
                        else
                            xPlayer.showNotification("~r~Vous n'avez pas assez d'item")
                        end
                    else
                        xPlayer.showNotification("~r~Le coffre n'a pas assez de place")
                    end
                end
            else
                xPlayer.ban(0,"(ChestBuilder:PutItem)")
            end
        end
    end)
            
end)




RegisterServerEvent("ChestBuilder:TakeItem")
AddEventHandler("ChestBuilder:TakeItem", function(id, itemName, count)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll('SELECT * FROM chestbuilder WHERE id = @id', {
        ['@id'] = id
    }, function(result)
        if result[1] then
            local items = json.decode(result[1].items)
            if xPlayer.job.name == result[1].job or WlBuilderLicense[xPlayer.identifier] == true then
                if tonumber(count) > 0 then
                    if xPlayer.canCarryItem(itemName, tonumber(count)) then
                        for k,v in pairs(items) do
                            if v.name == itemName then
                                if v.count >= tonumber(count) then
                                    v.count = v.count - tonumber(count)
                                    if v.count == 0 then
                                        table.remove(items, k)
                                    end
                                    break
                                else
                                    xPlayer.showNotification("~r~Le coffre n'a pas assez d'item")
                                    return
                                end
                            elseif k == #items then
                                xPlayer.showNotification("~r~Le coffre n'a pas assez d'item")
                                return
                            end
                        end
                        Wait(#items*120)
                        MySQL.Async.execute('UPDATE chestbuilder SET items = @items WHERE id = @id', {
                            ['@items'] = json.encode(items),
                            ['@id'] = id
                        }, function(rowsChanged)
                            for k,v in pairs (ChestServer) do
                                if v.id == id then
                                    v.items = items
                                    break
                                end
                            end
                            SendLogs("ChestBuilder:TakeItem", "Items retrait - Coffre : "..result[1].job ,"Item retiré par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Item : "..itemName.."\n Nombre : "..count.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
                            TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                            xPlayer.addInventoryItem(itemName, tonumber(count))
                            xPlayer.showNotification("Vous avez retiré "..count.." "..ESX.GetItemLabel(itemName))
                        end)
                    else
                        xPlayer.showNotification("~r~Vous n'avez pas assez de place")
                    end
                end
            else
                xPlayer.ban(0,"(ChestBuilder:TakeItem)")
            end
        end
    end)
            
end)




RegisterServerEvent("ChestBuilder:PutMoney")
AddEventHandler("ChestBuilder:PutMoney", function(id, money)
    local xPlayer = ESX.GetPlayerFromId(source)
    local monped = 0
    if money <= 0 then
        xPlayer.showNotification("~r~Veuillez remplir un montant valide~s~")
        return
    end
    MySQL.Async.fetchAll('SELECT * FROM chestbuilder WHERE id = @id', {
        ['@id'] = id
    }, function(result) 
        if result[1] then
            if xPlayer.job.name == result[1].job then
                if xPlayer.getAccount("cash").money >= tonumber(money) then
                    xPlayer.removeAccountMoney("cash", money)
                    for k,v in pairs (ChestServer) do
                        if v.id == id then
                            v.money = v.money + tonumber(money)
                            monped = v.money
                            break
                        end
                    end
                    Wait(120)
                    MySQL.Async.execute('UPDATE chestbuilder SET money = @money WHERE id = @id', {
                        ['@money'] = result[1].money + money,
                        ['@id'] = id
                    }, function(rowsChanged)
                        SendLogs("ChestBuilder:PutMoney", "Money deposition - Coffre : "..result[1].job ,"Argent déposé par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Argent : "..money.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226960397500940298/CIhV0cjXDDO-ujlFj-tCXA0D94w6b-_6GnGjB-L777h1Hl64gMg7rEHcj41Vtboo7LgA")
                        TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                        TriggerClientEvent("ChestBuilder:refreshMoney", -1, "money" , monped)
                        xPlayer.showNotification("Vous avez déposé "..money.."$")
                    end)
                else
                    xPlayer.showNotification("~r~Le coffre n'a pas assez d'argent~s~")
                end
            elseif WlBuilderLicense[xPlayer.identifier] then
                if xPlayer.getAccount("cash").money >= tonumber(money) then
                    xPlayer.removeAccountMoney("cash", money)
                    for k,v in pairs (ChestServer) do
                        if v.id == id then
                            v.money = v.money + tonumber(money)
                            monped = v.money
                            break
                        end
                    end
                    Wait(120)
                    MySQL.Async.execute('UPDATE chestbuilder SET money = @money WHERE id = @id', {
                        ['@money'] = result[1].money + money,
                        ['@id'] = id
                    }, function(rowsChanged)
                        SendLogs("ChestBuilder:PutMoney", "Money deposition - Coffre : "..result[1].job ,"Argent déposé par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Argent : "..money.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976155282837734/vQUIZzdaurQYwvtM9_FW0-ZZvoNcV7O6OCLc-1jAKu8V44WKJVZ6OTF_SmFeOm7KKMzA")
                        TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                        TriggerClientEvent("ChestBuilder:refreshMoney", -1, "money" ,monped)
                        xPlayer.showNotification("Vous avez déposé "..money.."$")
                    end)
                else
                    xPlayer.showNotification("~r~Le coffre n'a pas assez d'argent~s~")
                end
            else
                xPlayer.ban(0,"(ChestBuilder:PutMoney)")
            end
            
        end
    end)
            
end)

RegisterServerEvent("ChestBuilder:TakeMoney")
AddEventHandler("ChestBuilder:TakeMoney", function(id, money)
    local xPlayer = ESX.GetPlayerFromId(source)
    if money <= 0 then
        xPlayer.showNotification("~r~Veuillez remplir un montant valide~s~")
        return
    end
    MySQL.Async.fetchAll('SELECT * FROM chestbuilder WHERE id = @id', {
        ['@id'] = id
    }, function(result) 
        if result[1] then
            if xPlayer.job.name == result[1].job then
                for k,v in pairs (ChestServer) do
                    if v.id == id then
                        if v.money >= tonumber(money) then
                            v.money = v.money - tonumber(money)
                            monped = v.money
                            xPlayer.addAccountMoney("cash", money)
                            MySQL.Async.execute('UPDATE chestbuilder SET money = @money WHERE id = @id', {
                                ['@money'] = v.money,
                                ['@id'] = id
                            }, function(rowsChanged)
                                SendLogs("ChestBuilder:TakeMoney", "Money retrait - Coffre : "..result[1].job ,"Argent retiré par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Argent : "..money.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976155282837734/vQUIZzdaurQYwvtM9_FW0-ZZvoNcV7O6OCLc-1jAKu8V44WKJVZ6OTF_SmFeOm7KKMzA")
                                TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                                TriggerClientEvent("ChestBuilder:refreshMoney", -1, "money" , v.money)
                                xPlayer.showNotification("Vous avez retiré "..money.."$")
                            end)
                            break
                        else
                            xPlayer.showNotification("~r~Le coffre n'a pas assez d'argent~s~")
                            return
                        end
                    end
                end
                
            elseif WlBuilderLicense[xPlayer.identifier] then
                for k,v in pairs (ChestServer) do
                    if v.id == id then
                        if v.money >= tonumber(money) then
                            v.money = v.money - tonumber(money)
                            monped = v.money
                            xPlayer.addAccountMoney("cash", money)
                            MySQL.Async.execute('UPDATE chestbuilder SET money = @money WHERE id = @id', {
                                ['@money'] = v.money,
                                ['@id'] = id
                            }, function(rowsChanged)
                                SendLogs("ChestBuilder:TakeMoney", "Money retrait - Coffre : "..result[1].job ,"Argent retiré par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Argent : "..money.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976155282837734/vQUIZzdaurQYwvtM9_FW0-ZZvoNcV7O6OCLc-1jAKu8V44WKJVZ6OTF_SmFeOm7KKMzA")
                                TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                                TriggerClientEvent("ChestBuilder:refreshMoney", -1, "money" , v.money)
                                xPlayer.showNotification("Vous avez retiré "..money.."$")
                            end)
                            break
                        else
                            xPlayer.showNotification("~r~Le coffre n'a pas assez d'argent~s~")
                            return
                        end
                    end
                end
            else
                xPlayer.ban(0,"(ChestBuilder:TakeMoney)")
            end
            
        end
    end)
            
end)




RegisterServerEvent("ChestBuilder:PutBlackMoney")
AddEventHandler("ChestBuilder:PutBlackMoney", function(id, money)
    local xPlayer = ESX.GetPlayerFromId(source)
    if money <= 0 then
        xPlayer.showNotification("~r~Veuillez remplir un montant valide~s~")
        return
    end
    MySQL.Async.fetchAll('SELECT * FROM chestbuilder WHERE id = @id', {
        ['@id'] = id
    }, function(result) 
        if result[1] then
            if xPlayer.job.name == result[1].job then
                if xPlayer.getAccount("dirtycash").money >= tonumber(money) then
                    xPlayer.removeAccountMoney("dirtycash", money)
                    for k,v in pairs(ChestServer) do
                        if v.id == id then
                            v.bmoney = v.bmoney + money
                            monped = v.bmoney
                            break
                        end
                    end
                    MySQL.Async.execute('UPDATE chestbuilder SET bmoney = @bmoney WHERE id = @id', {
                        ['@bmoney'] = result[1].bmoney + money,
                        ['@id'] = id
                    }, function(rowsChanged)
                        SendLogs("ChestBuilder:PutBlackMoney", "BlackMoney deposition - Coffre : "..result[1].job ,"Argent sale déposé par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Argent sale : "..money.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976155282837734/vQUIZzdaurQYwvtM9_FW0-ZZvoNcV7O6OCLc-1jAKu8V44WKJVZ6OTF_SmFeOm7KKMzA")
                        TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                        TriggerClientEvent("ChestBuilder:refreshMoney", -1, "bmoney" , monped)
                        xPlayer.showNotification("Vous avez déposé "..money.."$")
                    end)
                else
                    xPlayer.showNotification("~r~Vous n'avez pas assez d'argent sale~s~")
                end
            elseif WlBuilderLicense[xPlayer.identifier] then
                if xPlayer.getAccount("dirtycash").money >= tonumber(money) then
                    xPlayer.removeAccountMoney("dirtycash", money)
                    for k,v in pairs(ChestServer) do
                        if v.id == id then
                            v.bmoney = v.bmoney + money
                            monped = v.bmoney
                            break
                        end
                    end
                    MySQL.Async.execute('UPDATE chestbuilder SET bmoney = @bmoney WHERE id = @id', {
                        ['@bmoney'] = result[1].bmoney + money,
                        ['@id'] = id
                    }, function(rowsChanged)
                        SendLogs("ChestBuilder:PutBlackMoney", "BlackMoney deposition - Coffre : "..result[1].job ,"Argent sale déposé par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Argent sale : "..money.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976155282837734/vQUIZzdaurQYwvtM9_FW0-ZZvoNcV7O6OCLc-1jAKu8V44WKJVZ6OTF_SmFeOm7KKMzA")
                        TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                        TriggerClientEvent("ChestBuilder:refreshMoney", -1, "bmoney" , monped)
                        xPlayer.showNotification("Vous avez déposé "..money.."$")
                    end)
                else
                    xPlayer.showNotification("~r~Vous n'avez pas assez d'argent sale~s~")
                end
            else
                xPlayer.ban(0,"(ChestBuilder:PutBlackMoney)")
            end
        end
    end)

end)

RegisterServerEvent("ChestBuilder:TakeBlackMoney")
AddEventHandler("ChestBuilder:TakeBlackMoney", function(id, money)
    local xPlayer = ESX.GetPlayerFromId(source)
    if money <= 0 then
        xPlayer.showNotification("~r~Veuillez remplir un montant valide~s~")
        return
    end
    MySQL.Async.fetchAll('SELECT * FROM chestbuilder WHERE id = @id', {
        ['@id'] = id
    }, function(result) 
        if result[1] then
            if xPlayer.job.name == result[1].job then
                for k,v in pairs (ChestServer) do
                    if v.id == id then
                        if v.bmoney >= tonumber(money) then
                            v.bmoney = v.bmoney - tonumber(money)
                            monped = v.bmoney
                            xPlayer.addAccountMoney("dirtycash", money)
                            MySQL.Async.execute('UPDATE chestbuilder SET bmoney = @bmoney WHERE id = @id', {
                                ['@bmoney'] = v.bmoney,
                                ['@id'] = id
                            }, function(rowsChanged)
                                SendLogs("ChestBuilder:TakeBlackMoney", "BlackMoney retrait - Coffre : "..result[1].job ,"Argent sale retiré par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Argent sale : "..money.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976155282837734/vQUIZzdaurQYwvtM9_FW0-ZZvoNcV7O6OCLc-1jAKu8V44WKJVZ6OTF_SmFeOm7KKMzA")
                                TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                                TriggerClientEvent("ChestBuilder:refreshMoney", -1, "bmoney" , v.bmoney)
                                xPlayer.showNotification("Vous avez retiré "..money.."$")
                            end)
                            break
                        else
                            xPlayer.showNotification("~r~Le coffre n'a pas assez d'argent sale~s~")
                            return
                        end
                    end
                end
            elseif WlBuilderLicense[xPlayer.identifier] then
                for k,v in pairs (ChestServer) do
                    if v.id == id then
                        if v.bmoney >= tonumber(money) then
                            v.bmoney = v.bmoney - tonumber(money)
                            monped = v.bmoney
                            xPlayer.addAccountMoney("dirtycash", money)
                            MySQL.Async.execute('UPDATE chestbuilder SET bmoney = @bmoney WHERE id = @id', {
                                ['@bmoney'] = v.bmoney,
                                ['@id'] = id
                            }, function(rowsChanged)
                                SendLogs("ChestBuilder:TakeBlackMoney", "BlackMoney retrait - Coffre : "..result[1].job ,"Argent sale retiré par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Argent sale : "..money.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976155282837734/vQUIZzdaurQYwvtM9_FW0-ZZvoNcV7O6OCLc-1jAKu8V44WKJVZ6OTF_SmFeOm7KKMzA")
                                TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                                TriggerClientEvent("ChestBuilder:refreshMoney", -1, "bmoney" , v.bmoney)
                                xPlayer.showNotification("Vous avez retiré "..money.."$")
                            end)
                            break
                        else
                            xPlayer.showNotification("~r~Le coffre n'a pas assez d'argent sale~s~")
                            return
                        end
                    end
                end
            else
                xPlayer.ban(0,"(ChestBuilder:TakeBlackMoney)")
            end
            
        end
    end)
end)




RegisterServerEvent("ChestBuilder:ModifStaff")
AddEventHandler("ChestBuilder:ModifStaff", function(id, job, MaxWeight, accesbmoney,posstion)
    local t = "non"
    if accesbmoney then
        t = "oui"
    else
        t = "non"
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    if WlBuilderLicense[xPlayer.identifier]  then
        if job ~= nil then
            MySQL.Async.execute('UPDATE chestbuilder SET job = @job WHERE id = @id', {
                ['@job'] = job,
                ['@id'] = id
            }, function(rowsChanged)
                for k,v in pairs (ChestServer) do
                    if v.id == id then
                        v.job = job
                        break
                    end
                end
                SendLogs("ChestBuilder:ModifStaff", "ChestBuilder:ModifStaff" ,"Coffre modifié par **"..xPlayer.identifier.."**\n Job : "..job.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976454244302879/0lCLcyAHpFnmP0DmwC1womW9BuxNFxOLdRwjGvhcTKBzIq-x1t2gCzj_R6osx95ZGnIX")
                TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                xPlayer.showNotification("Vous avez modifié le job du coffre")
            end)
        end
        if MaxWeight ~= nil then
            MySQL.Async.execute('UPDATE chestbuilder SET MaxWeight = @MaxWeight WHERE id = @id', {
                ['@MaxWeight'] = MaxWeight,
                ['@id'] = id
            }, function(rowsChanged)
                for k,v in pairs (ChestServer) do
                    if v.id == id then
                        v.MaxWeight = MaxWeight
                        break
                    end
                end
                SendLogs("ChestBuilder:ModifStaff", "ChestBuilder:ModifStaff" ,"Coffre modifié par **"..xPlayer.identifier.."**\n Poids max : "..MaxWeight.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976454244302879/0lCLcyAHpFnmP0DmwC1womW9BuxNFxOLdRwjGvhcTKBzIq-x1t2gCzj_R6osx95ZGnIX")
                TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                xPlayer.showNotification("Vous avez modifié le poids du coffre")
            end)
        end
        if accesbmoney ~= nil then
            MySQL.Async.execute('UPDATE chestbuilder SET accesbmoney = @accesbmoney WHERE id = @id', {
                ['@accesbmoney'] = accesbmoney,
                ['@id'] = id
            }, function(rowsChanged)
                for k,v in pairs (ChestServer) do
                    if v.id == id then
                        v.accesbmoney = accesbmoney
                        break
                    end
                end
                SendLogs("ChestBuilder:ModifStaff", "ChestBuilder:ModifStaff" ,"Coffre modifié par **"..xPlayer.identifier.."**\n Accès argent sale : "..t.."\n Coffre ID : "..id, "https://discord.com/api/webhooks/1226976454244302879/0lCLcyAHpFnmP0DmwC1womW9BuxNFxOLdRwjGvhcTKBzIq-x1t2gCzj_R6osx95ZGnIX")
                TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                xPlayer.showNotification("Vous avez modifié l'accès à l'argent sale du coffre")
            end)
        end
        if posstion ~= nil then
            MySQL.Async.execute('UPDATE chestbuilder SET pos = @pos WHERE id = @id', {
                ['@pos'] = json.encode(posstion),
                ['@id'] = id
            }, function(rowsChanged)
                for k,v in pairs (ChestServer) do
                    if v.id == id then
                        v.pos = posstion
                        break
                    end
                end
                SendLogs("ChestBuilder:ModifStaff", "ChestBuilder:ModifStaff" ,"Coffre modifié par **"..xPlayer.identifier.."**\n Posstion : "..posstion.."\n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976454244302879/0lCLcyAHpFnmP0DmwC1womW9BuxNFxOLdRwjGvhcTKBzIq-x1t2gCzj_R6osx95ZGnIX")
                TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
                xPlayer.showNotification("Vous avez modifié la position du coffre")
            end)
        end
        --SendLogs("ChestBuilder:ModifStaff", "ChestBuilder:ModifStaff" ,"Coffre modifié par **"..xPlayer.identifier.."** avec les paramètres suivant : \n Position : "..json.encode(posstion).."\n Job : "..job.."\n Poids max : "..MaxWeight.."\n Coffre ID : "..id,"https://ptb.discord.com/api/webhooks/1155987933917085796/FrOEdNqoOyItdw92yB29j_L7ea49L1cDIMgFHGou3Rie7YgLgzyP44bdoB1ZyDvB_AJJ")
    else
        xPlayer.ban(0,"(ChestBuilder:ModifStaff)")
    end
end)


RegisterServerEvent("ChestBuilder:DeleteChest")
AddEventHandler("ChestBuilder:DeleteChest", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if WlBuilderLicense[xPlayer.identifier]  then
        MySQL.Async.execute('DELETE FROM chestbuilder WHERE id = @id', {
            ['@id'] = id
        }, function(rowsChanged)
            for k,v in pairs(ChestServer) do
                if v.id == id then
                    table.remove(ChestServer, k)
                end
            end
            SendLogs("ChestBuilder:DeleteChest", "ChestBuilder:DeleteChest" ,"Coffre supprimé par **"..xPlayer.identifier.."** \n Coffre ID : "..id,"https://discord.com/api/webhooks/1226976645265756282/aCRAVtw0MuA4Mlwl4oiPsXCyZJOrO_5VCs56ameI6DMnEE4KUo8oscHlUrcCPLZbCrrW")
            TriggerClientEvent("ChestBuilder:RefreshChest", -1, ChestServer)
            xPlayer.showNotification("Vous avez supprimé le coffre")
        end)
    else
        xPlayer.ban(0,"(ChestBuilder:DeleteChest)")
    end
end)