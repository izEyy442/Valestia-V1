Visual = Visual or {};

local function AddLongString(txt)
    for i = 100, string.len(txt), 99 do
        local sub = string.sub(txt, i, i + 99)
        AddTextComponentSubstringPlayerName(sub)
    end
end

function Visual.Popup()

end

function Visual.Radar()

end

function Visual.Subtitle(text, time)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(time and math.ceil(time) or 0, true)
end

function Visual.FloatingHelpText(text, sound, loop)
    BeginTextCommandDisplayHelp("jamyfafi")
    AddTextComponentSubstringPlayerName(text)
    if string.len(text) > 99 then
        AddLongString(text)
    end
    EndTextCommandDisplayHelp(0, loop or 0, sound or true, -1)
end

function Visual.Prompt(text, spinner)
    BeginTextCommandBusyspinnerOn("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandBusyspinnerOn(spinner or 1)
end

function Visual.PromptDuration(duration, text, spinner)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        Visual.Prompt(text, spinner)
        Citizen.Wait(duration)
        if (BusyspinnerIsOn()) then
            BusyspinnerOff();
        end
    end)
end


---- event from server to show notification
RegisterNetEvent("RageUI:Popup")
AddEventHandler("RageUI:Popup", function(array)
    RageUI.Popup(array)
end)

---Popup
---@param array table
---@public
function RageUI.Popup(array)
    ClearPrints()
    if (array.colors == nil) then
        SetNotificationBackgroundColor(140)
    else
        SetNotificationBackgroundColor(array.colors)
    end
    SetNotificationTextEntry("STRING")
    if (array.message == nil) then
        error("Missing arguments, message")
    else
        AddTextComponentString(tostring(array.message))
    end
    DrawNotification(false, true)
    if (array.sound ~= nil) then
        if (array.sound.audio_name ~= nil) then
            if (array.sound.audio_ref ~= nil) then
                PlaySoundFrontend(-1, array.sound.audio_name, array.sound.audio_ref, true)
            else
                error("Missing arguments, audio_ref")
            end
        else
            error("Missing arguments, audio_name")
        end
    end
end


---PopupChar
---@param array table
---@public
function RageUI.PopupChar(array)
    if (array.colors == nil) then
        SetNotificationBackgroundColor(140)
    else
        SetNotificationBackgroundColor(array.colors)
    end
    SetNotificationTextEntry("STRING")
    if (array.message == nil) then
        error("Missing arguments, message")
    else
        AddTextComponentString(tostring(array.message))
    end
    if (array.request_stream_texture_dics ~= nil) then
        RequestStreamedTextureDict(array.request_stream_texture_dics)
    end
    if (array.picture ~= nil) then
        if (array.iconTypes == 1) or (array.iconTypes == 2) or (array.iconTypes == 3) or (array.iconTypes == 7) or (array.iconTypes == 8) or (array.iconTypes == 9) then
            SetNotificationMessage(tostring(array.picture), tostring(array.picture), true, array.iconTypes, array.sender, array.title)
        else
            SetNotificationMessage(tostring(array.picture), tostring(array.picture), true, 4, array.sender, array.title)
        end
    else
        if (array.iconTypes == 1) or (array.iconTypes == 2) or (array.iconTypes == 3) or (array.iconTypes == 7) or (array.iconTypes == 8) or (array.iconTypes == 9) then
            SetNotificationMessage('CHAR_ALL_PLAYERS_CONF', 'CHAR_ALL_PLAYERS_CONF', true, array.iconTypes, array.sender, array.title)
        else
            SetNotificationMessage('CHAR_ALL_PLAYERS_CONF', 'CHAR_ALL_PLAYERS_CONF', true, 4, array.sender, array.title)
        end
    end
    if (array.sound ~= nil) then
        if (array.sound.audio_name ~= nil) then
            if (array.sound.audio_ref ~= nil) then
                PlaySoundFrontend(-1, array.sound.audio_name, array.sound.audio_ref, true)
            else
                error("Missing arguments, audio_ref")
            end
        else
            error("Missing arguments, audio_name")
        end
    end
    DrawNotification(false, true)
end

---Text
---@param array table
---@public
function RageUI.Text(array)
    ClearPrints()
    SetTextEntry_2("STRING")
    if (array.message ~= nil) then
        AddTextComponentString(tostring(array.message))
    else
        error("Missing arguments, message")
    end
    if (array.time_display ~= nil) then
        DrawSubtitleTimed(tonumber(array.time_display), 1)
    else
        DrawSubtitleTimed(6000, 1)
    end
    if (array.sound ~= nil) then
        if (array.sound.audio_name ~= nil) then
            if (array.sound.audio_ref ~= nil) then
                PlaySoundFrontend(-1, array.sound.audio_name, array.sound.audio_ref, true)
            else
                error("Missing arguments, audio_ref")
            end
        else
            error("Missing arguments, audio_name")
        end
    end
end


function RageUI.drawTexts(x, y, text, center, scale, rgb, font, justify)
    SetTextFont(font)
    SetTextScale(scale, scale)

    SetTextColour(rgb[1], rgb[2], rgb[3], rgb[4])
    SetTextEntry("STRING")
    SetTextCentre(center)
    AddTextComponentString(text)
    EndTextCommandDisplayText(x,y)
end

local baseX = 0.685
local baseY = 0.15
local baseWidth = 0.15
local baseHeight = 0.03
function RageUI.advancedDesc(title, color, components)
    -- if not RageUI.CurrentMenu then
        DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.025, color[1], color[2], color[3], 255)
        DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 0, 0, 0, 170)
        RageUI.drawTexts(baseX - 0.0395, baseY - (0.043) - 0.013, title, false, 0.35, { 255, 255, 255, 255 }, 2, 0)

        for k, v in pairs(components) do
            DrawRect(baseX, (baseY - 0.043) + (0.030 * (k)), baseWidth, baseHeight, 0, 0, 0, 150)
            RageUI.drawTexts(baseX - 0.073, baseY - (0.043) + (0.030 * (k)) - 0.013, v[1], false, 0.35, v[2] or { 255, 255, 255, 255 }, 4, 0)
        end
    -- end
end

local function GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()
    SafeSize = math.round(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = 1920, 1080

    return { X = math.round(SafeSize * ((W / H) * 5.4)), Y = math.round(SafeSize * 5.4) }
end

local function SetScaleformParams(scaleform, data)
    data = data or {}
    for k, v in pairs(data) do
        PushScaleformMovieFunction(scaleform, v.name)
        if v.param then
            for _, par in pairs(v.param) do
                if math.type(par) == "integer" then
                    PushScaleformMovieFunctionParameterInt(par)
                elseif type(par) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(par)
                elseif math.type(par) == "float" then
                    PushScaleformMovieFunctionParameterFloat(par)
                elseif type(par) == "string" then
                    PushScaleformMovieFunctionParameterString(par)
                end
            end
        end
        if v.func then
            v.func()
        end
        PopScaleformMovieFunctionVoid()
    end
end

function RageUI.staffModeDesc(title, color, components)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 0, 0, 0, 255)
        RageUI.drawTexts(baseX - 0.0720, baseY - (0.043) - 0.013, title, false, 0.35, { 255, 255, 255, 255 }, 4, 0)
        
        for k, v in pairs(components) do
            DrawRect(baseX, (baseY - 0.043) + (0.030 * (k)), baseWidth, baseHeight, 0, 0, 0, 150)
            RageUI.drawTexts(baseX - 0.073, baseY - (0.043) + (0.030 * (k)) - 0.013, v[1], false, 0.35, v[2] or { 255, 255, 255, 255 }, 4, 0)
        end
        
        DrawRect(baseX, baseY - 0.085, baseWidth, baseHeight * 1.85, 242, 215, 4, 255)
        DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.025, 242, 215, 4, 255, 255)
    
        ---@type number
        local Glarewidth = 50
        ---@type number
        local Glareheight = 100
        ---@type number
        -- local GlareX = baseX / 1860 + GetSafeZoneBounds().X / 53.211
        local GlareX = 1.5
        ---@type number
        -- local GalreY = baseY - 0.085 / 1080 + GetSafeZoneBounds().Y / 33.195020746888
        local GalreY = 1.5
        
        SetScaleformParams(ScaleformMovie, {
            { name = "SET_DATA_SLOT", param = { GetGameplayCamRelativeHeading() } }
        })
    
        -- DrawScaleformMovie(ScaleformMovie, GlareX, GalreY, Glarewidth / 530, Glareheight / 100, 255, 255, 255, 145, 0)
        DrawScaleformMovie(ScaleformMovie, 0.895, 0.294, 0.60, 0.57, 255, 255, 255, 145, 0)

        RageUI.drawTexts(baseX - 0.030, baseY - 0.110, "", false, 0.7, { 255, 255, 255, 255 }, 4, 0)
    end
end