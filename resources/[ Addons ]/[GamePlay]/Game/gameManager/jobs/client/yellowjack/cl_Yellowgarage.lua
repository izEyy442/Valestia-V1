-- MENU FUNCTION --

local opening = false 
local yellowjackDeTesMort = RageUI.CreateMenu('', 'Garage Yellow Jack')
yellowjackDeTesMort.Display.Header = true 
yellowjackDeTesMort.Closed = function()
  opening = false
end

function openingTesMortyellowjack()
     if opening then 
         opening = false
         RageUI.Visible(yellowjackDeTesMort, false)
         return
     else
         opening = true 
         RageUI.Visible(yellowjackDeTesMort, true)
         CreateThread(function()
         while opening do 
          local PosMenuyellowjack = vector3(1999.35,3042.66,47.33)
          local ped = GetEntityCoords(PlayerPedId())
          local dist = #(ped - PosMenuyellowjack)
          if dist >= 5 then
              RageUI.CloseAll()
          else
          end
            RageUI.IsVisible(yellowjackDeTesMort,function() 

              RageUI.Button("Ranger le véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                if dist4 < 5 then
                      DeleteEntity(veh)
                      RageUI.CloseAll()
                      ESX.ShowNotification("~g~Véhicule supprimer avec succès !")
                else
                        ESX.ShowNotification("~r~Véhicule trop loins !")
                end
              end, })

-- test
               RageUI.Separator("↓ ~y~Gestion Véhicule ~s~ ↓")

                RageUI.Button("Véhicule de Fonction", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        ESX.Game.SpawnVehicle('speedo', vector3(1989.34,3032.12,47.05), 58.99, function (vehicle)
                          local newPlate = GeneratePlate()
                          SetVehicleNumberPlateText(vehicle, newPlate)
                          SetVehicleFuelLevel(vehicle, 100.0)
                          TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
                          TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        end)
                    end
                })

           end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = 1999.35, y = 3042.66, z = 47.33}
}

CreateThread(function()
  while true do

      local wait = 1000

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellowjack' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 15.0 then
            wait = 0
            DrawMarker(36, 1999.35,3042.66,47.33, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.3, 1.3, 1.3,250,0,255, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage.")
                if IsControlJustPressed(1,51) then
                  openingTesMortyellowjack()
            end
        end
    end
    end
    end
    Wait(wait)
  end
end)
