---
--- @author Kadir#6666
--- Create at [25/04/2023] 20:34:33
--- Current project [Valestia-V1]
--- File name [bring]
---

--- @param xPlayer xPlayer
--- @param args table[]
local function StaffCommand(xPlayer, args)

    if (not xPlayer) then
        return
    end

    local target_player_id = tonumber(args[1])
    local target_player_data = ESX.GetPlayerFromId(target_player_id)
    local target_player_ped = GetPlayerPed(target_player_data.source)

    if (target_player_data == nil) then
        return
    end

    local player_group = JG.AdminManager:GetPlayerGroup(xPlayer)
    local player_coords = xPlayer.getCoords()

    local target_player_group = JG.AdminManager:GetPlayerGroup(target_player_data)
    local target_player_is_staff = JG.AdminManager:PlayerIsStaff(target_player_data)
    local target_player_is_staff_higher = JG.AdminManager:GroupIsHigher(player_group, target_player_group, true)

    if ((target_player_is_staff == true and JG.AdminManager:StaffGetValue(target_player_data.source, "state") == true and target_player_is_staff_higher ~= true)) then
        return
    end

    local target_player_coords = GetEntityCoords(target_player_ped)
    JG.PlayersManager:ChangeValue(target_player_data.source, "last_pos", target_player_coords, true);

    local bucket = GetPlayerRoutingBucket(xPlayer.source);
    local target_bucket = GetPlayerRoutingBucket(target_player_id);

    if (bucket ~= target_bucket) then
        JG.PlayersManager:ChangeValue(target_player_id, "last_bucket", target_bucket, true);
        SetPlayerRoutingBucket(target_player_id, bucket);
        target_player_data.showNotification("Vous avez été téléporté dans une autre instance.");
    end

    SetEntityCoords(target_player_ped, player_coords);

    JG.Discord:SendMessage(
            "Admin:Bring",
            ("***%s*** vient de téléporter ***%s*** sur lui."):format(xPlayer.getName(), target_player_data.getName()),
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

Shared:RegisterCommand("bring", function(xPlayer, args)

    return StaffCommand(xPlayer, args)

end, {help = "Permet d'amener un joueur sur vous.", params = {
    {name = "id", help = "ID du joueur qui va venir sur vous."}
}}, {
    inMode = true
});

Shared.Events:OnNet(Enums.Administration.Server.Actions.Bring, function(xPlayer, ...)

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