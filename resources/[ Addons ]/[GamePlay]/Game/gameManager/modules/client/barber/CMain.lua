--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.Get.ESX, function(obj)
            ESX = obj
        end)
        Citizen.Wait(10)
    end
end)

local Barber = {}
Components = {}
ComponentsMax = {}
sLoaded = nil
sData = {}
sCharEnd = true
sIdentityEnd = true


local cam, isCameraActive
local firstSpawn, zoomOffset, camOffset, heading = true, 0.0, 0.0, 90.0

sBarber = {
    "hair_1",	
    "hair_2",	
    "hair_color_1",
    "hair_color_2",
    "beard_1",
    "beard_2",
    "beard_3",
    "beard_4",
    "eyebrows_2",
    "eyebrows_1",
    "eyebrows_3",
    "eyebrows_4",
    "makeup_1",
    "makeup_2",
    "makeup_3",
    "makeup_4",
    "lipstick_1",
    "lipstick_2",
    "lipstick_3",
    "lipstick_4",
    "blush_1",
    "blush_2",
    "blush_3",
    "complexion_1",	
    "complexion_2",	
}

function GetComponents()
	TriggerEvent('skinchanger:getData', function(data, max)
		Components = data
		ComponentsMax = max
	end)
end

RegisterNetEvent("barbershop:openMenu", function()
    if Barber.Menu then 
        Barber.Menu = false 
        RageUIv1.Visible(RMenuv1:Get('barber', 'main'), false)
        sCharacter = nil
        KillCreatorCam()
        FreezeEntityPosition(PlayerPedId(), true)
        return
    else
        RMenuv1.Add('barber', 'main', RageUIv1.CreateMenu("", "Bienvenue chez le barber")) --Menu principa
        RMenuv1.Add('barber', 'characteroptionshead', RageUIv1.CreateSubMenu(RMenuv1:Get("barber", "main"),"", "~s~Bienvenue chez le barber"))
        RMenuv1.Add('barber', 'characteroptions_s', RageUIv1.CreateSubMenu(RMenuv1:Get("barber", "character"),"", "~s~Bienvenue chez le barber")) -- validé
        RMenuv1.Add('barber', 'characteroptions_h', RageUIv1.CreateSubMenu(RMenuv1:Get("barber", "characteroptionshead"),"", "~s~Bienvenue chez le barber")) -- validé
        RMenuv1:Get('barber', 'main'):SetSubtitle("~s~Bienvenue chez le barber")
        RMenuv1:Get('barber', 'main').EnableMouse = false
        RMenuv1:Get('barber', 'main').Closable = true
        RMenuv1:Get('barber', 'main').Closed = function()
            Barber.Menu = false
            KillCreatorCam()
            FreezeEntityPosition(PlayerPedId(), false)
        end
        GetComponents()
        CreateCreatorCam()
        sCharEnd = true
        sIdentityEnd = true
        SwitchCam(false, 'default')
        Barber.Menu = true 
        RageUIv1.Visible(RMenuv1:Get('barber', 'main'), true)
        Citizen.CreateThread(function()
			while Barber.Menu do
                RageUIv1.IsVisible(RMenuv1:Get('barber', 'main'), true, false, true, function()
                    FreezeEntityPosition(PlayerPedId(), true)
                    RageUIv1.ButtonWithStyle("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Changer de style", "Voici ce que nous proposons", {RightLabel = "→"}, true,function(h,a,s)
                        if s then
                            GetComponents()
                        end
                    end,RMenuv1:Get("barber","characteroptionshead"))
                    RageUIv1.Line()
                    RageUIv1.ButtonWithStyle("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Valider le changement", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~→ 15~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~$"}, true,function(h,a,s)
                        if s then
                            TriggerServerEvent("barbershop:pay")
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                            end)
                        end
                    end)
                end)
                RageUIv1.IsVisible(RMenuv1:Get('barber', 'characteroptionshead'), true, false, true, function()
                    FreezeEntityPosition(PlayerPedId(), true)
                    for k,v in pairs(Components) do
                        for _, s_head in pairs(sBarber) do
                            if zoomOffset ~= v.zoomOffset and camOffset ~= v.camOffset then 
                                zoomOffset = v.zoomOffset
                                camOffset = v.camOffset
                            end
                            if v.name == s_head then
                                RageUIv1.ButtonWithStyle("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.label, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Voici ce que nous proposons", {RightLabel = "→"}, true,function(h,a,s)
                                    if a then
                                        sData = v.name
                                        SwitchCam(false, v.name)
                                    end
                                end,RMenuv1:Get("barber","characteroptions_h"))
                            end
                        end
                    end
                end)
                RageUIv1.IsVisible(RMenuv1:Get('barber', 'characteroptions_h'), true, false, true, function()
                    FreezeEntityPosition(PlayerPedId(), true)
                    for _,v in pairs(Components) do
                        if v.name == sData then
                            for i = 0, ComponentsMax[sData] do
                                RageUIv1.ButtonWithStyle("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.label.." N°"..i, "Voici ce que nous proposons", {RightLabel = "→"}, true,function(h,a,s)
                                    if a then
                                        if sLoaded ~= i then
                                            sLoaded = i
                                            TriggerEvent('skinchanger:change', v.name, i)
                                        end
                                    end
                                end)
                            end
                        end
                    end 
                end)
				Wait(0)
			end
		end)
	end
end)

RegisterNetEvent('BarberShop:CheckBuy')
AddEventHandler('BarberShop:CheckBuy', function(check)
	if check ==  'yes' then
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('esx_skin:save', skin)
        end)
        Barber.Menu = false
        KillCreatorCam()
        FreezeEntityPosition(PlayerPedId(), false)
	end
end)

local BarberShop = {
    {x = 137.09083557129, y = -1708.1477050781, z = 29.291622161865-0.98},
    {x = -810.96441650391, y = -184.06790161133, z = 37.568992614746-0.98},
    {x = -1280.9237060547, y = -1116.8645019531, z = 6.9901103973389-0.98},
    {x = 1929.7789306641, y = 3732.8803710938, z = 32.844417572021-0.98},
    {x = 1214.7652587891, y = -473.13641357422, z = 66.207984924316-0.98},
    {x = -33.455024719238, y = -154.7061920166, z = 57.076484680176-0.98},
    {x = -275.92349243164, y = 6226.2612304688, z = 31.695512771606-0.98},
    {x = 5150.6865, y = -5132.5142, z = 2.4341-0.98},
}  

Citizen.CreateThread(function()
    for k in pairs(BarberShop) do
       local blipbarber = AddBlipForCoord(BarberShop[k].x, BarberShop[k].y, BarberShop[k].z)
       SetBlipSprite(blipbarber, 71)
       SetBlipColour(blipbarber, 10)
       SetBlipScale(blipbarber, 0.6)
       SetBlipAsShortRange(blipbarber, true)

       BeginTextCommandSetBlipName('STRING')
       AddTextComponentString("[Public] Salon de Coiffure")
       EndTextCommandSetBlipName(blipbarber)
   end
end)


local CamOffset = {
	{item = "default", 		cam = {0.0, 3.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "default_face", cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 35.0},
	{item = "face",			cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 20.0},
	{item = "skin", 		cam = {0.0, 2.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 30.0},
	{item = "tshirt_1", 	cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "tshirt_2", 	cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "torso_1", 		cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "torso_2", 		cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "decals_1", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "decals_2", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "arms", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "arms_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "pants_1", 		cam = {0.0, 2.0, -0.35}, lookAt = {0.0, 0.0, -0.4}, fov = 35.0},
	{item = "pants_2", 		cam = {0.0, 2.0, -0.35}, lookAt = {0.0, 0.0, -0.4}, fov = 35.0},
	{item = "shoes_1", 		cam = {0.0, 2.0, -0.5}, lookAt = {0.0, 0.0, -0.6}, fov = 40.0},
	{item = "shoes_2", 		cam = {0.0, 2.0, -0.5}, lookAt = {0.0, 0.0, -0.6}, fov = 25.0},
	{item = "age_1",			cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "age_2",			cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "beard_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "beard_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "beard_3", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "beard_4", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "hair_1",		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "hair_2",		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "hair_color_1",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "hair_color_2",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eye_color", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eyebrows_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eyebrows_2", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eyebrows_3", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eyebrows_4", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "makeup_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "makeup_2", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "makeup_3", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "makeup_4", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "lipstick_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "lipstick_2", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "lipstick_3", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "lipstick_4", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blemishes_1",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blemishes_2",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blush_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blush_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blush_3", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "complexion_1",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "complexion_2",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "sun_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "sun_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "moles_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "moles_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chest_1", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chest_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chest_3", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bodyb_1", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bodyb_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "ears_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 35.0},
	{item = "ears_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 35.0},
	{item = "mask_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 20.0},
	{item = "mask_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 20.0},
	{item = "bproof_1", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bproof_2", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chain_1", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chain_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bags_1", 		cam = {0.0, -2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "bags_2", 		cam = {0.0, -2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "helmet_1", 	cam = {0.0, 1.0, 0.73}, lookAt = {0.0, 0.0, 0.68}, fov = 20.0},
	{item = "helmet_2", 	cam = {0.0, 1.0, 0.73}, lookAt = {0.0, 0.0, 0.68}, fov = 20.0},
	{item = "glasses_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "glasses_2", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "watches_1", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "watches_2", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bracelets_1",	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bracelets_2",	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
}

function GetCamOffset(type)
	for k,v in pairs(CamOffset) do
		if v.item == type then
			return v
		end
	end
end

function CreateCreatorCam()
    Citizen.CreateThread(function()
        local pPed = PlayerPedId()
        local offset = GetCamOffset("default")
        local pos = GetOffsetFromEntityInWorldCoords(pPed, offset.cam[1], offset.cam[2], offset.cam[3])
        local posLook = GetOffsetFromEntityInWorldCoords(pPed, offset.lookAt[1], offset.lookAt[2], offset.lookAt[3])

        CreatorCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
        
        SetCamActive(CreatorCam, 1)
        SetCamCoord(CreatorCam, pos.x, pos.y, pos.z)
        SetCamFov(CreatorCam, offset.fov)
        PointCamAtCoord(CreatorCam, posLook.x, posLook.y, posLook.z)

        RenderScriptCams(1, 1, 1000, 0, 0)
    end)
end

function SwitchCam(backto, type)
    if not DoesCamExist(cam2) then cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0) end
    Citizen.CreateThread(function()
        local pPed = PlayerPedId()
        local offset = GetCamOffset(type)
        if offset == nil then
            offset = GetCamOffset("default")
        end
        local pos = GetOffsetFromEntityInWorldCoords(pPed, offset.cam[1], offset.cam[2], offset.cam[3])
        local posLook = GetOffsetFromEntityInWorldCoords(pPed, offset.lookAt[1], offset.lookAt[2], offset.lookAt[3])

        if backto then
            SetCamActive(CreatorCam, 1)

            SetCamCoord(CreatorCam, pos.x, pos.y, pos.z)
            SetCamFov(CreatorCam, offset.fov)
            PointCamAtCoord(CreatorCam, posLook.x, posLook.y, posLook.z)
            SetCamActiveWithInterp(CreatorCam, cam2, 1000, 1, 1)
            Wait(1000)
            
        else
            SetCamActive(cam2, 1)

            SetCamCoord(cam2, pos.x, pos.y, pos.z)
            SetCamFov(cam2, offset.fov)
            PointCamAtCoord(cam2, posLook.x, posLook.y, posLook.z)
            SetCamDofMaxNearInFocusDistance(cam2, 1.0)
            SetCamDofStrength(cam2, 500.0)
            SetCamDofFocalLengthMultiplier(cam2, 500.0)
            SetCamActiveWithInterp(cam2, CreatorCam, 1000, 1, 1)
            Wait(1000)
        end
    end)
end

function KillCreatorCam()
    RenderScriptCams(0, 1, 1000, 0, 0)
    SetCamActive(CreatCam, 0)
    SetCamActive(cam2, 0)
    ClearPedTasks(PlayerPedId())
end
