Properties, UsersInfos, InVisit, InProperty, InGarage = {}, {}, false, false, false 

CreateThread(function()
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local OnMarker = false 
		if not MenuIsOpen then 
			for k,v in pairs (Properties) do 
				for t,b in pairs (UsersInfos) do
					if v.propertyEntering ~= nil then 
						if #(pCoords - vector3(v.propertyEntering.x, v.propertyEntering.y, v.propertyEntering.z)) < 15.0 then
							OnMarker = true
							DrawMarker(2, vector3(v.propertyEntering.x, v.propertyEntering.y, v.propertyEntering.z), 0, 0, 0, 0, 0, 0, 0.25, 0.25, 0.25, 119,0,255, 200, 1, 0, 0, 2)
						end
						if #(pCoords - vector3(v.propertyEntering.x, v.propertyEntering.y, v.propertyEntering.z)) < 1.2 then
							ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour intéragir avec la proprieté.")
							if IsControlJustPressed(1, 51) then
								TriggerServerEvent("Property:OwnedProperties", v.propertyID)
							end                                
						end  
					end
					if v.propertyGarage ~= nil then 
						if v.propertyOwner == "-" or v.propertyOwner == b.identifier then 
							if #(pCoords - vector3(v.propertyGarage.x, v.propertyGarage.y, v.propertyGarage.z)) < 15.0 then
								OnMarker = true
								DrawMarker(2, vector3(v.propertyGarage.x, v.propertyGarage.y, v.propertyGarage.z), 0, 0, 0, 0, 0, 0, 0.25, 0.25, 0.25, 119,0,255,200, 1, 0, 0, 2)
							end
							if #(pCoords - vector3(v.propertyGarage.x, v.propertyGarage.y, v.propertyGarage.z)) < 1.2 then
								ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour intéragir avec le garage.")
								if IsControlJustPressed(1, 51) then
									TriggerServerEvent("Property:OwnedGarages", v.propertyID)
								end                                
							end 
						end
					end
					if v.propertyOwner == b.identifier then  
						if v.propertyRented ~= nil then 
							if #(pCoords - vector3(v.propertyRented.x, v.propertyRented.y, v.propertyRented.z)) < 15.0 then
								OnMarker = true
								DrawMarker(2, vector3(v.propertyRented.x, v.propertyRented.y, v.propertyRented.z), 0, 0, 0, 0, 0, 0, 0.25, 0.25, 0.25, 119,0,255,200, 1, 0, 0, 2)
							end
							if #(pCoords - vector3(v.propertyRented.x, v.propertyRented.y, v.propertyRented.z)) < 1.2 then
								ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour ranger votre véhicule dans ~HUD_COLOUR_WAYPOINT~"..v.propertyLabel)
								if IsControlJustPressed(1, 51) then
									if IsPedSittingInAnyVehicle(PlayerPedId()) then 
										TriggerServerEvent("Property:AddVehicleIntoGarage", v.propertyID, getVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false)), GetVehicleLabel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))))
									else
										ESX.ShowNotification("~HUD_COLOUR_WAYPOINT~Vous devez être dans un véhicule pour effectuer cette action.")
									end
								end                                
							end 
						end
					end
				end
			end
			if InGarage == true then 
				for k,v in pairs(myProperties) do 
					for t,b in pairs(Config.GarageInteriors) do 
						if #(pCoords - b.Exit) < 15.0 then
							OnMarker = true
							DrawMarker(2, b.Exit, 0, 0, 0, 0, 0, 0, 0.25, 0.25, 0.25, 119,0,255,200, 1, 0, 0, 2)
						end
						if #(pCoords - b.Exit) < 1.2 then
							ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour sortir du garage.")
							if IsControlJustPressed(1, 51) then
								ExitProperty(v.propertyID)
							end                                
						end 
						if not InVisit then 
							if #(pCoords - b.Computer) < 15.0 then
								OnMarker = true
								DrawMarker(2, b.Computer, 0, 0, 0, 0, 0, 0, 0.25, 0.25, 0.25, 119,0,255,200, 1, 0, 0, 2)
							end
							if #(pCoords - b.Computer) < 1.2 then
								ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder à la ~HUD_COLOUR_WAYPOINT~gestion~s~ de votre garage.")
								if IsControlJustPressed(1, 51) then
									TriggerServerEvent("Property:GetVehiclesProperties", v.propertyID)
								end                                
							end
						end
					end
				end
				for k,v in pairs (myVehicles) do 
					if IsPedSittingInAnyVehicle(PlayerPedId()) then
						if v.plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)) then 
							OnMarker = true 
							CurrentVehicles = GetVehiclePedIsIn(PlayerPedId(), false)
							PropertiesOfVehicle = getVehicleProps(CurrentVehicles)
							ESX.ShowHelpNotification(("Appuyez sur ~INPUT_PICKUP~ pour sortir avec ~HUD_COLOUR_WAYPOINT~%s~s~."):format(GetVehicleLabel(PropertiesOfVehicle.model)))
							if IsControlJustPressed(1, 51) then 
								ExitGarageWithVehicle(PropertiesOfVehicle)          
							end
						end               
					end
				end
			end
			if InProperty == true then 
				for k,v in pairs (myProperties) do 
					for t,b in pairs (UsersInfos) do
						if v.propertyOwner == b.identifier then  
							OnMarker = true 
							if IsControlJustPressed(0, 344) then
								TriggerServerEvent("Property:OpenOwnerList", v.propertyID)
							end
						end
					end
					for _, interior in pairs(Config.PropertiesInteriors) do 
						if v.propertyInteriors == interior.IdType then 
							if #(pCoords - interior.Exit) < 15.0 then
								OnMarker = true
								DrawMarker(1, interior.Exit, 1, 1, 1, 0, 0, 0, 0.75, 0.75, 0.75, 119,0,255,200, 0, 0, 0, 2)
							end
						end
						if #(pCoords - interior.Exit) < 1.2 then
							ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour sortir de la proprieté.")
							if IsControlJustPressed(1, 51) then
								TriggerEvent("Property:OpenGestionMenu", v.propertyID)
							end                                
						end 
						if not InVisit then 
							if #(pCoords - interior.Storage) < 15.0 then
								OnMarker = true
								DrawMarker(1, interior.Exit, 1, 1, 1, 0, 0, 0, 0.75, 0.75, 0.75, 119,0,255,200, 0, 0, 0, 2)
							end
							if #(pCoords - interior.Storage) < 1.2 then
								ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder au coffre.")
								if IsControlJustPressed(1, 51) then
									TriggerEvent("Property:OpenStorageMenu", v.propertyID)
								end                                
							end 
						end
					end
				end
			end
		end
        if OnMarker then
            Wait(1)
        else
            Wait(500)
        end
    end
end)
