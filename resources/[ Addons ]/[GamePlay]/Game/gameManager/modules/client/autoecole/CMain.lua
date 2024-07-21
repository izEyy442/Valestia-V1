--[[
  This file is part of Valesia RolePlay.
  Copyright (c) Valesia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)

local AutoEcoleS = {}
local ConfigEcole = {}
local CurrentTest           = nil
local CurrentCheckPoint     = 0
local DriveErrors 		    = 0
local LastCheckPoint        = -1
local CurrentBlip           = nil
local CurrentZoneType       = nil
local IsAboveSpeedLimit     = false
local VehicleHealth     	= nil
local success               = false
local pieton                = false
local startedconduite 		= false
local drivetest = nil
local cvrai = 0
local blockitvoiture = false
local blockitmoto = false
local blockitcamion = false
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
permisencours = ""

function ShowHelpNotification(msg)
    AddTextEntry('HelpNotification', msg)
	BeginTextCommandDisplayHelp('HelpNotification')
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

-----------------------------------------------------------------------------------------------------------------------

local function StopDriveTest(success)
	if success then
		TriggerServerEvent('addpermis', permisencours)
		RemoveBlip(CurrentBlip)
		ESX.ShowAdvancedNotification('Walid le Moniteur', '~r~Bravo', 'Vous avez reçu votre permis !', 'CHAR_MOLLY', 'CHAR_MOLLY')
		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
		end
		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end
	else
		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end
		ESX.ShowAdvancedNotification('Walid le Moniteur', '~r~Malheureusement', 'Vous avez raté le test !', 'CHAR_MOLLY', 'CHAR_MOLLY')			
		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
		end
	end
	SetEntityCoords(PlayerPedId(), -460.24075317383, -619.36187744141, 31.174436569214)
	SetEntityHeading(PlayerPedId(), 96.84638214111328)
	CurrentTest     = nil
	CurrentTestType = nil
end

local function SetCurrentZoneType(type)
    CurrentZoneType = type
end

local CheckPoints = {

	{
		Pos = {x = -507.88558959961, y = -624.98254394531, z = 30.300067901611},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Allons sur la route, tournez à gauche, vitesse limitée à ~y~80km/h", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 147.14640808105, y = -808.60711669922, z = 31.011341094971},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Tournez a gauche et direction l'autoroute", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 299.28610229492, y = -486.75787353516, z = 43.3713722229},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Vous entrez sur l'autoroute, vitesse limitée à ~y~120km/h", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 2
		end
	},

	-- {
	-- 	Pos = {x = 45.206924438477, y = 485.09533691406, z = 33.904872894287},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Vous entrez sur l'autoroute, vitesse limitée à ~y~120km/h", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 2
	-- 	end
	-- },

	{
		Pos = {x = -408.5456237793, y = -496.3818359375, z = 25.323198318481},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Continuez sur l'autoroute", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -959.58825683594, y = -537.11126708984, z = 18.579393386841},
        Action = function(playerPed, setCurrentZoneType)
            ESX.ShowAdvancedNotification('Walid le Moniteur', 'Tournez !', "Tournez à droite, n'oubliez pas vos clignotants", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -1159.4927978516, y = -636.64123535156, z = 22.615493774414},
		Action = function(playerPed, setCurrentZoneType)
            ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien !', "Continuez sur cette voie", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 2
		end
	},

	-- {
	-- 	Pos = {x = -431.98, y = -682.32, z = 37.23},
	-- 	Action = function(playerPed, setCurrentZoneType)
    --         ESX.ShowAdvancedNotification('Walid le Moniteur', 'Votre Attention', "Préparez vous à prendre la sortie à droite", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 2
	-- 	end
	-- },

	-- {
	-- 	Pos = {x = -432.0, y = -928.51, z = 34.29},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Continuez tout droit", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 2
	-- 	end
	-- },

	-- {
	-- 	Pos = {x = -413.25, y = -1270.02, z = 20.98}, 
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Prenez la prochaine sortie", 'CHAR_MOLLY', 'CHAR_MOLLY') --## 393.65, -111.565, 65.29
	-- 		TesOuFDPRendMonQuad = 2
	-- 	end
	-- },
 --
	{
		Pos = {x = -1285.4116210938, y = -514.01531982422, z = 33.148296356201},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Prenez à droite", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = -884.07312011719, y = -294.00039672852, z = 39.894374847412},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Continuez comme ca !", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = -663.77001953125, y = -380.84451293945, z = 34.572933197021},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Continuez comme ca, tourné a droite", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = -640.42462158203, y = -633.77648925781, z = 32.07596206665},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Tourner à gauche", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = -498.16287231445, y = -661.10491943359, z = 33.040542602539},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Tourner à gauche", 'CHAR_MOLLY', 'CHAR_MOLLY')
			TesOuFDPRendMonQuad = 1
		end
	},

	-- {
	-- 	Pos = {x = -753.34, y = -1102.53, z = 10.73},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Continuez tout droit", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 1
	-- 	end
	-- },


	-- {
	-- 	Pos = {x = -888.26, y = -1173.96, z = 4.76},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Prenez la prochaine à droite", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 1
	-- 	end
	-- },

	-- {
	-- 	Pos = {x = -996.55, y = -1131.35, z = 2.15},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Ralentissez.", 'CHAR_MOLLY', 'CHAR_MOLLY') -- ici
	-- 		TesOuFDPRendMonQuad = 1
	-- 	end
	-- },

	-- {
	-- 	Pos = {x = -1159.73, y = -859.86, z = 14.15},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Tournez à gauche", 'CHAR_MOLLY', 'CHAR_MOLLY') -- ici
	-- 		TesOuFDPRendMonQuad = 1
	-- 	end
	-- },

	-- {
	-- 	Pos = {x = -1272.11, y = -899.9, z = 11.21},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Tourner à droite", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 1
	-- 	end
	-- },

	-- {
	-- 	Pos = {x = -1516.78, y = -681.49, z = 28.6},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Continuez tout droit.", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 1
	-- 	end
	-- },

	-- {
	-- 	Pos = {x = -1764.7, y = -545.16, z = 35.52},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Continuez tout droit.", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 1
	-- 	end
	-- },

	-- {
	-- 	Pos = {x = -2044.87, y = -379.97, z = 10.99},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Dernière ligne droite !", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 1
	-- 	end
	-- },

	-- {
	-- 	Pos = {x = -2150.22, y = -347.93, z = 13.21},
	-- 	Action = function(playerPed, setCurrentZoneType)
	-- 		ESX.ShowAdvancedNotification('Walid le Moniteur', 'Bien', "Tourner à gauche !", 'CHAR_MOLLY', 'CHAR_MOLLY')
	-- 		TesOuFDPRendMonQuad = 1
	-- 	end
	-- },

	{
		Pos = {x = -462.47827148438, y = -619.44171142578, z = 31.174436569214},
		Action = function(playerPed, setCurrentZoneType)
			startedconduite = false
			if DriveErrors < 5 then
				StopDriveTest(true)
			else
				StopDriveTest(false)
			end
		end
	},

}


local function GoToTargetWalking()
	pieton = false
	FreezeEntityPosition(pietonped, false)
    TaskGoToCoordAnyMeans(pietonped, 414.1815, -124.91, 63.71, 1.0, 0, 0, 786603, 0xbf800000)
    distanceToTarget = GetDistanceBetweenCoords(pietonped, 414.1815, -124.91, 63.71, true)
    if distanceToTarget <= 1 then
        FreezeEntityPosition(pietonped, true)
    end
end


local function StartConduite()
	startedconduite = true
	while startedconduite do
		Wait(0)

		if CurrentTest == 'drive' then

			if pieton then
				GoToTargetWalking()
			end

			local nextCheckPoint = CurrentCheckPoint + 1

			if CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				while not IsPedheadshotReady(RegisterPedheadshot(PlayerPedId())) or not IsPedheadshotValid(RegisterPedheadshot(PlayerPedId())) do
					Wait(100)
				end
		
				BeginTextCommandThefeedPost("PS_UPDATE")
				AddTextComponentInteger(50)
			
				EndTextCommandThefeedPostStats("PSF_DRIVING", 14, 50, 25, false, GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())), GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())))
			
				EndTextCommandThefeedPostTicker(false, true)
				
				UnregisterPedheadshot(RegisterPedheadshot(PlayerPedId()))

			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 90.0 then
					DrawMarker(36, CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					CheckPoints[nextCheckPoint].Action(PlayerPedId(), SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end

			----------

			if IsPedInAnyVehicle(PlayerPedId(), false) then

				local vehicle      = GetVehiclePedIsIn(PlayerPedId(), false)
				local speed        = GetEntitySpeed(vehicle) * 3.6
				local tooMuchSpeed = false
				local GetSpeed = math.floor(GetEntitySpeed(vehicle) * 3.6)
				local speed_limit_residence = 55.0
				local speed_limit_ville = 85.0
				local speed_limit_otoroute = 125.0

				local DamageControl = 0

				if TesOuFDPRendMonQuad == 0 and GetSpeed >= speed_limit_residence then
					tooMuchSpeed 	  = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					if DriveErrors <= 5 then
						ESX.ShowAdvancedNotification('Walid le Moniteur', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_residence.. " km/h!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_MOLLY', 'CHAR_MOLLY')
					end
					Wait(2000) -- evite bug
				end

				if TesOuFDPRendMonQuad == 1 and GetSpeed >= speed_limit_ville then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					if DriveErrors <= 5 then
						ESX.ShowAdvancedNotification('Walid le Moniteur', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_ville.. " km/h!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_MOLLY', 'CHAR_MOLLY')
					end
					Wait(2000)
				end

				if TesOuFDPRendMonQuad == 2 and GetSpeed >= speed_limit_otoroute then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					if DriveErrors <= 5 then
						ESX.ShowAdvancedNotification('Walid le Moniteur', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_otoroute.. " km/h!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_MOLLY', 'CHAR_MOLLY')
					end
					Wait(2000)
				end

				if HasEntityCollidedWithAnything(vehicle) and DamageControl == 0 then
					DriveErrors       = DriveErrors + 1
					if DriveErrors <= 5 then
						ESX.ShowAdvancedNotification('Walid le Moniteur', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_MOLLY', 'CHAR_MOLLY')
					end
					Wait(2000)
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				if GetEntityHealth(vehicle) < GetEntityHealth(vehicle) then

					DriveErrors = DriveErrors + 1

					ESX.ShowAdvancedNotification('Walid le Moniteur', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_MOLLY', 'CHAR_MOLLY')
					
					VehicleHealth = GetEntityHealth(vehicle)
					Wait(2000)
				end
				if DriveErrors >= 5 then
					CurrentCheckPoint = 10
					StopDriveTest(false)
					DriveErrors = 0
					CurrentCheckPoint = 0
					RemoveBlip(CurrentBlip)
					--SetNewWaypoint(204.82, 377.133)
					--DrawMarker(36, 204.82, 377.133, 107.24, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
					--local dist = Vdist2(GetEntityCoords(PlayerPedId()), 204.82, 377.133, 107.24)
					--if dist <= 2.5 then
					--	ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour rendre le véhicule.")
					--	if IsControlJustPressed(0, 51) then
					---		StopDriveTest(false)
					--		DriveErrors = 0
					--		CurrentCheckPoint = 0
					--		RemoveBlip(CurrentBlip)
					--	end
					--end
				end
			end
		else -- si jamais il prend pas en compte
			Wait(500)
		end
	end
end

local function StartDriveTest()
	CurrentTest       = 'drive'
	CurrentTestType   = type
	startedconduite = true
    permisencours = "drive"
	drivetest = "voiture"

	ConfigEcole.Zones = {

		VehicleSpawnPoint = {
			Pos = vector3(-594.77032470703, -623.13757324219, 28.300086975098)
		}
	}

	ESX.Game.SpawnVehicle('blista', ConfigEcole.Zones.VehicleSpawnPoint.Pos, 315.05, function(vehicle)
		local playerPed = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
	end)

	RequestModel(0x242C34A7)
    while not HasModelLoaded(0x242C34A7) do
        Wait(100)
	end
	
	pedssss = CreatePedInsideVehicle(veh, 5, 0x242C34A7, 0, true, false)
	SetEntityAsMissionEntity(pedssss, 0, 0)
	ESX.ShowAdvancedNotification('Walid le Moniteur', '~r~Me voila !', 'Tenez votre voiture, bonne route et bonne chance !', 'CHAR_MOLLY', 'CHAR_MOLLY')

	StartConduite()
end

local function StartDriveTestMoto()
	CurrentTest = 'drive'
	startedconduite = true
permisencours = "bike"
	drivetest = "moto"

	ConfigEcole.Zones = {

		VehicleSpawnPoint = {
			Pos = vector3(-594.77032470703, -623.13757324219, 28.300086975098)
		}
	}

	ESX.Game.SpawnVehicle('bati', ConfigEcole.Zones.VehicleSpawnPoint.Pos, 315.05, function(vehicle)
		local playerPed = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
	end)

	RequestModel(0x242C34A7)
    while not HasModelLoaded(0x242C34A7) do
        Wait(100)
	end
	pedssss = CreatePedInsideVehicle(veh, 5, 0x242C34A7, 0, true, false)
	SetEntityAsMissionEntity(pedssss, 0, 0)
	ESX.ShowAdvancedNotification('Walid le Moniteur', '~r~Me voila !', 'Tenez votre moto, bonne route et bonne chance !', 'CHAR_MOLLY', 'CHAR_MOLLY')

	StartConduite()
end

------------------------------------------------------------------------------------------------------------------------

RMenuv1.Add('rz-permis', 'main', RageUIv1.CreateMenu("", "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Bienvenue à l\'auto-ecole"))
RMenuv1:Get('rz-permis', 'main').EnableMouse = false

RMenuv1:Get('rz-permis', 'main').Closed = function() end

function AutoEcoleMenu()

    if AutoEcoleS.Menu then
        AutoEcoleS.Menu = false
    else
        AutoEcoleS.Menu = true
        RageUIv1.Visible(RMenuv1:Get('rz-permis', 'main'), true)
		
        Citizen.CreateThread(function()
			while AutoEcoleS.Menu do
				RageUIv1.IsVisible(RMenuv1:Get('rz-permis', 'main'), true, true, true, function()

					RageUIv1.ButtonWithStyle("~l~Passer le permis", "Passer le permis pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1200$.", { RightLabel = "1200$" }, true, function(_, _, Selected)
						if Selected then
							StartDriveTest()
							TriggerServerEvent('autoecole:pay', 1200)
							RageUIv1.CloseAll()
						end
					end)
                end)
				Wait(0)
			end
		end)
	end
end


local AutoEcole = {
    {x = -556.18725585938, y = -619.41467285156, z = 34.676368713379}
}  

Citizen.CreateThread(function()
    while true do
        local razzou = 500
        local pCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(AutoEcole) do
            local distance = Vdist(pCoords.x, pCoords.y, pCoords.z, AutoEcole[k].x, AutoEcole[k].y, AutoEcole[k].z)
           -- if not AutoEcoleS.Menu then
			if distance <= 10.0 then
				razzou = 1
				DrawMarker(Config.Get.Marker.Type, AutoEcole[k].x, AutoEcole[k].y, AutoEcole[k].z, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
				--DrawMarker(6, AutoEcole[k].x, AutoEcole[k].y, AutoEcole[k].z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 128, 255, 170, 0, 0, 0, 1, nil, nil, 0)
			
				if distance <= 1.5 then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler à la dame")
					if IsControlJustPressed(0, 51) then
						AutoEcoleMenu()
					end
				end
			end
           -- end
        end
        Citizen.Wait(razzou)
    end
end)

CreateThread(function()
    local hash = GetHashKey("a_f_m_bevhills_02")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(2000)
    end
    local ped = CreatePed("PED_TYPE_CIVFEMALE", "a_f_m_bevhills_02", -556.18725585938, -619.41467285156, 33.676368713379, 188.6353759765625, false, true) 
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	
	local blipauto = AddBlipForCoord(-556.18725585938, -619.41467285156, 34.676368713379)
	SetBlipSprite (blipauto, 269)
	SetBlipDisplay(blipauto, 4)
	SetBlipScale  (blipauto, 0.7)
	SetBlipAsShortRange(blipauto, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("[Public] Auto Ecole")
	EndTextCommandSetBlipName(blipauto)
end)