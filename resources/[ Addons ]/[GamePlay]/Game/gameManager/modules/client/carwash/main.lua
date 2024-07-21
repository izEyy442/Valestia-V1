--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Key = 201
local sWash = {}

vehicleWashStation = {
	{x = 26.5906,  y = -1392.0261,  z = 27.3634},
	{x = 167.1034,  y = -1719.4704,  z = 27.2916},
	{x = -74.5693,  y = 6427.8715,  z = 29.4400},
	{x = -699.6325,  y = -932.7043, z = 17.0139},
	{x = -515.9252,  y = 7581.9995, z = 6.3632},
	{x = 1362.5385, y = 3592.1274, z = 33.9211}
}

-- Blips & Marker --
Citizen.CreateThread(function()
    for k in pairs(vehicleWashStation) do
       local blipvehicleWashStation = AddBlipForCoord(vehicleWashStation[k].x, vehicleWashStation[k].y, vehicleWashStation[k].z)
       SetBlipSprite(blipvehicleWashStation, 100)
       SetBlipColour(blipvehicleWashStation, 3)
       SetBlipScale(blipvehicleWashStation, 0.6)
       SetBlipAsShortRange(blipvehicleWashStation, true)

       BeginTextCommandSetBlipName('STRING')
       AddTextComponentString("[Public] Station de lavage")
       EndTextCommandSetBlipName(blipvehicleWashStation)
   end
end)

function es_carwash_DrawSubtitleTimed(m_text, showtime)
	SetTextEntry_2('STRING')
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function es_carwash_DrawNotification(m_text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end

Citizen.CreateThread(function ()
    while true do
        local interval = 500
        local pCoords = GetEntityCoords(PlayerPedId(), false)
		if IsPedSittingInAnyVehicle(PlayerPedId()) then
        	for k,v in pairs(vehicleWashStation) do
            	local distance = Vdist(pCoords.x, pCoords.y, pCoords.z, vehicleWashStation[k].x, vehicleWashStation[k].y, vehicleWashStation[k].z)
            	if not sWash.Menu then
                	if distance <= 10.0 then
						interval = 1
						DrawMarker(1, vehicleWashStation[k].x, vehicleWashStation[k].y, vehicleWashStation[k].z, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
						es_carwash_DrawSubtitleTimed("Appuyez [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ENTRER~s~] laver votre véhicule!")
						if IsControlJustPressed(1, Key) then
							OpenCarWash()
						end
					end
				end
			end
		end
		Citizen.Wait(interval)
	end
end)

RMenuv1.Add('wash', 'main', RageUIv1.CreateMenu("", "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Actions disponibles"))
RMenuv1:Get('wash', 'main').EnableMouse = false
RMenuv1:Get('wash', 'main').Closed = function() sWash.Menu = false FreezeEntityPosition(PlayerPedId(), false) end
function OpenCarWash()
	if sWash.Menu then
		sWash.Menu = false
	else
		sWash.Menu = true
		RageUIv1.Visible(RMenuv1:Get('wash', 'main'), true)

		Citizen.CreateThread(function()
			while sWash.Menu do
				RageUIv1.IsVisible(RMenuv1:Get('wash', 'main'), true, true, true, function()
					RageUIv1.ButtonWithStyle("Laver votre véhicule", nil, {RightLabel = "~y~500 $~s~ →"}, true, function(h,a,s)
						if s then
							TriggerServerEvent('es_carwash:checkmoney')
						end
					end)
				end)
				Wait(1)
			end
		end)
	end
end

RegisterNetEvent('es_carwash:success')
AddEventHandler('es_carwash:success', function (price)
	WashDecalsFromVehicle(GetVehiclePedIsUsing(PlayerPedId()), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(PlayerPedId()))
	es_carwash_DrawNotification("Votre véhicule a été ~y~nettoyé~s~ ! \n- Vous avez payé ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" .. price .. " $~s~!")
end)

RegisterNetEvent('es_carwash:notenoughmoney')
AddEventHandler('es_carwash:notenoughmoney', function (moneyleft)
	es_carwash_DrawNotification("~h~~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas assez d'argent! $" .. moneyleft .. " left!")
end)

RegisterNetEvent('es_carwash:free')
AddEventHandler('es_carwash:free', function ()
	WashDecalsFromVehicle(GetVehiclePedIsUsing(PlayerPedId()), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(PlayerPedId()))
	es_carwash_DrawNotification("Votre véhicule a été ~y~nettoyé~s~ gratuitement ~!")
end)
