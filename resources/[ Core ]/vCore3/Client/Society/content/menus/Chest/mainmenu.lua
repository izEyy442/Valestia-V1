--
--Created Date: 14:22 16/12/2022
--Author: vCore3
--Made with ❤
--
--File: [mainmenu]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local SocietyMenus = Shared.Storage:Get("SocietyMenus");

---@type UIMenu
local chest = SocietyMenus:Get("chest_main");

local list = {

    index = 1,
    data = {

        [1] = Shared.Lang:Translate("society_menu_chest"),
        [2] = Shared.Lang:Translate("society_menu_player_inventory")

    };

};

---@return number
local function Index()

    if (list.index > #list.data) then
        list.index = 1;
    end

    return list.index;

end

---@param newIndex number
local function SetIndex(newIndex)

    if (newIndex > #list.data) then
        list.index = 1;
    elseif (newIndex < 1) then
        list.index = #list.data;
    else
        list.index = newIndex;
    end

end

---@return string
local function GetCurrentDescription()

    local societyItems = Client.Society:GetItems();
    local serverColor = Shared:ServerColor();

    if (societyItems) then

        return Shared.Lang:Translate(
            "society_menu_chest_chest_desc",
            serverColor,
            Client.Society:GetChestWeight(),
            serverColor,
            Client.Society:GetChestMaxWeight(),
            serverColor,
            Client.Player:GetWeight(),
            serverColor,
            Client.Player:GetMaxWeight()
        );

    else

        local waiting = Shared.Lang:Translate("jg_loading");

        return Shared.Lang:Translate(
            "society_menu_chest_chest_desc",
            serverColor,
            waiting,
            serverColor,
            waiting,
            serverColor,
            Client.Player:GetWeight(),
            serverColor,
            Client.Player:GetMaxWeight()
        );

    end

end

local function GetData()
    return list.data;
end

---@param weaponName string
---@param components table
---@return string
local function StringFromWeaponComponents(weaponName, components)

    local template = "\n";

    for i = 1, #components do

        local componentLabel = ESX.GetWeaponComponent(weaponName, components[i]);
        template = string.format("%s\n%s", template, componentLabel.label);
    end

    return template;

end

---@param weaponData table
---@param player boolean
---@return string
local function WeaponDescription(weaponData, player)

    local description;
    local weaponType = Shared:GetWeaponType(weaponData.name);

    if (#weaponData.components > 0) then

        description = string.format("%s\n\n%s\n%s\n%s%s",
            Shared.Lang:Translate("society_menu_chest_weapon_desc_cat"),
            Shared.Lang:Translate("society_menu_chest_weapon_desc_type", Shared:ServerColor(), weaponData.label),
            Shared.Lang:Translate("society_menu_chest_weapon_desc_ammo", Shared:ServerColor(), player and weaponType and Client.Player:GetAmmoForWeaponType(weaponType) or weaponData.ammo or 0),
            Shared.Lang:Translate("society_menu_chest_weapon_desc_components", Shared:ServerColor()),
            StringFromWeaponComponents(weaponData.name, weaponData.components)
        );

    else

        description = string.format("%s\n\n%s\n%s",
            Shared.Lang:Translate("society_menu_chest_weapon_desc_cat"),
            Shared.Lang:Translate("society_menu_chest_weapon_desc_type", Shared:ServerColor(), weaponData.label),
            Shared.Lang:Translate("society_menu_chest_weapon_desc_ammo", Shared:ServerColor(), player and weaponType and Client.Player:GetAmmoForWeaponType(weaponType) or weaponData.ammo or 0)
        );

    end

    return description;

end

chest:IsVisible(function(Items)

    local societyItems = Client.Society:GetItems();
    local playerItems = Client.Player:GetInventory();
    local societyWeapons = Client.Society:GetWeapons();
    local weapons = Client.Player:GetWeaponList();

    Items:List(Shared.Lang:Translate("society_menu_chest_choices"), GetData(), Index(), GetCurrentDescription(), {}, true, {

        onListChange = function(Index)
            SetIndex(Index);
        end,

    });

    if (Index() == 1) then

        Items:Separator(Shared.Lang:Translate("society_menu_chest_inventory_separator"));

        if (societyItems) then

            if (Shared.Table:SizeOf(societyItems) > 0) then

                for _, item in pairs(societyItems) do

                    if (item) then

                        Items:Button(item.label, GetCurrentDescription(), {
                            RightLabel = Shared.Lang:Translate("society_menu_chest_quantity", Shared:ServerColor(), item.count)
                        }, true, {

                            onSelected = function()

                                local quantity = Shared:KeyboardInput(Shared.Lang:Translate("society_menu_chest_select_quantity", Shared:ServerColor(), item.count), 50);

                                if (Shared:InputIsValid(quantity, "number") and tonumber(quantity) > 0) then

                                    Shared.Events:ToServer(Enums.Society.RemoveItem, Client.Society:GetSocietyName(), item.name, tonumber(quantity));

                                else

                                    Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

                                end

                            end

                        });

                    end

                end

            elseif (Shared.Table:SizeOf(societyItems) == 0) then

                Items:Separator(Shared.Lang:Translate("society_menu_chest_empty"));

            end

        else

            Items:Separator(Shared.Lang:Translate("society_menu_chest_loading"));

        end

        Items:Separator(Shared.Lang:Translate("society_menu_chest_weapons_separator"));

        if (societyWeapons) then

            if (Shared.Table:SizeOf(societyWeapons) > 0) then

                for _, listWeapons in pairs(societyWeapons) do

                    for i = 1, #listWeapons do
                        local weapon = listWeapons[i];

                        if (weapon) then

                            local description = WeaponDescription(weapon);

                            Items:Button(string.format("%s #%s", weapon.label, i), description, {

                                RightBadge = RageUI.BadgeStyle.Gun,
                                RightLabel = Shared:IsWeaponPermanent(weapon.name)
                                    and Shared.Lang:Translate("society_menu_weapons_is_permanent", Shared:ServerColor()) or nil

                            }, true, {

                                onSelected = function()

                                    local ped = Client.Player:GetPed();

                                    if (not HasPedGotWeapon(ped, GetHashKey(weapon.name), false)) then

                                        Shared.Events:ToServer(Enums.Society.RemoveWeapon, Client.Society:GetSocietyName(), weapon.name, weapon.ammo, weapon.components);

                                    else

                                        Game.Notification:ShowSimple(Shared.Lang:Translate("society_player_has_already_weapon"));

                                    end
                                end

                            });

                        end

                    end

                end

            elseif (Shared.Table:SizeOf(societyWeapons) == 0) then

                Items:Separator(Shared.Lang:Translate("society_menu_weapons_empty"));

            end

        else

            Items:Separator(Shared.Lang:Translate("society_menu_weapons_loading"));

        end

    elseif (Index() == 2) then

        if (playerItems) then

            local isInventoryEmpty = Client.Player:IsInventoryEmpty();

            Items:Separator(Shared.Lang:Translate("society_menu_chest_inventory_separator"));

            if (not isInventoryEmpty) then

                for i = 1, #playerItems do

                    local item = playerItems[i];

                    if (item) then

                        Items:Button(item.label, GetCurrentDescription(), {

                            RightLabel = Shared.Lang:Translate("society_menu_chest_quantity", Shared:ServerColor(), item.count)

                        }, true, {

                            onSelected = function()

                                local quantity = Shared:KeyboardInput(Shared.Lang:Translate("society_menu_chest_select_quantity", Shared:ServerColor(), item.count), 50);

                                if (Shared:InputIsValid(quantity, "number") and tonumber(quantity) > 0) then

                                    Shared.Events:ToServer(Enums.Society.AddItem, Client.Society:GetSocietyName(), item.name, tonumber(quantity));

                                else

                                    Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

                                end

                            end

                        });

                    end
                end

            elseif (isInventoryEmpty) then

                Items:Separator(Shared.Lang:Translate("society_menu_player_inventory_empty"));

            end

        else

            Items:Separator(Shared.Lang:Translate("society_menu_player_inventory_loading"));

        end

        Items:Separator(Shared.Lang:Translate("society_menu_chest_weapons_separator"));

        if (weapons) then

            if (Shared.Table:SizeOf(weapons) > 0) then

                for i = 1, #weapons do
                    local weapon = weapons[i];

                    if (weapon) then

                        local description = WeaponDescription(weapon, true);

                        Items:Button(weapon.label, description, {

                            RightBadge = RageUI.BadgeStyle.Gun,

                        }, not Shared:IsWeaponPermanent(weapon.name), {

                            onSelected = function()

                                local hash = GetHashKey(weapon.name);
                                local group = GetWeapontypeGroup(hash);
                                local weaponType = Shared:GetWeaponType(weapon.name);

                                if (Client.Player:GetWeaponsOfType(group) > 1) then

                                    local quantity = Shared:KeyboardInput(Shared.Lang:Translate("society_menu_chest_select_quantity", Shared:ServerColor(), Client.Player:GetAmmoForWeaponType(weaponType) or "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ERROR~s~"), 50);

                                    if (Shared:InputIsValid(quantity, "number")) then

                                        Shared.Events:ToServer(Enums.Society.AddWeapon, Client.Society:GetSocietyName(), weapon.name, tonumber(quantity));

                                    else

                                        Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

                                    end

                                else

                                    Shared.Events:ToServer(Enums.Society.AddWeapon, Client.Society:GetSocietyName(), weapon.name, Client.Player:GetAmmoForWeaponType(weaponType));

                                end

                            end

                        });

                    end

                end

            elseif (Shared.Table:SizeOf(weapons) == 0) then

                Items:Separator(Shared.Lang:Translate("society_menu_player_weapons_empty"));

            end

        else

            Items:Separator(Shared.Lang:Translate("society_menu_weapons_loading"));

        end

    else

        chest:Close();
        Game.Notification:ShowSimple(Shared.Lang:Translate("society_menu_chest_index_error"));

    end

end);