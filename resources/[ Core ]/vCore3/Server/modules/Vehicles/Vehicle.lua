--[[
----
----Created Date: 10:49 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Vehicle]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

Garage = {};
Pound = {};

Garage.VehiclesOut = {};

---@param position vector3 | table
---@param zoneType string
---@return table
function Garage.GetInArea(position, zoneType)
    local zones = Config["Garage"]["Zones"] or {};
    for i = 1, #zones or 1 do
        local dist = #(vector3(position.x, position.y, position.z) - vector3(zones[i][zoneType].x, zones[i][zoneType].y, zones[i][zoneType].z));
        if (dist) then
            if (dist < 10) then
                return zones[i];
            end
        end
    end
end

---@param vehiclePlate string
---@return number | nil
function Garage.GetVehicleByPlate(vehiclePlate)
    local vehicles = GetAllVehicles();
    for i = 1, #vehicles do
        if (GetVehicleNumberPlateText(vehicles[i]) == vehiclePlate) then
            return vehicles[i];
        end
    end
    return nil;
end

---@param position vector3 | table
---@param zoneType string
---@return table
function Pound.GetInArea(position, zoneType)
    local zones = Config["Pound"]["Zones"] or {};
    for i = 1, #zones or 1 do
        local dist = #(vector3(position.x, position.y, position.z) - vector3(zones[i][zoneType].x, zones[i][zoneType].y, zones[i][zoneType].z));
        if (dist) then
            if (dist < 10) then
                return zones[i];
            end
        end
    end
end