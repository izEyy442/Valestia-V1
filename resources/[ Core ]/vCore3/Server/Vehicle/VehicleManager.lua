--[[
----
----Created Date: 4:55 Friday October 14th 2022
----Author: vCore3
----Made with ❤
----
----File: [VehicleManager]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@type fun(): VehicleManager
VehicleManager = Class.new(function(class)

    ---@class VehicleManager: BaseObject
    local self = class;

    function self:Constructor()

        ---@type Vehicle[]
        self.vehicles = {};

        Shared:Initialized("VehicleManager");

    end

    ---@param vehiclePlate string
    ---@return Vehicle
    function self:GetVehicleByPlate(vehiclePlate)

        local vPlate = Shared.Vehicle:ConvertPlate(vehiclePlate);
        local vSelected = self.vehicles[vPlate]

        if (not vSelected) then
            return;
        end

        if (vSelected and not DoesEntityExist(vSelected:GetHandle())) then
            self.vehicles[vPlate] = nil
            return;
        end

        return vSelected;

    end

    ---@param plate string
    ---@return boolean
    function self:DoesVehicleExist(plate)
        return self:GetVehicleByPlate(plate) ~= nil
    end

    ---@return Vehicle[]
    function self:GetVehicles()
        return self.vehicles;
    end

    function self:RandomPlate()

        local plate_letters = Config["Vehicle"]["Plate"]["Letters"]
        local plate_numbers = Config["Vehicle"]["Plate"]["Numbers"]
        local plate_generate = ""

        for _ = 1,4 do
            plate_generate = plate_generate .. plate_numbers[math.random(#plate_numbers)]
        end

        for _ = 1,4 do
            plate_generate = plate_generate .. plate_letters[math.random(#plate_letters)]
        end

        return plate_generate:upper()

    end

    ---@param plate string
    function self:GetIfPlateIsTaken(plate)

        plate = Shared.Vehicle:ConvertPlate(plate)

        if (type(plate) ~= "string") then
            return
        end

        local plate_is_taken = MySQL.query.await('SELECT 1 FROM owned_vehicles WHERE plate = ?', { plate })
        return plate_is_taken[1] ~= nil

    end

    function self:GenerateUniquePlate()

        local plate_generated = self:RandomPlate()
        local attempts = 0

        while (self:GetIfPlateIsTaken(plate_generated) == true) do

            plate_generated = self:RandomPlate()
            attempts = attempts + 1

            if (attempts >= 10) then
                break
            end

            Wait(500)

        end

        return attempts < 10 and plate_generated or nil

    end

    ---@param model string
    ---@param position vector3
    ---@param heading number
    ---@param plate string
    ---@param callback fun(vehicle: Vehicle, properties: table)
    ---@param xPlayer xPlayer
    function self:CreateVehicle(model, position, heading, plate ,callback, xPlayer)

        local vehicle = Vehicle(model, position, heading, plate);

        vehicle:Spawn(function()

            local vPlate = Shared.Vehicle:ConvertPlate(vehicle:GetPlate());

            if (self.vehicles[vPlate]) then
                self.vehicles[vPlate] = nil;
            end

            self.vehicles[vPlate] = vehicle;

            if (xPlayer) then
                vehicle:RequestProperties(xPlayer, function(properties)
                    if callback then callback(vehicle, properties) end
                end);
            else
                if callback then callback(vehicle) end
            end

            ---@type VehicleKey
            local key = JG.KeyManager:GetKey("vehicle", vPlate);

            if (key) then
                key:AddHandle(vehicle:GetHandle());
            end

        end);
    end

    ---@param handle number
    ---@param model number
    ---@param position vector3
    ---@param heading number
    ---@param plate string
    ---@param callback fun(vehicle: Vehicle, properties: table)
    ---@param xPlayer xPlayer
    function self:CreateInstance(handle, model, position, heading, plate, callback, xPlayer)
        local vehicle = Vehicle(model, position, heading, plate);
        local vPlate = Shared.Vehicle:ConvertPlate(plate);
        if not (plate) then return; end

        self.vehicles[vPlate] = vehicle;

        self.vehicles[vPlate]:SetHandle(handle);
        self.vehicles[vPlate]:RequestNetworkId(function()

            if (xPlayer) then

                self.vehicles[vPlate]:RequestProperties(xPlayer, function(properties)
                    if callback then callback(self.vehicles[vPlate], properties) end
                end);

            else

                if (callback) then callback(self.vehicles[vPlate]); end

            end

        end);

    end

    ---@param plate string
    ---@param callback function
    ---@return boolean
    function self:RemoveVehicle(plate, callback)

        local vPlate = Shared.Vehicle:ConvertPlate(plate);

        if (self.vehicles[vPlate]) then

            local vehicle = self.vehicles[vPlate];
            local handle = vehicle:GetHandle();

            ---@type VehicleKey
            local key = JG.KeyManager:GetKey("vehicle", vPlate);

            if (key) then
                key:RemoveHandle();
            end

            if (callback) then callback(); end

            if (DoesEntityExist(handle)) then
                DeleteEntity(handle);
            end

            self.vehicles[vPlate] = nil;

            return true;

        end

        return false;

    end

    ---@param plate string
    ---@return number
    function self:GetStreetVehicleByPlate(plate)
        local vehicles = GetAllVehicles();
        if (vehicles) then
            for i = 1, #vehicles do

                local vPlate = GetVehicleNumberPlateText(vehicles[i]);

                if (vPlate == plate) then
                    return vehicles[i];
                end

            end
        end
    end

    return self;
end);