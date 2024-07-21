local inTelescope = false
local gameplayCamera = {}

local camera = nil
local scaleform = nil
local instScaleform = nil
local fov = 50.0

local maxLeft = 0
local maxRight = 0

Telescope = {}

Telescope.Animations = {
	["default"] = {
		enter = "enter_front",
		enterTime = 1500,
		exit = "exit_front",
		idle = "idle"
	},
	["public"] = {
		enter = "public_enter_front",
		enterTime = 1500,
		exit = "public_exit_front",
		idle = "public_idle"
	},
	["upright"] = {
		enter = "upright_enter_front",
		enterTime = 2500,
		exit = "upright_exit_front",
		idle = "upright_idle"
	}
}

Telescope.Models = {
	[1186047406] = { MaxHorizontal = 55.0, MaxVertical = 20.0, offset = vector3(0.0, 0.95, 0.0), headingOffset = 180.0, animation = "public", cameraOffset = vector3(0.0, -0.5, 0.7), scaleform = "OBSERVATORY_SCOPE" },
	[844159446] = { MaxHorizontal = 55.0, MaxVertical = 20.0, offset = vector3(0.0, -0.85, 1.0), animation = "upright", cameraOffset = vector3(0.0, 0.2, 1.7), scaleform = "BINOCULARS" },
	[-656927072] = { MaxHorizontal = 55.0, MaxVertical = 35.0, offset = vector3(1.25, 0.0, 0.0), headingOffset = 90.0, animation = "default", cameraOffset = vector3(-0.25, 0.0, 1.3), scaleform = "OBSERVATORY_SCOPE" }
}

Telescope.Telescopes = {
	[1] = { model = 1186047406, coords = vector3(-490.6682, 1095.387, 319.9773) },
	[2] = { model = 1186047406, coords = vector3(-487.7137, 1094.643, 319.9769) },
	[3] = { model = 1186047406, coords = vector3(-466.6990, 1088.443, 327.5582) },
	[4] = { model = 1186047406, coords = vector3(-452.7089, 1082.787, 332.4135) },
	[5] = { model = 1186047406, coords = vector3(-457.2304, 1101.254, 332.4135) },
	[6] = { model = 1186047406, coords = vector3(-451.7881, 1099.751, 332.4135) },
	[7] = { model = 1186047406, coords = vector3(-415.1138, 1089.622, 332.4135) },
	[8] = { model = 1186047406, coords = vector3(-409.6714, 1088.119, 332.4135) },
	[9] = { model = 1186047406, coords = vector3(-401.0349, 1051.714, 323.721) },
	[10] = { model = 1186047406, coords = vector3(2615.951, 3667.427, 101.9804) },
	[11] = { model = 1186047406, coords = vector3(2613.160, 3662.852, 101.9836) },
	[12] = { model = 1186047406, coords = vector3(-1722.135, -1014.014, 5.067778) },
	[13] = { model = 1186047406, coords = vector3(-1719.312, -1016.231, 5.140132) },
	[14] = { model = 1186047406, coords = vector3(-1677.599, -989.2823, 7.260609) },
	[15] = { model = 1186047406, coords = vector3(-1682.565, -1005.748, 7.264191) },
	[16] = { model = 1186047406, coords = vector3(-1704.427, -1058.541, 12.89529) },
	[17] = { model = 1186047406, coords = vector3(-1839.998, -1166.770, 12.8953) },
	[18] = { model = 1186047406, coords = vector3(-1852.887, -1182.131, 12.8953) },
	[19] = { model = 1186047406, coords = vector3(-1865.726, -1197.432, 12.8953) },
	[20] = { model = 1186047406, coords = vector3(-1879.108, -1213.380, 12.898) },
	[21] = { model = 1186047406, coords = vector3(-1867.321, -1223.522, 12.898) },
	[22] = { model = 1186047406, coords = vector3(-1856.398, -1232.756, 12.91837) },
	[23] = { model = 1186047406, coords = vector3(-1838.830, -1247.536, 12.91732) },
	[24] = { model = 1186047406, coords = vector3(-1823.529, -1260.374, 12.918) },
	[25] = { model = 1186047406, coords = vector3(-1826.419, -1270.177, 8.503754) },
	[26] = { model = 1186047406, coords = vector3(-1841.719, -1257.338, 8.5031) },
	[27] = { model = 1186047406, coords = vector3(-1857.081, -1244.448, 8.50415) },
	[28] = { model = 844159446, coords = vector3(499.8335, 5602.674, 796.9147) },
	[29] = { model = 844159446, coords = vector3(503.3787, 5602.383, 796.9147) },
	[30] = { model = -656927072, coords = vector3(13.73517, 528.4813, 174.2378) },
	[31] = { model = -656927072, coords = vector3(-667.9016, 845.2842, 224.6442) },
	[32] = { model = -656927072, coords = vector3(-1018.618, 658.7, 160.8932) },
	[33] = { model = -656927072, coords = vector3(-130.2234, -645.0045, 168.4174) },
	[34] = { model = -656927072, coords = vector3(-1473.417, -543.9343, 73.04141) },
	[35] = { model = -656927072, coords = vector3(-15.94042, -580.2412, 79.02798) },
	[36] = { model = -656927072, coords = vector3(-774.7643, 604.7314, 143.3283) },
	[37] = { model = -656927072, coords = vector3(-662.9636, 582.7271, 144.5675) },
	[38] = { model = -656927072, coords = vector3(-570.1771, 640.1734, 145.0294) },
	[39] = { model = -656927072, coords = vector3(-851.1698, 671.2417, 152.0503) },
	[40] = { model = -656927072, coords = vector3(-1282.699, 429.0291, 97.09206) },
	[41] = { model = -656927072, coords = vector3(-162.235, 479.5696, 136.8414) },
	[42] = { model = -656927072, coords = vector3(126.4659, 540.1469, 183.4945) },
	[43] = { model = -656927072, coords = vector3(327.7837, 421.3323, 148.5685) },
	[44] = { model = -656927072, coords = vector3(375.5592, 401.9527, 145.0975) },
	[45] = { model = -656927072, coords = vector3(-12.571, -581.1641, 98.44279) },
	[46] = { model = -656927072, coords = vector3(-44.62522, -578.5092, 88.32477) },
	[47] = { model = -656927072, coords = vector3(-260.373, -941.1046, 75.44127) },
	[48] = { model = -656927072, coords = vector3(-282.813, -967.2342, 90.72084) },
	[49] = { model = -656927072, coords = vector3(-880.5233, -442.9293, 124.7444) },
	[50] = { model = -656927072, coords = vector3(-918.014, -446.9025, 119.817) },
	[51] = { model = -656927072, coords = vector3(-901.0436, -425.5372, 93.67105) },
	[52] = { model = -656927072, coords = vector3(-912.1877, -386.501, 113.2719) },
	[53] = { model = -656927072, coords = vector3(-895.6904, -368.2518, 83.69043) },
	[54] = { model = -656927072, coords = vector3(-934.3463, -383.0493, 107.6502) },
	[55] = { model = -656927072, coords = vector3(-1475.581, -539.8524, 55.13894) },
	[56] = { model = -656927072, coords = vector3(-1475.581, -539.8524, 67.76656) },
	[57] = { model = -656927072, coords = vector3(-1557.817, -580.1621, 108.1199) },
	[58] = { model = -656927072, coords = vector3(-1368.97, -468.4037, 71.63905) },
	[59] = { model = -656927072, coords = vector3(-625.4163, 59.26805, 106.237) },
	[60] = { model = -656927072, coords = vector3(-612.4269, 39.68902, 97.1973) },
	[61] = { model = -656927072, coords = vector3(-575.95, 48.04946, 91.83607) },
}

local function SetupInstructions()
    instScaleform = RequestScaleformMovie("instructional_buttons")
    while not HasScaleformMovieLoaded(instScaleform) do
        Citizen.Wait(10)
    end
    
    DrawScaleformMovieFullscreen(instScaleform, 255, 255, 45,110,185)
    
    PushScaleformMovieFunction(instScaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(instScaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(instScaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    ScaleformMovieMethodAddParamPlayerNameString("~INPUT_TALK~")
    BeginTextCommandScaleformString("STRING")
	AddTextComponentSubstringPlayerName("Arrêter de regarder dans le telescope")
	EndTextCommandScaleformString(0, 0, 1, -1)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(instScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(instScaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
end

local function GetDifference(num1, num2)
	if num1 > num2 then
		return num1 - num2
	else
		return num2 - num1
	end
end

local function RotationToHeading(rotation)
    local heading = rotation
    if heading < 0 then 
        heading = heading*-1 
        heading = heading + GetDifference(heading, 180.0)*2
    end
    return heading
end

local function CreateTelescopeCamera(entity, data)
    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    local coords = GetOffsetFromEntityInWorldCoords(entity, data.cameraOffset)
    local rotation = GetEntityRotation(entity, 5).z
    if data.headingOffset then
        rotation = rotation + data.headingOffset 
        if rotation > 360.0 then rotation = rotation - 360.0 end
    end

    SetCamCoord(camera, coords.x, coords.y, coords.z)
    SetCamRot(camera, 0.0, 0.0, rotation, 2)

    SetExtraTimecycleModifier("telescope")

    scaleform = RequestScaleformMovie(data.scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(10)
    end
    local xres,yres = GetActiveScreenResolution()
    BeginScaleformMovieMethod(scaleform, "SET_DISPLAY_CONFIG")
    ScaleformMovieMethodAddParamInt(xres)
    ScaleformMovieMethodAddParamInt(yres)
    ScaleformMovieMethodAddParamInt(5)
    ScaleformMovieMethodAddParamInt(5)
    ScaleformMovieMethodAddParamInt(5)
    ScaleformMovieMethodAddParamInt(5)
    ScaleformMovieMethodAddParamBool(GetIsWidescreen())
    ScaleformMovieMethodAddParamBool(GetIsHidef())
    ScaleformMovieMethodAddParamBool(false)
    EndScaleformMovieMethod()

    RenderScriptCams(camera, 0, 0, false, false)
end

local function HideHudThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

local function HandleZoom()
	if GetDisabledControlNormal(0, 32) ~= 0.0 or GetDisabledControlNormal(0, 335) ~= 0.0 then
        fov = math.max(fov - 5.0, 5.0)
    end
    if GetDisabledControlNormal(0, 33) ~= 0.0 or GetDisabledControlNormal(0, 336) ~= 0.0 then
        fov = math.min(fov + 5.0, 50.0)
    end
    local current_fov = GetCamFov(camera)
    if math.abs(fov-current_fov) < 0.1 then
        fov = current_fov
    end
    SetCamFov(camera, current_fov + (fov - current_fov)*0.05)
end

local function HandleMovement(maxVertical)
    local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)

	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        local zoomValue = (1.0/(50.0-5.0))*(fov-5.0)
        local rotation = GetCamRot(camera, 2)
        local heading = RotationToHeading(rotation.z)

        local newX = math.max(math.min(maxVertical, rotation.x + rightAxisY*-1.0*(3.0)*(zoomValue+0.1)), maxVertical*-1)
        local newZ = rotation.z

        if not (heading > maxLeft and rightAxisX < 0.0) and not (heading < maxRight and rightAxisX > 0.0) then
            newZ = rotation.z + rightAxisX*-1.0*(3.0)*(zoomValue+0.1)
        end

		SetCamRot(camera, newX, 0.0, newZ, 2)
	end
end

local function GetClosestTelescope()
    local closest = 0
    local closestDist = 6.0
    local coords = GetEntityCoords(PlayerPedId())

    for model, data in pairs(Telescope.Models) do
        local entity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 6.0, model, false, false, false)
        if entity ~= 0 then
            local entityCoords = GetEntityCoords(entity)
            local dist = #(coords-entityCoords)
            if dist < closestDist then
                closest = entity
                closestDist = dist
            end
        end
    end
   
    return closest
end

local function UseTelescope(entity)
    local playerPed = PlayerPedId()
    local data = Telescope.Models[GetEntityModel(entity)]
    local offsetCoords = GetOffsetFromEntityInWorldCoords(entity, data.offset)
    local prevDist = #(GetEntityCoords(playerPed)-offsetCoords)
    local ticks = 0

        inTelescope = true
        TaskGotoEntityOffsetXy(playerPed, entity, 5000, data.offset, 1.0, true)

        while true do
            local dist = #(GetEntityCoords(playerPed)-offsetCoords)
            if dist < 0.5 then
                break
            elseif GetDifference(dist, prevDist) < 0.06 then
                break
            elseif dist > 8.0 or ticks > 12 then
                inTelescope = false
                return
            end

            prevDist = dist
            ticks = ticks + 1
            Citizen.Wait(250)
        end

        ClearPedTasks(playerPed)
        local heading = GetEntityHeading(entity)
        if data.headingOffset then 
            heading = heading + data.headingOffset
            if heading > 360.0 then heading = heading - 360.0 end
        end

        local difference = GetDifference(heading, GetEntityHeading(playerPed))
        if difference > 10.0 then
            TaskAchieveHeading(playerPed, heading, 1250)
            Citizen.Wait(1250)

            difference = GetDifference(heading, GetEntityHeading(playerPed))
            if difference > 10.0 then
                SetEntityHeading(playerPed, heading)
            end
        end

        local dist = #(GetEntityCoords(playerPed)-offsetCoords)
        if dist > 0.3 then
            SetEntityCoords(playerPed, vector3(offsetCoords.x, offsetCoords.y, offsetCoords.z-1.0))
        end

        local animation = Telescope.Animations[data.animation]
        RequestAnimDict("mini@telescope")
        while not HasAnimDictLoaded("mini@telescope") do
            Citizen.Wait(10)
        end
        TaskPlayAnim(playerPed, "mini@telescope", animation.enter, 2.0, 2.0, -1, 2, 0, false, false, false)

        gameplayCamera.heading = GetGameplayCamRelativeHeading()
        gameplayCamera.pitch = GetGameplayCamRelativePitch()

        Citizen.Wait(animation.enterTime)
        DoScreenFadeOut(500)
        Citizen.Wait(600)

        TaskPlayAnim(playerPed, "mini@telescope", animation.idle, 2.0, 2.0, -1, 1, 0, false, false, false)
        CreateTelescopeCamera(entity, data)
        SetupInstructions()
        Citizen.CreateThread(function()
            DoScreenFadeIn(500)
        end)

        local tick = 0
        local doAnim = true
        fov = 50.0

        maxLeft = heading+data.MaxHorizontal
        if maxLeft > 360.0 then maxLeft = maxLeft - 360.0 end

        maxRight = heading-data.MaxHorizontal
        if maxRight < 0.0 then maxRight = maxRight + 360.0 end

        while true do
            -- Handle the movement and button inputs every frame
            HandleZoom()
            HandleMovement(data.MaxVertical)

            if IsControlJustPressed(0, 46) then
                break
            end

            -- Only handle "less important" stuff every 100 frames
            if tick >= 100 then
                if #(GetEntityCoords(playerPed)-offsetCoords) > 2.0 or IsEntityDead(playerPed) then
                    doAnim = false
                    break
                end
                tick = 0
            end

            -- Draw the scaleform
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)

            -- Draw instructions
            DrawScaleformMovieFullscreen(instScaleform, 255, 255, 255, 255, 0)

            -- Hide hud
            HideHudThisFrame()

            tick = tick + 1
            Citizen.Wait(0)
        end

        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            Citizen.Wait(0)
        end
        Citizen.Wait(150)

        RenderScriptCams(cam, 0, false, 0, false, false)
        DestroyCam(cam, 0)

        ClearExtraTimecycleModifier()
        SetScaleformMovieAsNoLongerNeeded(scaleform)
        SetScaleformMovieAsNoLongerNeeded(instScaleform)

        SetGameplayCamRelativeHeading(gameplayCamera.heading)
        SetGameplayCamRelativePitch(gameplayCamera.pitch, 1.0)

        DoScreenFadeIn(500)
        Citizen.Wait(500)

        if doAnim then
            TaskPlayAnim(playerPed, "mini@telescope", animation.exit, 2.0, 1.0, -1, 0, 0, false, false, false)
            Citizen.Wait(1500)
        else
            ClearPedTasks(playerPed)
        end
        inTelescope = false
        RemoveAnimDict("mini@telescope")
end

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local coords = GetEntityCoords(PlayerPedId())
        local closest = 0
        local distance = 1000

        if not inTelescope then
            for index, data in pairs(Telescope.Telescopes) do
                local dist = #(data.coords-coords)
                if dist < distance then
                    closest = index
                    distance = dist
                end
            end

            if closest ~= 0 then
                if distance < 1.5 then
                    sleep = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour regarder dans le ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~télescope~s~.")
                    if IsControlJustPressed(0, 46) then
                        local telescope = GetClosestTelescope()
                        if telescope ~= 0 then
                            UseTelescope(telescope)
                        end
                    end
                else
                    sleep = distance*20
                end
            end
        else
            sleep = 500
        end

        Citizen.Wait(sleep)
    end
end)