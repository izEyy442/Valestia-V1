---
--- @author Kadir#6666
--- Create at [20/04/2023] 10:23:37
--- Current project [Valestia-V1]
--- File name [setgroup]
---


Shared.Events:OnNet(Enums.Administration.Server.Actions.CreateGroup, function(xPlayer, group_data)

    if (xPlayer == nil) then
        return
    end

    local playerGroup = JG.AdminManager:GetPlayerGroup(xPlayer)
    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (not JG.AdminManager:GroupHasPermission(playerGroup, "group_create")) then
        return
    end

    if (group_data == nil or type(group_data) ~= "table") then
        return
    elseif (group_data.name == nil or group_data.label == nil or group_data.permissions == nil) then
        return
    end

    for prmName, _ in pairs(group_data.permissions) do

        if (not JG.AdminManager:GroupHasPermission(playerGroup, prmName)) then

            return

        end

    end

    return JG.AdminManager:CreateGroup(group_data)

end);

Shared.Events:OnNet(Enums.Administration.Server.Actions.UpdateGroupPermission, function(xPlayer, groupName, groupPermission)

    if (xPlayer == nil) then
        return
    end

    local playerGroup = JG.AdminManager:GetPlayerGroup(xPlayer)
    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (not JG.AdminManager:GroupIsHigher(playerGroup, groupName) or not JG.AdminManager:GroupHasPermission(playerGroup, "group_manage") or not JG.AdminManager:GroupHasPermission(playerGroup, groupPermission)) then
        return
    end

    return JG.AdminManager:UpdateGroupPermission(groupName, groupPermission)

end);

Shared.Events:OnNet(Enums.Administration.Server.Actions.DeleteGroup, function(xPlayer, groupName)

    if (xPlayer == nil) then
        return
    end

    local playerGroup = JG.AdminManager:GetPlayerGroup(xPlayer)
    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (not JG.AdminManager:GroupIsHigher(playerGroup, groupName) or not JG.AdminManager:GroupHasPermission(playerGroup, "group_delete")) then
        return
    end

    return JG.AdminManager:DeleteGroup(groupName)

end);

Shared:RegisterCommand("setgroup", function(xPlayer, args)

    local groupName = tostring(args[2])
    if (groupName == nil) then
        return
    end

    local playerId = tonumber(args[1]) or tostring(args[1])
    if (playerId == nil) then
        return
    end

    local player_selected_data = ((type(playerId) == "number" and ESX.GetPlayerFromId(playerId)) or type(playerId) == "string" and ESX.GetPlayerFromIdentifier(playerId) or playerId)
    if (player_selected_data == nil) then
        return
    end

    local player_selected_data_group = JG.AdminManager:GetPlayerGroup(player_selected_data)
    if (xPlayer ~= nil) then

        local playerGroup = JG.AdminManager:GetPlayerGroup(xPlayer)
        if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
            return
        elseif (groupName ~= "user" and not JG.AdminManager:GroupIsHigher(playerGroup, groupName)) then
            return
        elseif (player_selected_data_group ~= nil and not JG.AdminManager:GroupIsHigher(playerGroup, player_selected_data_group)) then
            return
        end

    end

    JG.AdminManager:AddPlayerToGroup(player_selected_data, groupName)

    JG.Discord:SendMessage(
            "Admin:SetGroup",
            ("***%s*** vient de changer le grade de ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), ((type(player_selected_data) == "table" and player_selected_data.getName()) or player_selected_data)),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = ((type(player_selected_data) == "table" and player_selected_data.getIdentifier()) or player_selected_data),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = ((type(player_selected_data) == "table" and player_selected_data.source) or "OFFLINE"),
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = ((type(player_selected_data) == "table" and player_selected_data.getName()) or "Can't get this."),
                    inline = true
                },

                {
                    name = "Ancien grade",
                    value = (player_selected_data_group or "user"),
                    inline = true
                },
                {
                    name = "Nouveau grade",
                    value = groupName,
                    inline = true
                }

            }
    );

end, {help = "Permet changer le rang d'un joueur.", params = {
    {name = "player_id", help = "ID du joueur, celui qui va être mis dans le rang"},
    {name = "group_name", help = "Rang que vous souhaitez ou le joueur part"}
}}, {
    permission = "group_set_player"
});