local main_menu = RageUI.AddMenu("", "Los Santos Emergency Services")
local dead_menu = RageUI.AddMenu("", "Vous êtes mort")
local garage_menu = RageUI.AddMenu("", "Garage")
local cloakroom_menu = RageUI.AddMenu("", "Vestiaire")
local pharmacy_menu = RageUI.AddMenu("", "Pharmacie")
local player_action_menu = RageUI.AddSubMenu(main_menu, "", "Action Joueur")
local call_menu = RageUI.AddSubMenu(main_menu, "", "Liste des appels")

local IsInPVP = false
local isInService = false
local callInWaiting = {}

RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    ESX.PlayerLoaded = true
    ESX.PlayerData = xPlayer

    if (ESX.PlayerData.isDead) then

        SetTimeout(5000, function()

            SetEntityHealth(PlayerPedId(), 0)
            ESX.ShowNotification("Vous avez été mis dans le coma de force, car vous avez quitté le serveur dans le coma")

        end)

    end
end)

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP
end)

CreateThread(function()
    local model = GetHashKey("s_m_m_doctor_01")
    local ped = CreatePed(4, model, Config["AmbulanceJob"]["DoctorPed"], Config["AmbulanceJob"]["DoctorPedHeading"], false, true)

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(1)
    end

    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

end)

main_menu:IsVisible(function(Items)
    if isInService then
        Items:Button("Action joueur", nil, {}, true, {}, player_action_menu)
        Items:Button("Consulter les appels", nil, {}, true, {}, call_menu)
    else
        Items:Separator("")
        Items:Separator("Vous devez être en service")
        Items:Separator("")
    end
end)

player_action_menu:IsVisible(function(Items)
    local player, distance = ESX.Game.GetClosestPlayer()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    Items:Button("Faire une facture", nil, {}, true, {
        onSelected = function()
            if player ~= -1 and distance <= 5.0 then
                local amount = tostring(Shared:KeyboardInput("Prix de la facture ?", 5))
                if (Shared:InputIsValid(amount, "number")) then
                    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'ambulance', 'Ambulance', amount)
                end
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })

    Items:Button("Faire une réanimation", nil, {}, true, {
        onSelected = function()
            if player ~= -1 and distance <= 5.0 then
                TriggerServerEvent('vCore1:ambulance:heal', GetPlayerServerId(closestPlayer), "resuscitation")
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })

    Items:Button("Faire un petit soin", nil, {}, true, {
        onSelected = function()
            if player ~= -1 and distance <= 5.0 then
                TriggerServerEvent('vCore1:ambulance:heal', GetPlayerServerId(closestPlayer), "small")
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })

    Items:Button("Faire un grand soin", nil, {}, true, {
        onSelected = function()
            if player ~= -1 and distance <= 5.0 then
                TriggerServerEvent('vCore1:ambulance:heal', GetPlayerServerId(closestPlayer), "big")
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })


end)

call_menu:IsVisible(function(Items)
    for k, v in pairs(callInWaiting) do
        Items:Button("Appel #"..k, nil, {}, true, {
            onSelected = function()
                SetNewWaypoint(v.coords.x, v.coords.y)
                TriggerServerEvent("vCore1:ambulance:removeCall", k)
                ESX.ShowNotification("Vous avez pris l'appel #"..k)
            end
        })
    end
end)

pharmacy_menu:IsVisible(function(Items)
    for k, v in pairs(Config["AmbulanceJob"]["PharmacyShop"]) do
        Items:Button(v.label, nil, {}, true, {
            onSelected = function()
                local item = tostring(Shared:KeyboardInput("Nombre(s) d'objet(s) ?", 2))
                if (Shared:InputIsValid(item, "number")) then
                    TriggerServerEvent('vCore1:ambulance:buyItem', v.item, tonumber(item))
                end
            end
        })
    end
end)

local function RespawnPed(player, coords)
    if not IsInPVP then

        TriggerServerEvent("vCore1:ambulance:check")

        CreateThread(function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Wait(0)
            end

            NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
            SetPlayerInvincible(player, false)
            ClearPedBloodDamage(player)
            ResetPedVisibleDamage(player)
            ClearPedLastWeaponDamage(player)

            local respawnData = {
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z
                },
                heading = coords.heading or 0.0,
                model = GetEntityModel(player)
            }

            TriggerEvent("playerSpawned", respawnData, false)

            StopScreenEffect('DeathFailOut')
            DoScreenFadeIn(800)
        end)

    else

        CreateThread(function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Wait(0)
            end

            NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
            SetPlayerInvincible(player, false)
            ClearPedBloodDamage(player)
            ResetPedVisibleDamage(player)
            ClearPedLastWeaponDamage(player)

            local respawnData = {
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z
                },
                heading = coords.heading or 0.0,
                model = GetEntityModel(player)
            }

            TriggerEvent("playerSpawned", respawnData, false)

            local godCheck = true;
            local state = 100;

            SetTimeout(2500, function() godCheck = false
                SetEntityAlpha(playerPed, 255);
                SetPlayerInvincible(PlayerId(), false);
                DisablePlayerFiring(PlayerId(), false);
                NetworkSetFriendlyFireOption(true);
            end);

            CreateThread(function()
                while godCheck do

                    if (state == 100) then
                        state = 250;
                    elseif (state == 250) then
                        state = 100;
                    end

                    SetPlayerInvincible(PlayerId(), true);
                    SetEntityAlpha(playerPed, state);
                    DisablePlayerFiring(PlayerId(), true);
                    NetworkSetFriendlyFireOption(false);

                    Wait(250);

                end

            end)

            StopScreenEffect('DeathFailOut')
            DoScreenFadeIn(800)
        end)

    end
end

local function playAnimation(type)
    local player = PlayerPedId()

    if type == "resuscitation" then
        TaskStartScenarioInPlace(player, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    elseif type == "small" then
        TaskStartScenarioInPlace(player, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    elseif type == "big" then
        TaskStartScenarioInPlace(player, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    end

    SetTimeout(10000, function()
        ClearPedTasks(player)
    end)
end

RegisterNetEvent("vCore1:player:playAnimation", function(type)
    playAnimation(type)
end)

RegisterNetEvent("vCore1:player:heal", function(type, postion)
    local player = PlayerPedId()
    local health = GetEntityHealth(player)
    local coords = GetEntityCoords(player)

    if type == "resuscitation" then
        ESX.SetPlayerData('lastPosition', {
            x = coords.x,
            y = coords.y,
            z = coords.z
        })

        TriggerServerEvent('esx:updateLastPosition', {
            x = coords.x,
            y = coords.y,
            z = coords.z
        })

        RespawnPed(player, coords)
    elseif type == "small" then
        SetEntityHealth(player, health + 50)
    elseif type == "big" then
        TriggerEvent('esx_status:set', 'hunger', 1000000)
	    TriggerEvent('esx_status:set', 'thirst', 1000000)
        SetEntityHealth(player, health + 100)
    elseif type == "respawn" then
        ESX.SetPlayerData('lastPosition', {
            x = postion.x,
            y = postion.y,
            z = postion.z
        })

        TriggerServerEvent('esx:updateLastPosition', {
            x = postion.x,
            y = postion.y,
            z = postion.z
        })

        RespawnPed(player, postion)
    elseif type == "slay" then
        SetEntityHealth(player, 0)
    end

end)

local timer = 0

dead_menu:IsVisible(function(Items)

    if not IsInPVP then

        dead_menu:SetClosable(false)

        local timerHasPassed = timer:HasPassed()

        Items:Button("Envoyer un signal de détresse", nil, {}, true, {
            onSelected = function()
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                TriggerServerEvent("vCore1:ambulance:callEmergency", coords)
            end
        })

        local label = not timerHasPassed and ("Réaparition possible dans %s"):format(timer:ShowRemaining()) or "Réapparaître"
        Items:Button(label, nil, {}, timerHasPassed, {
            onSelected = function()
                TriggerServerEvent("vCore1:ambulance:respawn")
            end
        })

        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config["AmbulanceJob"]["DoctorPed"]) < 10 then
            Items:Button("Se faire soigner par le docteur", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent("vCore1:ambulance:buyNPC")
                end
            });
        end

    end

end)

RegisterNetEvent("vCore1:player:DeadMenu", function(bool)
    if bool then
        timer = Shared.Timer(Config["AmbulanceJob"]["RespawnTime"])
        timer:Start()
        exports['izeyy-inventory']:lockInventory(true)
        dead_menu:Toggle()
    else
        exports['izeyy-inventory']:lockInventory(false)
        dead_menu:Close()
    end
end)

RegisterNetEvent("vCore1:player:receiveCall", function(data, isNew)
    if (data) then

        if (isNew) then
            ESX.ShowNotification("Un nouvel appel a été reçu")
        end

        callInWaiting = data
    end
end)

garage_menu:IsVisible(function(Items)
    local playerData = ESX.GetPlayerData()
    local grade = playerData.job.grade

    for k, v in pairs(Config["AmbulanceJob"]["GarageVehicle"]) do
        if tonumber(grade) >= tonumber(v.grade) then
            Items:Button(v.label, nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent("vCore1:ambulance:spawnVehicle", v.vehicle, v.label)

                    ESX.Game.SpawnVehicle(v.vehicle, vector3(-1898.2557373047, -302.16693115234, 49.277523040771), 56.340370178222656, function (vehicle)
                        local newPlate = exports['Game']:GeneratePlate()
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        SetVehicleFuelLevel(vehicle, 100.0)
                        TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    end)
                end
            })
        end
    end
end)

local function setUniform(type)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config["AmbulanceJob"]["Uniform"][type].male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config["AmbulanceJob"]["Uniform"][type].female)
		end
	end)
end

cloakroom_menu:IsVisible(function(Items)
    Items:Button("Prendre sa tenue", nil, {}, true, {
        onSelected = function()
            setUniform("Uniforms")
            TriggerServerEvent("vCore1:job:takeService", "ambulance", true)
            ESX.ShowNotification("Vous avez pris votre service")
            isInService = true
        end
    })

    Items:Button("Reprendre ses vêtements", nil, {}, true, {
        onSelected = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            TriggerServerEvent("vCore1:job:takeService", "ambulance", false)
            ESX.ShowNotification("Vous avez quitter votre service")
            isInService = false
        end
    })
end)

CreateThread(function()
    local GarageZone = Game.Zone("GarageAmbulanceZone")

    GarageZone:Start(function()

        GarageZone:SetTimer(1000)
        GarageZone:SetCoords(Config["AmbulanceJob"]["Garage"])

        GarageZone:IsPlayerInRadius(8.0, function()
            GarageZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "ambulance" then

                if isInService then

                    GarageZone:Marker()

                    GarageZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder au garage")
                    GarageZone:IsPlayerInRadius(2.0, function()

                        GarageZone:KeyPressed("E", function()
                            garage_menu:Toggle()
                        end)

                    end, false, false)

                end

            end

        end, false, false)

        GarageZone:RadiusEvents(3.0, nil, function()
            garage_menu:Close()
        end)
    end)

    local DeleteZone = Game.Zone("DeleteAmbulanceZone")

    DeleteZone:Start(function()

        DeleteZone:SetTimer(1000)
        DeleteZone:SetCoords(Config["AmbulanceJob"]["DeleteCar"])

        DeleteZone:IsPlayerInRadius(60, function()
            DeleteZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "ambulance" then

                DeleteZone:Marker(nil, nil, 3.0)

                DeleteZone:IsPlayerInRadius(8.0, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule")

                    DeleteZone:KeyPressed("E", function()
                        local ped = PlayerPedId()
                        local vehicle = GetVehiclePedIsIn(ped, false)

                        TaskLeaveVehicle(ped, vehicle, 0)
                        SetTimeout(2000, function()
                            DeleteEntity(vehicle)
                        end)
                    end)

                end, false, true)

            end

        end, false, true)

    end)

    local BossActionZone = Game.Zone("BossActionAmbulanceZone")

    BossActionZone:Start(function()

        BossActionZone:SetTimer(1000)
        BossActionZone:SetCoords(Config["AmbulanceJob"]["BossAction"])

        BossActionZone:IsPlayerInRadius(8.0, function()
            BossActionZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name
            local grade = playerData.job.grade_name

            if job == "ambulance" then

                if isInService then

                    if grade == "boss" then
                        BossActionZone:Marker()

                        BossActionZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder à l'action patron")
                        BossActionZone:IsPlayerInRadius(2.0, function()

                            BossActionZone:KeyPressed("E", function()
                                ESX.OpenSocietyMenu("ambulance")
                            end)

                        end, false, false)

                    end

                end

            end

        end, false, false)
    end)

    local CloakroomZone = Game.Zone("CloakroomAmbulanceZone")

    CloakroomZone:Start(function()

        CloakroomZone:SetTimer(1000)
        CloakroomZone:SetCoords(Config["AmbulanceJob"]["Cloakroom"])

        CloakroomZone:IsPlayerInRadius(5.0, function()
            CloakroomZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "ambulance" then

                CloakroomZone:Marker()

                CloakroomZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder au vestiaire")
                CloakroomZone:IsPlayerInRadius(2.0, function()

                    CloakroomZone:KeyPressed("E", function()
                        cloakroom_menu:Toggle()
                    end)

                end, false, false)

            end

        end, false, false)

        CloakroomZone:RadiusEvents(3.0, nil, function()
            cloakroom_menu:Close()
        end)
    end)

    local PharmacyZone = Game.Zone("PharmacyAmbulanceZone")

    PharmacyZone:Start(function()

        PharmacyZone:SetTimer(1000)
        PharmacyZone:SetCoords(Config["AmbulanceJob"]["Pharmacy"])

        PharmacyZone:IsPlayerInRadius(8.0, function()
            PharmacyZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "ambulance" then

                if isInService then

                    PharmacyZone:Marker()

                    PharmacyZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder à la pharmacie")
                    PharmacyZone:IsPlayerInRadius(2.0, function()

                        PharmacyZone:KeyPressed("E", function()
                            pharmacy_menu:Toggle()
                        end)

                    end, false, false)

                end

            end

        end, false, false)

        PharmacyZone:RadiusEvents(3.0, nil, function()
            pharmacy_menu:Close()
        end)
    end)

    local DoctorZone = Game.Zone("DoctorZone")

    DoctorZone:Start(function()

        DoctorZone:SetTimer(1000)
        DoctorZone:SetCoords(Config["AmbulanceJob"]["DoctorPed"])

        DoctorZone:IsPlayerInRadius(3.0, function()
            DoctorZone:SetTimer(0)
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler au docteur")

            DoctorZone:IsPlayerInRadius(2.0, function()

                DoctorZone:KeyPressed("E", function()
                    TriggerServerEvent("vCore1:ambulance:buyNPC")
                end)

            end, false, false)

        end, false, false)

    end)

end)

Shared:RegisterKeyMapping("vCore1:ambulanceinteractmenu:use", { label = "open_menu_ambulanceInteract" }, "F6", function()
    if not IsInPVP then
        local playerData = ESX.GetPlayerData()
        local job = playerData.job.name

        if job == "ambulance" then
		    main_menu:Toggle()
        end
	end
end)


