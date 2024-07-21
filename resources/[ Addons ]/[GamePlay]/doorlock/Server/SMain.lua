local _doorCache = {}
local _CreateThread, _RegisterServerEvent = CreateThread, RegisterServerEvent

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

isAllowed = function(id)
    local xPlayer = ESX.GetPlayerFromId(id)
    local group = xPlayer.getGroup()
    for k, v in pairs(Config['admingroups']) do
        if group == v then
            return true
        end
    end
    return false
end

_CreateThread(function()
    local doors = LoadResourceFile(GetCurrentResourceName(), "Server/Files/Doors.json")
    if doors == "" then
        SaveResourceFile(GetCurrentResourceName(), "Server/Files/Doors.json", "[]", -1)
    end
end)

ESX.RegisterServerCallback('doorlock:cb:getDoors', function(source,cb) 
    local doors = LoadResourceFile(GetCurrentResourceName(), "Server/Files/Doors.json")
    doors = json['decode'](doors)
    cb(doors, _doorCache)
end)

_RegisterServerEvent("doorlock:server:addDoor", function(_doorCoords, _doorModel, _heading, type, _textCoords, dist, jobs, pin, item)
    local _src <const> = source
    if isAllowed(_src) then
        local usePin = false
        local useitem = false
        local doors = LoadResourceFile(GetCurrentResourceName(), "Server/Files/Doors.json")
        if pin ~= "" then
            usePin = true
        end
        if item ~= "" then
            useitem = true
        end
        doors = json.decode(doors)
        local tableToIns <const> = {
            doorCoords = _doorCoords,
            _doorModel = _doorModel,
            _heading = _heading,
            _type = type,
            _textCoords = _textCoords,
            dist = dist,
            jobs = jobs,
            usePin = usePin,
            pin = pin,
            useitem = useitem,
            item = item
        }
        table['insert'](doors, tableToIns)
        SaveResourceFile(GetCurrentResourceName(), "Server/Files/Doors.json", json['encode'](doors, { indent = true }), -1)
        TriggerClientEvent("doorlock:client:refreshDoors", -1, tableToIns)
    end
end)

_RegisterServerEvent("doorlock:server:addDoubleDoor", function(_doorsDobule, type, _textCoords, dist, jobs, pin, item)
    local _src <const> = source
    if isAllowed(_src) then
        local doors = LoadResourceFile(GetCurrentResourceName(), "Server/Files/Doors.json")
        doors = json.decode(doors)
        local useitem = false
        local usePin = false
        if pin ~= "" then
            usePin = true
        end
        if item ~= "" then
            useitem = true
        end
        local tableToIns <const> = {
            _doorsDouble = _doorsDobule,
            _type = type,
            _textCoords = _textCoords,
            dist = dist,
            jobs = jobs,
            usePin = usePin,
            pin = pin,
            useitem = useitem,
            item = item,
        }
        table['insert'](doors, tableToIns)
        SaveResourceFile(GetCurrentResourceName(), "Server/Files/Doors.json", json['encode'](doors, { indent = true }), -1)
        TriggerClientEvent("doorlock:client:refreshDoors", -1, tableToIns)
    end
end)

_RegisterServerEvent("doorlock:server:updateDoor", function(id, type)
    _doorCache[id] = type
    TriggerClientEvent("doorlock:client:updateDoorState", -1, id, type)
end)

_RegisterServerEvent("doorlock:server:syncRemove", function(id)
    local _src <const> = source
    if isAllowed(_src) then
        local doors = LoadResourceFile(GetCurrentResourceName(), "Server/Files/Doors.json")
        doors = json.decode(doors)
        table['remove'](doors, id)
        SaveResourceFile(GetCurrentResourceName(), "Server/Files/Doors.json", json['encode'](doors, { indent = true }), -1)
        TriggerClientEvent("doorlock:client:removeGlobDoor", -1, id)
    end
end)

RegisterCommand(Config['commands'].CreateDoor, function(source, args)  
    local _src <const> = source
    if isAllowed(_src) then
        TriggerClientEvent("doorlock:client:setUpDoor", _src)
    end 
end, false)

RegisterCommand(Config['commands'].RemoveDoor, function(source, args)  
    local _src <const> = source
    if isAllowed(_src) then
        TriggerClientEvent("doorlock:client:deleteDoor", _src)
    end 
end, false)

ESX.RegisterServerCallback('doorlock:cb:hasObj', function(source,cb, item) 
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local itemPly = xPlayer.getInventoryItem(item)
    if itemPly and itemPly.count > 0 then
        return cb(true)
    else 
        return cb(false)
    end
end)
