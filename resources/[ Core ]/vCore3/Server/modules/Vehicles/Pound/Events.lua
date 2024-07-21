--[[
----
----Created Date: 4:53 Sunday October 16th 2022
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

Shared.Events:OnNet(Enums.Pound.Events.RequestVehicles, function(xPlayer)
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier AND stored = 0", {
        ["@identifier"] = xPlayer.getIdentifier();
    }, function(vehicles)

        local playerVehicles = {};

        if (#vehicles > 0) then

            for i = 1, #vehicles do

                local mods = json.decode(vehicles[i].vehicle);

                if (mods) then

                    playerVehicles[#playerVehicles + 1] = {
                        plate = mods.plate,
                        model = mods.model,
                        stored = vehicles[i].stored
                    };

                end

            end

        end

        Shared.Events:ToClient(xPlayer, Enums.Pound.Events.ReceiveVehicles, playerVehicles);

    end);
end);

Shared.Events:OnNet(Enums.Pound.Events.TakeVehicle, function(xPlayer, vehiclePlate)

    local plate = Shared.Vehicle:ConvertPlate(vehiclePlate);

    if (JG.VehicleManager:GetVehicleByPlate(vehiclePlate)) then
        Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
        return xPlayer.showNotification(Shared.Lang:Translate("pound_vehicle_exist", vehiclePlate));
    end

    if (Garage.VehiclesOut[plate]) then

        if (DoesEntityExist(Garage.VehiclesOut[plate])) then
            Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
            return xPlayer.showNotification(Shared.Lang:Translate("pound_vehicle_exist", vehiclePlate));
        end
        Garage.VehiclesOut[plate] = nil;

    end

    xPlayer.updateVIP(function(vip_level)

        vip_level = tonumber(vip_level) or 0

        local account = xPlayer.getAccount(Config["Accounts"]["money"]);

        if (account) then

            local price_to_pay = (type(vip_level) == "number" and vip_level == 3) and 0 or Config["Pound"]["Prices"]["SpawnVehicle"]

            if (account.money >= price_to_pay) then

                MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND stored = 0", {
                    ["@owner"] = xPlayer.getIdentifier(),
                    ["@plate"] = vehiclePlate,
                }, function(result)

                    if (#result > 0) then

                        local ped = GetPlayerPed(xPlayer.source);
                        local playerCoords = GetEntityCoords(ped);
                        local props = json.decode(result[1].vehicle);
                        local position = Pound.GetInArea(playerCoords, "Menu");

                        if (position) then

                            if (price_to_pay > 0) then
                                xPlayer.removeAccountMoney(Config["Accounts"]["money"], price_to_pay)
                            end

                            xPlayer.showNotification((price_to_pay > 0 and Shared.Lang:Translate("player_paid", price_to_pay) or "L'assurance à pris en charge les honoraires !"))

                            JG.VehicleManager:CreateVehicle(props.model, position["Spawn"], position["Spawn"]["heading"], props.plate, function(vehicle, defaultProperties)

                                Garage.VehiclesOut[plate] = vehicle:GetHandle();

                                local propsData = Shared.Table:SizeOf(props) > 2 and props or nil;

                                if (not propsData) then

                                    props = defaultProperties;
                                    props["plate"] = props.plate;

                                end

                                vehicle:SetProperties(props, xPlayer, function()

                                    if (Config["Pound"]["Vehicles"]["SpawnIn"]) then

                                        local ped = GetPlayerPed(xPlayer.source);

                                        SetPedIntoVehicle(ped, vehicle:GetHandle(), -1);

                                    end

                                    if (Config["Pound"]["Vehicles"]["SpawnLocked"]) then
                                        vehicle:SetLocked(true);
                                    end

                                end);

                            end, xPlayer);

                        else

                            Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
                            xPlayer.showNotification(Shared.Lang:Translate("error_occured"));

                        end

                    else

                        Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
                        xPlayer.showNotification(Shared.Lang:Translate("error_occured"));

                    end

                end);

            else

                Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
                xPlayer.showNotification(Shared.Lang:Translate("player_not_enought_money"));

            end

        else
            Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
            xPlayer.showNotification(Shared.Lang:Translate("error_occured"));
        end

    end)

end);

Shared.Events:OnNet(Enums.Pound.Events.StoreVehicle, function(xPlayer, vehiclePlate)

    local plate = Shared.Vehicle:ConvertPlate(vehiclePlate);
    if (JG.VehicleManager:GetVehicleByPlate(vehiclePlate)) then
        Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
        return xPlayer.showNotification(Shared.Lang:Translate("pound_vehicle_exist", vehiclePlate));
    end

    if (Garage.VehiclesOut[plate]) then
        if (DoesEntityExist(Garage.VehiclesOut[plate])) then
            Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
            return xPlayer.showNotification(Shared.Lang:Translate("pound_vehicle_exist", vehiclePlate));
        end
    end

    xPlayer.updateVIP(function(vip_level)

        vip_level = tonumber(vip_level) or 0

        local account = xPlayer.getAccount(Config["Accounts"]["money"]);

        if (account) then

            local price_to_pay = (type(vip_level) == "number" and vip_level == 3) and 0 or Config["Pound"]["Prices"]["StoreVehicle"]

            if (account.money >= price_to_pay) then

                if (Garage.VehiclesOut[plate]) then
                    Garage.VehiclesOut[plate] = nil;
                end

                local ped = GetPlayerPed(xPlayer.source);
                local playerCoords = GetEntityCoords(ped);
                local position = Pound.GetInArea(playerCoords, "Menu");

                if (position) then

                    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND stored = 0", {
                        ["@owner"] = xPlayer.getIdentifier(),
                        ["@plate"] = vehiclePlate;
                    }, function(result)
                        if (#result > 0) then

                            if (price_to_pay > 0) then
                                xPlayer.removeAccountMoney(Config["Accounts"]["money"], price_to_pay)
                            end

                            MySQL.Async.execute("UPDATE owned_vehicles SET stored = 1 WHERE plate = @plate", {
                                ["@plate"] = vehiclePlate;
                            }, function()
                                Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
                                xPlayer.showNotification((price_to_pay > 0 and Shared.Lang:Translate("player_paid", price_to_pay) or "L'assurance à pris en charge les honoraires !"))
                            end);

                        else
                            Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
                            xPlayer.showNotification(Shared.Lang:Translate("error_occured"));
                        end
                    end);

                else

                    Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
                    xPlayer.showNotification(Shared.Lang:Translate("error_occured"));

                end

            else
                Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
                xPlayer.showNotification(Shared.Lang:Translate("error_occured"));
            end

        else

            Shared.Events:ToClient(xPlayer, Enums.Pound.Events.RefreshVehicles);
            xPlayer.showNotification(Shared.Lang:Translate("error_occured"));

        end

    end)

end);