--
--Created Date: 14:31 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [players]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local SocietyMenus = Shared.Storage:Get("SocietyMenus");

---@type UIMenu
local menu  = SocietyMenus:Get("action_players");
---@type UIMenu
local selectedPlayer = SocietyMenus:Get("action_selected_players");

menu:IsVisible(function(Items)

    local employees = Client.Society:GetEmployees();

    if (employees) then

        for _, employee in pairs(Client.Society:GetEmployees()) do

            Items:Button(("%s %s"):format(employee.firstname, employee.lastname), nil, {
                RightLabel = employee.grade,
                Color = {
                    HightLightColor = employee.isBoss and RageUI.ItemsColour.Damage or nil,
                }
            }, true, {

                onSelected = function()

                    menu:SetData("employee", employee);

                end

            }, selectedPlayer);

        end

    else

        Items:Separator(Shared.Lang:Translate("society_menu_loading_employees"));

    end

end);

selectedPlayer:IsVisible(function(Items)

    local employee = menu:GetData("employee");

    if (employee) then

        Items:Button(Shared.Lang:Translate("society_menu_promote"), nil, {}, true, {

            onSelected = function()

                Shared.Events:ToServer(Enums.Society.SetGrade, Client.Society:GetSocietyName(), employee.identifier, "promote");
                RageUI.GoBack();

            end

        });

        Items:Button(Shared.Lang:Translate("society_menu_demote"), nil, {}, true, {

            onSelected = function()

                Shared.Events:ToServer(Enums.Society.SetGrade, Client.Society:GetSocietyName(), employee.identifier, "demote");
                RageUI.GoBack();

            end

        });

        Items:Button(Shared.Lang:Translate("society_menu_fire"), nil, {}, true, {

            onSelected = function()

                Shared.Events:ToServer(Enums.Society.SetGrade, Client.Society:GetSocietyName(), employee.identifier, "fire");
                RageUI.GoBack();

            end

        });

    else

        Items:Separator(Shared.Lang:Translate("society_menu_loading_selected_employee"));

    end

end);





