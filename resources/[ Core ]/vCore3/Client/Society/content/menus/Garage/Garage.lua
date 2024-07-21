--
--Created Date: 16:50 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Garage]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local SocietyMenus = Shared.Storage:Get("SocietyMenus");

---@type UIMenu
local menu = SocietyMenus:Get("action_vehicles");
---@type UIMenu
local selected = SocietyMenus:Get("action_vehicle_selected");

local function IsVehicleOwnedByPlayer(plate)

    local isOwner = Client.Society:IsVehicleOwner(plate);

    if (isOwner) then

        return Shared.Lang:Translate("society_menu_player_owned_vehicle");

    elseif (not isOwner) then

        return Shared.Lang:Translate("society_menu_player_not_owned_vehicle");

    end

end

local function IsVehicleStored(plate)

    local isStored = Client.Society:IsVehicleStored(plate);

    if (isStored) then

        return true;

    else

        return false, Shared.Lang:Translate("society_menu_vehicle_not_stored");

    end

end

menu:IsVisible(function(Items)

    local vehicles = Client.Society:GetVehicles();

    if (vehicles) then

        if (Shared.Table:SizeOf(vehicles) > 0) then

            for plate, vehicle in pairs(vehicles) do

                if (vehicle) then

                    local isStored, reason = IsVehicleStored(plate);

                    Items:Button(("%s ~m~[%s%s~m~]"):format(GetDisplayNameFromVehicleModel(vehicle.data.model), Shared:ServerColor(), plate), nil, {
                        RightLabel = isStored and IsVehicleOwnedByPlayer(plate) or reason
                    }, isStored, {

                        onSelected = function()

                            selected:SetData("plate", plate);

                        end

                    }, selected);

                end

            end

        else

            Items:Separator();
            Items:Separator(Shared.Lang:Translate("society_garage_empty"));
            Items:Separator();

        end

    else

        Items:Separator(Shared.Lang:Translate("society_garage_loading_vehicles"));

    end

end);

selected:IsVisible(function(Items)

    local plate = selected:GetData("plate");

    if (plate) then

        Items:Button(Shared.Lang:Translate("society_menu_vehicle_take"), nil, {

            RightBadge = RageUI.BadgeStyle.Car

        }, true, {

            onSelected = function()

                if (plate) then

                    local coords = menu:GetData("coords");

                    if (Game.Vehicle:IsSpawnPointClear(coords, 2)) then

                        Shared.Events:ToServer(Enums.Society.TakeVehicle, Client.Society:GetSocietyName(), plate, vector4(coords.x, coords.y, coords.z, coords.w));

                    else

                        Game.Notification:ShowSimple(
                            Shared.Lang:Translate("spawn_point_unsafe")
                        );

                    end

                else

                    Game.Notification:ShowSimple(Shared.Lang:Translate("society_menu_vehicle_take_error"));

                end

            end

        });

        Items:Button(Shared.Lang:Translate("society_menu_vehicle_retrieve_personnal"), nil, {

            RightBadge = RageUI.BadgeStyle.Car

        }, Client.Society:IsVehicleOwner(plate), {

            onSelected = function()

                if (plate) then

                    Shared.Events:ToServer(Enums.Society.RetrievePlayerVehicle, Client.Society:GetSocietyName(), plate);

                else

                    Game.Notification:ShowSimple(Shared.Lang:Translate("society_menu_vehicle_retrieve_personnal_error"));

                end

            end

        });

    else

        Items:Separator(Shared.Lang:Translate("society_menu_vehicle_loading"));

    end

end, nil, function()

    selected:SetData("plate", nil);

end);