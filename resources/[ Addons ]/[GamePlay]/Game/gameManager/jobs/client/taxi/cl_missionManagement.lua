---
--- @author Azagal
--- Create at [28/10/2022] 16:40:57
--- Current project [Silky-V1]
--- File name [missionManagement]
---

Taxi = Taxi or {}

Taxi.missionData = {}
Taxi.missionData.actived = false
Taxi.currentBlip = nil

RegisterNetEvent("Taxi:mission:sendData", function(missionData)
    if (missionData.blip ~= nil) then
        if (missionData.blip.coords ~= nil) then
            if (Taxi.currentBlip ~= nil and DoesBlipExist(Taxi.currentBlip)) then
                RemoveBlip(Taxi.currentBlip)
                Taxi.currentBlip = nil
            end
            Taxi.currentBlip = AddBlipForCoord(missionData.blip.coords)
            SetBlipRoute(Taxi.currentBlip, true)
        else
            if (Taxi.currentBlip ~= nil and DoesBlipExist(Taxi.currentBlip)) then
                RemoveBlip(Taxi.currentBlip)
                Taxi.currentBlip = nil
            end
        end
    end

    if (missionData.actived ~= nil) then
        Taxi.missionData.actived = missionData.actived
    end
end)