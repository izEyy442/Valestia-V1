--[[
----
----Created Date: 1:44 Monday October 17th 2022
----Author: vCore3
----Made with ❤
----
----File: [vehicle]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local DEBUG_GARAGE = {
    PLAYER_ID = GetPlayerServerId(PlayerId()),
    ENABLED = false,
}

---@param player number
local function DEBUG_GARAGE_SWITCH(player)
    return DEBUG_GARAGE.ENABLED and DEBUG_GARAGE.PLAYER_ID or GetPlayerServerId(player);
end

Garage.subMenu = RageUI.AddSubMenu(
    Garage.mainMenu,
    Shared.Lang:Translate("garage_menu_sub_title"), 
    Shared.Lang:Translate("garage_menu_sub_subtitle")
);

local sellListIndex = 1;
local function giveVehicle(player, plate, choise)
    if (choise == 1) then
        Shared.Events:ToServer(Enums.Garage.Events.GiveVehicle, DEBUG_GARAGE_SWITCH(player), plate);
        Garage.vehicles = nil;
        Garage.mainMenu:SetData("vehicle", nil);
    elseif (choise == 2) then
        local input = Shared:KeyboardInput(Shared.Lang:Translate("how_much_sell"));
        if (Shared:InputIsValid(input, "number")) then
            if (tonumber(input) > 0) then
                Shared.Events:ToServer(Enums.Garage.Events.RequestSent, DEBUG_GARAGE_SWITCH(player), plate, tonumber(input));
                Garage.vehicles = nil;
                Garage.mainMenu:SetData("vehicle", nil);
            else
                Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));
            end
        else
            Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));
        end
    end
end

Garage.subMenu:IsVisible(function(Items)
    if not (Garage.mainMenu:GetData("vehicle")) then

        Items:Separator(Shared.Lang:Translate("garage_menu_waiting_vehicle"));

    else
        Items:Button(Shared.Lang:Translate("garage_menu_drive"), nil, {}, true, {
            onSelected = function()

                local vehicle = Garage.mainMenu:GetData("vehicle");
                local position = Garage.mainMenu:GetData("coords");

                if (Game.Vehicle:IsSpawnPointClear(position["Out"], 2)) then

                    Shared.Events:ToServer(
                        Enums.Garage.Events.TakeVehicle, 
                        vehicle.plate
                    );

                    Garage.vehicles = nil;
                    Garage.mainMenu:SetData("vehicle", nil);

                else

                    Game.Notification:ShowSimple(
                        Shared.Lang:Translate("spawn_point_unsafe")
                    );

                end

            end
        });
        Items:List(Shared.Lang:Translate("garage_menu_give"), { 
            Shared.Lang:Translate("garage_menu_list_give"),
            Shared.Lang:Translate("garage_menu_list_sell") 
        }, sellListIndex, nil, {}, true, {
            onListChange = function(index)
                sellListIndex = index;
            end,
            onSelected = function()
                local player, distance = Game.Players:GetClosestPlayer();
                local vehicle = Garage.mainMenu:GetData("vehicle");
                if (DEBUG_GARAGE.ENABLED or player and distance < 5) then
                    giveVehicle(player, vehicle.plate, sellListIndex);
                else
                    Game.Notification:ShowSimple(Shared.Lang:Translate("no_player_found"));
                end
            end
        });
    end
end, nil, function()
    Garage.mainMenu:SetData("vehicle", nil);
    sellListIndex = 1;
end);