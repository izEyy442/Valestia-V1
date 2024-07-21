--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local playerPed = PlayerPedId()
local isinintroduction = false
local introstep = 0
local enanimcinematique = false
local FirstSpawn     = true
local PlayerLoaded   = false

local PlayerMoney, PlayerMoneys = 0, 0

function destorycam()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end

function spawncinematiqueplayer(a)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    local playerPed = PlayerPedId()
    local introcam
    SetEntityVisible(playerPed, false, false)
    FreezeEntityPosition(PlayerPedId(), true)
    SetFocusEntity(playerPed)
    Wait(1)
    SetOverrideWeather("EXTRASUNNY")
    NetworkOverrideClockTime(19, 0, 0)
    introstep = 1
    isinintroduction = true
    Wait(1)
    DoScreenFadeIn(5000)
    if introstep == 1 then
        introcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(introcam, true)
        SetCamCoord(introcam, 701.47, 1031.08, 330.57)
        ShakeCam(introcam, "HAND_SHAKE", 0.1)
        SetCamRot(introcam, -0, -0, -11.48)
        SetCamActive(introcam, true)
        RenderScriptCams(1, 0, 500, false, false)
        return
    end
end

local function OpenMenuSpawn()
    local menu = RageUI.CreateMenu("Utils.Progressive", "Selection de personnage")
    menu.Closable = false
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu ~= nil do
        RageUI.IsVisible(menu, function()
            RageUI.Button("".. GetPlayerName(PlayerId()) .."", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Sélectionner"}, true, {
                onSelected = function()
                    SpawnEntrer()
                end
            })
            RageUI.Button("Créer un personnage.", nil, {}, false, {
                onSelected = function()
                    Visual.Subtitle("Cette ~y~option~s~ sera disponible ~y~prochainement~s~")
                end
            })
        end)
        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
		end
		Citizen.Wait(1)
    end
end

function SpawnEntrer()
    local playerPed = PlayerPedId();
    DoScreenFadeOut(1500);
    Wait(3000);
    RageUI.CloseAll();
    ESX.ShowAdvancedNotification('Notification', "Bienvenue", "Bon retour parmis nous ! Nous vous souhaitons un bon jeu sur notre serveur", 'CHAR_CALL911', 8)
    destorycam();
    spawncinematiqueplayer(false);
    enanimcinematique = false;
    isinintroduction = false;

    local coords = GetEntityCoords(playerPed);
    local heading = GetEntityHeading(playerPed);

    local respawnData = {

        coords = coords, 
        heading = heading or 0.0, 
        model = GetEntityModel(playerPed)

    };

    TriggerEvent("playerSpawned", respawnData, false);
    SetEntityVisible(playerPed, true, false)
    FreezeEntityPosition(PlayerPedId(), false)
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    DoScreenFadeIn(1500)
    DisplayRadar(true)
    TriggerEvent('esx_status:setDisplay', 0.5)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(10)
		end
		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin ~= nil then
                    TriggerEvent('skinchanger:loadSkin', skin)
                    spawncinematiqueplayer()
                    GetPlayerMoney()
                    GetPlayerMoneySolde()
                    OpenMenuSpawn()
				end
			end)
			FirstSpawn = false
		end
	end)
end)

RegisterNetEvent("solde:argent")
AddEventHandler("solde:argent", function(money)
  PlayerMoney = tonumber(money)
end)

RegisterNetEvent("solde2:argent2")
AddEventHandler("solde2:argent2", function(money)
  PlayerMoneys = tonumber(money)
end)
