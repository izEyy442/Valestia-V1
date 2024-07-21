--[[
----
----Created Date: 3:33 Saturday October 15th 2022
----Author: vCore3
----Made with ❤
----
----File: [menu]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local function loadPlayerKeys()
    Client.Player:SetValue("VehicleKeys", nil);
    Shared.Events:ToServer(Enums.VehicleKeys.Events.RequestAllPlayerKeys);
end

local menu = RageUI.AddMenu(Shared.Lang:Translate("keys_vehicle_menu_title"), Shared.Lang:Translate("keys_vehicle_menu_subtitle"));

menu:IsVisible(function(Items) 
    local keys = Client.Player:GetValue("VehicleKeys");
    if (not keys) then
        Items:Separator(Shared.Lang:Translate("waiting_player_keys"));
    elseif (keys) then
        if (#keys > 0) then
            for _, key in pairs(keys) do
                Items:Button(
                    Shared.Lang:Translate(
                        "keys_vehicle_menu_button", 
                        string.format(
                            "~c~[%s%s~c~]~s~", 
                            Shared:ServerColor(),
                            key.id
                        )
                    ),
                    Shared.Lang:Translate("keys_vehicle_menu_button_action"),
                    {},
                    true, 
                    {
                        onSelected = function()
                            local closestPlayer, closestDistance = Game.Players:GetClosestPlayer();
                            if (closestPlayer and closestDistance < 5) then
                                Shared.Events:ToServer(Enums.VehicleKeys.Events.GiveToPlayer, GetPlayerServerId(closestPlayer), key.id);
                                loadPlayerKeys();
                            else
                                Game.Notification:ShowSimple(Shared.Lang:Translate("no_player_found"));
                            end
                        end
                    }
                );
            end
        else
            Items:Separator();
            Items:Separator(Shared.Lang:Translate("keys_vehicle_player_nokeys"));
            Items:Separator();
        end
    end
end);

Shared.Events:OnNet(Enums.VehicleKeys.Events.UpdateKeys, function()
    loadPlayerKeys();
end)

Shared:RegisterKeyMapping(
    "vCore3:Keys:Menu:KeyManagement",
    { label = "keys_vehicle_menu_description" },
    "F2", 
    function() 
        CreateThread(function()
            while not Client.Player do Wait(20); end
            loadPlayerKeys();
            menu:Toggle();
        end)
    end
);