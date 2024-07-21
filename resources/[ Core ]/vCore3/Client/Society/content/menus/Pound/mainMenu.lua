--
--Created Date: 00:47 25/12/2022
--Author: vCore3
--Made with ❤
--
--File: [mainMenu]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local SocietyMenus = Shared.Storage:Get("SocietyMenus");

---@type UIMenu
local pound = SocietyMenus:Get("action_pound");

---@return number
local function GetNumberOfPoundVehicle()

    local vehicles = {};

    for vehiclePlate, vehicle in pairs(Client.Society:GetVehicles() or {}) do

        if (vehicle) then

            if (not Client.Society:IsVehicleStored(vehiclePlate)) then

                table.insert(vehicles, vehiclePlate);

            end

        end

    end

    return #vehicles;

end

pound:IsVisible(function(Items)

    if (pound:GetData("society")) then

        local vehicles = Client.Society:GetVehicles();

        if (vehicles) then

            if (GetNumberOfPoundVehicle() > 0) then

                for vehiclePlate, vehicleData in pairs(vehicles) do

                    if (vehicleData) then

                        if (vehicleData.data) then

                            if (not Client.Society:IsVehicleStored(vehiclePlate)) then

                                local vehicleName = GetDisplayNameFromVehicleModel(vehicleData.data.model);
                                Items:Button(("%s ~c~[%s%s~c~]~s~"):format(
                                    vehicleName,
                                    Shared:ServerColor(),
                                    vehiclePlate
                                ), nil, {

                                    RightBadge = RageUI.BadgeStyle.Car,
                                    RightLabel = ("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~$%s~s~"):format(Config["Society"]["Pound"]["Price"]),

                                }, true, {

                                    onSelected = function()

                                        local coords = Client.Society:IsJob() and Config["Society"]["Pound"]["JobCoords"]["Out"] or Config["Society"]["Pound"]["GangCoords"]["Out"];

                                        if (Game.Vehicle:IsSpawnPointClear(coords, 2)) then

                                            Shared.Events:ToServer(Enums.Society.TakeVehicle, Client.Society:GetSocietyName(), vehiclePlate, coords, Config["Society"]["Pound"]["Price"]);

                                        else

                                            Game.Notification:ShowSimple(
                                                Shared.Lang:Translate("spawn_point_unsafe")
                                            );

                                        end

                                    end

                                });

                            end

                        end

                    end

                end

            else

                Items:Separator();
                Items:Separator(Shared.Lang:Translate("society_menu_pound_no_vehicles"));
                Items:Separator();

            end

        else

            Items:Separator(Shared.Lang:Translate("society_pound_vehicles_loading"));

        end

    end

end, nil, function()

    pound:SetData("society", nil);

end);