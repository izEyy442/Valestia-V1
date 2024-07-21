ESX = nil

TriggerEvent(Config.ESX, function(obj)
    ESX = obj
end)

RegisterServerEvent('gouv:payWeapon')
AddEventHandler('gouv:payWeapon', function(prix, name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= "gouv" then
        xPlayer.ban(0, '(gouv:payWeapon)');
        return
    end

    xPlayer.addWeapon(name, 250)
    xPlayer.showNotification('Vous avez bien récupéré votre arme !')
end)

RegisterServerEvent('gouv:payArmor')
AddEventHandler('gouv:payArmor', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= "gouv" then
        xPlayer.ban(0, '(gouv:payArmor)');
        return
    end
    if xPlayer.canCarryItem('kevlar', 1) then
        xPlayer.addInventoryItem('kevlar', 1)
    else
        xPlayer.showNotification('Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

-- johnny

ClothesPlayer = {}

Citizen.CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM clothes_societies ", {}, function(result)
        for k, v in pairs(result) do
            if not ClothesPlayer[v.identifier] then
                ClothesPlayer[v.identifier] = {}
            end
            if not ClothesPlayer[v.identifier][v.id] then
                ClothesPlayer[v.identifier][v.id] = {}
            end
            ClothesPlayer[v.identifier][v.id].identifier = v.identifier
            ClothesPlayer[v.identifier][v.id].label = v.label
            ClothesPlayer[v.identifier][v.id].skin = v.skin
            ClothesPlayer[v.identifier][v.id].type = v.type
            ClothesPlayer[v.identifier][v.id].equip = v.equip
            ClothesPlayer[v.identifier][v.id].id = v.id
        end
    end)
end)

RegisterNetEvent("johnny:addtenue", function(label, skin)
    local NumberCount = 0
    local xPlayer = ESX.GetPlayerFromId(source)
    local NumberTenueAutorized = 9999
    if not ClothesPlayer[xPlayer.identifier] then
        NumberCount = 0
    else
        NumberCount = 0
    end

    if NumberCount + 1 > NumberTenueAutorized then
        xPlayer.showNotification('Vous avez déjà trop de tenue.')
    else
        local IdTenue = math.random(11111, 99999)
        local IdTenue2 = math.random(11111, 99999)
        local ValidateID = IdTenue + IdTenue2

        if not ClothesPlayer[xPlayer.identifier][ValidateID] then
            ClothesPlayer[xPlayer.identifier][ValidateID] = {}
            ClothesPlayer[xPlayer.identifier][ValidateID].identifier = xPlayer.identifier
            ClothesPlayer[xPlayer.identifier][ValidateID].label = label
            ClothesPlayer[xPlayer.identifier][ValidateID].type = "vetement"
            ClothesPlayer[xPlayer.identifier][ValidateID].equip = "n"
            ClothesPlayer[xPlayer.identifier][ValidateID].skin = json.encode(skin)
            ClothesPlayer[xPlayer.identifier][ValidateID].id = ValidateID
        end
        MySQL.Async.execute(
            "INSERT INTO clothes_societies (label, skin, type, identifier) VALUES (@label, @skin, @type, @identifier)",
            {
                ["@label"] = tostring(label),
                ["@skin"] = json.encode(skin),
                ["@type"] = "vetement",
                ["@identifier"] = xPlayer.identifier
            })
        xPlayer.showNotification('Vous avez crée une tenue (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~' .. label .. '~w~)')
        TriggerClientEvent("johnny:recieveclientsidevetement", xPlayer.source, ClothesPlayer[xPlayer.identifier])

    end
end)

RegisterNetEvent('johnny:RenameTenue', function(id, NewLabel)
    local xPlayer = ESX.GetPlayerFromId(source)
    if ClothesPlayer[xPlayer.identifier][id] then
        if ClothesPlayer[xPlayer.identifier][id].identifier == xPlayer.identifier then
            xPlayer.showNotification('Vous avez renommer votre tenue (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~' ..
                                         ClothesPlayer[xPlayer.identifier][id].label .. '~w~)')
            ClothesPlayer[xPlayer.identifier][id].label = NewLabel
            TriggerClientEvent("johnny:recieveclientsidevetement", xPlayer.source, ClothesPlayer[xPlayer.identifier])
            MySQL.Async.execute("UPDATE clothes_societies set label = @label WHERE id = @id", {
                ["@label"] = tostring(NewLabel),
                ["@id"] = id
            })
        else
            DropPlayer(source, 'Mhh c\'est chaud c\'que t\'essaie de faire')
        end
    end
end)

RegisterNetEvent('johnny:deletetenue', function(id, NewLabel)
    local xPlayer = ESX.GetPlayerFromId(source)
    if ClothesPlayer[xPlayer.identifier][id] then
        if ClothesPlayer[xPlayer.identifier][id].identifier == xPlayer.identifier then
            xPlayer.showNotification('Vous avez supprimer votre tenue (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~' ..
                                         ClothesPlayer[xPlayer.identifier][id].label .. '~w~)')
            ClothesPlayer[xPlayer.identifier][id] = nil
            TriggerClientEvent("johnny:recieveclientsidevetement", xPlayer.source, ClothesPlayer[xPlayer.identifier])
            MySQL.Async.execute("DELETE FROM clothes_societies WHERE id = @id", {
                ["@id"] = id
            })
        else
            DropPlayer(source, 'Mhh c\'est chaud c\'que t\'essaie de faire')
        end
    end
end)

RegisterNetEvent("RecieveVetement", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if not ClothesPlayer[xPlayer.identifier] then
        ClothesPlayer[xPlayer.identifier] = {}
        TriggerClientEvent("johnny:recieveclientsidevetement", xPlayer.source, nil)
    else
        TriggerClientEvent("johnny:recieveclientsidevetement", xPlayer.source, ClothesPlayer[xPlayer.identifier])
    end
end)

RegisterServerEvent('gouv:taxi')
AddEventHandler('gouv:taxi', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'taxi'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Taxi possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:cardealer')
AddEventHandler('gouv:cardealer', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'cardealer'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Concessionnaire possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:boatshop')
AddEventHandler('gouv:boatshop', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'boatshop'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Concessionnaire Bateaux possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money ..
                    " $")
        end
    end)
end)

RegisterServerEvent('gouv:planeshop')
AddEventHandler('gouv:planeshop', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'boatshop'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Concessionnaire Avions possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money ..
                    " $")
        end
    end)
end)

RegisterServerEvent('gouv:unicorn')
AddEventHandler('gouv:unicorn', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'unicorn'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Unicorn possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:avocat')
AddEventHandler('gouv:avocat', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'avocat'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Avocat possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:vigneron')
AddEventHandler('gouv:vigneron', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'vigneron'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Vigneron possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:journalist')
AddEventHandler('gouv:journalist', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'journalist'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Journaliste possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:mecano2')
AddEventHandler('gouv:mecano2', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'mecano2'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Ls Custom possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:mecano')
AddEventHandler('gouv:mecano', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'mecano2'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Benny's possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:bahamas')
AddEventHandler('gouv:bahamas', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'bahamas'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du Bahamas possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:police')
AddEventHandler('gouv:police', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'police'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du LSPD possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:bcso')
AddEventHandler('gouv:bcso', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'bcso'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du B.C.S.O possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:fib')
AddEventHandler('gouv:fib', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'fib'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte des Us Marsahall possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:ambulance')
AddEventHandler('gouv:ambulance', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'ambulance'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte des EMS possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:ltd')
AddEventHandler('gouv:ltd', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'ltd'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte des LTD Litle Seoul possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:ltd2')
AddEventHandler('gouv:ltd', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'ltd2'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte des LTD Miror Park possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

RegisterServerEvent('gouv:mecano3')
AddEventHandler('gouv:mecano3', function(id)
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = 'mecano3'", {}, function(result)
        for index, data in pairs(result) do
            TriggerClientEvent('esx:showNotification', _src,
                "Le compte du mecano North Mecano possède ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ " .. data.money .. " $")
        end
    end)
end)

AddEventHandler("playerDropped", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.hasWeapon("weapon_advancedrifle") then
            xPlayer.removeWeapon("weapon_advancedrifle")
        elseif xPlayer.hasWeapon("weapon_stungun") then
            xPlayer.removeWeapon("weapon_stungun")
        elseif xPlayer.hasWeapon("weapon_combatpistol") then
            xPlayer.removeWeapon("weapon_combatpistol")
        end
    end
end)
