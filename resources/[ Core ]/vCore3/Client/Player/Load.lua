--
--Created Date: 16:33 11/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Load]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Shared.Events:OnNet(Enums.Player.Events.ReceivePlayerData, function(playerData, ressource)

    if (playerData and type(playerData) == "table") then

        if ressource == "core" then
            Shared.Events:Trigger("vCore1:Valestia:player:receive_player_data", playerData);
        else
            Client:InitializePlayer(playerData);
            Shared.Events:Trigger(Enums.Player.Events.PlayerLoaded, playerData);
            Shared.Events:ToServer(Enums.Player.Events.PlayerLoaded);
            Shared.Events:Trigger("vCore1:Valestia:player:receive_player_data", playerData);
        end

    else

        Shared.Events:Protected(Enums.Player.Events.KickPlayer, "Les données du joueur n'ont pas pu être chargées.");

    end

end);