--[[
----
----Created Date: 2:58 Sunday October 16th 2022
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

Garage = {};

function Garage.GetVehicles()
    Garage.vehicles = nil;
    Shared.Events:ToServer(Enums.Garage.Events.RequestVehicles);
end

Shared.Events:OnNet(Enums.Garage.Events.RefreshVehicles, function()
    Shared.Events:ToServer(Enums.Garage.Events.RequestVehicles);

    local menu = Garage.subMenu;

    if (menu:IsShowing()) then
        RageUI.GoBack();
    end
end);

Shared.Events:OnNet(Enums.Garage.Events.ReceiveVehicles, function(vehicles)

    Garage.vehicles = vehicles;

end);

Shared.Events:OnNet(Enums.Garage.Events.RequestAuthorisation, function(vehiclePlate, playerName, price, playerId)

    CreateThread(function()

        if (not Client.Player:IsBusy()) then

            Client.Player:SetBusy(true);
            Game.Notification:ShowAdvanced(
                Config["ServerName"] or "vCore3 Script",
                Shared.Lang:Translate("garage_menu_prompt_notification_header"), 
                Shared.Lang:Translate("garage_menu_authorisation_prompt", 
                    vehiclePlate, 
                    playerName, 
                    price
                ),
                Config["AdvancedNotification"]["GarageSellVehicle"]["TextureName"],
                Config["AdvancedNotification"]["GarageSellVehicle"]["IconType"],
                Config["AdvancedNotification"]["GarageSellVehicle"]["flash"],
                Config["AdvancedNotification"]["GarageSellVehicle"]["SaveToBrief"],
                Config["AdvancedNotification"]["GarageSellVehicle"]["HudColorIndex"]
            );

            local timer = Shared.Timer(15);
            timer:Start();

            while not timer:HasPassed() do

                if IsControlJustReleased(2, 246) then

                    Client.Player:SetBusy(false);
                    Shared.Events:ToServer(Enums.Garage.Events.RequestAccepted, playerId, price, vehiclePlate);
                    break;

                end

                if (timer:HasPassed()) then

                    Client.Player:SetBusy(false);
                    Shared.Events:ToServer(Enums.Garage.Events.RequestCanceled, playerId);
                    Game.Notification:ShowSimple(Shared.Lang:Translate("garage_prompt_canceled"));

                end

                Wait(0);

            end

        else
            Shared.Events:ToServer(Enums.Garage.Events.RequestCanceled, playerId);
        end

    end);

end);