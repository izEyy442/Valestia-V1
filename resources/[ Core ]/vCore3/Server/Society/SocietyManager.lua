--
--Created Date: 19:12 14/12/2022
--Author: vCore3
--Made with ❤
--
--File: [SocietyManager]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@type SocietyManager
SocietyManager = Class.new(function(class)

    ---@class SocietyManager: BaseObject
    local self = class;

    function self:Constructor()

        self.societies = {};

        self:Initialize();

        Shared:Initialized("SocietyManager");

    end

    function self:Initialize()

        Shared.Events:On(Enums.ESX.Societies.jobsLoaded, function(esxJobs)

            self:LoadSocieties(esxJobs);

        end);

    end

    ---@param esxJobs table
    function self:LoadSocieties(esxJobs)
        local societiesLoaded = 0;
        local gangsLoaded = 0;

        for jobName, job in pairs(esxJobs) do

            if (job.societyType == 1) then
                societiesLoaded = societiesLoaded + 1;
            elseif (job.societyType == 2) then
                gangsLoaded = gangsLoaded + 1;
            end

            self.societies[jobName] = Society(job);

        end

        if (societiesLoaded > 0) then
            Shared.Log:Success(string.format("^4%s ^0societies loaded ✔️", societiesLoaded));
        end

        if (gangsLoaded > 0) then
            Shared.Log:Success(string.format("^4%s ^0gangs loaded ✔️", gangsLoaded));
        end

    end

    ---@param societyData table
    ---@param callback fun(esxSociety: table)
    function self:AddSociety(societyData, callback)

        if (not self.societies[societyData.name]) then

            MySQL.Async.execute("INSERT INTO `jobs` (`name`, `label`, `societyType`, `canWashMoney`, `canUseOffshore`) VALUES (@name, @label, @societyType, @canWashMoney, @canUseOffshore)", {

                ["@name"] = societyData.name,
                ["@label"] = societyData.label,
                ["@societyType"] = societyData.societyType ~= nil and societyData.societyType or 1,
                ["@canWashMoney"] = societyData.canWashMoney ~= nil and societyData.canWashMoney or 0,
                ["@canUseOffshore"] = societyData.canUseOffshore ~= nil and societyData.canUseOffshore or 0
            });

            for _, grade in pairs(societyData.grades) do

                MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {

                    ['@job_name'] = grade.job_name,
                    ['@grade'] = grade.grade,
                    ['@name'] = grade.name,
                    ['@label'] = grade.label,
                    ['@salary'] = grade.salary,
                    ['@skin_male'] = json.encode(grade.skin_male) or json.encode({}),
                    ['@skin_female'] = json.encode(grade.skin_female) or json.encode({})

                });

            end

            self.societies[societyData.name] = Society(societyData);

            self:OnJobCreated(function(esxSociety)

                if (callback) then
                    callback(esxSociety);
                end

                Shared.Log:Success(Shared.Lang:Translate("society_add_success", societyData.name));

            end);

            Shared.Events:Trigger(Enums.ESX.Societies.societyAdded, self.societies[societyData.name]);

        else

            Shared.Log:Error(Shared.Lang:Translate("society_add_already_exist", societyData.name));

        end

    end

    ---@param societyName string
    ---@return boolean
    function self:RemoveSociety(societyName)

        local society = self:GetSociety(societyName);

        if (society) then

            if (society:IsJob()) then

                self:RemovePlayersFromJob(societyName);

            elseif (society:IsGang()) then

                self:RemovePlayersFromGang(societyName);

            end

            MySQL.Async.execute("DELETE FROM `jobs` WHERE `name` = @name", {
                ["@name"] = societyName
            });

            MySQL.Async.execute("DELETE FROM `job_grades` WHERE `job_name` = @job_name", {
                ["@job_name"] = societyName
            });

            self.societies[societyName] = nil;

            Shared.Events:Trigger(Enums.ESX.Societies.societyRemoved, societyName);

            Shared.Log:Success(Shared.Lang:Translate("society_remove_success", societyName));

            return true;

        else

            Shared.Log:Error(Shared.Lang:Translate("society_remove_not_exist", societyName));

            return false;

        end

    end

    ---@param callback fun(esxSociety: table)
    function self:OnJobCreated(callback)

        local event;

        event = Shared.Events:On(Enums.ESX.Societies.jobLoaded, function(esxSociety)

            if (callback) then
                callback(esxSociety);
            end
            
            RemoveEventHandler(event);
        end);

    end

    ---@param jobName string
    function self:RemovePlayersFromJob(jobName)
        local players = ESX.GetPlayers();

        for i = 1, #players do

            local player = ESX.GetPlayerFromId(players[i]);

            if (player) then

                if (player.job.name == jobName) then
                    player.setJob("unemployed", 0);
                end

            end

        end

        MySQL.Async.execute("UPDATE `users` SET `job` = 'unemployed', `job_grade` = 0 WHERE `job` = @job", {
            ["@job"] = jobName
        });

    end

    ---@param gangName string
    function self:RemovePlayersFromGang(gangName)
        local players = ESX.GetPlayers();

        for i = 1, #players do

            local player = ESX.GetPlayerFromId(players[i]);

            if (player) then
                if (player.job2.name == gangName) then
                    player.setJob2("unemployed2", 0);
                end
            end

        end

        MySQL.Async.execute("UPDATE `users` SET `job2` = 'unemployed2', `job2_grade` = 0 WHERE `job2` = @job2", {
            ["@job2"] = gangName
        });

    end

    ---@return Society[]
    function self:GetSocieties()
        return self.societies;
    end

    ---@param societyName string
    ---@return Society
    function self:GetSociety(societyName)
        return self.societies[societyName] ~= nil and self.societies[societyName] or nil;
    end

    ---@param xPlayer xPlayer
    ---@param societyName string
    ---@return boolean
    function self:IsPlayerBoss(xPlayer, societyName)
        local player = Server:ConvertToPlayer(xPlayer);

        if (player) then

            local job = self:GetSociety(societyName);

            if (job:IsJob()) then
                return player.job.grade.name == "boss";
            elseif (job:IsGang()) then
                return player.job2.grade.name == "boss";
            end

        end

        return false;

    end

    return self;

end);