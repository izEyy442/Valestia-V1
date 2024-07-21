local main_menu = RageUI.AddMenu("", "Menu D'intéraction")
local pocket_menu = RageUI.AddSubMenu(main_menu, "", "Mes poches")
local economie_menu = RageUI.AddSubMenu(main_menu, "", "Economie")
local paper_menu = RageUI.AddSubMenu(main_menu, "", "Papier(s)")
local bill_menu = RageUI.AddSubMenu(main_menu, "", "Facture(s)")
local management_menu = RageUI.AddSubMenu(main_menu, "", "Gestion Patron")
local boss_action_menu = RageUI.AddSubMenu(management_menu, "", "Gestion Patron")
local boss2_action_menu = RageUI.AddSubMenu(management_menu, "", "Gestion Patron")
local car_menu = RageUI.AddSubMenu(main_menu, "", "Gestion Véhicule")
local information_menu = RageUI.AddSubMenu(main_menu, "", "Information Joueur")
local other_menu = RageUI.AddSubMenu(main_menu, "", "Préférence")
local visual_menu = RageUI.AddSubMenu(other_menu, "", "Gestion Visual")
local pass_menu = RageUI.AddSubMenu(other_menu, "", Config["BattlePass"]["name"])
local vip_menu = RageUI.AddSubMenu(other_menu, "", Config["BattlePass"]["name"])
local crosshair_menu = RageUI.AddSubMenu(other_menu, "", "Gestion Crosshair")
local id_menu = RageUI.AddSubMenu(other_menu, "", "ID Proche")

local InteractMenu = {

	player = {
		firstname = "default",
		lastname = "default",
		vipStatut = "default value",
	},

	billing = {},

	engineActionList = {
        "Allumer",
        "Éteindre",
    },

    maxSpeedList = {
        "50",
        "80",
        "120",
        "130",
        "Retirer",
    },

	doorsList = {
        "Toutes les portes",
        "Porte avant-gauche",
        "Porte avant-droite",
        "Porte arrière-gauche",
        "Porte arrière-droite",
		"Capot",
		"Coffre"
    },

    maxSpeedListIndex = 1,
    engineActionIndex = 1,
	doorActionIndex = 1,
	doorIndex = 1,
}

local function RefreshBills()
    ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
        InteractMenu.billing = bills
    end)
end

local function RefreshMoney()
	local PlayerData = ESX.GetPlayerData()

    if PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('pSociety:getSocietyMoney', function(money)
            societymoney = ESX.Math.GroupDigits(money)
        end, PlayerData.job.name)
    end

end

local function RefreshMoney2()
	local PlayerData = ESX.GetPlayerData()

    if PlayerData.job2 ~= nil and PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('pSociety:getSocietyMoney', function(money)
            societymoney2 = ESX.Math.GroupDigits(money)
        end, PlayerData.job2.name)
    end

end

---@param playerID number
local function playerMarker(player)
    local ped = GetPlayerPed(player)
    local pos = GetEntityCoords(ped)

    DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, Config["MarkerRGB"]["R"], Config["MarkerRGB"]["G"], Config["MarkerRGB"]["B"], Config["MarkerRGB"]["A1"], 0, 1, 2, 0, nil, nil, 0)
end

local function doorAction(door)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
		return 
	end

    local veh = GetVehiclePedIsIn(PlayerPedId(), false)

    if door == -1 then

        if InteractMenu.doorActionIndex == 1 then
            for i = 0, 7 do
                SetVehicleDoorOpen(veh, i, false, false)
            end
        else
            for i = 0, 7 do
                SetVehicleDoorShut(veh, i, false)
            end
        end

        doorCoolDown = true

        Citizen.SetTimeout(500, function()
            doorCoolDown = false
        end)

        return
    end

    if InteractMenu.doorActionIndex == 1 then
        SetVehicleDoorOpen(veh,door,false,false)
        doorCoolDown = true
        Citizen.SetTimeout(500, function()
            doorCoolDown = false
        end)
    else
        SetVehicleDoorShut(veh,door,false)
        doorCoolDown = true
        Citizen.SetTimeout(500, function()
            doorCoolDown = false
        end)
    end
end

local function doorState()
	local playerPed = PlayerPedId()
	local GetVehicle = GetVehiclePedIsIn(playerPed, false)
	local GetVehicleDoorLockStatus = GetVehicleDoorLockStatus(GetVehicle)

	if GetVehicleDoorLockStatus == 1 then
		return "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Désactiver"
	elseif GetVehicleDoorLockStatus == 2 then
		return "~g~Actif"
	end
end

local function isAllowedToManageVehicle()
    if IsPedInAnyVehicle(PlayerPedId(),false) then

        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

		if doorState() == "~g~Actif" then
			return ESX.ShowNotification("Le véhicule est verrouillé")
		end

        if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
            return true
        end

        return false

    end

    return false
end

local function getVipState()
	local VipLevel = InteractMenu.player.vipStatut
	
	if VipLevel == 0 then
		return "Aucun VIP"
	elseif VipLevel == 1 then
		return "Mini-VIP"
	elseif VipLevel == 2 then
		return "~y~Gold"
	elseif VipLevel == 3 then
		return "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Diamond"
	end
end

RegisterNetEvent('vCore1:interactMenu:receiveData', function(firstname, lastname, vip)
	InteractMenu.player.firstname = firstname
	InteractMenu.player.lastname = lastname
	InteractMenu.player.vipStatut = vip
end)

local IsInPVP = false
AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP
end)

RegisterNetEvent('esx:setJob', function(job)
    ESX.PlayerData.job = job
    RefreshMoney()
end)

RegisterNetEvent('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
    RefreshMoney2()
end)

main_menu:IsVisible(function(Items)
	local isInCar = IsPedSittingInAnyVehicle(PlayerPedId())

	Items:Separator("[ Pseudo : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" ..GetPlayerName(PlayerId()).. "~s~ | ID : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" ..GetPlayerServerId(PlayerId()).. "~s~ ]")
	Items:Line()

	-- Items:Button("Nom & Prenom :", nil, {RightLabel = ""..InteractMenu.player.lastname.." "..InteractMenu.player.firstname..""}, true, {})

	Items:Button("Poches", nil, {}, true, {}, economie_menu)
	Items:Button("Gestion", nil, {}, true, {}, management_menu)
	Items:Button("Véhicule", nil, {}, isInCar, {}, car_menu)
	-- Items:Button("Information", nil, {}, true, {}, information_menu)
    Items:Button("Autre", nil, {}, true, {}, other_menu)
end)

-- pocket_menu:IsVisible(function(Items)

	-- Items:Button("Papier", nil, { RightLabel = "→→" }, true, {}, paper_menu)
	
	-- Items:Button("Economie", nil, { RightLabel = "→→" }, true, {}, economie_menu)

    -- Items:Button("Facture", nil, { RightLabel = "→→" }, true, {
	-- 	onSelected = function()
	-- 		RefreshBills()
	-- 	end
	-- }, bill_menu)

	-- Items:Button("Gestion", nil, { RightLabel = "→→" }, true, {}, management_menu)

	-- local PlayerData = ESX.GetPlayerData()
	-- Items:Separator("Emploi "..Shared:ServerColorCode().."→~s~ " .. PlayerData.job.label .. "~s~ - " .. PlayerData.job.grade_label)
    -- Items:Separator("Gang/Orga "..Shared:ServerColorCode().."→~s~ " .. PlayerData.job2.label .. "~s~ - " .. PlayerData.job2.grade_label)
	-- Items:Line()
	-- Items:Button("Economie", nil, { RightLabel = "→→" }, true, {}, economie_menu)
    -- Items:Button("Facture", nil, { RightLabel = "→→" }, true, {
	-- 	onSelected = function()
	-- 		RefreshBills()
	-- 	end
	-- }, bill_menu)
	-- Items:Button("Gestion", nil, { RightLabel = "→→" }, true, {}, management_menu)

-- end)

-- paper_menu:IsVisible(function(Items)
-- 	local PlayerData = ESX.GetPlayerData()
-- 	Items:Separator("Emploi "..Shared:ServerColorCode().."→~s~ " .. PlayerData.job.label .. "~s~ - " .. PlayerData.job.grade_label)
--     Items:Separator("Gang/Orga "..Shared:ServerColorCode().."→~s~ " .. PlayerData.job2.label .. "~s~ - " .. PlayerData.job2.grade_label)
-- 	Items:Line()
-- 	Items:Button("Economie", nil, { RightLabel = "→→" }, true, {}, economie_menu)
--     Items:Button("Facture", nil, { RightLabel = "→→" }, true, {
-- 		onSelected = function()
-- 			RefreshBills()
-- 		end
-- 	}, bill_menu)
-- 	Items:Button("Gestion", nil, { RightLabel = "→→" }, true, {}, management_menu)
-- end)

economie_menu:IsVisible(function(Items)
	local PlayerData = ESX.GetPlayerData()
    for i = 1, #PlayerData.accounts, 1 do
        if PlayerData.accounts[i].name == 'cash' then
            Items:Button("Argent Liquide :", nil, {RightLabel = ""..ESX.Math.GroupDigits(PlayerData.accounts[i].money.." ~g~$")}, true, {})
        end
		if PlayerData.accounts[i].name == 'dirtycash' then
            Items:Button("Source Inconnue :", nil, {RightLabel = ""..ESX.Math.GroupDigits(PlayerData.accounts[i].money.." ~g~$")}, true, {})
        end
        if PlayerData.accounts[i].name == 'bank' then
            Items:Button("Argent en Banque :", nil, {RightLabel = ""..ESX.Math.GroupDigits(PlayerData.accounts[i].money.." ~g~$")}, true, {})
        end
    end
	Items:Line()
	Items:Button("Facture", nil, { RightLabel = "→→" }, true, {
		onSelected = function()
			RefreshBills()
		end
	}, bill_menu)
end)

bill_menu:IsVisible(function(Items)
	if not InteractMenu.billing then
		Items:Separator("Chargement des factures...")
	else
		if #InteractMenu.billing == 0 then
			Items:Separator(Config["ServerColorCode"].." Vous n'avez aucune facture")
		end

		for i = 1, #InteractMenu.billing, 1 do
			Items:Button(""..InteractMenu.billing[i].label, nil, {RightLabel = ESX.Math.GroupDigits(InteractMenu.billing[i].amount.."~g~$")}, true, {
				onSelected = function()
					ESX.TriggerServerCallback('esx_billing:payBill', function()
					end, InteractMenu.billing[i].id)
					RageUI.GoBack()
				end
			})
		end
	end
end)

management_menu:IsVisible(function(Items)
	local PlayerData = ESX.GetPlayerData()
	local isBoss = PlayerData.job ~= nil and PlayerData.job.grade_name == "boss"
	local isBoss2 = PlayerData.job2 ~= nil and PlayerData.job2.grade_name == "boss"

	Items:Separator("Emploi "..Shared:ServerColorCode().."→~s~ " .. PlayerData.job.label .. "~s~ - " .. PlayerData.job.grade_label)
    Items:Separator("Gang/Orga "..Shared:ServerColorCode().."→~s~ " .. PlayerData.job2.label .. "~s~ - " .. PlayerData.job2.grade_label)

	Items:Line()

	Items:Button("Gestion Entreprise", "Pour y accéder, il est nécessaire d'être patron de l'entreprise.", {}, isBoss, {
		onSelected = function()
			RefreshMoney()
		end
	}, boss_action_menu)

	Items:Button("Gestion Faction", "Pour y accéder, il est nécessaire d'être patron de la faction.", {}, isBoss2, {
		onSelected = function()
			RefreshMoney2()
		end
	}, boss2_action_menu)
end)

boss_action_menu:IsVisible(function(Items)
	local PlayerData = ESX.GetPlayerData()

	Items:Separator("Métier : "..Shared:ServerColorCode()..""..PlayerData.job.label.."")
	Items:Separator("Grade : "..Shared:ServerColorCode()..""..PlayerData.job.grade_label.."")

	if societymoney ~= nil then
		Items:Separator("Argent dans la société : "..Shared:ServerColorCode()..""..societymoney.." ~g~$")
	end

	Items:Line()

	Items:Button("Recruter l'individu", "Engager la personne en face de vous", {}, true, {
		onActive = function()
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3 then
				playerMarker(closestPlayer)
			end
		end,

		onSelected = function()
			if PlayerData.job.grade_name == "boss" then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur autour de vous")
				else
					exports["vCore3"]:RecruitPlayer("job", GetPlayerServerId(closestPlayer))
				end
			else
				ESX.ShowNotification("Vous possédez pas les droits nessésaire")
			end
		end
	})
end)

boss2_action_menu:IsVisible(function(Items)
	local PlayerData = ESX.GetPlayerData()

	Items:Separator("Métier : "..Shared:ServerColorCode()..""..PlayerData.job2.label.."")
	Items:Separator("Grade : "..Shared:ServerColorCode()..""..PlayerData.job2.grade_label.."")

	if societymoney2 ~= nil then
		Items:Separator("Argent dans la société : "..Shared:ServerColorCode()..""..societymoney2.." ~g~$")
	end

	Items:Line()

	Items:Button("Recruter l'individu", "Engager la personne en face de vous", {}, true, {
		onActive = function()
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestPlayer ~= -1 and closestDistance <= 3 then
				playerMarker(closestPlayer)
			end
		end,

		onSelected = function()
			if PlayerData.job2.grade_name == "boss" then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur autour de vous")
				else
					exports["vCore3"]:RecruitPlayer("job2", GetPlayerServerId(closestPlayer))
				end

			else
				ESX.ShowNotification("Vous possédez pas les droits nessésaire")
			end
		end
	})
end)

car_menu:IsVisible(function(Items)
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local GetVehicle = GetVehiclePedIsIn(playerPed, false)
		local GetVehicleFuel = exports["vCore3"]:GetFuel(GetVehicle) or 0
		local VehicleFuelRounded = (math.round(GetVehicleFuel))
		local GetVehicleHealth = (math.round(GetVehicleEngineHealth(GetVehicle)) / 10)

		Items:Separator("Verrouillage centralisé : "..doorState().."")
		Items:Separator("Carburant : "..VehicleFuelRounded.."L")
		Items:Separator("État du moteur : "..GetVehicleHealth.."%")

		Items:Line()

		Items:List("Action Moteur", InteractMenu.engineActionList, InteractMenu.engineActionIndex, nil, {}, true, {
			onListChange = function(index)
				InteractMenu.engineActionIndex = index
			end,

			onSelected = function(index)
				if index == 1 then
					SetVehicleEngineOn(GetVehicle, true, true, false)
				else
					SetVehicleEngineOn(GetVehicle, false, true, true)
				end
			end
		})

		Items:List("Limiteur de vitesse", InteractMenu.maxSpeedList, InteractMenu.maxSpeedListIndex, nil, {}, true, {
			onListChange = function(index)
				InteractMenu.maxSpeedListIndex = index
			end,
			onSelected = function(index)
				if index == 1 then
					SetVehicleMaxSpeed(GetVehicle, 13.7)
				elseif index == 2 then
					SetVehicleMaxSpeed(GetVehicle, 22.0)
				elseif index == 3 then
					SetVehicleMaxSpeed(GetVehicle, 33.0)
				elseif index == 4 then
					SetVehicleMaxSpeed(GetVehicle, 36.0)
				elseif index == 5 then
					SetVehicleMaxSpeed(GetVehicle, 0.0)
				end
			end
		})

		Items:List("Action portes", {"Ouvrir","Fermer"}, InteractMenu.doorActionIndex, nil, {}, true, {
			onListChange = function(index)
				InteractMenu.doorActionIndex = index
			end,
		})

		Items:List("Ouverture", InteractMenu.doorsList, InteractMenu.doorIndex, nil, {}, true, {
			onListChange = function(index)
				InteractMenu.doorIndex = index
			end,
			onSelected = function(index)
				if isAllowedToManageVehicle() then
					if index == 1 then
						doorAction(-1) 
					elseif index == 2 then
						doorAction(0) 
					elseif index == 3 then
						doorAction(1) 
					elseif index == 4 then
						doorAction(2) 
					elseif index == 5 then
						doorAction(3) 
					elseif index == 6 then
						doorAction(4) 
					elseif index == 7 then
						doorAction(5) 
					end
				end
			end
		})

	else
		Items:Separator("")
		Items:Separator(Config["ServerColorCode"].." Vous devez être dans un véhicule")
		Items:Separator("")
	end
end)

information_menu:IsVisible(function(Items)
	local PlayerData = ESX.GetPlayerData()
	Items:Button("ID :", nil, {RightLabel = GetPlayerServerId(PlayerId())}, true, {})
	Items:Button("Numéro de Compte :", nil, {RightLabel = PlayerData.character_id}, true, {})
	Items:Button("Niveau du personnage :", nil, {RightLabel = exports["Game"]:getPlayerLevel()}, true, {})
	Items:Button("Nom & Prenom :", nil, {RightLabel = ""..InteractMenu.player.lastname.." "..InteractMenu.player.firstname..""}, true, {})
	Items:Button("Niveau VIP :", nil, {RightLabel = getVipState()}, true, {})
end)

other_menu:IsVisible(function(Items)

	-- Items:Button("Véhicule", nil, {}, isInCar, {}, car_menu)

	-- Items:Line()
	
	-- Items:Checkbox("Masquer l'interface", nil, InteractMenu.hud, {}, {
	-- 	onSelected = function()
	-- 		InteractMenu.hud = not InteractMenu.hud
	-- 		if InteractMenu.hud then
	-- 			TriggerEvent("hud:hide", true)
	-- 		else
	-- 			TriggerEvent("hud:hide", false)
	-- 		end
	-- 	end
	-- })

	-- Items:Checkbox("Mode Cinématique", nil, InteractMenu.cinema, {}, {
	-- 	onSelected = function()
	-- 		InteractMenu.cinema = not InteractMenu.cinema
	-- 		TriggerEvent('hud:cinema')
	-- 	end
	-- })

	-- Items:Checkbox("Interface GPS", nil, InteractMenu.minimap, {}, {
	-- 	onSelected = function()
	-- 		InteractMenu.minimap = not InteractMenu.minimap
	-- 		if InteractMenu.minimap then
	-- 			DisplayRadar(false)
	-- 		else
	-- 			DisplayRadar(true)
	-- 		end
	-- 	end
	-- })

	-- Items:Button("Niveau : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..exports["Game"]:getPlayerLevel(), nil, {} {
	-- 	onSelected = function()
	-- 		ExecuteCommand("xpbarinfo")
	-- 	end
	-- })

	Items:Button("Voir votre Niveau : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..exports["Game"]:getPlayerLevel(), nil, { RightLabel = "→→"}, true, {
        onSelected = function()
            ExecuteCommand("-xpbarinfo")
        end
    })

	Items:Button("Voir vos heures de Jeux", nil, { RightLabel = "→→"}, true, {
        onSelected = function()
            ExecuteCommand("mytime")
        end
    })

	Items:Button("Voir les ID Proche", nil, { RightLabel = "→→"}, true, {}, id_menu)

	-- Items:Line()

	Items:Checkbox("Désactiver Casque de moto", nil, InteractMenu.helmet, {}, {
		onSelected = function()
			InteractMenu.helmet = not InteractMenu.helmet
			if InteractMenu.helmet then
				SetPedHelmet(PlayerPedId(), false)
			else
				SetPedHelmet(PlayerPedId(), true)
			end
		end
	})

	Items:Checkbox("Activé la vente de drogue", nil, InteractMenu.sellDrugs, {}, {
		onSelected = function()
			InteractMenu.sellDrugs = not InteractMenu.sellDrugs
			ExecuteCommand("ventedrogue")
		end
	}) 

	-- Items:Line()

	Items:Button("Sortir votre Sac de poches", nil, { RightLabel = "→→"}, true, {
        onSelected = function()
			TriggerEvent("kq_outfitbag:placeBag")
        end
    })

	Items:Button("Réticule personnalisé", nil, { RightLabel = "→→" }, true, {}, crosshair_menu)

	Items:Button("Visual", nil, { RightLabel = "→→" }, true, {}, visual_menu)

	Items:Button("Ouvrir le "..Config["BattlePass"]["name"].."", nil, { RightLabel = "→→" }, true, {}, pass_menu)

end)

id_menu:IsVisible(function(Items)

	for _, player in ipairs(GetActivePlayers()) do
		local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
		local coords = GetEntityCoords(GetPlayerPed(player))
		local sta = GetPlayerServerId()

		if IsEntityVisible(GetPlayerPed(player)) then
			if dst < 3.0 then
				if sta ~= "me" then
					Items:Button("Joueurs : ~b~"..GetPlayerName(player), nil, { RightLabel = "ID Temporaire : ~b~"..GetPlayerServerId(player)}, true, {
						onActive = function()
							DrawMarker(32, coords.x, coords.y, coords.z + 1.2, nil, nil, nil, nil, nil, nil, 0.3, 0.3, 0.3, 51, 162, 255, 150, true, true)
						end,
						onSelected = function()
							ESX.ShowNotification("ID Temporaire de la personne ( ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(player).."~s~ )")
						end
					})
				end
			end
		end
	end

end)

crosshair_menu:IsVisible(function(Items)
	Items:Button("Activer/Désactiver le réticule", nil, {RightLabel = "→→"}, true, {onSelected = function() TriggerEvent("sertyy:crosshair:active") end})
	
	Items:Button("Modifier le réticule", nil, {RightLabel = "→→"}, true, {onSelected = function() TriggerEvent("sertyy:crosshair:edit") RageUI:CloseAll() end})
	
	Items:Button("Réinitialiser le réticule", nil, {RightLabel = "→→"}, true, {onSelected = function() TriggerEvent("sertyy:crosshair:reset") end})
end)

pass_menu:IsVisible(function(Items)
	local PlayerLevel = exports["Game"]:getPlayerLevel()
	
	Items:Separator("Votre Niveau :"..Shared:ServerColorCode().." "..PlayerLevel.."")
	Items:Separator("Début : "..Shared:ServerColorCode()..""..Config["BattlePass"]["Date1"].."~w~ - Fin : "..Shared:ServerColorCode()..""..Config["BattlePass"]["Date2"].."")
	Items:Line()

	for k, v in pairs(Config["BattlePass"]["Gift"]) do

		if tonumber(PlayerLevel) >= tonumber(v.level) then

			Items:Button(Config["ServerColorCode"].."Niveau "..v.level.."~w~ - "..v.label, nil, {}, true, {
				onSelected = function()
					TriggerServerEvent('vCore1:pass:gift', tonumber(v.level))
				end
			})
			
		else
			Items:Button(Config["ServerColorCode"].."Niveau "..v.level.."~w~ - "..v.label, nil, {}, false, {})
		end

	end
end)

visual_menu:IsVisible(function(Items)
	Items:Checkbox("Vue & lumières améliorées", nil, InteractMenu.Visual1, {}, {
		onSelected = function()
			InteractMenu.Visual1 = not InteractMenu.Visual1

			if  InteractMenu.Visual1 then
				SetTimecycleModifier('tunnel')
			else
				SetTimecycleModifier('')
			end

		end
	})

	Items:Checkbox("Visual 1 (Boost FPS)", nil, InteractMenu.Visual2, {}, {
		onSelected = function()
			InteractMenu.Visual2 = not InteractMenu.Visual2

			if  InteractMenu.Visual2 then
				SetTimecycleModifier('yell_tunnel_nodirect')
			else
				SetTimecycleModifier('')
			end

		end
	})

	Items:Checkbox("Couleurs amplifiées", nil, InteractMenu.Visual3, {}, {
		onSelected = function()
			InteractMenu.Visual3 = not InteractMenu.Visual3

			if  InteractMenu.Visual3 then
				SetTimecycleModifier('rply_saturation')
			else
				SetTimecycleModifier('')
			end

		end
	})

	Items:Checkbox("Noir & blancs", nil, InteractMenu.Visual4, {}, {
		onSelected = function()
			InteractMenu.Visual4 = not InteractMenu.Visual4
			
			if  InteractMenu.Visual4 then
				SetTimecycleModifier('rply_saturation_neg')
			else
				SetTimecycleModifier('')
			end

		end
	})

	Items:Checkbox("Dégats", nil, InteractMenu.Visual5, {}, {
		onSelected = function()

			InteractMenu.Visual5 = not InteractMenu.Visual5
			if  InteractMenu.Visual5 then
				SetTimecycleModifier('rply_vignette')
			else
				SetTimecycleModifier('')
			end

		end
	})

end)

vip_menu:IsVisible(function(Items)
	Items:Button("Couleurs Armes", nil, {}, true, {})
	Items:Button("Options Véhicule", nil, {}, true, {})
	Items:Button("Information VIP", nil, {}, true, {})
end)


Shared:RegisterKeyMapping("vCore1:interactmenu:use", { label = "open_menu_interact" }, "F5", function()
    if not IsInPVP then
		main_menu:Toggle()
	end
end)