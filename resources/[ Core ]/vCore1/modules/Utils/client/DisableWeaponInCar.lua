local isActive = false

AddEventHandler("gameEventTriggered", function(name, args)
	if name == "CEventNetworkPlayerEnteredVehicle" then
        local player = PlayerPedId()
        local Vehicle = GetVehiclePedIsIn(player, false)
        
        if not isActive then
            CreateThread(function()
                while true do
                    if IsPedInAnyVehicle(player) then
                        if GetPedInVehicleSeat(Vehicle, -1) == player then
                            DisableControlAction(0, 330, true)
                            DisableControlAction(0, 68, true)
                            DisableControlAction(0, 25, true)
                            DisableControlAction(0, 346, true)
                            DisableControlAction(0, 347, true)
                            DisablePlayerFiring(player, true)
                            isActive = true
                        else
                            isActive = true
                            local CarSpeed = GetEntitySpeed(Vehicle) * 3.6
                            if CarSpeed >= 50 then
                                DisableControlAction(0, 68, true)
                                DisableControlAction(0, 91, true)
                                DisableControlAction(0, 92, true)
                                DisableControlAction(0, 25, true)
                                DisableControlAction(0, 346, true)
                                DisableControlAction(0, 347, true)
                                DisablePlayerFiring(player, true)
                            end
                        end
                    else
                        isActive = false
                        break
                    end
                    Wait(0)
                end
            end)
        end
	end
end)