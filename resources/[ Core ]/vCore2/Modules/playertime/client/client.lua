local PlayerTime = 0
local beafor = 0

function ConvertirTemps(milliseconds)
    local temps = {}

    local secondes = math.floor(milliseconds / 1000)
    local minutes = math.floor(secondes / 60)
    local heures = math.floor(minutes / 60)

    temps.heures = heures
    temps.minutes = minutes % 60
    temps.secondes = secondes % 60

    return temps
end 

RegisterNetEvent("PlayerTime:StartTimer", function(PlayedTime)
    PlayerTime = PlayedTime
    beafor = PlayedTime
    StartTimer()
end)

function StartTimer()
    while true do
        PlayerTime = PlayerTime + 1000
        if PlayerTime - beafor >= 60000 then
            TriggerServerEvent("PlayerTime:UpdateTimer", PlayerTime)
            beafor = PlayerTime
        end
        Wait(1000)
    end
end

RegisterCommand("mytime", function(source)
    local time = ConvertirTemps(PlayerTime)
    -- TriggerEvent('esx:showNotification', "Vous avez joué "..time.heures.." heures, "..time.minutes.." minutes et "..time.secondes.." secondes")
    TriggerEvent('esx:showNotification', "Vous avez joué "..time.heures.." heures, "..time.minutes.." minutes")
end)