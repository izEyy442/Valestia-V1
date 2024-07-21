Valestia = {}
Valestia.newThread = Citizen.CreateThread
Valestia.newWaitingThread = Citizen.SetTimeout
--Citizen.CreateThread, CreateThread, Citizen.SetTimeout, SetTimeout, InvokeNative = nil, nil, nil, nil, nil

Job = nil
Jobs = {}
Jobs.list = {}

ValestiaPrefixes = {
    zones = "^1ZONE",
    err = "^1ERREUR",
    blips = "^1BLIPS",
    npcs = "^1NPCS",
    dev = "^1INFOS",
    sync = "^6SYNC",
    jobs = "^6JOBS",
    succes = "^2SUCCÈS"
}

Valestia.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end

Valestia.prefix = function(title, message)
    return ("(%s^0) %s" .. "^0"):format(title, message)
end

local registredEvents = {}
local function isEventRegistred(eventName)
    for k,v in pairs(registredEvents) do
        if v == eventName then return true end
    end
    return false
end

Valestia.netRegisterAndHandle = function(eventName, handler)
    local event = "Valestia:" .. Valestia.hash(eventName)
    if not isEventRegistred(event) then
        RegisterNetEvent(event)
        table.insert(registredEvents, event)
    end
    AddEventHandler(event, handler)
end


Valestia.netRegister = function(eventName)
    local event = "Valestia:" .. Valestia.hash(eventName)
    RegisterNetEvent(event)
end


Valestia.netHandle = function(eventName, handler)
    local event = "Valestia:" .. Valestia.hash(eventName)
    AddEventHandler(event, handler)
end


Valestia.netHandleBasic = function(eventName, handler)
    AddEventHandler(eventName, handler)
end

Valestia.second = function(from)
    return from*1000
end

Valestia.toInternal = function(eventName, ...)
    TriggerEvent("Valestia:" .. Valestia.hash(eventName), ...)
end