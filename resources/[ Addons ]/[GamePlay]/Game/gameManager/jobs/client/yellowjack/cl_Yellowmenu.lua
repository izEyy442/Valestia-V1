-- MENU FUNCTION --

local open = false 
local yellowjackMain2 = RageUI.CreateMenu('', 'Yellow Jack')
local subMenu5 = RageUI.CreateSubMenu(yellowjackMain2, "Annonces", "Interaction")
yellowjackMain2.Display.Header = true 
yellowjackMain2.Closed = function()
  open = false
end

function KeyboardInputyellowjack(entryTitle, textEntry, inputText, maxLength)
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



local society = {
    label = "yellowjack",
    name = "yellowjackjob",
}


local IndexStrip = 1


function OpenMenuyellowjack()
	if open then 
		open = false
		RageUI.Visible(yellowjackMain2, false)
		return
	else
		open = true 
		RageUI.Visible(yellowjackMain2, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(yellowjackMain2,function() 

			RageUI.Separator("↓ Annonce Yellow Jack ↓")
			RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ouvre:yellowjack')
				end
			})

			RageUI.Button("Annonce ~r~[Fermetures]~r~", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ferme:yellowjack')
				end
			})

			RageUI.Button("Annonce ~p~[Recrutement]", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Recrutement:yellowjack')
				end
			})
			
			RageUI.Separator("↓ Facture ↓")
			RageUI.Button("Faire une ~p~Facture", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local montant = KeyboardInputPolice("Montant:", 'Indiquez un montant', '', 6)
					local amount = 0;
                    if tonumber(montant) == nil then
                        ESX.ShowNotification("Montant invalide")
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification('~r~Personne autour de vous')
						else
              ESX.ShowNotification("~g~Facture envoyée avec succès !")
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'yellowjack', 'yellowjack', amount)
						end
                    end
                end
            })
			end)

		 Wait(0)
		end
	 end)
  end
end




-- FUNCTION BILLING --

function OpenBillingMenu2()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
      ESX.ShowNotification("~g~Facture envoyé !")
      TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(player), amount)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'yellowjack', ('yellowjack'), amount)
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end


  Keys.Register('F6','InteractionsJobyellowjack', "Menu job Yellow Jack", function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'yellowjack' then
        if (not IsInPVP) then
          OpenMenuyellowjack()
        end
    end
end)