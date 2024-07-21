--
--Created Date: 19:20 15/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Requests]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Shared.Events:On("onResourceStart", function(resourceName)

    if (resourceName == "vCore3") then

        MySQL.ready(function()

            if (ESX) then

                if (Shared.Table:SizeOf(ESX.Jobs) > 0) then

                    Shared.Events:Trigger(Enums.ESX.Societies.jobsLoaded, ESX.Jobs);

                end

            end

        end);

    end

end);

Shared.Events:OnNet(Enums.Society.RequestMoney, function(xPlayer, societyName)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:IsPlayerBoss(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveMoney, storage:GetMoney());

            else

                xPlayer.showNotification(Shared.Lang:Translate("society_get_money_error"));
                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveMoney, 0);

            end

        else

            Server:BanPlayer(xPlayer, "(Trying to get money from society storage)");

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RequestDirtyMoney, function(xPlayer, societyName)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:IsPlayerBoss(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveDirtyMoney, storage:GetDirtyMoney());

            else

                xPlayer.showNotification(Shared.Lang:Translate("society_get_dirty_money_error"));
                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveDirtyMoney, 0);

            end

        else

            Server:BanPlayer(xPlayer, "(Trying to get dirty money from society storage)");

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RequestEmployees, function(xPlayer, societyName)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:IsPlayerBoss(xPlayer)) then

            Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveEmployees, society:GetEmployees());

        else

            Server:BanPlayer(xPlayer, "(Trying to get employees from society)");

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RequestItems, function(xPlayer, societyName)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:DoesPlayerExist(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveItems, storage:GetItems(), storage:GetWeight(), storage:GetMaxWeight());

            else

                xPlayer.showNotification(Shared.Lang:Translate("society_get_items_error"));
                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveItems, {}, 0, 0);

            end

        else

            Server:BanPlayer(xPlayer, "(Trying to get items from society storage)");

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RequestWeapons, function(xPlayer, societyName)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:DoesPlayerExist(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveWeapons, storage:GetWeapons());

            else

                xPlayer.showNotification(Shared.Lang:Translate("society_get_weapons_error"));
                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveWeapons, {});

            end

        else

            Server:BanPlayer(xPlayer, "(Trying to get weapons from society storage)");

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RequestVehicles, function(xPlayer, societyName)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:DoesPlayerExist(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveVehicles, storage:GetVehicles());

            else

                xPlayer.showNotification(Shared.Lang:Translate("society_get_vehicles_error"));
                Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveVehicles, {});

            end

        else

            Server:BanPlayer(xPlayer, "(Trying to get vehicles from society storage)");

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RequestGrades, function(xPlayer, societyName)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:IsPlayerBoss(xPlayer)) then

            Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveGrades, society:GetGrades());

        end

    end

end);