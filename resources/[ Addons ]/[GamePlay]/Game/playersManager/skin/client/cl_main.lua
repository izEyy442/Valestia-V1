local LastSkin, PlayerLoaded, cam, isCameraActive
local FirstSpawn, zoomOffset, camOffset, heading = true, 0.0, 0.0, 90.0
local SkinOpen = false
local i = {}
local comp = {}
local ClothesIndexCam = 1

function RUIText(text)
    ClearPrints()
    SetTextEntry_2("STRING")
    if (text.message ~= nil) then
        AddTextComponentString(tostring(text.message))
    end
    if (text.time_display ~= nil) then
        DrawSubtitleTimed(tonumber(text.time_display), 1)
    else
        DrawSubtitleTimed(10, 1)
    end
    if (text.sound ~= nil) then
        if (text.sound.audio_name ~= nil) then
            if (text.sound.audio_ref ~= nil) then
                PlaySoundFrontend(-1, text.sound.audio_name, text.sound.audio_ref, true)
            end
        end
    end
end

function CreateClothesCamProche()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.50)
    SetCamFov(cam, 60.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesCamNormal()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-2.0, coords.y, coords.z+0.50)
    SetCamFov(cam, 60.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesCamEloignez()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-2.50, coords.y, coords.z+0.50)
    SetCamFov(cam, 60.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesShoesCam()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.7)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.7)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesPantsCam()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.55)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.55)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesBasiqueCam()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesFaceCam()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-2.0, coords.y, coords.z+0.5)
    SetCamFov(cam, 30.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function ClothesSkinRota()
    RUIText({message = "Appuyer sur [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ESPACE~s~] pour faire pivoter votre personnage."})             
    if IsControlJustPressed(0, 22) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+45)
    end
end

local SkinOpenMenu = RageUI.CreateMenu("", "CRÉATION DE PERSONNAGE")
SkinOpenMenu.Closed = function()
    SkinOpen = false
    RenderScriptCams(0, 1, 1200, 0, 0)
    FreezeEntityPosition(PlayerPedId(), false)
end

function refreshDataSkin()
    comp = {}
    TriggerEvent("skinchanger:getData", function(comp_, max)
        SkinOpen = true
          if restrict == nil then
            for i=1, #comp_, 1 do
              comp[i] = comp_[i]
            end
        else
            for i=1, #comp_, 1 do
                local found = false
                for j=1, #restrict, 1 do
                    if comp_[i].name == restrict[j] then
                        found = true
                    end
                end
                if found then
                    table.insert(comp, comp_[i])
                end
            end
        end
        for k,v in pairs(comp) do
            if v.value ~= 0 then
                i[v.name] = v.value+1
            else
                i[v.name] = 1
            end
            for i,value in pairs(max) do
                if i == v.name then
                    comp[k].max = value
                    comp[k].table = {}
                    for i = 0, value do
                        table.insert(comp[k].table, i)
                    end
                    break
                end
            end
        end
    end)
end

local SkinOpenMenu = RageUI.CreateMenu("", "CRÉATION DE PERSONNAGE")
SkinOpenMenu.Closed = function()
    SkinOpen = false
    RenderScriptCams(0, 1, 1200, 0, 0)
    FreezeEntityPosition(PlayerPedId(), false)
end

function OpenSkinMenu(restrict)
    if not SkinOpen then
      TriggerEvent("skinchanger:getData", function(comp_, max)
        SkinOpen = true
          if restrict == nil then
            for i=1, #comp_, 1 do
              comp[i] = comp_[i]
            end
        else
            for i=1, #comp_, 1 do
                local found = false
                for j=1, #restrict, 1 do
                    if comp_[i].name == restrict[j] then
                        found = true
                    end
                end
                if found then
                    table.insert(comp, comp_[i])
                end
            end
        end
        for k,v in pairs(comp) do
            if v.value ~= 0 then
                i[v.name] = v.value+1
            else
                i[v.name] = 1
            end
            for i,value in pairs(max) do
                if i == v.name then
                    comp[k].max = value
                    comp[k].table = {}
                    for i = 0, value do
                        table.insert(comp[k].table, i)
                    end
                    break
                end
            end
        end
        RageUI.Visible(SkinOpenMenu, true)
          CreateThread(function()
            while SkinOpen do
              Wait(1)
                ClothesSkinRota()
                RageUI.IsVisible(SkinOpenMenu, function()
                        RageUI.List(" Type de caméra", {"Proche", "Normal", "Éloignez", "Visages", "Haut", "Bas", "Chaussure"}, ClothesIndexCam, nil, {}, true, {
                            onListChange = function(index, item)
                                ClothesIndexCam = index
                            end
                        })
                        RageUI.Line()
                        if ClothesIndexCam == 1 then
                            DestroyAllCams(true)
                            CreateClothesCamProche()
                        elseif ClothesIndexCam == 2 then
                            DestroyAllCams(true)
                            CreateClothesCamNormal()
                        elseif ClothesIndexCam == 3 then
                            DestroyAllCams(true)
                            CreateClothesCamEloignez()
                        elseif ClothesIndexCam == 4 then
                            DestroyAllCams(true)
                            CreateClothesFaceCam()
                        elseif ClothesIndexCam == 5 then
                            DestroyAllCams(true)
                            CreateClothesBasiqueCam()
                        elseif ClothesIndexCam == 6 then
                            DestroyAllCams(true)
                            CreateClothesPantsCam()
                        elseif ClothesIndexCam == 7 then
                            DestroyAllCams(true)
                            CreateClothesShoesCam()
                        end
                        for k,v in pairs(comp) do
                            if v.table[1] ~= nil then
                                RageUI.List(" "..v.label, v.table, i[v.name], nil, {}, true, {
                                    onSelected = function()
                                        RageUI.CloseAll()
                                        SkinOpen = false
                                        RenderScriptCams(0, 1, 1200, 0, 0)
                                        TriggerEvent("skinchanger:getSkin", function(skin)
                                            TriggerServerEvent("esx_skin:save", skin)
                                        end)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        ESX.ShowAdvancedNotification("Notification", "Valestia", "Votre personnage a été sauvegarder avec succès !", "CHAR_ST", 1)
                                    end,
                                    onListChange = function(index, item)
                                        if index ~= nil then
                                            refreshDataSkin()
                                            i[v.name] = index;
                                            TriggerEvent("skinchanger:change", v.name, index - 1)
                                            if v.componentId ~= nil then
                                                SetPedComponentVariation(PlayerPedId(), v.componentId, index - 1, 0, 2)
                                            end
                                        end
                                    end
                                })
                            end
                        end
                    end)
                end
            end)
        end)     
    end
end

function OpenSaveableMenu(submitCb, cancelCb, restrict)
    TriggerEvent('skinchanger:getSkin', function(skin)
        LastSkin = skin
    end)
    FreezeEntityPosition(PlayerPedId(), true)
    local coords = GetEntityCoords(PlayerPedId())
    SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())/coords.x+100)
    OpenSkinMenu(nil)
end

AddEventHandler('playerSpawned', function()
	CreateThread(function()
		while not PlayerLoaded do
			Wait(100)
		end

		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkin', {sex = 0})
				else
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)

			FirstSpawn = false
		end
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

AddEventHandler('esx_skin:getLastSkin', function(cb)
	cb(LastSkin)
end)

AddEventHandler('esx_skin:setLastSkin', function(skin)
	LastSkin = skin
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
    OpenSaveableMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openSaveableRestrictedMenu')
AddEventHandler('esx_skin:openSaveableRestrictedMenu', function(submitCb, cancelCb, restrict)
    OpenSaveableMenu(submitCb, cancelCb, restrict)
end)