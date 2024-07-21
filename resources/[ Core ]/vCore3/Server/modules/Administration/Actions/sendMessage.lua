---
--- @author Kadir#6666
--- Create at [25/04/2023] 19:34:59
--- Current project [Valestia-V1]
--- File name [sendMessage]
---

--- @param xPlayer xPlayer
--- @param args table[]
local function StaffCommand(xPlayer, args)

    if (not xPlayer) then
        return
    end

    local message_to_send = table.concat(args, " ", 2)
    if (message_to_send:len() > 50) then
        return xPlayer.showNotification("Veuillez saisir moins de mots dans votre message.")
    elseif (message_to_send:len() < 5) then
        return xPlayer.showNotification("Veuillez saisir plus de mots dans votre message.")
    end

    local target_player_id = tonumber(args[1])
    local target_player_data = ESX.GetPlayerFromId(target_player_id)

    if (target_player_data == nil) then
        return
    end

    JG.Discord:SendMessage(
            "Admin:SendMessage",
            ("***%s*** vient d'envoyer un message à ***%s***."):format(xPlayer.getName(), target_player_data.getName()),
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
                },

                {
                    name = "Message envoyé",
                    value = message_to_send,
                    inline = true
                }

            }
    );

    xPlayer.showNotification("Votre message à bien été envoyé.")
    return target_player_data.showNotification(("Message de (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s - %s~s~) : ~y~%s~s~"):format(xPlayer.source, xPlayer.getName(), message_to_send))

end

Shared:RegisterCommand("sendmessage", function(xPlayer, args)

    return StaffCommand(xPlayer, args)

end, {help = "Permet d'envoyer un message à un joueur.", params = {
    {name = "id", help = "ID du joueur qui va recevoir le message."},
    {name = "message", help = "Message que vous souhaitez lui envoyer."}
}}, {
    inMode = true
});

Shared.Events:OnNet(Enums.Administration.Server.Actions.SendMessage, function(xPlayer, ...)

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