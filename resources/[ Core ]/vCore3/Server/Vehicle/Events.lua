--[[
----
----Created Date: 4:40 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Events]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

Shared.Events:OnProtectedNet(Enums.Vehicles.Events.ReceiveProperties, function(xPlayer, plate, vehicleProperties)

    local vehicle = JG.VehicleManager:GetVehicleByPlate(plate);

    if (vehicle) then
        
        Shared.Events:Trigger(Enums.Vehicles.Events.OnPropertiesUpdate, xPlayer, vehicle:GetPlate(), vehicleProperties);

    end

end);

local vehicles_in_filling = {}
Shared.Events:OnNet(Enums.Vehicles.Events.BuyFuel, function(xPlayer, netId, fuelValue, fuelPrice)

    if (not xPlayer or type(netId) ~= "number" or type(fuelValue) ~= "number") then
        return
    end

    local entity_selected = NetworkGetEntityFromNetworkId(netId)

    if (entity_selected == 0 or not DoesEntityExist(entity_selected)) then
        return
    end

    local fuel_liter_price = Config["Vehicle"]["Fuel"]["Price"]
    local fuel_liter_price_calculated = (fuel_liter_price * fuelValue)

    if (type(fuel_liter_price_calculated) ~= "number" or fuel_liter_price_calculated < fuel_liter_price) then
        return
    end

    if (fuelPrice == nil or fuelPrice ~= fuel_liter_price_calculated) then
        return xPlayer.kick(("Event (%s) erreur détectée."):format(Enums.Vehicles.Events.BuyFuel))
    end

    if (vehicles_in_filling[entity_selected] ~= nil) then
        return xPlayer.showNotification(("Désolé, mais le reservoir de ce véhicule est déjà en cours de remplissage, veuillez patienter (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(vehicles_in_filling[entity_selected]:ShowRemaining()))
    end

    local buyAccount = {}

    buyAccount.list = {}
    buyAccount.list["cash"] = xPlayer.getAccount('cash').money
    buyAccount.list["bank"] = xPlayer.getAccount('bank').money
    buyAccount.current = nil

    if (buyAccount.list["cash"] > buyAccount.list["bank"]) then
        buyAccount.current = "cash"
    else
        buyAccount.current = "bank"
    end

    if (buyAccount.list[buyAccount.current] >= fuel_liter_price_calculated) then

        local fuel_await = (Config["Vehicle"]["Fuel"]["AWait"] * fuelValue);

        if (type(fuel_await) ~= "number") then

            return

        end

        vehicles_in_filling[entity_selected] = Shared.Timer(fuel_await);
        xPlayer.removeAccountMoney(buyAccount.current, fuel_liter_price_calculated)

        FreezeEntityPosition(entity_selected, true)
        vehicles_in_filling[entity_selected]:Start()
        xPlayer.showNotification(("Le réservoir de votre véhicule est en cours de remplissage, veuillez patienter (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(vehicles_in_filling[entity_selected]:ShowRemaining()))

        while (not vehicles_in_filling[entity_selected]:HasPassed()) do
            Wait(1000)
        end

        xPlayer.triggerEvent(Enums.Vehicles.Events.SetFuel, netId, fuelValue)
        FreezeEntityPosition(entity_selected, false)
        vehicles_in_filling[entity_selected] = nil;

        return xPlayer.showNotification("Le réservoir de votre véhicule a bien été ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~rempli~s~ avec succès.")

    else

        return xPlayer.showNotification(("Désolé, mais il vous manque %s~g~$~s~."):format((fuel_liter_price_calculated-buyAccount.list[buyAccount.current])))

    end

end);