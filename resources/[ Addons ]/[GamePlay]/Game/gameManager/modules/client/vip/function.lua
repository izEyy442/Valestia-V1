--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

function tableHasKey(table,key)
    return table[key] ~= nil
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) 
	blockinput = true 

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		return result 
	else
		Citizen.Wait(500) 
		blockinput = false 
		return nil 
	end
end

function SpawnPed(pedname)
    local j1 = PlayerId()
    local p1 = GetHashKey(pedname)
    RequestModel(p1)
    while not HasModelLoaded(p1) do
        Wait(100)
    end
    SetPlayerModel(j1, p1)
    SetModelAsNoLongerNeeded(p1)
    isWPed = true
    -- Anti Spam
    TriggerEvent('esx:restoreLoadout')
    Citizen.Wait(250)
end


function SetCus(ped, componentId, drawableId, textureId, paletteId)
    SetPedComponentVariation(ped, componentId, drawableId, textureId, paletteId)
end

function SetProp(ped,componentId,drawableId,TextureId,attach)
    SetPedPropIndex(ped,componentId,drawableId,TextureId,attach)
end

function Clear(ped,propId)
    ClearPedProp(ped,propId)
end

function ParticleMaker(asset, nomanim, scale)
    local player = PlayerPedId()
    local PlayerCoords = GetEntityCoords(player)
    if not HasNamedPtfxAssetLoaded(asset) then
        RequestNamedPtfxAsset(asset)
        while not HasNamedPtfxAssetLoaded(asset) do
            Citizen.Wait(1)
        end
    end
    while true do
        Citizen.Wait(1)
        UseParticleFxAssetNextCall(asset)
        local part = StartParticleFxNonLoopedAtCoord(nomanim, PlayerCoords, 0.0, 0.0, 0.0, scale, false, false, false, false)
        Citizen.Wait(200)
        break
    end
end

function BourTonMarraineUnNeon(toggle)
    local me = PlayerPedId()
    local myCar = GetVehiclePedIsIn(me, false)
    SetVehicleNeonLightEnabled(myCar, 0, toggle)
    SetVehicleNeonLightEnabled(myCar, 1, toggle)
    SetVehicleNeonLightEnabled(myCar, 2, toggle)
    SetVehicleNeonLightEnabled(myCar, 3, toggle)
    SetVehicleNeonLightsColour(myCar, 222, 222, 222)
end

function ChangeCouleurNeon(r, g, b)
    local me = PlayerPedId()
    local myCar = GetVehiclePedIsIn(me, false)
    SetVehicleNeonLightsColour(myCar, r, g, b)
end

function ResetPed()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0

        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                Citizen.Wait(200)
                TriggerEvent('esx:restoreLoadout')
                isWPed = false
            end)
        end)
    end)
end

Advancednotif = function(title, subject, msg, icon, iconType)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    SetNotificationMessage(icon, icon, false, iconType, title, subject)
    DrawNotification(false, false)
end

ColoredNotif = function(msg, color)
	SetNotificationBackgroundColor(color)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end