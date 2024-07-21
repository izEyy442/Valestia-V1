---
--- @author Azagal
--- Create at [31/10/2022] 10:36:36
--- Current project [Silky-V1]
--- File name [missionStop]
---

RegisterNetEvent("Taxi:mission:stop", function()
    local playerSrc = source
    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    local playerJob = xPlayer.getJob()
    if (playerJob ~= nil and playerJob.name ~= "taxi") then
        return --[[BAN : Not in job]]
    end

    local playerIdentifier = xPlayer.getIdentifier()
    if (not playerIdentifier) then
        return
    end

    if (Taxi.Mission.Checked[playerIdentifier] == true) then
        Taxi.Mission.Checked[playerIdentifier] = nil
        xPlayer.triggerEvent("Taxi:mission:sendData", {
            actived = false
        })
    end

    local playerCurrentMission = Taxi.Mission.List[playerIdentifier]
    if (playerCurrentMission ~= nil) then
        playerCurrentMission:stop()
    end
end)