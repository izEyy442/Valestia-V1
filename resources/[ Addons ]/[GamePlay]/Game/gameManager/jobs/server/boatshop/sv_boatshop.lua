--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil
local outsideBoat = {};

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

ESX.RegisterServerCallback('BoatShop:getBoatCategories', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if xPlayer.job.name ~= 'boatseller' then
            xPlayer.ban(0, '(BoatShop:getBoatCategories)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('BoatShop:getAllVehicles', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if xPlayer.job.name ~= 'boatseller' then
            xPlayer.ban(0, '(BoatShop:getAllVehicles)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM vehicles', {
        }, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('BoatShop:getSocietyMoney', function(source, cb)
    cb(ESX.GetSocietyMoney("boatseller"));
end)

ESX.RegisterServerCallback('BoatShop:getSocietyVehicles', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if xPlayer.job.name ~= 'boatseller' then
            xPlayer.ban(0, '(BoatShop:getSocietyVehicles)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM cardealer_vehicles WHERE society = @a', {
            ['@a'] = 'society_boatseller'
        }, function(result)
            cb(result)
        end)
    end
end)

RegisterServerEvent('BoatShop:changeBucket')
AddEventHandler('BoatShop:changeBucket', function(reason)
    local source = source
    if reason == "enter" then
        SetPlayerRoutingBucket(source, source+1)
    else
        SetPlayerRoutingBucket(source, 0)
    end
end)

RegisterServerEvent('BoatShop:buyVehicle')
AddEventHandler('BoatShop:buyVehicle', function(props, name, price)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= "boatseller" then
        xPlayer.ban(0, '(BoatShop:buyVehicle)');
        return
    end

    local society = ESX.DoesSocietyExist("boatseller");

    if (society) then

        MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
            ['@a']   = props,
            ['@b']   = name,
            ['@c']   = price,
            ['@d']   = 'society_boatseller'
        }, function()

            ESX.RemoveSocietyMoney("boatseller", tonumber(price));

        end);

    else

        xPlayer.showNotification("Une erreur est survenue, Code erreur ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'boatseller_buyVehicle_error'~s~. Veuillez contacter un ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~administrateur~s~.");

    end

end);

RegisterServerEvent('BoatShop:removesocietyboat', function(id, model, plate, menuData)
    local src = source;
    local xPlayer = ESX.GetPlayerFromId(src);
    if (xPlayer.job.name == "boatseller") then
        MySQL.Async.execute('DELETE FROM cardealer_vehicles WHERE id = @id', {
            ['@id'] = id
        }, function()
            local vehicleModel = type(model) == 'number' and model or GetHashKey(model);
            ESX.SpawnVehicle(vehicleModel, vector3(-767.2656, -1379.502, -0.412491), 233.94, plate, true, xPlayer, function(handle, props)
                --CreateThread(function()

                    --while not (DoesEntityExist(handle)) do
                        --Wait(100);
                    --end

                    xPlayer.triggerEvent("BoatShop:onSpawnVehicle", menuData, NetworkGetNetworkIdFromEntity(handle), props);
                    outsideBoat[#outsideBoat + 1] = {handle = handle, plate = plate, model = model, price = menuData.price, name = menuData.name};

                --end);
            end);
        end);
    end
end)

RegisterServerEvent('BoatShop:recupvehicle')
AddEventHandler('BoatShop:recupvehicle', function(vehicle, name, price, society)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'boatseller' then
        xPlayer.ban(0, '(BoatShop:recupvehicle)');
        return
    end
    MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
        ['@a']   = vehicle,
        ['@b']   = name,
        ['@c']   = price,
        ['@d']   = 'society_boatseller'
    }, function(rowsChange)
    end)
end)

RegisterServerEvent('BoatShop:sellthevehicle')
AddEventHandler('BoatShop:sellthevehicle', function(player, props)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)

    if xPlayer.job.name ~= "boatseller" then
        xPlayer.ban(0, '(BoatShop:sellthevehicle)');
    else
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state) VALUES (@owner, @plate, @vehicle, @state)', {
            ['@owner']   = tPlayer.identifier,
            ['@plate']   = props.plate,
            ['@vehicle'] = json.encode(props),
            ['@state']   = 0
        }, function()
            ESX.GiveCarKey(tPlayer, props.plate);
            for i = 1, #outsideBoat do
                local vehicle = outsideBoat[i];
                if (vehicle.plate == props.plate) then
                    table.remove(outsideBoat, i);
                    break;
                end
            end
        end)


        local link = "https://discord.com/api/webhooks/1236630492607021117/rw0olPHAWzaoGCN87oe8vVkKQDXPjsnNGCNvfPEIHf6uDI3hIkyHEmMgDlOctLlgKTka"
        local buyerName  = tPlayer.getName(player)
        local buyerLicense = tPlayer.identifier

        local sellerName  = xPlayer.getName(source)
        local sellerLicense = xPlayer.identifier

        local local_date = os.date('%H:%M:%S', os.time())
        local content = {
            {
                ["title"] = "**Achat Bateau :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Acheteur :", value = buyerName.." ["..buyerLicense.."]" },
                    { name = "- Vendeur :", value = sellerName.." ["..sellerLicense.."]" },
                    { name = "- Information facture : :", value = "Bateau : "..model.."\nMontant payer : "..theprice.."$\nPlaque : "..props.plate },
                },
                ["type"]  = "rich",
                ["color"] = 16711680,
                ["footer"] =  {
                ["text"] = "By t0nnnio | Valestia",
                },
            }
        }
        PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Vente Bateau", embeds = content}), { ['Content-Type'] = 'application/json' })

    end
end)

local function storeBoat(vehicleModel, vehicleName, price)
    MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
        ['@a']   = vehicleModel,
        ['@b']   = vehicleName,
        ['@c']   = price,
        ['@d']   = 'society_boatseller'
    }, function(rowsChange)
    end)
end

RegisterNetEvent("boatseller:deleteAllVehicles", function()
    local src = source;
    local xPlayer = ESX.GetPlayerFromId(src);
    if (xPlayer.job.name == "boatseller") then
        for i = 1, #outsideBoat do
            local vehicle = outsideBoat[i];
            ESX.RemoveVehicle(vehicle.plate, function()
                storeBoat(vehicle.model, vehicle.name, vehicle.price);
            end);
        end
        outsideBoat = {};
    end
end);

local TimeoutJob2 = {};

RegisterServerEvent('Ouvre:BoatShop')
AddEventHandler('Ouvre:BoatShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob2[xPlayer.identifier] or GetGameTimer() - TimeoutJob2[xPlayer.identifier] > 600000) then
		TimeoutJob2[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "boatseller" then
            xPlayer.ban(0, '(Ouvre:BoatShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if (player) then
                player.showAdvancedNotification('Bateau', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Le concessionnaire Bateau est désormais Ouvert~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
            end
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:BoatShop')
AddEventHandler('Ferme:BoatShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob2[xPlayer.identifier] or GetGameTimer() - TimeoutJob2[xPlayer.identifier] > 600000) then
		TimeoutJob2[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "boatseller" then
            xPlayer.ban(0, '(Ferme:BoatShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if (player) then
                player.showAdvancedNotification('Bateau', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Le concessionnaire Bateau est désormais Fermer~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
            end
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:BoatShop')
AddEventHandler('Recrutement:BoatShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob2[xPlayer.identifier] or GetGameTimer() - TimeoutJob2[xPlayer.identifier] > 600000) then
		TimeoutJob2[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "boatseller" then
            xPlayer.ban(0, '(Recrutement:BoatShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local player = ESX.GetPlayerFromId(xPlayers[i])
            if (player) then
                player.showAdvancedNotification('Bateau', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annonce', 'Le concessionnaire Bateau recrute, rendez-vous au concessionnaire Bateau !', 'CHAR_MP_STRIPCLUB_PR', 8)
            end
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)