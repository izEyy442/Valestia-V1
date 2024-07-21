--[[
----
----Created Date: 4:45 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Zones]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local zone = Game.Zone("PoundZone");

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

zone:Start(function()
    local zones = Config["Pound"]["Zones"] and Config["Pound"]["Zones"] or {};
    zone:SetTimer(1000);
    if (not IsInPVP) then
        for i = 1, #zones or 1 do
            if (zones[i]["Menu"].x and zones[i]["Menu"].y and zones[i]["Menu"].z) then
                zone:SetCoords(vector3(zones[i]["Menu"].x, zones[i]["Menu"].y, zones[i]["Menu"].z));
                zone:IsPlayerInRadius(40, function()
                    zone:SetTimer(0);
                    zone:Marker();
                    zone:IsPlayerInRadius(3, function()
                        zone:Text(Shared.Lang:Translate("pound_zone_text"));
                        zone:KeyPressed("E", function()
                            TriggerServerEvent("shops:getVIP")
                            Pound.mainMenu:SetData("coords", zones[i]);
                            Pound.GetVehicles();
                            Pound.mainMenu:Toggle();
                        end);
                    end);
                end, false);
                zone:RadiusEvents(2, nil, function()
                    Pound.mainMenu:Close();
                end);
            end
        end
    end
end);