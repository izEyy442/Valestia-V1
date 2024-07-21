--
--Created Date: 21:27 15/12/2022
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
local menu = SocietyMenus:Get("action_main");

menu:IsVisible(function(Items)

    Items:Button(Shared.Lang:Translate("society_menu_accounts"), nil, {}, true, {

        onSelected = function()

            Client.Society:RequestMoney();
            Client.Society:RequestDirtyMoney();

        end

    }, SocietyMenus:Get("action_accounts"));

    Items:Button(Shared.Lang:Translate("society_menu_employees"), nil, {}, true, {

        onSelected = function()

            Client.Society:RequestEmployees();

        end

    }, SocietyMenus:Get("action_players"));

    Items:Button(Shared.Lang:Translate("society_menu_salary"), nil, {}, true, {

        onSelected = function()

            Client.Society:RequestGrades();

        end

    }, SocietyMenus:Get("action_salary"));

end);