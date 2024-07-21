--[[
----
----Created Date: 11:45 Sunday December 11th 2022
----Author: vCore3
----Made with ❤
----
----File: [Load]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

Shared.Events:On("esx:playerLoaded", function(playerSrc)
    local xPlayer = Server:ConvertToPlayer(playerSrc);

    if (xPlayer) then

        local ipHost = GetPlayerEndpoint(xPlayer.source);

        Shared.Log:Success(
            Shared.Lang:Translate(
                "player_loaded",
                xPlayer.source,
                xPlayer.identifier,
                xPlayer.name,
                ipHost,
                xPlayer.getGroup() or "user"
            )
        );

        JG.Discord:SendMessage(
                "Admin:PlayerConnecting",
                ("***%s*** vient de se connecter sur le serveur."):format(xPlayer.getName()),
                {

                    {
                        name = "Identifiant du JOUEUR",
                        value = xPlayer.getIdentifier(),
                        inline = true
                    },

                    {
                        name = "ID unique du JOUEUR",
                        value = xPlayer.getCharacter(),
                        inline = true
                    },

                    {
                        name = "ID session du JOUEUR",
                        value = xPlayer.source,
                        inline = true
                    },

                    {
                        name = "Pseudo du JOUEUR",
                        value = xPlayer.getName(),
                        inline = true
                    }

                }
        );

        Shared.Events:ToClient(xPlayer, Enums.Player.Events.ReceivePlayerData, xPlayer);

    end

end);

Shared.Events:OnNet(Enums.Player.Events.PlayerLoaded, function(xPlayer)
    JG.PlayersManager:Add(xPlayer.source);
end);

Shared.Events:OnProtectedNet(Enums.Player.Events.KickPlayer, function(player, reason)

    local xPlayer = Server:ConvertToPlayer(player);

    if (xPlayer) then

        DropPlayer(xPlayer.source, reason);

    else

        DropPlayer(player, reason);
        
    end

end);

Server:OnPlayerDropped(function(xPlayer, reason)

    Shared.Log:Info(Shared.Lang:Translate("player_dropped", xPlayer.source, xPlayer.identifier, xPlayer.name, reason));
    JG.PlayersManager:Remove(xPlayer);

end);

AddEventHandler("vCore3:esx:loaded", function()

    local players = GetPlayers();
    local resource = GetInvokingResource()

    for i = 1, #players do
        
        local xPlayer = ESX.GetPlayerFromId(tonumber(players[i]));

        if (type(xPlayer) == "table") then
            
            xPlayer.triggerEvent(Enums.Player.Events.ReceivePlayerData, xPlayer, resource);

        end

    end

end);