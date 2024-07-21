--
--Created Date: 14:37 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [listener]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Shared.Events:On(Enums.ESX.Player.Job.Server.setJob(), function(playerId, job, lastJob)

    local xPlayer = Server:ConvertToPlayer(playerId);
    local lastSociety = JG.SocietyManager:GetSociety(lastJob.name);
    local society = JG.SocietyManager:GetSociety(job.name);

    if (lastSociety and society) then

        Shared.Events:ToClient(xPlayer, Enums.Society.JobChanged);

        lastSociety:RemoveEmployee(xPlayer);
        society:AddEmployee(xPlayer, true);

        society:UpdateBossEvent(Enums.Society.ReceiveEmployees, society:GetEmployees());

    end

end);

Shared.Events:On(Enums.ESX.Player.Job.Server.setJob2(), function(playerId, job2, lastJob2)

    local xPlayer = Server:ConvertToPlayer(playerId);
    local lastGang = JG.SocietyManager:GetSociety(lastJob2.name);
    local gang = JG.SocietyManager:GetSociety(job2.name);

    if (lastGang and gang) then

        Shared.Events:ToClient(xPlayer, Enums.Society.JobChanged);

        lastGang:RemoveEmployee(xPlayer);
        gang:AddEmployee(xPlayer, true);

        local gangFromBuilder = JG.GangBuilder:GetGang(gang:GetName());

        if (gangFromBuilder) then

            Shared.Events:ToClient(xPlayer, Enums.GangBuilder.ReceiveGangData, gangFromBuilder);

        else

            Shared.Events:ToClient(xPlayer, Enums.GangBuilder.ReceiveGangData, {});

        end

        gang:UpdateBossEvent(Enums.Society.ReceiveEmployees, gang:GetEmployees());

    end

end);

Shared.Events:OnNet(Enums.Player.Events.PlayerLoaded, function(xPlayer)

    local society = JG.SocietyManager:GetSociety(xPlayer.job.name);
    local gang = JG.SocietyManager:GetSociety(xPlayer.job2.name);

    if (society) then

        society:AddEmployee(xPlayer);

        society:UpdateBossEvent(Enums.Society.ReceiveEmployees, society:GetEmployees());

    end

    if (gang) then

        gang:AddEmployee(xPlayer);

        gang:UpdateBossEvent(Enums.Society.ReceiveEmployees, gang:GetEmployees());

    end

end);