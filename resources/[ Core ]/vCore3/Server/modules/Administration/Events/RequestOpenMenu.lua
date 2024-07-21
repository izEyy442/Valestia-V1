---
--- @author Kadir#6666
--- Create at [20/04/2023] 15:12:36
--- Current project [Valestia-V1]
--- File name [RequestOpenMenu]
---

Shared.Events:OnNet(Enums.Administration.Server.RequestOpenMenu, function(xPlayer)

    if (not xPlayer) then
        return
    end

    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    end

    xPlayer.triggerEvent("Admin:OpeningMenu")

end)