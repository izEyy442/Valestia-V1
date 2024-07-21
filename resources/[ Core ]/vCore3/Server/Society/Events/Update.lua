--
--Created Date: 20:12 15/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Update]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Shared.Events:OnNet(Enums.Society.AddMoney, function(xPlayer, societyName, amount, accountType)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:IsPlayerBoss(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                if (Config["Accounts"][accountType]) then

                    local playerAccount = xPlayer.getAccount(Config["Accounts"][accountType]);

                    if (playerAccount) then

                        if (playerAccount.money >= amount) then

                            xPlayer.removeAccountMoney(playerAccount.name, amount);

                            JG.Discord:SendMessage(
                                "MoneyPut", 
                                Shared.Lang:Translate(
                                    "discord_money_put", 
                                    xPlayer.getName(), 
                                    xPlayer.getIdentifier(), 
                                    ("%s "):format(tonumber(amount)),
                                    ("%s"):format(playerAccount.name),
                                    society:GetLabel()
                                )
                            );

                            if (accountType == "money") then

                                storage:AddMoney(amount);
                                society:UpdateBossEvent(Enums.Society.ReceiveMoney, storage:GetMoney());
                                --Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveMoney, storage:GetMoney());

                            elseif (accountType == "dirty_money") then

                                storage:AddDirtyMoney(amount);

                                society:UpdateBossEvent(Enums.Society.ReceiveDirtyMoney, storage:GetDirtyMoney());
                                --Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveDirtyMoney, storage:GetDirtyMoney());

                            end

                        else

                            xPlayer.showNotification(Shared.Lang:Translate("player_not_enought_money"));

                        end

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("society_add_money_error"));

                    end

                else

                    xPlayer.showNotification(Shared.Lang:Translate("society_add_money_error"));

                end

            else

                if (accountType == "money") then

                    society:UpdateBossEvent(Enums.Society.ReceiveMoney, 0);
                    --Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveMoney, 0);

                elseif (accountType == "dirty_money") then

                    society:UpdateBossEvent(Enums.Society.ReceiveDirtyMoney, 0);
                    --Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveDirtyMoney, 0);

                end

                xPlayer.showNotification(Shared.Lang:Translate("society_add_money_error"));

            end

        else

            Server:BanPlayer(xPlayer, "(Trying to add money to society storage)");

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RemoveMoney, function(xPlayer, societyName, amount, accountType)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:IsPlayerBoss(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                if (Config["Accounts"][accountType]) then

                    local playerAccount = xPlayer.getAccount(Config["Accounts"][accountType]);

                    if (playerAccount) then

                        local societyMoney = accountType == "money" and storage:GetMoney() or accountType == "dirty_money" and storage:GetDirtyMoney() or 0;

                        if (societyMoney - amount >= 0) then

                            xPlayer.addAccountMoney(playerAccount.name, amount);

                            JG.Discord:SendMessage(
                                "MoneyTake", 
                                Shared.Lang:Translate(
                                    "discord_money_take", 
                                    xPlayer.getName(), 
                                    xPlayer.getIdentifier(), 
                                    ("%s "):format(tonumber(amount)),
                                    ("%s"):format(playerAccount.name),
                                    society:GetLabel()
                                )
                            );

                            if (accountType == "money") then

                                storage:RemoveMoney(amount);

                                society:UpdateBossEvent(Enums.Society.ReceiveMoney, storage:GetMoney());
                                --Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveMoney, storage:GetMoney());

                            elseif (accountType == "dirty_money") then

                                storage:RemoveDirtyMoney(amount);

                                society:UpdateBossEvent(Enums.Society.ReceiveDirtyMoney, storage:GetDirtyMoney());
                                --Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveDirtyMoney, storage:GetDirtyMoney());

                            end

                        else

                            xPlayer.showNotification(Shared.Lang:Translate("society_no_enought_money"));

                        end

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("society_remove_money_error"));

                    end

                else

                    xPlayer.showNotification(Shared.Lang:Translate("society_remove_money_error"));

                end

            else

                if (accountType == "money") then

                    society:UpdateBossEvent(Enums.Society.ReceiveMoney, 0);
                    --Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveMoney, 0);

                elseif (accountType == "dirty_money") then

                    society:UpdateBossEvent(Enums.Society.ReceiveDirtyMoney, 0);
                    --Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveDirtyMoney, 0);

                end

                xPlayer.showNotification(Shared.Lang:Translate("society_remove_money_error"));

            end

        else

            Server:BanPlayer(xPlayer, "(Trying to remove money from society storage)");

        end

    end

end);

Shared.Events:OnNet(Enums.Society.AddItem, function(xPlayer, societyName, itemName, amount)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:DoesPlayerExist(xPlayer)) then

            local playerItem = xPlayer.getInventoryItem(itemName);

            if (playerItem) then

                if (playerItem.count >= amount) then

                    local storage = society:GetStorage();

                    if (storage) then

                        if (storage:CanAddItem(itemName, amount)) then

                            xPlayer.removeInventoryItem(itemName, amount);

                            storage:AddItem(itemName, amount);

                            society:UpdateEvent(Enums.Society.ReceiveItems, storage:GetItems(), storage:GetWeight(), storage:GetMaxWeight());

                            JG.Discord:SendMessage(
                                "ChestPut", 
                                Shared.Lang:Translate(
                                    "discord_chest_put", 
                                    xPlayer.getName(), 
                                    xPlayer.getIdentifier(), 
                                    amount, 
                                    playerItem.label, 
                                    society:GetLabel()
                                )
                            );

                        else

                            xPlayer.showNotification(Shared.Lang:Translate("society_storage_full"));

                        end

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("society_add_item_error"));

                    end

                else

                    xPlayer.showNotification(Shared.Lang:Translate("player_no_enought_item", Shared:ServerColor(), playerItem.label));

                end

            else

                xPlayer.showNotification(Shared.Lang:Translate("society_add_item_error"));

            end

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RemoveItem, function(xPlayer, societyName, itemName, amount)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:DoesPlayerExist(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                if (storage:HasItem(itemName)) then

                    local item = storage:GetItem(itemName);

                    if (item.count >= amount) then

                        if (xPlayer.canCarryItem(itemName, amount)) then

                            xPlayer.addInventoryItem(itemName, amount);

                            storage:RemoveItem(itemName, amount);

                            society:UpdateEvent(Enums.Society.ReceiveItems, storage:GetItems(), storage:GetWeight(), storage:GetMaxWeight());
                            --Shared.Events:ToClient(xPlayer, Enums.Society.ReceiveItems, storage:GetItems());

                            JG.Discord:SendMessage(
                                "ChestTake", 
                                Shared.Lang:Translate(
                                    "discord_chest_take", 
                                    xPlayer.getName(), 
                                    xPlayer.getIdentifier(), 
                                    amount, 
                                    item.label, 
                                    society:GetLabel()
                                )
                            );

                        else
                            xPlayer.showNotification(Shared.Lang:Translate("player_no_enought_space"));
                        end

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("society_no_enought_item", Shared:ServerColor(), item.label));

                    end

                else

                    xPlayer.showNotification(Shared.Lang:Translate("society_remove_item_error"));

                end

            else

                xPlayer.showNotification(Shared.Lang:Translate("society_remove_item_error"));

            end

        end

    end

end);

Shared.Events:OnNet(Enums.Society.AddWeapon, function(xPlayer, societyName, weaponName, ammo)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:DoesPlayerExist(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                local hasWeapon, playerWeapon = xPlayer.getWeapon(weaponName);

                if (hasWeapon) then

                    local newAmmo = tonumber(ammo);

                    if (newAmmo > xPlayer.GetAmmoForWeaponType(Shared:GetWeaponType(weaponName))) then

                        xPlayer.showNotification(Shared.Lang:Translate("insufisent_weapon_ammo"));
                        return;

                    end

                    if (xPlayer.removeWeapon(weaponName, newAmmo)) then

                        storage:AddWeapon(playerWeapon, newAmmo);

                        society:UpdateEvent(Enums.Society.ReceiveWeapons, storage:GetWeapons());

                        JG.Discord:SendMessage(
                            "ChestPut", 
                            Shared.Lang:Translate(
                                "discord_chest_put", 
                                xPlayer.getName(), 
                                xPlayer.getIdentifier(), 
                                ("1 %s"):format(playerWeapon.label),
                                ("avec %s Munitions"):format(tostring(newAmmo)),
                                society:GetLabel()
                            )
                        );

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("insufisent_weapon_ammo"));

                    end

                else

                    xPlayer.showNotification(Shared.Lang:Translate("society_player_no_enought_weapon"));

                end

            else

                xPlayer.showNotification(Shared.Lang:Translate("society_add_weapon_error"));

            end

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RemoveWeapon, function(xPlayer, societyName, weaponName, ammo, components)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:DoesPlayerExist(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                local weapon = storage:GetWeapon(weaponName);

                if (weapon) then

                    if (not xPlayer.hasWeapon(weaponName)) then

                        if (storage:RemoveWeapon(weaponName, ammo, components)) then

                            xPlayer.addWeapon(weaponName, ammo);

                            if (type(components) == 'table') then
                                for i = 1, #components do
                                    xPlayer.addWeaponComponent(weaponName, components[i]);
                                end
                            end

                            local _, playerWeapon = xPlayer.getWeapon(weaponName);

                            JG.Discord:SendMessage(
                                "ChestTake",
                                Shared.Lang:Translate(
                                    "discord_chest_take",
                                    xPlayer.getName(),
                                    xPlayer.getIdentifier(),
                                    ("1 %s"):format(playerWeapon.label),
                                    ("avec %s Munitions"):format(tonumber(ammo)),
                                    society:GetLabel()
                                )
                            );

                        else

                            xPlayer.showNotification(Shared.Lang:Translate("society_remove_weapon_error"));

                        end

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("society_player_has_already_weapon"));

                    end

                    society:UpdateEvent(Enums.Society.ReceiveWeapons, storage:GetWeapons());

                else

                    xPlayer.showNotification(Shared.Lang:Translate("society_no_enought_weapon"));

                end

            else

                xPlayer.showNotification(Shared.Lang:Translate("society_remove_weapon_error"));

            end

        end

    end

end);

Shared.Events:OnNet(Enums.Society.SetGrade, function(xPlayer, societyName, identifier, actionType, targetId)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:IsPlayerBoss(xPlayer)) then

            local target = ESX.GetPlayerFromId(targetId);

            local employee = target and society:GetEmployee(target.getIdentifier()) or society:GetEmployee(identifier);


            if (actionType == "recruit") then

                if (targetId) then

                    if (not employee) then

                        if (target) then

                            local targetJob = society:IsJob() and target.getJob() or society:IsGang() and target.getJob2();

                            if (targetJob and targetJob.name == "unemployed" or targetJob.name == "unemployed2") then

                                if (ESX.DoesJobExist(society:GetName(), 0)) then


                                    if (society:IsJob()) then
                                            
                                        target.setJob(society:GetName(), 0);
                                        local job = target.getJob();

                                        xPlayer.showNotification(
                                            Shared.Lang:Translate(
                                                "society_set_job_target", 
                                                Shared:ServerColor(), 
                                                target.getFirstName(), 
                                                target.getLastName(),
                                                Shared:ServerColor(),
                                                job.grade_label
                                            )
                                        );

                                        target.showNotification(
                                            Shared.Lang:Translate(
                                                "society_set_job_player", 
                                                Shared:ServerColor(), 
                                                society:GetLabel(),
                                                Shared:ServerColor(),
                                                xPlayer.getFirstName(), 
                                                xPlayer.getLastName(),
                                                Shared:ServerColor(),
                                                job.grade_label
                                            )
                                        );

                                    elseif (society:IsGang()) then

                                        target.setJob2(society:GetName(), 0);
                                        local job2 = target.getJob2();

                                        xPlayer.showNotification(
                                            Shared.Lang:Translate(
                                                "society_set_job_target", 
                                                Shared:ServerColor(), 
                                                target.getFirstName(), 
                                                target.getLastName(),
                                                Shared:ServerColor(),
                                                job2.grade_label
                                            )
                                        );

                                        target.showNotification(
                                            Shared.Lang:Translate(
                                                "society_set_job_player", 
                                                Shared:ServerColor(), 
                                                society:GetLabel(),
                                                Shared:ServerColor(),
                                                xPlayer.getFirstName(), 
                                                xPlayer.getLastName(),
                                                Shared:ServerColor(),
                                                job2.grade_label
                                            )
                                        );
                                    
                                    else

                                        return xPlayer.showNotification(Shared.Lang:Translate("society_grade_invalid_error"));

                                    end

                                    society:UpdateBossEvent(Enums.Society.ReceiveEmployees, society:GetEmployees());

                                elseif (ESX.DoesJobExist(society:GetName(), 1)) then

                                    if (society:IsJob()) then
                                            
                                        target.setJob(society:GetName(), 1);
                                        local job = target.getJob();

                                        xPlayer.showNotification(
                                            Shared.Lang:Translate(
                                                "society_set_job_target", 
                                                Shared:ServerColor(), 
                                                target.getFirstName(), 
                                                target.getLastName(),
                                                Shared:ServerColor(),
                                                job.grade_label
                                            )
                                        );

                                        target.showNotification(
                                            Shared.Lang:Translate(
                                                "society_set_job_player", 
                                                Shared:ServerColor(), 
                                                society:GetLabel(),
                                                Shared:ServerColor(),
                                                xPlayer.getFirstName(), 
                                                xPlayer.getLastName(),
                                                Shared:ServerColor(),
                                                job.grade_label
                                            )
                                        );

                                    elseif (society:IsGang()) then

                                        target.setJob2(society:GetName(), 1);
                                        local job2 = target.getJob2();

                                        xPlayer.showNotification(
                                            Shared.Lang:Translate(
                                                "society_set_job_target", 
                                                Shared:ServerColor(), 
                                                target.getFirstName(), 
                                                target.getLastName(),
                                                Shared:ServerColor(),
                                                job2.grade_label
                                            )
                                        );

                                        target.showNotification(
                                            Shared.Lang:Translate(
                                                "society_set_job_player", 
                                                Shared:ServerColor(), 
                                                society:GetLabel(),
                                                Shared:ServerColor(),
                                                xPlayer.getFirstName(), 
                                                xPlayer.getLastName(),
                                                Shared:ServerColor(),
                                                job2.grade_label
                                            )
                                        );

                                    else

                                        return xPlayer.showNotification(Shared.Lang:Translate("society_grade_invalid_error"));

                                    end

                                    society:UpdateBossEvent(Enums.Society.ReceiveEmployees, society:GetEmployees());

                                else

                                    xPlayer.showNotification(Shared.Lang:Translate("society_grade_invalid_error"));

                                end

                            else

                                xPlayer.showNotification(Shared.Lang:Translate("society_target_has_already_job"));
                                target.showNotification(Shared.Lang:Translate("society_player_has_already_job"));

                            end

                        else

                            xPlayer.showNotification(Shared.Lang:Translate("society_player_not_found"));

                        end

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("society_set_grade_player_already_in_society"));

                    end

                else

                    xPlayer.showNotification(Shared.Lang:Translate("society_player_not_found"));

                end

            elseif (actionType == "promote") then

                if (employee) then

                    if (not employee.isBoss) then

                        if (ESX.DoesJobExist(society:GetName(), employee.grade_level + 1)) then

                            society:UpdateEmployee(identifier, employee.grade_level + 1);

                            society:UpdateBossEvent(Enums.Society.ReceiveEmployees, society:GetEmployees());

                        else

                            xPlayer.showNotification(Shared.Lang:Translate("society_set_grade_error"));

                        end

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("society_set_grade_player_is_boss"));

                    end

                end

            elseif (actionType == "demote") then

                if (employee) then

                    if (not employee.isBoss) then

                        if (ESX.DoesJobExist(society:GetName(), employee.grade_level - 1)) then

                            society:UpdateEmployee(identifier, employee.grade_level - 1);

                            society:UpdateBossEvent(Enums.Society.ReceiveEmployees, society:GetEmployees());

                        else

                            xPlayer.showNotification(Shared.Lang:Translate("society_set_grade_error"));

                        end

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("society_set_grade_cant_demote_boss"));

                    end

                end

            elseif (actionType == "fire") then

                if (employee) then

                    if (not employee.isBoss) then

                        society:UpdateEmployee(identifier, false);

                        society:UpdateBossEvent(Enums.Society.ReceiveEmployees, society:GetEmployees());

                    else

                        xPlayer.showNotification(Shared.Lang:Translate("society_set_grade_cant_demote_boss"));

                    end

                end

            end

        end

    end

end);

Shared.Events:OnNet(Enums.Society.SetSalary, function(xPlayer, societyName, gradeLevel, newSalary)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:IsPlayerBoss(xPlayer)) then

            society:SetSalary(gradeLevel, tonumber(newSalary));

            society:UpdateBossEvent(Enums.Society.ReceiveGrades, society:GetGrades());

        else

            Server:BanPlayer(xPlayer, ("(Trying to set salary for society: %s grade: %s)"):format(societyName, gradeLevel));

        end

    end

end);

Shared.Events:OnNet(Enums.Society.TakeVehicle, function(xPlayer, societyName, plate, coords, price)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:DoesPlayerExist(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                local vehicleData = storage:GetVehicle(plate);

                if (not storage:IsVehicleOut(plate)) then

                    local playerMoney = xPlayer.getAccount("cash");

                    if (price and playerMoney) then

                        if (playerMoney.money >= price) then

                            xPlayer.removeAccountMoney("cash", price);

                            if (vehicleData) then

                                JG.VehicleManager:CreateVehicle(vehicleData.data.model, coords, coords.w or 0.0, plate, function(vehicle)

                                    vehicle:SetProperties(vehicleData.data, xPlayer, function()

                                        storage:RemoveVehicle(plate, vehicle);
                                        society:UpdateEvent(Enums.Society.ReceiveVehicle, plate, storage:GetVehicle(plate));

                                    end);

                                end);

                                xPlayer.showNotification(Shared.Lang:Translate("society_buy_pound_vehicle_success", Config["Society"]["Pound"]["Price"]));

                            end

                        else

                            xPlayer.showNotification(Shared.Lang:Translate("society_take_vehicle_not_enough_money"));

                        end

                    elseif (not price) then

                        if (vehicleData) then

                            JG.VehicleManager:CreateVehicle(vehicleData.data.model, coords, coords.w or 0.0, plate, function(vehicle)

                                vehicle:SetProperties(vehicleData.data, xPlayer, function()

                                    storage:RemoveVehicle(plate, vehicle);
                                    society:UpdateEvent(Enums.Society.ReceiveVehicle, plate, storage:GetVehicle(plate));

                                end);

                            end);

                        end

                    end

                else

                    xPlayer.showNotification(Shared.Lang:Translate("society_vehicle_already_out"));

                end

            end

        end

    end

end);

Shared.Events:OnNet(Enums.Society.ParkVehicle, function(xPlayer, societyName, plate)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        if (society:DoesPlayerExist(xPlayer)) then

            local storage = society:GetStorage();

            if (storage) then

                MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {

                    ["@plate"] = plate

                },function(result)

                    local isOwned = #result > 0;

                    if (isOwned) then

                        if ( result[1].boutique ~= nil and (result[1].boutique == 1 or result[1].boutique == true) ) then

                            xPlayer.showNotification(Shared.Lang:Translate("society_park_vehicle_is_permanent"));

                        else

                            local vehicle = JG.VehicleManager:GetVehicleByPlate(plate);

                            if (vehicle) then

                                vehicle:RequestProperties(xPlayer, function(properties)

                                    if (result[1].owner == xPlayer.getIdentifier()) then

                                        MySQL.Async.fetchAll("DELETE FROM owned_vehicles WHERE plate = @plate and owner = @owner", {

                                            ["@plate"] = plate,
                                            ["@owner"] = xPlayer.getIdentifier()

                                        }, function()

                                            local vehicleKeyId = Shared.Vehicle:ConvertPlate(plate);

                                            if (storage:AddVehicle(plate, properties, xPlayer.getIdentifier())) then

                                                JG.VehicleManager:RemoveVehicle(plate);
                                                JG.KeyManager:RemoveKey("vehicle", vehicleKeyId, true);
                                                society:UpdateEvent(Enums.Society.ReceiveVehicle, plate, storage:GetVehicle(plate));

                                            end

                                        end);

                                    else

                                        xPlayer.showNotification(Shared.Lang:Translate("society_park_vehicle_not_owned"));

                                    end

                                end);

                            end

                        end

                    else

                        local vehicle = JG.VehicleManager:GetVehicleByPlate(plate);

                        if (vehicle) then

                            vehicle:RequestProperties(xPlayer, function(properties)

                                local societyVehicle = storage:GetVehicle(plate);

                                if (societyVehicle) then

                                    if (storage:AddVehicle(plate, properties, societyVehicle.owner)) then

                                        JG.VehicleManager:RemoveVehicle(plate);
                                        society:UpdateEvent(Enums.Society.ReceiveVehicle, plate, storage:GetVehicle(plate));

                                    end

                                else

                                    xPlayer.showNotification(Shared.Lang:Translate("society_park_vehicle_not_from_society"));

                                end

                            end);

                        else

                            xPlayer.showNotification(Shared.Lang:Translate("society_park_vehicle_not_owned"));

                        end

                    end

                end);

            end

        end

    end

end);

Shared.Events:OnNet(Enums.Society.RetrievePlayerVehicle, function(xPlayer, societyName, vehiclePlate)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        local storage = society:GetStorage();

        if (storage) then

            local vehicle = storage:GetVehicle(vehiclePlate);

            if (vehicle) then

                local owner = storage:GetVehicleOwner(vehiclePlate);

                if (owner) then

                    if (owner == xPlayer.getIdentifier()) then

                        local convertedPlate = Shared.Vehicle:ConvertPlate(vehiclePlate);

                        MySQL.Async.execute("INSERT INTO `owned_vehicles` (owner, plate, vehicle, type, stored) VALUES (@identifier, @plate, @vehicleData, @type, @stored)", {

                                ["@identifier"] = owner,
                                ["@plate"] = convertedPlate,
                                ["@vehicleData"] = json.encode(storage:GetVehicleProps(vehiclePlate)),
                                ["@type"] = "car",
                                ["@stored"] = 1

                        }, function()

                            local managedVehicle = JG.VehicleManager:GetVehicleByPlate(vehiclePlate);

                            if (managedVehicle) then
                                JG.VehicleManager:RemoveVehicle(vehiclePlate);
                            end

                            JG.KeyManager:AddKey(xPlayer, VehicleKey, convertedPlate, "vehicle", true);
                            storage:DeleteVehicle(vehiclePlate);

                            society:UpdateEvent(Enums.Society.ReceiveVehicle, vehiclePlate, nil);

                            xPlayer.showNotification(Shared.Lang:Translate("society_retrieve_vehicle_success"));

                        end);

                    end

                end

            end

        end

    end

end);