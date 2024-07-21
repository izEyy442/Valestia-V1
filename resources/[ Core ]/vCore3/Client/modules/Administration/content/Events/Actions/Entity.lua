---
--- @author Kadir#6666
--- Create at [27/04/2023] 17:44:40
--- Current project [Valestia-V1]
--- File name [Vehicle]
---

Shared.Events:OnNet(Enums.Administration.Client.Actions.Entity, function(action, network_entity)

    local entity = NetworkGetEntityFromNetworkId(network_entity)

    if (entity ~= 0 and DoesEntityExist(entity)) then

        if (action == "entity_freeze") then

            return FreezeEntityPosition(entity, not IsEntityPositionFrozen(entity));

        end

        if (action == "vehicle_repair") then

            return Game.Vehicle:Repair(entity)

        elseif (action == "vehicle_refuel") then

            return Game.Vehicle:SetProperties(entity, {
                fuelLevel = 100.0
            })

        elseif (action == "vehicle_upgrade") then

            return Game.Vehicle:SetProperties(entity, {
                modEngine       = true,
                modBrakes       = true,
                modArmor        = 6,
                modTransmission = true,
                modSuspension   = true,
                modTurbo        = true
            })

        end

    end

end)