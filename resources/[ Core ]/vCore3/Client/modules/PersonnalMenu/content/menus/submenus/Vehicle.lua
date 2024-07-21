--[[
----
----Created Date: 6:37 Thursday December 22nd 2022
----Author: vCore3
----Made with ❤
----
----File: [Vehicle]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local Storage = Shared.Storage:Get("personnal_menu");
local personnalMenuData = Shared.Storage:Get("personnal_menu_data");

---@type UIMenu
local vehicleMenu = Storage:Get("vehicle_menu");
---@type UIMenu
local extraMenu = Storage:Get("vehicle_extra_menu");

---Generate list of extra for current player vehicle
---@return table
local function GenerateExtraList()

    local extras = {};

    local vehicle = Client.Player:GetVehicle();


    for i = 1, 9 do
    
        if (DoesExtraExist(vehicle, i)) then

            local id = #extras + 1

            extras[id] = {

                value = ("N°%s"):format(id),
                extraIndex = i,

            };

        end

    end

    return extras;

end

vehicleMenu:IsVisible(function(Items) 

    local vehicle = Client.Player:GetVehicle();

    if (vehicle) then

        local isEngineRunning = personnalMenuData:Get("ToStringEngine")();
        local doorState = personnalMenuData:Get("door_index");

        Items:Button(Shared.Lang:Translate("personnal_menu_vehicle_engine_button_label"), nil, {
            RightLabel = isEngineRunning,
        }, true, {
            
            onSelected = function()

                Game.Vehicle:ToggleEngine();

            end

        });

        Items:List(Shared.Lang:Translate("personnal_menu_vehicle_doors_button_label"), personnalMenuData:Get("doorList"), doorState, nil, {}, true,  {
            
            onListChange = function(Index)
                
                personnalMenuData:Set("door_index", Index);

            end,

            onSelected = function()

                local data = personnalMenuData:Get("doorList");
                Game.Vehicle:SetDoorState(data[doorState].doorIndex);

            end

        });

        Items:Button(Shared.Lang:Translate("personnal_menu_vehicle_extra_button_label"), nil, {}, true, {
            
            onSelected = function()

                personnalMenuData:Set("vehicle_extra", GenerateExtraList());

            end

        }, extraMenu);

    else

        Items:Separator();
        Items:Separator(Shared.Lang:Translate("personnal_menu_vehicle_not_in_vehicle"));
        Items:Separator();

    end

end, nil, function()

    personnalMenuData:Set("door_index", 1);

end);

extraMenu:IsVisible(function(Items)

    local vehicle = Client.Player:GetVehicle();
    local extras = personnalMenuData:Get("vehicle_extra");

    if (#extras > 0) then

        for i = 1, #extras do

            local extra = extras[i];

            Items:Checkbox(extra.value, nil, IsVehicleExtraTurnedOn(vehicle, extra.extraIndex), {}, {
                
                onSelected = function(Checked)

                    ---todo make this method
                    Game.Vehicle:ToggleExtra(extra.extraIndex, Checked);

                end

            });

        end

    else

        Items:Separator();
        Items:Separator(Shared.Lang:Translate("personnal_menu_vehicle_extra_no_extra"));
        Items:Separator();

    end

end);