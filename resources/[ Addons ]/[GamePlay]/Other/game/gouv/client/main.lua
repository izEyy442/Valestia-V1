ESX = nil

local ArgentSaleGouv = {}
local ItemsGouv = {}
local ArmesGouv = {}
local openClothes = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.ESX, function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(500)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    --èèlocal blip = AddBlipForCoord(Config.Gouv.PosBlip)

	--SetBlipSprite (blip, 164)
	--SetBlipDisplay(blip, 4)
--	SetBlipScale  (blip, 1.0)
--	SetBlipAsShortRange(blip, true)
   -- SetBlipColour(blip, 26)

	--BeginTextCommandSetBlipName("STRING")
	--AddTextComponentString("Gouvernement")
	--EndTextCommandSetBlipName(blip)
    while ESX.GetPlayerData()['job'] == nil do
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData()['job2'] == nil do
        Citizen.Wait(500)
    end
    while true do
        local interval = 500
        local plyCoords = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job.name == 'gouv' then
            if #(plyCoords - Config.Gouv.BossActions) <= 10 then
                if ESX.PlayerData.job.grade == 8 then
                    interval = 1
                    DrawMarker(Config.Marker.Type, Config.Gouv.BossActions, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], 0, 0, 255, 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(plyCoords - Config.Gouv.BossActions) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~  pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            OpenGouvBoss()
                        end
                    end
                end
            end
            if #(plyCoords - Config.Gouv.Armurerie) <= 10 then
                if ESX.PlayerData.job.grade ~= 0 and ESX.PlayerData.job.grade ~= 1 then
                    interval = 1
                    DrawMarker(Config.Marker.Type, Config.Gouv.Armurerie, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], 0, 0, 255, 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(plyCoords - Config.Gouv.Armurerie) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~  pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            OpenGouvArmurerie()
                        end
                    end
                end
            end
            if #(plyCoords - Config.Gouv.Vestiaire) <= 10 then
                if ESX.PlayerData.job.grade ~= 0 and ESX.PlayerData.job.grade ~= 1 then
                    interval = 1
                    DrawMarker(Config.Marker.Type, Config.Gouv.Vestiaire, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], 0, 0, 255, 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(plyCoords - Config.Gouv.Vestiaire) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~  pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            openClothes = true
                            openGouvCloathroom()
                        end
                    end
                end
            end
            if #(plyCoords - Config.Gouv.SortirVehicule) <= 10 then
                interval = 1
                DrawMarker(Config.Marker.Type, Config.Gouv.SortirVehicule, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], 0, 0, 255, 170, 0, 1, 0, 0, nil, nil, 0)
                if #(plyCoords - Config.Gouv.SortirVehicule) <= 3 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~  pour ouvrir le menu")
                    if IsControlJustPressed(0, 51) then
                        openSortirVehicle()
                    end
                end
            end
            if #(plyCoords - Config.Gouv.RangerVehicle) <= 10 then
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if DoesEntityExist(veh) then
                    interval = 1
                    DrawMarker(Config.Marker.Type, Config.Gouv.RangerVehicle, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], 0, 0, 255, 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(plyCoords - Config.Gouv.RangerVehicle) <= 6 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~  pour supprimer votre véhicule")
                        if IsControlJustPressed(0, 51) then
                            ESX.Game.DeleteVehicle(veh)
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)


function KeyboardInputGouv(entryTitle, textEntry, inputText, maxLength)
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

OpenF6Gouv = function()
    local mainMenu = RageUI.CreateMenu("", "Menu d'intéractions")
    local fouiller2 = RageUI.CreateSubMenu(mainMenu, "", "Menu fouille")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            if ESX.PlayerData.job.grade ~= 0 and ESX.PlayerData.job.grade ~= 1 then
                RageUI.Button("Fouiller une personne", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance ~= -1 and distance <= 3.0 then
                            getPlayerInvGouv(player)
                        else
                            ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Personne autour de vous", 'CHAR_CALL911', 8)
                        end
                    end

                }, fouiller2)
                RageUI.Button("Menotter/Démenotter", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Personne autour de vous", 'CHAR_CALL911', 8)
                        else
                            TriggerServerEvent('menotterForGouv', GetPlayerServerId(closestPlayer))
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
                            ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Personne autour de vous", 'CHAR_CALL911', 8)
                        else
                            TriggerServerEvent('escorterGouv', GetPlayerServerId(closestPlayer))
                        end
                    end
                })

                RageUI.Button("Mettre dans le véhicule", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Personne autour de vous", 'CHAR_CALL911', 8)
                        else
                            TriggerServerEvent('jeter', GetPlayerServerId(closestPlayer))
                        end
                    end
                })

                RageUI.Button("Sortir du véhicule", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Personne autour de vous", 'CHAR_CALL911', 8)
                        else
                            TriggerServerEvent('sortir', GetPlayerServerId(closestPlayer))
                        end
                    end
                })
            end
            RageUI.Button("Faire une Facture", nil, {RightLabel = ""}, true , {
                onSelected = function()
                    local montant = KeyboardInputGouv("Montant:", 'Indiquez un montant', '', 7)
                    if tonumber(montant) == nil then
                        ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Montant invalide", 'CHAR_CALL911', 8)
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestDistance == -1 or closestDistance > 3.0 then
							ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Personne autour de vous", 'CHAR_CALL911', 8)
						else
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'gouv', 'Gouvernement', amount)
						end
                    end
                end
            })
        end)

        RageUI.IsVisible(fouiller2, function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            local getPlayerSearch = GetPlayerPed(closestPlayer)
            if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                RageUI.GoBack()
                ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "La personne en face lève pas les mains en l'air", 'CHAR_CALL911', 8)
                return
            end

            if closestPlayer == -1 or closestDistance > 3.0 then
                RageUI.GoBack()
                return
            end

            RageUI.Separator("Vous Fouillez : " ..GetPlayerName(closestPlayer))

            RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Argent non déclaré ~s~↓")

            for k,v in pairs(ArgentSaleGouv) do
                RageUI.Button("Argent non déclaré :", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.label.."$"}, true , {
                    onSelected = function()
                        local combien = KeyboardInputGouv("Combien ?", 'Indiquez un nombre', '', 10)
                        if tonumber(combien) > v.amount then
                            ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Montant invalide", 'CHAR_CALL911', 8)
                        else
                            TriggerServerEvent('confiscatePlayerItemGouv', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                            RageUI.GoBack()
                        end
                    end
                })
            end

            RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Items du joueur ~s~↓")

            for k,v in pairs(ItemsGouv) do
                RageUI.Button("Nom: "..v.label, nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.right.." exemplaires"}, true , {
                    onSelected = function()
                        local combien = KeyboardInputGouv("Combien ", 'Indiquez un nombre', '', 4)
                        if tonumber(combien) > v.amount then
                            ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Montant invalide", 'CHAR_CALL911', 8)
                        else
                            TriggerServerEvent('confiscatePlayerItemGouv', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                            RageUI.GoBack()
                        end
                    end
                })
            end

            RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Armes du joueur ~s~↓")
            for k,v in pairs(ArmesGouv) do
                local isPermanent = ESX.IsWeaponPermanent(v.value)
                if not isPermanent then
                    RageUI.Button("Arme: "..v.label, nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                            local combien = KeyboardInputGouv("Nombre de munitions", 'Indiquez un nombre', '', 4)
                            if tonumber(combien) > 1 then
                                ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Montant invalide", 'CHAR_CALL911', 8)
                            else
                                TriggerServerEvent('confiscatePlayerItemGouv', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                RageUI.GoBack()
                            end
                        end
                    })
                end
            end

        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(fouiller2) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
        end

        if not RageUI.Visible(fouiller2) then
            table.remove(ArgentSaleGouv, k)
            table.remove(ItemsGouv, k)
            table.remove(ArmesGouv, k)
        end

        Citizen.Wait(0)
    end
end

OpenGouvBoss = function()
    local mainMenu = RageUIv2.CreateMenu("", "Menu du gouvernement")

    RageUIv2.Visible(mainMenu, not RageUIv2.Visible(mainMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while mainMenu do
        RageUIv2.IsVisible(mainMenu, true, true, true, function()

            RageUIv2.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Entreprises~s~ ↓")

            RageUIv2.ButtonWithStyle("Voir le montant du Taxi", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:taxi')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Concessionnaire", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:cardealer')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Concessionnaire Bateaux", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:boatshop')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Concessionnaire Avions", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:planeshop')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Unicorn", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:unicorn')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Avocat", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:avocat')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Vigneron", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:vigneron')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Journaliste", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:journalist')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Ls Custom", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:mecano2')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Benny's", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:mecano')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du Bahamas", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:bahamas')
                end
            end)

            RageUIv2.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Service-public~s~ ↓")

            RageUIv2.ButtonWithStyle("Voir le montant du LSPD", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:police')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du B.C.S.O", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:bcso')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant des Federal Bureau Investigation", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:fib')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant des EMS", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:ambulance')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du LTD Litle Seoul", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:ltd')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du LTD Miror Park", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:ltd2')
                end
            end)

            RageUIv2.ButtonWithStyle("Voir le montant du mécano North Mecano", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('gouv:mecano3')
                end
            end)


        end)
        if not RageUIv2.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
        Citizen.Wait(0)
    end
end

OpenGouvArmurerie = function()
    local mainMenu = RageUI.CreateMenu("", "Achetez vos équipements")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            for k,v in pairs(Config.Gouv.Items) do
                RageUI.Button(v.label, nil, {RightLabel = ""}, true, {
                    onSelected = function()
                        TriggerServerEvent('gouv:payWeapon', v.price, v.weapon)
                    end
                })
            end
			RageUI.Button("Gilet par balle", nil, {RightLabel = ""}, true, {
				onSelected = function()
					TriggerServerEvent('gouv:payArmor')
				end
			})
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
        Citizen.Wait(0)
    end
end

openSortirVehicle = function()
    local mainMenu = RageUI.CreateMenu("", "Sortir un véhicule")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            for k,v in pairs(Config.Gouv.ListeVehicle) do
                if ESX.PlayerData.job.grade >= v.grade then
                    RageUI.Button(v.label, nil, {RightLabel = ""}, true, {
                        onSelected = function()
                            -- TONIO HERE
                            ESX.Game.SpawnVehicle(v.model, Config.Gouv.PosSortirVehicule, Config.Gouv.HeadingSortirVehicule, function(vehicle)
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                RageUI.CloseAll()
                            end)
                        end
                    })
                end
            end
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
        Citizen.Wait(0)
    end
end


function getPlayerInvGouv(player)

    ESX.TriggerServerCallback('getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'dirtycash' and data.accounts[i].money > 0 then
                table.insert(ArgentSaleGouv, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'dirtycash',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })

            end
        end

        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(ItemsGouv, {
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
                table.insert(ArmesGouv, {
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

TS = true
Vetement2 = {

    Clothes = {},

    TshirtList = {},
    TshirtList2 = {},
    TorsoList = {},
    TorsoList2 = {},
    ArmsList = {},
    ArmsList2 = {},
    DecalsList = {},
    GiletList = {},
    GiletList2 = {},

    PantalonList = {},
    PantalonList2 = {},
    ChaussuresList = {},
    ChaussuresList2 = {},

    IndexGardeRobe = 1,
    TshirtIndex = 1,
    TshirtIndex2 = 1,
    TorsoIndex = 1,
    TorsoIndex2 = 1,
    ArmsIndex = 1,
    ArmsIndex2 = 1,
    DecalsIndex = 1,
    DecalsIndex2 = 1,
    GiletIndex = 1,
    GiletIndex2 = 1,

    PantalonIndex = 1,
    PantalonIndex2 = 1,
    ChaussuresIndex = 1,
    ChaussuresIndex2 = 1,

    Masque = {},
	Masque2 = {},
	Lunettes = {},
	Lunettes2 = {},
	Chapeau = {},
	Chapeau2 = {},
	Sac = {},
	Sac2 = {},
	Chaine = {},
	Chaine2 = {},
	Oreille = {},
	Oreille2 = {},
	MasqueIndex = 1,
	MasqueIndex2 = 1,
	LunetteIndex = 1,
	LunetteIndex2 = 1,
	ChapeauIndex = 1,
	ChapeauIndex2 = 1,
	SacIndex = 1,
	SacIndex2 = 1,
	ChaineIndex = 1,
	ChaineIndex2 = 1,
	OreilleIndex = 1,
	OreilleIndex2 = 1
}

Citizen.CreateThread(function()
	Wait(5000)
    for i = 0, 400 do
        table.insert(Vetement2.Masque, i)
    end
	for i = 0, 100 do
        table.insert(Vetement2.Lunettes, i)
    end
	for i = 0, 	300 do
        table.insert(Vetement2.Chapeau, i)
    end
	for i = 0, 200 do
        table.insert(Vetement2.Sac, i)
    end
	for i = 0, 400 do
        table.insert(Vetement2.Chaine, i)
    end
	for i = 0, 100 do
        table.insert(Vetement2.Oreille, i)
    end
    Vetement2.DecalsList = {}
    for i = 0, 200 do
        table.insert(Vetement2.DecalsList, i)
    end
end)

function openGouvCloathroom()
    local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')
    local vetements = RageUI.CreateSubMenu(mainMenu, "", "Voici les vêtements disponibles")
    local garderobe = RageUI.CreateSubMenu(mainMenu, "", "Voici toutes vos tenues")
    local tshirt = RageUI.CreateSubMenu(vetements, "", "Voici les T-Shirt disponibles")
    local tshirt2 = RageUI.CreateSubMenu(vetements, "", "Voici les variations de T-Shirt disponibles")
    local torse = RageUI.CreateSubMenu(vetements, "", "Voici les torses disponibles")
    local torse2 = RageUI.CreateSubMenu(vetements, "", "Voici les variations de torses disponibles")
    local bras = RageUI.CreateSubMenu(vetements, "", "Voici les bras disponibles")
    local calque = RageUI.CreateSubMenu(vetements, "", "Voici les calques disponibles")
    local calque2 = RageUI.CreateSubMenu(vetements, "", "Voici les calques disponibles")
    local bproof = RageUI.CreateSubMenu(vetements, "", "Voici les calques disponibles")
    local bproof2 = RageUI.CreateSubMenu(vetements, "", "Voici les calques disponibles")
    local pantalon = RageUI.CreateSubMenu(vetements, "", "Voici les pantalons disponibles")
    local pantalon2 = RageUI.CreateSubMenu(vetements, "", "Voici les variations des pantalons disponibles")
    local chaussures = RageUI.CreateSubMenu(vetements, "", "Voici les chaussures disponibles")
    local chaussures2 = RageUI.CreateSubMenu(vetements, "", "Voici les variations des chaussures disponibles")

    local mask = RageUI.CreateSubMenu(vetements, "", "Voici tout les masques disponibles")
	local lunette = RageUI.CreateSubMenu(vetements, "", "Voici tout les paires de lunettes disponibles")
	local chapeau = RageUI.CreateSubMenu(vetements, "", "Voici tout les chapeaux disponibles")
	local sac = RageUI.CreateSubMenu(vetements, "", "Voici tout les sacs disponibles")
	local chaine = RageUI.CreateSubMenu(vetements, "", "Voici toutes les chaines disponibles")
	local oreille = RageUI.CreateSubMenu(vetements, "", "Voici toutes les accésoires d'oreille disponibles")

	local variationsmasque = RageUI.CreateSubMenu(vetements, "", "Voici toutes les variations de masque disponibles")
	local variationslunette = RageUI.CreateSubMenu(vetements, "", "Voici toutes les variations de lunettes disponibles")
	local variationschapeau = RageUI.CreateSubMenu(vetements, "", "Voici toutes les variations de chapeau disponibles")
	local variationssac = RageUI.CreateSubMenu(vetements, "", "Voici toutes les variations de sacs disponibles")
	local variationschaine = RageUI.CreateSubMenu(vetements, "", "Voici toutes les variations de chaine disponibles")
	local variationsoreille = RageUI.CreateSubMenu(vetements, "", "Voici toutes les variations d'oreille disponibles")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    local NoTenueDispo = false

    while openClothes do
        local playerPed = PlayerPedId()
        local grade = ESX.PlayerData.job.grade_name
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Vêtements", nil, {RightLabel = "→"}, true , {}, vetements)
            RageUI.Button("Valider la tenue et l'enregister", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    local name = KeyboardInputGouv("Indiquer le nom de la tenue", "Indiquer le nom de la tenue", "", 10)
                    if name then
                        local TempoSkin = {}
                        local ListVet = {
                            ["tshirt_1"] = true,
                            ["tshirt_2"] = true,
                            ["torso_1"] = true,
                            ["torso_2"] = true,
                            ["arms"] = true,
                            ["arms_2"] = true,
                            ["decals_1"] = true,
                            ["decals_2"] = true,
                            ["pants_1"] = true,
                            ["pants_2"] = true,
                            ["shoes_1"] = true,
                            ["shoes_2"] = true,
                            ["bproof_1"] = true,
                            ["bproof_2"] = true,
                            ["mask_1"] = true,
                            ["mask_2"] = true,
                            ["glasses_1"] = true,
                            ["glasses_2"] = true,
                            ["helmet_1"] = true,
                            ["helmet_1"] = true,
                            ["bags_1"] = true,
                            ["bags_2"] = true,
                            ["chain_1"] = true,
                            ["chain_2"] = true,
                            ["ears_1"] = true,
                            ["ears_2"] = true,
                        }
                        TriggerEvent("skinchanger:getSkin", function(skin)
                            TriggerServerEvent("esx_skin:save", skin)
                            for k,v in pairs(skin) do
                                if ListVet[k] ~= nil then
                                    TempoSkin[k] = v
                                end
                            end
                            TriggerServerEvent("johnny:addtenue", name, TempoSkin)
                        end)
                    end
                end
            })

            RageUI.Button("Garde Robe", "Accéder à la garde robe", {RightLabel = "→"}, true, {}, garderobe)
            -- RageUI.Button("Enfiler sa tenue", nil, {RightLabel = "→"}, true , {
            --     onSelected = function()
            --         if grade == 'recruit' then
            --             setUniform('recruit_wear', playerPed)
            --         elseif grade == 'officer' then
            --             setUniform('officer_wear', playerPed)
            --         elseif grade == 'sergeant' then
            --             setUniform('sergeant_wear', playerPed)
            --         elseif grade == 'lieutenant' then
            --             setUniform('lieutenant_wear', playerPed)
            --         elseif grade == 'capitaine' then
            --             setUniform('capitaine_wear', playerPed)
            --         elseif grade == 'commander' then
            --             setUniform('commander_wear', playerPed)
            --         elseif grade == 'deputy' then
            --             setUniform('deputy_wear', playerPed)
            --         elseif grade == 'assistantboss' then
            --             setUniform('sassistantboss_wear', playerPed)
            --         elseif grade == 'boss' then
            --             setUniform('boss_wear', playerPed)
            --         end
            --     end
            -- })
            -- RageUI.Button("Reprendre ses vêtements", nil, {RightLabel = "→"}, true , {
            --     onSelected = function()
            --         ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            --             TriggerEvent('skinchanger:loadSkin', skin)
            --         end)
            --     end
            -- })
        end)
        RageUI.IsVisible(vetements, function()

            RageUI.Button("T-Shirt", nil, {RightLabel = "→"}, true, {}, tshirt)

            RageUI.Button("Variations T-Shirt", nil, {RightLabel = "→"}, true, {}, tshirt2)

            RageUI.Button("Torses", nil, {RightLabel = "→"}, true, {}, torse)

            RageUI.Button("Variations Torses", nil, {RightLabel = "→"}, true, {}, torse2)

            RageUI.Button("Gilet Pare-Balle", nil, {RightLabel = "→"}, true, {}, bproof)

            RageUI.Button("Variations Gilet Pare-Balle", nil, {RightLabel = "→"}, true, {}, bproof2)

            RageUI.Button("Bras", nil, {RightLabel = "→"}, true, {}, bras)

            RageUI.Button("Calques", nil, {RightLabel = "→"}, true, {}, calque)

            RageUI.Button("Variations Calques", nil, {RightLabel = "→"}, true, {}, calque2)

            RageUI.Button("Pantalon", nil, {RightLabel = "→"}, true, {}, pantalon)

            RageUI.Button("Variations Pantalon", nil, {RightLabel = "→"}, true, {}, pantalon2)

            RageUI.Button("Chaussures", nil, {RightLabel = "→"}, true, {}, chaussures)

            RageUI.Button("Variations Chaussures", nil, {RightLabel = "→"}, true, {}, chaussures2)

            RageUI.Button("Masques",  nil, {RightLabel = "→"}, true, {}, mask)

            RageUI.Button("Variation Masques",  nil, {RightLabel = "→"}, true, {}, variationsmasque)

			RageUI.Button("Lunettes",  nil, {RightLabel = "→"}, true, {}, lunette)

            RageUI.Button("Variation Lunettes",  nil, {RightLabel = "→"}, true, {}, variationslunette)

			RageUI.Button("Chapeaux",  nil, {RightLabel = "→"}, true, {}, chapeau)

            RageUI.Button("Variation Chapeaux",  nil, {RightLabel = "→"}, true, {}, variationschapeau)

			RageUI.Button("Sac",  nil, {RightLabel = "→"}, true, {
				onSelected = function()
					SetEntityHeading(PlayerPedId() , 155.0)
				end
			}, sac)

            RageUI.Button("Vaiation Sac",  nil, {RightLabel = "→"}, true, {}, variationssac)

			RageUI.Button("Chaînes",  nil, {RightLabel = "→"}, true, {}, chaine)

            RageUI.Button("Variation Chaînes",  nil, {RightLabel = "→"}, true, {}, variationschaine)

			RageUI.Button("Boucle d'oreille",  nil, {RightLabel = "→"}, true, {
				onSelected = function()
					SetEntityHeading(PlayerPedId() , 70.0)
				end
			}, oreille)

            RageUI.Button("Variation Boucle d'oreille",  nil, {RightLabel = "→"}, true, {}, variationsoreille)

        end, function()
        end)

        RageUI.IsVisible(garderobe, function()

            if ClothesPlayer ~= nil then
                for k, v in pairs(ClothesPlayer) do
                    if v.equip == "n" and v.type == "vetement" then
                        NoTenueDispo = true
                        RageUI.List("Tenue "..v.label, {"Equiper", "Renomer", "Supprimer"}, Vetement2.IndexGardeRobe, nil, {}, true, {
                            onListChange = function(Index)
                                Vetement2.IndexGardeRobe = Index
                            end,
                            onSelected = function(Index)
                                if Index == 1 then
                                    CreateThread(function()
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            TriggerEvent('skinchanger:loadClothes', skin, json.decode(v.skin))
                                            Citizen.Wait(50)
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                TriggerServerEvent('esx_skin:save', skin)
                                            end)
                                        end)
                                    end)
                                    ESX.ShowAdvancedNotification('Notification', 'Gouvernement', "Vous avez enfilé la tenue : "..v.label, 'CHAR_CALL911', 8)
                                elseif Index == 2 then
                                    local newname = KeyboardInputGouv("Nouveau nom","Nouveau nom", "", 15)
                                    if newname then
                                        TriggerServerEvent("johnny:RenameTenue", v.id, newname)
                                    end
                                elseif Index == 3 then
                                    TriggerServerEvent('johnny:deletetenue', v.id)
                                end
                            end
                        })
                    else
                        NoTenueDispo = false
                    end
                end
                if not NoTenueDispo then
                    RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Aucune tenue disponible")
                end
            else
                RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas de tenue")
            end
        end)

        RageUI.IsVisible(tshirt, function()
            RageUI.Button("T-Shirt 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement2.TshirtList2 = {}
                    TriggerEvent('skinchanger:change', 'tshirt_1', 0)
                    TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                    Vetement2.TshirtIndex = 0
                    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 8, 0) -2 do
                        table.insert(Vetement2.TshirtList2, i)
                    end
                end
            })
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 8) - 1, 1 do
                RageUI.Button("T-Shirt "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.TshirtList2 = {}
                        Vetement2.TshirtIndex = i
                        TriggerEvent('skinchanger:change', 'tshirt_1', i)
                        TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                        for n = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 8, i) -2 do
                            table.insert(Vetement2.TshirtList2, n)
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(tshirt2, function()
            RageUI.Button("Variation T-Shirt 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement2.TshirtIndex2 = 0
                    TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                end
            })
            for k, v in pairs(Vetement2.TshirtList2) do
                RageUI.Button("Variation T-Shirt "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.TshirtIndex2 = k
                        TriggerEvent('skinchanger:change', 'tshirt_2', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(torse, function()
            RageUI.Button("Torse 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement2.TorsoList2 = {}
                    Vetement2.TorsoIndex = 0
                    TriggerEvent('skinchanger:change', 'torso_1', 0)
                    TriggerEvent('skinchanger:change', 'torso_2', 0)
                    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 11, 0) -2 do
                        table.insert(Vetement2.TorsoList2, i)
                    end
                end
            })
            -- Torses
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 11) - 1, 1 do
                RageUI.Button("Torse "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.TorsoList2 = {}
                        Vetement2.TorsoIndex = i
                        TriggerEvent('skinchanger:change', 'torso_2', 0)
                        TriggerEvent('skinchanger:change', 'torso_1', i)
                        for n = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 11, i) -2 do
                            table.insert(Vetement2.TorsoList2, i)
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(torse2, function()
            RageUI.Button("Variations Torse 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement2.TorsoIndex2 = 0
                    TriggerEvent('skinchanger:change', 'torso_2', 0)
                end
            })
            for k, v in pairs(Vetement2.TorsoList2) do
                RageUI.Button("Variations Torse "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.TorsoIndex2 = k
                        TriggerEvent('skinchanger:change', 'torso_2', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(bras, function()
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 3) - 1, 1 do
                RageUI.Button("Bras "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.ArmsIndex = i
                        TriggerEvent('skinchanger:change', 'arms', i)
                    end
                })
            end
        end)

        RageUI.IsVisible(calque, function()
            RageUI.Button("Calques 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement2.DecalsIndex = 0
                    TriggerEvent('skinchanger:change', 'decals_1', 0)
                end
            })
            for k, v in pairs(Vetement2.DecalsList) do
                RageUI.Button("Calques "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.DecalsIndex = k
                        TriggerEvent('skinchanger:change', 'decals_1', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(calque2, function()
            RageUI.Button("Variations Calques 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement2.DecalsIndex2 = 0
                    TriggerEvent('skinchanger:change', 'decals_2', 0)
                end
            })
            for k, v in pairs(Vetement2.DecalsList) do
                RageUI.Button("Variations Calques "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.DecalsIndex2 = k
                        TriggerEvent('skinchanger:change', 'decals_2', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(bproof, function()
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 4) - 1, 1 do
                RageUI.Button("Gilet Pare-Balle "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        TriggerEvent('skinchanger:change', 'bproof_1', i)
                        TriggerEvent('skinchanger:change', 'bproof_2', 0)
                        Vetement2.GiletList2 = {}
                        Vetement2.GiletIndex = i
                        for n = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 4, i) -2 do
                            table.insert(Vetement2.GiletList2, n)
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(bproof2, function()
            RageUI.Button("Variation Gilet Pare-Balle 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement2.GiletIndex2 = 0
                    TriggerEvent('skinchanger:change', 'bproof_2', 0)
                end
            })
            for k, v in pairs(Vetement2.GiletList2) do
                RageUI.Button("Variation Gilet Pare-Balle "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.GiletIndex2 = k
                        TriggerEvent('skinchanger:change', 'bproof_2', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(pantalon, function()
            RageUI.Button("Pantalon 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    TriggerEvent('skinchanger:change', 'pants_1', 0)
                    TriggerEvent('skinchanger:change', 'pants_2', 0)
                    Vetement2.PantalonList2 = {}
                    Vetement2.PantalonIndex = 0
                    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 4, 0) -2 do
                        table.insert(Vetement2.PantalonList2, i)
                    end
                end
            })
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 4) - 1, 1 do
                RageUI.Button("Pantalon "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        TriggerEvent('skinchanger:change', 'pants_1', i)
                        TriggerEvent('skinchanger:change', 'pants_2', 0)
                        Vetement2.PantalonList2 = {}
                        Vetement2.PantalonIndex = i
                        for n = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 4, i) -2 do
                            table.insert(Vetement2.PantalonList2, n)
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(pantalon2, function()
            RageUI.Button("Variation Pantalon 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement2.PantalonIndex2 = 0
                    TriggerEvent('skinchanger:change', 'pants_2', 0)
                end
            })
            for k, v in pairs(Vetement2.PantalonList2) do
                RageUI.Button("Variation Pantalon "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.PantalonIndex2 = k
                        TriggerEvent('skinchanger:change', 'pants_2', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(chaussures, function()
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 6) - 1, 1 do
                RageUI.Button("Chaussure "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.ChaussuresIndex = i
                        TriggerEvent('skinchanger:change', 'shoes_1', i)
                        TriggerEvent('skinchanger:change', 'shoes_2', 0)
                        Vetement2.ChaussuresList2 = {}
                        for n = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 6, i) -2 do
                            table.insert(Vetement2.ChaussuresList2, n)
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(chaussures2, function()
            RageUI.Button("Variation Chaussure 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement2.ChaussuresIndex2 = 0
                    TriggerEvent('skinchanger:change', 'shoes_2', 0)
                end
            })
            for k, v in pairs(Vetement2.ChaussuresList2) do
                RageUI.Button("Variation Chaussure "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement2.ChaussuresIndex2 = k
                        TriggerEvent('skinchanger:change', 'shoes_2', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(mask, function()
			RageUI.Button("Aucun Masque ", nil, {}, true, {
				onActive = function()
					Vetement2.MasqueIndex = 0
					TriggerEvent('skinchanger:change', 'mask_1', 0)
					TriggerEvent('skinchanger:change', 'mask_2', 0)
					Vetement2.Masque2 = {}
					for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 1, 0)-2 do
						table.insert(Vetement2.Masque2, i)
					end
				end,
				onSelected = function()
					RageUI.Visible(mask, false)
					RageUI.Visible(lunette, true)
				end
			})

			for k, v in pairs(Vetement2.Masque) do
				RageUI.Button("Masque "..k, nil, {}, true, {
					onActive = function()
						Vetement2.MasqueIndex = k
						TriggerEvent('skinchanger:change', 'mask_1', k)
						TriggerEvent('skinchanger:change', 'mask_2', 0)
						Vetement2.Masque2 = {}
						for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 1, k)-2 do
							table.insert(Vetement2.Masque2, i)
						end

					end,
				})
			end
		end)

		RageUI.IsVisible(variationsmasque, function()

			RageUI.Button("Variation Masque 0", nil, {}, true, {
				onActive = function()
					Vetement2.MasqueIndex2 = 0
					TriggerEvent('skinchanger:change', 'mask_2', 0)
				end,
			})
			for k, v in pairs(Vetement2.Masque2) do
				RageUI.Button("Variation Masque "..k, nil, {}, true, {
					onActive = function()
						Vetement2.MasqueIndex2 = k
						TriggerEvent('skinchanger:change', 'mask_2', k)
					end,
				})
			end

		end)

		-- Lunettes
		RageUI.IsVisible(lunette, function()

			RageUI.Button("Aucune Lunette ", nil, {}, true, {
				onActive = function()
					Vetement2.LunetteIndex = 0
					TriggerEvent('skinchanger:change', 'glasses_1', 0)
					TriggerEvent('skinchanger:change', 'glasses_2', 0)
					Vetement2.Lunettes2 = {}
					for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 1, 0)-2 do
						table.insert(Vetement2.Lunettes2, i)
					end
				end,
			})
			for k, v in pairs(Vetement2.Lunettes) do
				RageUI.Button("Lunette "..k, nil, {}, true, {
					onActive = function()
						Vetement2.LunetteIndex = k
						TriggerEvent('skinchanger:change', 'glasses_1', k)
						TriggerEvent('skinchanger:change', 'glasses_2', 0)
						Vetement2.Lunettes2 = {}
						for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 1, k)-2 do
							table.insert(Vetement2.Lunettes2, i)
						end

					end,
				})
			end

		end)

		RageUI.IsVisible(variationslunette, function()

			RageUI.Button("Variation Lunette 0", nil, {}, true, {
				onActive = function()
					Vetement2.LunetteIndex2 = 0
					TriggerEvent('skinchanger:change', 'glasses_2', 0)
				end,
			})
			for k, v in pairs(Vetement2.Lunettes2) do
				RageUI.Button("Variation Masque "..k, nil, {}, true, {
					onActive = function()
						Vetement2.LunetteIndex2 = k
						TriggerEvent('skinchanger:change', 'glasses_2', k)
					end,
				})
			end

		end)

		-- Chapeau
		RageUI.IsVisible(chapeau, function()

			RageUI.Button("Aucun Chapeau ", nil, {}, true, {
				onActive = function()
					Vetement2.ChapeauIndex = 0
					TriggerEvent('skinchanger:change', 'helmet_1', 0)
					TriggerEvent('skinchanger:change', 'helmet_2', 0)
					Vetement2.Chapeau2 = {}
					for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, 0)- 1 do
						table.insert(Vetement2.Chapeau2, i)
					end
				end,
			})
			for k, v in pairs(Vetement2.Chapeau) do
				RageUI.Button("Chapeau "..k, nil, {}, true, {
					onActive = function()
						Vetement2.ChapeauIndex = k
						TriggerEvent('skinchanger:change', 'helmet_1', k)
						TriggerEvent('skinchanger:change', 'helmet_2', 0)
						Vetement2.Chapeau2 = {}
						for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, k) - 1 do
							table.insert(Vetement2.Chapeau2, i)
						end

					end,
				})
			end
		end)

		RageUI.IsVisible(variationschapeau, function()

			RageUI.Button("Variation Chapeau 0", nil, {}, true, {
				onActive = function()
					Vetement2.ChapeauIndex2 = 0
					TriggerEvent('skinchanger:change', 'helmet_2', 0)
				end,
			})
			for k, v in pairs(Vetement2.Chapeau2) do
				RageUI.Button("Variation Chapeau "..k, nil, {}, true, {
					onActive = function()
						Vetement2.ChapeauIndex2 = k
						TriggerEvent('skinchanger:change', 'helmet_2', k)
					end,
				})
			end
		end)

		-- Sac
		RageUI.IsVisible(sac, function()
			RageUI.Button("Aucun Sac ", nil, {}, true, {
				onActive = function()
					Vetement2.SacIndex = 0
					TriggerEvent('skinchanger:change', 'bags_1', 0)
					TriggerEvent('skinchanger:change', 'bags_2', 0)
					Vetement2.Sac2 = {}
					for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 5, 0) -1 do
						table.insert(Vetement2.Sac2, i)
					end
				end,
			})
			for k, v in pairs(Vetement2.Sac) do
				RageUI.Button("Sac "..k, nil, {}, true, {
					onActive = function()
						Vetement2.SacIndex = k
						TriggerEvent('skinchanger:change', 'bags_1', k)
						TriggerEvent('skinchanger:change', 'bags_2', 0)
						Vetement2.Sac2 = {}
						for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 5, k) - 2 do
							table.insert(Vetement2.Sac2, i)
						end

					end,
				})
			end

		end)

		RageUI.IsVisible(variationssac, function()

			RageUI.Button("Variation Sac 0", nil, {}, true, {
				onActive = function()
					Vetement2.SacIndex2 = 0
					TriggerEvent('skinchanger:change', 'bags_2', 0)
				end,
				onSelected = function()
					RageUI.Visible(variationssac, false)
					RageUI.Visible(paidsac, true)
				end
			})
			for k, v in pairs(Vetement2.Sac2) do
				RageUI.Button("Variation Sac "..k, nil, {}, true, {
					onActive = function()
						Vetement2.SacIndex2 = k
						TriggerEvent('skinchanger:change', 'bags_2', k)
					end,
				})
			end
		end)

		-- Chaîne
		RageUI.IsVisible(chaine, function()
			RageUI.Button("Aucune Chaine ", nil, {}, true, {
				onActive = function()
					Vetement2.ChaineIndex = 0
					TriggerEvent('skinchanger:change', 'chain_1', 0)
					TriggerEvent('skinchanger:change', 'chain_2', 0)
					Vetement2.Chaine2 = {}
					for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, 0)-2 do
						table.insert(Vetement2.Chaine2, i)
					end
				end,
			})
			for k, v in pairs(Vetement2.Chaine) do
				RageUI.Button("Chaine "..k, nil, {}, true, {
					onActive = function()
						Vetement2.ChaineIndex = k
						TriggerEvent('skinchanger:change', 'chain_1', k)
						TriggerEvent('skinchanger:change', 'chain_2', 0)
						Vetement2.Chaine2 = {}
						for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 7, k)-2 do
							table.insert(Vetement2.Chaine2, i)
						end

					end,
				})
			end

		end)

		RageUI.IsVisible(variationschaine, function()

			RageUI.Button("Variation Chaine 0", nil, {}, true, {
				onActive = function()
					Vetement2.ChaineIndex2 = 0
					TriggerEvent('skinchanger:change', 'chain_2', 0)
				end,
				onSelected = function()
					RageUI.Visible(variationschaine, false)
					RageUI.Visible(paidchaine, true)
				end
			})
			for k, v in pairs(Vetement2.Chaine2) do
				RageUI.Button("Variation Chaine "..k, nil, {}, true, {
					onActive = function()
						Vetement2.ChaineIndex2 = k
						TriggerEvent('skinchanger:change', 'chain_2', k)
					end,
				})
			end

		end)

		-- Accesoires d'oreille
		RageUI.IsVisible(oreille, function()
			RageUI.Button("Aucune Accesoire d'oreille ", nil, {}, true, {
				onActive = function()
					Vetement2.OreilleIndex = 0
					TriggerEvent('skinchanger:change', 'ears_1', 0)
					TriggerEvent('skinchanger:change', 'ears_2', 0)
					Vetement2.Oreille2 = {}
					for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 2, 0) -2 do
						table.insert(Vetement2.Oreille2, i)
					end
				end,
			})
			for k, v in pairs(Vetement2.Oreille) do
				RageUI.Button("Accesoire d'oreille "..k, nil, {}, true, {
					onActive = function()
						Vetement2.OreilleIndex = k
						TriggerEvent('skinchanger:change', 'ears_1', k)
						TriggerEvent('skinchanger:change', 'ears_2', 0)
						Vetement2.Oreille2 = {}
						for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 2, k)-2 do
							table.insert(Vetement2.Oreille2, i)
						end
					end,
				})
			end
		end)

		RageUI.IsVisible(variationsoreille, function()

			RageUI.Button("Variation Accesoire d'oreille 0", nil, {}, true, {
				onActive = function()
					Vetement2.OreilleIndex2 = 0
					TriggerEvent('skinchanger:change', 'ears_2', 0)
				end,
			})
			for k, v in pairs(Vetement2.Oreille2) do
				RageUI.Button("Variation Chaine "..k, nil, {}, true, {
					onActive = function()
						Vetement2.OreilleIndex2 = k
						TriggerEvent('skinchanger:change', 'ears_2', k)
					end,
				})
			end

		end)

        if not RageUI.Visible(mainMenu) and
            not RageUI.Visible(garderobe) and
            not RageUI.Visible(tshirt) and
            not RageUI.Visible(tshirt2) and
            not RageUI.Visible(torse) and
            not RageUI.Visible(torse2) and
            not RageUI.Visible(bras) and
            not RageUI.Visible(calque) and
            not RageUI.Visible(calque2) and

            not RageUI.Visible(bproof) and
            not RageUI.Visible(bproof2) and

            not RageUI.Visible(pantalon) and
            not RageUI.Visible(pantalon2) and
            not RageUI.Visible(chaussures) and
            not RageUI.Visible(chaussures2) and

            not RageUI.Visible(mask) and
		    not RageUI.Visible(lunette) and
            not RageUI.Visible(chapeau) and
            not RageUI.Visible(sac) and
            not RageUI.Visible(chaine) and
            not RageUI.Visible(oreille) and

            not RageUI.Visible(variationsmasque) and
            not RageUI.Visible(variationslunette) and
            not RageUI.Visible(variationschapeau) and
            not RageUI.Visible(variationssac) and
            not RageUI.Visible(variationschaine) and
            not RageUI.Visible(variationsoreille) and

            not RageUI.Visible(vetements) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            openClothes = false
        end
        Citizen.Wait(0)
    end
end

Citizen.CreateThread(function()
    Wait(1500)
    TriggerServerEvent("RecieveVetement")
end)

RegisterNetEvent("johnny:recieveclientsidevetement", function(Info)
    ClothesPlayer = Info
end)

Citizen.CreateThread(function()
	while true do
		local Timer = 800
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' and ESX.PlayerData.job.grade >= 0 then
		local plycrdjob = GetEntityCoords(PlayerPedId(), false)
		local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, -1270.801, -563.1508, 29.63947)
        if isInService then
            if jobdist <= 20 then
                Timer = 0
                --DrawMarker(6, 449.91, -996.77, 30.68-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 255 , 255)
                DrawMarker(Config.Marker.Type, -1270.801, -563.1508, 29.63947, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], Config.Marker.Color[1], Config.Marker.Color[2], Config.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            end
                if jobdist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                    if IsControlJustPressed(1,51) then
                        Coffregouv()
                    end
                end
            end
        end
        Citizen.Wait(Timer)
    end
end)

function Coffregouv()
    local Cgouv = RageUI.CreateMenu("", "Gouv")
        RageUI.Visible(Cgouv, not RageUI.Visible(Cgouv))
            while Cgouv do
            Citizen.Wait(0)
            RageUI.IsVisible(Cgouv, true, true, true, function()

                RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Objet(s)~s~ ↓")

                if  ESX.PlayerData.job.grade >= 0 then
                    RageUI.ButtonWithStyle("Retirer Objet(s)", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            FRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end


                if ESX.PlayerData.job.grade >= 0 then
                    RageUI.ButtonWithStyle("Déposer Objet(s)", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ADeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end

					RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Arme(s)~s~ ↓")

                   if ESX.PlayerData.job.grade >= 0 then

                    RageUI.ButtonWithStyle("Prendre Arme(s)", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            PCoffreRetirerWeapon()
                            RageUI.CloseAll()
                        end
                    end)

                end

                if ESX.PlayerData.job.grade >= 0 then
                    RageUI.ButtonWithStyle("Déposer Arme(s)", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            PCoffreDeposerWeapon()
                            RageUI.CloseAll()
                        end
                    end)
                end

                end, function()
                end)

            if not RageUI.Visible(Cgouv) then
            Cgouv = RMenu:DeleteType("Coffre", true)
        end
    end
end

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Keys.Register('F6','Interactgouv', 'Actions Gouvernement', function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "gouv" then

        if (not IsInPVP) then
            OpenF6Gouv()
        end

    end
end)