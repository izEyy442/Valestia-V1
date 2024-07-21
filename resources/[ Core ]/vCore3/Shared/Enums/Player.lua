--
--Created Date: 16:29 11/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Player]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Enums.Player = {
    Manager = {
        Request = "vCore3:Valestia:player:manager:request",
        Init = "vCore3:Valestia:player:manager:init",
        Add = "vCore3:Valestia:player:manager:add",
        Added = "vCore3:Valestia:player:manager:added",
        Remove = "vCore3:Valestia:player:manager:remove",
        Removed = "vCore3:Valestia:player:manager:removed",
        Set = "vCore3:Valestia:player:manager:set",
        SetAll = "vCore3:Valestia:player:manager:set_all"
    },
    Events = {
        updateZonesAndBlips = "vCore3:Valestia:player:update_zones&blips",
        LoadPlayerData = "vCore3:Valestia:player:load_player_data",
        ReceivePlayerData = "vCore3:Valestia:player:receive_player_data",
        PlayerLoaded = "vCore3:Valestia:player:player_loaded",
        KickPlayer = "vCore3:Valestia:player:kick_player",
        onDeath = "vCore3:Valestia:player:on_death",
        onRevive = "vCore3:Valestia:player:on_revive",
        LoadSkin = "vCore3:Valestia:player:load:skin",
        SetWaypoint = "vCore3:Valestia:player:set:waypoint"
    };
};