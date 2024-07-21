--[[
----
----Created Date: 3:53 Thursday April 20th 2023
----Author: vCore3
----Made with ❤
----
----File: [HUDNotification]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local _AddTextComponentSubstringPlayerName = AddTextComponentSubstringPlayerName;
local _BeginTextCommandDisplayHelp = BeginTextCommandDisplayHelp;
local _EndTextCommandDisplayHelp = EndTextCommandDisplayHelp;
local _BeginTextCommandBusyspinnerOn = BeginTextCommandBusyspinnerOn;
local _EndTextCommandBusyspinnerOn = EndTextCommandBusyspinnerOn;
local _BeginTextCommandPrint = BeginTextCommandPrint;
local _EndTextCommandPrint = EndTextCommandPrint;
local _ClearPrints = ClearPrints;
local _CreateThread = CreateThread;
local _BusyspinnerIsOn = BusyspinnerIsOn;
local _BusyspinnerOff = BusyspinnerOff;
local _Wait = Wait;

---@class HUDNotification
HUDNotification = {};

---@param txt string
local function AddLongString(txt)
    for i = 100, string.len(txt), 99 do
        local sub = string.sub(txt, i, i + 99)
        _AddTextComponentSubstringPlayerName(sub)
    end
end

---@param text string
---@param time number
function HUDNotification.Subtitle(text, time)
    _ClearPrints()
    _BeginTextCommandPrint("STRING")
    _AddTextComponentSubstringPlayerName(text)
    _EndTextCommandPrint(time and math.ceil(time) or 0, true)
end

---@param text string
---@param sound boolean
---@param loop number
function HUDNotification.FloatingHelpText(text, sound, loop)
    _BeginTextCommandDisplayHelp("jamyfafi")
    _AddTextComponentSubstringPlayerName(text)
    if string.len(text) > 99 then
        AddLongString(text)
    end
    _EndTextCommandDisplayHelp(0, loop or 0, sound or true, -1)
end

---@param text string
---@param spinner number
function HUDNotification.Prompt(text, spinner)
    _BeginTextCommandBusyspinnerOn("STRING")
    _AddTextComponentSubstringPlayerName(text)
    _EndTextCommandBusyspinnerOn(spinner or 1)
end

---@param duration number
---@param text string
---@param spinner number
function HUDNotification.PromptDuration(duration, text, spinner)
    _CreateThread(function()
        _Wait(0)
        Visual.Prompt(text, spinner)
        _Wait(duration)
        if (_BusyspinnerIsOn()) then
            _BusyspinnerOff();
        end
    end)
end

function HUDNotification.ResetPrompt()
    if (_BusyspinnerIsOn()) then
        _BusyspinnerOff();
    end
end