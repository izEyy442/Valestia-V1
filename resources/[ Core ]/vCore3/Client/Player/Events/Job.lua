--[[
----
----Created Date: 11:56 Sunday December 11th 2022
----Author: vCore3
----Made with ❤
----
----File: [Job]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

Shared.Events:OnNet(Enums.ESX.Player.Job.Client.setJob(), function(job)
    Client.Player:SetJob(job);
    Shared.Events:Trigger(Enums.Player.Events.updateZonesAndBlips);
end);

Shared.Events:OnNet(Enums.ESX.Player.Job.Client.setJob2(), function(job2)
    Client.Player:SetJob2(job2);
    Shared.Events:Trigger(Enums.Player.Events.updateZonesAndBlips);
end);