--[[
----
----Created Date: 3:01 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Zone]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local garageZone = Game.Zone("GarageParking");
local garageDelete = Game.Zone("GarageDelete");
local zones = Config["Garage"]["Zones"] and Config["Garage"]["Zones"] or {};

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

garageZone:Start(function()
    garageZone:SetTimer(1000);
    if (not IsInPVP) then
        for i = 1, #zones or 1 do
            if (zones[i]["Spawn"].x and zones[i]["Spawn"].y and zones[i]["Spawn"].z) then
                garageZone:SetCoords(vector3(zones[i]["Spawn"].x, zones[i]["Spawn"].y, zones[i]["Spawn"].z));
                garageZone:IsPlayerInRadius(40, function()
                    garageZone:SetTimer(0);
                    garageZone:Marker();
                    garageZone:IsPlayerInRadius(3, function()
                        garageZone:Text(Shared.Lang:Translate("garage_zone_text_take"));
                        garageZone:KeyPressed("E", function()
                            Garage.mainMenu:SetData("coords", zones[i]);
                            Garage.GetVehicles();
                            Garage.mainMenu:Toggle();
                        end);
                    end);
                end, false);
                garageZone:RadiusEvents(2, nil, function()
                    Garage.mainMenu:Close();
                end);
            end
        end
    end
end);

garageDelete:Start(function()
    garageDelete:SetTimer(1000);
    if (not IsInPVP) then
        for i = 1, #zones or 1 do
            if (zones[i]["Delete"].x and zones[i]["Delete"].y and zones[i]["Delete"].z) then
                garageDelete:SetCoords(vector3(
                    zones[i]["Delete"].x,
                    zones[i]["Delete"].y,
                    zones[i]["Delete"].z)
                );
                garageDelete:IsPlayerInRadius(40, function()
                    garageDelete:SetTimer(0);
                    garageDelete:Marker(nil, nil, 3.0);
                    garageDelete:IsPlayerInRadius(3, function()
                        garageDelete:Text(Shared.Lang:Translate("garage_zone_text_put"));
                        garageDelete:KeyPressed("E", function()
                            Shared.Events:ToServer(
                                Enums.Garage.Events.ParkVehicle, 
                                GetVehicleNumberPlateText(
                                    Client.Player:GetVehicle()
                                )
                            );
                        end);
                    end, false, true);
                end, false, true);
            end
        end
    end
end);