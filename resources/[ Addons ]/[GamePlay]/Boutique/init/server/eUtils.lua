eUtils = {}

eUtils.GetDistance = function(source, position, distance, eventName, security, onAccepted, onRefused)
    if #(GetEntityCoords(GetPlayerPed(source)) - position) < distance then
        onAccepted();
    else
        onRefused();
        if security then
            local xPlayer = ESX.GetPlayerFromId(source)
            ViceLogs('https://discord.com/api/webhooks/1226980104157138944/Uhdf3Jy0kp5g6K5lXGo6-xw1i8K2r18xRk_DhQXQb3i--xCnhIRs29Rdq6CZfJ_u3wWZ', "AntiCheat","**"..GetPlayerName(source).."** vient d'etre Kick \n**License** : "..xPlayer.identifier..'\nEvent : '..eventName, 56108)
            DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat [' ..eventName..']')
        end
    end
end