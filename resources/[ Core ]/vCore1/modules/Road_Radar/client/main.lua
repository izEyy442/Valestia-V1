local isFlashed = false
local speed_flash = 0
local radarZone = Game.Zone("Radar")
local zones = Config["Road_Radar"]["Zones"] and Config["Road_Radar"]["Zones"] or {}

radarZone:Start(function()

    radarZone:SetTimer(1000)

    for i = 1, #zones or 1 do

        if (zones[i]["Radar"].x and zones[i]["Radar"].y and zones[i]["Radar"].z) then
            
            radarZone:SetCoords(vector3(zones[i]["Radar"].x, zones[i]["Radar"].y, zones[i]["Radar"].z))

            radarZone:IsPlayerInRadius(zones[i]["Radius"], function()
                radarZone:SetTimer(0)

                local player = PlayerPedId()
                local playerSpeed = GetEntitySpeed(player)*3.6
                local speedLimit = zones[i]["SpeedLimit"] or 130
                local speedDif = playerSpeed - speedLimit

                if not isFlashed then

                    if playerSpeed > speedLimit then

                        speed_flash = (GetEntitySpeed(player) * 3.6) or 0
                        isFlashed = true
                        StartScreenEffect("SwitchShortMichaelIn", 400, false)
                        TriggerServerEvent("vCore1:radar:sendbill", math.round(playerSpeed), math.round(speedDif), speedLimit)
                        SetTimeout(8000, function()
                            isFlashed = false
                        end)

                    end

                end

            end, false, true)
        end
    end
end)