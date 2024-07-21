--[[
----
----Created Date: 2:31 Saturday October 15th 2022
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

---@param xPlayer xPlayer
---@param numberPlate string
---@param notify boolean
exports('GiveCarKey', function(xPlayer, numberPlate, notify)
	return JG.KeyManager:AddKey(xPlayer, VehicleKey, Shared.Vehicle:ConvertPlate(numberPlate), "vehicle", notify or true);
end);

---@param model string
---@param position vector3
---@param heading number
---@param plate string
---@param locked boolean
---@param xPlayer xPlayer
---@param callback fun(handle: number, properties: table)
exports('SpawnVehicle', function(model, position, heading, plate, locked, xPlayer, callback)
	JG.VehicleManager:CreateVehicle(model, position, heading, plate, function(vehicle, properties)
		vehicle:SetLocked(locked ~= nil and locked or false);
		if (callback) then
			callback(vehicle:GetHandle(), properties);
		end
	end, xPlayer);
end);

---@param plate string
---@param callback function
exports("RemoveVehicle", function(plate, callback)
	JG.VehicleManager:RemoveVehicle(plate, callback);
end);

---@param plate string
---@param properties table
---@return table | nil properties
exports("SetVehicleProperties", function(source, plate, properties)
	local xPlayer = ESX.GetPlayerFromId(source);
	if (not xPlayer) then return nil; end
	local vehicle = JG.VehicleManager:GetVehicleByPlate(plate);
	if (not vehicle) then return nil; end
	local p = promise.new();
	vehicle:SetProperties(properties, xPlayer, function(properties)
		p:resolve(properties);
	end);
	return Citizen.Await(p);
end);

---@param plate string
---@return boolean
exports("DoesVehicleExist", function(plate)
	return JG.VehicleManager:DoesVehicleExist(plate);
end);