--[[
----
----Created Date: 3:47 Saturday December 24th 2022
----Author: vCore3
----Made with ❤
----
----File: [mainMenu]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local AdminStorage = Shared.Storage:Get("Administration");

---@type UIMenu
local mainMenu = AdminStorage:Get("admin_main");

---@type UIMenu
local reports_menu = AdminStorage:Get("admin_reports");

---@type UIMenu
local players_menu = AdminStorage:Get("admin_players")

---@type UIMenu
local player_selected_menu = AdminStorage:Get("admin_player_selected");

---@type UIMenu
local statistics_menu = AdminStorage:Get("admin_statistics");

mainMenu:IsVisible(function(Items)

    local client_server_id = Client.Player:GetServerId()
    local client_player = Client.PlayersManager:GetFromId(Client.Player:GetServerId(client_server_id))

    Items:Checkbox("Mode Staff Actif", nil, Client.Admin:IsInStaffMode(), {}, {
        onSelected = function(Checked)
            Client.Admin:SetStaffMode(Checked);
        end
    });

    local can_manage_group = Client.Admin:GroupHasPermission(client_player.group, "group_manage");

    if (can_manage_group) then
        Items:Button("Reports Counter", nil, {}, true, {
            onSelected = function()
                AdminStorage:Set("report_stats", nil);
                TriggerServerEvent(Enums.Administration.Server.RequestReportCount);
            end
        }, statistics_menu);
    end

    Items:Line()

    Items:Button("Reports en Attente", nil, {
    }, Client.Admin:IsInStaffMode(), {

    }, reports_menu)

    Items:Button("Liste des Joueurs", nil, {
    }, Client.Admin:IsInStaffMode(), {

        onSelected = function()

            player_selected_menu:SetHasSubMenu(players_menu)

        end

    }, players_menu)

    Items:Button("Gestion Véhicules", nil, {
    }, Client.Admin:IsInStaffMode(), {
    }, AdminStorage:Get("admin_vehicles"))

    Items:Button("Gestion Personnel", nil, {
    }, Client.Admin:IsInStaffMode(), {

        onSelected = function()

            AdminStorage:Get("hoveredPlayer")({ client_server_id, client_player, true })

        end

    }, AdminStorage:Get("admin_player_selected_me"))

    Items:Line()

    -- Items:Button("Préférences", nil, {
    -- }, true, {
    -- }, AdminStorage:Get("admin_preferences"))

    local client_player_is_in_supremacy = (can_manage_group == true or Client.Admin:GroupHasPermission(client_player.group, "take_ped") == true)
    if (client_player_is_in_supremacy) then

        Items:Button("La Suprématie", nil, {}, true, {
        }, AdminStorage:Get("admin_supremacy"))

    end

end);

RegisterNetEvent("Admin:OpeningMenu", function()
    return mainMenu:Toggle()
end)