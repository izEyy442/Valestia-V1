---
--- @author Kadir#6666
--- Create at [20/04/2023] 17:00:58
--- Current project [Valestia-V1]
--- File name [Reports]
---

Shared.Events:OnNet(Enums.Administration.Client.ReportSetValue, function(reportId, key, value)

    if (Client.Admin == nil or type(reportId) ~= "number" or key == nil) then

        return

    end

    Client.Admin:SetReportValue(reportId, key, value)

end);

Shared.Events:OnNet(Enums.Administration.Client.ReportAdd, function(reportData)

    if (Client.Admin == nil or type(reportData) ~= "table") then

        return

    end

    Client.Admin:AddReport(reportData)

end);

Shared.Events:OnNet(Enums.Administration.Client.ReportRemove, function(reportIndex)

    if (Client.Admin == nil or type(reportIndex) ~= "number") then

        return

    end

    Client.Admin:RemoveReport(reportIndex)

end);

Shared.Events:OnNet(Enums.Administration.Client.ReceiveReportCount, function(data)
    if (Client.Admin == nil) then
        return
    end
    local storage = Shared.Storage:Get("Administration");
    if (storage) then
        storage:Set("report_stats", data);
    else
        storage:Set("report_stats", {});
        Game.Notification:ShowSimple("Impossible de charger les statistiques des reports.");
    end
end);