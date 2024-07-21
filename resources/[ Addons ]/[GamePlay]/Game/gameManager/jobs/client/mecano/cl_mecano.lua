--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local CurrentlyTowedVehicle = nil

function KeyboardInputPolice(entryTitle, textEntry, inputText, maxLength)
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

openMecanoF6 = function()
    local mainMenu = RageUI.CreateMenu("", "Actions mécano")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()

            RageUI.Separator("↓ Gestion Annonces ~s~ ↓")
            RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Ouvertures]~s~", nil, {}, not mecanoCooldown1, {
                onSelected = function()
                    mecanoCooldown1 = true
                    TriggerServerEvent('Ouvre:Mecano')

                    CreateThread(function()
                        Wait(15000)
                        mecanoCooldown1 = false
                    end)
                end
            })
            RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Fermetures]~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~", nil, {}, not mecanoCooldown2, {
                onSelected = function()
                    mecanoCooldown2 = true
                    TriggerServerEvent('Ferme:Mecano')

                    CreateThread(function()
                        Wait(15000)
                        mecanoCooldown2 = false
                    end)
                end
            })
            RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Recrutement]", nil, {}, not mecanoCooldown3, {
                onSelected = function()
                    mecanoCooldown3 = true
                    TriggerServerEvent('Recrutement:Mecano')

                    CreateThread(function()
                        Wait(15000)
                        mecanoCooldown3 = false
                    end)
                end
            })

            RageUI.Separator("↓ Gestion Mécanique ~s~ ↓")
            RageUI.Button("Réparer le véhicule", nil, {}, true, {
                onSelected = function()

                    local playerPed = PlayerPedId()
                    local coords    = GetEntityCoords(playerPed)

                    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

                        local vehicle = nil

                        if IsPedInAnyVehicle(playerPed, false) then
                            vehicle = GetVehiclePedIsIn(playerPed, false)
                        else
                            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                        end

                        if DoesEntityExist(vehicle) then
                            TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                            Citizen.CreateThread(function()
                                Citizen.Wait(10000)
                                SetVehicleFixed(vehicle)
                                SetVehicleDeformationFixed(vehicle)
                                SetVehicleUndriveable(vehicle, false)
                                SetVehicleEngineOn(vehicle,  true,  true)
                                ClearPedTasksImmediately(playerPed)
                                ESX.ShowAdvancedNotification('Notification', "Benny's", "Véhicule réparé avec succès", 'CHAR_CALL911', 8)
                            end)
                        end
                    end
                end
            })

            RageUI.Button("Nettoyer le véhicule", nil, {}, true, {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords    = GetEntityCoords(playerPed)

                    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

                        local vehicle = nil

                        if IsPedInAnyVehicle(playerPed, false) then
                            vehicle = GetVehiclePedIsIn(playerPed, false)
                        else
                            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                        end

                        if DoesEntityExist(vehicle) then
                            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
                            Citizen.CreateThread(function()
                                Citizen.Wait(10000)
                                SetVehicleDirtLevel(vehicle, 0)
                                ClearPedTasksImmediately(playerPed)
                                ESX.ShowAdvancedNotification('Notification', "Benny's", "Véhicule nettoyé avec succès", 'CHAR_CALL911', 8)
                            end)
                        end
                    end
                end
            })

            RageUI.Button("Mettre / Retirer le véhicule du plateau", "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Information\n~s~Vous devez d'abord monter dans votre dépanneuse à plateau", {}, true, {
                onSelected = function()
                    local vehicledepannage = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 70)
                    local playerPed = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(playerPed, true)

                    local towmodel = GetHashKey('flatbed')
                    local isVehicleTow = IsVehicleModel(vehicle, towmodel)

                    if isVehicleTow then
                        if CurrentlyTowedVehicle == nil then
                            if DoesEntityExist(vehicledepannage) then
                                if not IsPedInAnyVehicle(playerPed, true) then
                                    if vehicle ~= vehicledepannage then
                                        ClearPedTasks(playerPed)
                                        AttachEntityToEntity(vehicledepannage, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                        CurrentlyTowedVehicle = vehicledepannage
                                        ESX.ShowAdvancedNotification('Benny\'s', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Mise sur le plateau réussi", 'CHAR_CARSITE3', 1)
                                    else
                                        ESX.ShowAdvancedNotification('Benny\'s', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous ne pouvez pas attacher votre véhicule de dépannage", 'CHAR_CARSITE3', 1)
                                    end
                                end
                            else
                                ESX.ShowAdvancedNotification('Benny\'s', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Aucun véhicule à proximité", 'CHAR_CARSITE3', 1)
                            end
                        else
                            AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                            DetachEntity(CurrentlyTowedVehicle, true, true)
                            CurrentlyTowedVehicle = nil
                            ESX.ShowAdvancedNotification('Benny\'s', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Véhicule retiré du plateau", 'CHAR_CARSITE3', 1)
                        end
                    else
                        ESX.ShowAdvancedNotification('Benny\'s', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous devez avoir un véhicule à plateau pour faire cela", 'CHAR_CARSITE3', 1)
                    end
                end
            })

            RageUI.Button("Mettre le véhicule en fourrière", nil, {}, true, {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords    = GetEntityCoords(playerPed)
                    local vehicle = nil
                    if IsPedInAnyVehicle(playerPed, false) then
                        vehicle = GetVehiclePedIsIn(playerPed, false)
                    else
                        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                    end
                    if DoesEntityExist(vehicle) then
                        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                        Citizen.CreateThread(function()
                            Citizen.Wait(10000)
                            ESX.Game.DeleteVehicle(vehicle)
                            ClearPedTasksImmediately(playerPed)
                            ESX.ShowAdvancedNotification('Notification', "Benny's", "Véhicule mis en fourrière", 'CHAR_CALL911', 8)
                        end)
                    end
                end
            })

            RageUI.Separator("↓ Gestion Facture ~s~ ↓")
            RageUI.Button("Faire une ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Facture", nil, {RightLabel = ""}, true , {
                onSelected = function()
                    local montant = KeyboardInputPolice("Montant:", 'Indiquez un montant', '', 7)
                    if tonumber(montant) == nil then
                        ESX.ShowAdvancedNotification('Notification', "Benny's", "Montant invalide", 'CHAR_CALL911', 8)
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowAdvancedNotification('Notification', "Benny's", "Personne autour de vous", 'CHAR_CALL911', 8)
						else
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'mecano', "Benny's", amount)
						end
                    end
                end
            })
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
        end
        Citizen.Wait(0)
    end
end

openLsF6 = function()
    local mainMenu2 = RageUI.CreateMenu("", "Actions mécano")

    RageUI.Visible(mainMenu2, not RageUI.Visible(mainMenu2))

    while mainMenu2 do
        RageUI.IsVisible(mainMenu2, function()

            RageUI.Separator("↓ Gestion Annonces ~s~ ↓")
            RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Ouvertures]~s~", nil, {}, not mecano2Cooldown1, {
                onSelected = function()
                    mecano2Cooldown1 = true
                    TriggerServerEvent('Ouvre:Mecano2')

                    CreateThread(function()
                        Wait(15000)
                        mecano2Cooldown1 = false
                    end)
                end
            })
            RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Fermetures]~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~", nil, {}, not mecano2Cooldown2, {
                onSelected = function()
                    mecano2Cooldown2 = true
                    TriggerServerEvent('Ferme:Mecano2')

                    CreateThread(function()
                        Wait(15000)
                        mecano2Cooldown2 = false
                    end)
                end
            })
            RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Recrutement]", nil, {}, not mecano2Cooldown3, {
                onSelected = function()
                    mecano2Cooldown3 = true
                    TriggerServerEvent('Recrutement:Mecano2')

                    CreateThread(function()
                        Wait(15000)
                        mecano2Cooldown3 = false
                    end)
                end
            })

            RageUI.Separator("↓ Gestion Mécanique ~s~ ↓")
            RageUI.Button("Réparer le véhicule", nil, {}, true, {
                onSelected = function()

                    local playerPed = PlayerPedId()
                    local coords    = GetEntityCoords(playerPed)

                    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

                        local vehicle = nil

                        if IsPedInAnyVehicle(playerPed, false) then
                            vehicle = GetVehiclePedIsIn(playerPed, false)
                        else
                            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                        end

                        if DoesEntityExist(vehicle) then
                            TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                            Citizen.CreateThread(function()
                                Citizen.Wait(10000)
                                SetVehicleFixed(vehicle)
                                SetVehicleDeformationFixed(vehicle)
                                SetVehicleUndriveable(vehicle, false)
                                SetVehicleEngineOn(vehicle,  true,  true)
                                ClearPedTasksImmediately(playerPed)
                                ESX.ShowAdvancedNotification('Notification', "Ls Custom", "Véhicule réparé avec succès", 'CHAR_CALL911', 8)
                            end)
                        end
                    end
                end
            })

            RageUI.Button("Nettoyer le véhicule", nil, {}, true, {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords    = GetEntityCoords(playerPed)

                    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

                        local vehicle = nil

                        if IsPedInAnyVehicle(playerPed, false) then
                            vehicle = GetVehiclePedIsIn(playerPed, false)
                        else
                            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                        end

                        if DoesEntityExist(vehicle) then
                            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
                            Citizen.CreateThread(function()
                                Citizen.Wait(10000)
                                SetVehicleDirtLevel(vehicle, 0)
                                ClearPedTasksImmediately(playerPed)
                                ESX.ShowAdvancedNotification('Notification', "Ls Custom", "Véhicule nettoyé avec succès", 'CHAR_CALL911', 8)
                            end)
                        end
                    end
                end
            })

            RageUI.Button("Mettre / Retirer le véhicule du plateau", "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Information\n~s~Vous devez d'abord monter dans votre dépanneuse à plateau", {}, true, {
                onSelected = function()
                    local vehicledepannage = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 70)
                    local playerPed = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(playerPed, true)

                    local towmodel = GetHashKey('flatbed')
                    local isVehicleTow = IsVehicleModel(vehicle, towmodel)

                    if isVehicleTow then
                        if CurrentlyTowedVehicle == nil then
                            if DoesEntityExist(vehicledepannage) then
                                if not IsPedInAnyVehicle(playerPed, true) then
                                    if vehicle ~= vehicledepannage then
                                        ClearPedTasks(playerPed)
                                        AttachEntityToEntity(vehicledepannage, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                        CurrentlyTowedVehicle = vehicledepannage
                                        ESX.ShowAdvancedNotification('LS Customs', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Mise sur le plateau réussi", 'CHAR_CARSITE3', 1)
                                    else
                                        ESX.ShowAdvancedNotification('LS Customs', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous ne pouvez pas attacher votre véhicule de dépannage", 'CHAR_CARSITE3', 1)
                                    end
                                end
                            else
                                ESX.ShowAdvancedNotification('LS Customs', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Aucun véhicule à proximité", 'CHAR_CARSITE3', 1)
                            end
                        else
                            AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                            DetachEntity(CurrentlyTowedVehicle, true, true)
                            CurrentlyTowedVehicle = nil
                            ESX.ShowAdvancedNotification('LS Customs', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Véhicule retiré du plateau", 'CHAR_CARSITE3', 1)
                        end
                    else
                        ESX.ShowAdvancedNotification('LS Customs', '~y~Notification', "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous devez avoir un véhicule à plateau pour faire cela", 'CHAR_CARSITE3', 1)
                    end
                end
            })

            RageUI.Button("Mettre le véhicule en fourrière", nil, {}, true, {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords    = GetEntityCoords(playerPed)
                    local vehicle = nil
                    if IsPedInAnyVehicle(playerPed, false) then
                        vehicle = GetVehiclePedIsIn(playerPed, false)
                    else
                        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                    end
                    if DoesEntityExist(vehicle) then
                        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                        Citizen.CreateThread(function()
                            Citizen.Wait(10000)
                            ESX.Game.DeleteVehicle(vehicle)
                            ClearPedTasksImmediately(playerPed)
                            ESX.ShowAdvancedNotification('Notification', "Ls Custom", "Véhicule mis en fourrière", 'CHAR_CALL911', 8)
                        end)
                    end
                end
            })

            RageUI.Separator("↓ Gestion Facture ~s~ ↓")
            RageUI.Button("Faire une ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Facture", nil, {RightLabel = ""}, true , {
                onSelected = function()
                    local montant = KeyboardInputPolice("Montant:", 'Indiquez un montant', '', 7)
                    if tonumber(montant) == nil then
                        ESX.ShowAdvancedNotification('Notification', "Ls Custom", "Montant invalide", 'CHAR_CALL911', 8)
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowAdvancedNotification('Notification', "Ls Custom", "Personne autour de vous", 'CHAR_CALL911', 8)
						else
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'mecano2', 'Ls Custom', amount)
						end
                    end
                end
            })
        end)
        if not RageUI.Visible(mainMenu2) then
            mainMenu2 = RMenu:DeleteType(mainMenu2, true)
        end
        Citizen.Wait(0)
    end
end

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Keys.Register('F6','InteractionsJobMecano', "Menu job Benny's", function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mecano' then

        if (not IsInPVP) then
            openMecanoF6()
        end

    end
end)

Keys.Register('F6','InteractionsJobMecano2', 'Menu job Ls Custom', function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mecano2' then

        if (not IsInPVP) then
            openLsF6()
        end

    end
end)

local openedGarage = false
local openedLSGarage = false

CustomJob = {
    {name = "mecano" , label = "Benny's", pointveh = vector3(-200.638, -1296.414, 31.29654), pointdelveh = vector3(-191.6074, -1290.388, 31.29654)},
}

CustomJob2 = {
    {name = "mecano2" , label = "Ls Custom", pointveh = vector3(-365.61938476563,-112.66687774658,38.696517944336), pointdelveh = vector3(-388.1576, -109.8566, 38.68908)},
}

CreateThread(function()
    while true do
        local interval = 750
        for _,v in pairs(CustomJob) do
            local mc = v.pointveh
            local pPed = PlayerPedId()
            local pc = GetEntityCoords(pPed)
            local dif = #(pc - mc)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.name then
                if dif < 10 then
                    interval = 1
                    DrawMarker(1,mc.x,mc.y,mc.z-1.2,0.0,0.0,0.0,0.0,0.0,0.0,1.2,1.2,0.7,45,110,185,255,true,false,0,true,nil,nil,false)
                    if dif <= 5 then
                    Draw3DText(mc.x, mc.y, mc.z, "Appuyez sur [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~s~] pour ouvrir le Garage", 4, 0.1, 0.1)
                        if IsControlJustPressed(0, 51) then
                            openedGarage = true
                            openBennyGarage()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

CreateThread(function()
    while true do
        local interval = 750
        for _,v in pairs(CustomJob2) do
            local mc = v.pointveh
            local pPed = PlayerPedId()
            local pc = GetEntityCoords(pPed)
            local dif = #(pc - mc)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.name then
                if dif < 10 then
                    interval = 1
                    DrawMarker(1,mc.x,mc.y,mc.z-1.2,0.0,0.0,0.0,0.0,0.0,0.0,1.2,1.2,0.7,45,110,185,255,true,false,0,true,nil,nil,false)
                    if dif <= 5 then
                    Draw3DText(mc.x, mc.y, mc.z, "Appuyez sur [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~s~] pour ouvrir le Garage", 4, 0.1, 0.1)
                        if IsControlJustPressed(0, 51) then
                            openedLSGarage = true
                            openLSGarage()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function openBennyGarage()
    local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openedGarage do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Dépanneuse", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    TriggerServerEvent('benny:spawnVehicle', "b2")
                    RageUI.CloseAll()
                end
            })
            RageUI.Button("Utilitaire", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    TriggerServerEvent('benny:spawnVehicle', "b3")
                    RageUI.CloseAll()
                end
            })
            RageUI.Button("Speedo", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    TriggerServerEvent('benny:spawnVehicle', "b4")
                    RageUI.CloseAll()
                end
            })
            RageUI.Button("Bison", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    TriggerServerEvent('benny:spawnVehicle', "b5")
                    RageUI.CloseAll()
                end
            })

        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            openedGarage = false
        end

        Citizen.Wait(0)
    end
end

function openLSGarage()
    local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openedLSGarage do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Dépanneuse", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    TriggerServerEvent('ls:spawnVehicle', "flatbed")
                    RageUI.CloseAll()
                end
            })

        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            openedLSGarage = false
        end

        Citizen.Wait(0)
    end
end

CreateThread(function()
    while true do
        local interval = 750
        for _,v in pairs(CustomJob) do
            local mc = v.pointdelveh
            local pPed = PlayerPedId()
            local pc = GetEntityCoords(pPed)
            local dif = #(pc - mc)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.name then
                if dif < 10 then
                    interval = 1
                    if dif <= 5 then
                    DrawMarker(1,mc.x,mc.y,mc.z-1.2,0.0,0.0,0.0,0.0,0.0,0.0,3.0,0.7,45,110,185,255,true,false,0,true,nil,nil,false)
                    Draw3DText(mc.x, mc.y, mc.z, "Appuyez sur [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~s~] pour ranger votre véhicule")
                        if IsControlJustPressed(0, 51) then
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            ESX.Game.DeleteVehicle(vehicle)
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

CreateThread(function()
    while true do
        local interval = 750
        for _,v in pairs(CustomJob2) do
            local mc = v.pointdelveh
            local pPed = PlayerPedId()
            local pc = GetEntityCoords(pPed)
            local dif = #(pc - mc)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.name then
                if dif < 10 then
                    interval = 1
                    if dif <= 5 then
                    DrawMarker(1,mc.x,mc.y,mc.z-1.2,0.0,0.0,0.0,0.0,0.0,0.0,3.0,3.0,0.7,45,110,185,255,true,false,0,true,nil,nil,false)
                    Draw3DText(mc.x, mc.y, mc.z, "Appuyez sur [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~s~] pour ranger votre véhicule")
                        if IsControlJustPressed(0, 51) then
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            ESX.Game.DeleteVehicle(vehicle)
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)