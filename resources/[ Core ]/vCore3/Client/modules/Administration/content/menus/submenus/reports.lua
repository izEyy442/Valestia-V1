---
--- @author Kadir#6666
--- Create at [20/04/2023] 17:04:37
--- Current project [Valestia-V1]
--- File name [reports]
---

local AdminStorage = Shared.Storage:Get("Administration");

---@type UIMenu
local reports_menu = AdminStorage:Get("admin_reports");
local report_menu_selected = AdminStorage:Get("admin_report_selected");
local hovoredReport

---@type UIMenu
local player_selected_menu = AdminStorage:Get("admin_player_selected");

reports_menu:IsVisible(function(Items)

    hovoredReport = nil;

    local reports = Client.Admin:GetReports()
    if (Shared.Table:SizeOf(reports) == 0) then

        Items:Button("Aucun report.", nil, {}, true, {})

    else

        for _, currentReport in pairs(reports) do

            if (type(currentReport) == "table") then

                local player_server_id = currentReport.owner[2]
                local player_data = Client.PlayersManager:GetFromId(player_server_id)

                Items:Button(("Report #%s"):format(currentReport.id), ("Status : %s"):format(currentReport.taken == nil and "~y~EN ATTENTE~s~" or "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~EN COURS~s~"), {
                }, true, {

                    onActive = function()

                        hovoredReport = { currentReport, player_data }

                    end,

                    onSelected = function()

                        player_selected_menu:SetHasSubMenu(reports_menu)
                        AdminStorage:Get("hoveredPlayer")({ player_server_id, player_data })

                    end

                }, report_menu_selected)

            end

        end

    end

end, function(Panels)

    if (hovoredReport ~= nil) then

        local staff_data = Client.PlayersManager:GetFromId(hovoredReport[1].taken)

        Panels:info("Informations du Report", {
            ("Pseudo du Joueur : ~h~%s~h~"):format(((hovoredReport[2] ~= nil and hovoredReport[2].name) or "Unknow")),
            ("ID du Joueur : ~h~N°%s~h~"):format(((hovoredReport[1] ~= nil and hovoredReport[1].owner ~= nil and hovoredReport[1].owner[2]) or "Unknow")),
            ("Identité du Joueur : ~h~%s~h~"):format(((hovoredReport[2] ~= nil and hovoredReport[2].identity) or "Unknow")),
            ("Raison : ~h~%s~h~"):format(((hovoredReport[1] ~= nil and hovoredReport[1].reason) or "Unknow")),
            ("Pris par : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~"):format(staff_data ~= nil and staff_data.name or "~y~Personne~s~")
        })

    end

end, function()

    hovoredReport = nil

end)


report_menu_selected:IsVisible(function(Items)

    local report_data = Client.Admin:GetReportFromId(hovoredReport[1].id)

    if (report_data ~= nil) then

        Items:Button("Prendre en charge", nil, {
        }, (Client.Player:GetServerId() ~= report_data.owner[2] and report_data.taken == nil), {

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.ReportTake, hovoredReport[1].id)

            end

        })

        Items:Button("Gérer le joueur", nil, {
        }, true, {

            onSelected = function()

                player_selected_menu:SetHasSubMenu(report_menu_selected)

            end

        }, player_selected_menu)

        Items:Button("Fermer", nil, {
        }, (report_data.taken == Client.Player:GetServerId()), {

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.ReportRemove, hovoredReport[1].id)

            end

        })

    else

        RageUI.GoBack()

    end

end)