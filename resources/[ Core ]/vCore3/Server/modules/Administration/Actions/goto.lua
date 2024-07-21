---
--- @author Kadir#6666
--- Create at [22/04/2023] 19:40:43
--- Current project [Valestia-V1]
--- File name [goto]
---

--- @param xPlayer xPlayer
--- @param args table[]
local function StaffCommand(xPlayer, args)

    if (not xPlayer) then
        return
    end

    local target_player_id = tonumber(args[1])
    local target_player_data = ESX.GetPlayerFromId(target_player_id)

    if (target_player_data == nil) then
        return
    end

    local player_ped = GetPlayerPed(xPlayer.source)
    local player_group = JG.AdminManager:GetPlayerGroup(xPlayer)

    local target_player_group = JG.AdminManager:GetPlayerGroup(target_player_data)
    local target_player_is_staff = JG.AdminManager:PlayerIsStaff(target_player_data)
    local target_player_is_staff_higher = JG.AdminManager:GroupIsHigher(player_group, target_player_group, true)

    if ((target_player_is_staff == true and JG.AdminManager:StaffGetValue(target_player_data.source, "state") == true and target_player_is_staff_higher ~= true)) then

        return

    end

    local bucket = GetPlayerRoutingBucket(xPlayer.source);
    local target_bucket = GetPlayerRoutingBucket(target_player_id);

    if (bucket ~= target_bucket) then
        JG.PlayersManager:ChangeValue(xPlayer.source, "last_bucket", bucket, true);
        SetPlayerRoutingBucket(xPlayer.source, target_bucket);
        xPlayer.showNotification("Vous avez été téléporté dans une autre instance.");
    end

    SetEntityCoords(player_ped, target_player_data.getCoords());

    JG.Discord:SendMessage(
            "Admin:Goto",
            ("***%s*** vient de se téléporter sur ***%s***."):format(xPlayer.getName(), target_player_data.getName()),
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
                    value = target_player_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = target_player_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = target_player_data.getName(),
                    inline = true
                }

            }
    );

end

Shared:RegisterCommand("goto", function(xPlayer, args)

    return StaffCommand(xPlayer, args)

end, {help = "Permet d'aller sur un joueur.", params = {
    {name = "id", help = "ID du joueur."}
}}, {
    inMode = true
});

Shared.Events:OnNet(Enums.Administration.Server.Actions.Goto, function(xPlayer, ...)

    if (not xPlayer) then
        return
    end

    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (JG.AdminManager:StaffGetValue(xPlayer.source, "state") ~= true) then
        return
    end

    return StaffCommand(xPlayer, { ... })

end);