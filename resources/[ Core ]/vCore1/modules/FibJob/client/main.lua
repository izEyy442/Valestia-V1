local main_menu = RageUI.AddMenu("", "Federal Investigation Bureau")
local player_action_menu = RageUI.AddSubMenu(main_menu, "", "Action Joueur")
local loot_menu = RageUI.AddSubMenu(player_action_menu, "", "Inventaire du joueur")
local fine_menu = RageUI.AddSubMenu(player_action_menu, "", "Amende")
local cell_menu = RageUI.AddSubMenu(player_action_menu, "", "Cellule")
local cell_player_menu = RageUI.AddSubMenu(player_action_menu, "", "Cellule")
local vehicle_action_menu = RageUI.AddSubMenu(main_menu, "", "Action Véhicule")
local vehicle_info_menu = RageUI.AddSubMenu(vehicle_action_menu, "", "Information sur le Véhicule")
local backup_menu = RageUI.AddSubMenu(main_menu, "", "Demande de renfort")
local object_menu = RageUI.AddSubMenu(main_menu, "", "Objets")
local delete_object_menu = RageUI.AddSubMenu(object_menu, "", "Objets")

local armory_menu = RageUI.AddMenu("", "Armurerie")
local garage_menu = RageUI.AddMenu("", "Garage")
local cloakroom_menu = RageUI.AddMenu("", "Vestiaire")

local isInService = false
local IsInPVP = false
local receiveInfo = {}
local InventoryItems = {}
local IventoryWeapon = {}
local InventoryBlackMoney = {}
isHandcuff = false
isEscort = false

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    while ESX.GetPlayerData()["job"] == nil do
        Wait(2000)
    end
    TriggerServerEvent("vCore1:fib:onConnecting")
end)

main_menu:IsVisible(function(Items)
    if isInService then
        Items:Button("Action joueur", nil, {}, true, {}, player_action_menu)
        Items:Button("Action véhicule", nil, {}, true, {}, vehicle_action_menu)
        Items:Button("Demande de renfort", nil, {}, true, {}, backup_menu)
        Items:Button("Objets", nil, {}, true, {}, object_menu)
    else
        Items:Separator("")
        Items:Separator("Vous devez être en service")
        Items:Separator("")
    end
end)

RegisterNetEvent('vCore1:fib:player:handcuff', function()
    isHandcuff = not isHandcuff
    local player = PlayerPedId()

    CreateThread(function()
        if isHandcuff then
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Wait(100)
            end

            TaskPlayAnim(player, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            SetEnableHandcuffs(player, true)
            SetPedCanPlayGestureAnims(player, false)

            CreateThread(function()
                while true do
                    if isHandcuff then
                        DisableControlAction(0, 24, true)
                        DisableControlAction(0, 257, true)
                        DisableControlAction(0, 25, true)
                        DisableControlAction(0, 21, true)
                        DisableControlAction(0, 263, true)
                        DisableControlAction(0, 45, true)
                        DisableControlAction(0, 22, true)
                        DisableControlAction(0, 44, true)
                        DisableControlAction(0, 37, true)
                        DisableControlAction(0, 23, true)
                        DisableControlAction(0, 288,  true)
                        DisableControlAction(0, 289, true)
                        DisableControlAction(0, 170, true)
                        DisableControlAction(0, 167, true)
                        DisableControlAction(0, 26, true)
                        DisableControlAction(0, 73, true)
                        DisableControlAction(2, 199, true)
                        DisableControlAction(0, 59, true)
                        DisableControlAction(0, 71, true)
                        DisableControlAction(0, 72, true)
                        DisableControlAction(2, 36, true)
                        DisableControlAction(0, 47, true)
                        DisableControlAction(0, 264, true)
                        DisableControlAction(0, 257, true)
                        DisableControlAction(0, 140, true)
                        DisableControlAction(0, 141, true)
                        DisableControlAction(0, 142, true)
                        DisableControlAction(0, 143, true)
                        DisableControlAction(0, 75, true)
                        DisableControlAction(27, 75, true)
                    else
                        break
                    end
                    Wait(0)
                end
            end)
        else
            ClearPedSecondaryTask(player)
            SetEnableHandcuffs(player, false)
            SetPedCanPlayGestureAnims(player,  true)
        end
    end)
end)

RegisterNetEvent('vCore1:fib:player:escort', function(cop)
    isEscort = not isEscort
    copPlayer = tonumber(cop)

    CreateThread(function()
        while true do
            Wait(0)
            local player = PlayerPedId()
            local cop = GetPlayerPed(GetPlayerFromServerId(copPlayer))

            if isHandcuff then

                if isEscort then
                    AttachEntityToEntity(player, cop, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                else
                    DetachEntity(player, true, false)
                    break
                end

            else
                break
            end
        end
    end)
end)

RegisterNetEvent('vCore1:fib:player:putInVehicle', function()
    local player = PlayerPedId()
	local coords = GetEntityCoords(player)

	if not isHandcuff then
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
				TaskWarpPedIntoVehicle(player, vehicle, freeSeat)
				isEscort = false
			end
		end
	end

end)

RegisterNetEvent('vCore1:fib:player:putOutVehicle', function()
	local player = PlayerPedId()

	if not IsPedSittingInAnyVehicle(player) then
		return
	end

	local vehicle = GetVehiclePedIsIn(player, false)
	TaskLeaveVehicle(player, vehicle, 16)

    SetTimeout(500, function()
        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Wait(100)
        end

        TaskPlayAnim(player, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
    end)
end)

player_action_menu:IsVisible(function(Items)
    local ped = PlayerPedId()
    local player, distance = ESX.Game.GetClosestPlayer()
    local coords = GetEntityCoords(ped)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local getPlayerSearch = GetPlayerPed(player)
    local isHandsUP = IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3)
    local isHandcuff = IsEntityPlayingAnim(getPlayerSearch, 'mp_arresting', 'idle', 3)
    local isInVehicle = IsPedInAnyVehicle(getPlayerSearch, false)

    Items:Button("Fouiller le joueur", nil, {}, true, {
        onSelected = function()
            if player ~= -1 and distance <= 5.0 then
                if isHandsUP then
                    ExecuteCommand("me fouille l'individu")
                    TriggerServerEvent("vCore1:fib:requestInventory", GetPlayerServerId(closestPlayer))
                else
                    ESX.ShowNotification("La personne en face ne lève pas les mains")
                end
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    }, loot_menu)

    Items:Button("Prendre la carte d'identité", nil, {}, true, {
        onSelected = function()
            if player ~= -1 and distance <= 5.0 then
                if isHandsUP then
                    ExecuteCommand("me prends la carte d'identité de l'individu")
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(player), GetPlayerServerId(PlayerId()))
                else
                    ESX.ShowNotification("La personne en face ne lève pas les mains")
                end
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })

	Items:Button("Mettre une amende au joueur", nil, {}, true, {}, fine_menu)

    Items:Button("Menotter le joueur", nil, {}, true, {
        onSelected = function()
            if closestPlayer ~= -1 and closestDistance < 5.0 then
                if not isInVehicle then
                    TriggerServerEvent("vCore1:fib:handcuff", GetPlayerServerId(closestPlayer))
                else
                    ESX.ShowNotification("Cette personne se trouve à l'intérieur d'un véhicule")
                end
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })

    Items:Button("Escorter le joueur", nil, {}, true, {
        onSelected = function()
            if closestPlayer ~= -1 and closestDistance < 5.0 then
                if isHandcuff then
                    if not isInVehicle then
                        TriggerServerEvent("vCore1:fib:escort", GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification("Cette personne se trouve à l'intérieur d'un véhicule")
                    end
                else
                    ESX.ShowNotification("Cette personne n'est pas menottée")
                end
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })

    Items:Button("Mettre le joueur dans le véhicule", nil, {}, true, {
        onSelected = function()
            if closestPlayer ~= -1 and closestDistance < 5.0 then
                if IsEntityAttachedToAnyPed(getPlayerSearch) then
                    TriggerServerEvent("vCore1:fib:putInVehicle", GetPlayerServerId(closestPlayer))
                else
                    ESX.ShowNotification("Vous devez escorter une personne")
                end
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })

    Items:Button("Sortir le joueur du véhicule", nil, {}, true, {
        onSelected = function()
            if closestPlayer ~= -1 and closestDistance < 5.0 then
                if isInVehicle then
                    TriggerServerEvent("vCore1:fib:putOutVehicle", GetPlayerServerId(closestPlayer))
                else
                    ESX.ShowNotification("La personne ne se trouve pas à l'intérieur d'un véhicule")
                end
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })

    local isInCellZone = #(coords - Config["FibJob"]["CellZone"] ) < Config["FibJob"]["CellRadius"]

    Items:Button("Mettre le joueur en cellule", nil, {}, isInCellZone, {}, cell_menu)

    Items:Button("Retirer le joueur de la cellule", nil, {}, isInCellZone, {
        onSelected = function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance < 5.0 then
                TriggerServerEvent("vCore1:fib:removeToCell", GetPlayerServerId(closestPlayer))
            else
                ESX.ShowNotification("Personne autour de vous")
            end
        end
    })

    if not (loot_menu:IsOpen()) then
        InventoryBlackMoney = {}
        InventoryItems = {}
        IventoryWeapon = {}
    end

end)

cell_menu:IsVisible(function(Items)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    for k,v in pairs(Config["FibJob"]["Cell"]) do

        Items:Button(v.label, nil, {}, true, {
            onSelected = function()
                if closestPlayer ~= -1 and closestDistance < 5.0 then
                    local timeToCell = tostring(Shared:KeyboardInput("Combien de minutes ?", 3))
                    if (Shared:InputIsValid(timeToCell, "number")) then
                        if tonumber(timeToCell) >= tonumber(Config["FibJob"]["CellTimeMin"]) and tonumber(timeToCell) <= tonumber(Config["FibJob"]["CellTimeMax"]) then
                            TriggerServerEvent("vCore1:fib:putInCell", GetPlayerServerId(closestPlayer), v.position, timeToCell)
                        else
                            ESX.ShowNotification(("Veuillez choisir une valeur entre %s-%s"):format(Config["FibJob"]["CellTimeMin"], Config["FibJob"]["CellTimeMax"]))
                        end
                    else
                        ESX.ShowNotification("Veuillez rentrer une valeur valide")
                    end
                else
                    ESX.ShowNotification("Personne autour de vous")
                end
            end
        })

    end
end)

local timer = 0
isInCell = false

cell_player_menu:IsVisible(function(Items)
    cell_player_menu:SetClosable(false)

    if not timer:HasPassed() then
        Items:Button("Temps Restant : ", nil, {RightLabel = timer:ShowRemaining()}, true, {})
    else
        isInCell = false
        cell_player_menu:Close()
        SetEntityCoords(PlayerPedId(), Config["FibJob"]["CellEnd"])
    end
end)

RegisterNetEvent('vCore1:fib:player:sendToCell', function(time, x, y, z)
    local position = vector3(x, y, z)
    timer = Shared.Timer(time)
    isInCell = true
    timer:Start()
    RageUI.CloseAll()
    SetEntityCoords(PlayerPedId(), position)
    cell_player_menu:Toggle()

    CreateThread(function()
        while isInCell do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if #(coords - position) > 20 then
                SetEntityCoords(player, position)
            end

            Wait(1000)
        end
    end)
end)

RegisterNetEvent('vCore1:fib:player:removeToCell', function()
    TriggerServerEvent("vCore1:fib:checkIsAllowed")
    isInCell = false
    timer:Stop()
end)


RegisterNetEvent('vCore1:fib:player:receiveInventory', function(data)
    if data then
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'dirtycash' then
                table.insert(InventoryBlackMoney, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'dirtycash',
                    itemType = 'money',
                    amount   = data.accounts[i].money
                })
            end
        end

        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(InventoryItems, {
                    label    = data.inventory[i].label,
                    count    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item',
                })
            end
        end

        for i=1, #data.weapons, 1 do
            table.insert(IventoryWeapon, {
                label    = ESX.GetWeaponLabel(data.weapons[i].name),
                value    = data.weapons[i].name,
                itemType = 'weapon',
            })
        end
    end
end)

loot_menu:IsVisible(function(Items)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local getPlayerSearch = GetPlayerPed(closestPlayer)
    local isHandsUP = IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3)

    if isHandsUP then
        if closestPlayer ~= -1 and closestDistance < 5.0 then

            if next(InventoryBlackMoney) ~= nil or next(InventoryItems) ~= nil or next(IventoryWeapon) ~= nil then

                if next(InventoryBlackMoney) ~= nil then
                    Items:Separator("↓ Argent non déclaré ↓")

                    for k,v in pairs(InventoryBlackMoney) do
                        Items:Button("Argent non déclaré :", nil, {RightLabel = ""..v.label.." ~g~$"}, true, {
                            onSelected = function()
                                local money = tostring(Shared:KeyboardInput("Somme a confisqué ? (Somme: "..v.label.."~g~ $~s~)", 7))
                                if (Shared:InputIsValid(money, "number")) then
                                    if tonumber(money) > 1 then
                                        if v.label >= tonumber(money) then
                                            v.label = v.label - tonumber(money)
                                            TriggerServerEvent("vCore1:fib:takeItem", GetPlayerServerId(closestPlayer),  v.itemType, v.value, tonumber(money))
                                        end
                                    else
                                        ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                    end
                                end
                            end
                        })
                    end

                else
                    Items:Separator("Chargement de l'argent..")
                end

                Items:Separator("↓ Items ↓")
                if next(InventoryItems) ~= nil then

                    for k,v in pairs(InventoryItems) do
                        if v.count > 0 then
                            Items:Button("Nom: "..v.label, nil, {RightLabel = ""..v.count.." exemplaires"}, true , {
                                onSelected = function()
                                    local item = tostring(Shared:KeyboardInput("Somme a prendre ? (Somme: "..Shared:ServerColorCode()..""..v.count.."~s~)", 3))
                                    if (Shared:InputIsValid(item, "number")) then
                                        if tonumber(item) > 0 then
                                            if v.count <= 0 then
                                                table.remove(InventoryItems, k)
                                            else
                                                v.count = v.count - tonumber(item)
                                            end
                                            TriggerServerEvent("vCore1:fib:takeItem", GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(item))
                                        else
                                            ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                        end
                                    end
                                end
                            })
                        else
                            Items:Separator("l'inventaire est vide")
                        end
                    end

                else
                    Items:Separator("l'inventaire est vide")
                end

                Items:Separator("↓ Armes ↓")
                if next(IventoryWeapon) ~= nil then

                    for k,v in pairs(IventoryWeapon) do
                        local isPermanent = ESX.IsWeaponPermanent(v.value)

                        if not isPermanent then
                            Items:Button(""..v.label, nil, {}, true, {
                                onSelected = function()
                                    table.remove(IventoryWeapon, k)
                                    TriggerServerEvent("vCore1:fib:takeItem", GetPlayerServerId(closestPlayer),  v.itemType, v.value, 1)
                                end
                            })
                        else
                            Items:Button(""..v.label, "Vous pouvez pas prendre cette arme car elle est permanente", {}, false, {})
                        end

                    end

                else
                    Items:Separator("Aucune arme dans l'inventaire")
                end

            else
                Items:Separator("Chargement en cours..")
            end
        else
            InventoryBlackMoney = {}
            InventoryItems = {}
            IventoryWeapon = {}
            RageUI.GoBack()
        end
    else
        InventoryBlackMoney = {}
        InventoryItems = {}
        IventoryWeapon = {}
        RageUI.GoBack()
    end
end, nil, function()
    InventoryBlackMoney = {}
    InventoryItems = {}
    IventoryWeapon = {}
end)

fine_menu:IsVisible(function(Items)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	for k, v in pairs(Config["FibJob"]["Fine"]) do
		Items:Button(v.label, nil, {RightLabel = v.price.. "~g~ $"}, true, {
			onSelected = function()
				if closestPlayer ~= -1 and closestDistance < 5.0 then
					TriggerServerEvent("vCore1:fib:sendFine", GetPlayerServerId(closestPlayer), v.label)
				else
					ESX.ShowNotification("Personne autour de vous")
				end
			end
		})
	end
end)

vehicle_action_menu:IsVisible(function(Items)
    Items:Button("Rechercher une plaque", nil, {}, true, {
        onSelected = function()
            local plate = tostring(Shared:KeyboardInput("Numero de plaque", 8))
            if (Shared:InputIsValid(plate, "string")) then
                if string.len(plate) >= 7 then
                    TriggerServerEvent("vCore1:fib:requestVehicleInfo", plate)
                else
                    RageUI.GoBack()
                    return
                end
            end
        end
    }, vehicle_info_menu)

    if not (vehicle_info_menu:IsOpen()) then
        receiveInfo = {}
    end

    Items:Button("Mettre le véhicule en fourrière", nil, {}, true, {
        onSelected = function()
            local player = PlayerPedId()

            RequestAnimDict('random@arrests')
            while not HasAnimDictLoaded('random@arrests') do
                Wait(100)
            end

            ExecuteCommand("me fait une demande d'une dépanneuse")
            TaskPlayAnim(player, 'random@arrests', 'generic_radio_enter', 1.0, -1, 2500, 49, 0, 0, 0, 0)
            SetTimeout(3500, function()
                TriggerServerEvent("vCore1:fib:putInPound")
            end)
        end
    })
end)

RegisterNetEvent('vCore1:fib:player:receiveVehicleInfo', function(plate, owner, vehicle)
    local player = PlayerPedId()

    if vehicle then

        local modelHash = vehicle.model
        local getNameVehicleModel = GetDisplayNameFromVehicleModel(modelHash)
        local modelLabelName = GetLabelText(getNameVehicleModel)

        receiveInfo = {
            plate = plate or "Inconnue",
            owner = owner or "Inconnue (Pas déclarer)",
            vehicle = modelLabelName or "Inconnue"
        }

    else

        receiveInfo = {
            plate = plate or "Inconnue",
            owner = owner or "Inconnue (Pas déclarer)",
            vehicle = "Inconnue"
        }

    end

    RequestAnimDict('random@arrests')
    while not HasAnimDictLoaded('random@arrests') do
        Wait(100)
    end

    ExecuteCommand("me fait une demande au central")
    TaskPlayAnim(player, 'random@arrests', 'generic_radio_enter', 1.0, -1, 2500, 49, 0, 0, 0, 0)
end)

vehicle_info_menu:IsVisible(function(Items)
    if (next(receiveInfo) ~= nil) then
        Items:Button("Numéro de plaque :", nil, {RightLabel = receiveInfo.plate}, true, {})
        Items:Button("Propriétaire :", nil, {RightLabel = receiveInfo.owner}, true, {})
        Items:Button("Modèle du véhicule :", nil, {RightLabel = receiveInfo.vehicle}, true, {})
    else
        Items:Separator("Chargement en cours..")
    end
end)

RegisterNetEvent('vCore1:fib:player:receiveBackupAlert', function(coords, type)
	if type == "low" then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowNotification("Demande de renfort demandé.\nRéponse: "..Shared:ServerColorCode().." CODE-2")
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 2
	elseif type == 'mid' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowNotification("Demande de renfort demandé.\nRéponse: "..Shared:ServerColorCode().." CODE-3")
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 47
	else
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
		ESX.ShowNotification("Demande de renfort demandé.\nRéponse: "..Shared:ServerColorCode().." CODE-99")
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
		color = 1
	end

    local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, 161)
	SetBlipScale(blip, 1.2)
	SetBlipColour(blip, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Demande renfort')
	EndTextCommandSetBlipName(blip)
    SetTimeout(80000, function()
        RemoveBlip(blip)
    end)
end)

backup_menu:IsVisible(function(Items)
    local player = PlayerPedId()
    local coords  = GetEntityCoords(player)

    RequestAnimDict('random@arrests')
    while not HasAnimDictLoaded('random@arrests') do
        Wait(100)
    end

    Items:Button("Petite demande (CODE-2)", nil, {}, true, {
        onSelected = function()
            ExecuteCommand("me fait une demande de renfort")
            TaskPlayAnim(player, 'random@arrests', 'generic_radio_enter', 1.0, -1, 2500, 49, 0, 0, 0, 0)
            TriggerServerEvent("vCore1:fib:callBackup", coords, "low")
        end
    })
    Items:Button("Moyenne demande (CODE-3)", nil, {}, true, {
        onSelected = function()
            ExecuteCommand("me fait une demande de renfort")
            TaskPlayAnim(player, 'random@arrests', 'generic_radio_enter', 1.0, -1, 2500, 49, 0, 0, 0, 0)
            TriggerServerEvent("vCore1:fib:callBackup", coords, "mid")
        end
    })
    Items:Button("Grande demande (CODE-99)", nil, {}, true, {
        onSelected = function()
            ExecuteCommand("me fait une demande de renfort")
            TaskPlayAnim(player, 'random@arrests', 'generic_radio_enter', 1.0, -1, 2500, 49, 0, 0, 0, 0)
            TriggerServerEvent("vCore1:fib:callBackup", coords, "high")
        end
    })
end)


local objectList = {}
local objectCounter = 0

local function spawnProps(model, label)
    local player = PlayerPedId()
    local prop = (type(model) == 'number' and model or GetHashKey(model))
    local coords  = GetEntityCoords(player)
    local forward = GetEntityForwardVector(player)
    local x, y, z   = table.unpack(coords + forward * 3.0)

    if objectCounter < Config["FibJob"]["MaxProps"] then
        CreateThread(function()
            ESX.Streaming.RequestModel(prop)
            local object = CreateObject(prop, x, y, z, true, true, true)
            table.insert(objectList, {label = label, entity = object})
            objectCounter = objectCounter + 1

            SetEntityAsMissionEntity(object, false, false)
            SetEntityHeading(object, GetEntityHeading(player))
            FreezeEntityPosition(object, true)
            SetEntityInvincible(object, true)
            SetModelAsNoLongerNeeded(prop)
            PlaceObjectOnGroundProperly(object)

            RequestCollisionAtCoord(coords)

            while not HasCollisionLoadedAroundEntity(object) do
                Wait(100)
            end

        end)
    else
        ESX.ShowNotification("Vous avez atteint la limite d'objets poser")
    end

end

object_menu:IsVisible(function(Items)
    Items:Button("Cone de circulation", nil, {}, true, {
        onSelected = function()
            spawnProps("prop_roadcone02a", "Cone")
        end
    })

    Items:Button("Barrière de securité", nil, {}, true, {
        onSelected = function()
            spawnProps("prop_barrier_work05", "Barriere")
        end
    })

    Items:Button("Supprimer", nil, {}, true, {}, delete_object_menu)
end)

local function propsMarker(props)
    local pos = GetEntityCoords(props)
    DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, Config["MarkerRGB"]["R"], Config["MarkerRGB"]["G"], Config["MarkerRGB"]["B"], Config["MarkerRGB"]["A1"], 0, 1, 2, 0, nil, nil, 0)
end

delete_object_menu:IsVisible(function(Items)
    for k, v in pairs(objectList) do
        Items:Button(""..v.label.." #"..k.."", nil, {}, true, {
            onActive = function()
                propsMarker(v.entity)
            end,
            onSelected = function()
                DeleteObject(v.entity)
                table.remove(objectList, k)
                objectCounter = objectCounter -1
            end
        })
    end
end)

CreateThread(function()
    local BossActionZone = Game.Zone("BossActionFibZone")

    BossActionZone:Start(function()

        BossActionZone:SetTimer(1000)
        BossActionZone:SetCoords(Config["FibJob"]["BossAction"])

        BossActionZone:IsPlayerInRadius(8.0, function()
            BossActionZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name
            local grade = playerData.job.grade_name

            if job == "fib" then

                if isInService then

                    if grade == "boss" then
                        BossActionZone:Marker()

                        BossActionZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder à l'action patron")
                        BossActionZone:IsPlayerInRadius(2.0, function()

                            BossActionZone:KeyPressed("E", function()
                                ESX.OpenSocietyMenu("fib")
                            end)

                        end, false, false)

                    end

                end

            end

        end, false, false)
    end)

    local ArmoryZone = Game.Zone("ArmoryFibZone")

    ArmoryZone:Start(function()

        ArmoryZone:SetTimer(1000)
        ArmoryZone:SetCoords(Config["FibJob"]["Armory"])

        ArmoryZone:IsPlayerInRadius(8.0, function()
            ArmoryZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "fib" then

                if isInService then

                    ArmoryZone:Marker()

                    ArmoryZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder à l'armurerie")
                    ArmoryZone:IsPlayerInRadius(2.0, function()

                        ArmoryZone:KeyPressed("E", function()
                            armory_menu:Toggle()
                        end)

                    end, false, false)

                end

            end

        end, false, false)

        ArmoryZone:RadiusEvents(3.0, nil, function()
            armory_menu:Close()
        end)
    end)

    local GarageZone = Game.Zone("GarageFibZone")

    GarageZone:Start(function()

        GarageZone:SetTimer(1000)
        GarageZone:SetCoords(Config["FibJob"]["Garage"])

        GarageZone:IsPlayerInRadius(8.0, function()
            GarageZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "fib" then

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

    local DeleteZone = Game.Zone("DeleteFibZone")

    DeleteZone:Start(function()

        DeleteZone:SetTimer(1000)
        DeleteZone:SetCoords(Config["FibJob"]["DeleteCar"])

        DeleteZone:IsPlayerInRadius(60, function()
            DeleteZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "fib" then

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

    local CloakroomZone = Game.Zone("CloakroomFibZone")

    CloakroomZone:Start(function()

        CloakroomZone:SetTimer(1000)
        CloakroomZone:SetCoords(Config["FibJob"]["Cloakroom"])

        CloakroomZone:IsPlayerInRadius(8.0, function()
            CloakroomZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "fib" then

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

    local SeizedZone = Game.Zone("SeizedFibZone")

    SeizedZone:Start(function()

        SeizedZone:SetTimer(1000)
        SeizedZone:SetCoords(Config["FibJob"]["SeizedTrunk"])

        SeizedZone:IsPlayerInRadius(8.0, function()
            SeizedZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name
            local grade = playerData.job.grade

            if job == "fib" then

                if grade >= Config["FibJob"]["SeizedTrunkAcess"] then

                    SeizedZone:Marker()

                    SeizedZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder au coffre")
                    SeizedZone:IsPlayerInRadius(2.0, function()

                        SeizedZone:KeyPressed("E", function()
                            ESX.OpenSocietyChest("fib")
                        end)

                    end, false, false)

                end

            end

        end, false, false)
    end)
end)

armory_menu:IsVisible(function(Items)
    local playerData = ESX.GetPlayerData()
    local grade = playerData.job.grade

    for k, v in pairs(Config["FibJob"]["ArmoryWeapon"]) do
        if tonumber(grade) >= tonumber(v.grade) then
            Items:Button(v.label, nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent("vCore1:fib:takeArmoryWeapon", v.weapon, v.label)
                end
            })
        end
    end
end)

garage_menu:IsVisible(function(Items)
    local playerData = ESX.GetPlayerData()
    local grade = playerData.job.grade

    for k, v in pairs(Config["FibJob"]["GarageVehicle"]) do
        if tonumber(grade) >= tonumber(v.grade) then
            Items:Button(v.label, nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent("vCore1:fib:spawnVehicle", v.vehicle, v.label)
                end
            })
        end
    end
end)

local function setUniform(type)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config["FibJob"]["Uniform"][type].male)

			if type == 'bullet' then
				TriggerServerEvent("vCore1:kevlar:addforjob", "fib", 100)
			end
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config["FibJob"]["Uniform"][type].female)

			if type == 'bullet' then
				TriggerServerEvent("vCore1:kevlar:addforjob", "fib", 100)
			end
		end
	end)
end

cloakroom_menu:IsVisible(function(Items)
    Items:Button("Prendre sa tenue", nil, {}, true, {
        onSelected = function()
            local playerData = ESX.GetPlayerData()
            local grade = playerData.job.grade_name

            setUniform(grade)
            TriggerServerEvent("vCore1:job:takeService", "fib", true)
            ESX.ShowNotification("Vous avez pris votre service")
            isInService = true
        end
    })
    Items:Button("Mettre un gilet pare-balles", nil, {}, true, {
        onSelected = function()
            setUniform("bullet")
        end
    })
    Items:Button("Mettre un gilet cadet", nil, {}, true, {
        onSelected = function()
            setUniform("gilet")
        end
    })
    Items:Button("Retirer le gilet", nil, {}, true, {
        onSelected = function()
            setUniform("ungilet")
            TriggerServerEvent("vCore1:kevlar:remove")
        end
    })
    Items:Button("Reprendre ses vêtements", nil, {}, true, {
        onSelected = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            TriggerServerEvent("vCore1:job:takeService", "fib", false)
            ESX.ShowNotification("Vous avez quitter votre service")
            isInService = false
        end
    })
end)

Shared:RegisterKeyMapping("vCore1:fibinteractmenu:use", { label = "open_menu_fibInteract" }, "F6", function()
    if not IsInPVP then
        local playerData = ESX.GetPlayerData()
        local job = playerData.job.name

        if job == "fib" then
		    main_menu:Toggle()
        end
	end
end)