--[[
----
----Created Date: 3:17 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Events]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@param plate string
---@param xPlayer xPlayer
local function removeFromTable(plate, xPlayer)

    if (Garage.VehiclesOut[plate]) then

        Garage.VehiclesOut[plate] = nil;

    end

    xPlayer.showNotification(Shared.Lang:Translate("garage_vehicle_parked"));

end

Shared.Events:OnNet(Enums.Garage.Events.RequestVehicles, function(xPlayer)
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier", {
        ["@identifier"] = xPlayer.getIdentifier();
    }, function(vehicles)

        local playerVehicles = {};

        if (#vehicles > 0) then

            for i = 1, #vehicles do

                if (vehicles[i]) then

                    local mods = json.decode(vehicles[i].vehicle);

                    if (mods) then

                        playerVehicles[#playerVehicles + 1] = {
                            plate = vehicles[i].plate,
                            model = mods.model,
                            stored = vehicles[i].stored
                        };

                    end

                end

            end

        end

        Shared.Events:ToClient(xPlayer.source, Enums.Garage.Events.ReceiveVehicles, playerVehicles);

    end);
end);

Shared.Events:OnNet(Enums.Garage.Events.TakeVehicle, function(xPlayer, vehiclePlate)

    local plate = Shared.Vehicle:ConvertPlate(vehiclePlate);
    if (JG.VehicleManager:GetVehicleByPlate(vehiclePlate)) then
        Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
        return xPlayer.showNotification(Shared.Lang:Translate("pound_vehicle_exist", vehiclePlate));
    end

    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND stored = 1", {
        ["@owner"] = xPlayer.getIdentifier(),
        ["@plate"] = vehiclePlate,
    }, function(result)

        if (#result > 0) then

            local ped = GetPlayerPed(xPlayer.source);
            local playerCoords = GetEntityCoords(ped);
            local props = json.decode(result[1].vehicle);
            local position = Garage.GetInArea(playerCoords, "Spawn");

            if (position) then

                Shared.Events:ToClient(xPlayer.source, Enums.Garage.Events.RefreshVehicles);

                JG.VehicleManager:CreateVehicle(props.model, position["Out"], position["Out"]["heading"], props.plate, function(vehicle, defaultProperties)

                    Garage.VehiclesOut[plate] = vehicle:GetHandle();

                    local propsData = Shared.Table:SizeOf(props) > 2 and props or nil;

                    if (not propsData) then

                        props = defaultProperties;
                        props["plate"] = props.plate;

                    end

                    vehicle:SetProperties(props, xPlayer, function()

                        if (Config["Garage"]["Vehicles"]["SpawnIn"]) then

                            local ped = GetPlayerPed(xPlayer.source);

                            SetPedIntoVehicle(ped, vehicle:GetHandle(), -1);

                        end

                        if (Config["Garage"]["Vehicles"]["SpawnLocked"]) then
                            vehicle:SetLocked(true);
                        end

                        if (Garage.VehiclesOut[plate]) then

                            Garage.VehiclesOut[plate] = nil;

                        end

                    end);

                    MySQL.Async.execute("UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate", {
                        ["@stored"] = 0,
                        ["@plate"] = vehiclePlate
                    });

                end, xPlayer);

            else

                Shared.Events:ToClient(xPlayer.source, Enums.Garage.Events.RefreshVehicles);
                xPlayer.showNotification(Shared.Lang:Translate("error_occured"));

            end

        else

            Shared.Events:ToClient(xPlayer.source, Enums.Garage.Events.RefreshVehicles);
            xPlayer.showNotification(Shared.Lang:Translate("error_occured"));

        end

    end);

end);

Shared.Events:OnNet(Enums.Garage.Events.ParkVehicle, function(xPlayer, vehiclePlate)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = vehiclePlate
    }, function (result)
        if result[1] ~= nil then
            local plate = Shared.Vehicle:ConvertPlate(vehiclePlate);
            local vehicle = JG.VehicleManager:GetVehicleByPlate(vehiclePlate);
            if (vehicle) then 
                TaskLeaveVehicle(GetPlayerPed(xPlayer.source), vehicle:GetHandle(), 0);
                vehicle:RequestProperties(xPlayer, function(properties)
                    MySQL.Async.execute("UPDATE owned_vehicles SET stored = 1, vehicle = @props WHERE plate = @plate", {
                        ["@plate"] = vehiclePlate,
                        ["@props"] = json.encode(properties);
                    });
                    SetTimeout(1500, function()
                        removeFromTable(plate, xPlayer);
                        JG.VehicleManager:RemoveVehicle(plate);
                    end);
                end);
            else
                xPlayer.showNotification(Shared.Lang:Translate("error_occured"));
            end
        else
            xPlayer.showNotification(Shared.Lang:Translate("garage_vehicle_not_owned"));
        end
    end);
end);

Shared.Events:OnNet(Enums.Garage.Events.GiveVehicle, function(xPlayer, playerId, plate)
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate", {
        ["@owner"] = xPlayer.getIdentifier(),
        ["@plate"] = plate
    }, function(result)
        if (#result > 0) then
            if (result[1].boutique ~= nil and result[1].boutique == 1 or result[1].boutique == true) then
                xPlayer.showNotification(Shared.Lang:Translate("garage_vehicle_boutique"));
                Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
            else

                local xTarget = ESX.GetPlayerFromId(playerId);
                if (xTarget) then
                    MySQL.Async.execute("UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate", {
                        ["@owner"] = xTarget.getIdentifier(),
                        ["@plate"] = plate
                    }, function()
                        local key = JG.KeyManager:GetKey("vehicle", Shared.Vehicle:ConvertPlate(plate));
                        if (key) then
                            key:SetDefaultOwner(xTarget);
                            if (key:GetOwner() == xPlayer.getIdentifier()) then
                                key:SetOwner(xTarget, true);
                            end
                        end
                        xPlayer.showNotification(Shared.Lang:Translate("garage_player_give", plate, xTarget.getName()));
                        xTarget.showNotification(Shared.Lang:Translate("garage_player_receive", plate, xPlayer.getName()));
                        Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
                        Shared.Events:ToClient(xTarget, Enums.Garage.Events.RefreshVehicles);
                    end);
                else
                    Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
                    xPlayer.showNotification(Shared.Lang:Translate("error_occured"));
                end

            end
        else
            Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
            xPlayer.showNotification(Shared.Lang:Translate("error_occured"));
        end
    end);
end);

Shared.Events:OnNet(Enums.Garage.Events.RequestSent, function(xPlayer, targetId, vehiclePlate, price)
    local xTarget = ESX.GetPlayerFromId(targetId);
    if (xTarget) then
        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate", {
            ["@owner"] = xPlayer.getIdentifier(),
            ["@plate"] = vehiclePlate
        }, function(result)

            if (#result > 0) then

                if (result[1].boutique ~= nil and result[1].boutique == 1 or result[1].boutique == true) then

                    xPlayer.showNotification(Shared.Lang:Translate("garage_vehicle_boutique"));
                    Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
                    Shared.Events:ToClient(xTarget, Enums.Garage.Events.RefreshVehicles);

                else

                    Shared.Events:ToClient(xTarget, Enums.Garage.Events.RequestAuthorisation,
                        vehiclePlate, 
                        xPlayer:getName(), 
                        price, 
                        xPlayer.source
                    );

                end

            end
            
        end);
    end
end);

Shared.Events:OnNet(Enums.Garage.Events.RequestCanceled, function(xPlayer, playerId)
    local xTarget = ESX.GetPlayerFromId(playerId);
    Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
    if (xTarget) then
        Shared.Events:ToClient(xTarget, Enums.Garage.Events.RefreshVehicles);
        xTarget.showNotification(Shared.Lang:Translate("garage_request_canceled"));
    end
end);

Shared.Events:OnNet(Enums.Garage.Events.RequestAccepted, function(xPlayer, senderId, price, vehiclePlate)
    local xSender = ESX.GetPlayerFromId(senderId);

    if (xSender) then
        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate", {
            ["@owner"] = xSender.getIdentifier(),
            ["@plate"] = vehiclePlate
        }, function(result)
            if (#result > 0) then
                local xPlayerAccount = xPlayer.getAccount(Config["Accounts"]["money"]);
                if (xPlayerAccount.money >= price) then
                    MySQL.Async.execute("UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate", {
                        ["@owner"] = xPlayer.getIdentifier(),
                        ["@plate"] = vehiclePlate
                    }, function()
                        xPlayer.removeAccountMoney(Config["Accounts"]["money"], price);
                    xSender.addAccountMoney(Config["Accounts"]["money"], price);
                        local key = JG.KeyManager:GetKey("vehicle", Shared.Vehicle:ConvertPlate(vehiclePlate));
                        if (key) then
                            key:SetDefaultOwner(xPlayer);
                            if (key:GetOwner() == xSender.getIdentifier()) then
                                key:SetOwner(xPlayer, true);
                            end
                        end
                        Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
                        Shared.Events:ToClient(xSender, Enums.Garage.Events.RefreshVehicles);
                        xPlayer.showNotification(Shared.Lang:Translate("garage_buy_vehicle", vehiclePlate, xSender.getName()));
                        xSender.showNotification(Shared.Lang:Translate("garage_sell_vehicle", vehiclePlate, xPlayer.getName()));
                    end);
                else
                    Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
                    Shared.Events:ToClient(xSender, Enums.Garage.Events.RefreshVehicles);
                    xPlayer.showNotification(Shared.Lang:Translate("player_not_enought_money"));
                    xSender.showNotification(Shared.Lang:Translate("target_not_enought_money", xPlayer.getName()));
                    return
                end
            else
                Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
                Shared.Events:ToClient(xSender, Enums.Garage.Events.RefreshVehicles);
                xSender.showNotification(Shared.Lang:Translate("error_occured"));
            end
        end);
    else
        Shared.Events:ToClient(xPlayer, Enums.Garage.Events.RefreshVehicles);
        Shared.Events:ToClient(xSender, Enums.Garage.Events.RefreshVehicles);
        xSender.showNotification(Shared.Lang:Translate("error_occured"));
    end
end);

Shared.Events:OnNet(Enums.Garage.Events.LocateVehicle, function(xPlayer, vehiclePlate)

    if (not xPlayer or type(vehiclePlate) ~= "string") then
        return
    end

    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND stored = 0", {
        ["@owner"] = xPlayer.getIdentifier(),
        ["@plate"] = vehiclePlate,
    }, function(result)

        if (#result > 0) then

            local vehicle_is_in_pound = true;
            local vehicle_selected = JG.VehicleManager:GetVehicleByPlate(vehiclePlate)

            if (vehicle_selected ~= nil) then

                local vehicle_entity = vehicle_selected:GetHandle()

                if (vehicle_entity ~= 0 and DoesEntityExist(vehicle_entity)) then

                    vehicle_is_in_pound = { position = GetEntityCoords(vehicle_entity) };

                else

                    vehicle_is_in_pound = true;

                end

            else

                vehicle_is_in_pound = true;

            end

            if (type(vehicle_is_in_pound) == "table") then

                xPlayer.showNotification("Votre véhicule a été localisé, envoi de la position GPS....")
                xPlayer.triggerEvent(Enums.Player.Events.SetWaypoint, vehicle_is_in_pound.position)

            else

                xPlayer.showNotification("Votre véhicule se trouve actuellement en fourrière.")

            end

        else

            xPlayer.kick(("Event (%s) erreur détectée."):format(Enums.Garage.Events.LocateVehicle))
            return

        end

    end)

end)