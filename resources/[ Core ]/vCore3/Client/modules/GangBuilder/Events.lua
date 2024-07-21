--
--Created Date: 19:19 17/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Events]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Shared.Events:On(Enums.Player.Events.PlayerLoaded, function()
    Shared.Events:ToServer(Enums.GangBuilder.RequestGangData);
end);

Shared.Events:OnNet(Enums.GangBuilder.ReceiveGangData, function(gangData)
    Client.Gang:SetData(gangData);
end);