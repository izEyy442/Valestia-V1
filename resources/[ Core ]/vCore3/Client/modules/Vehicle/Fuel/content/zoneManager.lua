---
--- @author Kadir#6666
--- Create at [08/05/2023] 14:04:18
--- Current project [Valestia-V1]
--- File name [zoneManager]
---

local FuelSys = Shared.Storage:Get("FuelSys");
local FuelZone = Game.Zone("FuelSys");
FuelSys:Set("Zone", FuelZone);

CreateThread(function()

    local gas_stations = Config["Vehicle"]["Fuel"]["Stations"];

    for i = 1, #gas_stations do

        local gas_station_selected = gas_stations[i]

        if (type(gas_station_selected) == "vector3") then

            local blip_on_create = AddBlipForCoord(gas_station_selected.x, gas_station_selected.y, gas_station_selected.z)

            SetBlipSprite(blip_on_create, 415)
            SetBlipColour(blip_on_create, 1)
            SetBlipScale(blip_on_create, 0.5)
            SetBlipAsShortRange(blip_on_create, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString("[Public] Station Essence")
            EndTextCommandSetBlipName(blip_on_create)

        end

    end

end)

FuelZone:Start(function()

    FuelZone:SetTimer(1000);

    local pump_near_entity = FuelSys:Get("PumpNear")()

    if (pump_near_entity and DoesEntityExist(pump_near_entity)) then

        local pump_near_entity_coords = GetEntityCoords(pump_near_entity)

        if (type(pump_near_entity_coords) == "vector3") then

            FuelZone:SetCoords(pump_near_entity_coords)

            FuelZone:IsPlayerInRadius(3.5, function()

                FuelZone:SetTimer(0);
                Game.Notification:ShowHelp("Appuyez sur ~INPUT_PICKUP~ pour intéragir avec la pompe.", true);
                FuelZone:KeyPressed("E", function()
                    FuelSys:Get("Menu"):Toggle();
                end)

            end, false, true)

            FuelZone:RadiusEvents(3.5, nil, function()

                FuelSys:Get("Menu"):Close();

            end);

        end

    end

end);