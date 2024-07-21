--[[
----
----Created Date: 1:49 Monday October 17th 2022
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

local gVip = nil

RegisterNetEvent('shops:setStatVip', function(call)
    if call == 0 then 
        gVip = false
    elseif call == 1 then
        gVip = false
    elseif call == 2 then
        gVip = true
    elseif call == 3 then
        gVip = true
    end
end)

local PoundPSpawnV = Config["Pound"]["Prices"]["SpawnVehicle"]
local PoundPStoreV = Config["Pound"]["Prices"]["StoreVehicle"]
local statAssu = Shared.Lang:Translate("pound_checkpub_assurance_no")

Pound.subMenu = RageUI.AddSubMenu(
    Pound.mainMenu, 
    Shared.Lang:Translate("pound_submenu_title"),
    Shared.Lang:Translate("pound_submenu_subtitle")
);

Pound.subMenu:IsVisible(function(Items) 
    if (not Pound.subMenu:GetData("vehicle")) then
        Items:Separator(Shared.Lang:Translate("pound_menu_waiting_vehicle"));
    else
        if gVip then 
            Items:Separator(Shared.Lang:Translate("pound_menu_assurance_yes"));
            PoundPSpawnV = "0"
            PoundPStoreV = "0"
            statAssu = Shared.Lang:Translate("pound_checkpub_assurance_yes")
        else
            Items:Separator(Shared.Lang:Translate("pound_menu_assurance_no"));
            PoundPSpawnV = Config["Pound"]["Prices"]["SpawnVehicle"]
            PoundPStoreV = Config["Pound"]["Prices"]["StoreVehicle"]
            statAssu = Shared.Lang:Translate("pound_checkpub_assurance_no")
        end
        Items:Button(Shared.Lang:Translate("pound_menu_take_vehicle_out"), statAssu, {
            RightLabel = Shared.Lang:Translate("pound_spawnvehicle_price", string.format("%s%s", Shared:ServerColor(), PoundPSpawnV));
        }, Pound.subMenu:GetData("vehicle").type == "car", {
            onSelected = function()
                local position = Pound.mainMenu:GetData("coords");
                if (position and position["Spawn"]) then
                    if (Game.Vehicle:IsSpawnPointClear(position["Spawn"], 2)) then
                        Shared.Events:ToServer(Enums.Pound.Events.TakeVehicle, Pound.subMenu:GetData("vehicle").plate);
                        Pound.subMenu:SetData("vehicle", nil);
                    else
                        Game.Notification:ShowSimple(
                            Shared.Lang:Translate("spawn_point_unsafe")
                        );
                    end
                else
                    Game.Notification:ShowSimple(
                        Shared.Lang:Translate("error_occured")
                    );
                end
            end
        });
        Items:Button(Shared.Lang:Translate("pound_menu_store_vehicle"), statAssu, {
            RightLabel = Shared.Lang:Translate("pound_storevehicle_price", string.format("%s%s", Shared:ServerColor(), PoundPStoreV));
        }, true, {
            onSelected = function()

                local vehicle = Pound.subMenu:GetData("vehicle");
                if (vehicle) then
                    Shared.Events:ToServer(Enums.Pound.Events.StoreVehicle, vehicle.plate);
                    Pound.subMenu:SetData("vehicle", nil);
                else
                    Pound.subMenu:Close();
                    Game.Notification:ShowSimple(Shared.Lang:Translate("error_occured"));
                end

            end
        });
    end
end, nil, function()
    Pound.subMenu:SetData("vehicle", nil);
end);