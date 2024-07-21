AddEventHandler("CEventDeath", function(entities, entity, data)
    if entities[1] == PlayerPedId() then
        OnDeath()
    end
end)

AddEventHandler("CEventEntityDamaged", function()
    if IsPedDeadOrDying(PlayerPedId(), false) then
        OnDeath()
    end
end)