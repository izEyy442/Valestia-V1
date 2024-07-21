UtilsCreator = {} or {};

local cam;

function UtilsCreator:input(TextEntry, ExampleText, MaxStringLenght)
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

function UtilsCreator:spawnCinematic()
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    local playerPed = PlayerPedId()
   -- SetEntityVisible(playerPed, false, false)
    FreezeEntityPosition(PlayerPedId(), true)
    SetFocusEntity(playerPed)
    Wait(1)
    SetOverrideWeather("EXTRASUNNY")
    NetworkOverrideClockTime(19, 0, 0)
    introstep = 1
    Wait(1)
    DoScreenFadeIn(500)
    if introstep == 1 then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam, true)
        SetCamCoord(cam, 701.47, 1031.08, 330.57)
        ShakeCam(cam, "HAND_SHAKE", 0.1)
        SetCamRot(cam, -0, -0, -11.48)
        SetCamActive(cam, true)
        RenderScriptCams(1, 0, 500, false, false)
        return
    end
end

function UtilsCreator:SetPlayerBuckets(val)
    TriggerServerEvent(_Prefix..":setBuckets", val)
end

function UtilsCreator:PlayAnimeCreator()
    ESX.Streaming.RequestAnimDict("anim@heists@prison_heistunfinished_biztarget_idle", function()
        TaskPlayAnim(PlayerPedId(), "anim@heists@prison_heistunfinished_biztarget_idle", "target_idle", 8.0, -8.0, -1, 1, 0, false, false, false)
        RemoveAnimDict("anim@heists@prison_heistunfinished_biztarget_idle")
        ESX.Streaming.RequestAnimDict("amb@world_human_hang_out_street@female_arms_crossed@idle_a", function()
            TaskPlayAnim(PlayerPedId(), "amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", 8.0, -8.0, -1, 51, 0, false, false, false)
            RemoveAnimDict("amb@world_human_hang_out_street@female_arms_crossed@idle_a")
        end)
    end)
end

function UtilsCreator:loadPlayerAnime()
    RequestAnimDict("anim@heists@ornate_bank@chat_manager")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@chat_manager") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@chat_manager", "poor_clothes", 8.0, -8, -1, 49, 0, 0, 0, 0)
end

function UtilsCreator:IsDateCorrect(date)
    if (string.match(date, "^%d+%p%d+%p%d%d%d%d$")) then
        local d, m, y = string.match(date, "(%d+)%p(%d+)%p(%d+)")
        d, m, y = tonumber(d), tonumber(m), tonumber(y)
        local dm2 = d*m*m
        if  d>31 or m>12 or dm2==0 or dm2==116 or dm2==120 or dm2==124 or dm2==496 or dm2==1116 or dm2==2511 or dm2==3751 then
            if dm2==116 and (y%400 == 0 or (y%100 ~= 0 and y%4 == 0)) then
                return true
            else
                return false
            end
        else
            return true
        end
    else
        return false
    end
end

function UtilsCreator:goCloak()
    ClearPedTasks(PlayerPedId())
    SetEntityInvincible(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do Wait(1) end
    Wait(1200)
    SetEntityCoords(PlayerPedId(), CreatorConfig.cloakRoom.pos, false, false, false, false)
    SetEntityHeading(PlayerPedId(), CreatorConfig.cloakRoom.heading)
    SetEntityInvincible(PlayerPedId(), false)
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(750)
    _Client.open:creatoRMenuClothes()
end

function UtilsCreator:goKitchen()
    ClearPedTasks(PlayerPedId())
    SetEntityInvincible(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do Wait(1) end
    Wait(1200)
    SetEntityCoords(PlayerPedId(), CreatorConfig.kitchen.pos, false, false, false, false)
    SetEntityHeading(PlayerPedId(), CreatorConfig.kitchen.heading)
    SetEntityInvincible(PlayerPedId(), false)
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(750)
    _Client.open:starterPackMenu()
end

function UtilsCreator:goLift()
    RageUIClothes.CloseAll()
    Wait(50)
    ClearPedTasks(PlayerPedId())
    SetEntityInvincible(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do Wait(1) end
    Wait(1200)
    SetEntityCoords(PlayerPedId(), CreatorConfig.lift.pos, false, false, false, false)
    SetEntityHeading(PlayerPedId(), CreatorConfig.lift.heading)
    SetEntityInvincible(PlayerPedId(), false)
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(750)
    _Client.open:selectSpawnMenu()
    -- local = pos = vector3(-115.3341, -605.4562, 36.28086)
    -- UtilsCreator:endIdentity(pos, 251.55155944824)
end

ControlDisable = {20, 24, 27, 178, 177, 189, 190, 187, 188, 202, 239, 240, 201, 172, 173, 174, 175}
function UtilsCreator:OnRenderCam()
    DisableAllControlActions(0)
    for _, v in pairs(ControlDisable) do
        EnableControlAction(0, v, true)
    end
    local Control1, Control2 = IsDisabledControlPressed(1, 44), IsDisabledControlPressed(1, 51)
    if Control1 or Control2 then
        local pPed = PlayerPedId()
        SetEntityHeading(pPed, Control1 and GetEntityHeading(pPed) - 2.0 or Control2 and GetEntityHeading(pPed) + 2.0)
    end
end

function UtilsCreator:applySkinSpecific(vest)
    TriggerEvent(CreatorConfig.events.skinchanger..':getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = vest.clothes["male"]
        else
            uniformObject = vest.clothes["female"]
        end
        if uniformObject then
            TriggerEvent(CreatorConfig.events.skinchanger..':loadClothes', skin, uniformObject)
        end
    end)
end

local CamOffset = {
    {item = "default", 		cam = {0.0, 3.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
    {item = "default_face", cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 35.0},
    {item = "face",			cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 20.0},
    {item = "skin", 		cam = {0.0, 2.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 30.0},
    {item = "tshirt_1", 	cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
    {item = "torso_1", 		cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
    {item = "arms", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
    {item = "pants_1", 		cam = {0.0, 2.0, -0.35}, lookAt = {0.0, 0.0, -0.4}, fov = 35.0},
    {item = "shoes_1", 		cam = {0.0, 2.0, -0.5}, lookAt = {0.0, 0.0, -0.6}, fov = 40.0},
    {item = "age_1",		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
    {item = "age_2",		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
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
    {item = "makeup_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
    {item = "lipstick_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
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

function UtilsCreator:GetCamOffset(type)
    for k,v in pairs(CamOffset) do
        if v.item == type then
            return v
        end
    end
end

function UtilsCreator:CreateHeadCam()
    CreateThread(function()
        local pPed = PlayerPedId()
        local offset = UtilsCreator:GetCamOffset("hair_1")
        local pos = GetOffsetFromEntityInWorldCoords(pPed, offset.cam[1], offset.cam[2], offset.cam[3])
        local posLook = GetOffsetFromEntityInWorldCoords(pPed, offset.lookAt[1], offset.lookAt[2], offset.lookAt[3])

        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)

        SetCamActive(cam, true)
        SetCamCoord(cam, pos.x, pos.y, pos.z)
        SetCamFov(cam, offset.fov)
        PointCamAtCoord(cam, posLook.x, posLook.y, posLook.z)

        RenderScriptCams(1, 1, 1500, 0, 0)
    end)
end

function UtilsCreator:CreatePlayerCam()
    CreateThread(function()
        local pPed = PlayerPedId()
        local offset = UtilsCreator:GetCamOffset("default")
        local pos = GetOffsetFromEntityInWorldCoords(pPed, offset.cam[1], offset.cam[2], offset.cam[3])
        local posLook = GetOffsetFromEntityInWorldCoords(pPed, offset.lookAt[1], offset.lookAt[2], offset.lookAt[3])

        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)

        SetCamActive(cam, true)
        SetCamCoord(cam, pos.x, pos.y, pos.z)
        SetCamFov(cam, offset.fov)
        PointCamAtCoord(cam, posLook.x, posLook.y, posLook.z)

        RenderScriptCams(1, 1, 1500, 0, 0)
    end)
end

function UtilsCreator:KillCam()
    RenderScriptCams(0, 1, 1500, 0, 0)
    SetCamActive(cam, false)
    ClearPedTasks(PlayerPedId())
    DestroyAllCams(true)
end

function UtilsCreator:endIdentity()
    RageUIClothes.CloseAll()
    ClearPedTasks(PlayerPedId())
    SetEntityInvincible(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do Wait(1) end
    Wait(1200)
    UtilsCreator:SetPlayerBuckets(false)
    SetEntityCoords(PlayerPedId(), selectedPos, false, false, false, false)
    SetEntityHeading(PlayerPedId(), selectedHeading)
    SetEntityInvincible(PlayerPedId(), false)
    FreezeEntityPosition(PlayerPedId(), false)
    DisplayRadar(true)
    DoScreenFadeIn(1000)
    if CreatorConfig.afterMessage then
        ESX.ShowNotification("Nous vous souhaitons la bienvenue sur ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ ValestiaRP. Passez un agréable moment parmis nous ! 💙")
    end
    if CreatorConfig.starterPack.enable == false then
        TriggerServerEvent('finallyCreator')
    end
end