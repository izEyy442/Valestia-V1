---
--- @author Kadir#6666
--- Create at [20/04/2023] 21:48:49
--- Current project [Valestia-V1]
--- File name [PlayersManager]
---

---@type CPlayersManager
CPlayersManager = Class.new(function(class)

    ---@class CPlayersManager: BaseObject
    local self = class;

    function self:Constructor()

        ---@type number[]
        self.list = {}

        self:Initialize();

    end

    function self:Initialize()

        Shared.Events:OnNet(Enums.Player.Manager.Init, function(player_list)

            self.list = player_list;

        end)

        Shared.Events:OnNet(Enums.Player.Manager.Set, function(playerId, key, value)

            return self:ChangeValue(playerId, key, value)

        end)

        Shared.Events:OnNet(Enums.Player.Manager.SetAll, function(players_data)

            for  i = 1, #players_data do

                local player_data = players_data[i]

                if (player_data ~= nil and type(player_data.id) == "number" and type(player_data.coords) == "vector3") then

                    self:ChangeValue(player_data.id, "coords", player_data.coords)

                end

            end

        end)

        Shared.Events:OnNet(Enums.Player.Manager.Add, function(playerId, playerData)

            return self:Add(playerId, playerData)

        end)

        Shared.Events:OnNet(Enums.Player.Manager.Remove, function(playerId)

            return self:Remove(playerId)

        end)

        Shared.Events:ToServer(Enums.Player.Manager.Request)

    end

    function self:GetAll()

        return self.list

    end

    function self:GetFromId(playerId)

        return self.list[playerId]

    end

    function self:ChangeValue(playerId, key, value)

        if (self:GetFromId(playerId) == nil) then
            return
        end

        self.list[playerId][key] = value;

    end

    function self:Add(playerId, playerData)

        if (playerId == nil or type(playerId) ~= "number" or playerData == nil or type(playerData) ~= "table") then
            return
        end

        if (self:GetFromId(playerId) ~= nil) then
            return
        end

        self.list[playerId] = playerData;

    end

    function self:OnConnected(callback)

        if (callback ~= nil and type(callback) == "function") then

            Shared.Events:On(Enums.Player.Manager.Added, callback);

        end

    end

    function self:Remove(playerId)

        if (self:GetFromId(playerId) == nil) then
            return
        end

        self.list[playerId] = nil;
        Shared.Events:Trigger(Enums.Player.Manager.Removed, playerId)

    end

    function self:OnDisconnected(callback)

        if (callback ~= nil and type(callback) == "function") then

            Shared.Events:On(Enums.Player.Manager.Removed, callback);

        end

    end

    return self;

end)