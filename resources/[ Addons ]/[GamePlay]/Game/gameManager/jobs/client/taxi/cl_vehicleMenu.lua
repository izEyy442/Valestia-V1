---
--- @author Azagal
--- Create at [31/10/2022] 12:18:11
--- Current project [Silky-V1]
--- File name [vehicleMenu]
---

function Taxi:vehicleMenu()
    local menuPosition = Taxi.Config.vehicle.menuPosition
    local mainMenu = RageUI.CreateMenu("", "Garage")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while (mainMenu) do
        local playerCoords = GetEntityCoords(PlayerPedId())

        RageUI.IsVisible(mainMenu, function()
            if ServiceTaxi then
                RageUI.Separator("Liste des véhicules")

                for k,v in pairs(Taxi.Config.vehicle.model) do
                    RageUI.Button(v.label, nil, {
                        RightLabel = "Prendre →"
                    }, true, {
                        onSelected = function()
                            ESX.Game.SpawnVehicle(v.name, vector3(-1603.0594482422, -817.96423339844, 9.9909610748291), 314.66, function (vehicle)
                                local newPlate = GeneratePlate()
                                SetVehicleNumberPlateText(vehicle, newPlate)
                                SetVehicleFuelLevel(vehicle, 100.0)
                                TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            end)
                            TriggerServerEvent("Taxi:Spawn:Vehicle")
                            RageUI.GoBack()
                        end
                    })
                end
            else
                RageUI.Separator("Vous devez etre en service !")
            end
        end)

        Wait(0)
    end
end