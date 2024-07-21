--
--Created Date: 21:09 15/12/2022
--Author: vCore3
--Made with ❤
--
--File: [SocietyListener]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@type SocietyListener
SocietyListener = Class.new(function(class)

    ---@class SocietyListener: BaseObject
    local self = class;

    function self:Constructor()

        self.type = nil;
        self.data = {};
        ---@type number[]
        self.accounts = {};
        ---@type table[]
        self.items = nil;
        self.storage = {};
        self.weapons = {};
        self.vehicles = {};
        ---@type table[]
        self.players = {};
        self.grades = {};

    end

    function self:Reset()

        self.type = nil;
        self.data = {};
        self.accounts = {};
        self.items = nil;
        self.storage = {};
        self.weapons = {};
        self.vehicles = {};
        self.players = {};
        self.grades = {};
    end

    ---@return string
    function self:GetSocietyName()
        return self.data and self.data.name;
    end

    ---@return string
    function self:GetSocietyLabel()
        return self.data and self.data.label;
    end

    ---@return boolean
    function self:CanWashMoney()
        return self.data and self.data.canWashMoney;
    end

    ---@return boolean
    function self:CanUseOffshore()
        return self.data and self.data.canUseOffshore;
    end

    ---@param jobName string
    ---@param callback fun(jobData: table | boolean)
    function self:SelectSociety(jobName, callback);

        if (not callback) then return; end

        self:Reset();

        local job = Client.Player:GetJob();
        local gang = Client.Player:GetJob2();

        if (job.name == jobName and job.name ~= "unemployed") then
            self.data = job;
            self.type = 1;
            callback(self.data);
        elseif (gang.name == jobName and gang.name ~= "unemployed2") then
            self.data = gang;
            self.type = 2;
            callback(self.data);
        else
            callback(false);
        end

    end

    ---@return boolean
    function self:IsJob()
        return self.type == 1;
    end

    ---@return boolean
    function self:IsGang()
        return self.type == 2;
    end

    ---@return string
    function self:GetTypeLabel()

        if (self.data and type(self.data) == "table" and self.data.label) then

            if (self:IsJob()) then

                return Shared.Lang:Translate("society_job_label", Shared:ServerColor(), self.data.label);

            elseif (self:IsGang()) then

                return Shared.Lang:Translate("society_gang_label", Shared:ServerColor(), self.data.label);

            end

        end

        return "ERROR";

    end

    ---RequestMoney from server
    function self:RequestMoney()
        self.accounts["money"] = 0;
        Shared.Events:ToServer(Enums.Society.RequestMoney, self:GetSocietyName());
    end

    ---@return number
    function self:GetMoney()
        return self.accounts["money"];
    end

    ---@param societyMoney number
    function self:SetMoney(societyMoney)
        self.accounts["money"] = societyMoney;
    end

    ---RequestMoney from server
    function self:RequestDirtyMoney()
        self.accounts["dirty_money"] = 0;
        Shared.Events:ToServer(Enums.Society.RequestDirtyMoney, self:GetSocietyName());
    end

    ---@return number
    function self:GetDirtyMoney()
        return self.accounts["dirty_money"];
    end

    ---@param societyMoney number
    function self:SetDirtyMoney(societyMoney)
        self.accounts["dirty_money"] = societyMoney;
    end

    ---Request item from server
    function self:RequestItems()
        self.items = nil;
        Shared.Events:ToServer(Enums.Society.RequestItems, self:GetSocietyName());
    end

    ---@return table
    function self:GetItems()
        return self.items;
    end

    ---@param items table
    function self:SetItems(items)
        self.items = items;
    end

    ---@return number
    function self:GetChestWeight()
        return self.storage and self.storage.weight;
    end

    ---@param weight number
    function self:SetChestWeight(weight)
        self.storage.weight = weight;
    end

    ---@return number
    function self:GetChestMaxWeight()
        return self.storage and self.storage.maxWeight;
    end

    ---@param maxWeight number
    function self:SetChestMaxWeight(maxWeight)
        self.storage.maxWeight = maxWeight;
    end

    ---Request weapons from server
    function self:RequestWeapons()
        self.weapons = nil;
        Shared.Events:ToServer(Enums.Society.RequestWeapons, self:GetSocietyName());
    end

    ---@return table
    function self:GetWeapons()
        return self.weapons and self.weapons;
    end

    ---@param weapons table
    function self:SetWeapons(weapons)
        self.weapons = weapons;
    end

    ---Request employees from server
    function self:RequestEmployees()
        self.players = nil;
        Shared.Events:ToServer(Enums.Society.RequestEmployees, self:GetSocietyName());
    end

    ---@return table
    function self:GetEmployees()
        return self.players;
    end

    ---@param players table
    function self:SetEmployees(players)
        self.players = players;
    end

    ---Request grades from server
    function self:RequestGrades()
        self.grades = nil;
        Shared.Events:ToServer(Enums.Society.RequestGrades, self:GetSocietyName());
    end

    ---@return table
    function self:GetGrades()
        return self.grades;
    end

    ---@param grades table
    function self:SetGrades(grades)
        self.grades = grades;
        table.sort(self.grades, function(a, b)
            return a.grade > b.grade;
        end);
    end

    function self:RequestVehicles()
        self.vehicles = nil;
        Shared.Events:ToServer(Enums.Society.RequestVehicles, self:GetSocietyName());
    end

    function self:GetVehicles()
        return self.vehicles;
    end

    ---@param vehicles table
    function self:SetVehicles(vehicles)
        self.vehicles = vehicles;
    end

    ---@param plate string
    ---@param vehicle table
    function self:SetVehicle(plate, vehicle)
        self.vehicles[plate] = vehicle;
    end

    ---@param plate string
    function self:ParkVehicle(plate)
        Shared.Events:ToServer(Enums.Society.ParkVehicle, self:GetSocietyName(), plate);
    end

    ---@param plate string
    ---@return boolean
    function self:IsVehicleOwner(plate)
        return self.vehicles and self.vehicles[plate] and self.vehicles[plate].owner == Client.Player:GetIdentifier();
    end

    ---@param plate string
    ---@return boolean
    function self:IsVehicleStored(plate)
        return self.vehicles and self.vehicles[plate] and self.vehicles[plate].stored == 1;
    end

    ---@return boolean
    function self:IsPlayerBoss()
        return self.data and self.data.grade_name == "boss" or false;
    end

    ---@param zoneName string
    ---@param job string
    ---@param coords vector3
    ---@param interactMessage string
    ---@param externalRadius number
    ---@param internalRadius number
    ---@param hasMarker boolean
    ---@param callback function
    function self:CreateZoneForJob(zoneName, job, jobGrade, coords, interactMessage, externalRadius, internalRadius, hasMarker, callback)

        local zone = Game.Zone(zoneName, {
            job = job,
            jobGrade = jobGrade
        });

        zone:Start(function()

            zone:SetTimer(1000);
            zone:SetCoords(coords);
            zone:IsPlayerInRadius(externalRadius, function()

                zone:SetTimer(0);
                if (hasMarker) then
                    zone:Marker();
                end

                zone:IsPlayerInRadius(internalRadius, function()
                    zone:Text(interactMessage);
                    zone:KeyPressed("E", callback);
                end);

            end);

        end);

    end

    ---Close all society menus
    function self:CloseAll()

        local SocietyMenus = Shared.Storage:Get("SocietyMenus");
    
        ---@type UIMenu
        local boss = SocietyMenus:Get("action_main");

        ---@type UIMenu
        local action_vehicles = SocietyMenus:Get("action_vehicles");

        ---@type UIMenu
        local chest_main = SocietyMenus:Get("chest_main");

        ---@type UIMenu
        local pound = SocietyMenus:Get("action_pound");

        if (boss:IsShowing()) then

            boss:Close();

        end

        if (action_vehicles:IsShowing()) then

            action_vehicles:Close();

        end

        if (chest_main:IsShowing()) then

            chest_main:Close();

        end

        if (pound:IsShowing()) then

            pound:Close();

        end

    end

    return self;

end);

