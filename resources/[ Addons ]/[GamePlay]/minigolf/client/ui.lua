-- Author : Morow
-- Github : https://github.com/Morow73

-- Credit for research
-- https://github.com/Sainan/GTA-V-Decompiled-Scripts/blob/master/decompiled_scripts/golf_mp.c
-- https://www.vespura.com/fivem/scaleform/

Ui = {}
Ui.__index = Ui

function Ui:displayNotification(str)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentString(str)
    EndTextCommandThefeedPostTicker(false, true)
end

function Ui:displayHelpNotification(request)
    BeginTextCommandDisplayHelp("THREESTRINGS")

    for i = 1,#request,1 do
        AddTextComponentSubstringPlayerName(request[i])
    end

    EndTextCommandDisplayHelp(0, false, true, request.duration or 5000)
end

function Ui:fadeOut(time)
    CreateThread(function()
        if not IsScreenFadedOut() then
            DoScreenFadeOut(time)
        else
            DoScreenFadeIn(100)
        end
    end)
end

function Ui:fadeIn()
    DoScreenFadeIn(150)
end

function Ui:drawLine(coords, coords2)
    DrawLine(coords.x, coords.y, coords.z, coords2.x, coords2.y, coords2.z, 255, 0, 0, 0.8)
end

function Ui:displayScoreboard(display)
    if display then
        SendNuiMessage(json.encode({
            status = true,
            data = allGame,
            ui = 'Scoreboard'
        }))
    else
        SendNuiMessage(json.encode({
            status = false,
            ui = 'Scoreboard'
        }))
    end
end

function Ui:displayPowerBar(display, power)
    if display then
        SendNuiMessage(json.encode({
            status = true,
            ui = 'Power',
            data = tonumber(power * 100)
        }))
  
    else
        SendNuiMessage(json.encode({
            status = false,
            ui = 'Power',
            data = 0
        }))
    end
end
