--
--Created Date: 19:24 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [BuildMenu]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local menu = RageUI.AddMenu("", "GangBuilder");
local gradeMenu = RageUI.AddSubMenu(menu, "", "GangBuilder");
local gangData = {
    grades = {},
};

local setter = {
    label = false,
    grades = false,
    boss_action = false,
    chest_action = false,
    take_vehicle = false,
    parking = false,
    vehicle_spawn = false,
};

---@return boolean
local function SetterValid()
    for _, value in pairs(setter) do
        if (not value) then
            return false;
        end
    end
    return true;
end

menu:IsVisible(function(Items)

    Items:Button(Shared.Lang:Translate("gangbuilder_menu_label"), nil, {}, true, {

        onSelected = function()

            local entry = Shared:KeyboardInput(Shared.Lang:Translate("gangbuilder_menu_set_label"), 20);

            if (Shared:InputIsValid(entry, "string")) then

                gangData.label = entry;
                gangData.name = string.gsub(entry, " ", "_"):lower();
                setter.label = true;

            end

        end

    });

    Items:Button(Shared.Lang:Translate("gangbuilder_menu_grades"), nil, {}, setter.label, {

            onSelected = function()

                setter.grades = true;

            end

    }, gradeMenu);

    Items:Button(Shared.Lang:Translate("gangbuilder_menu_boss_action"), Shared.Lang:Translate("gangbuilder_menu_boss_action_desc"), {}, setter.grades, {

        onSelected = function()
            local coords = Client.Player:GetCoords();

            gangData.boss_action = coords;
            setter.boss_action = true;

        end

    });

    Items:Button(Shared.Lang:Translate("gangbuilder_menu_chest_action"), Shared.Lang:Translate("gangbuilder_menu_chest_action_desc"), {}, setter.boss_action, {

        onSelected = function()

            local coords = Client.Player:GetCoords();

            gangData.chest_action = coords;
            setter.chest_action = true;

        end

    });

    Items:Button(Shared.Lang:Translate("gangbuilder_menu_vehicle_menu"), Shared.Lang:Translate("gangbuilder_menu_vehicle_menu_desc"), {}, setter.chest_action, {

        onSelected = function()

            local coords = Client.Player:GetCoords();

            gangData.take_vehicle = coords;
            setter.take_vehicle = true;

        end

    });

    Items:Button(Shared.Lang:Translate("gangbuilder_menu_vehicle_park"), Shared.Lang:Translate("gangbuilder_menu_vehicle_park_desc"), {}, setter.take_vehicle, {

        onSelected = function()

            local coords = Client.Player:GetCoords();

            gangData.parking = coords;
            setter.parking = true;

        end

    });

    Items:Button(Shared.Lang:Translate("gangbuilder_menu_vehicle_spawn"), Shared.Lang:Translate("gangbuilder_menu_vehicle_spawn_desc"), {}, setter.parking, {

        onSelected = function()

            local coords = Client.Player:GetCoords();
            local heading = Client.Player:GetHeading();

            gangData.vehicle_spawn = vector4(coords.x, coords.y, coords.z, heading);
            setter.vehicle_spawn = true;

        end

    });

    Items:Button(Shared.Lang:Translate("gangbuilder_menu_save"), nil, {
        Color = {
            BackgroundColor = RageUI.ItemsColour.Green,
        }
    }, SetterValid(), {

        onSelected = function()

            if (SetterValid()) then

                local gradesLenght = Shared.Table:SizeOf(gangData.grades);

                if (gradesLenght > 0) then

                    gangData.societyType = 2;
                    Shared.Events:ToServer(Enums.GangBuilder.AddGang, gangData);
                    menu:Close();

                else

                    Game.Notification:ShowSimple(Shared.Lang:Translate("gangbuilder_menu_no_grades"));

                end

            end

        end

    });

end, nil, function()
    gangData = {
        grades = {},
    };
    setter = {
        label = false,
        grades = false,
        boss_action = false,
        chest_action = false,
        take_vehicle = false,
        parking = false,
        vehicle_spawn = false,
    };
end);

gradeMenu:IsVisible(function(Items)

    Items:Button(Shared.Lang:Translate("gangbuilder_menu_add_grade"), nil, {}, true, {

        onSelected = function()

            local grade = {};
            grade.job_name = gangData.name;
            grade.skin_male = {};
            grade.skin_female = {};

            local entry = Shared:KeyboardInput(Shared.Lang:Translate("gangbuilder_menu_set_grade_label"), 20);

            if (Shared:InputIsValid(entry, "string")) then

                grade.label = entry;
                grade.name = string.gsub(entry, " ", "_"):lower();

                local entry = Shared:KeyboardInput(Shared.Lang:Translate("gangbuilder_menu_set_grade_salary"), 20);

                if (Shared:InputIsValid(entry, "number") and tonumber(entry) >= 0) then

                    grade.salary = tonumber(entry);

                    local entry = Shared:KeyboardInput(Shared.Lang:Translate("gangbuilder_menu_set_grade_level"), 20);

                    if (Shared:InputIsValid(entry, "number") and tonumber(entry) > 0) then

                        grade.grade = tonumber(entry);
                        gangData.grades[entry] = grade;

                    else

                        Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

                    end

                else

                    Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

                end

            else

                Game.Notification:ShowSimple(Shared.Lang:Translate("invalid_entry"));

            end

        end

    });

    if (Shared.Table:SizeOf(gangData.grades) > 0) then

        Items:Line();

        for _, gradeData in pairs(gangData.grades) do

            Items:Button(
                gradeData.label,
                Shared.Lang:Translate(
                    "gangbuilder_menu_grade_infos",
                    Shared:ServerColor(),
                    gradeData.grade,
                    Shared:ServerColor(),
                    gradeData.salary
            ), {}, true, {});

        end

    end

end);

Shared.Events:OnNet(Enums.GangBuilder.OpenGangBuilder, function()
    menu:Toggle();
end);