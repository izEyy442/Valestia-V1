Shared.Events:OnNet(Enums.ESX.Player.Job.Client.setJob(), function(job)
    Client.Player:SetJob(job);
    Shared.Events:Trigger(Enums.Player.Events.updateZonesAndBlips);
end);

Shared.Events:OnNet(Enums.ESX.Player.Job.Client.setJob2(), function(job2)
    Client.Player:SetJob2(job2);
    Shared.Events:Trigger(Enums.Player.Events.updateZonesAndBlips);
end);