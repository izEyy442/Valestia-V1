--
--Created Date: 21:27 15/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Storage]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local SocietyMenus = Shared.Storage:Register("SocietyMenus");

SocietyMenus:Set("SetLabel", function()

    for name, menu in pairs(SocietyMenus:GetAll()) do

        ---@type UIMenu
        local menuData = menu;

        if (menuData) then
            if (name ~= "SetLabel") then
                menuData:SetSubtitle(Client.Society:GetTypeLabel());
            end
        end

    end

end);

--Actions
local parent = SocietyMenus:Set("action_main", RageUI.AddMenu("", "Actions"));

local players = SocietyMenus:Set("action_players", RageUI.AddSubMenu(parent, "", "Actions"));
SocietyMenus:Set("action_selected_players", RageUI.AddSubMenu(players, "", "Actions"));
local accounts = SocietyMenus:Set("action_accounts", RageUI.AddSubMenu(parent, "", "Actions"));
SocietyMenus:Set("action_money", RageUI.AddSubMenu(accounts, "", "Actions"));
SocietyMenus:Set("action_dirty_money", RageUI.AddSubMenu(accounts, "", "Actions"));
SocietyMenus:Set("action_salary", RageUI.AddSubMenu(parent, "", "Actions"));

--Garage
local vehicles = SocietyMenus:Set("action_vehicles", RageUI.AddMenu("", "Actions"));
SocietyMenus:Set("action_vehicle_selected", RageUI.AddSubMenu(vehicles, "", "Actions"));

--Pound
SocietyMenus:Set("action_pound", RageUI.AddMenu("", "Actions"));

--Chest
SocietyMenus:Set("chest_main", RageUI.AddMenu("", "Chest"));