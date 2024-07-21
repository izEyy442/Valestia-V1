--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

CustomHandler.Functions = {}

CustomHandler.Functions.Input = function(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
		blockinput = false
        return result
    else
        Wait(500)
		blockinput = false
        return nil
    end
end

CustomHandler.Functions.getVehicleProps = function()
    local vehicleProperties = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
    CustomHandler.Upgrades = vehicleProperties
    Wait(250)
    ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false), vehicleProperties)
end

CustomHandler.Functions.resetVehicleProps = function()
    ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.Upgrades)
end

CustomHandler.Functions.getCustomPrice = function()
    local price = 0 
    for k,v in pairs(CustomHandler.SetUpgrades) do 
        price = price + CustomHandler.SetUpgrades[k].priceOfCustom
    end
    return price
end

CustomHandler.Functions.getCategorieLabel = function(modType) 
    for _,v in pairs(CustomHandler.List.Categories) do 
        if modType == v.modType then 
            return v.name
        end
    end
end

CustomHandler.Functions.GetHornName = function(Index)
	if Index == 0 then
		return "Klaxon de camion"
	elseif Index == 1 then
		return "Klaxon de police"
	elseif Index == 2 then
		return "Klaxon Clown"
	elseif Index == 3 then
		return "Klaxon Musicale 1"
	elseif Index == 4 then
		return "Klaxon Musicale 2"
	elseif Index == 5 then
		return "Klaxon Musicale 3"
	elseif Index == 6 then
		return "Klaxon Musicale 4"
	elseif Index == 7 then
		return "Klaxon Musicale 5"
	elseif Index == 8 then
		return "Trombonne triste"
	elseif Index == 9 then
		return "Klaxon classique 1"
	elseif Index == 10 then
		return "Klaxon classique 2"
	elseif Index == 11 then
		return "Klaxon classique 3"
	elseif Index == 12 then
		return "Klaxon classique 4"
	elseif Index == 13 then
		return "Klaxon classique 5"
	elseif Index == 14 then
		return "Klaxon classique 6"
	elseif Index == 15 then
		return "Klaxon classique 7"
	elseif Index == 16 then
		return "Note - Do"
	elseif Index == 17 then
		return "Note - Re"
	elseif Index == 18 then
		return "Note - Mi"
	elseif Index == 19 then
		return "Note - Fa"
	elseif Index == 20 then
		return "Note - Sol"
	elseif Index == 21 then
		return "Note - La"
	elseif Index == 22 then
		return "Note - Ti"
	elseif Index == 23 then
		return "Note - Do"
	elseif Index == 24 then
		return "Klaxon Jazz 1"
	elseif Index == 25 then
		return "Klaxon Jazz 2"
	elseif Index == 26 then
		return "Klaxon Jazz 3"
	elseif Index == 27 then
		return "Klaxon Jazz Boucle"
	elseif Index == 28 then
		return "Klaxon Etoile 1"
	elseif Index == 29 then
		return "Klaxon Etoile 2"
	elseif Index == 30 then
		return "Klaxon Etoile 3"
	elseif Index == 31 then
		return "Klaxon Etoile 4"
	elseif Index == 32 then
		return "Klaxon classique 8 Boucle"
	elseif Index == 33 then
		return "Klaxon classique 9 Boucle"
	elseif Index == 34 then
		return "Klaxon classique 10 Boucle"
	elseif Index == 35 then
		return "Klaxon classique 8"
	elseif Index == 36 then
		return "Klaxon classique 9"
	elseif Index == 37 then
		return "Klaxon classique 10"
	elseif Index == 38 then
		return "Klaxon funérailles Boucle"
	elseif Index == 39 then
		return "Klaxon funérailles"
	elseif Index == 40 then
		return "Spooky Boucle"
	elseif Index == 41 then
		return "Spooky"
	elseif Index == 42 then
		return "San Andreas Boucle"
	elseif Index == 43 then
		return "San Andreas"
	elseif Index == 44 then
		return "Liberty City Boucle"
	elseif Index == 45 then
		return "Liberty City"
	elseif Index == 46 then
		return "Festif 1 Boucle"
	elseif Index == 47 then
		return "Festif 1"
	elseif Index == 48 then
		return "Festif 2 Boucle"
	elseif Index == 49 then
		return "Festif 2"
	elseif Index == 50 then
		return "Festif 3 Boucle"
	elseif Index == 51 then
		return "Festif 3"
	else
		return "Klaxon Inconnu"
	end
end

function setIndexCustom(value)
	for k,v in pairs(CustomHandler.SetUpgrades) do 		
		if k == CustomHandler.List.ModTypeValue[value] then 
			return true
		end
	end
end

function getCustomIndex(value)
	for k,v in pairs(CustomHandler.SetUpgrades) do 	
		if k == CustomHandler.List.ModTypeValue[value] then 
			return v.value 
		end
	end
end

function setCustom()
	for t,b in pairs(CustomHandler.Upgrades) do 
		if setIndexCustom(t) then 
			SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.List.ModTypeValue[t], getCustomIndex(t), 0)
		else
			if CustomHandler.List.ModTypeValue[t] ~= nil then 
				SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.List.ModTypeValue[t], b, 0)
			end
		end
	end
	Wait(120)
	if CustomHandler.SetUpgrades["primaryColor"] ~= nil then 
		if CustomHandler.SetUpgrades["secondaryColor"] ~= nil then 
			SetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.SetUpgrades["primaryColor"].color, CustomHandler.SetUpgrades["secondaryColor"].color)
		else
			SetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.SetUpgrades["primaryColor"].color, CustomHandler.Upgrades.color2)
		end
	else
		if CustomHandler.SetUpgrades["secondaryColor"] ~= nil then 
			SetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.Upgrades.color1, CustomHandler.SetUpgrades["secondaryColor"].color)
		else
			SetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.Upgrades.color1, CustomHandler.Upgrades.color2)
		end
	end
	if CustomHandler.SetUpgrades["pearlescentColor"] ~= nil then 
		if CustomHandler.SetUpgrades["wheelColor"] ~= nil then 
		 	SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.SetUpgrades["pearlescentColor"].color, CustomHandler.SetUpgrades["wheelColor"].color)
		else
			SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.SetUpgrades["pearlescentColor"].color, CustomHandler.Upgrades.wheelColor)
		end
	else
		if CustomHandler.SetUpgrades["wheelColor"] ~= nil then 
			SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.Upgrades.pearlescentColor, CustomHandler.SetUpgrades["wheelColor"].color)
		else
			SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.Upgrades.pearlescentColor, CustomHandler.Upgrades.wheelColor)
		end
	end
	if CustomHandler.SetUpgrades[48] ~= nil then 
		SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 48, CustomHandler.SetUpgrades[48].value, false)
		SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.SetUpgrades[48].value)
	else
		SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 48, CustomHandler.Upgrades.modLivery, false)
		SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.Upgrades.modLivery)
	end
	if CustomHandler.SetUpgrades["windowTint"] ~= nil then 
		SetVehicleWindowTint(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.SetUpgrades["windowTint"].value)
	else
		SetVehicleWindowTint(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.Upgrades.windowTint-1)
	end
	if CustomHandler.SetUpgrades["plateIndex"] ~= nil then 
		SetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.SetUpgrades["plateIndex"].value)
	else
		SetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(PlayerPedId(), false), CustomHandler.Upgrades.plateIndex)
	end
	Wait(120)
	for k,v in pairs(CustomHandler.SetUpgrades) do 
		if k == "modXenon" then 
			ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false), {modXenon = true})
		else
			ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false), {modXenon = false})
		end
		if k == "tyreSmokeColor" then
			ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false), {tyreSmokeColor = v.value})
		elseif k == "neonColor" then 
			ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false), {neonEnabled = {1,1,1,1}})
			ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false), {neonColor = v.value})
		end
	end
end

RegisterNetEvent("custom:receiveCustom")
AddEventHandler("custom:receiveCustom", function(haveMoney)
    if not haveMoney then 
        CustomHandler.Functions.resetVehicleProps()
        SetTimeout(250, function()
			RageUICustom.CloseAll()
        end)  
        return 
    end
    setCustom()
	Wait(500)
    RageUICustom.CloseAll()
	FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), false)
end)