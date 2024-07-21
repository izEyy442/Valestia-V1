--[[
----
----Created Date: 3:36 Sunday October 23rd 2022
----Author: vCore3
----Made with ❤
----
----File: [debug]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local ESXttt;

TriggerEvent("esx:getSharedObject", function(obj) ESXttt = obj end);

local DEVMODE = ESXttt.GetConfig().DEVMODE; ---#vCore3 WRAPPER (EPROTECT)

if (DEVMODE) then
    local JRegisterNetEvent = RegisterNetEvent
    local JTriggerServerEvent = TriggerServerEvent

    ---@param eventName string
    ---@param cb fun(source: number, ...: any): void
    function _RegisterNetEvent(eventName, cb)
        return JRegisterNetEvent(eventName, function(...)
            local src = source;
            if (IsDuplicityVersion()) then
                cb(src, ...);
            else
                cb(...);
            end
        end);
    end

    ---@param eventName string
    function _TriggerServerEvent(eventName, cb)
        JTriggerServerEvent(eventName, cb);
    end
end