---
--- @author Kadir#6666
--- Create at [20/04/2023] 20:02:05
--- Current project [Valestia-V1]
--- File name [PlayersManager]
---

---@type PlayersManager
PlayersManager = Class.new(function(class)

    ---@class PlayersManager: BaseObject
    local self = class;

    function self:Constructor()

        ---@type number[]
        self.list = {}

        self:Initialize();

    end

    function self:Initialize()

        local players_list = GetPlayers()

        for i = 1, #players_list do

            self:Add(players_list[i])

        end

        Shared.Events:OnNet(Enums.Player.Manager.Request, function(xPlayer)

            if (xPlayer == nil) then
                return
            end

            xPlayer.triggerEvent(Enums.Player.Manager.Init, self.list);

        end)

    end

    function self:GetAll()

        return GetPlayers()

    end

    function self:GetFromId(playerId)

        return self.list[playerId]

    end

    function self:Get(playerId, key)

        if (self:GetFromId(playerId) == nil) then
            return
        end

        return self.list[playerId] ~= nil and self.list[playerId][key]

    end

    function self:ChangeValue(playerId, key, value, onlyServer)

        if (self:GetFromId(playerId) == nil) then
            return
        end

        local selectedPlayer = ESX.GetPlayerFromId(playerId)
        if (selectedPlayer == nil) then
            return
        end

        self.list[playerId][key] = value;

        if (onlyServer ~= true) then
            TriggerClientEvent(Enums.Player.Manager.Set, -1, selectedPlayer.source, key, value)
        end

    end

    function self:Add(playerId)

        if (self:GetFromId(playerId) ~= nil) then
            return
        end

        local selectedPlayer = ESX.GetPlayerFromId(playerId)
        if (selectedPlayer == nil) then
            return
        end

        local formatIdentity = (selectedPlayer.getFirstName() .. " " ..selectedPlayer.getLastName())
        local playerGroup = JG.AdminManager:GetPlayerGroup(selectedPlayer)

        self.list[selectedPlayer.source] = {
            license = selectedPlayer.getIdentifier(),
            name = selectedPlayer.getName(),
            identity = formatIdentity,
            group = playerGroup or "user",
            job = selectedPlayer.job or "Aucun",
            job2 = selectedPlayer.job2 or "Aucun",
        }

        TriggerClientEvent(Enums.Player.Manager.Add, -1, selectedPlayer.source, self.list[selectedPlayer.source])
        TriggerClientEvent("chat:addSuggestions", selectedPlayer.source, Shared:GetCommands())

        if (playerGroup ~= nil) then

            JG.AdminManager:AddStaff(selectedPlayer.source)

        end

    end

    function self:Remove(player)

        if (player == nil) then
            return
        end

        local playerId = tonumber(player.source)
        if (playerId == nil or self:GetFromId(playerId) == nil) then
            return
        end

        local player_have_current_report, report_index = JG.AdminManager:PlayerHaveCurrentlyReport(player.getIdentifier())
        if (player_have_current_report == true and report_index ~= nil) then

            JG.AdminManager:RemoveReport(report_index)

        end

        self.list[playerId] = nil;

        TriggerClientEvent(Enums.Player.Manager.Remove, -1, playerId)
        JG.AdminManager:RemoveStaff(playerId)

    end

    return self;

end)