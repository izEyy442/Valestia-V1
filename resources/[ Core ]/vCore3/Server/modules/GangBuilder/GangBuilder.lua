--
--Created Date: 19:11 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [GangBuilder]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@type GangBuilder
GangBuilder = Class.new(function(class)

    ---@class GangBuilder: BaseObject
    local self = class;

    function self:Constructor()

        local gangJSON = LoadResourceFile(GetCurrentResourceName(), "Server/JSON/Gangs.json");
        local converted = gangJSON and json.decode(gangJSON);

        self.gangs = gangJSON and type(converted) == "table" and Shared.Table:SizeOf(converted) > 0 and converted or {};

        Shared:Initialized("GangBuilder");

    end

    ---@return table
    function self:GetGangs()
        return self.gangs;
    end

    ---@param gang table
    function self:SaveGang(gang)
        self.gangs[gang.name] = {
            boss_action = gang.boss_action,
            name = gang.name,
            chest_action = gang.chest_action,
            take_vehicle = gang.take_vehicle,
            parking = gang.parking,
            vehicle_spawn = gang.vehicle_spawn,
        };
        SaveResourceFile(GetCurrentResourceName(), "Server/JSON/Gangs.json", json.encode(self.gangs));
    end

    ---@param gangName string
    function self:DeleteGang(gangName)

        local players = ESX.GetPlayers();

        for i = 1, #players do
            local xPlayer = ESX.GetPlayerFromId(players[i]);

            if (xPlayer) then
                if (xPlayer.job2.name == gangName) then
                    xPlayer.setJob2("unemployed2", 0);
                end
            end
        end

        if (self.gangs[gangName]) then
            self.gangs[gangName] = nil;
            SaveResourceFile(GetCurrentResourceName(), "Server/JSON/Gangs.json", json.encode(self.gangs));
        end

    end

    ---@param gangName string
    ---@return table
    function self:GetGang(gangName)
        return self.gangs[gangName];
    end

    return self;

end);