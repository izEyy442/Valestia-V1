--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Utils = {};
Utils.Valestia = {};
Utils.Write = print

Utils.Valestia.ShowNotification = function(msg, hudColorIndex)
	AddTextEntry('ShowNotification', msg)
	BeginTextCommandThefeedPost('ShowNotification')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostTicker(false, true)
end

Utils.Valestia.ShowHelpNotification = function(msg)
    AddTextEntry('HelpNotification', msg)
	BeginTextCommandDisplayHelp('HelpNotification')
    EndTextCommandDisplayHelp(0, false, true, -1)
end

Utils.Valestia.Draw3DText = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Utils.Valestia.SetParticle = function()
	Citizen.CreateThread(function()
		RequestNamedPtfxAsset(dict2)
		while not HasNamedPtfxAssetLoaded(dict2) do
			Citizen.Wait(0)
		end
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped, true))
		local a = 0
		while a < 25 do
			UseParticleFxAssetNextCall(dict2)
			StartParticleFxNonLoopedAtCoord(particleName2, x, y, z, 1.50, 1.50, 1.50, 1.50, false, false, false)
			SetParticleFxLoopedColour(0, 255, 255, 255, 0)
			a = a + 1
			break
			Citizen.Wait(500)
		end
	end)
end

Utils.Valestia.RefreshPlayerData = function()
    Citizen.CreateThread(function()
        ESX.PlayerData = ESX.GetPlayerData()
    end)
end

Utils.Valestia.startAnim = function(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 2.0, 2.0, -1, 51, 0, false, false, false)
	end)
end

Utils.Valestia.input = function(TextEntry, ExampleText, MaxStringLenght, isValueInt)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        if isValueInt then
            local isNumber = tonumber(result)
            if isNumber then
                return result
            else
                return nil
            end
        end

        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

Utils.Valestia.GetCurrentWeight = function()
	local currentWeight = 0

	for i = 1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].count > 0 then
			currentWeight = currentWeight + (ESX.PlayerData.inventory[i].weight * ESX.PlayerData.inventory[i].count)
		end
	end

	return currentWeight
end

Utils.Valestia.DrawSubtitle = function(text, time)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(time and math.ceil(time) or 0, true)
end

Utils.Valestia.ExitVehicle = function(pos, vehicle, plate, heading)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = pos.x,
		y = pos.y,
		z = pos.z 
	}, heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
        FreezeEntityPosition(PlayerPedId(), false)
	end)

	TriggerServerEvent('garage:modifyState', vehicle, false)
end

CEvent = {};
CEvent.Valestia = {};
CEvent.Valestia.Call = {};
CEvent.Valestia.Call.ClientSideEvent = TriggerEvent
CEvent.Valestia.Call.ServerSideEvent = TriggerServerEvent