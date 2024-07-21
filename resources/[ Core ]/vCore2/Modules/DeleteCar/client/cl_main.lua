-- Date: 04/05/2024

local DeleteCarZone = {
    vector3(895.5569, 2353.5557, 51.6643), --cross
    vector3(-161.4018, -2131.1404, 16.7051), --kart sud
    vector3(2068.7354, 3943.0527, 35.1490) --kart nord
    -- Ajoute les autres positions ici @Zxnka et n'oubliez pas les virgules sauf a la dernière position 😊
}

local function DrawiZeyyInstructionBarNotification(x, y, z, text)
	local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, false)

	if distance <= 6 then
		SetTextScale(0.25, 0.25)
		SetTextFont(10)
		SetTextProportional(1)
		SetTextColour(235, 235, 235, 215)
		SetTextEntry("STRING")
		SetTextCentre(true)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		local factor = (string.len(text)) / 370
		ClearDrawOrigin()
	end
end

CreateThread(function()
    while true do
        local interval = 750
        for _,v in pairs(DeleteCarZone) do
            local MarkerDelPos = v
            local Player = PlayerPedId()
            local Coords = GetEntityCoords(Player)
            local dif = #(Coords - MarkerDelPos)
            if dif < 10 then
                interval = 1
                if dif <= 5 then
                    DrawMarker(6,MarkerDelPos.x,MarkerDelPos.y,MarkerDelPos.z -1, 1.0, 1.0, 90.0, 0, 0, 0, 3.0, 3.0, 3.0, 0, 131, 255, 225, 0, 0, 0, 0)
                    DrawMarker(1,MarkerDelPos.x,MarkerDelPos.y,MarkerDelPos.z -3.5, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 0, 131, 255, 225, 0, 0, 0, 0)
                    DrawiZeyyInstructionBarNotification(MarkerDelPos.x,MarkerDelPos.y,MarkerDelPos.z+0.2, "Appuyez sur [~b~E~s~] pour supprimer le véhicule")
                    if IsControlJustPressed(0, 51) then
                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        TaskLeaveVehicle(Player, vehicle, 0)
                        Citizen.Wait(2000)
                        DeleteEntity(vehicle)
                    end
                end
            end
        end
        Wait(interval)
    end
end)