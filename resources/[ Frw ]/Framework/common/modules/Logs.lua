--
--Created Date: 19:02 13/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Logs]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@param name string
---@vararg any
---@return fun(...)
function store_get_function(name, ...)

    local success, result = pcall(function(...)
        return exports["Valestia"][name](unused, ...);
    end, ...);

    if (not success) then
        print(("^6LUA RUNTIME^1 Failed to call function %s from resource Valestia^7"):format(name));
        return nil;
    end

    return result;
end

local current = GetCurrentResourceName();

local function get_resource_str()
    local invoking = GetInvokingResource();
    return invoking ~= nil and "^5" .. invoking .. " →^7" or "^5" .. current .. " →^7";
end

ESX.Logs = {
    ---@param message string
    ["Info"] = function (message, ...)
        --store_get_function("log.info", get_resource_str(), message, ...);
        TriggerEvent('Valestia:Log', "info", message, ...)
    end,

    ---@param message string
    ["Warn"] = function (message, ...)
        --store_get_function("log.warn", get_resource_str(), message, ...);
        TriggerEvent('Valestia:Log', "warn", message, ...)
    end,

    ---@param message string
    ["Error"] = function (message, ...)
        --store_get_function("log.error", get_resource_str(), message, ...);
        TriggerEvent('Valestia:Log', "error", message, ...)
    end,

    ---@param message string
    ["Success"] = function (message, ...)
        --store_get_function("log.success", get_resource_str(), message, ...);
        TriggerEvent('Valestia:Log', "success", message, ...)
    end,
    ---@param message string
    ["Debug"] = function (message, ...)
        --store_get_function("log.debug", get_resource_str(), message, ...);
        TriggerEvent('Valestia:Log', "debug", message, ...)
    end
};