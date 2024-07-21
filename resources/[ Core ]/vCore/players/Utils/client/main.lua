ESX = exports["Framework"]:getSharedObject();

local numbers = 0.1
local players = 0;
local pedPerPlayer = {
	{
		multiplier=0.5,
		players=5
	},
	{
		multiplier=0.4,
		players=50
	},
	{
		multiplier=0.3,
		players=75
	},
	{
		multiplier=0.1,
		players=100
	},
	{
		multiplier=0.0,
		players=150
	}
};

RegisterCommand("getpedmultiplier", function()
	ESX.Logs.Debug({
		players = players,
		numbers = numbers
	});
end);

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
	while PlayerPedId() == nil do Wait(20) end
	local playerId = playerId
	local PNJZone = {}

	CreateThread(function()
		while true do
			ESX.TriggerServerCallback("pnj:getPlayerCount", function(count)
				players = count;
			end);
			Wait(10000);
		end
	end);

	---@return number
	local function estimateMultiplier()
		numbers = 0.5;
		for i = 1, #pedPerPlayer do
			if players > pedPerPlayer[i].players then
				numbers = pedPerPlayer[i].multiplier;
			end
		end
	end

	CreateThread(function()
		while true do
			estimateMultiplier();

			local pCoords = GetEntityCoords(pPed)
			for k,v in pairs(PNJZone) do
				local dst = GetDistanceBetweenCoords(pCoords, v, false)
				if dst <= 30.0 then
					numbers = 0.0
				end
			end

			SetPoliceIgnorePlayer(playerId, true)
			SetEveryoneIgnorePlayer(playerId, true)
			SetPlayerTargetingMode(3)
			SetVehicleDensityMultiplierThisFrame(numbers)
       		SetRandomVehicleDensityMultiplierThisFrame(numbers)
	    	SetParkedVehicleDensityMultiplierThisFrame(0.0)
	    	SetPedDensityMultiplierThisFrame(0.5)
	    	SetScenarioPedDensityMultiplierThisFrame(0.5, 0.5)
			SetPedSuffersCriticalHits(PlayerPedId(), false)
			Wait(0)
		end
	end)

	for i = 1, #(ConfigPNJ.RemoveHudCommonents) do
		if ConfigPNJ.RemoveHudCommonents[i] then
			SetHudComponentPosition(i, 999999.0, 999999.0)
		end
	end

	local weaponPickups = {"PICKUP_WEAPON_CARBINERIFLE", "PICKUP_WEAPON_PISTOL", "PICKUP_WEAPON_PUMPSHOTGUN"}
	for i = 1, #weaponPickups do
		ToggleUsePickupsForPlayer(playerId, weaponPickups[i], false)
	end

	for _, model in pairs(ConfigPNJ.SuppressedVehiclesModels) do
		SetVehicleModelIsSuppressed(model, true)
	end

	for i = 1, 15 do
		EnableDispatchService(i, false)
	end

    -- Disable Weapon AutoSwap
    SetWeaponsNoAutoswap(true)
    DisablePlayerVehicleRewards(playerId)
	ClearPlayerWantedLevel(playerId)
	SetMaxWantedLevel(0)
    SetPedCanBeDraggedOut(PlayerPedId(), false)
	SetCreateRandomCopsNotOnScenarios(false)
	SetCreateRandomCops(false)
    SetDispatchCopsForPlayer(playerId, false)

    SetRadarAsExteriorThisFrame()
    SetRadarAsInteriorThisFrame(GetHashKey("h4_fake_islandx"), vec(4700.0, -5145.0), 0, 0)

	-- Disable Scenarios
	local scenarios = {
		'WORLD_VEHICLE_ATTRACTOR',
		'WORLD_VEHICLE_AMBULANCE',
		'WORLD_VEHICLE_BICYCLE_BMX',
		'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',
		'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',
		'WORLD_VEHICLE_BICYCLE_BMX_HARMONY',
		'WORLD_VEHICLE_BICYCLE_BMX_VAGOS',
		'WORLD_VEHICLE_BICYCLE_MOUNTAIN',
		'WORLD_VEHICLE_BICYCLE_ROAD',
		'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
		'WORLD_VEHICLE_BIKER',
		'WORLD_VEHICLE_BOAT_IDLE',
		'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
		'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
		'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
		'WORLD_VEHICLE_BROKEN_DOWN',
		'WORLD_VEHICLE_BUSINESSMEN',
		'WORLD_VEHICLE_HELI_LIFEGUARD',
		'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
		'WORLD_VEHICLE_CONSTRUCTION_SOLO',
		'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
		'WORLD_VEHICLE_DRIVE_PASSENGERS',
		'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
		'WORLD_VEHICLE_DRIVE_SOLO',
		'WORLD_VEHICLE_FIRE_TRUCK',
		'WORLD_VEHICLE_EMPTY',
		'WORLD_VEHICLE_MARIACHI',
		'WORLD_VEHICLE_MECHANIC',
		'WORLD_VEHICLE_MILITARY_PLANES_BIG',
		'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
		'WORLD_VEHICLE_PARK_PARALLEL',
		'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
		'WORLD_VEHICLE_PASSENGER_EXIT',
		'WORLD_VEHICLE_POLICE_BIKE',
		'WORLD_VEHICLE_POLICE_CAR',
		'WORLD_VEHICLE_POLICE',
		'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
		'WORLD_VEHICLE_QUARRY',
		'WORLD_VEHICLE_SALTON',
		'WORLD_VEHICLE_SALTON_DIRT_BIKE',
		'WORLD_VEHICLE_SECURITY_CAR',
		'WORLD_VEHICLE_STREETRACE',
		'WORLD_VEHICLE_TOURBUS',
		'WORLD_VEHICLE_TOURIST',
		'WORLD_VEHICLE_TANDL',
		'WORLD_VEHICLE_TRACTOR',
		'WORLD_VEHICLE_TRACTOR_BEACH',
		'WORLD_VEHICLE_TRUCK_LOGS',
		'WORLD_VEHICLE_TRUCKS_TRAILERS',
		'WORLD_VEHICLE_DISTANT_EMPTY_GROUND',
		'WORLD_HUMAN_PAPARAZZI'
	}

	for i, v in pairs(scenarios) do
		SetScenarioTypeEnabled(v, false)
	end
end)