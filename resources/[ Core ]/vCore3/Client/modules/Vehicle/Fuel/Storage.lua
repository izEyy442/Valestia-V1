---
--- @author Kadir#6666
--- Create at [08/05/2023] 13:54:17
--- Current project [Valestia-V1]
--- File name [_main]
---

local FuelSys = Shared.Storage:Register("FuelSys")

CreateThread(function()

    while (not DecorIsRegisteredAsType("vehicle.fuel", 1)) do
        DecorRegister("vehicle.fuel", 1)
        Wait(500)
    end

end)

FuelSys:Set("Menu", RageUI.AddMenu("", "Station essence"));

FuelSys:Set("PumpNear", function()

    local player_coords = Client.Player:GetCoords()
    local pump_models = Config["Vehicle"]["Fuel"]["Pump"]["Models"]

    for pump_model in pairs(pump_models) do

        if (pump_model ~= nil) then

            local pump_entity = GetClosestObjectOfType(player_coords.x, player_coords.y, player_coords.z, 3.5, pump_model, true, true, true)

            if (pump_entity ~= 0) then
                return pump_entity;
            end

        end

    end

    return false;

end)

FuelSys:Set("GetFuel", function(entity)

    if (entity == nil or not DoesEntityExist(entity)) then
        return
    end

    if (not DecorExistOn(entity, "vehicle.fuel")) then
        DecorSetFloat(entity, "vehicle.fuel", GetVehicleFuelLevel(entity))
    end

    return DecorGetFloat(entity, "vehicle.fuel")

end)

FuelSys:Set("SetFuel", function(entity, fuel)

    if (entity == nil or not DoesEntityExist(entity)) then
        return
    end

    if (type(fuel) ~= "number" or fuel < 0 or fuel > 100) then
        return
    end

    fuel = (fuel + 0.0)

    DecorSetFloat(entity, "vehicle.fuel", fuel)
    SetVehicleFuelLevel(entity, fuel)

end)

Client:SubscribeToGameEvent("CEventNetworkPlayerEnteredVehicle", function(args)

    if (args[1] == Client.Player:GetId()) then

        if (args[2] == Client.Player:GetVehicle()) then

            local vehicle_class = GetVehicleClass(args[2])
            local vehicle_fuel = FuelSys:Get("GetFuel")(args[2])

            while (Client.Player:GetVehicle() ~= 0 and Client.Player:GetVehicle() == args[2] and Client.Player:IsInVehicle(-1)) do

                local loop_interval = 1000
                vehicle_fuel = FuelSys:Get("GetFuel")(args[2])

                if vehicle_fuel < 5.0 then
                    isElectric = GetVehicleHandlingInt(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'nInitialDriveGears')
                    
                    if isElectric ~= 1 then
                        loop_interval = 0
                        SetVehicleEngineOn(args[2], false, true, true)
                    end

                else

                    if GetIsVehicleEngineRunning(args[2]) then

                        local fuel_new_value = (vehicle_fuel - Config["Vehicle"]["Fuel"]["Usage"][math.round(GetVehicleCurrentRpm(args[2]), 1)] * (Config["Vehicle"]["Fuel"]["Consumption"][vehicle_class] or 1.0) / 10)
                        FuelSys:Get("SetFuel")(args[2], fuel_new_value)

                    end

                end

                Wait(loop_interval)

            end

        end

    end

end);