---
--- @author Kadir#6666
--- Create at [10/05/2023] 14:10:01
--- Current project [Valestia-V1]
--- File name [Events]
---

Shared.Events:OnNet(Enums.Vehicles.Events.SetFuel, function(netId, newValue)

    if (type(netId) ~= "number" and type(newValue) ~= "number") then
        return
    end

    local network_entity = NetworkGetEntityFromNetworkId(netId)

    if (network_entity ~= 0 and DoesEntityExist(network_entity)) then

        local vehicle_fuel = Shared.Storage:Get("FuelSys"):Get("GetFuel")(network_entity);

        if (vehicle_fuel ~= nil) then

            Shared.Storage:Get("FuelSys"):Get("SetFuel")(network_entity, ((vehicle_fuel + newValue) + 0.0))

        end

    end

end)