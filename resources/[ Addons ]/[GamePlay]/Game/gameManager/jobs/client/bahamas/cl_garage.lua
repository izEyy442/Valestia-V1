local open = false 
local mainMenu = RageUI.CreateMenu('', 'Garage Bahamas')

mainMenu.Display.Header = true 
mainMenu.Closed = function()
  	open = false
end

RegisterNetEvent("bahamas:OpenGarage", function()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
			while open do 
				RageUI.IsVisible(mainMenu,function() 
					local playerData = ESX.GetPlayerData()
					local job = playerData.job.name
					if job == 'bahamas' then 
						RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Gestion Véhicule ~s~ ↓")

						RageUI.Button("Limousine", nil, {RightLabel = "→→"}, true , {
							onSelected = function()
								for k,v in pairs(Config.Jobs.Bahamas.SpawnVehicule) do
									TriggerServerEvent('bahamas:SpawnVehicle', "stretch", v.coords[1], v.coords[2]);

									ESX.Game.SpawnVehicle('patriot2', v.coords[1], v.coords[2], function (vehicle)
										local newPlate = GeneratePlate()
										SetVehicleNumberPlateText(vehicle, newPlate)
										SetVehicleFuelLevel(vehicle, 100.0)
										TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
										TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
									  end)

									RageUI.CloseAll()
								end
							end
						})

						RageUI.Button("Limousine 4x4", nil, {RightLabel = "→→"}, true , {
							onSelected = function()
								for k,v in pairs(Config.Jobs.Bahamas.SpawnVehicule) do
									TriggerServerEvent('bahamas:SpawnVehicle', "patriot2", v.coords[1], v.coords[2])

									ESX.Game.SpawnVehicle('patriot2', v.coords[1], v.coords[2], function (vehicle)
										local newPlate = GeneratePlate()
										SetVehicleNumberPlateText(vehicle, newPlate)
										SetVehicleFuelLevel(vehicle, 100.0)
										TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
										TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
									  end)
									RageUI.CloseAll()
								end
							end
						})
					else
						RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'êtes pas ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Concessionnaire Bateau]~s~")
						return
					end
				end)
				Wait(0)
			end
		end)
	end
end)