ESX = nil
local hunger, thirst = 0, 0
local uiFaded = false

CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

RegisterNetEvent("Hud:hide", function(show) 
	SendNUIMessage({ type = "SET_SHOW_ATH", show = show }) 
end)

RegisterNetEvent("ui:update")
AddEventHandler("ui:update", function(nbPlayerTotal)
    SendNUIMessage({ type = "SET_PLAYERS_COUNT", playerCount = nbPlayerTotal })
end)

AddEventHandler('tempui:toggleUi', function(value)
	uiFaded = value

	if uiFaded then
        SendNUIMessage({ type = "SET_SHOW_ATH", show = false }) 
	else
        SendNUIMessage({ type = "SET_SHOW_ATH", show = true }) 
	end
end)

AddEventHandler('set_ply_mics', function(value)
	SendNUIMessage({
		type = "SET_PLAYER_MICS",
		value = value
	})
end)


Citizen.CreateThread(function()
    Wait(2500)

    SendNUIMessage({ type = "SET_ID_PLAYER", playerID = GetPlayerServerId(PlayerId()) })
    SendNUIMessage({ type = "SET_SHOW_ATH", show = true }) 

	local inFrontend = false

	while true do
		Wait(250)
		
		HideHudComponentThisFrame(1) -- Wanted Stars
		HideHudComponentThisFrame(2) -- Weapon Icon
		HideHudComponentThisFrame(3) -- Cash
		HideHudComponentThisFrame(4) -- MP Cash
		HideHudComponentThisFrame(6) -- Vehicle Name
		HideHudComponentThisFrame(7) -- Area Name
		HideHudComponentThisFrame(8) -- Vehicle Class
		HideHudComponentThisFrame(9) -- Street Name
		HideHudComponentThisFrame(13) -- Cash Change
		HideHudComponentThisFrame(17) -- Save Game
		HideHudComponentThisFrame(20) -- Weapon Stats

		if not uiFaded then
			if IsPauseMenuActive() or IsPlayerSwitchInProgress() then
				if not inFrontend then
					inFrontend = true
                    SendNUIMessage({ type = "SET_SHOW_ATH", show = false }) 
				end
			else
				if inFrontend then
					inFrontend = false
                    SendNUIMessage({ type = "SET_SHOW_ATH", show = true }) 
				end
			end
		end
	end
end)

CreateThread(function()
    while true do
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
        end)
		

        SendNUIMessage({type = "SET_PLAYER_WATER", pourcent = thirst })
        SendNUIMessage({type = "SET_PLAYER_FOOD", pourcent = hunger })

        Wait(3000)
    end
end)