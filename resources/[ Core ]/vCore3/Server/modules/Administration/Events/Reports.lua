---
--- @author Kadir#6666
--- Create at [20/04/2023] 17:01:29
--- Current project [Valestia-V1]
--- File name [Reports]
---

Shared.Events:OnNet(Enums.Administration.Server.ReportTake, function(xPlayer, reportId)

    if (not xPlayer) then
        return
    end

    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    end

    local report_selected = JG.AdminManager:GetReportFromId(reportId)

    if (report_selected == nil) then
        return
    end

    local staff_taken = JG.AdminManager:TakeReport(reportId, xPlayer.source)

    if (staff_taken == true) then

        local player_selected = ESX.GetPlayerFromIdentifier(report_selected.owner[1])
        local player_ped = GetPlayerPed(xPlayer.source)

        local bucket = GetPlayerRoutingBucket(xPlayer.source);
        local target_bucket = GetPlayerRoutingBucket(player_selected.source);

        if (bucket ~= target_bucket) then
            JG.PlayersManager:ChangeValue(xPlayer.source, "last_bucket", bucket, true);
            SetPlayerRoutingBucket(xPlayer.source, target_bucket);
            xPlayer.showNotification("Vous avez été téléporté dans une autre instance.");
        end

        SetEntityCoords(player_ped, player_selected.getCoords());

        JG.Discord:SendMessage(
                "Admin:Report",
                ("***%s*** vient de prendre le report (___#%s___)."):format(xPlayer.getName(), reportId),
                {

                    {
                        name = "Identifiant du STAFF",
                        value = xPlayer.getIdentifier(),
                        inline = true
                    },
                    {
                        name = "ID session du STAFF",
                        value = xPlayer.source,
                        inline = true
                    },
                    {
                        name = "Pseudo du STAFF",
                        value = xPlayer.getName(),
                        inline = true
                    },

                    {
                        name = "Identifiant du Joueur",
                        value = ((player_selected ~= nil and player_selected.getIdentifier()) or report_selected.owner[1]),
                        inline = true
                    },
                    {
                        name = "ID session du Joueur",
                        value = ((player_selected ~= nil and player_selected.source) or "Non trouvable"),
                        inline = true
                    },
                    {
                        name = "Pseudo du Joueur",
                        value = ((player_selected ~= nil and player_selected.getName()) or "Non trouvable"),
                        inline = true
                    },

                    {
                        name = "Raison du Report",
                        value = report_selected.reason,
                        inline = true
                    }

                }
        );

    end

end)

Shared.Events:OnNet(Enums.Administration.Server.ReportRemove, function(xPlayer, reportId)

    if (not xPlayer) then
        return
    end

    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    end

    local report_selected = JG.AdminManager:GetReportFromId(reportId)

    if (report_selected == nil or JG.AdminManager:StaffGetValue(xPlayer.source, "onReport") ~= reportId) then
        return
    end

    local staff_removed = JG.AdminManager:RemoveReport(reportId)

    if (staff_removed == true) then
        local player_selected = ESX.GetPlayerFromIdentifier(report_selected.owner[1])

        local bucket = GetPlayerRoutingBucket(xPlayer.source);
        local old_bucket = JG.PlayersManager:Get(xPlayer.source, "last_bucket");

        if (bucket ~= old_bucket) then
            SetPlayerRoutingBucket(xPlayer.source, old_bucket);
            xPlayer.showNotification("Vous avez été téléporté dans votre instance.");
        end

        JG.Discord:SendMessage(
                "Admin:Report",
                ("***%s*** vient de clôturer le report (___#%s___)."):format(xPlayer.getName(), reportId),
                {

                    {
                        name = "Identifiant du STAFF",
                        value = xPlayer.getIdentifier(),
                        inline = true
                    },
                    {
                        name = "ID session du STAFF",
                        value = xPlayer.source,
                        inline = true
                    },
                    {
                        name = "Pseudo du STAFF",
                        value = xPlayer.getName(),
                        inline = true
                    },

                    {
                        name = "Identifiant du Joueur",
                        value = ((player_selected ~= nil and player_selected.getIdentifier()) or report_selected.owner[1]),
                        inline = true
                    },
                    {
                        name = "ID session du Joueur",
                        value = ((player_selected ~= nil and player_selected.source) or "Non trouvable"),
                        inline = true
                    },
                    {
                        name = "Pseudo du Joueur",
                        value = ((player_selected ~= nil and player_selected.getName()) or "Non trouvable"),
                        inline = true
                    },

                    {
                        name = "Raison du Report",
                        value = report_selected.reason,
                        inline = true
                    }

                }
        );
        JG.AdminManager:AddReportCount(xPlayer);
    end

end)

Shared.Events:OnNet(Enums.Administration.Server.RequestReportCount, function(xPlayer)
    if (not xPlayer) then return; end
    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return;
    end
    MySQL.query("SELECT * FROM `jg_reports`", {}, function(result)
        if (next(result)) then
            table.sort(result, function(a, b) return a.count > b.count; end);
        end
        TriggerClientEvent(Enums.Administration.Client.ReceiveReportCount, xPlayer.source, result);
    end);
end)