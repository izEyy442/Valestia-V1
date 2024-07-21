--
--Created Date: 21:41 15/12/2022
--Author: vCore3
--Made with ❤
--
--File: [accounts]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local SocietyMenus = Shared.Storage:Get("SocietyMenus");

---@type UIMenu
local menu = SocietyMenus:Get("action_accounts");
---@type UIMenu
local money = SocietyMenus:Get("action_money");
---@type UIMenu
local dirty_money = SocietyMenus:Get("action_dirty_money");

---@param Items Items
---@param moneyType string
---@param deposit string
---@param withdraw string
local function Buttons(Items, moneyType, deposit, withdraw)

    local money = moneyType == "money" and Client.Society:GetMoney() or Client.Society:GetDirtyMoney();
    Items:Line();

    Items:Button(Shared.Lang:Translate(deposit), nil, {

        RightBadge = RageUI.BadgeStyle.Tick,

    }, true, {

        onSelected = function()

            local amount = Shared:KeyboardInput(Shared.Lang:Translate("society_menu_deposit", Shared:ServerColor(), Client.Player:GetMoney()), 10);

            if (Shared:InputIsValid(amount, "number") and tonumber(amount) > 0) then

                local newAmount = tonumber(amount);

                if (newAmount > 0) then

                    Shared.Events:ToServer(Enums.Society.AddMoney, Client.Society:GetSocietyName(), newAmount, moneyType);

                else

                    Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

                end

            else

                Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

            end

        end

    });

    Items:Button(Shared.Lang:Translate(withdraw), nil, {

        RightBadge = RageUI.BadgeStyle.Alert,

    }, true, {

        onSelected = function()

            local amount = Shared:KeyboardInput(Shared.Lang:Translate("society_menu_withdraw", Shared:ServerColor() , money), 10);

            if (Shared:InputIsValid(amount, "number") and tonumber(amount) > 0) then

                local newAmount = tonumber(amount);

                if (newAmount > 0) then

                    Shared.Events:ToServer(Enums.Society.RemoveMoney, Client.Society:GetSocietyName(), newAmount, moneyType);

                else

                    Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

                end

            else

                Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

            end

        end

    });

end

menu:IsVisible(function(Items)

    Items:Button(Shared.Lang:Translate("society_menu_money"), nil, {}, true, {}, money);
    Items:Button(Shared.Lang:Translate("society_menu_dirty_money"), nil, {}, Client.Society:CanUseOffshore(), {}, dirty_money);

end);

money:IsVisible(function(Items)

    Items:Separator(Shared.Lang:Translate("society_money", Client.Society:GetMoney()));

    Buttons(Items, "money", "society_menu_money_add", "society_menu_money_remove");

end);

dirty_money:IsVisible(function(Items)

    Items:Separator(Shared.Lang:Translate("society_money", Client.Society:GetDirtyMoney()));

    Buttons(Items, "dirty_money", "society_menu_dirty_money_add", "society_menu_dirty_money_remove");

end);