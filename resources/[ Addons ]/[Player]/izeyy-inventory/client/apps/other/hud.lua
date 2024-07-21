
function Inventaire:hideHUD()
    TriggerEvent(Config.Trigger['getStatus'], 'hunger',function(status) hunger = status.val / 10000 end)
    TriggerEvent(Config.Trigger['getStatus'], 'thirst', function(status) thirst = status.val / 10000 end)
    SendNUIMessage({
        action = "InvHud",
        hp = GetEntityHealth(PlayerPedId())-100,
        armor = GetPedArmour(PlayerPedId()),
        hunger = hunger,
        thirst = thirst,
    })
end
