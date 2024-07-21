--
--Created Date: 19:15 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Events]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Shared.Events:OnNet(Enums.GangBuilder.RequestGangData, function(xPlayer)

    local playerGang = xPlayer.getJob2();

    if (playerGang and playerGang.name ~= "unemployed2") then

        local gangData = JG.GangBuilder:GetGang(playerGang.name);

        Shared.Events:ToClient(xPlayer, Enums.GangBuilder.ReceiveGangData, gangData and gangData or {});

    end

end);

Shared.Events:OnNet(Enums.GangBuilder.AddGang, function(xPlayer, gangData)

    if (xPlayer.getGroup() == "founder" or xPlayer.getGroup() == "gerant-il") then

        local hasBossGrade = false;
        local gradesLenght = Shared.Table:SizeOf(gangData.grades);

        if (gradesLenght > 0) then

            for _, grade in pairs(gangData.grades) do

                if (grade.name == "boss") then

                    hasBossGrade = true;
                    break;

                end

            end

            if (gradesLenght > 6) then

                xPlayer.showNotification(Shared.Lang:Translate("gangbuilder_max_grades"));
                return;

            end

            if (not hasBossGrade) then

                local bossGrade = gradesLenght + 1;

                gangData.grades[tostring(bossGrade)] = {
                    job_name = gangData.name,
                    name = "boss",
                    label = "Patron",
                    salary = 0,
                    grade = bossGrade,
                    skin_male = {},
                    skin_female = {}
                };

                Shared.Log:Warn(Shared.Lang:Translate("gangbuilder_added_boss_grade", gangData.name));

            end

            gangData.canUseOffshore = true;
            gangData.canWashMoney = false;

            JG.GangBuilder:SaveGang(gangData);
            JG.SocietyManager:AddSociety(gangData, function()

                xPlayer.showNotification(Shared.Lang:Translate("gangbuilder_added_gang", Shared:ServerColor() ,gangData.name));

            end);

        else

            xPlayer.showNotification(Shared.Lang:Translate("gangbuilder_no_grades"));

        end

    end

end);

Shared:RegisterCommand("gangbuilder", function(xPlayer)

    if (not xPlayer) then return; end

    if (xPlayer.getGroup() == "founder" or xPlayer.getGroup() == "gerant-il") then

        Shared.Events:ToClient(xPlayer, Enums.GangBuilder.OpenGangBuilder);

    end

end);

Shared:RegisterCommand("removegang", function(xPlayer, args)

    if (xPlayer) then

        if (xPlayer.getGroup() == "founder" or xPlayer.getGroup() == "gerant-il") then

            local gangName = args[1];

            if (gangName) then

                if (JG.SocietyManager:RemoveSociety(gangName)) then

                    JG.GangBuilder:DeleteGang(gangName);
                    xPlayer.showNotification(Shared.Lang:Translate("gangbuilder_removed_gang", Shared:ServerColor(), gangName));

                else

                    xPlayer.showNotification(Shared.Lang:Translate("gangbuilder_gang_not_found", gangName));

                end

            else

                xPlayer.showNotification(Shared.Lang:Translate("invalid_entry"));

            end

        end

    else

        local gangName = args[1];

            if (gangName) then

                JG.SocietyManager:RemoveSociety(gangName);
                JG.GangBuilder:DeleteGang(gangName);

            else

                Shared.Log:Error(Shared.Lang:Translate("server_invalid_entry"));

            end

    end

end);