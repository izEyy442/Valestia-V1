local lib = exports.loaf_lib:GetLib()

---Check if a vehicle is out
---@param plate string
---@param vehicles any
---@return boolean out
---@return number | nil vehicle
local function IsVehicleOut(plate, vehicles)
    if not vehicles then
        vehicles = GetAllVehicles()
    end

    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        if DoesEntityExist(vehicle) and GetVehicleNumberPlateText(vehicle):gsub("%s+", "") == plate:gsub("%s+", "") then
            return true, vehicle
        end
    end

    return false
end

lib.RegisterCallback("phone:garage:findCar", function(source, cb, plate)
    local phoneNumber = GetEquippedPhoneNumber(source)

    local out, vehicle = IsVehicleOut(plate)
    if out then
        cb(GetEntityCoords(vehicle))
    else
        if phoneNumber then
            SendNotification(phoneNumber, {
                source = source,
                app = "Garage",
                title = L("BACKEND.GARAGE.VALET"),
                content = L("BACKEND.GARAGE.COULDNT_FIND"),
            })
        end
        cb(false)
    end
end)

lib.RegisterCallback("phone:garage:getVehicles", function(source, cb)
    GetPlayerVehicles(source, function(vehicles)
        if #vehicles > 0 then
            local allVehicles = GetAllVehicles()
            for i = 1, #vehicles do
                if IsVehicleOut(vehicles[i].plate, allVehicles) then
                    vehicles[i].location = "out"
                end
            end
        end

        cb(vehicles)
    end)
end)

lib.RegisterCallback("phone:garage:valetVehicle", function(source, cb, plate)
    local phoneNumber = GetEquippedPhoneNumber(source)
    if not phoneNumber then
        return cb()
    end

    if IsVehicleOut(plate) then
        SendNotification(phoneNumber, {
            app = "Garage",
            title = L("BACKEND.GARAGE.VALET"),
            content = L("BACKEND.GARAGE.ALREADY_OUT"),
        })
        return cb()
    end

    if Config.Valet.Price and not RemoveMoney(source, Config.Valet.Price) then
        SendNotification(phoneNumber, {
            app = "Garage",
            title = L("BACKEND.GARAGE.VALET"),
            content = L("BACKEND.GARAGE.NO_MONEY"),
        })
        return cb()
    end

    GetVehicle(source, function(vehicleData)
        if not vehicleData then
            if Config.Valet.Price then
                AddMoney(source, Config.Valet.Price)
            end
            return cb()
        end

        SendNotification(phoneNumber, {
            app = "Garage",
            title = L("BACKEND.GARAGE.VALET"),
            content = L("BACKEND.GARAGE.ON_WAY"),
        })

        cb(vehicleData)
    end, plate)
end)