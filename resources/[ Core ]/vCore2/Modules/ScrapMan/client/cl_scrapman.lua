local InJob = false
local scrap_type = nil
local Scrapsell = {{x= -512.01, y= -1738.1, z= 18.29}}
local Npc = {{x= -512.31, y= -1738.59, z= 18.3, h=324.46}}
local Scrappos = {
   {x= -507.06, y= -1741.13, z= 17.94},
   {x= -511.76, y= -1753.97, z= 17.9},
   {x= -501.03, y= -1746.44, z= 17.48},
}
CreateThread(function()
   while true do
      local ped = PlayerPedId()
      local plyCoords = GetEntityCoords(ped)
      local Interval = 1000

      for k in pairs(Scrappos) do

         local coord1 = vector3(plyCoords.x, plyCoords.y, plyCoords.z)
         local coord2 = vector3(Scrappos[k].x, Scrappos[k].y, Scrappos[k].z)
         local dist = #(coord1 - coord2)

         if (dist <= 10) then
            DrawMarker(20, Scrappos[k].x, Scrappos[k].y, Scrappos[k].z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.40, 0.40, 0.40, 255,255,255, 255, 55555, false, true, 2, false, false, false, false)  
            Interval = 0
            if not InJob then

               if dist <= 1.2 then
                  ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour prendre de la feraille")
                  if IsControlJustPressed(0,38) then
                     scrap()
                     InJob = true
                  end
               end
            end
         end
      end

      for k in pairs(Scrapsell) do
         local coord1 = vector3(plyCoords.x, plyCoords.y, plyCoords.z)
         local coord2 = vector3(Scrapsell[k].x, Scrapsell[k].y, Scrapsell[k].z)
         local dist = #(coord1 - coord2)

         if (dist <= 10) then
            Interval = 0
            if InJob then
               DrawMarker(20, Scrapsell[k].x, Scrapsell[k].y, Scrapsell[k].z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.40, 0.40, 0.40, 255,255,255, 255, 55555, false, true, 2, false, false, false, false)  
               if dist <= 1.2 then
                  ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour interagir avec l'action")
                  if IsControlJustPressed(0,38) then
                     TriggerServerEvent('sCore:scrap:sell')
                     DeleteEntity(scrap_type)
                     ClearPedTasks(ped)
                     InJob = false
                  end
               end
            end
         end
      end

      if IsEntityPlayingAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "player_search", 3) then
         DisableAllControlActions(0, true)
      end

      Wait(Interval)
    end
end)

CreateThread(function()
   for k in pairs(Npc) do
      RequestModel(GetHashKey("s_m_m_dockwork_01"))
      while not HasModelLoaded(GetHashKey("s_m_m_dockwork_01")) do
      Citizen.Wait(0)
      end
      local sell_npc =  CreatePed(4, GetHashKey("s_m_m_dockwork_01"), Npc[k].x, Npc[k].y, Npc[k].z, Npc[k].h, false, true)
      TaskStartScenarioInPlace(sell_npc, "WORLD_HUMAN_CLIPBOARD", 0, 1)
      FreezeEntityPosition(sell_npc, true)
      SetEntityHeading(sell_npc, Npc[k].h, true)
      SetEntityInvincible(sell_npc, true)
      SetBlockingOfNonTemporaryEvents(sell_npc, true)
   end
end)

function scrap()
   CreateThread(function()
      local impacts = 0
      local ped = PlayerPedId()
      local plyCoords = GetEntityCoords(PlayerPedId())
      local time = math.random(1,4)
      while impacts < 3 do
         FreezeEntityPosition(ped, true)
         LoadDict('anim@gangops@facility@servers@bodysearch@')  
         TaskPlayAnim(ped, 'anim@gangops@facility@servers@bodysearch@', 'player_search', 8.0, -8.0, -1, 48, 0)
         Wait(2500)
         ClearPedTasks(ped)
         impacts = impacts+1

         if impacts == 3 then
            FreezeEntityPosition(ped, false)
            impacts = 0
            TriggerServerEvent('scrapjob:scrap:find')
            ESX.ShowNotification("Vous avez trouvé un type de ferraille, allez-y pour vendre cette ferraille au revendeur à proximité")
            break
         end
      end

      if time == 1 then
         scrap_type = CreateObject(GetHashKey('prop_car_door_01'),plyCoords.x, plyCoords.y,plyCoords.z, true, true, true)
         AttachEntityToEntity(scrap_type , PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309),  0.025, 0.00, 0.355, -75.0, 470.0, 0.0, true, true, false, true, 1, true)
         LoadDict('anim@heists@box_carry@')
         TaskPlayAnim(ped, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
      elseif time == 2 then
         scrap_type = CreateObject(GetHashKey('prop_rub_monitor'),plyCoords.x, plyCoords.y,plyCoords.z, true, true, true)
         AttachEntityToEntity(scrap_type , PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309),  0.020, 0.00, 0.255, -70.0, 470.0, 0.0, true, true, false, true, 1, true)
         LoadDict('anim@heists@box_carry@')
         TaskPlayAnim(ped, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
      elseif time == 3 then
         scrap_type = CreateObject(GetHashKey('prop_car_seat'),plyCoords.x, plyCoords.y,plyCoords.z, true, true, true)
         AttachEntityToEntity(scrap_type , PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309),  0.020, 0.00, 0.255, -70.0, 470.0, 0.0, true, true, false, true, 1, true)
         LoadDict('anim@heists@box_carry@')
         TaskPlayAnim(ped, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
      else
         scrap_type = CreateObject(GetHashKey('prop_rub_tyre_03'),plyCoords.x, plyCoords.y,plyCoords.z, true, true, true)
         AttachEntityToEntity(scrap_type , PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309),  0.30, 0.35, 0.365, -045.0, 480.0, 0.0, true, true, false, true, 1, true)
         LoadDict('anim@heists@box_carry@')
         TaskPlayAnim(ped, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
      end
   end)
end

function LoadDict(dict)
   RequestAnimDict(dict)
   while not HasAnimDictLoaded(dict) do
      Wait(10)
   end
end
