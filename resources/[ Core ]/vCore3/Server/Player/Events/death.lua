--[[
----
----Created Date: 11:45 Sunday December 11th 2022
----Author: vCore3
----Made with ❤
----
----File: [death]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

Shared.Events:OnProtectedNet(Enums.Player.Events.onDeath, function(player, deathData)
    local data = deathData;
    local isInPVP = ESX.GetPlayerInPVPMode(player.identifier);

    if (not Config["DeathLogs"]["onDeath"]) then
        return;
    end

    if (data.killedByPlayer) then

        local killer = Server:ConvertToPlayer(data.killerServerId);

        if (not ESX.GetPlayerInPVPMode(killer.identifier)) then

            Shared.Log:Info(
                Shared.Lang:Translate(
                    "player_killed_by_player",
                    player.source,
                    player.identifier,
                    player.name,
                    killer.source,
                    killer.identifier,
                    killer.name
                )
            );

            player.showNotification(("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~AntiCheat:~s~\n Vous avez été tué par le joueur ~c~(~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~c~)"):format(killer.source));
            
        else

            player.showNotification(("Vous avez été tué par ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~"):format(killer.name));
            killer.triggerEvent("vCore3:Valestia:pvp:onKill");
            exports["Framework"]:AddKill(killer.source);
            exports["Framework"]:AddDeath(player.source);

        end

    else

        if (not ESX.GetPlayerInPVPMode(player.identifier)) then

            Shared.Log:Info(
                Shared.Lang:Translate(
                    "player_die",
                    player.source,
                    player.identifier,
                    player.name
                )
            );

        else

            player.showNotification("Vous avez succombé.");

        end

    end

    if (isInPVP) then

        SetTimeout(2000, function()
            player.triggerEvent('vCore1:player:heal', "resuscitation");
        end);

    else
        player.setDead(true);
        TriggerEvent("vCore3:Valestia:playerDied", player.source);
    end

end);

Shared.Events:OnProtectedNet(Enums.Player.Events.onRevive, function(player)

    local isInPVP = ESX.GetPlayerInPVPMode(player.identifier);

    if (not isInPVP) then

        TriggerEvent("vCore3:Valestia:playerRevived", player.source);
        player.setDead(false);

        if (not Config["DeathLogs"]["onRevive"]) then
            return;
        end

        Shared.Log:Info(Shared.Lang:Translate("player_revived", player.source, player.identifier, player.name));

    end

end);