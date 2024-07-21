--
--Created Date: 22:29 17/12/2022
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

exports("GetSocietyMoney", function(societyName)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        local storage = society:GetStorage();

        if (storage) then

            return storage:GetMoney();

        end

    end

    return 0;

end);

exports("SocietyExist", function(societyName)
    return JG.SocietyManager:GetSociety(societyName) ~= nil
end)

---@param societyName string
---@param amount number
---@return boolean
exports("AddSocietyMoney", function(societyName, amount)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        local storage = society:GetStorage();

        if (storage) then
            storage:AddMoney(amount);
            return true;
        end

    end

    return false;

end);

---@param societyName string
---@param amount number
---@return boolean
exports("RemoveSocietyMoney", function(societyName, amount)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        local storage = society:GetStorage();

        if (storage) then
            storage:RemoveMoney(amount);
            return true;
        end

    end

    return false;

end);

---@param societyName string
---@param amount number
---@return boolean
exports("AddSocietyDirtyMoney", function(societyName, amount)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        local storage = society:GetStorage();

        if (storage) then
            storage:AddDirtyMoney(amount);
            return true;
        end

    end

    return false;

end);

---@param societyName string
---@param amount number
---@return boolean
exports("RemoveSocietyDirtyMoney", function(societyName, amount)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        local storage = society:GetStorage();

        if (storage) then
            storage:RemoveDirtyMoney(amount);
            return true;
        end

    end

    return false;

end);

---@param societyName string
---@param itemName string
---@param count number
---@return boolean
exports("AddSocietyItem", function(societyName, itemName, count)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        local storage = society:GetStorage();

        if (storage) then
            storage:AddItem(itemName, count);
            return true;
        end

    end

    return false;

end);

---@param societyName string
---@param weaponName table
---@return boolean
exports("AddSocietyWeapon", function(societyName, weaponName)

    local society = JG.SocietyManager:GetSociety(societyName);

    if (society) then

        local storage = society:GetStorage();

        if (storage) then
            storage:AddWeapon(weaponName, 255);
            return true;
        end

    end

    return false;

end);


---@param jobName string
---@param wipeJob boolean
exports("RemoveAllPlayerFromJob", function(jobName, wipeJob)

    local job = JG.SocietyManager:GetSociety(jobName);

    if (job) then

        JG.SocietyManager:RemovePlayersFromJob(jobName);

        if (wipeJob) then

            local storage = job:GetStorage();

            if (storage) then

                storage:ResetDirtyMoney();
                storage:ResetMoney();
                storage:ResetItems();
                storage:ResetVehicles();
                storage:ResetWeapons();

            end

        end

    end

end);

---@param gangName string
---@param wipeGang boolean
exports("RemoveAllPlayerFromGang", function(gangName, wipeGang)

    local gang = JG.SocietyManager:GetSociety(gangName);

    if (gang) then

        JG.SocietyManager:RemovePlayersFromGang(gangName);

        if (wipeGang) then

            local storage = gang:GetStorage();

            if (storage) then

                storage:ResetDirtyMoney();
                storage:ResetMoney();
                storage:ResetItems();
                storage:ResetVehicles();
                storage:ResetWeapons();

            end

        end

    end

end);

exports('AddSociety', function(name, label, canWashMoney, canUseOffshore, societyType, callback)

    local data = {
        name = name,
        label = label,
        grades = grades,
        canWashMoney = canWashMoney,
        canUseOffshore = canUseOffshore,
        societyType = societyType,
        grades = {
            ["0"] = {
                job_name = name,
                name = "recrue",
                label = "Recrue",
                salary = 0,
                grade = 0,
                skin_male = {},
                skin_female = {}
            },
            ["1"] = {
                job_name = name,
                name = "novice",
                label = "Novice",
                salary = 0,
                grade = 1,
                skin_male = {},
                skin_female = {}
            },
            ["2"] = {
                job_name = name,
                name = "experimente",
                label = "Experimente",
                salary = 0,
                grade = 2,
                skin_male = {},
                skin_female = {}
            },
            ["3"] = {
                job_name = name,
                name = "boss",
                label = "Patron",
                salary = 0,
                grade = 3,
                skin_male = {},
                skin_female = {}
            }
        }
    };

    return JG.SocietyManager:AddSociety(data, callback);

end);