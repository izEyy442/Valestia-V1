--[[
----
----Created Date: 2:55 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [mainmenu]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

Garage.mainMenu = RageUI.AddMenu(
    Shared.Lang:Translate("garage_menu_main_title"),
    Shared.Lang:Translate("garage_menu_main_subtitle")
);

---@param model string
---@return string
function Garage.getTypeFromModel(model)

    model = (type(model) == "string" and GetHashKey(model)) or model

    if (IsModelAVehicle(model)) then

        local vehicle_class = GetVehicleClassFromName(model)
        return (vehicle_class == 14 and "boat") or ((vehicle_class == 15 or vehicle_class == 16) and "plane") or "car"

    end

end

---@param stored boolean
---@return string, boolean
local function isParked(stored)
    local parked = Shared.Lang:Translate("garage_menu_vehicle_in");
    local out = Shared.Lang:Translate("garage_menu_vehicle_out");
    if (stored == 1 or stored == 2) then
        return parked, true;
    else
        return out, false;
    end
end

local function getCurrentGarage()
    return Garage.mainMenu:GetData("coords")
end

Garage.mainMenu:IsVisible(function(Items)

    if (not Garage.vehicles) then

        Items:Separator(Shared.Lang:Translate("garage_menu_waiting_vehicles"));

    else

        if (#Garage.vehicles > 0) then

            local current_garage = getCurrentGarage()
            local vehicles = Garage.vehicles;

            for i = 1, #vehicles do

                if (vehicles[i] ~= nil) then

                    vehicles[i].type = Garage.getTypeFromModel(vehicles[i].model)

                    local vehicle_is_bone = (vehicles[i].type ~= nil and current_garage ~= nil and ((current_garage["Type"] == nil and vehicles[i].type == "car") or (current_garage["Type"] == vehicles[i].type))) and true or false;

                    if (vehicle_is_bone == true) then

                        local vehicleName = GetDisplayNameFromVehicleModel(vehicles[i].model);
                        local isStored, enabled = isParked(vehicles[i].stored);

                        Items:Button(("%s ~c~[%s%s~c~]~s~"):format(
                                vehicleName,
                                Shared:ServerColor(),
                                vehicles[i].plate
                        ),
                                (not enabled and "Appuyez pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~localiser~s~ votre véhicule."),
                                {
                                    RightLabel = isStored,
                                    RightBadge = (not enabled and RageUI.BadgeStyle.Lock)
                                },
                                true,
                                {

                                    onSelected = function()

                                        if (enabled) then

                                            Garage.mainMenu:SetData("vehicle", vehicles[i]);

                                        else

                                            Shared.Events:ToServer(Enums.Garage.Events.LocateVehicle, vehicles[i].plate)

                                        end

                                    end

                                },
                                (enabled and Garage.subMenu)
                        )

                    end

                end

            end

        else

            Items:Separator();
            Items:Separator(Shared.Lang:Translate("garage_menu_no_vehicles"));
            Items:Separator();

        end

    end

end);