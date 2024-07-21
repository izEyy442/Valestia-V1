local kmh = 3.6
local drift_speed_limit = 150.0

AddEventHandler("gameEventTriggered", function(name, args)

    if name == "CEventNetworkPlayerEnteredVehicle" then

        CreateThread(function()
            while GetPedInVehicleSeat(GetCar(), -1) == GetPed() do
                CarSpeed = GetEntitySpeed(GetCar()) * kmh
                if GetPedInVehicleSeat(GetCar(), -1) == GetPed() then 
                    if IsControlPressed(1, 21) then
                        if CarSpeed <= drift_speed_limit then
                            SetVehicleReduceGrip(GetCar(), true)
                        end
                    else
                        SetVehicleReduceGrip(GetCar(), false)
                    end
                end
                
                Wait(1)
            end
        end)

    end

end)

function GetPed() return PlayerPedId() end
function GetCar() return GetVehiclePedIsIn(PlayerPedId(),false) end