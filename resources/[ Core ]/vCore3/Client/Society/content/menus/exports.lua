--
--Created Date: 14:27 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [exports]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@param societyName string
exports("OpenSocietyMenu", function(societyName)

    Client.Society:SelectSociety(societyName, function(jobData)

        if (jobData) then

            local societyMenus = Shared.Storage:Get("SocietyMenus");

            ---@type UIMenu
            local menu = societyMenus:Get("action_main");
            societyMenus:Get("SetLabel")();

            menu:Toggle();

        end

    end);

end);

exports("OpenSocietyChest", function(societyName)

    Client.Society:SelectSociety(societyName, function(jobData)

        if (jobData) then

            local societyMenus = Shared.Storage:Get("SocietyMenus");

            Client.Society:RequestItems();
            Client.Society:RequestWeapons();

            ---@type UIMenu
            local menu = societyMenus:Get("chest_main");
            societyMenus:Get("SetLabel")();

            menu:Toggle();

        end

    end);

end);

exports("ParkSocietyVehicle", function(societyName, plate)

    Client.Society:SelectSociety(societyName, function(jobData)

        if (jobData) then

            Client.Society:ParkVehicle(plate);

        end

    end);

end);

exports("OpenSocietyGarage", function(societyName, coords)
    Client.Society:SelectSociety(societyName, function(jobData)

        if (jobData) then

            local SocietyMenus = Shared.Storage:Get("SocietyMenus");

            Client.Society:RequestVehicles();

            SocietyMenus:Get("SetLabel")();

            local menu = SocietyMenus:Get("action_vehicles");

            menu:SetData("coords", coords);
            menu:Toggle();

        end

    end);
end);

exports("RecruitPlayer", function(jobType, targetId)

    local job = jobType == "job" and Client.Player:GetJob() or jobType == "job2" and Client.Player:GetJob2();

    if (job) then

        Client.Society:SelectSociety(job.name, function(jobData)

            if (jobData) then

                Shared.Events:ToServer(Enums.Society.SetGrade, job.name, nil, "recruit", targetId);

            end

        end);

    end

end);