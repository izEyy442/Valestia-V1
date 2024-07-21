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

function KeyboardInputLjMotors(entryTitle, textEntry, inputText, maxLength)
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

OpenBetaMecaF6 = function()
    local mainMenu = RageUI.CreateMenu("", "Actions mécano")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()

            RageUI.Separator("↓ Gestion Annonces ~s~ ↓")
            RageUI.Button("Annonce ~b~[Ouvertures]~s~", nil, {}, not mecano3Cooldown1, {
                onSelected = function()
                    mecano3Cooldown1 = true
                    TriggerServerEvent('Ouvre:Mecano3')

                    CreateThread(function()
                        Wait(15000)
                        mecano3Cooldown1 = false
                    end)
                end
            })
            RageUI.Button("Annonce ~b~[Fermetures]~b~", nil, {}, not mecano3Cooldown2, {
                onSelected = function()
                    mecano3Cooldown2 = true
                    TriggerServerEvent('Ferme:Mecano3')

                    CreateThread(function()
                        Wait(15000)
                        mecano3Cooldown2 = false
                    end)
                end
            })
            RageUI.Button("Annonce ~b~[Recrutement]", nil, {}, not mecano3Cooldown3, {
                onSelected = function()
                    mecano3Cooldown3 = true
                    TriggerServerEvent('Recrutement:Mecano3')

                    CreateThread(function()
                        Wait(15000)
                        mecano3Cooldown3 = false
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
                                ESX.ShowAdvancedNotification('Notification', "North Mecano", "Véhicule réparé avec succès", 'CHAR_CALL911', 8)
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
                                ESX.ShowAdvancedNotification('Notification', "North Mecano", "Véhicule nettoyé avec succès", 'CHAR_CALL911', 8)
                            end)
                        end
                    end
                end
            })

            RageUI.Button("Mettre / Retirer le véhicule du plateau", "~b~Information\n~s~Vous devez d'abord monter dans votre dépanneuse à plateau", {}, true, {
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
                                        ESX.ShowAdvancedNotification('North Mecano', '~y~Notification', "~b~Mise sur le plateau réussi", 'CHAR_CARSITE3', 1)
                                    else
                                        ESX.ShowAdvancedNotification('North Mecano', '~y~Notification', "~b~Vous ne pouvez pas attacher votre véhicule de dépannage", 'CHAR_CARSITE3', 1)
                                    end
                                end
                            else
                                ESX.ShowAdvancedNotification('North Mecano', '~y~Notification', "~b~Aucun véhicule à proximité", 'CHAR_CARSITE3', 1)
                            end
                        else
                            AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                            DetachEntity(CurrentlyTowedVehicle, true, true)
                            CurrentlyTowedVehicle = nil
                            ESX.ShowAdvancedNotification('North Mecano', '~y~Notification', "~b~Véhicule retiré du plateau", 'CHAR_CARSITE3', 1)
                        end
                    else
                        ESX.ShowAdvancedNotification('North Mecano', '~y~Notification', "~b~Vous devez avoir un véhicule à plateau pour faire cela", 'CHAR_CARSITE3', 1)
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
                            ESX.ShowAdvancedNotification('Notification', "North Mecano", "Véhicule mis en fourrière", 'CHAR_CALL911', 8)
                        end)
                    end
                end
            })

            RageUI.Separator("↓ Gestion Facture ~s~ ↓")
            RageUI.Button("Faire une ~b~Facture", nil, {RightLabel = ""}, true , {
                onSelected = function()
                    local montant = KeyboardInputLjMotors("Montant:", 'Indiquez un montant', '', 7)
                    if tonumber(montant) == nil then
                        ESX.ShowAdvancedNotification('Notification', "North Mecano", "Montant invalide", 'CHAR_CALL911', 8)
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowAdvancedNotification('Notification', "North Mecano", "Personne autour de vous", 'CHAR_CALL911', 8)
						else
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'mecano3', "North Mecano", amount)
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

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Keys.Register('F6','InteractionsJobMecano3', "Menu job North Mecano", function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mecano3' then

        if (not IsInPVP) then
            OpenBetaMecaF6()
        end

    end
end)

local openedGarage = false

CustomJob = {
    {name = "mecano3" , label = "North Mecano", pointveh = vector3(123.87136077881, 6623.1533203125, 31.822353363037), pointdelveh = vector3(139.62802124023, 6632.2270507812, 31.670179367065)},
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
                    DrawMarker(1,mc.x,mc.y,mc.z-1.2,0.0,0.0,0.0,0.0,0.0,0.0,1.5,1.5,0.9,45,110,185,150,1,0,0,1,nil,nil,0)
                    if dif <= 5 then
                    Draw3DText(mc.x,mc.y,mc.z, "Appuyez sur [~b~E~w~] pour ouvrir le ~b~Garage")
                        if IsControlJustPressed(0, 51) then
                            openedGarage = true
                            openLjMotorsGarage()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function openLjMotorsGarage()
    local mainMenu = RageUI.CreateMenu('', 'Garage JLMotors')

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openedGarage do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Dépanneuse", nil, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
                onSelected = function()
                    TriggerServerEvent('izeyy:ljmotors:spawnVehicle', "flatbed")
                    RageUI.CloseAll()
                end
            })
            RageUI.Button("Baller", nil, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
                onSelected = function()
                    TriggerServerEvent('izeyy:ljmotors:spawnVehicle', "baller")
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
                        DrawMarker(1,mc.x,mc.y,mc.z-1.2,0.0,0.0,0.0,0.0,0.0,0.0,2.5,2.5,0.9,45,110,185,150,1,0,0,1,nil,nil,0)
                    Draw3DText(mc.x,mc.y,mc.z, "Appuyez sur [~b~E~w~] pour ranger le ~b~Véhicule")
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

local function setUniformMecano(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Mecano.Uniforms.male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Mecano.Uniforms.female)
		end
	end)
end

function MecanoClothesMenu()
    local mainMenu = RageUI.CreateMenu("", "Vestiaire LJMotors")
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
    while openClothesformecano do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Reprendre votre tenue de Ville", nil, { LeftBadge = RageUI.BadgeStyle.Star }, true , {
                onSelected = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end
            })
            RageUI.Button("Prendre votre tenue de Travail", nil, { LeftBadge = RageUI.BadgeStyle.Star }, true , {
                onSelected = function()
                    setUniformMecano('mecano', PlayerPedId())
                end
            })
        end)
        local onPos = false
        for _, v in pairs(Config.Mecano.Clothes) do
            if #(GetEntityCoords(PlayerPedId()) - v.clothes) <= 10 then
                onPos = true
            end
        end
        if not RageUI.Visible(mainMenu) or onPos == false then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            openClothesformecano = false
        end
        Citizen.Wait(0)
    end
end



Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end
    while true do
        local interval = 500
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)
        if ESX.PlayerData.job.name == 'mecano3' then
            for k,v in pairs(Config.Mecano.Clothes) do
                if #(coords - v.clothes) <= 4 then
                    DrawMarker(1, v.clothes.x, v.clothes.y, v.clothes.z-1.2, 0, 0, 0, 270, nil, nil, 1.2, 1.2, 0.7, 45,110,185, 255, 1, 0, 0, 1, nil, nil, 0)
                    interval = 1
                    if #(coords - v.clothes) <= 4 then
                        Draw3DText(v.clothes.x, v.clothes.y, v.clothes.z, "Appuyez sur [~b~E~w~] pour ouvrir le ~b~Vestiaire")
                        if IsControlJustPressed(0, 51) then
                            openClothesformecano = true
                            MecanoClothesMenu()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)
