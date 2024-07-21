--[[
----
----Created Date: 4:43 Sunday October 16th 2022
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

local gVip = nil

RegisterNetEvent('shops:setStatVip', function(call)
    if call == 0 then 
        gVip = false
    elseif call == 1 then
        gVip = false
    elseif call == 2 then
        gVip = true
    end
end)

Pound.mainMenu = RageUI.AddMenu(
    Shared.Lang:Translate("pound_menu_title"),
    Shared.Lang:Translate("pound_menu_subtitle")
);

Pound.mainMenu:IsVisible(function(Items) 
    if (not Pound.vehicles) then
        Items:Separator(Shared.Lang:Translate("pound_menu_waiting_vehicles"));
    else
        if (#Pound.vehicles > 0) then
            if gVip then 
                Items:Separator(Shared.Lang:Translate("pound_menu_assurance_yes"));
            else
                Items:Separator(Shared.Lang:Translate("pound_menu_assurance_no"));
            end

            for i = 1, #Pound.vehicles do

                if ( Pound.vehicles[i] ~= nil) then

                    Pound.vehicles[i].type = Garage.getTypeFromModel(Pound.vehicles[i].model)

                    local vehicleName = GetDisplayNameFromVehicleModel(Pound.vehicles[i].model);
                    Items:Button(("%s ~c~[%s%s~c~]~s~"):format(
                            vehicleName,
                            Shared:ServerColor(),
                            Pound.vehicles[i].plate
                    ),
                            nil,
                            {},
                            true,
                            {
                                onSelected = function()
                                    Pound.subMenu:SetData("vehicle", Pound.vehicles[i]);
                                end
                            },
                            Pound.subMenu
                    );

                end

            end
        else
            Items:Separator();
            Items:Separator(Shared.Lang:Translate("pound_menu_no_vehicle"));
            Items:Separator();
        end
    end
end);