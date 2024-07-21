---
--- @author Kadir#6666
--- Create at [25/04/2023] 20:49:01
--- Current project [Valestia-V1]
--- File name [bring_back]
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

    local target_player_last_pos = JG.PlayersManager:Get(target_player_data.source, "last_pos")

    if (target_player_last_pos ~= nil) then

        local bucket = GetPlayerRoutingBucket(target_player_id);
        local old_bucket = JG.PlayersManager:Get(target_player_id, "last_bucket");

        if (bucket ~= old_bucket) then
            SetPlayerRoutingBucket(target_player_id, old_bucket);
            target_player_data.showNotification("Vous avez été téléporté dans une autre instance.");
        end

        SetEntityCoords(target_player_ped, target_player_last_pos)
        JG.PlayersManager:ChangeValue(target_player_data.source, "last_pos", nil, true)

        JG.Discord:SendMessage(
                "Admin:BringBack",
                ("***%s*** vient de téléporter ***%s*** à sa dernière position."):format(xPlayer.getName(), target_player_data.getName()),
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

end

Shared:RegisterCommand("bringback", function(xPlayer, args)

    return StaffCommand(xPlayer, args)

end, {help = "Permet d'amener un joueur à sa dernière position connue.", params = {
    {name = "id", help = "ID du joueur qui va y aller."}
}}, {
    inMode = true
});

Shared.Events:OnNet(Enums.Administration.Server.Actions.BringBack, function(xPlayer, ...)

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