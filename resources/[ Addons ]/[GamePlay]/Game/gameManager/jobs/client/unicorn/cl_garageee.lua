-- -- MENU FUNCTION --

-- local open = false 
-- local unicornDeTesMort = RageUI.CreateMenu('', 'Garage Unicorn')
-- unicornDeTesMort.Display.Header = true 
-- unicornDeTesMort.Closed = function()
--   open = false
-- end

-- function OpenTesMortunicorn()
--      if open then 
--          open = false
--          RageUI.Visible(unicornDeTesMort, false)
--          return
--      else
--          open = true 
--          RageUI.Visible(unicornDeTesMort, true)
--          CreateThread(function()
--          while open do 
--           local PosMenuUnicorn = vector3(144.19,-1284.94,29.32)
--           local ped = GetEntityCoords(PlayerPedId())
--           local dist = #(ped - PosMenuUnicorn)
--           if dist >= 5 then
--               RageUI.CloseAll()
--           else
--           end
--             RageUI.IsVisible(unicornDeTesMort,function() 

--               RageUI.Button("Ranger le véhicule", nil, {RightLabel = "→→"}, true , {
--                 onSelected = function()
--                   local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
--                 if dist4 < 5 then
--                       DeleteEntity(veh)
--                       RageUI.CloseAll()
--                       ESX.ShowNotification("~g~Véhicule supprimer avec succès !")
--                 else
--                         ESX.ShowNotification("~r~Véhicule trop loins !")
--                 end
--               end, })

-- -- test
--                RageUI.Separator("↓ ~y~Gestion Véhicule ~s~ ↓")

--                 RageUI.Button("Véhicule de Fonction", nil, {RightLabel = "→→"}, true , {
--                     onSelected = function()
--                         ESX.Game.SpawnVehicle('stretch', vector3(161.93,-1283.09,29.08), 145.59, function (vehicle)
--                           local newPlate = GeneratePlate()
--                           SetVehicleNumberPlateText(vehicle, newPlate)
--                           SetVehicleFuelLevel(vehicle, 100.0)
--                           TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
--                           TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
--                         end)
--                     end
--                 })

--            end)
--           Wait(0)
--          end
--       end)
--    end
-- end

-- ----OUVRIR LE MENU------------

-- local position = {
-- 	{x = 144.19, y = -1284.94, z = 29.32}
-- }

-- CreateThread(function()
--   while true do

--       local wait = 1000

--         for k in pairs(position) do
--         if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
--             local plyCoords = GetEntityCoords(PlayerPedId(), false)
--             local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

--             if dist <= 15.0 then
--             wait = 0
--             DrawMarker(36, 144.19,-1284.94,29.32, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.3, 1.3, 1.3,250,0,255, 255, true, true, p19, true)  

        
--             if dist <= 1.0 then
--                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage.")
--                 if IsControlJustPressed(1,51) then
--                   OpenTesMortunicorn()
--             end
--         end
--     end
--     end
--     end
--     Wait(wait)
--   end
-- end)
