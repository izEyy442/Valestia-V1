--
--Created Date: 19:41 11/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Death]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@type PlayerDeath
PlayerDeath = Class.new(function(class)

    ---@class PlayerDeath: BaseObject
    local self = class;

    function self:Constructor()
        self:RegisterGameEvent();
    end

    function self:RegisterGameEvent()
        Client:SubscribeToGameEvent("CEventNetworkEntityDamage", function(data)

            local victim, victimDied = data[1], data[4];

            if (not IsPedAPlayer(victim)) then return; end

            local player = Client.Player:GetId();
            local playerPed = Client.Player:GetPed();
            local victimId = NetworkGetPlayerIndexFromPed(victim);
            local isDead = IsPedDeadOrDying(victim, true);
            local isInjured = IsPedFatallyInjured(victim);

            if victimDied and victimId == player and (isDead or isInjured)  then

                local killerEntity, deathCause = GetPedSourceOfDeath(playerPed), GetPedCauseOfDeath(playerPed);
                local killerClientId = NetworkGetPlayerIndexFromPed(killerEntity);
                local killerIsActive = NetworkIsPlayerActive(killerClientId);
                local killerServeId = GetPlayerServerId(killerClientId);

                if (killerEntity ~= playerPed and killerClientId and killerIsActive) then
                    self:HasBeenKilledByPlayer(killerServeId, killerClientId, deathCause);
                else
                    self:HasBeenKilled(deathCause);
                end
            end
        end)
    end

    ---@param killerServeId number
    ---@param killerClientId number
    ---@param deathCause any
    function self:HasBeenKilledByPlayer(killerServerId, killerClientId, deathCause)
        local playerPed = Client.Player:GetPed();
        local victimCoords = GetEntityCoords(playerPed);
        local killerPed = GetPlayerPed(killerClientId);
        local killerCoords = GetEntityCoords(killerPed);
        local distance = #(victimCoords - killerCoords);

        local data = {
            victimCoords = {x = Shared.Math:Round(victimCoords.x, 1), y = Shared.Math:Round(victimCoords.y, 1), z = Shared.Math:Round(victimCoords.z, 1)},
            killerCoords = {x = Shared.Math:Round(killerCoords.x, 1), y = Shared.Math:Round(killerCoords.y, 1), z = Shared.Math:Round(killerCoords.z, 1)},

            killedByPlayer = true,
            deathCause = deathCause,
            distance = Shared.Math:Round(distance, 1),

            killerServerId = killerServerId,
            killerClientId = killerClientId
        }

        Shared.Events:Trigger(Enums.Player.Events.onDeath, data);
        Shared.Events:Protected(Enums.Player.Events.onDeath, data);
        self:Process();

    end

    ---@param deathCause any
    function self:HasBeenKilled(deathCause)
        local playerPed = Client.Player:GetPed();
        local victimCoords = GetEntityCoords(playerPed);

        local data = {
            victimCoords = {x = Shared.Math:Round(victimCoords.x, 1), y = Shared.Math:Round(victimCoords.y, 1), z = Shared.Math:Round(victimCoords.z, 1)},

            killedByPlayer = false,
            deathCause = deathCause
        }

        Shared.Events:Trigger(Enums.Player.Events.onDeath, data);
        Shared.Events:Protected(Enums.Player.Events.onDeath, data);
        self:Process();

    end

    ---Logic to handle the death of the player
    function self:Process()
        local playerPed = Client.Player:GetPed();
        Client.Player:SetDead(true);

        CreateThread(function()
            while IsPedFatallyInjured(playerPed) do
                Wait(300);
            end
            Shared.Events:Protected(Enums.Player.Events.onRevive);
            Shared.Events:Trigger(Enums.Player.Events.onRevive);
            Client.Player:SetDead(false);
        end);
    end

    return self;

end);