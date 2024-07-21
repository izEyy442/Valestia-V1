--
--Created Date: 19:23 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Zone]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local zone = Game.Zone("GangBuilder");
--boss_action = gang.boss_action,
--name = gang.name,
--chest_action = gang.chest_action,
--take_vehicle = gang.take_vehicle,
--parking = gang.parking,
--vehicle_spawn = gang.vehicle_spawn,

local actions = {
    ["boss_action"] = {
        isBossOnly = true,
        exitCallback = function()
            Shared.Storage:Get("SocietyMenus"):Get("action_main"):Close();
        end,
        coords = function() return Client.Gang:GetData("boss_action") end,
        interactMessage = Shared.Lang:Translate("gangbuilder_interact_message_boss", Shared:ServerColor()),
        onInteract = function()
            Shared.Events:Trigger(Enums.Society.OpenAction, Client.Player:GetJob2().name);
        end
    },
    ["chest_action"] = {
        coords = function() return Client.Gang:GetData("chest_action") end,
        exitCallback = function()
            Shared.Storage:Get("SocietyMenus"):Get("chest_main"):Close();
        end,
        interactMessage = Shared.Lang:Translate("gangbuilder_interact_message_chest", Shared:ServerColor()),
        onInteract = function()
            Shared.Events:Trigger(Enums.Society.OpenChest, Client.Player:GetJob2().name);
        end
    },
    ["take_vehicle"] = {
        coords = function() return Client.Gang:GetData("take_vehicle") end,
        exitCallback = function()
            Shared.Storage:Get("SocietyMenus"):Get("action_vehicles"):Close();
        end,
        interactMessage = Shared.Lang:Translate("gangbuilder_interact_message_take_vehicle", Shared:ServerColor()),
        onInteract = function()
            Shared.Events:Trigger(Enums.Society.OpenVehicleMenu, Client.Player:GetJob2().name, Client.Gang:GetData("vehicle_spawn"));
        end
    },
    ["parking"] = {
        markerRadius = 4.0,
        coords = function() return Client.Gang:GetData("parking") end,
        interactMessage = Shared.Lang:Translate("gangbuilder_interact_message_parking", Shared:ServerColor()),
        isVehicleOnly = true,
        onInteract = function()
            Shared.Events:ToServer(Enums.Society.ParkVehicle, Client.Player:GetJob2().name, GetVehicleNumberPlateText(Client.Player:GetVehicle()));
        end
    },

};

zone:Start(function()

    zone:SetTimer(1000);

    local gangData = Client.Gang:GetAllData();

    if (gangData) then
        if (Shared.Table:SizeOf(gangData) > 0) then

            for _, actionData in pairs(actions) do

                if (not actionData.isBossOnly or Client.Gang:IsPlayerBoss()) then

                    local coords = actionData.coords();

                    if (coords) then
                        zone:SetCoords(vector3(coords.x, coords.y, coords.z));

                        zone:IsPlayerInRadius(50, function()
                            zone:SetTimer(0);
                            zone:Marker(nil, nil, actionData.markerRadius or 0.75);

                            zone:IsPlayerInRadius(2, function()
                                zone:Text(actionData.interactMessage);
                                zone:KeyPressed("E", function()
                                    actionData.onInteract();
                                end);
                            end, false, actionData.isVehicleOnly);

                        end, false, actionData.isVehicleOnly);

                        if (actionData.exitCallback) then
                            zone:RadiusEvents(3, nil, function()
                                actionData.exitCallback();
                            end);
                        end

                    end

                end

            end

        end

    end

end);