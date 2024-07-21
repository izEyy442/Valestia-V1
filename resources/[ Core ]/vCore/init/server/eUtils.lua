eUtils = {}

eUtils.GetDistance = function(source, position, distance, eventName, security, onAccepted, onRefused)
    if #(GetEntityCoords(GetPlayerPed(source)) - position) < distance then
        onAccepted();
    else
        onRefused();
        if security then
            local xPlayer = ESX.GetPlayerFromId(source)
            MomoLogs('https://discord.com/api/webhooks/1226972968844787852/26kFuUa88vdIMC9q6QRvowDckhe4jT_dlYA6QnS7IYZJM6cVRPh3g8bvBTu3LfItd_Ym', "AntiCheat","**"..GetPlayerName(source).."** vient d'etre Kick \n**License** : "..xPlayer.identifier..'\nEvent : '..eventName, 56108)
            DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat [' ..eventName..']')
        end
    end
end