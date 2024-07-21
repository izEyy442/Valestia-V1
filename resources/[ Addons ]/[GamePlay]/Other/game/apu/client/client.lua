function loadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end


--- todo Eviter que plusieurs personne puisse prendre le meme sac a billet

-- TIMER BAR

local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.012, titleOffsetY = -0.009, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {    timerBarWidth = 0.165, timerBarHeight = 0.035, timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 }
local RecompenceVIP = 100

local activeBars = {}
function AddTimerBar(title, itemData)
    if not itemData then return end
    RequestStreamedTextureDict("timerbars", true)

    local barIndex = #activeBars + 1
    activeBars[barIndex] = {
        title = title,
        text = itemData.text,
        textColor = itemData.color or { 255, 255, 255, 255 },
        percentage = itemData.percentage,
        endTime = itemData.endTime,
        pbarBgColor = itemData.bg or { 155, 155, 155, 255 },
        pbarFgColor = itemData.fg or { 255, 255, 255, 255 }
    }

    return barIndex
end

RegisterNetEvent("initializeApuBlip")
AddEventHandler("initializeApuBlip", function(houseIndex,duration)
    PlaySoundFrontend(-1, "Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
    ESX.ShowAdvancedNotification("Notification","Valestia","Un civil a appellé la police à cause d'un possible cambriolage.","CHAR_CALL911",9)

    local houseVector = robberiesConfiguration.houses[houseIndex].outdoorVector

    local blip = AddBlipForCoord(houseVector.x, houseVector.y, houseVector.z)
    SetBlipSprite(blip , 161)
    SetBlipScale(blip , 3.0)
    SetBlipColour(blip, 47)
    PulseBlip(blip)

    Citizen.Wait(1000*duration)

    RemoveBlip(blip)

end)

function RemoveTimerBar()
    activeBars = {}
    SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end

function UpdateTimerBar(barIndex, itemData)
    if not activeBars[barIndex] or not itemData then return end
    for k,v in pairs(itemData) do
        activeBars[barIndex][k] = v
    end
end

local HideHudComponentThisFrame = HideHudComponentThisFrame
local GetSafeZoneSize = GetSafeZoneSize
local DrawSprite = DrawSprite
local DrawText2 = DrawText2
local DrawRect = DrawRect
local SecondsToClock = SecondsToClock
local GetGameTimer = GetGameTimer
local textColor = { 200, 100, 100 }
local math = math

Citizen.CreateThread(function()
    while true do
        if #activeBars > 0 then
            Citizen.Wait(0)
        else
            Citizen.Wait(1000)
        end

        local safeZone = GetSafeZoneSize()
        local safeZoneX = (1.0 - safeZone) * 0.5
        local safeZoneY = (1.0 - safeZone) * 0.5

        if #activeBars > 0 then
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)

            for i,v in pairs(activeBars) do
local drawY = (ScreenCoords.baseY - safeZoneY) - (i * Sizes.timerBarMargin);
                DrawSprite("timerbars", "all_black_bg", ScreenCoords.baseX - safeZoneX, drawY, Sizes.timerBarWidth, Sizes.timerBarHeight, 0.0, 255, 255, 255, 160)
                DrawText2(0, v.title, 0.3, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY + ScreenCoords.titleOffsetY, v.textColor, false, 2)

                if v.percentage then
                    local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
                    local pbarY = drawY + ScreenCoords.pbarOffsetY;
                    local width = Sizes.pbarWidth * v.percentage;

                    DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4])

                    DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, v.pbarFgColor[1], v.pbarFgColor[2], v.pbarFgColor[3], v.pbarFgColor[4])
                elseif v.text then
                    DrawText2(0, v.text, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, v.textColor, false, 2)
                elseif v.endTime then
                    local remainingTime = math.floor(v.endTime - GetGameTimer())
                    DrawText2(0, SecondsToClock(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
                end
            end
        end
    end
end)

function DrawText2(intFont, strText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
    SetTextFont(intFont)
    SetTextScale(floatScale, floatScale)

    if boolShadow then
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
    end

    SetTextColour(color[1], color[2], color[3], 255)
    if intAlign == 0 then
        SetTextCentre(true)
    else
        SetTextJustification(intAlign or 1)
        if intAlign == 2 then
            SetTextWrap(.0, addWarp or intPosX)
        end
    end

    SetTextEntry("jamyfafi")
    AddLongString(strText)

    DrawText(intPosX, intPosY)
end

function AddLongString(txt)
    local maxLen = 100
    for i = 0, string.len(txt), maxLen do
        local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
        AddTextComponentString(sub)
    end
end

function SecondsToClock(seconds)
    seconds = tonumber(seconds)
  
    if seconds <= 0 then
        return "00:00"
    else
        mins = string.format("%02.f", math.floor(seconds / 60))
        secs = string.format("%02.f", math.floor(seconds - mins * 60))
        return string.format("%s:%s", mins, secs)
    end
  end

  function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
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

-- TIMER BAR

function RequestAndWaitModel(modelName) -- Request un modèle de véhicule
    if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
        RequestModel(modelName)
        while not HasModelLoaded(modelName) do Citizen.Wait(100) end
    end
end

function DrawText3D(B6zKxgVs, O3_X, DVs8kf2w, vms5, M7, v3)
    local ihKb = M7 or 7
    local JGSK, rA5U, Uc06 = table.unpack(GetGameplayCamCoords())
    M7 = GetDistanceBetweenCoords(JGSK, rA5U, Uc06, B6zKxgVs, O3_X, DVs8kf2w, 1)
    local lcBL = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), B6zKxgVs, O3_X, DVs8kf2w, 1) - 1.65
    local DHPxI, dx = ((1 / M7) * (ihKb * .7)) * (1 / GetGameplayCamFov()) * 100, 255;
    if lcBL < ihKb then
        dx = math.floor(255 * ((ihKb - lcBL) / ihKb))
    elseif lcBL >= ihKb then
        dx = 0
    end
    dx = v3 or dx
    SetTextFont(0)
    SetTextScale(.0 * DHPxI, .1 * DHPxI)
    SetTextColour(255, 255, 255, math.max(0, math.min(255, dx)))
    SetTextCentre(1)
    SetDrawOrigin(B6zKxgVs, O3_X, DVs8kf2w, 0)
    SetTextEntry("STRING")
    AddTextComponentString(vms5)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

eSup.IsRobbing = false
eSup.BarUpdate = nil
eSup.Peds = {}
eSup.Props = {}

RegisterNetEvent('eSup:OnPedDeathRobbery')
AddEventHandler('eSup:OnPedDeathRobbery', function(store)
    SetEntityHealth(eSup.Peds[store], 0)
end)

RegisterNetEvent('eSup:RemovePickupRobbery')
AddEventHandler('eSup:RemovePickupRobbery', function(bank)
    for i = 1, #eSup.Props  do 
        if eSup.Props[i].bank == bank and DoesEntityExist(eSup.Props[i].object) then 
            DeleteObject(eSup.Props[i].object) 
        end 
    end
end)

RegisterNetEvent('eSup:RobberyStartOver')
AddEventHandler('eSup:RobberyStartOver', function()
    eSup.IsRobbing = false
end)

RegisterNetEvent('eSup:RobberyStart')
AddEventHandler('eSup:RobberyStart', function(i)
    if not IsPedDeadOrDying(eSup.Peds[i]) then
        SetEntityCoords(eSup.Peds[i], eSup.Braquage[i].coords)
        loadDict('mp_am_hold_up')
        TaskPlayAnim(eSup.Peds[i], "mp_am_hold_up", "holdup_victim_20s", 8.0, -8.0, -1, 2, 0, false, false, false)
        PlayAmbientSpeechWithVoice(eSup.Peds[i], "SHOP_HURRYING", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)
        while not IsEntityPlayingAnim(eSup.Peds[i], "mp_am_hold_up", "holdup_victim_20s", 3) do 
            Wait(0) 
        end
        local timer = GetGameTimer() + 10800
        while timer >= GetGameTimer() do
            if IsPedDeadOrDying(eSup.Peds[i]) then
                break
            end
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(eSup.Peds[i]), true) >= 7.5 then
                ClearPedTasks(eSup.Peds[i])
                Wait(0)
                
                
                RemoveTimerBar()
                SetFakeWantedLevel(0)
                eSup.IsRobbing = false
            end
            Wait(0)
        end

        if not IsPedDeadOrDying(eSup.Peds[i]) then
            local cashRegister = GetClosestObjectOfType(GetEntityCoords(eSup.Peds[i]), 5.0, GetHashKey('prop_till_01'))
            if DoesEntityExist(cashRegister) then
                CreateModelSwap(GetEntityCoords(cashRegister), 0.5, GetHashKey('prop_till_01'), GetHashKey('prop_till_01_dam'), false)
            end

            timer = GetGameTimer() + 200 
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(eSup.Peds[i]) then
                    break
                end
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(eSup.Peds[i]), true) >= 7.5 then
                    ClearPedTasks(eSup.Peds[i])
                    Wait(0)
                    
                    
                    RemoveTimerBar()
                    SetFakeWantedLevel(0)
                    eSup.IsRobbing = false
                end
                Wait(0)
            end
            local model = GetHashKey('prop_poly_bag_01')
            RequestAndWaitModel(model)
            local bag = CreateObject(model, GetEntityCoords(eSup.Peds[i]), false, false)
                        
            AttachEntityToEntity(bag, eSup.Peds[i], GetPedBoneIndex(eSup.Peds[i], 60309), 0.1, -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2, 1)
            timer = GetGameTimer() + 10000
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(eSup.Peds[i]) then
                    break
                end
                Wait(0)
            end
            if not IsPedDeadOrDying(eSup.Peds[i]) then
                DetachEntity(bag, true, false)
                timer = GetGameTimer() + 75
                while timer >= GetGameTimer() do
                    if IsPedDeadOrDying(eSup.Peds[i]) then
                        break
                    end
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(eSup.Peds[i]), true) >= 7.5 then
                        ClearPedTasks(eSup.Peds[i])
                        Wait(0)
                        
                        
                        RemoveTimerBar()
                        SetFakeWantedLevel(0)
                        eSup.IsRobbing = false
                    end
                    Wait(0)
                end
                SetEntityHeading(bag, eSup.Braquage[i].heading)
                ApplyForceToEntity(bag, 3, vector3(0.0, 50.0, 0.0), 0.0, 0.0, 0.0, 0, true, true, false, false, true)
                table.insert(eSup.Props , {bank = i, object = bag})
                Citizen.CreateThread(function()
                    while true do
                        local wait = 500
                        if DoesEntityExist(bag) then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(bag), true) <= 1.5 then
                                wait = 1
                                DrawText3D(GetEntityCoords(bag).x, GetEntityCoords(bag).y, GetEntityCoords(bag).z, "Appuyez sur ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~s~ pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ramasser le sac~s~.", 12)
                                if IsControlJustPressed(0, 51) then 
                                    local dict, anim = 'random@domestic', 'pickup_low'
                                    loadDict(dict)
                                    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, 0, 1, 0, 0, 0)
                                    Wait(1000)
                                    PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
                                    UpdateTimerBar(eSup.BarUpdate, {percentage = 0})
                                    RemoveTimerBar()
                                    
                                    
                                    TriggerServerEvent('eSup:PickupRobbery', eSup.Braquage[i], i)
                                    SetFakeWantedLevel(0)
                                    break
                                end
                            end
                        else
                            break
                        end
                        Wait(wait)
                    end
                end)
            else
                DeleteObject(bag)
            end
        end
        loadDict('mp_am_hold_up')
        TaskPlayAnim(eSup.Peds[i], "mp_am_hold_up", "cower_intro", 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(10000)
        ClearPedTasks(eSup.Peds[i])
    end
end)

RegisterNetEvent('eSup:ResetPedDeath')
AddEventHandler('eSup:ResetPedDeath', function(i)
    if DoesEntityExist(eSup.Peds[i]) then
        DeletePed(eSup.Peds[i])
    end
    Wait(250)
    eSup.Peds[i] = _CreatePed(eSup.Braquage[i].shopkeeper, eSup.Braquage[i].coords, eSup.Braquage[i].heading)
    local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(eSup.Peds[i]), 5.0, GetHashKey('prop_till_01_dam'))
    if DoesEntityExist(brokenCashRegister) then
        CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, GetHashKey('prop_till_01_dam'), GetHashKey('prop_till_01'), false)
    end
end)

function _CreatePed(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end

    local ped = CreatePed(4, hash, coords, false, false)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetEntityInvincible(ped, true)
    return ped
end

local function MenaceApuMore(apu)
    ShowNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous devez menacer APU.")
    local pPed = PlayerPedId()
    PlayAmbientSpeechWithVoice(apu, "SHOP_SCARED_START", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)
    GiveWeaponToPed(apu, GetHashKey("weapon_sawnoffshotgun"), 0, 1, 1)
    TaskAimGunAtEntity(apu, pPed, 2500, false)
    TaskAnimForce({"random@mugging3","handsup_standing_base"},48)
    Citizen.Wait(5000)
    RemoveAllPedWeapons(apu, 1)
    ClearPedTasks(pPed)
    RemoveTimerBar()
    
    SetFakeWantedLevel(0)
    
    UpdateTimerBar(eSup.BarUpdate, {percentage = 0})
end

local function ApuShootPlayer(peds)
    local pPed = PlayerPedId()
    PlayAmbientSpeechWithVoice(peds, "SHOP_SCARED_START","MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)
    GiveWeaponToPed(peds, GetHashKey("weapon_autoshotgun"), 0, 1, 1)
    TaskAimGunAtEntity(peds, pPed, 2000, false)
    Wait(2000)
    TaskShootAtEntity(peds, pPed, 6000, -957453492)
    Citizen.Wait(6500)
    RemoveAllPedWeapons(peds, 1)
    ClearPedTasks(peds)
end
    

RegisterNetEvent("initializePoliceBlip2")
AddEventHandler("initializePoliceBlip2", function(ApuIndex)
    PlaySoundFrontend(-1, "Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
    ESX.ShowAdvancedNotification("Notification","Valestia","Un civil a appellé la police à cause d'un braquage de supérette.","CHAR_CALL911",9)

    local ApuVector = ApuIndex

    local blip = AddBlipForCoord(ApuVector.x, ApuVector.y, ApuVector.z)
    SetBlipSprite(blip , 161)
    SetBlipScale(blip , 3.0)
    SetBlipColour(blip, 47)
    PulseBlip(blip)

    Citizen.Wait(60000)

    RemoveBlip(blip)

end)

Citizen.CreateThread(function()
    for i = 1, #eSup.Braquage do 
        eSup.Peds[i] = _CreatePed(eSup.Braquage[i].shopkeeper, eSup.Braquage[i].coords, eSup.Braquage[i].heading)

        local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(eSup.Peds[i]), 5.0, GetHashKey('prop_till_01_dam'))
        if DoesEntityExist(brokenCashRegister) then
            CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, GetHashKey('prop_till_01_dam'), GetHashKey('prop_till_01'), false)
        end
    end

	local timerBraquage = false
    local wait = 1000
    while true do
        Wait(wait)
        local player = PlayerPedId()
        if IsPedArmed(player, 5) then
            wait = 500
            if IsPlayerFreeAiming(PlayerId()) or IsPedInMeleeCombat(player) then
                if eSup.IsRobbing then
                    
                    eSup.IsRobbing = false
                end
                for i = 1, #eSup.Peds do
                    if HasEntityClearLosToEntityInFront(player, eSup.Peds[i], 19) and not IsPedDeadOrDying(eSup.Peds[i]) and GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(eSup.Peds[i]), true) <= 5.0 then
                        wait = 1
                        if not eSup.IsRobbing then
                            local canRob = nil
							if not timerBraquage then
								timerBraquage = true
								ESX.TriggerServerCallback('eSup:CanRobbery', function(cb)
									canRob = cb
									Citizen.SetTimeout(10000, function()
										timerBraquage = false
									end)
								end, i)
								while canRob == nil do
									Wait(0)
								end
							end
                            if canRob == true then
                                local chance = math.random(0, 99)
                                if chance >= 0 and chance <= 25 then
                                    ApuShootPlayer(eSup.Peds[i])
                                else
                                    eSup.IsRobbing = true
                                    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
                                    ActivatePhysics(eSup.Peds[i])
                                    eSup.BarUpdate = AddTimerBar("Menace :",{percentage = 0.0, bg = {0, 0, 255}, fg = {45,110,185,255}})
                                    TriggerServerEvent("eSup:callThePolice", eSup.Braquage[i].coords)
                                    PlayAmbientSpeechWithVoice(eSup.Peds[i], "SHOP_HURRYING", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)
                                    SetFakeWantedLevel(2)
                                    Citizen.CreateThread(function()
                                        while eSup.IsRobbing do 
                                            Wait(0) 
                                            if IsPedDeadOrDying(eSup.Peds[i]) then 
                                                eSup.IsRobbing = false 
                                            end 
                                            if not IsPedArmed(player, 5) and GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(eSup.Peds[i]), true) <= 5.0 then
                                                ClearPedTasksImmediately(eSup.Peds[i])
                                                MenaceApuMore(eSup.Peds[i])
                                                eSup.IsRobbing = false 
                                            end
                                        end
                                    end)
                                    loadDict('missheist_agency2ahands_up')
									TaskPlayAnim(eSup.Peds[i], "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)
                                    local scared = 0
                                    while scared < 50 and not IsPedDeadOrDying(eSup.Peds[i]) and GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(eSup.Peds[i]), true) <= 7.5 do
                                        local sleep = eSup.Braquage[i].timrob
                                        SetEntityAnimSpeed(eSup.Peds[i], "missheist_agency2ahands_up", "handsup_anxious", 1.0)
                                        if IsPedArmed(player, 5) then
                                            sleep = eSup.Braquage[i].timrob
                                            SetEntityAnimSpeed(eSup.Peds[i], "missheist_agency2ahands_up", "handsup_anxious", 1.3)
                                        end
                                        sleep = GetGameTimer() + sleep
                                        while sleep >= GetGameTimer() and not IsPedDeadOrDying(eSup.Peds[i]) do
                                            Wait(0)
                                            local draw = scared/500
                                        end
                                        UpdateTimerBar(eSup.BarUpdate, {percentage = scared / 50})
                                        scared = scared + 1
                                    end
                                    if GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(eSup.Peds[i]), true) <= 7.5 then
                                        if not IsPedDeadOrDying(eSup.Peds[i]) then
                                            TriggerServerEvent('eSup:RobberyStart', i)
                                            while eSup.IsRobbing do
                                                Wait(0) 
                                                if IsPedDeadOrDying(eSup.Peds[i]) then 
                                                    eSup.IsRobbing = false 
                                                    UpdateTimerBar(eSup.BarUpdate, {percentage = 0})
                                                end 
                                            end
                                        end
                                    else
                                        ClearPedTasks(eSup.Peds[i])
                                        local wait = GetGameTimer()+5000
                                        while wait >= GetGameTimer() do
                                            Wait(0)
                                            
                                            
                                            UpdateTimerBar(eSup.BarUpdate, {percentage = 0})
                                            RemoveTimerBar()
                                            SetFakeWantedLevel(0)
                                        end
                                        eSup.IsRobbing = false
                                    end
                                end
                            elseif canRob == 'no_cops' then
                                local wait = GetGameTimer() + 5000
                                while wait >= GetGameTimer() do
                                    Wait(0)
                                    ShowNotification('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Gruppe6 viens de passer, les caisses sont vides.')
                                    
                                    SetFakeWantedLevel(0)
                                end
                            else
                                ShowNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cette superette a déjà été braqué, le vendeur n'a plus rien.")
                                
                                SetFakeWantedLevel(0)
                                Wait(0)
                            end
                            break
                        else
                            wait = 150
                        end
                    end
                end
            end
        end
    end
end)