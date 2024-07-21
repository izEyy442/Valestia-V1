ESX, Labo = nil, {}
local savedCoords = {}
local checkPos = {}

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

local drugsBasicInfos = function(Table)
    if Table == nil then return end
    Table.Data = {}
    if Table.Type == "Meth" then 
        Table.Data = {
            interior = {"meth_lab_basic", "meth_lab_setup"}, 
            interiorStatus = "basic"
        }
    elseif Table.Type == "Cocaïne" then 
        Table.Data = {
            interior = {"set_up", "equipment_basic", "coke_press_basic", "production_basic", "table_equipment"}, 
            interiorStatus = "basic"
        }
    elseif Table.Type == "Weed" then 
        Table.Data = {
            interior = "weed_standard_equip",
            interiorStatus = "basic",
            details = {
                drying = false,
                chairs = false,
                production = false
            }
        }
    end
end 

local DrugsUpgradeInfos = function(type, value)
    if type == "Meth" then 
        if value == "basic" then 
            return {"meth_lab_basic", "meth_lab_setup"}
        end
        if value == "upgrade" then 
            return {"meth_lab_upgrade", "meth_lab_setup"}
        end
    end
    if type == "Weed" then 
        if value == "upgrade" then 
            return "weed_upgrade_equip"
        end
    end
    if type == "Cocaïne" then 
        if value == "upgrade" then 
            return {"set_up", "equipment_upgrade", "coke_press_upgrade", "production_upgrade", "table_equipment_upgrade"}
        end
    end
end

local DrugsProductionInfos = function(type, value, count)
    if type == "Meth" then
        local table = {}
        for i=1, 1 do
            table[i] = value
        end
        return json.encode(table)
    end
    if type == "Weed" then 
        local table = {}
        for i=1, 9 do
            table[i] = value
        end
        return json.encode(table)
    end
    if type == "Cocaïne" then 
        local table = {}
        if count then
            for i=1, count do
                table[i] = value
            end
        else
            for i=1, 5 do
                table[i] = value
            end
        end
        return json.encode(table)
    end 
end

local saveLabo = function(laboId, laboData)
    if laboId == nil then return end
    MySQL.Async.execute("UPDATE drugss SET data = @data WHERE id = @id", {
        ["id"] = laboId,
        ["data"] = json.encode(laboData)
    })
end

local saveProduction = function(laboId, laboProduction)
    if laboId == nil then return end
    MySQL.Async.execute("UPDATE drugss SET production = @production WHERE id = @id", {
        ["id"] = laboId,
        ["production"] = laboProduction
    })
end

RegisterServerEvent("Laboratories:SetPlayerIntoBucket")
AddEventHandler("Laboratories:SetPlayerIntoBucket", function()
    local _src = source 
    local data = DrugsHandler.ConfigBuilds

    TriggerClientEvent("Laboratories:SetConfigToClient", _src, data)
end)

RegisterServerEvent("Laboratories:SetPlayerIntoBucket")
AddEventHandler("Laboratories:SetPlayerIntoBucket", function(bucketId)
    local _src = source 
    SetPlayerRoutingBucket(_src, bucketId)
end)

RegisterServerEvent("Laboratories:SetPlayerIntoNormalBucket")
AddEventHandler("Laboratories:SetPlayerIntoNormalBucket", function()
    local _src = source 
    SetPlayerRoutingBucket(_src, 0)
end)

ESX.RegisterServerCallback("Laboratories:GetUserInfos", function(source, cb)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)     
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ["identifier"] = xPlayer.identifier
    }, function(userData)
    	cb(userData)
    end)
end)

ESX.RegisterServerCallback("Laboratories:GetConfigBuilds", function(source, cb)
    local _src = source
    cb(DrugsHandler.Builds)
end)

ESX.RegisterServerCallback("Laboratories:GetConfigInfos", function(source, cb)
    local _src = source
    cb(DrugsHandler.Builds, DrugsHandler.Interiors, DrugsHandler.Settings, DrugsHandler.Items, DrugsHandler.Upgrades, DrugsHandler.Supplies)
end)

ESX.RegisterServerCallback("Laboratories:GetLaboratories", function(source, cb)
    SetTimeout(350, function()
        MySQL.Async.fetchAll('SELECT * FROM drugss', {}, function(drugsData)
            for k, v in pairs(drugsData) do
                drugsData[k].data = json.decode(v.data)
            end
            cb(drugsData)
        end)
    end)
end)

RegisterServerEvent("Laboratories:BuyLaboratories")
AddEventHandler("Laboratories:BuyLaboratories", function(Drugs)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)
    if Drugs == nil then return end 
    local randomNumber = math.random(1111, 9999)
    if xPlayer.getAccount('dirtycash').money  < Drugs.Price then 
        return TriggerClientEvent("esx:showNotification", _src, "Vous n'avez pas assez d'argent")
    end
    SetTimeout(350, function()
        MySQL.Async.fetchAll("SELECT * FROM drugss WHERE owner = @owner AND type = @type AND value = @value", {
            ["owner"] = xPlayer.identifier,
            ["type"] = Drugs.Type,
            ["value"] = Drugs.Value
        }, function(result)
            if result[1] then 
                TriggerClientEvent("esx:showNotification", _src, "Vous avez déjà ce laboratoire de "..string.lower(Drugs.Type))
            else
                drugsBasicInfos(Drugs)
                xPlayer.removeAccountMoney('dirtycash', Drugs.Price)
                MySQL.Async.execute('INSERT INTO drugss (owner, type, value, data, production, password) VALUES (@owner, @type, @value, @data, @production, @password)', {
                    ['owner'] = xPlayer.identifier,
                    ['type'] = Drugs.Type,
                    ['value'] = Drugs.Value,
                    ['data'] = json.encode(Drugs.Data),
                    ['production'] = DrugsProductionInfos(Drugs.Type, 1),
                    ['password'] = randomNumber
                })
                Wait(350)
                TriggerClientEvent("esx:showNotification", _src, "Vous avez acheté un laboratoire de "..string.lower(Drugs.Type).." pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Drugs.Price.." $")
                TriggerClientEvent("Laboratories:AddWaypoint", _src, Drugs)
                TriggerClientEvent("Laboratories:refreshLaboratories", -1)
                Drugs = {}
            end
        end)
    end)
end)

RegisterServerEvent("Laboratories:Interact")
AddEventHandler("Laboratories:Interact", function(LaboType, LaboIndex)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    SetTimeout(350, function()
        MySQL.Async.fetchAll('SELECT * FROM drugss WHERE type = @type AND value = @value', {
            ["type"] = LaboType,
            ["value"] = LaboIndex
        }, function(drugsData)
            if drugsData[1] then 
                for k,v in pairs(drugsData) do
                    drugsData[k].data = json.decode(v.data)
                    drugsData[k].storage = json.decode(v.storage)
                    drugsData[k].production = json.decode(v.production)
                end
                TriggerClientEvent("Laboratories:OpenInteractMenu", _src, drugsData, xPlayer.identifier)
            end
        end)
    end)
end)

RegisterServerEvent("Laboratories:OpenComputer")
AddEventHandler("Laboratories:OpenComputer", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    TriggerClientEvent("Laboratories:OpenComputerMenu", _src, xPlayer.getIdentifier())
end)

RegisterServerEvent("Laboratories:EnteringLaboratories")
AddEventHandler("Laboratories:EnteringLaboratories", function(laboId, LaboType, LaboIndex)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local coords = {}
    local targetCoords = xPlayer.getCoords()
	savedCoords[_src] = targetCoords
    if Labo[laboId] then 
        for k,v in pairs(Labo) do 
            if k == laboId then
                if Labo[k] then 
                    if Labo[k].players then 
                        table.insert(Labo[k].players, {
                            id = _src
                        })
                    else
                        Labo[k].players = {}
                        table.insert(Labo[k].players, {
                            id = _src
                        })
                    end
                end
            end
        end 
    else
        Labo[laboId] = {}
        Labo[laboId].players = {}
        table.insert(Labo[laboId].players, {
            id = _src
        })
    end
    local bucketId = 1545477 + laboId
    if LaboType == nil then return end 
    SetTimeout(350, function()
        MySQL.Async.fetchAll('SELECT * FROM drugss WHERE id = @id AND type = @type AND value = @value', {
            ["id"] = laboId,
            ["type"] = LaboType,
            ["value"] = LaboIndex
        }, function(laboData)
            if laboData[1] then 
                for k,v in pairs(laboData) do
                    laboData[k].data = json.decode(v.data)
                    laboData[k].storage = json.decode(v.storage)
                    laboData[k].production = json.decode(v.production)
                end
                for key, value in pairs (DrugsHandler.Interiors) do 
                    if key == LaboType then 
                        coords = value.Position
                        TriggerClientEvent("Laboratories:SetIntoLaboratories", _src, coords, laboData, LaboType, bucketId)
                    end
                end 
            end
        end)
    end)
end)

RegisterServerEvent("Laboratories:EnteringIntoOtherLaboratories")
AddEventHandler("Laboratories:EnteringIntoOtherLaboratories", function(laboId, LaboType, LaboIndex)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local coords = {}
    local targetCoords = xPlayer.getCoords()
	savedCoords[_src] = targetCoords
    for k,v in pairs(Labo) do 
        if k == laboId then
            if Labo[k] then 
                if Labo[k].players then 
                    table.insert(Labo[k].players, {
                        id = _src
                    })
                else
                    Labo[k].players = {}
                    table.insert(Labo[k].players, {
                        id = _src
                    })
                end
            end
        end
    end 
    local bucketId = 1545477 + laboId
    if LaboType == nil then return end 
    SetTimeout(350, function()
        MySQL.Async.fetchAll('SELECT * FROM drugss WHERE id = @id AND type = @type AND value = @value', {
            ["id"] = laboId,
            ["type"] = LaboType,
            ["value"] = LaboIndex
        }, function(laboData)
            if laboData[1] then 
                for k,v in pairs(laboData) do
                    laboData[k].data = json.decode(v.data)
                    laboData[k].storage = json.decode(v.storage)
                    laboData[k].production = json.decode(v.production)
                end
                for key, value in pairs (DrugsHandler.Interiors) do 
                    if key == LaboType then 
                        coords = value.Position
                        TriggerClientEvent("Laboratories:SetIntoLaboratories", _src, coords, laboData, LaboType, bucketId)
                    end
                end 
            end
        end)
    end)
end)

RegisterServerEvent("Laboratories:ExitInteract")
AddEventHandler("Laboratories:ExitInteract", function(laboId, coords)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    savedCoords[_src] = nil
    for k,v in pairs(Labo) do 
        if k == laboId then
            if Labo[k] then 
                if Labo[k].players then 
                    for t,b in pairs(v.players) do 
                        if #v.players > 1 then 
                            if b.id == _src then 
                                b.id = nil 
                            end
                        else
                            v.players = {}
                        end
                    end
                end
            end
        end
    end
    SetTimeout(350, function()
        TriggerClientEvent("Laboratories:ExitLaboratories", _src, coords)
    end)
end)

AddEventHandler('playerDropped', function (reason)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local playerCoords = savedCoords[_src]

    if xPlayer then
        if playerCoords then 
            xPlayer.setLastPosition(playerCoords);
            savedCoords[_src] = nil
        end
    end
end)
  
RegisterServerEvent("Laboratories:DeleteLaboratories")
AddEventHandler("Laboratories:DeleteLaboratories", function(laboId, laboType, laboValue)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if laboId == nil then return end
    MySQL.Sync.execute("DELETE FROM drugss WHERE id = @id", {
        ["id"] = laboId 
    })
    for key, value in pairs (DrugsHandler.Builds[laboType].Labo) do 
        if key == laboValue then 
            coords = value.Entering
            TriggerClientEvent("Laboratories:ExitLaboratories", _src, coords)
            TriggerClientEvent("Laboratories:refreshLaboratories", _src)
        end
    end    
    for k,v in pairs(Labo) do 
        if laboId == k then 
            for t,b in pairs(v.players) do 
                if b.id ~= nil then 
                    TriggerClientEvent("Laboratories:ExitLaboratories", b.id, coords)
                    TriggerClientEvent("Laboratories:refreshLaboratories", b.id)
                end
            end
        end
    end
    Labo[laboId] = nil 
    TriggerClientEvent("esx:showNotification", _src, "Vous ne possèdez plus ce laboratoire.") 
end)

RegisterServerEvent("Laboratories:UpgradeLaboratories")
AddEventHandler("Laboratories:UpgradeLaboratories", function(upgradeType, upgradeValue, upgradePrice, laboType, laboId, laboData)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local upgrade = DrugsUpgradeInfos(laboType, upgradeValue)
    if xPlayer.getAccount('dirtycash').money  < upgradePrice then 
        return TriggerClientEvent("esx:showNotification", _src, "Vous n'avez pas assez d'argent pour effectuer l'amélioration")
    end
    if upgradeType == "interior" then 
        laboData.interiorStatus = upgradeValue
        laboData.interior = upgrade
    end
    if upgradeType == "details" then 
        if laboType == "Weed" then 
            if upgradeValue == "weed_chairs" then 
                if laboData.details.chairs == true then 
                    return TriggerClientEvent("esx:showNotification", _src, "Vous avez déjà effectué cette amélioration") 
                end
                laboData.details.chairs = true
            end
        end
    end
    xPlayer.removeAccountMoney('dirtycash', upgradePrice)
    TriggerClientEvent("esx:showNotification", _src, "L'amélioration a été effectuée.")
    saveLabo(laboId, laboData)
    SetTimeout(350, function()
        MySQL.Async.fetchAll('SELECT * FROM drugss WHERE id = @id', {
            ["id"] = laboId
        }, function(laboData)
            if laboData[1] then 
                for k,v in pairs(laboData) do
                    laboData[k].data = json.decode(v.data)
                    laboData[k].storage = json.decode(v.storage)
                    laboData[k].production = json.decode(v.production)
                end
                for k,v in pairs(Labo) do 
                    if laboId == k then 
                        for t,b in pairs(v.players) do 
                            if b.id ~= nil then
                                TriggerClientEvent("Laboratories:reloadUpgrade", b.id, laboData, laboType, nil, true)      
                            end
                        end
                    end
                end
            end
        end)
    end)
end)

RegisterServerEvent("Laboratories:DepositItems")
AddEventHandler("Laboratories:DepositItems", function(laboId, laboStorage, itemName, itemCount)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer.getInventoryItem(itemName).count >= itemCount then 
        if not laboStorage[itemName] then 
            laboStorage[itemName] = {}
            laboStorage[itemName].label = ESX.GetItemLabel(itemName)
            laboStorage[itemName].count = itemCount
        else
            laboStorage[itemName].count = laboStorage[itemName].count + itemCount
        end
        MySQL.Async.execute("UPDATE drugss SET storage = @storage WHERE id = @id", {
            ["id"] = laboId,
            ["storage"] = json.encode(laboStorage)
        })
        xPlayer.removeInventoryItem(itemName, itemCount)
        for k,v in pairs(Labo) do 
            if laboId == k then 
                for t,b in pairs(v.players) do 
                    if b.id ~= nil then
                        TriggerClientEvent("Laboratories:updateStorage", b.id, laboStorage)
                    end
                end
            end
        end
    else
        TriggerClientEvent("esx:showNotification", _src, ("Vous n'avez pas assez de %s"):format(ESX.GetItemLabel(itemName)))
    end
end)

RegisterServerEvent("Laboratories:changePassword")
AddEventHandler("Laboratories:changePassword", function(laboId, password)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)
    if laboId then 
        if password == nil then return TriggerClientEvent("esx:showNotification", _src, "Une erreur est survenu") end 
        MySQL.Async.execute("UPDATE drugss SET password = @password WHERE id = @id", {
            ["id"] = laboId,
            ["password"] = password
        })
        for k,v in pairs(Labo) do 
            if laboId == k then 
                for t,b in pairs(v.players) do 
                    if b.id ~= nil then
                        TriggerClientEvent("Laboratories:updatePassword", b.id, password)
                    end
                end
            end
        end
    end
end)

RegisterServerEvent("Laboratories:WithdrawItems")
AddEventHandler("Laboratories:WithdrawItems", function(laboId, laboStorage, itemName, itemCount)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)
    if not laboStorage[itemName] then 
        return TriggerClientEvent("esx:showNotification", _src, "Une erreur est survenu")            
    end
    if laboStorage[itemName].count >= itemCount then
        if not xPlayer.canCarryItem(itemName, itemCount) then 
            return TriggerClientEvent("esx:showNotification", _src, "Vous n'avez pas assez de place sur vous")            
        end 
        if (laboStorage[itemName].count - itemCount) > 0 then 
            laboStorage[itemName].count = laboStorage[itemName].count - itemCount
        else
            laboStorage[itemName] = nil
        end
        MySQL.Async.execute("UPDATE drugss SET storage = @storage WHERE id = @id", {
            ["id"] = laboId,
            ["storage"] = json.encode(laboStorage)
        })
        xPlayer.addInventoryItem(itemName, itemCount)
        for k,v in pairs(Labo) do 
            if laboId == k then 
                for t,b in pairs(v.players) do 
                    if b.id ~= nil then
                        TriggerClientEvent("Laboratories:updateStorage", b.id, laboStorage)
                    end
                end
            end
        end
    else
        return TriggerClientEvent("esx:showNotification", _src, ("Vous n'avez pas autant de %s dans le coffre"):format(ESX.GetItemLabel(itemName)))            
    end
end)

RegisterServerEvent("Laboratories:PurchaseTreatment")
AddEventHandler("Laboratories:PurchaseTreatment", function(laboType)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)
    local ped = GetPlayerPed(_src)
	local coords = GetEntityCoords(ped)

    for key, value in pairs(DrugsHandler.Interiors) do
        if key == laboType then
            if #(coords - value.Treatment) < 1.2 then
                checkPos[_src] = true
            end
        end
    end

    if checkPos[_src] then
        if laboType == "Weed" then 
            if xPlayer.getInventoryItem("weed").count >= 75 then
                TriggerClientEvent("Laboratories:TreatmentAnimation", _src, laboType)
                xPlayer.removeInventoryItem("weed", DrugsHandler.Items[laboType].treatment[1])
                Wait(26000)
                checkPos[_src] = false
                xPlayer.addInventoryItem("weed_pooch", DrugsHandler.Items[laboType].treatment[2])
            else
                TriggerClientEvent("esx:showNotification", _src, ("Vous n'avez pas assez pour traiter ! Il vous faut minimum x75 ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s."):format(string.lower(laboType)))
            end
        end
        if laboType == "Cocaïne" then 
            if xPlayer.getInventoryItem("coke").count >= 60 then
                TriggerClientEvent("Laboratories:TreatmentAnimation", _src, laboType)
                xPlayer.removeInventoryItem("coke", DrugsHandler.Items[laboType].treatment[1])
                Wait(60000)
                checkPos[_src] = false
                xPlayer.addInventoryItem("coke_pooch", DrugsHandler.Items[laboType].treatment[2])
            else
                TriggerClientEvent("esx:showNotification", _src, ("Vous n'avez pas assez pour traiter ! Il vous faut minimum x60 ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s."):format(string.lower(laboType)))
            end
        end
        if laboType == "Meth" then 
            if xPlayer.getInventoryItem("meth").count >= 40 then
                TriggerClientEvent("Laboratories:TreatmentAnimation", _src, laboType)
                xPlayer.removeInventoryItem("meth", DrugsHandler.Items[laboType].treatment[1])
                Wait(45000)
                checkPos[_src] = false
                xPlayer.addInventoryItem("meth_pooch", DrugsHandler.Items[laboType].treatment[2])
            else
                TriggerClientEvent("esx:showNotification", _src, ("Vous n'avez pas assez pour traiter ! Il vous faut minimum x40 ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s."):format(string.lower(laboType)))
            end
        end
    end
end)

RegisterServerEvent("Laboratories:BuySupplies")
AddEventHandler("Laboratories:BuySupplies", function(laboId, laboType, suppliesPrice, yourProduction, yourData)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer.getAccount('dirtycash').money  < suppliesPrice then 
        return TriggerClientEvent("esx:showNotification", _src, "Vous n'avez pas assez d'argent pour acheter les matières premières")
    end
    xPlayer.removeAccountMoney('dirtycash', suppliesPrice)
    if laboType == "Cocaïne" then 
        if yourData.interiorStatus == "upgrade" then 
            yourProduction = DrugsProductionInfos(laboType, 2, 5)
        else
            yourProduction = DrugsProductionInfos(laboType, 2, 3)
        end
    else
        yourProduction = DrugsProductionInfos(laboType, 2)
    end
    TriggerClientEvent("esx:showNotification", _src, "L'achat de matière première a été effectuée.")
    saveProduction(laboId, yourProduction)
    SetTimeout(350, function()
        MySQL.Async.fetchAll('SELECT * FROM drugss WHERE id = @id', {
            ["id"] = laboId
        }, function(laboData)
            if laboData[1] then 
                for k,v in pairs(laboData) do
                    laboData[k].data = json.decode(v.data)
                    laboData[k].storage = json.decode(v.storage)
                    laboData[k].production = json.decode(v.production)
                end
                for k,v in pairs(Labo) do 
                    if laboId == k then 
                        for t,b in pairs(v.players) do 
                            if b.id ~= nil then
                                TriggerClientEvent("Laboratories:reloadUpgrade", b.id, laboData, laboType, 2, true)    
                            end  
                        end
                    end
                end
            end
        end)
    end)
end)

RegisterServerEvent("Laboratories:harvest")
AddEventHandler("Laboratories:harvest", function(laboId, laboInterior, laboType, laboZone, laboAction, laboProduction, laboItem)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)
    local wait = 7500
    local ped = GetPlayerPed(_src)
	local coords = GetEntityCoords(ped)
    checkPos[_src] = false
    if not laboProduction then return TriggerClientEvent("esx:showNotification", _src, "Une erreur est survenu") end

    for key, value in pairs(DrugsHandler.Interiors) do
        if key == laboType then
            for y,u in pairs (value.Harvest) do
                coordss = u.pos
                if #(coords - coordss) < 3.5 then
                    checkPos[_src] = true
                end
            end
        end
    end

    if checkPos[_src] then
        if laboType == "Weed" then
            if laboInterior == "upgrade" then wait = 7500 else wait = 10000 end
            if laboAction == 1 then 
                laboProduction[laboZone] = 3
                TriggerClientEvent("Laboratories:startAnimation", _src, laboId, laboInterior, laboType, laboZone, laboAction, laboProduction, laboItem)
                xPlayer.addXP(10)
            end
            if laboAction == 2 then 
                laboProduction[laboZone] = 4
                TriggerClientEvent("Laboratories:startAnimation", _src, laboId, laboInterior, laboType, laboZone, laboAction, laboProduction, laboItem)
                xPlayer.addXP(10)
            end
            if laboAction == 3 then 
                laboProduction[laboZone] = 1
                if not xPlayer.canCarryItem(laboItem, DrugsHandler.Items[laboType].harvest) then return TriggerClientEvent("esx:showNotification", _src, "Vous n'avez pas assez de place sur vous") end
                TriggerClientEvent("Laboratories:startAnimation", _src, laboId, laboInterior, laboType, laboZone, laboAction, laboProduction, laboItem)
                xPlayer.addXP(20)
                xPlayer.addInventoryItem("weed", DrugsHandler.Items[laboType].harvest)
            end
        elseif laboType == "Cocaïne" then 
            if laboAction == 1 then 
                laboProduction[laboZone] = 1
                if not xPlayer.canCarryItem(laboItem, DrugsHandler.Items[laboType].harvest) then return TriggerClientEvent("esx:showNotification", _src, "Vous n'avez pas assez de place sur vous") end
                TriggerClientEvent("Laboratories:startAnimation", _src, laboId, laboInterior, laboType, laboZone, laboAction, laboProduction, laboItem)
                wait = 15000
                xPlayer.addXP(20)
                xPlayer.addInventoryItem("coke", DrugsHandler.Items[laboType].harvest)
            end
        elseif laboType == "Meth" then 
            if laboAction == 1 then 
                laboProduction[laboZone] = 1
                if not xPlayer.canCarryItem(laboItem, DrugsHandler.Items[laboType].harvest) then return TriggerClientEvent("esx:showNotification", _src, "Vous n'avez pas assez de place sur vous") end
                TriggerClientEvent("Laboratories:startAnimation", _src, laboId, laboInterior, laboType, laboZone, laboAction, laboProduction, laboItem)
                wait = 70000
                xPlayer.addXP(20)
                xPlayer.addInventoryItem("meth", DrugsHandler.Items[laboType].harvest)
            end
        end
        saveProduction(laboId, json.encode(laboProduction))
        Wait(500)
        checkPos[_src] = false
        MySQL.Async.fetchAll('SELECT * FROM drugss WHERE id = @id', {
            ["id"] = laboId
        }, function(laboData)
            if laboData[1] then 
                for k,v in pairs(laboData) do
                    laboData[k].data = json.decode(v.data)
                    laboData[k].storage = json.decode(v.storage)
                    laboData[k].production = json.decode(v.production)
                end
                for k,v in pairs(Labo) do 
                    if laboId == k then 
                        for t,b in pairs(v.players) do 
                            if b.id ~= nil then
                                TriggerClientEvent("Laboratories:reloadIpl", b.id, laboData, laboType, 2, false, wait)          
                            end
                        end
                    end
                end
            end
        end)
    end
end)