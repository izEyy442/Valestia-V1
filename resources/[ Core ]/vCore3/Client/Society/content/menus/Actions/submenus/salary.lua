--
--Created Date: 16:20 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [salary]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local SocietyMenus = Shared.Storage:Get("SocietyMenus");

---@type UIMenu
local menu = SocietyMenus:Get("action_salary");

menu:IsVisible(function(Items)

    local grades = Client.Society:GetGrades();

    if (grades) then

        for _, grade in pairs(grades) do

            Items:Button(grade.label, nil, {
                RightLabel = ("%s~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~$"):format(grade.salary)
            }, true, {

                onSelected = function()

                    local newSalary = Shared:KeyboardInput(Shared.Lang:Translate("society_menu_salary_set_salary", Shared:ServerColor(), grade.salary), 4);

                    if (Shared:InputIsValid(newSalary, "number") and tonumber(newSalary) > 0) then

                        Shared.Events:ToServer(Enums.Society.SetSalary, Client.Society:GetSocietyName(), grade.grade, tonumber(newSalary));

                    else

                        Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

                    end

                end

            });

        end

    end

end);