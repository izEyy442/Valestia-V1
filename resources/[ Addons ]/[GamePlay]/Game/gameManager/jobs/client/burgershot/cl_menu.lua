Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local open = false
local mainMenu8 = RageUI.CreateMenu('', 'Interaction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local subMenu10 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
mainMenu8.Display.Header = true
mainMenu8.Closed = function()
  open = false
end

function OpenF6BurgerShot()
	if open then
		open = false
		RageUI.Visible(mainMenu8, false)
		return
	else
		open = true
		RageUI.Visible(mainMenu8, true)
		CreateThread(function()
		while open do
		   RageUI.IsVisible(mainMenu8,function()

			RageUI.Button("Annonces BurgerShot", nil, {RightLabel = "→"}, true , {
				onSelected = function()
				end
			}, subMenu8)

			RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local montant = KeyboardInputPolice("Montant:", 'Indiquez un montant', '', 7)
                    if tonumber(montant) == nil then
						ESX.ShowAdvancedNotification('Notification', "BurgerShot", "Montant invalide", 'CHAR_CALL911', 8)
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowAdvancedNotification('Notification', "BurgerShot", "Personne autour de vous", 'CHAR_CALL911', 8)
						else
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'burgershot', 'BurgerShot', amount)
						end
                    end
                end
            })

			end)

			RageUI.IsVisible(subMenu8,function()


			RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Ouvertures", nil, {RightLabel = "→"}, not codesCooldown1, {
				onSelected = function()
					codesCooldown1 = true
					TriggerServerEvent('Ouvre:BurgerShot')

					CreateThread(function()
						Wait(15000)
						codesCooldown1 = false
					end)
				end
			})

			RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Fermetures", nil, {RightLabel = "→"}, not codesCooldown2, {
				onSelected = function()
					codesCooldown2 = true
					TriggerServerEvent('Ferme:BurgerShot')

					CreateThread(function()
						Wait(15000)
						codesCooldown2 = false
					end)
				end
			})

			RageUI.Button("Annonce ~y~Recrutement", nil, {RightLabel = "→"}, not codesCooldown3, {
				onSelected = function()
					codesCooldown3 = true
					TriggerServerEvent('Recrutement:BurgerShot')

					CreateThread(function()
						Wait(15000)
						codesCooldown3 = false
					end)
				end
			})

		   end)

		 Wait(0)
		end
	 end)
  end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

-- OUVERTURE DU MENU --

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Keys.Register('F6', 'burgershot', 'Ouvrir le menu burgershot', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' then
		if (not IsInPVP) then
			OpenF6BurgerShot()
		end
	end
end)

Citizen.CreateThread(function()

	local blip = AddBlipForCoord(-1191.99, -889.81, 302.66)

	SetBlipSprite (blip, 106) -- Model du blip
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.5) -- Taille du blip
	SetBlipColour (blip, 46) -- Couleur du blip
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('[Entreprise] BurgerShot') -- Nom du blip
	EndTextCommandSetBlipName(blip)
  end)

