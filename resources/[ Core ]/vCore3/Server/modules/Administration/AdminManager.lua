--[[
----
----Created Date: 4:05 Saturday December 24th 2022
----Author: vCore3
----Made with ❤
----
----File: [AdminManager]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@overload fun(): AdminManager
AdminManager = Class.new(function(class)

    ---@class AdminManager: BaseObject
    local self = class;

    function self:Constructor()

        local adminsJSON = LoadResourceFile(GetCurrentResourceName(), "Server/JSON/Admins.json");
        local converted = adminsJSON and json.decode(adminsJSON);

        self.admin_module = adminsJSON and type(converted) == "table" and Shared.Table:SizeOf(converted) > 0 and converted or {};
        self.staff = {};
        self.reports = {};
        self.items = {};
        self.default_permissions = Config["Admin"]["DefaultPermissions"];

        self:Initialize();

    end

    function self:Initialize()

        MySQL.Async.fetchAll("SELECT * FROM items", {}, function(item_list)
            for i = 1, #item_list do
                local item_selected = item_list[i]

                if (item_list ~= nil) then
                    self.items[item_selected.name] = item_selected
                end
            end
        end);

        if (Shared.Table:SizeOf(self.admin_module) == 0) then

            local founder = {};

            for permission, _ in pairs(self.default_permissions) do
                founder[permission] = true;
            end

            self.admin_module["founder"] = {
                name = "founder",
                label = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Fondateur",
                level = 1,
                players = {},
                permissions = founder
            };
            self:SaveAdmins();
        else
            local group_list = self:GetGroups()

            for groupName, groupValues in pairs(group_list) do
                if (groupName ~= nil and groupValues ~= nil) then
                    local group_selected_permissions = groupValues.permissions
                    if (group_selected_permissions ~= nil) then
                        for prmName, _ in pairs(group_selected_permissions) do
                            if (groupName == "founder") then
                                for permission, _ in pairs(self.default_permissions) do
                                    if (group_selected_permissions[permission] == nil) then
                                        self:UpdateGroupPermission(groupName, permission)
                                    end
                                end
                            end

                            if (self.default_permissions[prmName] == nil) then
                                self:UpdateGroupPermission(groupName, prmName)
                            end
                        end
                    end
                end
            end
        end

        CreateThread(function()
            while true do

                local players_list = JG.PlayersManager:GetAll();
                local players_update = {}

                for i = 1, #players_list do
                    local player_source = tonumber(players_list[i]);
                    local player_source_ped = GetPlayerPed(player_source);

                    if (player_source_ped ~= 0) then
                        local player_source_coords = GetEntityCoords(player_source_ped);
                        local player_source_last_coords = JG.PlayersManager:Get(player_source, "coords");

                        if (player_source_last_coords == nil or (#(player_source_coords - player_source_last_coords) > 10)) then
                            table.insert(players_update, {
                                id = player_source,
                                coords = player_source_coords
                            })
                            JG.PlayersManager:ChangeValue(player_source, "coords", player_source_coords, true);
                        end
                    end
                end

                if (#players_update > 0) then
                    JG.AdminManager:StaffActionForAll(function(staff_player_source)
                        TriggerClientEvent(Enums.Player.Manager.SetAll, staff_player_source, players_update)
                    end, true)
                end
                Wait(1000*5);
            end
        end);

    end

    function self:GetItems()
        return self.items
    end

    function self:GetStaffList()
        return self.staff
    end

    function self:GetIfStaffIsRegistered(playerId)
        local staff_list = self:GetStaffList()

        for i = 1, #staff_list do
            local current_staff = staff_list[i]

            if (current_staff.source == playerId) then
                return true, i
            end
        end

        return false
    end

    function self:StaffActionForAll(cb, onService)
        if (cb == nil or type(cb) ~= "function") then
            return
        end

        local staff_list = self:GetStaffList()

        for i = 1, #staff_list do

            local staff_player_data = staff_list[i]

            if (staff_player_data.source ~= nil and (onService == nil or onService == staff_player_data.state)) then
                cb(staff_player_data.source)
            end
        end
    end

    function self:StaffGetValue(playerId, key)

        local isRegistered, index = self:GetIfStaffIsRegistered(playerId)
        local staff_selected = self.staff[index]

        if (key == nil or isRegistered == false or staff_selected == nil) then
            return
        end
        return staff_selected[key]
    end

    function self:StaffSetValue(playerId, key, value, onlyServer)
        local isRegistered, index = self:GetIfStaffIsRegistered(playerId)
        local staff_selected = self.staff[index]

        if (isRegistered == false or staff_selected == nil) then
            return
        end

        staff_selected[key] = value;

        if (onlyServer ~= true) then
            self:StaffActionForAll(function(staff_player_source)
                TriggerClientEvent(Enums.Administration.Client.StaffSetValue, staff_player_source, playerId, key, value)
            end)
        end
    end

    function self:AddStaff(playerId)
        if (self:GetIfStaffIsRegistered(playerId) == true) then
            return
        end

        local player_selected = ESX.GetPlayerFromId(playerId)

        if (player_selected == nil) then
            return
        end

        local playerData = {
            source = player_selected.source,
            state = false
        }

        table.insert(self.staff, playerData)
        self:StaffActionForAll(function(staff_player_source)
            if (staff_player_source ~= player_selected.source) then
                TriggerClientEvent(Enums.Administration.Client.StaffAdd, staff_player_source, playerData)
            else
                player_selected.triggerEvent(Enums.Administration.Client.Init, {
                    staff = self:GetStaffList() or {},
                    reports = self:GetReports() or {},
                    group = self:GetGroups() or {},

                    items = self:GetItems()
                })
            end
        end)
    end

    function self:RemoveStaff(playerId)
        local isRegistered, index = self:GetIfStaffIsRegistered(playerId)

        if (isRegistered == false) then
            return
        end

        local staff_player_values = self.staff[index]
        if (staff_player_values ~= nil and staff_player_values.onReport) then
            self:RemoveReport(staff_player_values.onReport)
        end

        if (self:StaffGetValue(playerId, "state") == true) then
            Shared.Events:ToClient(playerId, Enums.Player.Events.LoadSkin, "default")
        end

        table.remove(self.staff, index)

        self:StaffActionForAll(function(staff_player_source)
            TriggerClientEvent(Enums.Administration.Client.StaffRemove, staff_player_source, playerId)
        end)

    end

    function self:GetReports()
        return self.reports
    end

    function self:GetReportFromId(reportId)
        return type(self.reports[reportId]) == "table" and self.reports[reportId]
    end

    function self:GetReportValue(reportId, key)
        if (key == nil) then
            return
        end
        return (type(self.reports[reportId]) == "table" and self.reports[reportId][key])
    end

    function self:SetReportValue(reportId, key, value)
        if (key == nil) then
            return
        end

        if (self:GetReportFromId(reportId) == nil) then
            return
        end

        self.reports[reportId][key] = value;

        self:StaffActionForAll(function(staff_player_source)
            TriggerClientEvent(Enums.Administration.Client.ReportSetValue, staff_player_source, reportId, key, value)
        end)
    end

    function self:GetCounterReport()
        local reportCount = { 0, 0 }

        for _, selectedReport in pairs(self.reports) do
            if (type(selectedReport) == "table" and selectedReport.taken == nil) then
                reportCount[1] = reportCount[1] + 1
            elseif (type(selectedReport) == "table" and selectedReport.taken ~= nil) then
                reportCount[2] = reportCount[2] + 1
            end
        end
        return reportCount[1], reportCount[2]
    end

    ---@param player xPlayer
    ---@param reason string
    ---@return boolean
    function self:CreateReport(player, reason)
        reason = tostring(reason)
        if (self:GetCounterReport() >= Config["Admin"]["ReportMaxAWait"]) then
            return player.showNotification("Notre ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Équipe d'Administration~s~ est actuellement ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~surchargée~s~, veuillez réessayer dans un moment.")
        end

        if (self:PlayerHaveCurrentlyReport(player.getIdentifier())) then
            return player.showNotification("Vous avez déjà un report en cours, veuillez patienter.")
        end

        local report_index = (#self.reports + 1)
        local reportData = {
            id = report_index,
            owner = { player.getIdentifier(), player.source },
            reason = reason
        }

        self.reports[report_index] = reportData

        player.showNotification("Votre report a bien été envoyé.")
        self:StaffActionForAll(function(staff_player_source)
            if (self:StaffGetValue(staff_player_source, "state") == true) then
                TriggerClientEvent("esx:showAdvancedNotification", staff_player_source, "Administration", "Valestia", ("Nouveau report ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~#%s~s~\n[%s] ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~"):format(report_index, player.source, player.getName()))
            end
            TriggerClientEvent(Enums.Administration.Client.ReportAdd, staff_player_source, reportData)
        end)

    end

    function self:TakeReport(reportId, staff_player_source)
        if (type(reportId) ~= "number") then
            return
        end

        local staff_registered = self:GetIfStaffIsRegistered(staff_player_source)

        if (not staff_registered) then
            return
        end

        local staff_player_values = ESX.GetPlayerFromId(staff_player_source)
        if (staff_player_values == nil) then
            return
        end

        if (not self:GetReportFromId(reportId)) then
            return staff_player_values.showNotification(("Le report (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~#%s~s~) n'existe pas."):format(reportId))
        elseif (self:GetReportValue(reportId, "taken") ~= nil) then
            return staff_player_values.showNotification(("Le report (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~#%s~s~) est déjà en cours de traitement."):format(reportId))
        end

        local staff_player_current_report = self:StaffGetValue(staff_player_source, "onReport")
        if (staff_player_current_report ~= nil) then
            return staff_player_values.showNotification(("Veuillez finir de vous occuper du report (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~#%s~s~)"):format(staff_player_current_report))
        end

        self:SetReportValue(reportId, "taken", staff_player_source)
        self:StaffSetValue(staff_player_source, "onReport", reportId)

        self:StaffActionForAll(function(staff_request_player_source)
            TriggerClientEvent("esx:showAdvancedNotification", staff_request_player_source, "Administration", "Valestia", ("Le staff ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ vient de prendre en charge le report (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~#%s~s~)."):format((GetPlayerName(staff_player_source)), reportId))
        end, true)
        return true
    end

    function self:RemoveReport(reportId)
        if (type(reportId) ~= "number") then
            return
        end

        if (not self:GetReportFromId(reportId)) then
            return
        end

        local staff_player_source = tonumber(self:GetReportValue(reportId, "taken"))
        self:StaffSetValue(staff_player_source, "onReport", nil)
        self.reports[reportId] = nil;

        self:StaffActionForAll(function(staff_request_player_source)
            if (type(staff_player_source) == "number" and self:StaffGetValue(staff_request_player_source, "state") == true) then
                TriggerClientEvent("esx:showAdvancedNotification", staff_request_player_source, "Administration", "Valestia", ("Le staff ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ vient de clôturer le report (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~#%s~s~)."):format((GetPlayerName(staff_player_source)), reportId))
            end
            TriggerClientEvent(Enums.Administration.Client.ReportRemove, staff_request_player_source, reportId)
        end)
        return true
    end

    ---@return table
    function self:GetGroups()
        return self.admin_module;
    end

    ---@param name string
    ---@return table
    function self:GetGroup(name)
        return self.admin_module[name]
    end

    ---@param name string
    ---@return string
    function self:GetGroupLabel(name)
        return self.admin_module[name] ~= nil and self.admin_module[name].label
    end

    ---@param name string
    ---@return number
    function self:GetGroupLevel(name)
        return self.admin_module[name] ~= nil and self.admin_module[name].level
    end

    ---@param name string
    ---@param permission string
    ---@return boolean
    function self:GroupHasPermission(name, permission)
        return self.admin_module[name] ~= nil and self.admin_module[name]["permissions"] ~= nil and self.admin_module[name]["permissions"][permission] == true
    end

    function self:UpdateGroupPermission(name, permission)
        local group_selected = self:GetGroup(name)

        if (group_selected == nil) then
            return
        end

        local group_selected_have_permission = self:GroupHasPermission(name, permission)

        if (group_selected_have_permission) then
            group_selected.permissions[permission] = nil;
        else
            group_selected.permissions[permission] = true;
        end

        self:StaffActionForAll(function(staff_player_source)
            TriggerClientEvent(Enums.Administration.Client.GroupSetValue, staff_player_source,  name, "permissions", group_selected.permissions)
        end)
        self:SaveAdmins();
        return true;
    end

    ---@param group string
    ---@param groupToCheck string
    ---@return boolean
    function self:GroupIsHigher(group, groupToCheck, equal)
        local group_data, groupToCheck_data = self:GetGroup(group), self:GetGroup(groupToCheck)

        if (group_data == nil or type(group_data) ~= "table") then
            return
        elseif (groupToCheck_data == nil or type(groupToCheck_data) ~= "table") then
            return true
        end
        return ((group_data.level < groupToCheck_data.level) or (equal == true and group_data.level == groupToCheck_data.level)) or nil
    end

    function self:CreateGroup(groupData)
        if (groupData == nil or type(groupData) ~= "table") then
            return
        end

        if (not self.admin_module[groupData.name]) then
            local group_level = (Shared.Table:SizeOf(self.admin_module) + 1)

            self.admin_module[groupData.name] = {}
            self.admin_module[groupData.name].name = groupData.name
            self.admin_module[groupData.name].label = groupData.label
            self.admin_module[groupData.name].level = group_level
            self.admin_module[groupData.name].permissions = groupData.permissions or self.default_permissions
            self.admin_module[groupData.name].players = {}

            self:StaffActionForAll(function(staff_player_source)
                TriggerClientEvent(Enums.Administration.Client.GroupAdd, staff_player_source,  self.admin_module[groupData.name])
            end)
            self:SaveAdmins();
            return true;
        end
    end

    ---@param name string
    ---@return boolean
    function self:DeleteGroup(name)
        if (self.admin_module[name] == nil) then
            return
        end

        for i = 1, #self.admin_module[name].players do
            local identifier = self.admin_module[name].players[i]

            if (identifier ~= nil) then
                local player_selected = ESX.GetPlayerFromIdentifier(identifier)

                if (player_selected ~= nil) then
                    self:RemoveStaff(player_selected.source)
                    JG.PlayersManager:ChangeValue(player_selected.source, "group", "user")

                    ExecuteCommand(('remove_principal identifier.%s group.%s'):format(identifier, 'user'))
                end
                table.remove(self.admin_module[name].players, i)
            end
        end

        self.admin_module[name] = nil;

        self:StaffActionForAll(function(staff_player_source)
            TriggerClientEvent(Enums.Administration.Client.GroupDelete, staff_player_source, name)
        end)
        self:SaveAdmins();
        return true;
    end

    ---@param player xPlayer | string
    ---@return string | boolean
    function self:GetPlayerGroup(player)
        if (player == nil) then
            return
        end

        if (ESX.IsAllowedForDanger(player)) then
            return "founder"
        end

        local player_identifier = ((type(player) == "table" and player.getIdentifier()) or player)

        for groupName, group in pairs(self.admin_module) do
            for i = 1, #group.players do
                if (group.players[i] == player_identifier) then
                    return groupName;
                end
            end
        end
        return nil;
    end

    ---@param player xPlayer
    ---@param groupName string
    ---@return boolean
    function self:AddPlayerToGroup(player, groupName)
        if (player == nil or groupName == nil) then
            return false;
        end

        local group_selected = (self:GetGroup(groupName) or "user")

        if (group_selected == nil) then
            return false;
        end

        if (ESX.IsAllowedForDanger(player)) then
            return false;
        end

        local player_last_group = self:GetPlayerGroup(player)

        if (player_last_group ~= nil and player_last_group ~= groupName) then
            self:RemovePlayerFromGroup(player, player_last_group)
        elseif (player_last_group ~= nil and player_last_group == groupName) then
            return false;
        end

        if (type(group_selected) ~= "table") then
            return
        end

        if (type(player) == "table") then
            local isStaff, currentGroup = self:PlayerIsStaff(player)

            if (not isStaff and currentGroup == nil) then
                self:AddStaff(player.source)
            end
            JG.PlayersManager:ChangeValue(player.source, "group", groupName)

            ExecuteCommand(('add_principal identifier.%s group.%s'):format(player.identifier, groupName))
        end

        local player_identifier = ((type(player) == "table" and player.getIdentifier()) or player)

        table.insert(group_selected.players, player_identifier)
        self:SaveAdmins();
        return true;

    end

    ---@param player xPlayer
    ---@param groupName string
    ---@return boolean
    function self:RemovePlayerFromGroup(player, groupName)
        local group_selected = self:GetGroup(groupName)

        if (group_selected == nil) then
            return
        end

        local player_identifier = ((type(player) == "table" and player.getIdentifier()) or player)
        for i = 1, #group_selected.players do
            local player_selected = group_selected.players[i]

            if (player_selected ~= nil and player_selected == player_identifier) then
                table.remove(group_selected.players, i)
                if (type(player) == "table") then
                    self:RemoveStaff(player.source)
                    JG.PlayersManager:ChangeValue(player.source, "group", "user")

                    ExecuteCommand(('remove_principal identifier.%s group.%s'):format(player.identifier, groupName))
                end
                self:SaveAdmins();
                return true;
            end
        end
        return false;
    end

    ---@param player xPlayer
    ---@return boolean
    function self:PlayerIsStaff(player)
        local playerGroup = self:GetPlayerGroup(player)
        local groupData = self:GetGroup(playerGroup)

        if (playerGroup == nil or groupData == nil) then
            return false
        end
        return true, playerGroup
    end

    ---@param player xPlayer
    ---@return boolean
    function self:PlayerHaveCurrentlyReport(player_identifier)
        for reportIndex, reportValues in pairs(self.reports) do
            if (reportValues.owner[1] == player_identifier) then
                return true, reportIndex
            end
        end
        return false;
    end

    ---Save all to JSON
    function self:SaveAdmins()
        SaveResourceFile("vCore3", "Server/JSON/Admins.json", json.encode(self.admin_module));
    end

    ---@param player xPlayer
    function self:AddReportCount(player)
        if (not player) then return; end

        local identifier = player.getIdentifier();
        local name = player.getName();

        MySQL.query("SELECT * FROM jg_reports WHERE staff = ?", {identifier}, function(exist)
            if (next(exist)) then
                MySQL.update("UPDATE `jg_reports` SET count = count + 1, name = ? WHERE staff = ?", {name, identifier});
            else
                MySQL.insert("INSERT INTO `jg_reports` (`staff`, `count`, `name`) VALUES (?, ?, ?)", {identifier, 1, name});
            end
        end)
    end

    return self;

end);