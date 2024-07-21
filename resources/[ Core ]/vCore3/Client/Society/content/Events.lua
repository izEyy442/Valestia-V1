--
--Created Date: 21:09 15/12/2022
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

Shared.Events:OnNet(Enums.Society.ReceiveMoney, function(money)
    Client.Society:SetMoney(money);
end);

Shared.Events:OnNet(Enums.Society.ReceiveDirtyMoney, function(money)
    Client.Society:SetDirtyMoney(money);
end);

Shared.Events:OnNet(Enums.Society.ReceiveEmployees, function(players)
    Client.Society:SetEmployees(players);
end);

Shared.Events:OnNet(Enums.Society.ReceiveItems, function(items, weight, maxWeight)
    Client.Society:SetItems(items);
    Client.Society:SetChestWeight(weight);
    Client.Society:SetChestMaxWeight(maxWeight);
end);

Shared.Events:OnNet(Enums.Society.ReceiveWeapons, function(weapons)
    Client.Society:SetWeapons(weapons);
end);

Shared.Events:OnNet(Enums.Society.ReceiveVehicles, function(vehicles)
    Client.Society:SetVehicles(vehicles);
end);

Shared.Events:OnNet(Enums.Society.ReceiveVehicle, function(plate, vehicle)

    local SocietyMenus = Shared.Storage:Get("SocietyMenus");

    ---@type UIMenu
    local selected = SocietyMenus:Get("action_vehicle_selected");

    if (selected:IsShowing() and selected:GetData("plate") == plate) then
        RageUI.GoBack();
    end

    Client.Society:SetVehicle(plate, vehicle);
end);

Shared.Events:OnNet(Enums.Society.ReceiveGrades, function(grades)
    Client.Society:SetGrades(grades);
end);

Shared.Events:OnNet(Enums.Society.JobChanged, function()
    Client.Society:CloseAll();
end);

Shared.Events:OnNet(Enums.Society.OpenAction, function(societyName)

    Client.Society:SelectSociety(societyName, function(jobData)

        if (jobData and Client.Society:IsPlayerBoss()) then

            local SocietyMenus = Shared.Storage:Get("SocietyMenus");

            ---@type UIMenu
            local menu = SocietyMenus:Get("action_main");
            SocietyMenus:Get("SetLabel")();

            menu:Toggle();

        end

    end);

end);

Shared.Events:OnNet(Enums.Society.OpenChest, function(societyName)

    Client.Society:SelectSociety(societyName, function(jobData)

        if (jobData) then

            local SocietyMenus = Shared.Storage:Get("SocietyMenus");

            Client.Society:RequestItems();
            Client.Society:RequestWeapons();

            ---@type UIMenu
            local menu = SocietyMenus:Get("chest_main");
            SocietyMenus:Get("SetLabel")();

            menu:Toggle();

        end

    end);

end);

Shared.Events:OnNet(Enums.Society.OpenVehicleMenu, function(jobName, coords)

    Client.Society:SelectSociety(jobName, function(jobData)

        if (jobData) then

            local SocietyMenus = Shared.Storage:Get("SocietyMenus");

            Client.Society:RequestVehicles();

            SocietyMenus:Get("SetLabel")();

            local  menu = SocietyMenus:Get("action_vehicles")

            menu:SetData("coords", coords);
            menu:Toggle();

        end

    end);

end);