-- audio, models and other stuff that was loaded while playing in Casino
-- (unload only Casino stuff, don't unload casino-used anims that were already loaded before entering)
-- (not to break other resources?)
local CasinoAssets = {}
local RequestTimeout = 2000
local SceneTimeout = 10000

-- clone ped
local face_features = {"Nose_Width", "Nose_Peak_Hight", "Nose_Peak_Lenght", "Nose_Bone_High", "Nose_Peak_Lowering",
                       "Nose_Bone_Twist", "EyeBrown_High", "EyeBrown_Forward", "Cheeks_Bone_High", "Cheeks_Bone_Width",
                       "Cheeks_Width", "Eyes_Openning", "Lips_Thickness", "Jaw_Bone_Width", "Jaw_Bone_Back_Lenght",
                       "Chimp_Bone_Lowering", "Chimp_Bone_Lenght", "Chimp_Bone_Width", "Chimp_Hole", "Neck_Thikness"}
local head_overlays = {"Blemishes", "FacialHair", "Eyebrows", "Ageing", "Makeup", "Blush", "Complexion", "SunDamage",
                       "Lipstick", "MolesFreckles", "ChestHair", "BodyBlemishes", "AddBodyBlemishes"}

function UnloadCasinoAssets()
    local u = 0
    for k, v in pairs(CasinoAssets) do
        Debug("Unloading asset '" .. k .. "' ( " .. v.type .. " )")
        if v.type == "Model" then
            SetModelAsNoLongerNeeded(k)
        elseif v.type == "AudioBank" then
            ReleaseNamedScriptAudioBank(k)
            ReleaseScriptAudioBank()
        elseif v.type == "Animset" then
            RemoveAnimSet(k)
        elseif v.type == "AnimDict" then
            RemoveAnimDict(k)
        elseif v.type == "StreamedTextureDict" then
            SetStreamedTextureDictAsNoLongerNeeded(k)
        end
        u = u + 1
    end
    for k, v in pairs(CasinoBlips) do
        RemoveBlip(v)
    end
    for k, v in pairs(MissionBlips) do
        RemoveBlip(v)
    end
    Debug("Unloaded " .. u .. " Casino assets.")
end

local function AssetFailedToLoad(assetType, assetName)
    print("^1[CASINO] Couldn't load " .. assetType .. " in time: " .. assetName .. "^7")
    if not IN_CASINO then
        print("^3Player is not in casino anymore.^7")
    else
        print("^3Time expired.^7")
    end
end

function IsGamepadControl()
    return not IsInputDisabled(2)
end

function GetSmartControlNormal(control)
    if type(control) == 'table' then
        local normal1 = GetDisabledControlNormal(0, control[1])
        local normal2 = GetDisabledControlNormal(0, control[2])
        return normal1 - normal2
    end

    return GetDisabledControlNormal(0, control)
end

function DisableESCThisFrame()
    DisableControlAction(0, 202, true) -- esc default
    DisableControlAction(0, 177, true) -- esc all
    DisableControlAction(1, 177, true)
    DisableControlAction(2, 177, true)
    DisableControlAction(0, 199, true)
    DisableControlAction(1, 199, true)
    DisableControlAction(2, 199, true)
end

-- _SET_NETWORK_TASK_PARAM_FLOAT
function SetNetworkTaskParamFloat(ped, param, value)
    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, param, value)
end

function GetPedFromPlayerId(playerId)
    local svrId = GetPlayerServerId(playerId)
    local pid = GetPlayerFromServerId(svrId)
    return GetPlayerPed(pid)
end

-- set ped invicible and *brave*
function SetPedBrave(ped)
    SetEntityCanBeDamaged(ped, false)
    SetPedAsEnemy(ped, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedResetFlag(ped, 249, true)
    SetPedConfigFlag(ped, 185, true)
    SetPedConfigFlag(ped, 108, true)
    Citizen.InvokeNative(0x352E2B5CF420BF3B, ped, 1)
    SetPedCanEvasiveDive(ped, 0)
    Citizen.InvokeNative(0x2F3C3D9F50681DE4, ped, 1)
    SetPedCanRagdollFromPlayerImpact(ped, 0)
    SetPedConfigFlag(ped, 208, true)
end

function WaitForEntityAnimToFinish(entity, animDict, animName, finishTime)
    local timeout = GAME_TIMER + 30000
    while IN_CASINO and IsEntityPlayingAnim(entity, animDict, animName, 3) and GAME_TIMER < timeout and
        GetEntityAnimCurrentTime(entity, animDict, animName) <= finishTime do
        Wait(33)
    end
end

function WaitSynchronizedSceneToReachTime(scene, reachTime, waitFor, initialDelay)
    if waitFor == nil then
        waitFor = 30000
    end
    if initialDelay ~= nil then
        Wait(initialDelay)
    end
    local timeout = GAME_TIMER + waitFor
    while IN_CASINO and GetSynchronizedScenePhase(scene) < reachTime and GAME_TIMER < timeout do
        Wait(33)
    end
    return IN_CASINO and GAME_TIMER < timeout
end

function WaitTaskAnimToReachTime(entity, dict, name, reachTime, waitFor, initialDelay)
    if waitFor == nil then
        waitFor = 30000
    end
    if initialDelay ~= nil then
        Wait(initialDelay)
    end
    local timeout = GAME_TIMER + waitFor
    while IN_CASINO and GetEntityAnimCurrentTime(entity, dict, name) < reachTime and GAME_TIMER < timeout do
        Wait(33)
    end
    return IN_CASINO and GAME_TIMER < timeout
end

function GetInitialAnimOffsets(animDict, animName, x, y, z, rx, ry, rz)
    return GetAnimInitialOffsetPosition(animDict, animName, x, y, z, rx, ry, rz, 0.01, 2),
        GetAnimInitialOffsetRotation(animDict, animName, x, y, z, rx, ry, rz, 0.01, 2)
end
function CreateTaskAnimEndEvent(ped, dict, anim, reachTime, onEnd, waitFor, initialDelay)
    if waitFor == nil then
        waitFor = 30000
    end
    local startTime = GAME_TIMER
    local o = {
        cancelled = false,
        finished = false,
        totalTime = 0
    }
    CreateThread(function()

        local success = WaitTaskAnimToReachTime(ped, dict, anim, reachTime, waitFor, initialDelay) and onEnd and
                            not o.cancelled
        o.totalTime = GAME_TIMER - startTime
        o.finished = true
        if success and IN_CASINO then
            onEnd()
        end
    end)
    return o
end

function CreateSceneEndEvent(scene, reachTime, onEnd, waitFor, initialDelay)
    if waitFor == nil then
        waitFor = 30000
    end
    local startTime = GAME_TIMER
    local o = {
        cancelled = false,
        finished = false,
        totalTime = 0
    }
    CreateThread(function()
        local success = WaitSynchronizedSceneToReachTime(scene, reachTime, waitFor, initialDelay) and onEnd and
                            not o.cancelled
        o.totalTime = GAME_TIMER - startTime
        o.finished = true
        if success and IN_CASINO then
            onEnd()
        end
    end)
    return o
end

function FormatMMSS(time)
    local minutes = math.floor(time / 60)
    local seconds = time % 60
    return string.format("%02d:%02d", minutes, seconds)
end

function FormatTimestamp(time)
    local days = math.floor(time / 86400)
    local hours = math.floor(math.fmod(time, 86400) / 3600)
    local minutes = math.floor(math.fmod(time, 3600) / 60)
    local seconds = math.floor(math.fmod(time, 60))

    local formatted = ""
    if days > 0 then
        formatted = days .. "d, "
    end
    if hours > 0 then
        formatted = formatted .. hours .. "h, "
    end
    if minutes > 0 then
        formatted = formatted .. minutes .. "m, "
    end
    if seconds > 0 then
        formatted = formatted .. seconds .. "s, "
    end

    formatted = formatted:sub(1, -3)

    return formatted
end

local function TryToLoadScaleformMovie(scaleform)
    if not IN_CASINO then
        return false
    end
    local handle = RequestScaleformMovie(scaleform)
    local t = GetGameTimer() + RequestTimeout
    while not HasScaleformMovieLoaded(handle) and (IN_CASINO or IN_GARAGE) and GetGameTimer() < t do
        Citizen.Wait(33)
    end
    if GetGameTimer() <= t then
        Debug("[CASINO LOADING] Scaleform '" .. scaleform .. "' loaded")
    else
        AssetFailedToLoad("scaleform", scaleform)
        return nil
    end
    return handle
end

local function TryToLoadStreamedTextureDict(dict, p1)
    if not IN_CASINO then
        return false
    end
    if not HasStreamedTextureDictLoaded(dict) then
        CasinoAssets[dict] = {
            hash = dict,
            type = "StreamedTextureDict"
        }
    end
    local t = GetGameTimer() + RequestTimeout
    RequestStreamedTextureDict(dict, p1)
    while not HasStreamedTextureDictLoaded(dict) and IN_CASINO and GetGameTimer() < t do
        Citizen.Wait(33)
    end
    if HasStreamedTextureDictLoaded(dict) then
        Debug("[CASINO LOADING] Texture Dict '" .. dict .. "' loaded")
        return true
    else
        AssetFailedToLoad("texture dict", dict)
    end
    return false
end

local function TryToLoadAnimDict(animDict)
    if not IN_CASINO then
        return false
    end
    if not HasAnimDictLoaded(animDict) then
        CasinoAssets[animDict] = {
            hash = animDict,
            type = "AnimDict"
        }
    end
    Debug("[CASINO LOADING] Loading animations '" .. animDict .. "'")
    local t = GetGameTimer() + RequestTimeout
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) and IN_CASINO and GetGameTimer() < t do
        Citizen.Wait(33)
    end
    if HasAnimDictLoaded(animDict) then
        Debug("[CASINO LOADING] Animations '" .. animDict .. "' loaded")
        return true
    else
        AssetFailedToLoad("animations", animDict)
    end
    return false
end

local function TryToLoadAnimSet(animset)
    if not IN_CASINO then
        return false
    end
    if not HasAnimSetLoaded(animset) then
        CasinoAssets[animset] = {
            hash = animset,
            type = "Animset"
        }
    end
    RequestAnimSet(animset)
    local t = GetGameTimer() + RequestTimeout
    while not HasAnimSetLoaded(animset) and IN_CASINO and GetGameTimer() < t do
        Citizen.Wait(33)
    end
    if GetGameTimer() <= t then
        Debug("[CASINO LOADING] AnimSet '" .. animset .. "' loaded")
        return true
    else
        AssetFailedToLoad("animset", animset)
    end
    return false
end

local function TryToLoadModel(modelName)
    if not IN_CASINO then
        return false
    end
    if not HasModelLoaded(modelName) then
        CasinoAssets[modelName] = {
            hash = modelName,
            type = "Model"
        }
    end
    local t = GetGameTimer() + RequestTimeout
    RequestModel(modelName)
    while not HasModelLoaded(modelName) and IN_CASINO and GetGameTimer() < t do
        Citizen.Wait(33)
    end
    if GetGameTimer() <= t then
        Debug("[CASINO LOADING] Model '" .. modelName .. "' loaded")
        return true
    else
        AssetFailedToLoad("model", modelName)
    end
    return false
end

-- custom load functions for loading all resources synchronously
function RequestModelAndWait(modelName)
    Debug("[CASINO LOADING] Loading model '" .. modelName .. "'")
    if not tonumber(modelName) then
        local original = modelName
        modelName = GetHashKey(modelName)
        if modelName == 0 then
            print("^3[CASINO LOADING] Failed to get hash of model name '" .. original .. "'. ^7")
        end
    end
    for i = 1, 3 do
        if TryToLoadModel(modelName) then
            if i ~= 1 then
                print("^3[CASINO LOADING] Model '" .. modelName .. "' was loaded on " .. i .. "# try.^7")
            end
            break
        end
    end
end

function RequestModelsAndWait(models)
    for k, v in pairs(models) do
        RequestModelAndWait(v)
    end
end

function RequestAnimSetAndWait(animset)
    Debug("[CASINO LOADING] Loading Animset '" .. animset .. "'")
    for i = 1, 3 do
        if TryToLoadAnimSet(animset) then
            if i ~= 1 then
                print("^3[CASINO LOADING] Animset '" .. animset .. "' was loaded on " .. i .. "# try.^7")
            end
            break
        end
    end
end

function RequestAnimDictAndWait(animDict)
    if HasAnimDictLoaded(animDict) then
        return
    end
    if not DoesAnimDictExist(animDict) then
        print("^3[CASINO LOADING] AnimDict '" .. animDict .. "' doesn't exist. ^7")
        return
    end
    for i = 1, 3 do
        if TryToLoadAnimDict(animDict) then
            if i ~= 1 then
                print("^3[CASINO LOADING] AnimDict '" .. animDict .. "' was loaded on " .. i .. "# try.^7")
            end
            break
        end
    end
end

function RequestStreamedTextureDictAndWait(dict, p1)
    Debug("[CASINO LOADING] Loading textures '" .. dict .. "'")
    for i = 1, 3 do
        if TryToLoadStreamedTextureDict(dict, p1) then
            if i ~= 1 then
                print("^3[CASINO LOADING] Texture Dict '" .. dict .. "' was loaded on " .. i .. "# try.^7")
            end
            break
        end
    end
end

function PrepareDefaultInterior(interior)
    PinInteriorInMemory(interior)
end

function LoadCasinoAtCoordsAndWait()
    if Config.LOAD_SCENE then
        local t = GetGameTimer() + 2000
        while (IsNewLoadSceneLoaded() or IsNewLoadSceneActive()) and GetGameTimer() < t do
            NewLoadSceneStop()
            Wait(100)
        end
    end

    local interior = GetInteriorFromEntity(PlayerPedId())
    local position = GetEntityCoords(PlayerPedId())
    Debug("[CASINO LOADING] Loading interior '" .. interior .. "'")
    if interior == 0 then
        return
    end

    if Config.MapType == 5 then
        PrepareDefaultInterior(interior)
    end

    if not IsEntityInCasino(PlayerPedId()) then
        return
    end

    t = GetGameTimer() + SceneTimeout
    while not IsInteriorReady(interior) and IN_CASINO and GetGameTimer() < t do
        Citizen.Wait(33)
    end

    if GetGameTimer() <= t then
        Debug("[CASINO LOADING] Interior '" .. interior .. "' loaded")
    else
        AssetFailedToLoad("scene", "Casino Scene Int")
    end

    Debug("[CASINO LOADING] Loading casino scene")

    if Config.LOAD_SCENE then
        if NewLoadSceneStartSphere(position.x, position.y, position.z, 100.0, 1) then
            t = GetGameTimer() + SceneTimeout
            while IN_CASINO and GetGameTimer() < t and IsNewLoadSceneActive() and not IsNewLoadSceneLoaded() do
                Citizen.Wait(33)
            end
            if GetGameTimer() <= t and IsNewLoadSceneLoaded() then
                Debug("[CASINO LOADING] Scene loaded")
            else
                AssetFailedToLoad("scene", "Casino Scene")
                Config._AutoScanTables = true
                print(
                    "^3Problems with loading the casino interior may cause other maps or IPLS around this area.\n^3Please try to disable some of the maps that you think may be affecting this.\n^3Some of games may not be enterble/playable.^7")
            end
        end
    else
        Config._AutoScanTables = true
    end
end

function SetVehicleProperties(vehicle, props)
    if DoesEntityExist(vehicle) then
        local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
        SetVehicleModKit(vehicle, 0)

        if props.plate then
            SetVehicleNumberPlateText(vehicle, props.plate)
        end
        if props.plateIndex then
            SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
        end
        if props.bodyHealth then
            SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0)
        end
        if props.engineHealth then
            SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0)
        end
        if props.fuelLevel then
            SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0)
        end
        if props.dirtLevel then
            SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0)
        end
        if Config.VehicleRGBTweak then
            if props.color1 and not tonumber(props.color1) then
                SetVehicleCustomPrimaryColour(vehicle, props.color1[1], props.color1[2], props.color1[3])
            end
            if props.color2 and not tonumber(props.color2) then
                SetVehicleCustomSecondaryColour(vehicle, props.color2[1], props.color2[2], props.color2[3])
            end
        else
            if props.color1 and tonumber(props.color1) then
                SetVehicleColours(vehicle, props.color1, colorSecondary)
            end
            if props.color2 and tonumber(props.color2) then
                SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2)
            end
        end
        if props.pearlescentColor then
            SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
        end
        if props.wheelColor then
            SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
        end
        if props.wheels then
            SetVehicleWheelType(vehicle, props.wheels)
        end
        if props.windowTint then
            SetVehicleWindowTint(vehicle, props.windowTint)
        end

        if props.neonEnabled then
            SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
            SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
            SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
            SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
        end

        if props.extras then
            for id, enabled in pairs(props.extras) do
                if enabled then
                    SetVehicleExtra(vehicle, tonumber(id), 0)
                else
                    SetVehicleExtra(vehicle, tonumber(id), 1)
                end
            end
        end

        if props.neonColor then
            SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
        end
        if props.modSmokeEnabled then
            ToggleVehicleMod(vehicle, 20, true)
        end
        if props.tyreSmokeColor then
            SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
        end
        if props.modSpoilers then
            SetVehicleMod(vehicle, 0, props.modSpoilers, false)
        end
        if props.modFrontBumper then
            SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
        end
        if props.modRearBumper then
            SetVehicleMod(vehicle, 2, props.modRearBumper, false)
        end
        if props.modSideSkirt then
            SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
        end
        if props.modExhaust then
            SetVehicleMod(vehicle, 4, props.modExhaust, false)
        end
        if props.modFrame then
            SetVehicleMod(vehicle, 5, props.modFrame, false)
        end
        if props.modGrille then
            SetVehicleMod(vehicle, 6, props.modGrille, false)
        end
        if props.modHood then
            SetVehicleMod(vehicle, 7, props.modHood, false)
        end
        if props.modFender then
            SetVehicleMod(vehicle, 8, props.modFender, false)
        end
        if props.modRightFender then
            SetVehicleMod(vehicle, 9, props.modRightFender, false)
        end
        if props.modRoof then
            SetVehicleMod(vehicle, 10, props.modRoof, false)
        end
        if props.modEngine then
            SetVehicleMod(vehicle, 11, props.modEngine, false)
        end
        if props.modBrakes then
            SetVehicleMod(vehicle, 12, props.modBrakes, false)
        end
        if props.modTransmission then
            SetVehicleMod(vehicle, 13, props.modTransmission, false)
        end
        if props.modHorns then
            SetVehicleMod(vehicle, 14, props.modHorns, false)
        end
        if props.modSuspension then
            SetVehicleMod(vehicle, 15, props.modSuspension, false)
        end
        if props.modArmor then
            SetVehicleMod(vehicle, 16, props.modArmor, false)
        end
        if props.modTurbo then
            ToggleVehicleMod(vehicle, 18, props.modTurbo)
        end
        if props.modXenon then
            ToggleVehicleMod(vehicle, 22, props.modXenon)
        end
        if props.modFrontWheels then
            SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
        end
        if props.modBackWheels then
            SetVehicleMod(vehicle, 24, props.modBackWheels, false)
        end
        if props.modPlateHolder then
            SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
        end
        if props.modVanityPlate then
            SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
        end
        if props.modTrimA then
            SetVehicleMod(vehicle, 27, props.modTrimA, false)
        end
        if props.modOrnaments then
            SetVehicleMod(vehicle, 28, props.modOrnaments, false)
        end
        if props.modDashboard then
            SetVehicleMod(vehicle, 29, props.modDashboard, false)
        end
        if props.modDial then
            SetVehicleMod(vehicle, 30, props.modDial, false)
        end
        if props.modDoorSpeaker then
            SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
        end
        if props.modSeats then
            SetVehicleMod(vehicle, 32, props.modSeats, false)
        end
        if props.modSteeringWheel then
            SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
        end
        if props.modShifterLeavers then
            SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
        end
        if props.modAPlate then
            SetVehicleMod(vehicle, 35, props.modAPlate, false)
        end
        if props.modSpeakers then
            SetVehicleMod(vehicle, 36, props.modSpeakers, false)
        end
        if props.modTrunk then
            SetVehicleMod(vehicle, 37, props.modTrunk, false)
        end
        if props.modHydrolic then
            SetVehicleMod(vehicle, 38, props.modHydrolic, false)
        end
        if props.modEngineBlock then
            SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
        end
        if props.modAirFilter then
            SetVehicleMod(vehicle, 40, props.modAirFilter, false)
        end
        if props.modStruts then
            SetVehicleMod(vehicle, 41, props.modStruts, false)
        end
        if props.modArchCover then
            SetVehicleMod(vehicle, 42, props.modArchCover, false)
        end
        if props.modAerials then
            SetVehicleMod(vehicle, 43, props.modAerials, false)
        end
        if props.modTrimB then
            SetVehicleMod(vehicle, 44, props.modTrimB, false)
        end
        if props.modTank then
            SetVehicleMod(vehicle, 45, props.modTank, false)
        end
        if props.modWindows then
            SetVehicleMod(vehicle, 46, props.modWindows, false)
        end

        if props.modLivery then
            SetVehicleMod(vehicle, 48, props.modLivery, false)
            SetVehicleLivery(vehicle, props.modLivery)
        end

        if props.pr and props.pg and props.pb then
            SetVehicleCustomPrimaryColour(vehicle, props.pr, props.pg, props.pb)
        end

        if props.sr and props.sg and props.sb then
            SetVehicleCustomSecondaryColour(vehicle, props.sr, props.sg, props.sb)
        end
    end
end

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
        local extras = {}

        for extraId = 0, 12 do
            if DoesExtraExist(vehicle, extraId) then
                local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
                extras[tostring(extraId)] = state
            end
        end

        local pr, pg, pb
        if GetIsVehiclePrimaryColourCustom(vehicle) then
            pr, pg, pb = GetVehicleCustomPrimaryColour(vehicle)
        end

        local sr, sg, sb
        if GetIsVehicleSecondaryColourCustom(vehicle) then
            sr, sg, sb = GetVehicleCustomSecondaryColour(vehicle)
        end

        local o = {
            model = GetEntityModel(vehicle),

            pr = pr,
            pg = pg,
            pb = pb,

            sr = sr,
            sg = sg,
            sb = sb,

            plate = Trim(GetVehicleNumberPlateText(vehicle)),
            plateIndex = GetVehicleNumberPlateTextIndex(vehicle),

            bodyHealth = Clamp(GetVehicleBodyHealth(vehicle), 0, 1),
            engineHealth = Clamp(GetVehicleEngineHealth(vehicle), 0, 1),
            tankHealth = Clamp(GetVehiclePetrolTankHealth(vehicle), 0, 1),

            fuelLevel = Clamp(GetVehicleFuelLevel(vehicle), 0, 1),
            dirtLevel = Clamp(GetVehicleDirtLevel(vehicle), 0, 1),
            color1 = colorPrimary,
            color2 = colorSecondary,

            pearlescentColor = pearlescentColor,
            wheelColor = wheelColor,

            wheels = GetVehicleWheelType(vehicle),
            windowTint = GetVehicleWindowTint(vehicle),
            xenonColor = GetVehicleXenonLightsColour(vehicle),

            neonEnabled = {IsVehicleNeonLightEnabled(vehicle, 0), IsVehicleNeonLightEnabled(vehicle, 1),
                           IsVehicleNeonLightEnabled(vehicle, 2), IsVehicleNeonLightEnabled(vehicle, 3)},

            neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
            extras = extras,
            tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),

            modSpoilers = GetVehicleMod(vehicle, 0),
            modFrontBumper = GetVehicleMod(vehicle, 1),
            modRearBumper = GetVehicleMod(vehicle, 2),
            modSideSkirt = GetVehicleMod(vehicle, 3),
            modExhaust = GetVehicleMod(vehicle, 4),
            modFrame = GetVehicleMod(vehicle, 5),
            modGrille = GetVehicleMod(vehicle, 6),
            modHood = GetVehicleMod(vehicle, 7),
            modFender = GetVehicleMod(vehicle, 8),
            modRightFender = GetVehicleMod(vehicle, 9),
            modRoof = GetVehicleMod(vehicle, 10),

            modEngine = GetVehicleMod(vehicle, 11),
            modBrakes = GetVehicleMod(vehicle, 12),
            modTransmission = GetVehicleMod(vehicle, 13),
            modHorns = GetVehicleMod(vehicle, 14),
            modSuspension = GetVehicleMod(vehicle, 15),
            modArmor = GetVehicleMod(vehicle, 16),

            modTurbo = IsToggleModOn(vehicle, 18),
            modSmokeEnabled = IsToggleModOn(vehicle, 20),
            modXenon = IsToggleModOn(vehicle, 22),

            modFrontWheels = GetVehicleMod(vehicle, 23),
            modBackWheels = GetVehicleMod(vehicle, 24),

            modPlateHolder = GetVehicleMod(vehicle, 25),
            modVanityPlate = GetVehicleMod(vehicle, 26),
            modTrimA = GetVehicleMod(vehicle, 27),
            modOrnaments = GetVehicleMod(vehicle, 28),
            modDashboard = GetVehicleMod(vehicle, 29),
            modDial = GetVehicleMod(vehicle, 30),
            modDoorSpeaker = GetVehicleMod(vehicle, 31),
            modSeats = GetVehicleMod(vehicle, 32),
            modSteeringWheel = GetVehicleMod(vehicle, 33),
            modShifterLeavers = GetVehicleMod(vehicle, 34),
            modAPlate = GetVehicleMod(vehicle, 35),
            modSpeakers = GetVehicleMod(vehicle, 36),
            modTrunk = GetVehicleMod(vehicle, 37),
            modHydrolic = GetVehicleMod(vehicle, 38),
            modEngineBlock = GetVehicleMod(vehicle, 39),
            modAirFilter = GetVehicleMod(vehicle, 40),
            modStruts = GetVehicleMod(vehicle, 41),
            modArchCover = GetVehicleMod(vehicle, 42),
            modAerials = GetVehicleMod(vehicle, 43),
            modTrimB = GetVehicleMod(vehicle, 44),
            modTank = GetVehicleMod(vehicle, 45),
            modWindows = GetVehicleMod(vehicle, 46),
            modLivery = GetVehicleLivery(vehicle)
        }
        if Config.VehicleRGBTweak then
            o.color1 = table.pack(GetVehicleCustomPrimaryColour(vehicle))
            o.color2 = table.pack(GetVehicleCustomSecondaryColour(vehicle))
        end
        return o
    else
        return
    end
end

-- max mods for the podium
function SetVehicleMaxMods(vehicle)
    local props = {
        modEngine = 2,
        modBrakes = 2,
        modTransmission = 2,
        modSuspension = 3,
        modTurbo = true,
        -- I added the comma above and the wheels below
        wheels = 4, -- offroad
        modFrontWheels = 5 -- WHEEL_OFFROAD_CHALLENGER
    }
    SetVehicleProperties(vehicle, props)
end

function ForceDeleteEntity(entity)
    SetEntityAsMissionEntity(entity)
    DeleteEntity(entity)
end

function SetModelsAsNoLongerNeeded(models)
    for k, v in pairs(models) do
        SetModelAsNoLongerNeeded(v)
    end
end

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function ReyCastAroundObjects(object, distance, getClosest, debug)
    local finalTable = {}

    if type(object) == "string" then
        finalTable[object] = true
    else
        for k, v in pairs(object) do
            finalTable[v] = true
        end
    end

    local RotationToDirection, StartShapeTestRay, GetShapeTestResult, PlayerPedId, vector3, GetEntityModel,
        GetEntityCoords, DrawLine, GetEntityHeading = RotationToDirection, StartShapeTestRay, GetShapeTestResult,
        PlayerPedId, vector3, GetEntityModel, GetEntityCoords, DrawLine, GetEntityHeading

    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    local distance = distance or 4
    local direction
    local destination

    local closestDistance = 4
    local closestEntity = 0

    for i = -5, 3 do
        direction = RotationToDirection(vector3(0, 0, GetEntityHeading(ped) + (i * 10)))
        destination = {
            x = pos.x + direction.x * distance,
            y = pos.y + direction.y * distance,
            z = pos.z + direction.z * distance
        }

        local ray = StartShapeTestRay(pos.x, pos.y, pos.z, destination.x, destination.y, destination.z, 16,
            PlayerPedId(), 1)
        local _, hit, endCoords, _, entity = GetShapeTestResult(ray)

        if finalTable[GetEntityModel(entity)] then
            if getClosest then
                local d = #(pos - endCoords)
                if d < closestDistance then
                    closestEntity = entity
                    closestDistance = d
                end
            else
                return entity
            end

        end

        if debug then
            DrawLine(pos.x, pos.y, pos.z, destination.x, destination.y, destination.z, 255, 0, 0, 255)
        end
    end

    return closestEntity, closestDistance
end

function RegisterKey(fc, uniqid, description, key, inputDevice)
    if inputDevice == nil then
        inputDevice = "keyboard"
    end
    RegisterCommand(uniqid, fc, false)
    RegisterKeyMapping(uniqid, description, inputDevice, key)
end

function getClosestAnimation(playerPosition, entityPosition, entityRotation, dictionary, variations)
    local bestName = variations[1]
    local bestDistance = 9

    for i, v in ipairs(variations) do
        local offset = GetAnimInitialOffsetPosition(dictionary, v, entityPosition.x, entityPosition.y, entityPosition.z,
            entityRotation.x, entityRotation.y, entityRotation.z, 0.01, 2);
        local distance = GetDistanceBetweenCoords(playerPosition.x, playerPosition.y, playerPosition.z, offset.x,
            offset.y, offset.z, true);
        if distance < bestDistance then
            bestName = v
            bestDistance = distance
        end
    end
    return bestName
end

local lastAnimationTime = -1
local lastSyncedScene = -1

-- destroy actual scene
function DestroyActualAnimationScene()
    NetworkStopSynchronisedScene(lastSyncedScene)
    DisposeSynchronizedScene(lastSyncedScene)
    lastSyncedScene = -1
end

function NativeAnimationTimeoutChecking()
    local unknown = Citizen.InvokeNative(0x16F2683693E537C9)
    local results = Citizen.InvokeNative(0xDDCA9A4E51DADA2B, unknown, -2124244681)
    return results
end

function IsAnimationInProgress()
    local timeAgo = GAME_TIMER - lastAnimationTime
    return timeAgo < Config.CASINO_ANIM_TIMEOUT
end

function StartMachineAnimationSceneAdvanced(position, rotation, sceneName, dict, blendInSpeed, blendOutSpeed, duration,
    flag, playbackRate, p9)
    if NativeAnimationTimeoutChecking() then
        return
    end

    -- don't stop 
    if IsAnimationInProgress() then
        return
    end

    ClearPedSecondaryTask(PlayerPedId())

    lastAnimationTime = GAME_TIMER

    lastSyncedScene = NetworkCreateSynchronisedScene(position.x, position.y, position.z, rotation.x, rotation.y,
        rotation.z, 2, true, false, 1065353216, 0, 1065353216)
    -- NetworkAddPedToSynchronisedScene(PlayerPedId(), lastScene, dict, sceneName, 2.0, -2.0, 5, 0, 1148846080, 0) IT
    NetworkAddPedToSynchronisedScene(PlayerPedId(), lastSyncedScene, dict, sceneName, 2.0, -1.5, 13, flag, 2.0, 0)
    -- NetworkStartSynchronisedScene(lastSyncedScene)
    Citizen.InvokeNative(0x914E6894744915F8, lastSyncedScene)

    return lastSyncedScene
end

function Repeat(t, length)
    return Clamp(t - math.floor(t / length) * length, 0.0, length)
end

function PingPong(t, length)
    t = Repeat(t, length * 2.0)
    return length - math.abs(t - length)
end

function LerpColor(c1, c2, t)
    local x = {Lerp(c1[1], c2[1], t), Lerp(c1[2], c2[2], t), Lerp(c1[3], c2[3], t), Lerp(c1[4], c2[4], t)}
    return {math.ceil(x[1]), math.ceil(x[2]), math.ceil(x[3]), math.ceil(x[4])}
end

function LerpHeading(entity, heading, speed, increaseSpeed, maxDistance, maxFrames)

    local start = GetEntityHeading(entity)
    local actual = start

    CreateThread(function()
        for i = 0, maxFrames, 1 do
            Wait(0)
            actual = LerpAngle(actual, heading, speed)
            speed = speed + increaseSpeed
            SetEntityHeading(entity, actual)

            local distance = Repeat(math.abs(actual - heading), 359.9)

            if distance < maxDistance then
                break
            end
        end
        SetEntityHeading(entity, heading)
    end)
end

function LerpEntityAdvanced(entity, x, y, z, speed)
    local o = {
        hasFinished = false
    }

    local start = GetEntityCoords(entity)
    local actual = {
        x = start.x,
        y = start.y,
        z = start.z
    }
    CreateThread(function()
        while true do
            Wait(0)
            actual.x = Lerp(actual.x, x, speed)
            actual.y = Lerp(actual.y, y, speed)
            actual.z = Lerp(actual.z, z, speed)
            SetEntityCoordsNoOffset(entity, actual.x, actual.y, actual.z, true, true, true)
            if #(vector3(actual.x, actual.y, actual.z) - vector3(x, y, z)) < -5 then
                break
            end
        end
        SetEntityCoordsNoOffset(entity, x, y, z, true, true, true)
        o.hasFinished = true
    end)
    return o
end

function IsEntityInCasino(entity)
    local int = GetInteriorFromEntity(entity)
    local roomCount = GetInteriorRoomCount(int)

    if int == 0 then
        return false
    end

    -- custom casino
    if Config.MapType == 6 then
        return roomCount == 5
    end

    -- k4casino
    if Config.MapType == 4 then
        local c = int ~= 0 and roomCount == 10 and
                      (GetInteriorRoomName(int, 1) == "k4casinomain" or GetInteriorRoomName(int, 2) ==
                          "k4casinoentrance")
        -- toilet room is a part of a different interior
        if not c then
            c = int ~= 0 and roomCount >= 1 and GetInteriorRoomName(int, 1) == "k4restrooms"
        end
        -- office area
        if not c then
            c = int ~= 0 and roomCount >= 6 and GetInteriorRoomName(int, 1) == "k4casinolobby"
        end

        local roomHash = GetRoomKeyFromEntity(entity)
        local roomId = GetInteriorRoomIndexByHash(int, roomHash)

        if roomId ~= -1 then
            local roomName = GetInteriorRoomName(int, roomId)
            if roomName == "k4casinobay" then
                -- ignore in garage
                c = false
            end

        end

        return c
    end
    -- others
    local inside = int ~= 0 and roomCount > 10 and
                       (GetInteriorRoomName(int, 1) == "rm_GamingFloor_01" or GetInteriorRoomName(int, 2) ==
                           "rm_GamingFloor_01")
    return inside
end

function IsEntityNearCoords(entity, coords, maxOffset, ignoreZ)
    if entity == nil then
        return false
    end
    local entityCoords = GetEntityCoords(entity)
    if ignoreZ then
        entityCoords = vector3(entityCoords.x, entityCoords.y, coords.z)
    end
    return #(entityCoords - coords) <= maxOffset
end

function WaitForPedOnCoords(ped, coords, maxOffset, maxTimeMs)
    local endTime = GAME_TIMER + maxTimeMs
    while GAME_TIMER < endTime do
        if IsEntityNearCoords(ped, coords, maxOffset, true) then
            return true
        end
        Wait(33)
    end
    return false
end

function WaitForPlayerOnCoords(coords, maxTimeMs)
    WaitForPedOnCoords(PlayerPedId(), coords, 0.05, maxTimeMs)
end

function removePlaceholderText(inputString)
    local outputString = inputString:gsub("~.-~", "")
    return outputString
end

function ShowHelpNotification(text)
    if not ENABLE_HUD then
        return
    end
    if Config.NotifySystem then
        if Config.NotifySystem == 2 and text and text ~= "" then
            exports['okokNotify']:Alert("", removePlaceholderText(text), 3000, 'info', true)
            return
        elseif Config.NotifySystem == 3 and text and text ~= "" then
            exports['esx_notify']:Notify("info", 3000, removePlaceholderText(text))
            return
        elseif Config.NotifySystem == 4 and text and text ~= "" then
            exports['qb-notify']:Notify(removePlaceholderText(text), "primary", 3000)
            return
        elseif Config.NotifySystem == 5 and text and text ~= "" then
            lib.notify({
                description = text,
                duration = 3000,
                type = 'info'
            })
            return
        end
    end
    BeginTextCommandDisplayHelp("THREESTRINGS")
    if Config.UIFontName and text then
        text = "<font face=\"" .. Config.UIFontName .. "\">" .. text .. "</font>"
    end
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, 5000)
end

function WriteChatMessage(message) -- needs edit.. o.o
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {-1, message}
    })
end

function CreateScaleformHandle(name, model)
    local handle = 0
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, false)
    end
    if not IsNamedRendertargetLinked(GetHashKey(model)) then
        LinkNamedRendertarget(GetHashKey(model))
    end
    if IsNamedRendertargetRegistered(name) then
        handle = GetNamedRendertargetRenderId(name)
    end
    return handle
end

function PushNUIInstructionalButtons(buttons)
    if not ENABLE_HUD then
        return
    end
    INSTRUCTIONAL_BUTTONS_ACTIVE = buttons and #buttons > 0
    SendNUIMessage({
        isGamepad = IsGamepadControl(),
        buttons = buttons,
        action = "drawInstButtons"
    })
end

function PushScaleformButton(scaleform, slot, buttonPad, buttonControl, buttonText, extraControl)
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(slot)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(buttonPad, buttonControl, true))
    if extraControl then
        N_0xe83a3e3557a56640(GetControlInstructionalButton(buttonPad, extraControl, true))
    end
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(buttonText)
    EndTextCommandScaleformString()
    PopScaleformMovieFunctionVoid()
end

function PushScaleformInt(scaleform, method, methodValue)
    PushScaleformMovieFunction(scaleform, method)
    PushScaleformMovieFunctionParameterInt(methodValue)
    PopScaleformMovieFunctionVoid()
end

function PushScaleformFloat(scaleform, method, methodValue)
    PushScaleformMovieFunction(scaleform, method)
    ScaleformMovieMethodAddParamFloat(methodValue)
    PopScaleformMovieFunctionVoid()
end

function PushScaleformBool(scaleform, method, methodValue)
    BeginScaleformMovieMethod(scaleform, method)
    ScaleformMovieMethodAddParamBool(methodValue)
    EndScaleformMovieMethod()
end

function PushScaleformCommandString(scaleform, method, methodValue)
    BeginScaleformMovieMethod(scaleform, method)
    BeginTextCommandScaleformString(methodValue)
    EndTextCommandScaleformString()
    EndScaleformMovieMethod()
end

function PushScaleformVoid(scaleform, method)
    PushScaleformMovieFunction(scaleform, method)
    PopScaleformMovieFunction()
end

function RequestScaleformMovieAndWait(scaleform)
    for i = 1, 3 do
        local movie = TryToLoadScaleformMovie(scaleform)
        if movie then
            if i ~= 1 then
                print("^3[CASINO LOADING] Scaleform '" .. scaleform .. "' was loaded on " .. i .. "# try.^7")
            end
            return movie
        end
    end
end

function RequestIplAndWait(iplName)
    while not IsIplActive(iplName) do
        RequestIpl(iplName)
        Wait(33)
    end
end

function CallScaleformFunction(scaleform, returndata, the_function, ...)
    BeginScaleformMovieMethod(scaleform, the_function)
    local args = {...}

    if args ~= nil then
        for i = 1, #args do
            local arg_type = type(args[i])

            if arg_type == "boolean" then
                ScaleformMovieMethodAddParamBool(args[i])
            elseif arg_type == "number" then
                if not string.find(args[i], '%.') then
                    ScaleformMovieMethodAddParamInt(args[i])
                else
                    ScaleformMovieMethodAddParamFloat(args[i])
                end
            elseif arg_type == "string" then
                ScaleformMovieMethodAddParamTextureNameString(args[i])
            end
        end

        if not returndata then
            EndScaleformMovieMethod()
        else
            return EndScaleformMovieMethodReturnValue()
        end
    end
end

function ShowFullscreenBonusNotify(captionText, mainText, descriptionText, color)
    Citizen.CreateThread(function()
        local scaleform = RequestScaleformMovieAndWait('HEIST_CELEBRATION')
        local scaleform_bg = RequestScaleformMovieAndWait('HEIST_CELEBRATION_BG')
        local scaleform_fg = RequestScaleformMovieAndWait('HEIST_CELEBRATION_FG')
        local scaleform_list = {scaleform, scaleform_bg, scaleform_fg}
        if not color then
            color = "HUD_COLOUR_PAUSE_BG"
        end

        for key, scaleform_handle in pairs(scaleform_list) do
            CallScaleformFunction(scaleform_handle, false, "SET_PAUSE_DURATION", 5000.0)
            CallScaleformFunction(scaleform_handle, false, "CREATE_STAT_WALL", 1, color, 1)
            CallScaleformFunction(scaleform_handle, false, "ADD_BACKGROUND_TO_WALL", 1, 50, 1)
            CallScaleformFunction(scaleform_handle, false, "ADD_MISSION_RESULT_TO_WALL", 1, captionText, mainText,
                descriptionText, true, true, true)
            CallScaleformFunction(scaleform_handle, false, "SHOW_STAT_WALL", 1)
            CallScaleformFunction(scaleform_handle, false, "createSequence", 1, 1, 1)
            CallScaleformFunction(scaleform_handle, false, "PAUSE", 1)
        end

        local timeout = GAME_TIMER + 3000
        CreateThread(function()
            Wait(500)
            PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", 1)
            StartScreenEffect("HeistCelebToast")
        end)

        while GAME_TIMER < timeout do
            Citizen.Wait(1)
            DrawScaleformMovieFullscreenMasked(scaleform_bg, scaleform_fg, 255, 255, 255, 50)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end
    end)
end

_GetClosestVehicle = function(coord, distance)
    local entity = 0
    local nearest = -1
    for k, vehicle in pairs(GetGamePool('CVehicle')) do
        local dist = #(GetEntityCoords(vehicle) - coord)
        if dist < distance and nearest == -1 or nearest > dist then
            nearest = dist
            entity = vehicle
        end
    end
    return entity
end

GetPlayerPosition = function()
    return GetEntityCoords(PlayerPedId())
end

function SetCroupierSkin(dealerPed, skin)
    if skin == 0 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 3, 0, 0)
        SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 3, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 3, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
        else
            SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
        end
    elseif skin == 1 then
        SetPedDefaultComponentVariation(dealerPed)
        -- SetPedComponentVariation(dealerPed, 0, 2, 2, 0)
        SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 4, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 0, 3, 0)
        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
        else
            SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
        end
    elseif skin == 2 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 2, 1, 0)
        SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 0, 3, 0)
        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
        else
            SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
        end
    elseif skin == 3 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 3, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 1, 3, 0)
        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 3, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
        else
            SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
        end
    elseif skin == 4 then
        SetPedDefaultComponentVariation(dealerPed)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 0, 4, 2, 0)
        end
        SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 3, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
        else
            SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
        end
    elseif skin == 5 then
        SetPedDefaultComponentVariation(dealerPed)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 0, 4, 0, 0)
        else
            SetPedComponentVariation(dealerPed, 0, 6, 0, 0)
        end
        SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
        else
            SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
        end
    elseif skin == 6 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 4, 1, 0)
        SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 4, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 3, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
        else
            SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
        end
    elseif skin == 7 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 1, 1, 0)
        SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 0, 3, 0)
        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
    elseif skin == 8 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 1, 1, 0)
        SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 1, 1, 0)

        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        if not IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 3, 1, 3, 0)
            SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
        end
        SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
    elseif skin == 9 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 2, 3, 0)
        SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
    elseif skin == 10 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 2, 1, 0)
        SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
        if IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 2, 2, 0, 0)
        else
            SetPedComponentVariation(dealerPed, 2, 2, 1, 0)
        end
        SetPedComponentVariation(dealerPed, 3, 3, 3, 0)
        SetPedComponentVariation(dealerPed, 4, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        if not IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 8, 3, 0, 0)
        end
        SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
    elseif skin == 11 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 3, 0, 0)
        SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 3, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 0, 1, 0)
        SetPedComponentVariation(dealerPed, 4, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
        SetPedPropIndex(dealerPed, 1, 0, 0, false)
    elseif skin == 12 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 3, 1, 0)
        SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 3, 1, 0)
        SetPedComponentVariation(dealerPed, 4, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
        if not IsPedMale(dealerPed) then
            SetPedComponentVariation(dealerPed, 3, 1, 1, 0)
            SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
        end
        SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
    elseif skin == 13 then
        SetPedDefaultComponentVariation(dealerPed)
        SetPedComponentVariation(dealerPed, 0, 4, 0, 0)
        SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 2, 4, 0, 0)
        SetPedComponentVariation(dealerPed, 3, 2, 1, 0)
        SetPedComponentVariation(dealerPed, 4, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 7, 1, 0, 0)
        SetPedComponentVariation(dealerPed, 8, 2, 0, 0)
        SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
        SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
        SetPedPropIndex(dealerPed, 1, 0, 0, false)
    end
end

function GetHeadOverlayData(ped)
    local headData = {}
    for i = 1, #head_overlays do
        local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(ped,
            i - 1)
        if retval then
            headData[i] = {}
            headData[i].name = head_overlays[i]
            headData[i].overlayValue = overlayValue
            headData[i].colourType = colourType
            headData[i].firstColour = firstColour
            headData[i].secondColour = secondColour
            headData[i].overlayOpacity = overlayOpacity
        end
    end
    return headData
end

function GetHeadOverlayData(ped)
    local headData = {}
    for i = 1, #head_overlays do
        local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(ped,
            i - 1)
        if retval then
            headData[i] = {}
            headData[i].name = head_overlays[i]
            headData[i].overlayValue = overlayValue
            headData[i].colourType = colourType
            headData[i].firstColour = firstColour
            headData[i].secondColour = secondColour
            headData[i].overlayOpacity = overlayOpacity
        end
    end
    return headData
end

function GetHeadStructureData(ped)
    local structure = {}
    for i = 1, #face_features do
        structure[face_features[i]] = GetPedFaceFeature(ped, i - 1)
    end
    return structure
end

function GetHeadStructure(ped)
    local structure = {}
    for i = 1, #face_features do
        structure[i] = GetPedFaceFeature(ped, i - 1)
    end
    return structure
end

function GetPedHair(ped)
    local hairColor = {}
    hairColor[1] = GetPedHairColor(ped)
    hairColor[2] = GetPedHairHighlightColor(ped)
    return hairColor
end

function GetPedHeadBlendData(ped)
    local blob = string.rep("\0\0\0\0\0\0\0\0", 6 + 3 + 1) -- Generate sufficient struct memory.
    if not Citizen.InvokeNative(0x2746BD9D88C5C5D0, ped, blob, true) then -- Attempt to write into memory blob.
        return nil
    end

    return {
        shapeFirst = string.unpack("<i4", blob, 1),
        shapeSecond = string.unpack("<i4", blob, 9),
        shapeThird = string.unpack("<i4", blob, 17),
        skinFirst = string.unpack("<i4", blob, 25),
        skinSecond = string.unpack("<i4", blob, 33),
        skinThird = string.unpack("<i4", blob, 41),
        shapeMix = string.unpack("<f", blob, 49),
        skinMix = string.unpack("<f", blob, 57),
        thirdMix = string.unpack("<f", blob, 65),
        hasParent = string.unpack("b", blob, 73) ~= 0
    }
end

function SetHeadStructure(ped, data)
    for i = 1, #face_features do
        SetPedFaceFeature(ped, i - 1, data[i])
    end
end

function SetHeadOverlayData(ped, data)
    if json.encode(data) ~= "[]" then
        for i = 1, #head_overlays do
            SetPedHeadOverlay(ped, i - 1, tonumber(data[i].overlayValue), tonumber(data[i].overlayOpacity))
            -- SetPedHeadOverlayColor(ped, i-1, data[i].colourType, data[i].firstColour, data[i].secondColour)
        end

        SetPedHeadOverlayColor(ped, 0, 0, tonumber(data[1].firstColour), tonumber(data[1].secondColour))
        SetPedHeadOverlayColor(ped, 1, 1, tonumber(data[2].firstColour), tonumber(data[2].secondColour))
        SetPedHeadOverlayColor(ped, 2, 1, tonumber(data[3].firstColour), tonumber(data[3].secondColour))
        SetPedHeadOverlayColor(ped, 3, 0, tonumber(data[4].firstColour), tonumber(data[4].secondColour))
        SetPedHeadOverlayColor(ped, 4, 2, tonumber(data[5].firstColour), tonumber(data[5].secondColour))
        SetPedHeadOverlayColor(ped, 5, 2, tonumber(data[6].firstColour), tonumber(data[6].secondColour))
        SetPedHeadOverlayColor(ped, 6, 0, tonumber(data[7].firstColour), tonumber(data[7].secondColour))
        SetPedHeadOverlayColor(ped, 7, 0, tonumber(data[8].firstColour), tonumber(data[8].secondColour))
        SetPedHeadOverlayColor(ped, 8, 2, tonumber(data[9].firstColour), tonumber(data[9].secondColour))
        SetPedHeadOverlayColor(ped, 9, 0, tonumber(data[10].firstColour), tonumber(data[10].secondColour))
        SetPedHeadOverlayColor(ped, 10, 1, tonumber(data[11].firstColour), tonumber(data[11].secondColour))
        SetPedHeadOverlayColor(ped, 11, 0, tonumber(data[12].firstColour), tonumber(data[12].secondColour))
    end
end

-- clone ped manually
function _ClonePed(ped)
    local clone = CreatePed(2, GetEntityModel(ped), GetEntityCoords(ped), GetEntityHeading(ped), false, false)

    local hat = GetPedPropIndex(ped, 0)
    local hat_texture = GetPedPropTextureIndex(ped, 0)

    local glasses = GetPedPropIndex(ped, 1)
    local glasses_texture = GetPedPropTextureIndex(ped, 1)

    local ear = GetPedPropIndex(ped, 2)
    local ear_texture = GetPedPropTextureIndex(ped, 2)

    local watch = GetPedPropIndex(ped, 6)
    local watch_texture = GetPedPropTextureIndex(ped, 6)

    local wrist = GetPedPropIndex(ped, 7)
    local wrist_texture = GetPedPropTextureIndex(ped, 7)

    local head_drawable = GetPedDrawableVariation(ped, 0)
    local head_palette = GetPedPaletteVariation(ped, 0)
    local head_texture = GetPedTextureVariation(ped, 0)

    local beard_drawable = GetPedDrawableVariation(ped, 1)
    local beard_palette = GetPedPaletteVariation(ped, 1)
    local beard_texture = GetPedTextureVariation(ped, 1)

    local hair_drawable = GetPedDrawableVariation(ped, 2)
    local hair_palette = GetPedPaletteVariation(ped, 2)
    local hair_texture = GetPedTextureVariation(ped, 2)

    local torso_drawable = GetPedDrawableVariation(ped, 3)
    local torso_palette = GetPedPaletteVariation(ped, 3)
    local torso_texture = GetPedTextureVariation(ped, 3)

    local legs_drawable = GetPedDrawableVariation(ped, 4)
    local legs_palette = GetPedPaletteVariation(ped, 4)
    local legs_texture = GetPedTextureVariation(ped, 4)

    local hands_drawable = GetPedDrawableVariation(ped, 5)
    local hands_palette = GetPedPaletteVariation(ped, 5)
    local hands_texture = GetPedTextureVariation(ped, 5)

    local foot_drawable = GetPedDrawableVariation(ped, 6)
    local foot_palette = GetPedPaletteVariation(ped, 6)
    local foot_texture = GetPedTextureVariation(ped, 6)

    local acc1_drawable = GetPedDrawableVariation(ped, 7)
    local acc1_palette = GetPedPaletteVariation(ped, 7)
    local acc1_texture = GetPedTextureVariation(ped, 7)

    local acc2_drawable = GetPedDrawableVariation(ped, 8)
    local acc2_palette = GetPedPaletteVariation(ped, 8)
    local acc2_texture = GetPedTextureVariation(ped, 8)

    local acc3_drawable = GetPedDrawableVariation(ped, 9)
    local acc3_palette = GetPedPaletteVariation(ped, 9)
    local acc3_texture = GetPedTextureVariation(ped, 9)

    local mask_drawable = GetPedDrawableVariation(ped, 10)
    local mask_palette = GetPedPaletteVariation(ped, 10)
    local mask_texture = GetPedTextureVariation(ped, 10)

    local aux_drawable = GetPedDrawableVariation(ped, 11)
    local aux_palette = GetPedPaletteVariation(ped, 11)
    local aux_texture = GetPedTextureVariation(ped, 11)

    local hair_color = GetPedHairColor(ped)
    local hair_highlight_color = GetPedHairHighlightColor(ped)

    SetPedPropIndex(clone, 0, hat, hat_texture, 1)
    SetPedPropIndex(clone, 1, glasses, glasses_texture, 1)
    SetPedPropIndex(clone, 2, ear, ear_texture, 1)
    SetPedPropIndex(clone, 6, watch, watch_texture, 1)
    SetPedPropIndex(clone, 7, wrist, wrist_texture, 1)

    SetPedComponentVariation(clone, 0, head_drawable, head_texture, head_palette)
    SetPedComponentVariation(clone, 1, beard_drawable, beard_texture, beard_palette)
    SetPedComponentVariation(clone, 2, hair_drawable, hair_texture, hair_palette)
    SetPedComponentVariation(clone, 3, torso_drawable, torso_texture, torso_palette)
    SetPedComponentVariation(clone, 4, legs_drawable, legs_texture, legs_palette)
    SetPedComponentVariation(clone, 5, hands_drawable, hands_texture, hands_palette)
    SetPedComponentVariation(clone, 6, foot_drawable, foot_texture, foot_palette)
    SetPedComponentVariation(clone, 7, acc1_drawable, acc1_texture, acc1_palette)
    SetPedComponentVariation(clone, 8, acc2_drawable, acc2_texture, acc2_palette)
    SetPedComponentVariation(clone, 9, acc3_drawable, acc3_texture, acc3_palette)
    SetPedComponentVariation(clone, 10, mask_drawable, mask_texture, mask_palette)
    SetPedComponentVariation(clone, 11, aux_drawable, aux_texture, aux_palette)

    if HasPedHeadBlendFinished(ped) then
        local headBlend = GetPedHeadBlendData(ped)
        local headOverlay = GetHeadOverlayData(ped)
        local headStructure = GetHeadStructure(ped)
        local hairColor = GetPedHair(ped)

        if headBlend then
            SetPedHeadBlendData(clone, headBlend.shapeFirst, headBlend.shapeSecond, headBlend.shapeThird,
                headBlend.skinFirst, headBlend.skinSecond, headBlend.skinThird, headBlend.shapeMix, headBlend.skinMix,
                headBlend.thirdMix, false)
        end
        if headStructure then
            SetHeadStructure(clone, headStructure)
        end
        if hairColor then
            SetPedHairColor(clone, tonumber(hairColor[1]), tonumber(hairColor[2]))
        end
        if headOverlay then
            SetHeadOverlayData(clone, headOverlay)
        end
    end

    return clone
end

-- sort array of entities by distance from coords
function SortByDistance(array, c)
    local s = {}

    function FindIndex(d)
        for i = 1, #(s) do
            local a = #(GetEntityCoords(s[i]) - c)
            if d < a then
                return i
            end
        end
        return #(s) + 1
    end

    for k, v in pairs(array) do
        local d = #(GetEntityCoords(v) - c)
        local i = #(s) == 0 and 1 or FindIndex(d)
        table.insert(s, i, v)
    end
    return s
end

function FullscreenPrompt(caption, message, onclose, bottomText)
    Citizen.CreateThread(function()
        local keys = {}
        if onclose then
            keys = {{
                key = 176,
                title = Translation.Get("BTN_YES")
            }, {
                key = 177,
                title = Translation.Get("BTN_NO")
            }}
        else
            keys = {{
                key = 177,
                title = Translation.Get("BTN_CLOSE")
            }}
        end

        if not bottomText then
            bottomText = ""
        end

        PROMPT_ACTIVE = true
        PushNUIInstructionalButtons(keys)
        local s = RequestScaleformMovie("POPUP_WARNING")
        local t = GetGameTimer() + 2000
        while not HasScaleformMovieLoaded(s) and GetGameTimer() < t do
            Wait(33)
        end

        if GetGameTimer() < t then
            CallScaleformFunction(s, false, "SHOW_POPUP_WARNING", 1000, caption, message, "", true, 0, bottomText)
            while true do
                DisableControlAction(2, 176, true)
                DisableControlAction(2, 191, true)
                DisableControlAction(2, 177, true)

                if IsDisabledControlJustPressed(2, 176) or IsDisabledControlJustPressed(2, 191) then
                    if onclose then
                        onclose(true)
                    end
                    break
                end

                if IsDisabledControlJustPressed(2, 177) then
                    if onclose then
                        onclose(false)
                    end
                    break
                end

                DrawScaleformMovieFullscreen(s, 255, 255, 255, 255, 0)
                Wait(0)
            end
        else
            onclose(true)
        end
        SetScaleformMovieAsNoLongerNeeded(s)
        PushNUIInstructionalButtons(nil)
        Wait(1000)
        PROMPT_ACTIVE = false
    end)
end
