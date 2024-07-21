local webhook = 'https://discord.com/api/webhooks/1226966739204571336/lXWc97We7Ec8ombR7U56fA0XMgVJx9EJGGXNTqjDogEBsBKk35Towf-yOK8wjVcrcnqE'

ESX.RegisterServerCallback('screenshot:getwebhook', function(source, cb)
    cb('https://discord.com/api/webhooks/1226966739204571336/lXWc97We7Ec8ombR7U56fA0XMgVJx9EJGGXNTqjDogEBsBKk35Towf-yOK8wjVcrcnqE')
end)

RegisterNetEvent("vCore1:TakeScreen")
AddEventHandler("vCore1:TakeScreen", function(source)
    TriggerClientEvent('vCore1:GetScreen', source)
end)

exports["vCore3"]:RegisterCommand("screen", function(xPlayer, args)

    local target_player = ESX.GetPlayerFromId(tonumber(args[1]))
    if (target_player == nil) then
        return xPlayer ~= nil and xPlayer.showNotification("ID du joueur invalide.") or "ID du joueur invalide."
    elseif (xPlayer ~= nil and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), target_player.getGroup())) then
        return
    end

    PerformHttpRequest(webhook, function()

        for _ = 1, 5 do
            TriggerEvent('vCore1:TakeScreen', args[1])
            Wait(1500)
        end

        PerformHttpRequest(webhook, function() end, 'POST', json.encode({username = "Capture de jeu", content = "---- Fin des captures de jeu "..target_player.name.." demandé par "..((xPlayer ~= nil and xPlayer.getName()) or "Console").." ----"}), { ['Content-Type'] = 'application/json' })

    end, 'POST', json.encode({username = "Capture de jeu", content = "---- Début des captures de jeu du joueur "..target_player.name.." demandé par "..((xPlayer ~= nil and xPlayer.getName()) or "Console").." ----"}), { ['Content-Type'] = 'application/json' })

end, {help = "Faire une capture de jeu du joueur", params = {
    {name = "id", help = "Id du joueur"}
}}, {
    inMode = true
});

RegisterNetEvent("AC:BanPlayer", function(reason, staffbypass)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        if staffbypass and xPlayer.getGroup() ~= "user" then
            return
        else
            xPlayer.ban(0, reason)
        end

    end
end)