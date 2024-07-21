local gangJSON = LoadResourceFile("vCore3", "Server/JSON/Gangs.json");
local converted = gangJSON and json.decode(gangJSON)
local playersHasBlips = {}

exports["vCore3"]:RegisterCommand("gangs", function(xPlayer, args)
    local data = {}

    if (xPlayer) then

        if (not playersHasBlips[xPlayer.identifier]) then
            playersHasBlips[xPlayer.identifier] = true

            for k, v in pairs(converted) do
                table.insert(data, {
                    name = v.name,
                    x = v.boss_action.x,
                    y = v.boss_action.y,
                    z = v.boss_action.z,
                })
            end

            TriggerClientEvent("vCore1:gang:receiveGangPosition", xPlayer.source, data)
            xPlayer.showNotification("Vous avez activer les emplacements des organisations")

        else
            playersHasBlips[xPlayer.identifier] = false
            TriggerClientEvent("vCore1:gang:receiveGangPosition", xPlayer.source)
            xPlayer.showNotification("Vous avez désactiver les emplacements des organisations")
        end

    end

end, {help = "Afficher les emplacements des organisations", 
}, {
	inMode = true,
})

AddEventHandler("playerDropped", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        if (playersHasBlips[xPlayer.identifier]) then
            playersHasBlips[xPlayer.identifier] = nil
        end

    end
end)