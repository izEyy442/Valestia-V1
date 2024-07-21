--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

--- todo rajouter qu'on puisse se changer dans son appartement avec les tenues enregistré dans le magasin de vetement, preter ces clé a une personne ou a un son setjob

local OwnedProperties, Blips, CurrentActionData = {}, {}, {}
local CurrentProperty, CurrentPropertyOwner, LastProperty, LastPart, CurrentAction, CurrentActionMsg
local firstSpawn, hasChest, hasAlreadyEnteredMarker = true, false, false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('esx_property:getProperties', function(properties)
		ConfigProperty.Properties = properties
		CreateBlips()
	end)

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(ownedProperties)
		for i = 1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end)
end)

RegisterNetEvent('esx_property:sendProperties')
AddEventHandler('esx_property:sendProperties', function(properties)
	while not ESX do Wait(20) end
	ConfigProperty.Properties = properties
	CreateBlips();

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(ownedProperties)
		for i = 1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end);
end)

function DrawSub(text, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(time, 1)
end

function CreateBlips()
	for i = 1, #ConfigProperty.Properties, 1 do
		local property = ConfigProperty.Properties[i]

		if property.entering then
			Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)

			SetBlipSprite(Blips[property.name], 374)
			SetBlipDisplay(Blips[property.name], 4)
			SetBlipScale(Blips[property.name], 0.6)
			SetBlipAsShortRange(Blips[property.name], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName("[Public] Propriété disponible")
			EndTextCommandSetBlipName(Blips[property.name])
		end
	end
end

function GetProperties()
	return ConfigProperty.Properties
end

function GetProperty(name)
	for i = 1, #ConfigProperty.Properties, 1 do
		if ConfigProperty.Properties[i].name == name then
			return ConfigProperty.Properties[i]
		end
	end
end

function GetGateway(property)
	for i = 1, #ConfigProperty.Properties, 1 do
		local property2 = ConfigProperty.Properties[i]

		if property2.isGateway and property2.name == property.gateway then
			return property2
		end
	end
end

function GetGatewayProperties(property)
	local properties = {}

	for i = 1, #ConfigProperty.Properties, 1 do
		if ConfigProperty.Properties[i].gateway == property.name then
			table.insert(properties, ConfigProperty.Properties[i])
		end
	end

	return properties
end

function EnterProperty(name, owner)
	local property = GetProperty(name)
	local playerPed = PlayerPedId()
	CurrentProperty = property
	CurrentPropertyOwner = owner

	for i = 1, #ConfigProperty.Properties, 1 do
		if ConfigProperty.Properties[i].name ~= name then
			ConfigProperty.Properties[i].disabled = true
		end
	end

	TriggerServerEvent('esx_property:saveLastProperty', name)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		for i = 1, #property.ipls, 1 do
			RequestIpl(property.ipls[i])

			while not IsIplActive(property.ipls[i]) do
				Citizen.Wait(0)
			end
		end

		SetEntityCoords(playerPed, property.inside.x, property.inside.y, property.inside.z)
		DoScreenFadeIn(800)
		DrawSub(property.label, 5000)
	end)
end

function ExitProperty(name)
	local property = GetProperty(name)
	local playerPed = PlayerPedId()
	local outside = nil
	CurrentProperty = nil

	if property.isSingle then
		outside = property.outside
	else
		outside = GetGateway(property).outside
	end

	TriggerServerEvent('esx_property:deleteLastProperty')

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		SetEntityCoords(playerPed, outside.x, outside.y, outside.z)

		for i = 1, #property.ipls, 1 do
			RemoveIpl(property.ipls[i])
		end

		for i = 1, #ConfigProperty.Properties, 1 do
			ConfigProperty.Properties[i].disabled = false
		end

		DoScreenFadeIn(800)
	end)
end

function SetPropertyOwned(name, owned)
	local property = GetProperty(name)
	local entering = nil
	local enteringName = nil

	if property.isSingle then
		entering = property.entering
		enteringName = property.name
	else
		local gateway = GetGateway(property)
		entering = gateway.entering
		enteringName = gateway.name
	end

	if owned then
		OwnedProperties[name] = true
		RemoveBlip(Blips[enteringName])

		Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)

		SetBlipSprite(Blips[enteringName], 357)
		SetBlipAsShortRange(Blips[enteringName], true)
		SetBlipScale(Blips[enteringName], 0.6)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Propriété acquise")
		EndTextCommandSetBlipName(Blips[enteringName])
	else
		OwnedProperties[name] = nil
		local found = false

		for k, v in pairs(OwnedProperties) do
			local _property = GetProperty(k)
			local _gateway = GetGateway(_property)

			if _gateway then
				if _gateway.name == enteringName then
					found = true
					break
				end
			end
		end

		if not found then
			RemoveBlip(Blips[enteringName])

			Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
			SetBlipSprite(Blips[enteringName], 369)
			SetBlipAsShortRange(Blips[enteringName], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName("Propriété libre")
			EndTextCommandSetBlipName(Blips[enteringName])
		end
	end
end

function PropertyIsOwned(property)
	return OwnedProperties[property.name] == true
end

--[[function OpenPropertyMenu(property)
	local elements = {}

	if PropertyIsOwned(property) then
		table.insert(elements, {label = _U('enter'), value = 'enter'})

		if not ConfigProperty.EnablePlayerManagement then
			table.insert(elements, {label = _U('leave'), value = 'leave'})
		end
	else
		if not ConfigProperty.EnablePlayerManagement then
			table.insert(elements, {label = _U('buy'), value = 'buy'})
			table.insert(elements, {label = _U('rent'), value = 'rent'})
		end

		table.insert(elements, {label = _U('visit'), value = 'visit'})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'property', {
		title = property.label,
		elements = elements
	}, function(data, menu)
		menu.close()

		if data.current.value == 'enter' then
			TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
		elseif data.current.value == 'leave' then
			TriggerServerEvent('esx_property:removeOwnedProperty', property.name)
		elseif data.current.value == 'buy' then
			TriggerServerEvent('esx_property:buyProperty', property.name)
		elseif data.current.value == 'rent' then
			TriggerServerEvent('esx_property:rentProperty', property.name)
		elseif data.current.value == 'visit' then
			TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
		end
	end, function(data, menu)
		CurrentAction = 'property_menu'
		CurrentActionMsg = _U('press_to_menu')
		CurrentActionData = {property = property}
	end)
end]]

function OpenPropertyMenu(property)
	local mainMenu = RageUI.CreateMenu("", "Propriété")

	RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

	while mainMenu do
		RageUI.IsVisible(mainMenu, function()
			if PropertyIsOwned(property) then
				RageUI.Separator(" "..property.label.." ")
				RageUI.Button("Entrer", nil, {}, true, {
					onSelected = function()
						TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
					end
				})
				RageUI.Button("Rendre la propriété", nil, {}, true, {
					onSelected = function()
						TriggerServerEvent('esx_property:removeOwnedProperty', property.name, math.floor((property.price*75)/100));
					end
				})
			else
				RageUI.Separator(" "..property.label.." ")
				RageUI.Button("Acheter", nil, {RightLabel = property.price.."$"}, true, {
					onSelected = function()
						TriggerServerEvent('esx_property:buyProperty', property.name)
					end
				})
				--RageUI.Button("Louer", nil, {}, true, {
				--	onSelected = function()
				--		TriggerServerEvent('esx_property:rentProperty', property.name)
				--	end
				--})
				RageUI.Button("Visiter la propriété", nil, {}, true, {
					onSelected = function()
						TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
					end
				})
			end
		end)
		if not RageUI.Visible(mainMenu) then
			mainMenu = RMenu:DeleteType(mainMenu, true)
		end
		Citizen.Wait(0)
	end
end

--[[function OpenGatewayMenu(property)
	if ConfigProperty.EnablePlayerManagement then
		OpenGatewayOwnedPropertiesMenu(gatewayProperties)
	else
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway', {
			title = property.name,
			elements = {
				{label = _U('owned_properties'), value = 'owned_properties'},
				{label = _U('available_properties'), value = 'available_properties'}
			}
		}, function(data, menu)
			if data.current.value == 'owned_properties' then
				OpenGatewayOwnedPropertiesMenu(property)
			elseif data.current.value == 'available_properties' then
				OpenGatewayAvailablePropertiesMenu(property)
			end
		end, function(data, menu)
			CurrentAction = 'gateway_menu'
			CurrentActionMsg = _U('press_to_menu')
			CurrentActionData = {property = property}
		end)
	end
end]]

function OpenGatewayMenu(property)
	local mainMenu = RageUI.CreateMenu("", "Propriété")

	RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

	while mainMenu do
		RageUI.IsVisible(mainMenu, function()
			RageUI.Button("Vos propriétés", nil, {}, true, {
				onSelected = function()
					Citizen.Wait(200)
					OpenGatewayOwnedPropertiesMenu(property)
				end
			})
			RageUI.Button("Propriétés disponibles", nil, {}, true, {
				onSelected = function()
					Citizen.Wait(200)
					OpenGatewayAvailablePropertiesMenu(property)
				end
			})
		end)
		if not RageUI.Visible(mainMenu) then
			mainMenu = RMenu:DeleteType(mainMenu, true)
		end
		Citizen.Wait(0)
	end
end

--[[function OpenGatewayOwnedPropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements = {}

	for i = 1, #gatewayProperties, 1 do
		if PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				value = gatewayProperties[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties', {
		title = property.name .. ' - ' .. _U('owned_properties'),
		elements = elements
	}, function(data, menu)
		menu.close()

		local elements = {
			{label = _U('enter'), value = 'enter'}
		}

		if not ConfigProperty.EnablePlayerManagement then
			table.insert(elements, {label = _U('leave'), value = 'leave'})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties_actions', {
			title = data.current.label,
			elements = elements
		}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'enter' then
				TriggerEvent('instance:create', 'property', {property = data.current.value, owner = ESX.GetPlayerData().identifier})
				ESX.UI.Menu.CloseAll()
			elseif data2.current.value == 'leave' then
				TriggerServerEvent('esx_property:removeOwnedProperty', data.current.value)
			end
		end, function(data2, menu2)
		end)
	end, function(data, menu)
	end)
end]]

function OpenGatewayOwnedPropertiesMenu(property)
	local mainMenu = RageUI.CreateMenu("", "Propriété")

	local gatewayProperties = GetGatewayProperties(property)
	local elements = {}

	for i = 1, #gatewayProperties, 1 do
		if PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				value = gatewayProperties[i].name
			})
		end
	end

	RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

	while mainMenu do
		RageUI.IsVisible(mainMenu, function()
			for k,v in pairs(elements) do
				RageUI.Button("Entrer dans: "..v.label.."", nil, {}, true, {
					onSelected = function()
						TriggerEvent('instance:create', 'property', {property = v.value, owner = ESX.GetPlayerData().identifier})
					end
				})
				RageUI.Button("Rendre: "..v.label.."", nil, {}, true, {
					onSelected = function()
						TriggerServerEvent('esx_property:removeOwnedProperty', v.value);
					end
				})
			end
		end)
		if not RageUI.Visible(mainMenu) then
			mainMenu = RMenu:DeleteType(mainMenu, true)
		end
		Citizen.Wait(0)
	end
end

--[[function OpenGatewayAvailablePropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements = {}

	for i = 1, #gatewayProperties, 1 do
		if not PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				rightlabel = {'$' .. ESX.Math.GroupDigits(gatewayProperties[i].price)},
				value = gatewayProperties[i].name,
				price = gatewayProperties[i].price
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties', {
		title = property.name .. ' - ' .. _U('available_properties'),
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties_actions', {
			title = property.label .. ' - ' .. _U('available_properties'),
			elements = {
				{label = _U('buy'), value = 'buy'},
				{label = _U('rent'), value = 'rent'},
				{label = _U('visit'), value = 'visit'}
			}
		}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'buy' then
				TriggerServerEvent('esx_property:buyProperty', data.current.value)
			elseif data2.current.value == 'rent' then
				TriggerServerEvent('esx_property:rentProperty', data.current.value)
			elseif data2.current.value == 'visit' then
				TriggerEvent('instance:create', 'property', {property = data.current.value, owner = ESX.GetPlayerData().identifier})
			end
		end, function(data2, menu2)
		end)
	end, function(data, menu)
	end)
end]]

function OpenGatewayAvailablePropertiesMenu(property)
	local mainMenu = RageUI.CreateMenu("", "Propriété")

	local gatewayProperties = GetGatewayProperties(property)
	local elements = {}

	for i = 1, #gatewayProperties, 1 do
		if not PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				rightlabel = {'$' .. ESX.Math.GroupDigits(gatewayProperties[i].price)},
				value = gatewayProperties[i].name,
				price = gatewayProperties[i].price
			})
		end
	end

	RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

	while mainMenu do
		RageUI.IsVisible(mainMenu, function()
			for k,v in pairs(elements) do
				RageUI.Button("Acheter: "..v.label.."", nil, {RightLabel = ESX.Math.GroupDigits(v.price).."$"}, true, {
					onSelected = function()
						TriggerServerEvent('esx_property:buyProperty', v.value)
						RageUI.CloseAll()
					end
				})
				--RageUI.Button("Louer: "..v.label.."", nil, {}, true, {
				--	onSelected = function()
				--		TriggerServerEvent('esx_property:rentProperty', v.value)
				--		RageUI.CloseAll()
				--	end
				--})
				RageUI.Button("Visiter: "..v.label.."", nil, {}, true, {
					onSelected = function()
						TriggerEvent('instance:create', 'property', {property = v.value, owner = ESX.GetPlayerData().identifier})
						RageUI.CloseAll()
					end
				})
			end
		end)
		if not RageUI.Visible(mainMenu) then
			mainMenu = RMenu:DeleteType(mainMenu, true)
		end
		Citizen.Wait(0)
	end
end

function OpenRoomMenu(property, owner)
	local mainMenu = RageUI.CreateMenu("", "Propriété")
	local inviter = RageUI.CreateSubMenu(mainMenu,"", "Inviter")
	local myDressing = RageUI.CreateSubMenu(mainMenu, '','Mes tenues enregistrées')

	local entering = nil

	if property.isSingle then
		entering = property.entering
	else
		entering = GetGateway(property).entering
	end

	RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

	while mainMenu do
		RageUI.IsVisible(mainMenu, function()
			RageUI.Button("Inviter un joueur", nil, {}, true, {}, inviter)
			RageUI.Button("Récupérer un objet", nil, {}, true, {
				onSelected = function()
					OpenRoomInventoryMenu(property, owner)
				end
			})
			RageUI.Button("Déposer un objet", nil, {}, true, {
				onSelected = function()
					OpenPlayerInventoryMenu(property, owner)
				end
			})
			RageUI.Button("Mon dressing", nil, {}, true, {
				onSelected = function()
					_Razzway:refreshData()
				end
			}, myDressing)
		end)
		RageUI.IsVisible(inviter, function()
			local playersInArea = ESX.Game.GetPlayersInArea(vector3(entering.x, entering.y, entering.z), 10.0)
			local elements = {}

			for i = 1, #playersInArea, 1 do
				if playersInArea[i] ~= PlayerId() then
					table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
				end
			end
			for k,v in pairs(elements) do
				RageUI.Button("Inviter "..v.label.."", nil, {}, true, {
					onSelected = function()
						TriggerEvent('instance:invite', 'property', GetPlayerServerId(v.value), {property = property.name, owner = owner})
						ESX.ShowAdvancedNotification('Notification', "Propriété", "Vous venez d'inviter "..GetPlayerName(v.value), 'CHAR_CALL911', 8)
					end
				})
			end
		end)
        RageUI.IsVisible(myDressing, function()
            Render:myDressingMenu()
        end)
		if not RageUI.Visible(mainMenu) and not RageUI.Visible(inviter) then
			mainMenu = RMenu:DeleteType(mainMenu, true)
		end
		Citizen.Wait(0)
	end
end

function OpenRoomInventoryMenu(property, owner)
	Citizen.Wait(100)
	local roomInv = RageUI.CreateMenu("", "Propriété")
	local moneyMenu = RageUI.CreateSubMenu(roomInv, "", "Argent Sale")
	local itemsMenu = RageUI.CreateSubMenu(roomInv, "", "Objets")
	local weaponsMenu = RageUI.CreateSubMenu(roomInv, "", "Armes") 

	ESX.TriggerServerCallback('esx_property:getPropertyInventory', function(inventory)
		local invitemsList = {}
		local invweaponsList = {}
		local invmoneyList = {}

		if inventory.dirtycash > 0 then
			table.insert(invmoneyList, {
				label = "Argent Sale",
				rightlabel = ESX.Math.GroupDigits(inventory.dirtycash),
				type = 'item_account',
				value = 'dirtycash'
			})
		end

		for i = 1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(invitemsList, {
					label = item.label,
					rightlabel = item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		for i = 1, #inventory.weapons, 1 do
			local weapon = inventory.weapons[i]

			table.insert(invweaponsList, {
				label = ESX.GetWeaponLabel(weapon.name),
				rightlabel = weapon.ammo,
				type = 'item_weapon',
				value = weapon.name,
				ammo = weapon.ammo
			})
		end

		RageUI.Visible(roomInv, not RageUI.Visible(roomInv))

		while roomInv do
			RageUI.IsVisible(roomInv, function()
				RageUI.Button("Argent sale", nil, {RightLabel = "->"}, true, {
					onSelected = function()
					end
				}, moneyMenu)
				RageUI.Button("Items", nil, {RightLabel = "->"}, true, {
					onSelected = function()
					end
				}, itemsMenu)
				RageUI.Button("Armes", nil, {RightLabel = "->"}, true, {
					onSelected = function()
					end
				}, weaponsMenu)
			end)
			RageUI.IsVisible(moneyMenu, function()
				if invmoneyList then
					for k,v in pairs(invmoneyList) do
						RageUI.Separator(" Récupérer de l'argent sale ")
						RageUI.Button("Solde disponible:", nil, {RightLabel = v.rightlabel.."$"}, true, {
							onSelected = function()
								local amount = KeyboardInputProperty("Montant", 'Entrez un montant', '', 10)
								TriggerServerEvent('esx_property:getItem', owner, v.type, v.value, tonumber(amount))
								RageUI.CloseAll()
								OpenRoomInventoryMenu(property, owner)
							end
						})
					end
				else
					RageUI.Button("Rien a afficher", nil, {}, true, {})
				end
			end)
			RageUI.IsVisible(itemsMenu, function()
				if invitemsList then
					for k,v in pairs(invitemsList) do
						RageUI.Separator(" Récupérer des objets ")
						RageUI.Button(v.label, nil, {RightLabel = tonumber(v.rightlabel).." disponibles"}, true, {
							onSelected = function()
								local amount = KeyboardInputProperty("Montant", 'Entrez un montant', '', 10)
								TriggerServerEvent('esx_property:getItem', owner, v.type, v.value, tonumber(amount))
								RageUI.CloseAll()
								OpenRoomInventoryMenu(property, owner)
							end
						})
					end
				else
					RageUI.Button("Rien a afficher", nil, {}, true, {})
				end
			end)
			RageUI.IsVisible(weaponsMenu, function()
				if invweaponsList then
					for k,v in pairs(invweaponsList) do
						RageUI.Separator(" Récupérer des armes ")
						RageUI.Button(v.label, nil, {RightLabel = "->"}, true, {
							onSelected = function()
								TriggerServerEvent('esx_property:getItem', owner, v.type, v.value, v.ammo)
								RageUI.CloseAll()
								OpenRoomInventoryMenu(property, owner)
							end
						})
					end
				else
					RageUI.Button("Rien a afficher", nil, {}, true, {})
				end
			end)
			if not RageUI.Visible(roomInv) and not RageUI.Visible(moneyMenu) and not RageUI.Visible(itemsMenu) and not RageUI.Visible(weaponsMenu) then
				roomInv = RMenu:DeleteType(roomInv, true)
			end
			Citizen.Wait(0)
		end
	end, owner)
end

function OpenPlayerInventoryMenu(property, owner)
	Citizen.Wait(100)
	local plyMenu = RageUI.CreateMenu("", "Propriété")
	local moneyMenu = RageUI.CreateSubMenu(plyMenu, "", "Argent Sale")
	local itemsMenu = RageUI.CreateSubMenu(plyMenu, "", "Objets")
	local weaponsMenu = RageUI.CreateSubMenu(plyMenu, "", "Armes") 

	ESX.TriggerServerCallback('esx_property:getPlayerInventory', function(inventory)
		local itemsList = {}
		local weaponsList = {}
		local moneyList = {}

		if inventory.dirtycash > 0 then
			table.insert(moneyList, {
				label = "Argent Sale",
				rightlabel = ESX.Math.GroupDigits(inventory.dirtycash),
				type = 'item_account',
				value = 'dirtycash'
			})
		end

		for i = 1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(itemsList, {
					label = item.label,
					rightlabel = item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		for i = 1, #inventory.weapons, 1 do
			local weapon = inventory.weapons[i]

			table.insert(weaponsList, {
				label = weapon.label,
				rightlabel = weapon.ammo,
				type = 'item_weapon',
				value = weapon.name,
				ammo = weapon.ammo
			})
		end
	
		RageUI.Visible(plyMenu, not RageUI.Visible(plyMenu))

		while plyMenu do
			RageUI.IsVisible(plyMenu, function()
				RageUI.Button("Argent sale", nil, {RightLabel = "->"}, true, {}, moneyMenu)
				RageUI.Button("Items", nil, {RightLabel = "->"}, true, {}, itemsMenu)
				RageUI.Button("Armes", nil, {RightLabel = "->"}, true, {}, weaponsMenu)
			end)
			RageUI.IsVisible(moneyMenu, function()
				if moneyList then
					for k,v in pairs(moneyList) do
						RageUI.Separator(" Déposer de l'argent sale ")
						RageUI.Button("Solde disponible:", nil, {RightLabel = v.rightlabel.."$"}, true, {
							onSelected = function()
								local amount = KeyboardInputProperty("Montant", 'Entrez un montant', '', 10)
								TriggerServerEvent('esx_property:putItem', owner, v.type, v.value, tonumber(amount))
								RageUI.CloseAll()
								OpenPlayerInventoryMenu(property, owner)
							end
						})
					end
				else
					RageUI.Button("Rien a afficher", nil, {}, true, {})
				end
			end)
			RageUI.IsVisible(itemsMenu, function()
				if itemsList then
					for k,v in pairs(itemsList) do
						RageUI.Separator(" Déposer des objets ")
						RageUI.Button(v.label, nil, {RightLabel = tonumber(v.rightlabel).." disponibles"}, true, {
							onSelected = function()
								local amount = KeyboardInputProperty("Montant", 'Entrez un montant', '', 10)
								TriggerServerEvent('esx_property:putItem', owner, v.type, v.value, tonumber(amount))
								RageUI.CloseAll()
								OpenPlayerInventoryMenu(property, owner)
							end
						})
					end
				else
					RageUI.Button("Rien a afficher", nil, {}, true, {})
				end
			end)
			RageUI.IsVisible(weaponsMenu, function()
				if weaponsList then
					for k,v in pairs(weaponsList) do
						RageUI.Separator(" Déposer des armes ")
						RageUI.Button(v.label, nil, {RightLabel = "->"}, true, {
							onSelected = function()
								TriggerServerEvent('esx_property:putItem', owner, v.type, v.value, v.ammo)
								RageUI.CloseAll()
								OpenPlayerInventoryMenu(property, owner)
							end
						})
					end
				else
					RageUI.Button("Rien a afficher", nil, {}, true, {})
				end
			end)
			if not RageUI.Visible(plyMenu) and not RageUI.Visible(moneyMenu) and not RageUI.Visible(itemsMenu) and not RageUI.Visible(weaponsMenu) then
				plyMenu = RMenu:DeleteType(plyMenu, true)
			end
			Citizen.Wait(0)
		end
	end)
end

AddEventHandler('instance:loaded', function()
	TriggerEvent('instance:registerType', 'property', function(instance)
		EnterProperty(instance.data.property, instance.data.owner)
	end, function(instance)
		ExitProperty(instance.data.property)
	end)
end)

-- AddEventHandler('playerSpawned', function()
-- 	if firstSpawn then
-- 		Citizen.CreateThread(function()
-- 			while not ESX.IsPlayerLoaded() do
-- 				Citizen.Wait(0)
-- 			end

-- 			ESX.TriggerServerCallback('esx_property:getLastProperty', function(propertyName)
-- 				if propertyName then
-- 					if propertyName ~= '' then
-- 						local property = GetProperty(propertyName)

-- 						for i = 1, #property.ipls, 1 do
-- 							RequestIpl(property.ipls[i])
				
-- 							while not IsIplActive(property.ipls[i]) do
-- 								Citizen.Wait(0)
-- 							end
-- 						end

-- 						TriggerEvent('instance:create', 'property', {property = propertyName, owner = ESX.GetPlayerData().identifier})
-- 					end
-- 				end
-- 			end)
-- 		end)

-- 		firstSpawn = false
-- 	end
-- end)

AddEventHandler('esx_property:getProperties', function(cb)
	cb(GetProperties())
end)

AddEventHandler('esx_property:getProperty', function(name, cb)
	cb(GetProperty(name))
end)

AddEventHandler('esx_property:getGateway', function(property, cb)
	cb(GetGateway(property))
end)

RegisterNetEvent('esx_property:setPropertyOwned')
AddEventHandler('esx_property:setPropertyOwned', function(name, owned)
	SetPropertyOwned(name, owned)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'property' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
	if instance.type == 'property' then
		local property = GetProperty(instance.data.property)
		local isHost = GetPlayerFromServerId(instance.host) == PlayerId()
		local isOwned = false

		if PropertyIsOwned(property) == true then
			isOwned = true
		end

		if isOwned or not isHost then
			hasChest = true
		else
			hasChest = false
		end
	end
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(instance, player)
	if player == instance.host then
		TriggerEvent('instance:leave')
	end
end)

AddEventHandler('esx_property:hasEnteredMarker', function(name, part)
	local property = GetProperty(name)

	if part == 'entering' then
		if property.isSingle then
			CurrentAction = 'property_menu'
			CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu"
			CurrentActionData = {property = property}
		else
			CurrentAction = 'gateway_menu'
			CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu"
			CurrentActionData = {property = property}
		end
	elseif part == 'exit' then
		CurrentAction = 'room_exit'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour sortir de la propriété"
		CurrentActionData = {propertyName = name}
	elseif part == 'roomMenu' then
		CurrentAction = 'room_menu'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu"
		CurrentActionData = {property = property, owner = CurrentPropertyOwner}
	end
end)

AddEventHandler('esx_property:hasExitedMarker', function(name, part)
	RageUI.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId(), false)
		local isInMarker, letSleep = false, true
		local currentProperty, currentPart

		for i = 1, #ConfigProperty.Properties, 1 do
			local property = ConfigProperty.Properties[i]

			if property.entering and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.entering.x, property.entering.y, property.entering.z, true)

				if distance < ConfigProperty.DrawDistance then
					DrawMarker(ConfigProperty.MarkerType, property.entering.x, property.entering.y, property.entering.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfigProperty.MarkerSize.x, ConfigProperty.MarkerSize.y, ConfigProperty.MarkerSize.z, ConfigProperty.MarkerColor.r, ConfigProperty.MarkerColor.g, ConfigProperty.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < ConfigProperty.MarkerSize.x then
					isInMarker = true
					currentProperty = property.name
					currentPart = 'entering'
				end
			end

			if property.exit and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.exit.x, property.exit.y, property.exit.z, true)

				if distance < ConfigProperty.DrawDistance then
					DrawMarker(ConfigProperty.MarkerType, property.exit.x, property.exit.y, property.exit.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfigProperty.MarkerSize.x, ConfigProperty.MarkerSize.y, ConfigProperty.MarkerSize.z, ConfigProperty.MarkerColor.r, ConfigProperty.MarkerColor.g, ConfigProperty.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < ConfigProperty.MarkerSize.x then
					isInMarker = true
					currentProperty = property.name
					currentPart = 'exit'
				end
			end

			-- Room menu
			if property.roomMenu and hasChest and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, true)

				if distance < ConfigProperty.DrawDistance then
					DrawMarker(ConfigProperty.MarkerType, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfigProperty.MarkerSize.x, ConfigProperty.MarkerSize.y, ConfigProperty.MarkerSize.z, ConfigProperty.RoomMenuMarkerColor.r, ConfigProperty.RoomMenuMarkerColor.g, ConfigProperty.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < ConfigProperty.MarkerSize.x then
					isInMarker = true
					currentProperty = property.name
					currentPart = 'roomMenu'
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker or (isInMarker and (LastProperty ~= currentProperty or LastPart ~= currentPart) ) then
			hasAlreadyEnteredMarker = true
			LastProperty = currentProperty
			LastPart = currentPart

			TriggerEvent('esx_property:hasEnteredMarker', currentProperty, currentPart)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_property:hasExitedMarker', LastProperty, LastPart)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'property_menu' then
					OpenPropertyMenu(CurrentActionData.property)
				elseif CurrentAction == 'gateway_menu' then
					if ConfigProperty.EnablePlayerManagement then
						OpenGatewayOwnedPropertiesMenu(CurrentActionData.property)
					else
						OpenGatewayMenu(CurrentActionData.property)
					end
				elseif CurrentAction == 'room_menu' then
					OpenRoomMenu(CurrentActionData.property, CurrentActionData.owner)
				elseif CurrentAction == 'room_exit' then
					TriggerEvent('instance:leave')
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function KeyboardInputProperty(entryTitle, textEntry, inputText, maxLength)
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