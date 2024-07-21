ESX = nil

local ArgentSale = {}
local Items = {}
local Armes = {}
local infosvehicle = {}
DragStatus = {}
DragStatus.IsDragged          = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.ESX, function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(500)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
    ESX.PlayerData.job2 = job
end)

openF7 = function()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")
    local interaction = RageUI.CreateSubMenu(mainMenu, "", "Interactions avec l'individue")
    local interactveh = RageUI.CreateSubMenu(mainMenu, "", "Interactions avec un vÉhicule")
    local fouiller = RageUI.CreateSubMenu(interaction, "", "Faites vos actions")
    local lesinfosduvehicle = RageUI.CreateSubMenu(interactveh, "", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do

        RageUI.IsVisible(mainMenu, function()
            if not exports.Game:IsInSafeZone() and not exports.Game:IsInMenotte() and not exports.Game:IsInPorter() and not exports.Game:IsInOtage() then
                RageUI.Button("Interaction avec l'individue", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                }, interaction)
                RageUI.Button("Interaction véhicule", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                }, interactveh)
            else
                RageUI.Button("Interaction avec le kidnappé", "Action impossible en safe zone", {RightLabel = RageUI.BadgeStyle.Lock}, false, {
                }, interaction)
                RageUI.Button("Interaction véhicule", "Action impossible en safe zone", {RightLabel = RageUI.BadgeStyle.Lock}, false, {
                }, interactveh)
            end
        end)

        RageUI.IsVisible(interaction, function()
            RageUI.Button("Prendre la carte d'identité", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    local getPlayerSearch = GetPlayerPed(player)
                    if IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                        if distance ~= -1 and distance <= 3.0 then
                            RageUI.CloseAll()
                            ExecuteCommand("me prend la carte d'identité..")
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(player), GetPlayerServerId(PlayerId()))
                        else
                            ESX.ShowNotification('~r~Personne autour de vous')
                        end
                    else
                        ESX.ShowNotification("Cette personne ne lève pas les mains")
                    end
                end
            })
            RageUI.Button("Dérober", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    local getPlayerSearch = GetPlayerPed(player)
                    if IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                        if player ~= -1 and distance <= 3.0 then
                            ExecuteCommand("me fouille l'individue..")
                            TriggerServerEvent('message', GetPlayerServerId(player))
                            getPlayerInv(player)
                        else
                            ESX.ShowNotification('~r~Personne autour de vous')
                        end
                    else
                        ESX.ShowNotification("Cette personne ne lève pas les mains")
                    end
                end
            }, fouiller)
    
           --[[ RageUI.Button("Menotter/Démenotter", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('~r~Personne autour de vous')
                    else
                        TriggerServerEvent('menotter', GetPlayerServerId(closestPlayer))
                    end
                end
            })
    
            RageUI.Button("Escorter", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(PlayerPedId())
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(PlayerPedId())
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('~r~Personne autour de vous')
                    else
                        TriggerServerEvent('escorter', GetPlayerServerId(closestPlayer))
                    end
                end
            })
    
            RageUI.Button("Jeter dans le véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('~r~Personne autour de vous')
                    else
                        TriggerServerEvent('jeter', GetPlayerServerId(closestPlayer))
                    end
                end
            })

            RageUI.Button("Sortir du véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('~r~Personne autour de vous')
                    else
                        TriggerServerEvent('sortir', GetPlayerServerId(closestPlayer))
                    end
                end
            })]]
        end)

        RageUI.IsVisible(interactveh, function()
            RageUI.Button("Informations du véhicule", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {
                onSelected = function()
                    local coords  = GetEntityCoords(PlayerPedId())
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
                    if DoesEntityExist(vehicle) then
                        getInfosVehicle(vehicleData)
                    else
                        ESX.ShowNotification("~r~Aucun véhicule à proximité")
                    end
                end
            }, lesinfosduvehicle)
            RageUI.Button("Crocheter le véhicule", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {
                onSelected = function()
                    local coords  = GetEntityCoords(PlayerPedId())
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    if DoesEntityExist(vehicle) then
                        local plyPed = PlayerPedId()
    
                        TaskStartScenarioInPlace(plyPed, 'WORLD_HUMAN_WELDING', 0, true)
                        Citizen.Wait(20000)
                        ClearPedTasksImmediately(plyPed)
    
                        SetVehicleDoorsLocked(vehicle, 1)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                        ESX.ShowNotification("~g~Véhicule dévérouillé")
                    else
                        ESX.ShowNotification("~r~Aucun véhicule à proximité")
                    end
                end
            })
        end)

        RageUI.IsVisible(fouiller, function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            local getPlayerSearch = GetPlayerPed(closestPlayer)
            if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                RageUI.GoBack()
                ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                return
            end

            if closestPlayer == -1 or closestDistance > 3.0 then
                RageUI.GoBack()
                return
            end
            
            -- RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Argent non déclaré ~s~↓")

            for k,v in pairs(ArgentSale) do
                RageUI.Button("Source Inconnu : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.label.."$", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {})
            end

            -- RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Items du joueur ~s~↓")

            RageUI.Line()
            for k,v in pairs(Items) do
                RageUI.Button(" ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.right.."X~s~ - "..v.label, nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {})
            end

            -- RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Armes du joueur ~s~↓")
            
            RageUI.Line()
            for k,v in pairs(Armes) do
                local isPermanent = ESX.IsWeaponPermanent(v.value)
                if not isPermanent then
                    RageUI.Button(""..v.label, nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {})
                end
            end

        end)

        RageUI.IsVisible(lesinfosduvehicle, function()
            local vehicle = ESX.Game.GetVehicleInDirection()
            if not DoesEntityExist(vehicle) then
                RageUI.GoBack()
                return
            end
            for k,v in pairs(infosvehicle) do
                RageUI.Button("Propriétaire: "..v.label, nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {
                })
                RageUI.Button("Plaque: "..v.plaque, nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true , {
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(lesinfosduvehicle) and not RageUI.Visible(fouiller) and not RageUI.Visible(interaction) and not RageUI.Visible(interactveh) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
        end

        if not RageUI.Visible(lesinfosduvehicle) then
            table.remove(infosvehicle, k)
        end

        if not RageUI.Visible(fouiller) then
            table.remove(ArgentSale, k)
            table.remove(Items, k)
            table.remove(Armes, k)
        end

        Citizen.Wait(0)
    end
end

RegisterNetEvent('menotterlejoueur')
AddEventHandler('menotterlejoueur', function()
    IsHandcuffed    = not IsHandcuffed;
    local playerPed = PlayerPedId()
  
    Citizen.CreateThread(function()
        if IsHandcuffed then
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end
  
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            DisableControlAction(2, 37, true)
            SetEnableHandcuffs(playerPed, true)
            SetPedCanPlayGestureAnims(playerPed, false)
            FreezeEntityPosition(playerPed,  true)
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 47, true)  -- Disable weapon
        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed,  true)
            FreezeEntityPosition(playerPed, false)
        end
    end)
end)

RegisterNetEvent('putInVehicle')
AddEventHandler('putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('outofVehicle')
AddEventHandler('outofVehicle', function()
    local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

RegisterNetEvent('actionescorter')
AddEventHandler('actionescorter', function(ganggg)
  IsDragged = not IsDragged
  GangPed = tonumber(ganggg)
end)

function getInfosVehicle(vehicleData)
    ESX.TriggerServerCallback('getVehicleInfos', function(retrivedInfo)
        if retrivedInfo.owner == nil then
            table.insert(infosvehicle, {
                label = "inconnu",
                plaque = vehicleData.plate
            })
        else
            table.insert(infosvehicle, {
                label = retrivedInfo.owner,
                plaque = retrivedInfo.plate
            })
        end
    end)
end

function getPlayerInv(player)
    
    ESX.TriggerServerCallback('getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'dirtycash' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'dirtycash',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
    
            end
        end
    
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end

        for i=1, #data.weapons, 1 do
           -- if data.weapons[i].count > 0 then
                table.insert(Armes, {
                    label    = ESX.GetWeaponLabel(data.weapons[i].name),
                    right    = data.weapons[i].ammo,
                    value    = data.weapons[i].name,
                    itemType = 'item_weapon',
                    amount   = data.weapons[i].ammo
                })   
           -- end
        end

    end, GetPlayerServerId(player))
end

Citizen.CreateThread(function()
    while true do
      Wait(0)
      if IsHandcuffed then
        if IsDragged then
          local ped = GetPlayerPed(GetPlayerFromServerId(GangPed))
          local myped = PlayerPedId()
          AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        else
          DetachEntity(PlayerPedId(), true, false)
        end
      end
    end
end)

function KeyboardInputOrga(entryTitle, textEntry, inputText, maxLength)
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

local IsInPVP = false;

Keys.Register('F7','Interactgang', 'Actions gangs', function()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name ~= "unemployed2" and ESX.PlayerData.job2.name ~= "unemployed" then
        if (not IsInPVP) then
            PlaySoundFrontend(-1, 'ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 1)
            openF7()
        else
            ESX.ShowNotification("Vous ne pouvez pas faire ceci pour le moment")
        end
    end
end)