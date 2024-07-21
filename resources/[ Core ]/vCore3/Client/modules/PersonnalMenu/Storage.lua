--[[
----
----Created Date: 12:13 Thursday December 22nd 2022
----Author: vCore3
----Made with ❤
----
----File: [Storage]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local Storage = Shared.Storage:Register("personnal_menu");
local personnalMenuData = Shared.Storage:Register("personnal_menu_data");

local mainMenu = Storage:Set("main_menu", RageUI.AddMenu("", Shared.Lang:Translate("personnal_menu_label")));

local inventory = Storage:Set("inventory_menu", RageUI.AddSubMenu(mainMenu, "", Shared.Lang:Translate("personnal_menu_inventory_label")));
Storage:Set("inventory_sub_menu", RageUI.AddSubMenu(inventory));

Storage:Set("management_menu", RageUI.AddSubMenu(mainMenu, "", Shared.Lang:Translate("personnal_menu_management_label")));

local vehicle = Storage:Set("vehicle_menu", RageUI.AddSubMenu(mainMenu, "", Shared.Lang:Translate("personnal_menu_vehicle_label")));

Storage:Set("vehicle_extra_menu", RageUI.AddSubMenu(vehicle, "", Shared.Lang:Translate("personnal_menu_vehicle_extra_label")));

personnalMenuData:Set("doorList", {

    { 
        value = Shared.Lang:Translate("personnal_menu_vehicle_door_driver"),
        doorIndex = 0, 
    },

    { 
        value = Shared.Lang:Translate("personnal_menu_vehicle_door_passenger"),
        doorIndex = 1, 
    },

    { 
        value = Shared.Lang:Translate("personnal_menu_vehicle_door_passenger_rear_left"),
        doorIndex = 2, 
    },

    { 
        value = Shared.Lang:Translate("personnal_menu_vehicle_door_passenger_rear_right"),
        doorIndex = 3, 
    },

    { 
        value = Shared.Lang:Translate("personnal_menu_vehicle_door_hood"),
        doorIndex = 4, 
    },

    { 
        value = Shared.Lang:Translate("personnal_menu_vehicle_door_trunk"),
        doorIndex = 5, 
    },

});

personnalMenuData:Set("door_index", 1);

local wallet = Storage:Set("wallet_menu", RageUI.AddSubMenu(mainMenu));
Storage:Set("identity_menu", RageUI.AddSubMenu(wallet, Shared.Lang:Translate("personnal_menu_identity_label")));