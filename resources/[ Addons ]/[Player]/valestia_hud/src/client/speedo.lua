
CreateThread(function()
	local StateSpeedoMeter = false

	while (true) do
		local interval = 1000

		local PlayerPed = PlayerPedId()
		local isInVehicle = IsPedInAnyVehicle(PlayerPed, false)

		if (isInVehicle) then
			interval = 100

			if (not StateSpeedoMeter) then
				StateSpeedoMeter = true
				SendNUIMessage({ type = "SET_PLAYER_SPEEDO_SHOW", show = true }) 
			end

			local vehicle = GetVehiclePedIsIn(PlayerPed, false)
			local fuel = exports["vCore3"]:GetFuel(vehicle)
			local speed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
			local gear = GetVehicleCurrentGear(vehicle)
			
			SetVehicleCurrentGear(gear)
			SetSpeedoMeterValueSpeed(speed)
			SetSpeedoMeterValueFuel(math.ceil(fuel))
		else
			if (StateSpeedoMeter) then
				StateSpeedoMeter = false
				SendNUIMessage({ type = "SET_PLAYER_SPEEDO_SHOW", show = false })
			end
		end

		Wait(interval)
	end
end)

function SetVehicleCurrentGear(value)

    if (value == 0) then
        value = 'R'
    end

	SendNUIMessage({ type = "SET_PLAYER_SPEEDO_GEAR", value = value })
end
function SetSpeedoMeterValueSpeed(value)

    if(value < 100 and value > 10) then
        value = '0'..tostring(value)
    elseif (value < 10) then
        value = '00'..tostring(value)
    end

	SendNUIMessage({ type = "SET_PLAYER_SPEEDO_SPEED", value = value })
end
function SetSpeedoMeterValueFuel(value)
	SendNUIMessage({ type = "SET_PLAYER_SPEEDO_FUEL", value = value })
end