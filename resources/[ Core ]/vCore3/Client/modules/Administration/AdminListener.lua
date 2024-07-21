--[[
----
----Created Date: 3:52 Saturday December 24th 2022
----Author: vCore3
----Made with ❤
----
----File: [AdminListener]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@overload fun(): AdminListener
AdminListener = Class.new(function(class)

    ---@class AdminListener: BaseObject
    local self = class;

    function self:Constructor()

        ---@type table
        self.staff = {};

        ---@type table
        self.group = {};

        ---@type boolean
        self.enabled    = false;

        ---@type table
        self.preferences = {};

        ---@type table
        self.reports    = {};

        while (Client.Player == nil or Client.PlayersManager == nil) do
            Wait(500)
        end

        self:Initialize()

    end

    function self:Initialize()

        self.Ped = AdminPed();
        self.Utils = AdminUtils();

        Shared:RegisterKeyMapping("admin:open_menu", {
            label = "admin_open_menu"
        }, "F9", function ()

            Shared.Events:ToServer(Enums.Administration.Server.RequestOpenMenu);

        end);

        Shared:RegisterCommand("staffmode", function()

            self:SetStaffMode(not self:IsInStaffMode())

        end);

        CreateThread(function()

            while true do

                local loopInterval = (1000*3)

                local client_server_id = Client.Player:GetServerId()
                local client_player = Client.PlayersManager:GetFromId(client_server_id)
                local client_is_staff = (client_player ~= nil and client_player.group ~= "user")

                if (not client_is_staff) then

                    self:StopAll();
                    break

                elseif (client_is_staff and self:GetPreferenceFromName("report:number") == true) then

                    loopInterval = 0

                    local reportOnWait, reportTaken = self:GetCounterReport()
                    Game:DrawText({ 0.5, 0.01 }, ("Reports : ~r~%s~s~ en attente | ~g~%s~s~ en cours de traitement"):format(reportOnWait, reportTaken), 8, 0.5)

                end

                Wait(loopInterval)

            end

        end)

        Client.PlayersManager:OnDisconnected(function(player_id)

            if (self:IsInStaffMode() and self.Utils:GetBlipFromPlayer(player_id)) then

                return self.Utils:RemoveBlipForPlayer(player_id)

            end

        end)

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

    function self:StaffGetValue(playerId, key)

        local isRegistered, index = self:GetIfStaffIsRegistered(playerId)
        local staff_selected = self.staff[index]

        if (key == nil or isRegistered == false or staff_selected == nil) then

            return

        end

        return staff_selected[key]

    end

    function self:StaffSetValue(playerId, key, value)

        local isRegistered, index = self:GetIfStaffIsRegistered(playerId)
        local staff_selected = self.staff[index]

        if (isRegistered ~= true or staff_selected == nil) then

            return

        end

        staff_selected[key] = value;

    end

    function self:AddStaff(playerData)

        if (playerData == nil) then

            return

        end

        if (self:GetIfStaffIsRegistered(playerData.source) == true) then

            return

        end

        table.insert(self.staff, playerData)

    end

    function self:RemoveStaff(playerId)

        local isRegistered, index = self:GetIfStaffIsRegistered(playerId)

        if (isRegistered ~= true) then

            return

        end

        table.remove(self.staff, index)

    end

    ---@return table
    function self:GetGroups()

        return self.group;

    end

    ---@param name string
    ---@return table
    function self:GetGroup(name)

        return self.group[name]

    end

    ---@param name string
    ---@return string
    function self:GetGroupLabel(name)

        return self.group[name] ~= nil and self.group[name].label

    end

    ---@param name string
    ---@return number
    function self:GetGroupLevel(name)

        return self.group[name] ~= nil and self.group[name].level

    end

    ---@param name string
    ---@param permission string
    ---@return boolean
    function self:GroupHasPermission(name, permission)

        return self.group[name] ~= nil and self.group[name]["permissions"] ~= nil and self.group[name]["permissions"][permission] == true

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

    function self:UpdateGroup(name, key, value)

        if (name == nil or key == nil) then
            return
        end

        local group_selected = self:GetGroup(name)

        if (group_selected == nil) then
            return
        end

        self.group[name][key] = value;

    end

    function self:CreateGroup(data)

        if (data == nil or type(data) ~= "table") then
            return
        end

        local group_selected = self:GetGroup(data.name)

        if (group_selected ~= nil) then
            return
        end

        self.group[data.name] = data;

    end

    function self:DeleteGroup(name)

        local group_selected = self:GetGroup(name)

        if (group_selected == nil) then
            return
        end

        self.group[name] = nil;

    end

    ---@return boolean
    function self:IsInStaffMode()

        return self.enabled;

    end

    ---@param state boolean
    function self:SetStaffMode(state)

        local id = Client.Player:GetServerId();
        local is_founder = Client:isFounder();
        self.enabled = state;
        Shared.Events:ToServer(Enums.Administration.Server.StaffChangeState, self.enabled)
        if (state == true) then
            self:Loop()
            if (not is_founder) then
                self.Ped:Start();
            end
        else
            self.Ped:Stop();
        end
    end

    function self:GetPreferenceFromName(name)

        if (name == nil) then
            return
        end

        local preferenceState = GetResourceKvpString(("admin:preferences:%s"):format(name))
        if preferenceState == "false" then
            preferenceState = false
        elseif preferenceState == "true" then
            preferenceState = true
        end

        return preferenceState

    end

    function self:SetPreferenceFromName(name, value)

        if (name == nil or value == nil) then
            return
        end

        return SetResourceKvp(("admin:preferences:%s"):format(name), tostring(value))

    end

    function self:StopAll()

        self:SetStaffMode(false);

        ---@type UIMenu
        local admin_menu = Shared.Storage:Get("Administration"):Get("admin_main");

        if (admin_menu:IsOpen()) then

            admin_menu:Close()

        end

        Client.Admin = nil;

    end

    function self:Loop()

        CreateThread(function()

            while (true) do

                local client_player_server_id = Client.Player:GetServerId()
                local client_player_data = Client.PlayersManager:GetFromId(client_player_server_id)
                local client_player_is_in_staffmode = self:IsInStaffMode()

                if ((not client_player_is_in_staffmode) or (self:GetPreferenceFromName("blip") ~= true)) then

                    local blip_list = self.Utils:GetBlips()

                    for blipId in pairs(blip_list) do

                        if (type(blipId) == "number") then

                            self.Utils:RemoveBlipForPlayer(blipId)

                        end

                    end

                end

                if ((not client_player_is_in_staffmode) or (self:GetPreferenceFromName("gamertag") ~= true)) then

                    local tag_list = self.Utils:GetTags()

                    for tagId in pairs(tag_list) do

                        if (type(tagId) == "number") then

                            self.Utils:RemoveTagForPlayer(tagId)

                        end

                    end

                end

                if ((client_player_is_in_staffmode) and ((self:GetPreferenceFromName("blip") == true) or (self:GetPreferenceFromName("gamertag") == true))) then

                    local player_list = Client.PlayersManager:GetAll();

                    for playerId in pairs(player_list) do

                        if (playerId ~= client_player_server_id) then

                            local player_selected_data = Client.PlayersManager:GetFromId(playerId)
                            local client_player_can_manage = (self:StaffGetValue(playerId, "state") ~= true or (self:StaffGetValue(playerId, "state") == true and self:GroupIsHigher(client_player_data.group, player_selected_data.group, true)))

                            if (client_player_can_manage) then

                                if ((self:GetPreferenceFromName("gamertag") == true)) then

                                    self.Utils:AddTagForPlayer(playerId)

                                end

                                if ((self:GetPreferenceFromName("blip") == true)) then

                                    self.Utils:AddBlipForPlayer(playerId)

                                end

                            else

                                if (self.Utils:GetBlipFromPlayer(playerId)) then
                                    self.Utils:RemoveBlipForPlayer(playerId)
                                end

                                if (self.Utils:GetTagFromPlayer(playerId)) then
                                    self.Utils:RemoveTagForPlayer(playerId)
                                end

                            end

                        end

                    end

                end

                if (not client_player_is_in_staffmode) then
                    break
                end

                Wait(800)

            end

        end)

    end

    ---@return table
    function self:GetReports()

        return self.reports;

    end

    function self:GetReportFromId(reportId)

        return ((type(self.reports[reportId]) == "table" and self.reports[reportId]) or nil)

    end


    function self:GetReportValue(reportId, key)

        if (key == nil) then
            return
        end

        return self.reports[reportId] ~= nil and self.reports[reportId][key]

    end

    function self:SetReportValue(reportId, key, value)

        if (key == nil) then
            return
        end

        if (self:GetReportFromId(reportId) == nil) then
            return
        end

        self.reports[reportId][key] = value;

    end

    function self:AddReport(reportData)

        self.reports[reportData.id] = reportData;

    end

    function self:RemoveReport(reportIndex)

        self.reports[reportIndex] = nil;

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

    return self;

end);