--[[
----
----Created Date: 6:13 Thursday December 22nd 2022
----Author: vCore3
----Made with ❤
----
----File: [mainMenu]
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
local mainMenu = Storage:Get("main_menu");
---@type UIMenu
local inventory = Storage:Get("inventory_menu");
---@type UIMenu
local management = Storage:Get("management_menu");
---@type UIMenu
local vehicle = Storage:Get("vehicle_menu");

mainMenu:IsVisible(function(Items) 

    Items:Button(
        Shared.Lang:Translate(
            "personnal_menu_inventory_button_label", 
            Shared:ServerColor(), 
            Client.Player:GetWeight(), 
            Shared:ServerColor(), 
            Client.Player:GetMaxWeight()
        ), 
        nil, 
        {}, 
        true, 
        {},
        inventory
    );

    Items:Button(Shared.Lang:Translate("personnal_menu_management_button_label"), nil, {}, true, {}, management);

    Items:Button(Shared.Lang:Translate("personnal_menu_vehicle_button_label"), nil, {}, personnalMenuData:Get("isInVehicle"), {}, vehicle);

end);

Shared:RegisterCommand("menujg", function()
    
    Game.Notification:ShowSimple("Bien essayé, vCore3 ne laisse jamais rien au hasard.");
    --mainMenu:Toggle();

end);