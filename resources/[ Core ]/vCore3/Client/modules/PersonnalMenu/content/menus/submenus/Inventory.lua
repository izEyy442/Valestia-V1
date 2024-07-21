--[[
----
----Created Date: 12:35 Saturday December 24th 2022
----Author: vCore3
----Made with ❤
----
----File: [Inventory]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local personnalMenu = Shared.Storage:Get("personnal_menu");
local personnalMenuData = Shared.Storage:Get("personnal_menu_data");

---@type UIMenu
local inventoryMenu = personnalMenu:Get("inventory_menu");

personnalMenuData:Set("inventoryList", {
    index = 1,
    items = {
        Shared.Lang:Translate("personnal_menu_inventory_items_list"),
        Shared.Lang:Translate("personnal_menu_inventory_weapons_list"),
    },
});

inventoryMenu:IsVisible(function(Items) 

    local inventoryList = personnalMenuData:Get("inventoryList");

    Items:List(Shared.Lang:Translate("personnal_menu_inventory_list_actions"), inventoryList.items, inventoryList.index, nil, {}, true, {

        onListChange = function(Index)

            inventoryList.index = Index;

        end,

    });

    Items:Line();

    if (inventoryList.index == 1) then

        local inventory = Client.Player:GetInventory();

        for i = 1, #inventory do

            local item = inventory[i];

            if (item) then

                Items:Button(("%s x%s"):format(item.label, item.count), nil, {}, true, {

                    onSelected = function()

                        Client.Player:UseItem(item.id);

                    end,

                });

            end

        end

    else

        local weapons = Client.Player:GetWeaponList();

        for i = 1, #weapons do

            local weapon = weapons[i];

            if (weapon) then

                Items:Button(("%s"):format(weapon.label), nil, {}, true, {

                    onSelected = function()

                        Client.Player:UseItem(weapon.id);

                    end,

                });

            end

        end

    end

end, nil, function()

    personnalMenuData:Set("inventoryList", {
        index = 1,
        items = {
            Shared.Lang:Translate("personnal_menu_inventory_items_list"),
            Shared.Lang:Translate("personnal_menu_inventory_weapons_list"),
        },
    });

end);