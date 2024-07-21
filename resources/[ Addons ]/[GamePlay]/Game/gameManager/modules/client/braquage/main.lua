--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local holdingup = false
local holdingup2 = false
local bank = ''
local store = ""
local secondsRemaining = 0
local blipRobbery = nil
local vetrineRotte = 0 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentSubstringPlayerName(str)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_holdupbank:currentlyrobbing')
AddEventHandler('esx_holdupbank:currentlyrobbing', function(robb)
	holdingup = true
	bank = robb
	secondsRemaining = 900
end)

RegisterNetEvent('esx_holdupbank:killblip')
AddEventHandler('esx_holdupbank:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdupbank:setblip')
AddEventHandler('esx_holdupbank:setblip', function(position)
	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
	
    SetBlipSprite(blipRobbery, 161)
    SetBlipScale(blipRobbery, 2.0)
	SetBlipColour(blipRobbery, 3)

    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdupbank:toofarlocal')
AddEventHandler('esx_holdupbank:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowAdvancedNotification('Notification', "Braquage", "Braquage annulé", 'CHAR_CALL911', 8)
	robbingName = ""
	secondsRemaining = 900 -- 0
	incircle = false
end)


RegisterNetEvent('esx_holdupbank:robberycomplete')
AddEventHandler('esx_holdupbank:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowAdvancedNotification('Notification', "Braquage", "Braquage complété" .. Banks[bank].reward, 'CHAR_CALL911', 8)
	bank = ""
	secondsRemaining = 900 -- 0
	incircle = false
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
	end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Banks) do
		local blip = AddBlipForCoord(v.position)

		SetBlipSprite(blip, 255)
		SetBlipScale(blip, 0.6)
		SetBlipColour(blip, 75)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("[Illégal] Braquage de banque")
		EndTextCommandSetBlipName(blip)
	end
end)

incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(PlayerPedId(), false)

		for k, v in pairs(Banks) do
			if Vdist(pos, v.position) < 15.0 then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1.05, 0, 0, 0, 0, 0, 0, 1.50, 1.50, 1.00, 0, 255, 0,45,110,185, 0,0)

					if Vdist(pos, v.position) < 1.5 then
						if not incircle then
							DisplayHelpText("Appuyez pour braquer " .. v.nameofbank)
						end

						incircle = true

						if IsControlJustReleased(0, 51) then
							TriggerServerEvent('esx_holdupbank:rob', k)
						end
					elseif Vdist(pos, v.position) > 1.5 then
						incircle = false
					end
				end
			end
		end

		if holdingup then
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, "braquage de banque: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" .. secondsRemaining .. " secondes restantes", 255, 255, 255, 255)

			if Vdist(pos, Banks[bank].position) > 7.5 then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
			end
		end

		Citizen.Wait(1)
	end
end)

-- Bijouterie
local vetrine = {
	{x = 147.085, y = -1048.612, z = 29.346, heading = 70.326, isOpen = false},--
	{x = -1392.9639, y = -249.4319, z = 43.1555, heading = 134.2458, isOpen = false},--
	{x = -1394.6594, y = -247.5043, z = 43.1555, heading = 134.9916, isOpen = false},--
	{x = -1392.1113, y = -243.2257, z = 43.1555, heading = 316.4457, isOpen = false},-- 
	{x = -1388.6902, y = -247.1196, z = 43.1555, heading = 308.0808, isOpen = false},-- 
	{x = -1384.6968, y = -250.7005, z = 43.1555, heading = 313.5320, isOpen = false},--
	{x = -1391.1570, y = -251.3725, z = 43.1555, heading = 128.8745, isOpen = false},--
	{x = -1395.4664, y = -239.0948, z = 43.1555, heading = 312.6419, isOpen = false},--
	{x = -1394.7067, y = -254.6446, z = 43.1555, heading = 310.0843, isOpen = false},--
	{x = -1396.4669, y = -252.7156, z = 43.1555, heading = 305.6978, isOpen = false},--
	{x = -1398.2228, y = -250.7012, z = 43.1555, heading = 307.1600, isOpen = false},--
	{x = -1403.0396, y = -253.3981, z = 43.1555, heading = 132.1705, isOpen = false},--
	{x = -1399.3763, y = -257.0967, z = 43.1555, heading = 132.2299, isOpen = false},--
	{x = -1406.6555, y = -249.5174, z = 43.1555, heading = 134.3685, isOpen = false},-- 
	{x = -1386.3031, y = -260.3615, z = 43.1555, heading = 220.5887, isOpen = false},--
	{x = -1390.2178, y = -263.8332, z = 43.1555, heading = 223.2117, isOpen = false},--
	{x = -1394.1943, y = -267.2193, z = 43.1555, heading = 224.4639, isOpen = false},--
	{x = -1399.6355, y = -262.2678, z = 43.1555, heading = 42.6601, isOpen = false},-- 
	{x = -1394.5752, y = -248.2951, z = 38.8324, heading = 223.8550, isOpen = false},--
	{x = -1396.3966, y = -249.8178, z = 38.8324, heading = 220.1006, isOpen = false},--
	{x = -1398.0126, y = -251.5360, z = 38.8324, heading = 219.5005, isOpen = false},-- 
}

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

end

function DisplayHelpTextRobbery(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('esx_vangelico_robbery:currentlyrobbing')
AddEventHandler('esx_vangelico_robbery:currentlyrobbing', function(robb)
	holdingup2 = true
	store = robb
end)

RegisterNetEvent('esx_vangelico_robbery:killblip')
AddEventHandler('esx_vangelico_robbery:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_vangelico_robbery:setblip')
AddEventHandler('esx_vangelico_robbery:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_vangelico_robbery:toofarlocal')
AddEventHandler('esx_vangelico_robbery:toofarlocal', function(robb)
	holdingup2 = false
	ESX.ShowAdvancedNotification('Notification', "Braquage", "Braquage annulé", 'CHAR_CALL911', 8)
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('esx_vangelico_robbery:robberycomplete')
AddEventHandler('esx_vangelico_robbery:robberycomplete', function(robb)
	holdingup2 = false
	ESX.ShowAdvancedNotification('Notification', "Braquage", "Braquage complété", 'CHAR_CALL911', 8)
	store = ""
	incircle = false
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position2

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 617)
		SetBlipScale(blip, 0.6)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("[Illégal] Braquage de Bijouterie")
		EndTextCommandSetBlipName(blip)
	end
end)

animazione = false
incircle = false
soundid = GetSoundId()

function drawTxt2(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.64, 0.64)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(0.155, 0.935)
end

--local borsa = nil

--[[Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)
	  TriggerEvent('skinchanger:getSkin', function(skin)
		borsa = skin['bags_1']
	  end)
	  Citizen.Wait(1000)
	end
end)]]

Citizen.CreateThread(function()
      
	while true do
		local pos = GetEntityCoords(PlayerPedId(), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position2

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup2 then
					DrawMarker(27, v.position2.x, v.position2.y, v.position2.z-0.9, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 45,110,185, 200, 0, 0, 0, 0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText("Tirer pour démarrer le braquage")
						end
						incircle = true
						if IsPedShooting(PlayerPedId()) then
							if ConfigBraco.NeedBag then
							    --if borsa == 40 or borsa == 41 or borsa == 44 or borsa == 45 then
							        ESX.TriggerServerCallback('esx_vangelico_robbery:conteggio', function(CopsConnected)
								        if CopsConnected >= ConfigBraco.RequiredCopsRob then
							                TriggerServerEvent('esx_vangelico_robbery:rob', k)
								        else
									        TriggerEvent('esx:showNotification', "Besoin de: " .. ConfigBraco.RequiredCopsRob .. " policiers pour braquer")
								        end
							        end)		
						       -- else
							        --TriggerEvent('esx:showNotification', _U('need_bag'))
								--end
							else
								ESX.TriggerServerCallback('esx_vangelico_robbery:conteggio', function(CopsConnected)
									if CopsConnected >= ConfigBraco.RequiredCopsRob then
										TriggerServerEvent('esx_vangelico_robbery:rob', k)
									else
										TriggerEvent('esx:showNotification', "Besoin de: " .. ConfigBraco.RequiredCopsRob .. " policiers pour braquer")
									end
								end)	
							end	
                        end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end		
				end
			end
		end

		if holdingup2 then
			drawTxt2(0.3, 1.4, 0.45, "Briser la vitrine" .. ' :~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ ' .. vetrineRotte .. '/' .. ConfigBraco.MaxWindows, 185, 185, 185, 255)

			for i,v in pairs(vetrine) do 
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 10.0) and not v.isOpen and ConfigBraco.EnableMarker then 
					DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 0, 0, 255, 200, 1, 1, 0, 0)
				end
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 0.75) and not v.isOpen then 
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour voler les bijoux")
					if IsControlJustPressed(0, 51) then
						animazione = true
					    SetEntityCoords(PlayerPedId(), v.x, v.y, v.z-0.95)
					    SetEntityHeading(PlayerPedId(), v.heading)
						v.isOpen = true 
						PlaySoundFromCoord(-1, "Glass_Smash", v.x, v.y, v.z, "", 0, 0, 0)
					    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
					    RequestNamedPtfxAsset("scr_jewelheist")
					    end
					    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
					    Citizen.Wait(0)
					    end
					    SetPtfxAssetNextCall("scr_jewelheist")
					    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", v.x, v.y, v.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
					    loadAnimDict( "missheist_jewel" ) 
						TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
						TriggerEvent("mt:missiontext", "Collection en cours", 3000)
					    --DisplayHelpText(_U('collectinprogress'))
					    DrawSubtitleTimed(5000, 1)
					    Citizen.Wait(5000)
					    ClearPedTasksImmediately(PlayerPedId())
					    TriggerServerEvent('esx_vangelico_robbery:gioielli')
					    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					    vetrineRotte = vetrineRotte+1
					    animazione = false

						if vetrineRotte == ConfigBraco.MaxWindows then 
						    for i,v in pairs(vetrine) do 
								v.isOpen = false
								vetrineRotte = 0
							end
							TriggerServerEvent('esx_vangelico_robbery:endrob', store)
							ESX.ShowAdvancedNotification('Notification', "Braquage", "Vous avez braqué la bijouterie! Maintenant, allez revendre les bijoux", 'CHAR_CALL911', 8)
						    holdingup2 = false
						    StopSound(soundid)
						end
					end
				end
			end


			local pos2 = Stores[store].position2

			if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1393.7194, -252.2722, 43.1556, true) > 31.5 ) then
				TriggerServerEvent('esx_vangelico_robbery:toofar', store)
				holdingup2 = false
				for i,v in pairs(vetrine) do 
					v.isOpen = false
					vetrineRotte = 0
				end
				StopSound(soundid)
			end

		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
      
	while true do
		Wait(1)
		if animazione == true then
			if not IsEntityPlayingAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 3) then
				TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false)
			end
		end
	end
end)

blip = false

CreateThread(function()
	while true do
		Wait(1);
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1164.6614, -2022.2856, 13.1605, true) <= 10 and not blip then
			DrawMarker(20, -1164.6614, -2022.2856, 13.1605, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 100, 102, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -1164.6614, -2022.2856, 13.1605, true) < 1.0 then
				DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~  pour vendre")
				if IsControlJustReleased(1, 51) then
					blip = true;
					TriggerServerEvent('vCore3:ClaquetteChausette');
				end
			end
		end
	end
end)

RegisterNetEvent('vCore3:ClaquetteChausetteV2', function()
	blip = false; --"Pas asser de policier pour vendre: " .. ConfigBraco.RequiredCopsSell .. " policiers requis"
end);

