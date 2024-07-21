--
--Created Date: 20:34 26/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Zones]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local SocietyMenus = Shared.Storage:Get("SocietyMenus");

---@type UIMenu
local poundMenu = SocietyMenus:Get("action_pound");

local zoneSociety = Game.Zone("SocietyPound");
local zoneGang = Game.Zone("SocietyPound");

zoneSociety:Start(function()

    zoneSociety:SetTimer(1000);
    zoneSociety:SetCoords(Config["Society"]["Pound"]["JobCoords"]["Interact"]);

    zoneSociety:IsPlayerInRadius(50, function()

        zoneSociety:SetTimer(0);
        zoneSociety:Marker();

        zoneSociety:IsPlayerInRadius(2, function()

            zoneSociety:Text(Shared.Lang:Translate("society_zone_pound", Shared:ServerColor()));

            zoneSociety:KeyPressed("E", function()

                Client.Society:SelectSociety(Client.Player:GetJob().name, function(jobData)

                    if (jobData) then

                        poundMenu:SetData("society", jobData.name);
                        Client.Society:RequestVehicles();
                        SocietyMenus:Get("SetLabel")();
                        poundMenu:Toggle();

                    else

                        Game.Notification:ShowSimple(Shared.Lang:Translate("society_zone_pound_no_job", Shared:ServerColor()));

                    end

                end);

            end);

        end);

    end);

    zoneSociety:RadiusEvents(50, nil, function()

        poundMenu:Close();

    end);

end);

zoneGang:Start(function()

    zoneGang:SetTimer(1000);
    zoneGang:SetCoords(Config["Society"]["Pound"]["GangCoords"]["Interact"]);

    zoneGang:IsPlayerInRadius(50, function()

        zoneGang:SetTimer(0);
        zoneGang:Marker();

        zoneGang:IsPlayerInRadius(2, function()

            zoneGang:Text(Shared.Lang:Translate("society_zone_pound", Shared:ServerColor()));

            zoneGang:KeyPressed("E", function()

                Client.Society:SelectSociety(Client.Player:GetJob2().name, function(jobData)

                    if (jobData) then

                        poundMenu:SetData("society", jobData.name);
                        Client.Society:RequestVehicles();
                        SocietyMenus:Get("SetLabel")();
                        poundMenu:Toggle();

                    else

                        Game.Notification:ShowSimple(Shared.Lang:Translate("society_zone_pound_no_gang", Shared:ServerColor()));

                    end

                end);

            end);

        end);

    end);

    zoneGang:RadiusEvents(50, nil, function()

        poundMenu:Close();

    end);

end);