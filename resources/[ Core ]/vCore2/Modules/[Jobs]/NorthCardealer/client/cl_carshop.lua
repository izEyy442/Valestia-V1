
--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

local desCategories = {}
local desVehicles = {}
local isOpenedActions = false
local theCategoriesname
local theCategorieslabel
local thisIsForPreview = {}
local alwaysPreview = {}
local getsSocietyvehicles = {}
local LastVehicles = {}
local inCaseOf = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(1000)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    x,y,z = -574.61474609375, -1127.3721923828, 25.084943771362
    local blipvoiture = AddBlipForCoord(x,y,z)

	SetBlipSprite (blipvoiture, 810)
	SetBlipDisplay(blipvoiture, 4)
	SetBlipScale  (blipvoiture, 0.6)
	SetBlipAsShortRange(blipvoiture, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("[Entreprise] Premium Deluxe Motorsport")
	EndTextCommandSetBlipName(blipvoiture)

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    while true do
        local interval = 500
        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(ConfigNorth.JobsNorth.CardealerNorth.ActionsNorth) do
            if ESX.PlayerData.job.name == 'cardealer2' then
                if #(coords - v.actions) <= 10 then
                    interval = 1
                    DrawMarker(25, v.actions.x, v.actions.y, v.actions.z - 0.9, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, ConfigNorth.GetNorth.Marker.Color[1], ConfigNorth.GetNorth.Marker.Color[2], ConfigNorth.GetNorth.Marker.Color[3], 200, false, true, 2, false, false, false, false)
                    if #(coords - v.actions) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustReleased(0, 38) then
                            isOpenedActions = true
                            openNorthCardealerActions()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

function openNorthCardealerActions()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")
    local sortirVehicle = RageUI.CreateSubMenu(mainMenu, "", "Sortir un véhicule")
    local listeVehicles = RageUI.CreateSubMenu(mainMenu, "", "Liste des catégories")
    local lesVehiclesDeLaCategories = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local preview = RageUI.CreateSubMenu(mainMenu, '', 'Faites vos actions')
    local x,y,z

    preview.Closable = false
    preview.Closed = function()
        SetEntityCoords(PlayerPedId(), x, y, z)
        FreezeEntityPosition(PlayerPedId(), false)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        SetEntityLocallyInvisible(PlayerPedId(), false)
        for k,v in pairs(thisIsForPreview) do
            SetModelAsNoLongerNeeded(v.vehicle)
            ESX.Game.DeleteVehicle(v.vehicle)
        end
        RageUI.CloseAll()
    end

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while isOpenedActions do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Acheter un véhicule", nil , {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
                onSelected = function()
                    getCategoriesNorth()
                    getVehiclesNorth()
                end
            }, listeVehicles)
            RageUI.Button("Sortir un véhicule", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
                onSelected = function()
                    getPossedVehiclesNorth()
                end
            }, sortirVehicle)
            RageUI.Button("Donner les clefs", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowAdvancedNotification('Notification', "Concessionnaire Voiture", "Personne autour de vous", 'CHAR_CALL911', 8)
                    else
                        for k,v in pairs(inCaseOf) do
                            TriggerServerEvent('sellthevehicleNorth', GetPlayerServerId(closestPlayer), v.vehicleProps)
                            ESX.ShowAdvancedNotification('Notification', "Concessionnaire Voiture", "Vous avez bien donner le véhicule", 'CHAR_CALL911', 8)
                        end
                        inCaseOf = {}
                    end
                end
            })
            RageUI.Line()
            RageUI.Button("Appliquer une facture", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {
                onSelected = function()
                    local montant = KeyboardInputCardealerNorth("Montant:", 'Rentrez un montant', '', 8)
                    if tonumber(montant) == nil then
                        ESX.ShowAdvancedNotification('Notification', "Concessionnaire Voiture", "Montant invalide", 'CHAR_CALL911', 8)
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowAdvancedNotification('Notification', "Concessionnaire Voiture", "Personne autour de vous", 'CHAR_CALL911', 8)
						else
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'cardealer2', 'Concessionnaire Voiture', amount)
						end
                    end
                end
            })
            RageUI.Button("Ranger le véhicule sortie", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
                onSelected = function()
                    DeleteShopInsideVehiclesNorth()
                end
            })
        end)

        RageUI.IsVisible(sortirVehicle, function()
            for k,v in pairs(getsSocietyvehicles) do
                RageUI.Button(v.name, nil , {RightLabel = v.price.."$"}, true, {
                    onSelected = function()
                        local plate     = GeneratePlateNorth();
                        TriggerServerEvent('cardealer:removesocietycarNorth',  v.id, v.props, plate, v);

                        --[[
                        ESX.Game.SpawnVehicle(v.props, {x = -23.51, y = -1094.40, z = 27.30}, 338.00, function (vehicle)
                            local plaque     = GeneratePlateNorth()
                            SetVehicleNumberPlateText(vehicle, plaque)
                            table.insert(LastVehicles, vehicle)
                            local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
                            vehicleProps.plate = plaque
                            table.insert(inCaseOf, {
                                vehicle = v.props,
                                name = v.name,
                                price = v.price,
                                category = v.category,
                                vehicleProps = vehicleProps
                            })

                        end)
                        ]]
                        RageUI.CloseAll()
                    end
                })
            end
        end)

        RageUI.IsVisible(listeVehicles, function()
            for k,v in pairs(desCategories) do
                if v.name ~= 'avionfdp' and v.name ~= 'superboat' then
                    RageUI.Button(v.label, nil , {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
                        onSelected = function()
                            theCategories = v.name
                            theCategorieslabel = v.label
                        end
                    }, lesVehiclesDeLaCategories)
                end
            end
        end)

        RageUI.IsVisible(lesVehiclesDeLaCategories, function()
            -- RageUI.Separator("Catégorie : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..theCategorieslabel)
            RageUI.Line()
            for k,v in pairs(desVehicles) do
                if v.category == theCategories then
                    RageUI.Button(v.name, nil , {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
                        onSelected = function()
                            x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
                            local plyPed = PlayerPedId()
                            SetEntityCoords(plyPed, -596.79241943359, -1153.5020751953, 24.90885925293)
                            local vehicle = v.model
                            TriggerServerEvent('cardealer:changeBucketNorth', "enter")
                            ESX.Game.SpawnLocalVehicle(vehicle, {x = -596.79241943359, y = -1153.5020751953, z = 24.90885925293}, 123.55655670166016, function (vehicle)
                                TaskWarpPedIntoVehicle(plyPed, vehicle, -1)
                                FreezeEntityPosition(vehicle, true)
                                --SetModelAsNoLongerNeeded(vehicle)
                                table.insert(thisIsForPreview, {
                                    vehicle = vehicle,
                                    price = v.price,
                                    name = v.name,
                                    model = v.model
                                })
                            end)
                        end
                    }, preview)
                end
            end
        end)


        RageUI.IsVisible(preview, function()
            for k,v in pairs(thisIsForPreview) do
                local plyPed = PlayerPedId()
                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
                SetEntityLocallyInvisible(PlayerPedId(), true)
                if GetVehiclePedIsIn(plyPed) == 0 then
                    TaskWarpPedIntoVehicle(plyPed, v.vehicle, -1)
                end
                RageUI.Separator("Vehicule Choisis : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.name.."")
                RageUI.Line()
                RageUI.Button("Comfirmez l'achat", nil, {RightLabel = v.price.."~g~$"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('cardealer:getSocietyMoneyNorth', function(data)
                            local d = data;
                            if (d >= v.price) then
                                TriggerServerEvent('cardealer:buyVehicleNorth', v.model, v.name, v.price);
                                SetModelAsNoLongerNeeded(v.vehicle)
                                ESX.Game.DeleteVehicle(v.vehicle)
                                RageUI.CloseAll()
                                SetEntityCoords(PlayerPedId(), x, y, z)
                                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                                SetEntityLocallyInvisible(PlayerPedId(), false)
                                TriggerServerEvent('cardealer:changeBucketNorth', "leave")
                                inCaseOf = {}
                            else
                                ESX.ShowAdvancedNotification('Notification', "Concessionnaire Voiture", "Il n'y a pas suffisamment d'argent dans la société", 'CHAR_CALL911', 8)
                            end
                        end)
                    end
                })
                RageUI.Line()
                RageUI.Button("Refusé l'achat", nil, { Color = { BackgroundColor = { 200, 0, 0, 170 } } }, true, {
                    onSelected = function()
                        SetModelAsNoLongerNeeded(v.vehicle)
                        ESX.Game.DeleteVehicle(v.vehicle)
                        RageUI.CloseAll()
                        SetEntityCoords(PlayerPedId(), x, y, z)
                        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                        SetEntityLocallyInvisible(PlayerPedId(), false)
                        TriggerServerEvent('cardealer:changeBucketNorth', "leave")
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(listeVehicles) and not RageUI.Visible(lesVehiclesDeLaCategories) and not RageUI.Visible(preview) and not RageUI.Visible(sortirVehicle) then
            isOpenedActions = false
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
        if not RageUI.Visible(listeVehicles) and not RageUI.Visible(lesVehiclesDeLaCategories) and not RageUI.Visible(preview) then
            desCategories = {}
            desVehicles = {}
            thisIsForPreview = {}
        end
        if not RageUI.Visible(sortirVehicle) then
            getsSocietyvehicles = {}
            alwaysPreview = {}
        end

        Citizen.Wait(0)
    end
end

local NumberCharset = {}
local Charset = {}

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlateNorth()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetterNorth(ConfigNorth.PlateLetters) .. GetRandomNumberNorth(ConfigNorth.PlateNumbers))

		ESX.TriggerServerCallback('vehicle:verifierplaquedispoboutiqueNorth', function (IsPlateTakenNorth)
			if not IsPlateTakenNorth then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

RegisterNetEvent('cardealer:onSpawnVehicleNorth', function(menuData, vehicleNetworkId, vehicleProps)
    local data = menuData;
    exports["vCore3"]:GetByNetworkId(vehicleNetworkId, function(vehicle)
        table.insert(LastVehicles, vehicle);
        table.insert(inCaseOf, {
            vehicle = data.props,
            name = data.name,
            price = data.price,
            category = data.category,
            vehicleProps = vehicleProps
        });
    end)
end);

function GenerateSocietyPlateNorth(societyPlate)
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(societyPlate .. GetRandomNumberNorth(ConfigNorth.PlateNumbers))

		ESX.TriggerServerCallback('vehicle:verifierplaquedispoboutiqueNorth', function (IsPlateTakenNorth)
			if not IsPlateTakenNorth then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function IsPlateTakenNorth(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('vehicle:verifierplaquedispoboutiqueNorth', function(IsPlateTakenNorth)
		callback = IsPlateTakenNorth
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumberNorth(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return GetRandomNumberNorth(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetterNorth(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return GetRandomLetterNorth(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

function getCategoriesNorth()
    ESX.TriggerServerCallback('cardealer:getCategoriesNorth', function(cb)
        for i=1, #cb do
            local d = cb[i]
            table.insert(desCategories, {
                name = d.name,
                label = d.label,
                society = d.society
            })

        end
    end)
end

function getVehiclesNorth()
    ESX.TriggerServerCallback('cardealer:getAllVehiclesNorth', function(result)
        for i=1, #result do
            local d = result[i]
            table.insert(desVehicles, {
                model = d.model,
                name = d.name,
                price = d.price,
                category = d.category
            })
        end
    end)
end

function getPossedVehiclesNorth()
    ESX.TriggerServerCallback('cardealer:getSocietyVehiclesNorth', function(ladata)
        for i=1, #ladata do
            local d = ladata[i]
            table.insert(getsSocietyvehicles, {
                id = d.id,
                props = d.vehicle,
                name = d.name,
                price = d.price,
                society = d.society
            })
        end
    end)
end

function DeleteShopInsideVehiclesNorth()

    TriggerServerEvent("cardealer:deleteAllVehiclesNorth");

	--while #LastVehicles > 0 do
	--	local vehicle = LastVehicles[1]
    --
    --    NetworkGetNetworkIdFromEntity(vehicle);
    --
	--	ESX.Game.DeleteVehicle(vehicle);
    --
    --    for k,v in pairs(inCaseOf) do
    --        TriggerServerEvent('cardealer:recupvehicle', v.vehicle, v.name, v.price, v.society)
    --    end
	--	table.remove(LastVehicles, 1)
    --    inCaseOf = {}
	--end
end

function KeyboardInputCardealerNorth(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
      Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
      local result = GetOnscreenKeyboardResult()
      return result
    else
      return nil
    end
end

local open = false
local carMain2 = RageUI.CreateMenu('', 'Concessionnaire Voiture')
local subMenu7 = RageUI.CreateSubMenu(carMain2, "Annonces", "Interaction")
carMain2.Display.Header = true
carMain2.Closed = function()
  open = false
end

function OpenMenuCarShopNorth()
	if open then
		open = false
		RageUI.Visible(carMain2, false)
		return
	else
		open = true
		RageUI.Visible(carMain2, true)
		CreateThread(function()
		while open do
		   RageUI.IsVisible(carMain2,function()

			RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Ouvertures]~s~", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, not northDealerCooldown1, {
				onSelected = function()
                    northDealerCooldown1 = true
					TriggerServerEvent('Ouvre:CarShopNorth')

                    CreateThread(function()
                        Wait(15000)
                        northDealerCooldown1 = false
                    end)
				end
			})

			RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Fermetures]~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, not northDealerCooldown2, {
				onSelected = function()
                    northDealerCooldown2 = true
					TriggerServerEvent('Ferme:CarShopNorth')

                    CreateThread(function()
                        Wait(15000)
                        northDealerCooldown2 = false
                    end)
				end
			})

			RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Recrutement]", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, not northDealerCooldown3, {
				onSelected = function()
                    northDealerCooldown3 = true
					TriggerServerEvent('Recrutement:CarShopNorth')

                    CreateThread(function()
                        Wait(15000)
                        northDealerCooldown3 = false
                    end)
				end
			})
			end)

		 Wait(0)
		end
	 end)
  end
end

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Keys.Register('F6', 'carshop', 'Menu job carshop', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cardealer2' then
        if (not IsInPVP) then
            OpenMenuCarShopNorth()
        end
	end
end)