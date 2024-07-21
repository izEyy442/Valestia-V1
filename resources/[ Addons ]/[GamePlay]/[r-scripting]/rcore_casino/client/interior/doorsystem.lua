DoorSystem = {}
DoorSystem.Pool = {}
DoorSystem.Uid = 0
DoorSystem.EntranceLock = true

function DoorSystem:RegisterDoor(entity, coords, heading, model, group)
    if entity then
        coords = GetEntityCoords(entity)
        model = GetEntityModel(entity)
        if not heading then
            heading = GetEntityHeading(heading) -- of closed state
        end
    end
    if not group then
        group = "casino"
    end

    local o = {}
    o.handle = GetHashKey("casinodoors_" .. DoorSystem.Uid)
    o.coords = coords
    o.model = model
    o.heading = heading
    o.entity = entity
    o.state = -1
    o.group = group

    local exist, existHandle = DoorSystemFindExistingDoor(coords.x, coords.y, coords.z, model)
    if exist then
        o.handle = existHandle
    end

    if not IsDoorRegisteredWithSystem(o.handle) then
        AddDoorToSystem(o.handle, o.model, o.coords.x, o.coords.y, o.coords.z, false, false, false)
    end

    o.setState = function(state)
        if o.state == state then
            return
        end
        o.state = state
        DoorSystemSetDoorState(o.handle, state, false, false)
    end

    o.refresh = function(relink)
        if o.state >= 3 then -- this frame only states
            DoorSystemSetDoorState(o.handle, o.state, false, true)
        end
        if not o.entity and relink then
            o.entity = GetClosestObjectOfType(o.coords.x, o.coords.y, o.coords.z, 0.10, o.model, false, false, false)
        end
        if DoesEntityExist(o.entity) and (o.state == 1 or o.state == 4) then -- locked states
            SetEntityHeading(o.entity, o.heading)
        end
    end

    o.unlock = function()
        o.setState(0)
    end

    o.lock = function()
        o.setState(1)
    end

    o.open = function(forceUpdate)
        o.unlock()
        if not forceUpdate then
            forceUpdate = false
        end
        DoorSystemSetOpenRatio(o.handle, -1.0, false, forceUpdate)
    end

    o.close = function(forceUpdate)
        if not forceUpdate then
            forceUpdate = false
        end
        DoorSystemSetOpenRatio(o.handle, 0.0, false, forceUpdate)
    end

    o.lockLoop = function()
        o.setState(4)
    end

    o.unlockLoop = function()
        o.setState(3)
    end

    o.openLoop = function()
        o.open()
        o.setState(5)
    end

    o.closeLoop = function()
        o.close()
        o.setState(6)
    end

    table.insert(DoorSystem.Pool, o)
    DoorSystem.Uid = DoorSystem.Uid + 1
    return o
end

function DoorSystem:GetDoors(group)
    local list = {}
    for k, v in pairs(DoorSystem.Pool) do
        if v.group == group then
            table.insert(list, v)
        end
    end
    return list
end

function DoorSystem:Unregister(o)
    for i = 1, #DoorSystem.Pool do
        if DoorSystem.Pool[i] == o then
            table.remove(DoorSystem.Pool, i)
            break
        end
    end
end

function DoorSystem:InitializeCasino()
    if #DoorSystem.Pool > 0 then
        return
    end

    -- left wings (entrance)
    DoorSystem:RegisterDoor(nil, vector3(927.676880, 49.645515, 81.543098), 328.15661621094 - 90.0, 21324050, "entrance")
    DoorSystem:RegisterDoor(nil, vector3(926.188293, 47.248829, 81.543098), 328.15661621094 - 90.0, 21324050, "entrance")
    DoorSystem:RegisterDoor(nil, vector3(924.706238, 44.862366, 81.543098), 328.15661621094 - 90.0, 21324050, "entrance")
    -- right wings (entrance)
    DoorSystem:RegisterDoor(nil, vector3(926.347046, 47.515320, 81.543098), 328.15661621094 + 90.0, 21324050, "entrance")
    DoorSystem:RegisterDoor(nil, vector3(924.859009, 45.119484, 81.543098), 328.15661621094 + 90.0, 21324050, "entrance")
    DoorSystem:RegisterDoor(nil, vector3(923.376038, 42.731743, 81.543098), 328.15661621094 + 90.0, 21324050, "entrance")

    if Config.MapType == 1 then
        -- garage <=> interior
        DoorSystem:RegisterDoor(nil, vector3(930.422791, 33.263103, 81.242676), 150.0, 901693952, "int2garage")
        -- office elevator (normal)
        DoorSystem:RegisterDoor(nil, vector3(952.656677, 57.975616, 74.432373), 60.0, -1240156945, "officeelevator")
        DoorSystem:RegisterDoor(nil, vector3(953.451599, 59.247688, 74.432373), -120.0, -1240156945, "officeelevator")
        -- office elevator (down) (normal)
        DoorSystem:RegisterDoor(nil, vector3(976.157166, 73.089081, 69.232674), 60.0, -1240156945, "officeelevator")
        DoorSystem:RegisterDoor(nil, vector3(977.429199, 72.294205, 69.232674), -120.0, -1240156945, "officeelevator")

        -- casino staff cashier
        local cashierDoors = DoorSystem:RegisterDoor(nil, CASHIER_DOORS.pos, CASHIER_DOORS.heading, 1266543998,
            "cashier")
        cashierDoors.close()
        cashierDoors.lock()
    elseif Config.MapType == 2 or Config.MapType == 3 then
        -- office elevator (gabz)
        DoorSystem:RegisterDoor(nil, vector3(993.200623, 55.761406, 74.059692), 60.0, -1240156945, "officeelevator")
        DoorSystem:RegisterDoor(nil, vector3(993.992004, 57.035648, 74.059692), -120.0, -1240156945, "officeelevator")
        -- office elevator (down) (gabz)
        DoorSystem:RegisterDoor(nil, vector3(1016.659668, 70.939056, 68.859993), 60.0, -1240156945, "officeelevator")
        DoorSystem:RegisterDoor(nil, vector3(1017.933899, 70.147675, 68.859993), -120.0, -1240156945, "officeelevator")
    end

    local elevators = DoorSystem:GetDoors("officeelevator")
    for k, v in pairs(elevators) do
        v.close(true)
    end
end

local function RecheckEntranceLock()
    local lock = IsActivityEnabled("casinoentrance")
    if Config.LeaveThroughTeleport then
        lock = false -- always lock if leaving through teleports
    end
    if lock ~= DoorSystem.EntranceLock then
        DoorSystem.EntranceLock = lock
        for k, v in pairs(DoorSystem.Pool) do
            if v.group == "entrance" or v.group == "int2garage" then
                if lock then
                    v.close()
                    v.unlock()
                else
                    v.lockLoop()
                    v.close()
                end
            end
        end
    end
end

local function HandleDoors(relink)
    local playerPosition = GetEntityCoords(PlayerPedId())
    local sleepTime = 1000

    if relink then
        RecheckEntranceLock()
    end

    for k, v in pairs(DoorSystem.Pool) do
        if #(playerPosition - v.coords) < 10.0 then
            v.refresh(relink)
            sleepTime = 0
        end
    end
    Wait(sleepTime)
end

DoorSystem:InitializeCasino()

CreateThread(function()
    local checkTime = GetGameTimer() + 2000
    while true do
        local timer = GetGameTimer()
        local check = timer > checkTime
        HandleDoors(check)
        if check then
            checkTime = timer + 2000
        end
    end
end, true)
