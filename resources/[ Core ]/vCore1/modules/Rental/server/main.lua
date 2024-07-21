local RentalTimeout = {}

RegisterNetEvent('vCore1:rental:spawnVehicle', function(key)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)
	local BuyRental = Config["Rental"][key]["PedPos"]
	local carModel = Config["Rental"][key]["CarModel"]
	local price = Config["Rental"][key]["Price"]

	if (xPlayer) then
		if #(coords - BuyRental) < 15 then
			
			if (not RentalTimeout[xPlayer.identifier] or GetGameTimer() - RentalTimeout[xPlayer.identifier] > 60000) then
				RentalTimeout[xPlayer.identifier] = GetGameTimer()

				if xPlayer.getAccount('cash').money >= price then
					xPlayer.removeAccountMoney('cash', price)
					xPlayer.showNotification("Vous avez payer "..price.." ~g~$")
					-- TONIO HERE
					ESX.SpawnVehicle(carModel, Config["Rental"][key]["SpawnCar"], Config["Rental"][key]["SpawnCarHeading"], nil, false, nil, function(vehicle)
						TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
					end)
				else
					xPlayer.showNotification("Vous n'avez pas assez d'argent sur vous")
				end

			else
				xPlayer.showNotification("Vous devez attendre 60 secondes avant de pouvoir acheter à nouveau")
			end

		else
			xPlayer.ban(0, '(vCore1:rental:spawnVehicle)')
		end
	end
end)