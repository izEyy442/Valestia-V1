---
--- @author Kadir#6666
--- Create at [26/04/2023] 00:05:49
--- Current project [Valestia-V1]
--- File name [setPed]
---

--- @param xPlayer xPlayer
--- @param args table[]
local function StaffCommand(xPlayer, args)

    if (not xPlayer) then
        return
    end

    local model_selected = args[2]
    if (model_selected == nil) then
        return
    end

    local target_player_id = tonumber(args[1])
    local target_player_data = (target_player_id ~= xPlayer.source and ESX.GetPlayerFromId(target_player_id))

    local player_group = JG.AdminManager:GetPlayerGroup(xPlayer)
    local target_player_group = (target_player_id ~= xPlayer.source and JG.AdminManager:GetPlayerGroup(target_player_data))
    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (not JG.AdminManager:GroupHasPermission(player_group, "take_ped") or (target_player_id ~= xPlayer.source and (not JG.AdminManager:GroupIsHigher(player_group, target_player_group)))) then
        return
    end

    if (JG.AdminManager:PlayerIsStaff(target_player_data) and (JG.AdminManager:StaffGetValue(target_player_data.source, "state") == true and not JG.AdminManager:GroupHasPermission(target_player_group, "player_use_personnal_ped"))) then
        return
    end

    local player_selected = (target_player_data or xPlayer)
    player_selected.triggerEvent(Enums.Player.Events.LoadSkin, model_selected)

    JG.Discord:SendMessage(
            "Admin:SetPed",
            ("***%s*** vient de changer le model à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected.getName()),
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
                    value = player_selected.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected.getName(),
                    inline = true
                },

                {
                    name = "Model changé",
                    value = ("***%s***"):format(model_selected),
                    inline = true
                }

            }
    );

end

Shared:RegisterCommand("setPed", function(xPlayer, args)
    return StaffCommand(xPlayer, args);
end, {help = "Permet de changer le model d'un joueur.", params = {
    {name = "id", help = "ID du joueur."},
    {name = "model", help = "Model du ped."}
}},{
    permission = "take_ped"
});

Shared.Events:OnNet(Enums.Administration.Server.Actions.SetPed, function(xPlayer, ...)
    return StaffCommand(xPlayer, { ... })
end);