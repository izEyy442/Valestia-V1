---
--- @author Kadir#6666
--- Create at [26/04/2023] 00:26:31
--- Current project [Valestia-V1]
--- File name [LocalPlayer]
---

Shared.Events:OnNet(Enums.Player.Events.LoadSkin, function(skin)

    if (skin == nil) then
        return
    end

    return Client.Player:LoadSkin(skin)

end)

Shared.Events:OnNet(Enums.Player.Events.SetWaypoint, function(position)

    if (type(position) ~= "vector3") then
        return
    end

    SetNewWaypoint(position.x, position.y)
    ESX.ShowAdvancedNotification('Notification', "GPS", "Votre GPS a été actualisé", 'CHAR_CALL911', 8)

end)