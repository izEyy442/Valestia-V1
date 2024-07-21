---
--- @author Kadir#6666
--- Create at [30/05/2023] 19:07:23
--- Current project [Valestia-V1]
--- File name [PlayerDropped]
---

---@param xPlayer xPlayer
---@param drop_reason string
local function onDrop(xPlayer, drop_reason)

    if (not xPlayer) then
        return
    end

    drop_reason = tostring(drop_reason)

    local drop_reason_formatted = (type(drop_reason) == "string" and (string.find(string.lower(drop_reason), "crashed") and "Crash") or "Quit")
    local player_character = xPlayer.getCharacter()
    local player_name = xPlayer.getName()
    local player_coords = xPlayer.getCoords()

    Shared.Events:Broadcast(Enums.Administration.Client.PlayerDropped, player_character, player_name, player_coords, drop_reason_formatted)
    JG.Discord:SendMessage(
            "Admin:PlayerDropped",
            ("***%s*** vient de quitter le serveur."):format(player_name),
            {

                {
                    name = "Identifiant du JOUEUR",
                    value = xPlayer.getIdentifier(),
                    inline = true
                },

                {
                    name = "ID unique du JOUEUR",
                    value = player_character,
                    inline = true
                },

                {
                    name = "Raison de la déconnexion",
                    value = drop_reason,
                    inline = true
                }

            }
    );

end

Server:OnPlayerDropped(function(xPlayer, reason)
    return onDrop(xPlayer, reason)
end);