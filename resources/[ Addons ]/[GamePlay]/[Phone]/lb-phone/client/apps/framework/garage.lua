local lib = exports.loaf_lib:GetLib()

---Function to find a spawn point for a car
---@param minDist? number Minimum distance from the player. Default 150
---@return nil | vector3
---@return number
local function FindCarLocation(minDist)
    if not minDist then
        minDist = 150
    end

    local plyCoords = GetEntityCoords(PlayerPedId())
    local nth = 0

    local success, position, heading
    repeat
        nth += 1
        success, position, heading = GetNthClosestVehicleNodeWithHeading(plyCoords.x, plyCoords.y, plyCoords.z, nth, 0, 0, 0)
    until #(plyCoords - position) > minDist or success == false

    return position, heading
end

local function BringCar(data, cb)
    local location, heading = FindCarLocation(50)
    if not location then
        debugprint("No location found")
        return
    end

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        debugprint("Player is in a vehicle")
        return
    end

    local plate = data.plate
    lib.TriggerCallback("phone:garage:valetVehicle", function(vehicleData)
        if not vehicleData then
            return
        end

        local vehicle = CreateFrameworkVehicle(vehicleData, location)
        SetEntityHeading(vehicle, heading)

        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetVehRadioStation(vehicle, "OFF")
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleEngineOn(vehicle, true, true, true)
        SetEntityAsMissionEntity(vehicle, true, true)

        -- create a ped that drives the vehicle to player
        local model = `S_M_Y_XMech_01`
        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(500)
        end

        local ped = CreatePedInsideVehicle(vehicle, 4, model, -1, true, false)
        local plyCoords = GetEntityCoords(PlayerPedId())
        TaskVehicleDriveToCoord(ped, vehicle, plyCoords.x, plyCoords.y, plyCoords.z, 20.0, 0, model, 786603, 1.0, 1)
        SetPedKeepTask(ped, true)
        SetEntityAsMissionEntity(ped, true, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedCombatAttributes(ped, 17, true)
        SetPedAlertness(ped, 0)

        cb(true)

        -- wait for the ped to arrive
        local blip = AddBlipForEntity(vehicle)
        SetBlipSprite(blip, 225)
        SetBlipColour(blip, 5)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Valet")
        EndTextCommandSetBlipName(blip)

        while #(GetEntityCoords(ped) - GetEntityCoords(PlayerPedId())) > 10.0 do
            Wait(1000)
        end

        RemoveBlip(blip)

        -- make the ped exit the vehicle, then wander in area, and set as no longer needed
        TaskLeaveVehicle(ped, vehicle, 0)
        TaskWanderStandard(ped, 10.0, 10)
        SetEntityAsNoLongerNeeded(ped)
    end, plate)
end

---Function to find a car
---@param plate string
---@return vector3 | false
local function FindCar(plate)
    local vehicles = GetGamePool("CVehicle")
    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        if DoesEntityExist(vehicle) and GetVehicleNumberPlateText(vehicle):gsub("%s+", "") == plate:gsub("%s+", "") then
            return GetEntityCoords(vehicle)
        end
    end

    return lib.TriggerCallbackSync("phone:garage:findCar", plate)
end

function GetVehicleLabel(model)
    local vehicleLabel = GetDisplayNameFromVehicleModel(model):lower()

    if not vehicleLabel or vehicleLabel == "null" or vehicleLabel == "carnotfound" then
        vehicleLabel = "Unknown"
    else
        local text = GetLabelText(vehicleLabel)
        if text and text:lower() ~= "null" then
            vehicleLabel = text
        end
    end
    return vehicleLabel
end

RegisterNUICallback("Garage", function(data, cb)
    local action = data.action

    if action == "getVehicles" then
        lib.TriggerCallback("phone:garage:getVehicles", function(cars)
            for i = 1, #cars do
                cars[i].model = GetVehicleLabel(cars[i].model)
                --If you're implementing your own lock system, you can use this to set the locked state
                -- cars[i].locked = true
            end
            cb(cars)
        end)
    elseif action == "valet" then
        if not Config.Valet.Enabled then
            return
        end

        BringCar(data, cb)
    elseif action == "setWaypoint" then
        local coords = FindCar(data.plate)
        if coords then
            TriggerEvent("phone:sendNotification", {
                app = "Garage",
                title = L("BACKEND.GARAGE.VALET"),
                content = L("BACKEND.GARAGE.MARKED"),
            })
            SetNewWaypoint(coords.x, coords.y)
        else
            debugprint("not found")
        end
    elseif action == "toggleLocked" then
        --IMPLEMENT YOUR LOCK SYSTEM HERE, don't forget to callback with the new locked state
        -- cb(true)
    end
end)