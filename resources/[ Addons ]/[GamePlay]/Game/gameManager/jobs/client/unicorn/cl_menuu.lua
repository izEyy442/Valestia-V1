-- -- MENU FUNCTION --

-- local open = false 
-- local unicornMain2 = RageUI.CreateMenu('', 'Unicorn')
-- local subMenu5 = RageUI.CreateSubMenu(unicornMain2, "Annonces", "Interaction")
-- unicornMain2.Display.Header = true 
-- unicornMain2.Closed = function()
--   open = false
-- end

-- function KeyboardInputUnicorn(entryTitle, textEntry, inputText, maxLength)
--     AddTextEntry(entryTitle, textEntry)
--     DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
  
--     while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
--       Citizen.Wait(0)
--     end
  
--     if UpdateOnscreenKeyboard() ~= 2 then
--       local result = GetOnscreenKeyboardResult()
--       return result
--     else
--       return nil
--     end
-- end

-- RegisterNetEvent("Unicorn:StartBoucleMoney")
-- AddEventHandler("Unicorn:StartBoucleMoney", function()
--     StartInitMoneyYamok()
-- end)

-- CoordsThrowing = {
--     vector3(123.86, -1288.10, 28.44),
--     vector3(123.25, -1291.75, 28.44),
--     vector3(120.17, -1287.36, 28.44)
-- }

-- function StartInitMoneyYamok()
--     initthrowingbillet = true
--     Citizen.CreateThread(function()
--         while initthrowingbillet do
--             Wait(0)
--             local ped = PlayerPedId()
--             local pedcoords = GetEntityCoords(ped, false)
--             for k,v in pairs(CoordsThrowing) do
--                 local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, v)
--                 DrawMarker(29, v, 0, 0, 0, 180.0,nil,nil, 0.3, 0.3, 0.3,250,0,255, 255, false, true, nil, true)
--                 if distance <= 1.5 then
--                     ESX.ShowHelpNotification('Appuyez sur ~INPUT_PICKUP~ pour jeter de l\'argent à la stripteaseuse.')
--                     if IsControlJustPressed(0, 51) then
--                         ThrowMoney(v)
--                     end
--                 end
--             end
--         end
--     end)
-- end

-- local society = {
--     label = "Unicorn",
--     name = "unicornjob",
-- }


-- function ThrowMoney(zone)
--     RequestNamedPtfxAsset("core")
--     cash = CreateObject(GetHashKey("prop_cash_pile_01"), 0, 0, 0, false, true, true) 
--     AttachEntityToEntity(cash, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.12, 0.028, 0.001, 300.00, 180.0, 20.0, true, true, false, true, 1, true)
--     local lib, anim = 'anim@mp_player_intcelebrationfemale@raining_cash', 'raining_cash' do
--     Citizen.Wait(900)
--     ESX.Streaming.RequestAnimDict(lib, function()
--     TaskPlayAnim(PlayerPedId(), lib, anim, 8.0 , -1 , -1 , 0 , 0 , false , false , false);
--     Citizen.Wait(1000)
--     UseParticleFxAssetNextCall("core")
--     local fx = StartParticleFxNonLoopedOnEntity("ent_brk_banknotes", PlayerPedId(), 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, false, false, false)  --(effectName, entity, offsetX, offsetY, offsetZ, rotX, rotY, rotZ, scale, axisX, axisY, axisZ);
--         end)
--     end
--     TriggerServerEvent('Unicorn:PayStrip')
--     Citizen.Wait(4000)
--     DeleteEntity(cash)
--     Citizen.Wait(1000)
--     --FS.TriggerServerEvent("Core:AddMoneyBusiness", zone, "deposit", society, "cash", 1000)
-- end

-- local IndexStrip = 1

-- RegisterNetEvent("Unicorn:StartStrip")
-- AddEventHandler("Unicorn:StartStrip", function()
--     local model = GetHashKey("csb_stripper_01")
--     RequestModel(model)
--     while not HasModelLoaded(model) do
--         Wait(10)
--     end
--     npc = CreatePed(1, "csb_stripper_01", 106.7979, -1298.4333, 29.2189, 294.7011, false, true)
--     PedToNet(npc)
--     SetEntityInvincible(npc, true)
--     SetBlockingOfNonTemporaryEvents(npc, true)
--     TaskGoToCoordAnyMeans(npc, 122.0026, -1289.3020, 29.2189, 134.4331)
--     Wait(3000)
--     RequestAnimDict("mini@strip_club@pole_dance@pole_dance3")
--     while not HasAnimDictLoaded("mini@strip_club@pole_dance@pole_dance3") do
--         Citizen.Wait(100)
--     end
--     netScene3 = CreateSynchronizedScene(122.18, -1288.99, 29.21, vec3(0.0, 0.0, 0.0), 2)
--     TaskSynchronizedScene(npc, netScene3, "mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", 1.0, -4.0, 261, 0, 0)
--     SetSynchronizedSceneLooped(netScene, 1)
--     SetModelAsNoLongerNeeded(model)
--     inscene = true
-- end)

-- RegisterNetEvent("Unicorn:StopStrip")
-- AddEventHandler("Unicorn:StopStrip", function()
--     ClearPedTasksImmediately(npc)
--     TaskGoToCoordAnyMeans(npc, 99.95526, -1294.306, 29.26352, 265.902+180, 0, 0, 786603, 1.0)
--     Wait(5000)
--     DeleteEntity(npc)
-- 	inscene = false
-- 	initthrowingbillet = false
-- end)

-- function OpenMenuunicorn()
-- 	if open then 
-- 		open = false
-- 		RageUI.Visible(unicornMain2, false)
-- 		return
-- 	else
-- 		open = true 
-- 		RageUI.Visible(unicornMain2, true)
-- 		CreateThread(function()
-- 		while open do 
-- 		   RageUI.IsVisible(unicornMain2,function() 

-- 			RageUI.Separator("↓ Annonce Unicorn ↓")
-- 			RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, {RightLabel = "→"}, true , {
-- 				onSelected = function()
-- 					TriggerServerEvent('Ouvre:unicorn')
-- 				end
-- 			})

-- 			RageUI.Button("Annonce ~r~[Fermetures]~r~", nil, {RightLabel = "→"}, true , {
-- 				onSelected = function()
-- 					TriggerServerEvent('Ferme:unicorn')
-- 				end
-- 			})

-- 			RageUI.Button("Annonce ~p~[Recrutement]", nil, {RightLabel = "→"}, true , {
-- 				onSelected = function()
-- 					TriggerServerEvent('Recrutement:unicorn')
-- 				end
-- 			})
			
-- 			RageUI.Separator("↓ Facture ↓")
-- 			RageUI.Button("Faire une ~p~Facture", nil, {RightLabel = "→"}, true , {
--                 onSelected = function()
--                     local montant = KeyboardInputPolice("Montant:", 'Indiquez un montant', '', 6)
-- 					local amount = 0;
--                     if tonumber(montant) == nil then
--                         ESX.ShowNotification("Montant invalide")
--                         return false
--                     else
--                         amount = (tonumber(montant))
--                         local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
-- 						if closestPlayer == -1 or closestDistance > 3.0 then
-- 							ESX.ShowNotification('~r~Personne autour de vous')
-- 						else
--               ESX.ShowNotification("~g~Facture envoyée avec succès !")
-- 							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'unicorn', 'Unicorn', amount)
-- 						end
--                     end
--                 end
--             })

-- 			RageUI.Separator("↓ Activité ↓")
-- 			RageUI.List("Stripteaseuse", {"~p~Faire danser sur scène~s~", "~p~Dire d'arrêter~s~"}, IndexStrip, nil, {}, true, {
-- 				onListChange = function(Index)
-- 					IndexStrip = Index
-- 				end,
-- 				onSelected = function(Index)
-- 					if Index == 1 then
-- 						if not called and not inscene then
-- 							ESX.ShowNotification("Vous avez activé le lancé de billet !")
-- 							TriggerServerEvent("Unicorn:StartDance")
-- 							called = true
							
-- 						else
-- 							ESX.ShowNotification("~r~Veuillez attendre qu'elle se mette en place")
-- 						end
-- 					elseif Index == 2 then
-- 						if called and inscene then
-- 							ESX.ShowNotification("~r~Vous avez desactivé le lancé de billet !")
-- 							TriggerServerEvent("Unicorn:StopDance")
-- 							called = false
-- 						else
-- 							ESX.ShowNotification("~r~Veuillez attendre qu'elle se mette en place")
-- 						end
-- 					end
-- 				end
-- 			})
-- 			end)

-- 		 Wait(0)
-- 		end
-- 	 end)
--   end
-- end




-- -- FUNCTION BILLING --

-- function OpenBillingMenu2()

-- 	ESX.UI.Menu.Open(
-- 	  'dialog', GetCurrentResourceName(), 'billing',
-- 	  {
-- 		title = "Facture"
-- 	  },
-- 	  function(data, menu)
	  
-- 		local amount = tonumber(data.value)
-- 		local player, distance = ESX.Game.GetClosestPlayer()
  
-- 		if player ~= -1 and distance <= 3.0 then
  
-- 		  menu.close()
-- 		  if amount == nil then
-- 			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
-- 		  else
-- 			local playerPed        = PlayerPedId()
-- 			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
-- 			Citizen.Wait(5000)
--       ESX.ShowNotification("~g~Facture envoyé !")
--       TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(player), amount)
-- 			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'unicorn', ('unicorn'), amount)
-- 		  end
  
-- 		else
-- 		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
-- 		end
  
-- 	  end,
-- 	  function(data, menu)
-- 		  menu.close()
-- 	  end
-- 	)
--   end


--   Keys.Register('F6','InteractionsJobUnicorn', "Menu job Unicorn", function()
--     if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
--         if (not IsInPVP) then
--           OpenMenuunicorn()
--         end
--     end
-- end)