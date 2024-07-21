---
--- @author Kadir#6666
--- Create at [08/05/2023] 14:33:00
--- Current project [Valestia-V1]
--- File name [Menu]
---

local FuelSys = Shared.Storage:Get("FuelSys");

---@type UIMenu
local FuelMenu = FuelSys:Get("Menu");
FuelMenu:SetData("slider_index", 1)

FuelMenu:IsVisible(function(Items)

    local player_vehicle = Client.Player:GetVehicle()

    if (player_vehicle == nil) then
        FuelMenu:Close()

    else

        local player_vehicle_fuel = (DoesEntityExist(player_vehicle) and FuelSys:Get("GetFuel")(player_vehicle))

        if (player_vehicle_fuel ~= nil) then

            local player_vehicle_fuel_rounded = (math.round(player_vehicle_fuel) + 0.0)

            if (player_vehicle_fuel_rounded <= 90.0) then

                local fuel_liter_choose_max = (100.0 - player_vehicle_fuel_rounded)
                local fuel_liter_choose_current = FuelMenu:GetData("slider_index")
                local fuel_liter_price = Config["Vehicle"]["Fuel"]["Price"]
                local fuel_liter_price_current = (fuel_liter_price * fuel_liter_choose_current)

                Items:SliderProgress(("Nombre de litre (%sL)"):format(fuel_liter_choose_current), fuel_liter_choose_current, fuel_liter_choose_max, "Nombre de litre que vous voulez ajouter au ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~réservoir~s~.", {

                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 255, G = 255, B = 255, A = 255 }

                }, true, {

                    onSliderChange = function(newIndex)

                        FuelMenu:SetData("slider_index", newIndex)

                    end

                })

                Items:Button("Confirmer", ("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%sL~s~ d'essence"):format(fuel_liter_choose_current), {

                    RightLabel = ("→ %s~g~$~s~"):format(fuel_liter_price_current)

                }, true, {

                    onSelected = function()

                        Shared.Events:ToServer(Enums.Vehicles.Events.BuyFuel, NetworkGetNetworkIdFromEntity(player_vehicle), fuel_liter_choose_current, fuel_liter_price_current)

                    end

                })

            else

                Items:Button("Votre réservoir est déjà rempli.", nil, {}, true, {})

            end

        end

    end

end, function(Panels)

    local player_vehicle = Client.Player:GetVehicle()

    if (player_vehicle ~= nil) then

        local player_vehicle_fuel = (DoesEntityExist(player_vehicle) and FuelSys:Get("GetFuel")(player_vehicle))

        if (player_vehicle_fuel ~= nil) then

            local player_vehicle_fuel_rounded = (math.round(player_vehicle_fuel) + 0.0)
            local fuel_percent = (player_vehicle_fuel_rounded / 100)

            Panels:StatisticPanel(fuel_percent, "Réservoir")

        end

    end

end, function()

    FuelMenu:SetData("slider_index", 1)

end);