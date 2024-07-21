ESX, MenuIsOpen, PlayerData = nil, false, {}
WaitMoney, WaitStorage = true, true
AddSpawnVehicle, AddGarage, GetInvite = {}, false, {}

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
		while ESX.GetPlayerData().job == nil do
			Wait(10)
		end
		ESX.PlayerData = ESX.GetPlayerData()
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    PlayerData = xPlayer
	TriggerServerEvent("Property:getInfos")
end)

RegisterNetEvent('Property:ReponsePerms')
AddEventHandler('Property:ReponsePerms', function()
	RageUI.CloseAll()
	FreezeEntityPosition(PlayerPedId(), false)
	MenuIsOpen, InProperty = false, true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	PlayerData.job = job
end)

createPropertyType = nil

if Config.PropertySettings.EnableBanner then
	PropertyActionsMenu = RageUI.CreateMenu("", "Intéractions disponibles", nil, nil, "dynasty", "interaction_bgd")
	PropertyGestionMenu = RageUI.CreateSubMenu(PropertyActionsMenu, false, "Intéractions disponibles")
	PropertyInfosMenu = RageUI.CreateSubMenu(PropertyGestionMenu, false, "Intéractions disponibles")
	PropertyBuilderMenu = RageUI.CreateSubMenu(PropertyActionsMenu, false, "Configuration du garage")
else
	PropertyActionsMenu = RageUI.CreateMenu("", "Agence Immobilière Dynsaty 8")
	PropertyGestionMenu = RageUI.CreateSubMenu(PropertyActionsMenu, false, "Agence Immobilière Dynsaty 8")
	PropertyInfosMenu = RageUI.CreateSubMenu(PropertyGestionMenu, false, "Agence Immobilière Dynsaty 8")
	PropertyBuilderMenu = RageUI.CreateSubMenu(PropertyActionsMenu, false, "Agence Immobilière Dynsaty 8")
end
PropertyActionsMenu.Closed = function()
	RageUI.CloseAll()
	viewsMarkers(false)
	Config.BuilderSettings.PropertyInfos = {}
	MenuIsOpen, createPropertyType = false, nil
end
PropertyBuilderMenu.Closed = function()
	createPropertyType = false
	resetVar()
	viewsMarkers(false)
end

RegisterNetEvent("Property:OpenBuilderMenu")
AddEventHandler("Property:OpenBuilderMenu", function(AllProperties)
	allProperties = AllProperties
    if MenuIsOpen then
        MenuIsOpen = false
        RageUI.Visible(PropertyActionsMenu, false)
    else
        MenuIsOpen = true
        RageUI.Visible(PropertyActionsMenu, true)
        CreateThread(function()
            while MenuIsOpen do
                RageUI.IsVisible(PropertyActionsMenu, function()
					RageUI.Button("Créer une propriété", false, { LeftBadge= RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
						onSelected = function()
							createPropertyType = 1
						end
					}, PropertyBuilderMenu)
					RageUI.Button("Créer un garage", false, { LeftBadge= RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
						onSelected = function()
							createPropertyType = 2
						end
					}, PropertyBuilderMenu)
					RageUI.Button("Gestion propriété(s)", false, { LeftBadge= RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {}, PropertyGestionMenu)
					RageUI.List("Annonce", Config.BuilderSettings.AnnounceList, Config.BuilderSettings.AnnounceList.Index, nil, { LeftBadge= RageUI.BadgeStyle.Star }, true, {
                        onListChange = function(Index)
                            Config.BuilderSettings.AnnounceList.Index = Index
                        end,
                        onSelected = function(Index)
                            Announce(Index)
                        end
                    })
					RageUI.Button("Faire une facture", false, { LeftBadge= RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
                        onSelected = function()
                            local AmountBill = Input("BillsAmount", "Montant", "", 8)
                            AmountBill = tonumber(AmountBill)
                            local ReasonBill = Input("BillsReason", "Motif de la facturation", "", 8)
                            local ClosestPlayer, distance = ESX.Game.GetClosestPlayer()
                            if ClosestPlayer ~= -1 and distance <= 3.0 then
                                if AmountBill ~= nil and type(AmountBill) == 'number' then
                                    if ReasonBill ~= nil then
                                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(ClosestPlayer), 'society_realestateagent', ReasonBill, AmountBill)
                                        ESX.ShowNotification("~HUD_COLOUR_WAYPOINT~Vous avez envoyée une facture au montant de ( "..AmountBill.."$ ).")
                                    else
                                        ESX.ShowNotification("~HUD_COLOUR_WAYPOINT~Veuillez entrer un motif de facturation.")
                                    end
                                else
                                    ESX.ShowNotification("~HUD_COLOUR_WAYPOINT~Montant invalide.")
                                end
                            else
                                ESX.ShowNotification("~HUD_COLOUR_WAYPOINT~Aucun joueur à proximité.")
                            end
                        end
                    })
                end)
                RageUI.IsVisible(PropertyGestionMenu, function()
					if #allProperties > 0 then
						RageUI.List("Filtrer les propriétés : ", Config.BuilderSettings.PropertyList, Config.BuilderSettings.PropertyList.Index, nil, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
							onListChange = function(Index)
								Config.BuilderSettings.PropertyList.Index = Index
							end
						})
						RageUI.Line()
						for k,v in pairs (allProperties) do
							if Config.BuilderSettings.PropertyList.Index == 1 then
								RageUI.Button(v.propertyLabel, false, {RightLabel = "~HUD_COLOUR_WAYPOINT~Gérer~s~ →", LeftBadge = RageUI.BadgeStyle.Star }, true, {
									onSelected = function()
										PropertyID = v.propertyID
									end
								},PropertyInfosMenu)
							elseif Config.BuilderSettings.PropertyList.Index == 2 then
								if v.propertyGarage == nil and v.propertyRented == nil then
									RageUI.Button(v.propertyLabel, false, {RightLabel = "~HUD_COLOUR_WAYPOINT~Gérer~s~ →"}, true, {
										onSelected = function()
											PropertyID = v.propertyID
										end
									},PropertyInfosMenu)
								end
							elseif Config.BuilderSettings.PropertyList.Index == 3 then
								if v.propertyEntering == nil then
									RageUI.Button(v.propertyLabel, false, {RightLabel = "~HUD_COLOUR_WAYPOINT~Gérer~s~ →"}, true, {
										onSelected = function()
											PropertyID = v.propertyID
										end
									},PropertyInfosMenu)
								end
							end
						end
					else
						RageUI.Separator("")
						RageUI.Separator("~HUD_COLOUR_WAYPOINT~Aucune propriété(s) disponibles.")
						RageUI.Separator("")
					end
				end)
				RageUI.IsVisible(PropertyInfosMenu, function()
					local player, distance = ESX.Game.GetClosestPlayer()
					for k,v in pairs (allProperties) do
						if PropertyID == v.propertyID then
							RageUI.Separator("Nom de la propriété : ~HUD_COLOUR_WAYPOINT~"..v.propertyLabel)
							if v.ownerName ~= "-" then
								RageUI.Separator("Nom du propriétaire : ~HUD_COLOUR_WAYPOINT~"..tostring(v.ownerName))
							end
							if v.propertyEntering ~= nil then
								if v.maxStorage ~= nil then
									RageUI.Separator("Capacité de stockage : ~HUD_COLOUR_WAYPOINT~"..v.maxStorage.."KG")
								end
								RageUI.Separator("Intérieur : ~HUD_COLOUR_WAYPOINT~"..tostring(Config.PropertiesInteriors[v.propertyInteriors].PropertyName))
							end
							if v.propertyGarage ~= nil and v.propertyRented ~= nil then
								if v.garageInteriors ~= nil then
									RageUI.Separator("Capacité du garage : ~HUD_COLOUR_WAYPOINT~"..tostring(#Config.GarageInteriors[v.garageInteriors].AllowedPositions.." places"))
								end
							end
							RageUI.Line()
							RageUI.Button("Mettre un point sur le GPS", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star }, true, {
								onSelected = function()
									SetNewWaypoint(v.propertyEntering.x, v.propertyEntering.y)
								end
							})
							if v.propertyOwner == "-" then
								RageUI.List("Attribuer la propriété : ", Config.BuilderSettings.SellList, Config.BuilderSettings.SellList.Index, false, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
									onListChange = function(Index)
										Config.BuilderSettings.SellList.Index = Index
									end,
									onSelected = function(Index)
										if Index == 1 then
											SellProperty(v.propertyID, PlayerId())
										elseif Index == 2 then
											if player ~= -1 and distance <= 3.0 then
												SellProperty(v.propertyID, player)
											else
												ESX.ShowNotification("~HUD_COLOUR_WAYPOINT~Aucun joueur à proximité.")
											end
										end
									end
								})
							else
								RageUI.Button("Révoquer la propriété", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star }, true, {
									onSelected = function()
										TriggerServerEvent("Property:UpdateOwner", v.propertyID)
									end
								})
							end
							RageUI.Button("Supprimer la propriété", false, { RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star }, true, {
								onSelected = function()
									TriggerServerEvent("Property:DeleteProperty", v.propertyID)
									RageUI.GoBack()
								end
							})
						end
					end
				end)
				RageUI.IsVisible(PropertyBuilderMenu, function()
					local pos = GetEntityCoords(PlayerPedId())
					if createPropertyType == 1 then
						RageUI.Checkbox("Activé le mode visite", false, Config.BuilderSettings.CheckForView, { LeftBadge = RageUI.BadgeStyle.Star }, {
							onChecked = function()
								ViewCoordsPlayer = GetEntityCoords(PlayerPedId())
								TriggerEvent("Property:ViewInteriors", true)
							end,
							onUnChecked = function()
								SetEntityCoords(PlayerPedId(), ViewCoordsPlayer.x, ViewCoordsPlayer.y, ViewCoordsPlayer.z)
								TriggerEvent("Property:ViewInteriors", false)
							end,
							onSelected = function(Index)
								Config.BuilderSettings.CheckForView = Index
							end
						})
					end
					if createPropertyType == 1 then
						RageUI.Button("Nom de la propriété", false, { RightLabel = LookInfos(PropertyName), LeftBadge = RageUI.BadgeStyle.Star }, true, {
							onSelected = function()
								PropertyName = Input("NameOfProperty", "Nom de la propriété", "", 20)
								if PropertyName ~= nil then
									Config.BuilderSettings.PropertyInfos["NameOfProperty"] = PropertyName
								end
							end
						})
					else
						RageUI.Button("Nom du garage", false, { RightLabel = LookInfos(PropertyName), LeftBadge = RageUI.BadgeStyle.Star }, true, {
							onSelected = function()
								PropertyName = Input("NameOfProperty", "Nom du garage", "", 20)
								if PropertyName ~= nil then
									Config.BuilderSettings.PropertyInfos["NameOfProperty"] = PropertyName
								end
							end
						})
					end
					if createPropertyType == 1 then
						RageUI.List("Propriété", Config.BuilderSettings.InteriorsList, Config.BuilderSettings.InteriorsList.Index, false, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
							onListChange = function(Index)
								Config.BuilderSettings.InteriorsList.Index = (Index or 1)
								Config.BuilderSettings.PropertyInfos.Interiors = Config.BuilderSettings.InteriorsList.Index
								if InView == true then
									SetEntityCoords(PlayerPedId(), Config.PropertiesInteriors[(Index or 1)].IPL)
								end
							end
						})
						RageUI.Button("Définir la position de l'entrée", false, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→" }, true, {
							onSelected = function()
								viewsMarkers(true)
								Config.BuilderSettings.PropertyInfos.EnteringPos = {x = math.round(pos.x, 2), y = math.round(pos.y, 2), z = math.round(pos.z, 2)}
							end
						})
						RageUI.List("Espace de stockage", Config.BuilderSettings.StorageList, Config.BuilderSettings.StorageList.Index, false, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
							onListChange = function(Index)
								Config.BuilderSettings.StorageList.Index = (Index or 1)
								Config.BuilderSettings.PropertyInfos.AllowedStorage = tonumber(string.match(Config.BuilderSettings.StorageList[(Index or 1)], "%d+"))
							end
						})
						-- RageUI.Checkbox("Ajouter un garage", false, Config.BuilderSettings.AddGarageCheckbox, { LeftBadge = RageUI.BadgeStyle.Star }, {
						-- 	onChecked = function()
						-- 		AddGarage = true
						-- 	end,
						-- 	onUnChecked = function()
						-- 		AddGarage = false
						-- 	end,
						-- 	onSelected = function(Index)
						-- 		Config.BuilderSettings.AddGarageCheckbox = Index
						-- 	end
						-- })
					end
					if AddGarage or createPropertyType == 2 then
						RageUI.List("Nombre de places allouées", Config.BuilderSettings.GarageList, Config.BuilderSettings.GarageList.Index, false, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
							onListChange = function(Index)
								Config.BuilderSettings.GarageList.Index = (Index or 1)
								Config.BuilderSettings.PropertyInfos.garageInteriors = Config.BuilderSettings.GarageList.Index
							end
						})
						RageUI.Button("Définir la position du garage", "Position à indiquer pour rentrer dans le garage", { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→" }, true, {
							onSelected = function()
								viewsMarkers(true)
								Config.BuilderSettings.PropertyInfos.GaragePos = {x = math.round(pos.x, 2), y = math.round(pos.y, 2), z = math.round(pos.z, 2)}
							end
						})
						RageUI.Button("Définir la position du rangement", "Position à indiquer pour ranger un véhicule", { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→" }, true, {
							onSelected = function()
								viewsMarkers(true)
								Config.BuilderSettings.PropertyInfos.RentedPos = {x = math.round(pos.x, 2), y = math.round(pos.y, 2), z = math.round(pos.z, 2), w = math.round(GetEntityHeading(PlayerPedId()), 2)}
							end
						})
					end
					RageUI.Line()
					if createPropertyType == 1 then
						if Config.BuilderSettings.PropertyInfos["NameOfProperty"] ~= nil and Config.BuilderSettings.PropertyInfos.EnteringPos ~= nil then
							RageUI.Button("Créer la Propriété", false, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→" }, true, {
								onSelected = function()
									if Config.BuilderSettings.PropertyInfos.AllowedStorage == nil then
										Config.BuilderSettings.PropertyInfos.AllowedStorage = 50
									end
									if Config.BuilderSettings.PropertyInfos.Interiors == nil then
										Config.BuilderSettings.PropertyInfos.Interiors = 1
									end
									if Config.BuilderSettings.PropertyInfos.garageInteriors == nil then
										Config.BuilderSettings.PropertyInfos.garageInteriors = 1
									end
									TriggerServerEvent("Property:AddProperty", Config.BuilderSettings.PropertyInfos)
									Wait(50)
									Config.BuilderSettings.PropertyInfos = {}
									resetVar()
								end
							})
						else
							RageUI.Button("Créer la Propriété", false, {}, false, {})
						end
					else
						if Config.BuilderSettings.PropertyInfos["NameOfProperty"] ~= nil and Config.BuilderSettings.PropertyInfos.GaragePos ~= nil and Config.BuilderSettings.PropertyInfos.RentedPos ~= nil then
							RageUI.Button("Créer le Garage", false, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→" }, true, {
								onSelected = function()
									if Config.BuilderSettings.PropertyInfos.garageInteriors == nil then
										Config.BuilderSettings.PropertyInfos.garageInteriors = 1
									end
									TriggerServerEvent("Property:AddProperty", Config.BuilderSettings.PropertyInfos)
									resetVar()
								end
							})
						else
							RageUI.Button("Créer le Garage", false, {}, false, {})
						end
					end
				end)
                Wait(1)
            end
        end)
    end
end)

CreateThread(function()
    while true do
		if PlayerData.job ~= nil and PlayerData.job.name == Config.PropertySettings.AllowedJob then
            Wait(5)
            if IsControlJustReleased(0, 167) then
				TriggerServerEvent("Property:openJobInteractionsMenu")
            end
        else
            Wait(500)
        end
    end
end)

if Config.PropertySettings.EnableBanner then
	OwnedPropertyInteractionsMenu = RageUI.CreateMenu(false, "Intéractions disponibles", nil, nil, "dynasty", "interaction_bgd")
else
	OwnedPropertyInteractionsMenu = RageUI.CreateMenu('', "Intéractions disponibles")
end
OwnedPropertyInteractionsMenu.Closed = function()
	RageUI.CloseAll()
    MenuIsOpen = false
	if isOwned == false then
		myProperties = {}
	end
	FreezeEntityPosition(PlayerPedId(), false)
end

RegisterNetEvent("Property:OpenPropertyMenu")
AddEventHandler("Property:OpenPropertyMenu", function(isOwned, InfosOfProperty)
	myProperties = InfosOfProperty
    if MenuIsOpen then
        MenuIsOpen = false
        RageUI.Visible(OwnedPropertyInteractionsMenu, false)
    else
        MenuIsOpen = true
        RageUI.Visible(OwnedPropertyInteractionsMenu, true)
        CreateThread(function()
            while MenuIsOpen do
				FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(OwnedPropertyInteractionsMenu, function()
					for k,v in pairs (InfosOfProperty) do
						if isOwned == true then
							RageUI.Separator("Nom de la Propriété : ~HUD_COLOUR_WAYPOINT~"..v.propertyLabel)
							RageUI.Separator("Adresse : ~HUD_COLOUR_WAYPOINT~"..GetStreetForCoords(v.propertyEntering.x, v.propertyEntering.y, v.propertyEntering.z))
							RageUI.Line()
							RageUI.Button("Entrer dans la propriété", false, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
								onSelected = function()
									EnterProperty(v.propertyInteriors, v.propertyID, false)
								end
							})
						else
							RageUI.Separator("Nom de la Propriété : ~HUD_COLOUR_WAYPOINT~"..v.propertyLabel)
							RageUI.Separator("Adresse : ~HUD_COLOUR_WAYPOINT~"..GetStreetForCoords(v.propertyEntering.x, v.propertyEntering.y, v.propertyEntering.z))
							RageUI.Line()
							-- RageUI.Button("Adresse : ~HUD_COLOUR_WAYPOINT~"..GetStreetForCoords(v.propertyEntering.x, v.propertyEntering.y, v.propertyEntering.z), false, {LeftBadge = RageUI.BadgeStyle.Star}, true, {RightLabel = "→"})
							if v.propertyOwner ~= "-" then
								RageUI.Button("Sonner à la porte", false, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
									onSelected = function()
										TriggerServerEvent("Property:DringDring", v.propertyOwner)
									end
								})
								if Config.PropertySettings.ActivateForcedDoor then
									for _, job in pairs(Config.PropertySettings.AllowedJobs) do
										if PlayerData.job.name == job then
											RageUI.Button("Entrer de force dans la propriété", false, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
												onSelected = function()
													EnterProperty(v.propertyInteriors, v.propertyID, false)
												end
											})
										end
									end
								end
							else
								RageUI.Button("Visiter la propriété", false, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
									onSelected = function()
										EnterProperty(v.propertyInteriors, v.propertyID, true)
									end
								})
								RageUI.Button("Sonner à la porte", false, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, false, { LeftBadge = RageUI.BadgeStyle.Star })
							end
						end
					end
				end)
                Wait(1)
            end
        end)
    end
end)

if Config.PropertySettings.EnableBanner then
	PropertyGarageMenu = RageUI.CreateMenu(false, "Intéractions disponibles", nil, nil, "dynasty", "interaction_bgd")
else
	PropertyGarageMenu = RageUI.CreateMenu('', "Intéractions disponibles")
end
PropertyGarageMenu.Closed = function()
	RageUI.CloseAll()
    MenuIsOpen = false
	if isOwned == false then
		myProperties = {}
		myVehicles = {}
	end
	FreezeEntityPosition(PlayerPedId(), false)
end

garageCooldown = false

RegisterNetEvent("Property:OpenGarageMenu")
AddEventHandler("Property:OpenGarageMenu", function(isOwned, InfosOfProperty, VehiclesOfProperty)
	myProperties = InfosOfProperty
	if VehiclesOfProperty ~= nil then
		myVehicles = VehiclesOfProperty
	end
    if MenuIsOpen then
        MenuIsOpen = false
        RageUI.Visible(PropertyGarageMenu, false)
    else
        MenuIsOpen = true
        RageUI.Visible(PropertyGarageMenu, true)
        CreateThread(function()
            while MenuIsOpen do
				FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(PropertyGarageMenu, function()
					for k,v in pairs (myProperties) do
						if isOwned == true then
							RageUI.Separator("Nom de la Propriété : ~HUD_COLOUR_WAYPOINT~"..v.propertyLabel)
							RageUI.Separator("Adresse : ~HUD_COLOUR_WAYPOINT~"..GetStreetForCoords(v.propertyGarage.x, v.propertyGarage.y, v.propertyGarage.z))
							RageUI.Line()
							RageUI.Button("Entrer dans le garage", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star}, true, {
								onSelected = function() 
									if not garageCooldown then
										garageCooldown = true
										EnterGarage(false)
										SetTimeout(2000, function()
											garageCooldown = false
										end)
									end
								end
							})
						else
							RageUI.Separator("Nom de la Propriété : ~HUD_COLOUR_WAYPOINT~"..v.propertyLabel)
							RageUI.Separator("Adresse : ~HUD_COLOUR_WAYPOINT~"..GetStreetForCoords(v.propertyGarage.x, v.propertyGarage.y, v.propertyGarage.z))
							RageUI.Line()
							if v.propertyOwner == "-" then
								RageUI.Button("Visiter le garage", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star}, true, {
									onSelected = function()
										EnterGarage(true)
									end
								})
							else
								RageUI.Button("Visiter le garage", false, {RightLabel = "→",LeftBadge = RageUI.BadgeStyle.Star}, false, { LeftBadge = RageUI.BadgeStyle.Star })
							end
						end
					end
				end)
                Wait(1)
            end
        end)
    end
end)

if Config.PropertySettings.EnableBanner then
	OwnedPropertyGestionMenu = RageUI.CreateMenu(false, "Intéractions disponibles", nil, nil, "dynasty", "interaction_bgd")
else
	OwnedPropertyGestionMenu = RageUI.CreateMenu('', "Intéractions disponibles")
end
OwnedPropertyGestionMenu.Closed = function()
    MenuIsOpen = false
	RageUI.Visible(OwnedPropertyGestionMenu, false)
	FreezeEntityPosition(PlayerPedId(), false)
end

RegisterNetEvent("Property:OpenGestionMenu")
AddEventHandler("Property:OpenGestionMenu", function()
    if MenuIsOpen then
        MenuIsOpen = false
        RageUI.Visible(OwnedPropertyGestionMenu, false)
    else
        MenuIsOpen = true
        RageUI.Visible(OwnedPropertyGestionMenu, true)
        CreateThread(function()
            while MenuIsOpen do
				FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(OwnedPropertyGestionMenu, function()
					for k,v in pairs(myProperties) do
						RageUI.Button("Sortir de la propriété", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star }, true, {
							onSelected = function()
								ExitProperty(v.propertyID)
							end
						})
						if #GetInvite > 0 then
							RageUI.Separator("↓ ~HUD_COLOUR_WAYPOINT~Demande en cours..~s~ ↓")
							for t,b in pairs (GetInvite) do
								RageUI.Button("Faire rentrer (~HUD_COLOUR_WAYPOINT~"..b.playerName.."~s~) dans la propriété", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star}, true, {
									onSelected = function()
										table.remove(GetInvite, t)
										TriggerServerEvent("Property:AcceptDringDring", b.source, v.propertyID)
									end
								})
							end
						end
					end
				end)
                Wait(1)
            end
        end)
    end
end)

waitingForVehicles, myGarageInteriors, garageCooldown = false, nil, false

if Config.PropertySettings.EnableBanner then
	OwnedPropertyGarageMenu = RageUI.CreateMenu(false, "Intéractions disponibles", nil, nil, "dynasty", "interaction_bgd")
	OwnedPropertyVehiclesMenu = RageUI.CreateSubMenu(OwnedPropertyGarageMenu, false, "Intéractions disponibles")
	OwnedGarageVehiclesMenu = RageUI.CreateSubMenu(OwnedPropertyGarageMenu, false, "Intéractions disponibles")
else
	OwnedPropertyGarageMenu = RageUI.CreateMenu('', "Intéractions disponibles")
	OwnedPropertyVehiclesMenu = RageUI.CreateSubMenu(OwnedPropertyGarageMenu, '', "Intéractions disponibles")
	OwnedGarageVehiclesMenu = RageUI.CreateSubMenu(OwnedPropertyGarageMenu, '', "Intéractions disponibles")
end
OwnedPropertyGarageMenu.Closed = function()
	RageUI.CloseAll()
    MenuIsOpen, myGarageInteriors, waitingForVehicles = false, nil, false
	FreezeEntityPosition(PlayerPedId(), false)
end

RegisterNetEvent("Property:OpenGestionGarageMenu")
AddEventHandler("Property:OpenGestionGarageMenu", function(OwnedVehicles, GarageVehicles)
	myOwnedVehicles = OwnedVehicles
	myGarageVehicles = GarageVehicles
    if MenuIsOpen then
        MenuIsOpen = false
        RageUI.Visible(OwnedPropertyGarageMenu, false)
    else
        MenuIsOpen = true
        RageUI.Visible(OwnedPropertyGarageMenu, true)
		for k,v in pairs(myProperties) do
			myGarageInteriors = v.garageInteriors
		end
        CreateThread(function()
            while MenuIsOpen do
				FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(OwnedPropertyGarageMenu, function()
					RageUI.Button("Gestion véhicule(s) garage public", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star}, true, {
						onSelected = function()
							Wait(120)
							waitingForVehicles = true
						end
					}, OwnedPropertyVehiclesMenu)
					RageUI.Button("Gestion véhicule(s) de la propriété", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star}, true, {
						onSelected = function()
							Wait(120)
							waitingForVehicles = true
						end
					}, OwnedGarageVehiclesMenu)
				end)
				RageUI.IsVisible(OwnedPropertyVehiclesMenu, function()
					if waitingForVehicles then
						if #myOwnedVehicles > 0 then
							for k,v in pairs(myProperties) do
								for t,b in pairs (myOwnedVehicles) do
									if #myGarageVehicles == #Config.GarageInteriors[myGarageInteriors].AllowedPositions then
										RageUI.Separator("Place(s) disponibles : ~HUD_COLOUR_WAYPOINT~"..#myGarageVehicles.."~s~/~HUD_COLOUR_WAYPOINT~"..#Config.GarageInteriors[myGarageInteriors].AllowedPositions)
										RageUI.Line()
										RageUI.Button(""..GetVehicleLabel(b.vehicle.model).."~s~ - [~HUD_COLOUR_WAYPOINT~"..b.plate.."~s~]", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star}, false,  {})
									else
										RageUI.Separator("Place(s) disponibles : ~HUD_COLOUR_WAYPOINT~"..#myGarageVehicles.."~s~/~HUD_COLOUR_WAYPOINT~"..#Config.GarageInteriors[myGarageInteriors].AllowedPositions)
										RageUI.Line()
										RageUI.Button(""..GetVehicleLabel(b.vehicle.model).."~s~ - [~HUD_COLOUR_WAYPOINT~"..b.plate.."~s~]", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star }, true, {
											onSelected = function()
												if not garageCooldown then
													garageCooldown = true
													TriggerServerEvent("Property:InteractionsGarage", v.propertyID, b.vehicle, 1)
													SetTimeout(750, function()
														garageCooldown = false
													end)
												end
											end
										})
									end
								end
							end
						else
							RageUI.Separator("")
							RageUI.Separator("~HUD_COLOUR_WAYPOINT~Vous n'avez aucun véhicule.")
							RageUI.Separator("")
						end
					end
				end)
				RageUI.IsVisible(OwnedGarageVehiclesMenu, function()
					if waitingForVehicles then
						if #myGarageVehicles > 0 then
							if #myGarageVehicles < #Config.GarageInteriors[myGarageInteriors].AllowedPositions then
								RageUI.Separator("Place(s) disponibles : ~HUD_COLOUR_WAYPOINT~"..#myGarageVehicles.."~s~/~HUD_COLOUR_WAYPOINT~"..#Config.GarageInteriors[myGarageInteriors].AllowedPositions)
							else
								RageUI.Separator("Place(s) disponibles : ~HUD_COLOUR_WAYPOINT~MAX")
							end
							RageUI.Line()
							for k,v in pairs(myProperties) do
								for t,b in pairs (myGarageVehicles) do
									if b.stored == 1 then
										OwnedPrefix = "~HUD_COLOUR_WAYPOINT~Rentré~s~"
									else
										OwnedPrefix = "~HUD_COLOUR_WAYPOINT~Sortie~s~"
									end
									if v.propertyID == v.propertyID then
										RageUI.Button(""..GetVehicleLabel(b.data_vehicle.model).."~s~ - [~HUD_COLOUR_WAYPOINT~"..b.plate.."~s~]", false, {RightLabel = "["..OwnedPrefix.."]", LeftBadge = RageUI.BadgeStyle.Star}, true, {
											onSelected = function()
												if b.stored == 1 then
													if not garageCooldown then
														garageCooldown = true
														TriggerServerEvent("Property:InteractionsGarage", v.propertyID, b.data_vehicle, 2)
														SetTimeout(750, function()
															garageCooldown = false
														end)
													end
												end
											end
										})
									end
								end
							end
						else
							RageUI.Separator("")
							RageUI.Separator("~HUD_COLOUR_WAYPOINT~Vous n'avez aucun véhicule.")
							RageUI.Separator("")
						end
					end
				end)
                Wait(1)
            end
        end)
    end
end)

if Config.PropertySettings.EnableBanner then
	OwnedPropertyStorageMenu = RageUI.CreateMenu(false, "Intéractions disponibles", nil, nil, "dynasty", "interaction_bgd")
	OwnedPropertyStorageAddMenu = RageUI.CreateSubMenu(OwnedPropertyStorageMenu, false, "Intéractions disponibles")
	OwnedPropertyStorageRemoveMenu = RageUI.CreateSubMenu(OwnedPropertyStorageMenu, false, "Intéractions disponibles")
else
	OwnedPropertyStorageMenu = RageUI.CreateMenu('', "Intéractions disponibles")
	OwnedPropertyStorageAddMenu = RageUI.CreateSubMenu(OwnedPropertyStorageMenu, '', "Intéractions disponibles")
	OwnedPropertyStorageRemoveMenu = RageUI.CreateSubMenu(OwnedPropertyStorageMenu, '', "Intéractions disponibles")
end
OwnedPropertyStorageMenu.Closed = function()
	RageUI.CloseAll()
    MenuIsOpen = false
	FreezeEntityPosition(PlayerPedId(), false)
end

actionCooldown = false

-- RegisterNetEvent("Property:OpenStorageMenu")
-- AddEventHandler("Property:OpenStorageMenu", function(propertyID)
--     if MenuIsOpen then
--         MenuIsOpen = false
--         RageUI.Visible(OwnedPropertyStorageMenu, false)
--     else
--         MenuIsOpen = true
--         RageUI.Visible(OwnedPropertyStorageMenu, true)
-- 		Wait(250)
-- 		refreshInventory()
-- 		countData(propertyID)
--         CreateThread(function()
--             while MenuIsOpen do
-- 				FreezeEntityPosition(PlayerPedId(), true)
--                 RageUI.IsVisible(OwnedPropertyStorageMenu, function()
-- 					local player, distance = ESX.Game.GetClosestPlayer()
-- 					if WaitMoney == true then
-- 						for k,v in pairs(myProperties) do
-- 							if propertyID == v.propertyID then
-- 								if v.dataMoney ~= nil then
-- 									for t,b in pairs(v.dataMoney) do
-- 										if v.propertyID == propertyID then
-- 											if player ~= -1 and distance <= 1.2 then
-- 											else
-- 												if t == "dirtycash" then
-- 													RageUI.List("Argent sale : ~HUD_COLOUR_WAYPOINT~"..v.dataMoney["dirtycash"].count.."$", Config.BuilderSettings.dataMoneyList[1], Config.BuilderSettings.dataMoneyList[1].Index, false, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
-- 														onListChange = function(Index)
-- 															Config.BuilderSettings.dataMoneyList[1].Index = Index
-- 														end,
-- 														onSelected = function(Index)
-- 															if Index == 1 then
-- 																if not actionCooldown then
-- 																	actionCooldown = true
-- 																	local count = Input("DepositBlackMoney", "Argent sale à déposer dans le stock", "", 6)
-- 																	if count ~= nil then
-- 																		count = tonumber(count)
-- 																		if type(count) == "number" then
-- 																			TriggerServerEvent("Property:ActionsMoney", v.propertyID, v.dataMoney, t, count, 1, 1)
-- 																			WaitMoney = false
-- 																			Wait(250)
-- 																			WaitMoney = true
-- 																		end
-- 																	end
-- 																	SetTimeout(350, function()
-- 																		actionCooldown = false
-- 																	end)
-- 																end
-- 															elseif Index == 2 then
-- 																if not actionCooldown then
-- 																	actionCooldown = true
-- 																	local count = Input("WithdrawBlackMoney", "Argent sale à retirer du stock", "", 6)
-- 																	if count ~= nil then
-- 																		count = tonumber(count)
-- 																		if type(count) == "number" then
-- 																			TriggerServerEvent("Property:ActionsMoney", v.propertyID, v.dataMoney, t, count, 1, 2)
-- 																			WaitMoney = false
-- 																			Wait(250)
-- 																			WaitMoney = true
-- 																		end
-- 																	end
-- 																	SetTimeout(350, function()
-- 																		actionCooldown = false
-- 																	end)
-- 																end
-- 															end
-- 														end
-- 													})
-- 												else
-- 													RageUI.List("Argent propre : ~HUD_COLOUR_WAYPOINT~"..v.dataMoney["money"].count.."$", Config.BuilderSettings.dataMoneyList[2], Config.BuilderSettings.dataMoneyList[2].Index, false, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
-- 														onListChange = function(Index)
-- 															Config.BuilderSettings.dataMoneyList[2].Index = Index
-- 														end,
-- 														onSelected = function(Index)
-- 															if Index == 1 then
-- 																if not actionCooldown then
-- 																	actionCooldown = true
-- 																	local count = Input("DepositMoney", "Argent propre à déposer dans le stock", "", 6)
-- 																	if count ~= nil then
-- 																		count = tonumber(count)
-- 																		if type(count) == "number" then
-- 																			TriggerServerEvent("Property:ActionsMoney", v.propertyID, v.dataMoney, t, count, 2, 1)
-- 																			WaitMoney = false
-- 																			Wait(250)
-- 																			WaitMoney = true
-- 																		end
-- 																	end
-- 																	SetTimeout(350, function()
-- 																		actionCooldown = false
-- 																	end)
-- 																end
-- 															elseif Index == 2 then
-- 																if not actionCooldown then
-- 																	actionCooldown = true
-- 																	local count = Input("WithdrawMoney", "Argent propre à retirer du stock", "", 6)
-- 																	if count ~= nil then
-- 																		count = tonumber(count)
-- 																		if type(count) == "number" then
-- 																			TriggerServerEvent("Property:ActionsMoney", v.propertyID, v.dataMoney, t, count, 2, 2)
-- 																			WaitMoney = false
-- 																			Wait(250)
-- 																			WaitMoney = true
-- 																		end
-- 																	end
-- 																	SetTimeout(350, function()
-- 																		actionCooldown = false
-- 																	end)
-- 																end
-- 															end
-- 														end
-- 													})
-- 												end
-- 											end
-- 										end
-- 									end
-- 								end
-- 							end
-- 							RageUI.Button("Déposer un objet", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star}, true, {
-- 								onSelected = function()
-- 									getData(v.propertyID)
-- 									refreshInventory()
-- 								end
-- 							},OwnedPropertyStorageAddMenu)
-- 							RageUI.Button("Retirer un objet", false, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star}, true, {
-- 								onSelected = function()
-- 									countData(v.propertyID)
-- 								end
-- 							},OwnedPropertyStorageRemoveMenu)
-- 						end
-- 					end
-- 				end)
-- 				RageUI.IsVisible(OwnedPropertyStorageAddMenu, function()
-- 					RageUI.Separator("Capacité de stockage: ~HUD_COLOUR_WAYPOINT~"..countStorage.count.."~s~/~HUD_COLOUR_WAYPOINT~"..countStorage.max.." ~s~KG")
-- 					if #ESX.PlayerData.inventory > 0 then
-- 						for k,v in pairs(ESX.PlayerData.inventory) do
-- 							if v.count > 0 then
-- 								RageUI.Button("~HUD_COLOUR_WAYPOINT~"..v.count.."x~s~ - "..v.label, false , {RightLabel = "→"}, true , {
-- 									onSelected = function()
-- 										if not actionCooldown then
-- 											actionCooldown = true
-- 											local count = Input("CountForAdd", "Quantité à déposer dans le stock", "", 3)
-- 											if count ~= nil then
-- 												count = tonumber(count)
-- 												if type(count) == "number" then
-- 													WaitStorage = false
-- 													TriggerServerEvent("Property:ActionsStorage", propertyID, DataStorage, v.name, countStorage, count, 1)
-- 													Wait(120)
-- 													refreshInventory()
-- 												end
-- 											end
-- 											SetTimeout(350, function()
-- 												actionCooldown = false
-- 											end)
-- 										end
-- 									end
-- 								})
-- 							end
-- 						end
-- 					else
-- 						RageUI.Separator("")
-- 						RageUI.Separator("~HUD_COLOUR_WAYPOINT~Aucun item(s) sur vous.")
-- 						RageUI.Separator("")
-- 					end
-- 				end)
-- 				RageUI.IsVisible(OwnedPropertyStorageRemoveMenu, function()
-- 					if WaitStorage == true then
-- 						RageUI.Separator("Capacité : ~HUD_COLOUR_WAYPOINT~"..countStorage.count.."~s~/~HUD_COLOUR_WAYPOINT~"..countStorage.max.."KG")
-- 					end
-- 					if countStorage.count > 0 then
-- 						for k,v in pairs(myProperties) do
-- 							if v.propertyID == propertyID then
-- 								if v.data ~= nil then
-- 									for t,b in pairs(v.data) do
-- 										if v.data[t].count > 0 then
-- 											RageUI.Button(v.data[t].label.."~s~ - [~HUD_COLOUR_WAYPOINT~"..v.data[t].count.."~s~]", false , {RightLabel = "→"}, true , {
-- 												onSelected = function()
-- 													if not actionCooldown then
-- 														actionCooldown = true
-- 														local count = Input("CountForRemove", "Quantité à retirer dans le stock", "", 3)
-- 														if count ~= nil then
-- 															count = tonumber(count)
-- 															if type(count) == "number" then
-- 																WaitStorage = false
-- 																TriggerServerEvent("Property:ActionsStorage", propertyID, v.data, v.data[t].name, countStorage, count, 2)
-- 															end
-- 														end
-- 														SetTimeout(350, function()
-- 															actionCooldown = false
-- 														end)
-- 													end
-- 												end
-- 											})
-- 										end
-- 									end
-- 								end
-- 							end
-- 						end
-- 					else
-- 						WaitStorage = false
-- 						RageUI.Separator("")
-- 						RageUI.Separator("~HUD_COLOUR_WAYPOINT~Vous n'avez aucun item(s)")
-- 						RageUI.Separator("")
-- 					end
-- 				end)
--                 Wait(1)
--             end
--         end)
--     end
-- end)

ownerList, ownerCooldown = {}, false

if Config.PropertySettings.EnableBanner then
	PropertyOwnerMenu = RageUI.CreateMenu(false, "Intéractions disponibles", nil, nil, "dynasty", "interaction_bgd")
	PropertyOwnerAddMenu = RageUI.CreateSubMenu(PropertyOwnerMenu, false, "Liste des joueurs")
	PropertyOwnerListMenu = RageUI.CreateSubMenu(PropertyOwnerMenu, false, "Liste des co-propriétaires")
else
	PropertyOwnerMenu = RageUI.CreateMenu('', "Intéractions disponibles")
	PropertyOwnerAddMenu = RageUI.CreateSubMenu(PropertyOwnerMenu, "", "Liste des joueurs")
	PropertyOwnerListMenu = RageUI.CreateSubMenu(PropertyOwnerMenu, "", "Liste des co-propriétaires")
end
PropertyOwnerMenu.Closed = function()
	RageUI.CloseAll()
    MenuIsOpen = false
end


RegisterNetEvent("Property:OpenOwnerMenu")
AddEventHandler("Property:OpenOwnerMenu", function(propertyOwnerInfos)
	ownerList = propertyOwnerInfos
    if MenuIsOpen then
        MenuIsOpen = false
        RageUI.Visible(PropertyOwnerMenu, false)
    else
        MenuIsOpen = true
        RageUI.Visible(PropertyOwnerMenu, true)
        CreateThread(function()
            while MenuIsOpen do
                RageUI.IsVisible(PropertyOwnerMenu, function()
					RageUI.Button("Liste des co-propriétaires", false, {}, true, {},PropertyOwnerListMenu)
					RageUI.Button("Ajouter un co-propriétaire", false, {}, true, {},PropertyOwnerAddMenu)
				end)
				RageUI.IsVisible(PropertyOwnerAddMenu, function()
					if ownerList ~= nil then
						if #ownerList > 0 then
							for k,v in pairs(ownerList) do
								for t,b in pairs(myProperties) do
									if #b.ownerList > 0 then
										for _, user in pairs(b.ownerList) do
											if user.name ~= v.playerName then
												if v.playerName ~= nil then
													if v.playerName == b.ownerName then
														RageUI.Button(v.playerName, false, {RightLabel = "~HUD_COLOUR_WAYPOINT~Attribuer~s~ →"}, false, {})
													else
														RageUI.Button(v.playerName, false, {RightLabel = "→"}, true, {
															onSelected = function()
																if not ownerCooldown then
																	ownerCooldown = true
																	TriggerServerEvent("Property:addOwner", b.propertyID, v.id, b.ownerList)
																	SetTimeout(450, function()
																		ownerCooldown = false
																	end)
																end
															end
														})
													end
												end
											else
												RageUI.Button(v.playerName, false, {}, false, {})
											end
										end
									elseif #b.ownerList == 0 then
										if v.playerName ~= nil then
											if v.playerName == b.ownerName then
												RageUI.Button(v.playerName, false, {}, false, {})
											else
												RageUI.Button(v.playerName, false, {RightLabel = "~HUD_COLOUR_WAYPOINT~Attribuer~s~ →"}, true, {
													onSelected = function()
														if not ownerCooldown then
															ownerCooldown = true
															TriggerServerEvent("Property:addOwner", b.propertyID, v.id, b.ownerList)
															SetTimeout(450, function()
																ownerCooldown = false
															end)
														end
													end
												})
											end
										end
									end
								end
							end
						end
					end
				end)
				RageUI.IsVisible(PropertyOwnerListMenu, function()
					for k,v in pairs(myProperties) do
						if #v.ownerList > 0 then
							for t,b in pairs(v.ownerList) do
								if b.name ~= nil then
									RageUI.Button(b.name, false, {}, true, {
										onSelected = function()
											if not ownerCooldown then
												ownerCooldown = true
												TriggerServerEvent("Property:deleteOwner", v.propertyID, b.identifier, v.ownerList)
												SetTimeout(450, function()
													ownerCooldown = false
												end)
											end
										end
									})
								end
							end
						else
							RageUI.Separator("~HUD_COLOUR_WAYPOINT~Aucun co-propriétaire(s).")
						end
					end
				end)
                Wait(1)
            end
        end)
    end
end)

