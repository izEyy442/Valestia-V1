--
--Created Date: 22:38 14/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Society]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@type Society
Society = Class.new(function(class)

    ---@class Society: BaseObject
    local self = class;

    function self:Constructor(societyData)

        local data = societyData;

        self.name = data.name;
        self.label = data.label;
        self.grades = data.grades;
        self.societyType = data.societyType;
        self.canWashMoney = data.canWashMoney;
        self.canUseOffshore = data.canUseOffshore;
        self.employees = {};

        self:Initialize();

    end

    ---@private
    function self:LoadStorage()

        MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = @name", {
            ["@name"] = self.name
        }, function(storageData)
            if (#storageData > 0) then

                local storage = storageData[1];

                storage.vehicles = json.decode(storageData[1].vehicles);
                storage.weapons = json.decode(storageData[1].weapons);
                storage.items = json.decode(storageData[1].items);

                self.storage = SocietyStorage(storage);

            else

                MySQL.Async.execute("INSERT INTO societies_storage (name, label, money, dirty_money) VALUES (@name, @label, @money, @dirty_money)", {

                    ['@name'] = self.name,
                    ['@label'] = self.label,
                    ["@money"] = Config["Society"]["DefaultMoney"],
                    ["@dirty_money"] = Config["Society"]["DefaultDirtyMoney"]

                });

                self.storage = SocietyStorage({
                    name = self.name,
                    label = self.label,
                    data = {},
                });

            end
        end);
    end

    function self:DeleteStorage()

        MySQL.Async.execute("DELETE FROM societies_storage WHERE name = @name", {
            ['@name'] = self.name,
        });

    end

    ---@param grade number
    ---@return string
    function self:GetGradeLabel(grade)

        for _, gradeData in pairs(self.grades) do

            if (gradeData.grade == grade) then
                return gradeData.label;
            end

        end

    end

    ---@return table
    function self:GetGrades()
        return self.grades;
    end

    ---@private
    function self:LoadEmployees()

        local query = "SELECT * FROM users WHERE job = @job";

        if (self:IsGang()) then

            query = "SELECT * FROM users WHERE job2 = @job";

        end

        MySQL.Async.fetchAll(query, {
            ["@job"] = self.name
        }, function(employeesData)

            if (#employeesData > 0) then

                for i = 1, #employeesData do

                    local jobGrade = self:IsJob() and employeesData[i].job_grade or employeesData[i].job2_grade

                    self.employees[employeesData[i].identifier] = {
                        firstname = employeesData[i].firstname,
                        lastname = employeesData[i].lastname,
                        isBoss = self:IsOfflinePlayerBoss(employeesData[i]),
                        identifier = employeesData[i].identifier,
                        grade = self:GetGradeLabel(jobGrade),
                        grade_level = jobGrade,
                    };

                end

            end

        end);

    end

    function self:Initialize()
        self:LoadStorage();
        self:LoadEmployees();
    end

    ---@return string
    function self:GetName()
        return self.name;
    end

    ---@return string
    function self:GetLabel()
        return self.label;
    end

    ---@return table
    function self:GetGrades()
        return self.grades;
    end

    ---@return boolean
    function self:IsJob()
        return self.societyType == 1;
    end

    ---@return boolean
    function self:IsGang()
        return self.societyType == 2;
    end

    ---@return boolean
    function self:CanWashMoney()
        return self.canWashMoney;
    end

    ---@return boolean
    function self:CanUseOffshore()
        return self.canUseOffshore;
    end

    ---@param canWashMoney boolean
    function self:SetCanWashMoney(canWashMoney)

        self.canWashMoney = canWashMoney;

        MySQL.Async.execute("UPDATE jobs SET canWashMoney = @canWashMoney WHERE name = @name", {
            ["@canWashMoney"] = canWashMoney,
            ["@name"] = self.name
        });

    end

    ---@return table
    function self:GetEmployees()
        return self.employees;
    end

    ---@param identifier string
    ---@return table
    function self:GetEmployee(identifier)
        return self.employees[identifier];
    end

    ---@param xPlayer xPlayer | number
    ---@param verbose boolean
    function self:AddEmployee(xPlayer, verbose)

        local employee = Server:ConvertToPlayer(xPlayer);
        local job = self:IsJob() and employee.getJob() or employee.getJob2();

        self.employees[employee.getIdentifier()] = {
            firstname = employee.getFirstName(),
            lastname = employee.getLastName(),
            isBoss = self:IsPlayerBoss(employee),
            id = employee.source,
            identifier = employee.getIdentifier(),
            grade = self:GetGradeLabel(job.grade),
            grade_level = job.grade,
        };

        if (verbose) then

            if (self:IsJob()) then

                Shared.Log:Success(Shared.Lang:Translate("society_log_job_employee_added", employee.source, employee.getIdentifier(), employee.getName(), self:GetName()));

            elseif (self:IsGang()) then

                Shared.Log:Success(Shared.Lang:Translate("society_log_gang_employee_added", employee.source, employee.getIdentifier(), employee.getName(), self:GetName()));

            end

        end

    end

    ---@param xPlayer xPlayer | number
    function self:RemoveEmployee(xPlayer)

        local employee = Server:ConvertToPlayer(xPlayer);
        self.employees[employee.getIdentifier()] = nil;

    end

    ---@param identifier string
    ---@param grade number
    function self:UpdateEmployee(identifier, grade)

        if (self.employees[identifier]) then

            local player = ESX.GetPlayerFromIdentifier(identifier);

            if (player) then

                if (self:IsJob()) then

                    if (grade) then
                        player.setJob(self.name, grade);
                    else
                        player.setJob("unemployed", 0);
                    end

                elseif (self:IsGang()) then

                    if (grade) then
                        player.setJob2(self.name, grade);
                    else
                        player.setJob2("unemployed2", 0);
                    end

                end

            else

                if (self:IsJob()) then

                    MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
                        ["@job"] = grade and self.name or "unemployed",
                        ["@job_grade"] = grade or 0,
                        ["@identifier"] = identifier
                    });

                elseif (self:IsGang()) then

                    MySQL.Async.execute("UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier", {
                        ["@job2"] = grade and self.name or "unemployed2",
                        ["@job2_grade"] = grade or 0,
                        ["@identifier"] = identifier
                    });

                end

            end

            if (grade) then

                self.employees[identifier].grade = self:GetGradeLabel(grade);
                self.employees[identifier].grade_level = grade;

            else

                self.employees[identifier] = nil;

            end

        end

    end

    ---@param xPlayer xPlayer | number
    function self:IsPlayerBoss(xPlayer)

        local employee = Server:ConvertToPlayer(xPlayer);

        if (employee and type(employee) == "table") then

            if (employee.job == nil or employee.job2 == nil) then 
                
                Shared.Log:Error(("Le job ou le gang est invalide pour ^1%s^7"):format(employee.identifier)); 
                return false; 

            end

            if (employee.job.name == self.name) then
                return employee.job.grade_name == "boss";
            elseif (employee.job2.name == self.name) then
                return employee.job2.grade_name == "boss";
            end

        end

        return false;

    end

    ---@param playerData table
    ---@return boolean
    function self:IsOfflinePlayerBoss(playerData)

        local grades = self:GetGrades();

        for _, gradeData in pairs(grades) do

            if (gradeData.name == "boss") then

                local jobType = self:IsJob() and "job_grade" or "job2_grade";

                if (gradeData.grade == playerData[jobType]) then

                    return true;

                end

            end

        end

        return false;

    end

    ---@param xPlayer xPlayer | number
    function self:DoesPlayerExist(xPlayer)

        local employee = Server:ConvertToPlayer(xPlayer);

        if (employee) then

            if (employee.job.name == self.name) then
                return true;
            elseif (employee.job2.name == self.name) then
                return true;
            end

        end

        return false;

    end

    ---Update specific data for all boss (Client side)
    ---@param eventName string
    function self:UpdateBossEvent(eventName, ...)

        local players = GetPlayers();
        local args = {...};

        for i = 1, #players do

            local xPlayer = Server:ConvertToPlayer(players[i]);

            if (xPlayer and type(xPlayer) == "table") then

                if (self:IsPlayerBoss(xPlayer)) then

                    Shared.Events:ToClient(xPlayer, eventName, #args > 0 and table.unpack(args));

                end

            end

        end

    end

    ---Update specific data for all employees (Client side)
    ---@param eventName string
    function self:UpdateEvent(eventName, ...)

        local players = GetPlayers();

        for i = 1, #players do

            local xPlayer = Server:ConvertToPlayer(players[i]);

            if (xPlayer) then

                if (self:DoesPlayerExist(xPlayer)) then

                    Shared.Events:ToClient(xPlayer, eventName, ...);

                end

            end

        end

    end

    ---@return SocietyStorage
    function self:GetStorage()
        return self.storage;
    end

    ---@param gradeLevel number
    ---@return number
    function self:GetSalary(gradeLevel)

        for _, gradeData in pairs(self.grades) do

            if (gradeData.grade == gradeLevel) then
                return gradeData.salary;
            end

        end

    end

    ---@param gradeLevel number
    ---@param salary number
    function self:SetSalary(gradeLevel, salary)

        for level, gradeData in pairs(self.grades) do

            if (gradeData.grade == gradeLevel) then

                self.grades[level].salary = salary;

                MySQL.Async.execute("UPDATE `job_grades` SET `salary` = @salary WHERE job_name = @job_name AND grade = @grade", {

                    ["@job_name"] = self:GetName(),

                    ["@grade"] = gradeLevel,

                    ["@salary"] = tonumber(salary)

                });

                break;
            end

        end

    end

    return self;

end);