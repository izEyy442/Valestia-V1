ValestiaServerUtils = {}

ValestiaServerUtils.toClient = function(eventName, targetId, ...)
    TriggerClientEvent("Valestia:" .. Valestia.hash(eventName), targetId, ...)
end

ValestiaServerUtils.toAll = function(eventName, ...)
    TriggerClientEvent("Valestia:" .. Valestia.hash(eventName), -1, ...)
end

ValestiaServerUtils.registerConsoleCommand = function(command, func)
    RegisterCommand(command, function(source,args)
        if source ~= 0 then return end
        func(source, args)
    end, false)
end

ValestiaServerUtils.getLicense = function(source)
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return ""
end

ValestiaServerUtils.trace = function(message, prefix)
    print("(^2" .. prefix .. "^0) ^2" .. message .. "^0")
end

local webhookColors = {
    ["red"] = 652101,
    ["green"] = 56108,
    ["grey"] = 8421504,
    ["orange"] = 16744192
}

ValestiaServerUtils.getIdentifiers = function(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[_]
        end
        return identifiers
    end
end