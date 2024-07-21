--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

CreateThread(function()
	while true do
		if (NetworkIsPlayerActive(PlayerId()) and ESX) then
			ESX.Logs.Info("Valestia resource loading...");
			TriggerServerEvent('vCore3:UpdatePlayer');
			break;
		end
		Wait(0)
	end
end);

RegisterNetEvent("vCore3:ReloadPlayer", function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.Logs.Info("Valestia resource loaded.");
end);

local isFirstSpawn = true
local switchFinished = false

local function FreezePlayer(player, freeze)
	SetPlayerControl(player, not freeze, false)
	local ped = GetPlayerPed(player)

	if not freeze then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		if IsEntityVisible(ped) then
			SetEntityVisible(ped, false)
		end

		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end

RegisterNetEvent('spawnmanager:spawnPlayer')
AddEventHandler('spawnmanager:spawnPlayer', function(spawn)
	DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Citizen.Wait(0)
	end

	FreezePlayer(PlayerId(), true)
	RequestModel(spawn.model)

	while not HasModelLoaded(spawn.model) do
		RequestModel(spawn.model)
		Citizen.Wait(0)
	end

	SetPlayerModel(PlayerId(), spawn.model)
	SetModelAsNoLongerNeeded(spawn.model)

	RequestCollisionAtCoord(spawn.coords)
	local ped = PlayerPedId()

	SetEntityCoordsNoOffset(ped, spawn.coords, false, false, false, true)
	NetworkResurrectLocalPlayer(spawn.coords, spawn.heading, true, true, false)

	ClearPedTasksImmediately(ped)
	RemoveAllPedWeapons(ped)

	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		Citizen.Wait(0)
	end

	if isFirstSpawn then
		isFirstSpawn = false
		TriggerEvent("playerSpawned", spawn, true);

		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()

		FreezePlayer(PlayerId(), false)

		DoScreenFadeIn(2000)
		while not IsScreenFadedIn() do
			Citizen.Wait(0)
		end

		switchFinished = true;
	else
		FreezePlayer(PlayerId(), false)

		DoScreenFadeIn(500)
		while not IsScreenFadedIn() do
			Citizen.Wait(0)
		end

		TriggerEvent("playerSpawned", spawn, false);
	end
end)

-- changes the auto-spawn flag
function setAutoSpawn(enabled)
    autoSpawnEnabled = enabled
end

-- sets a callback to execute instead of 'native' spawning when trying to auto-spawn
function setAutoSpawnCallback(cb)
    autoSpawnCallback = cb
    autoSpawnEnabled = true
end

exports('setAutoSpawn', setAutoSpawn)
exports('setAutoSpawnCallback', setAutoSpawnCallback)

exports('isFirstSpawn', function()
	return isFirstSpawn
end)

exports('switchFinished', function()
	return switchFinished
end)