--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

RegisterNetEvent('esx_addons_gcphone:call')
AddEventHandler('esx_addons_gcphone:call', function(data)
	if data.message == nil then
		DisplayOnscreenKeyboard(1, 'FMMC_MPM_NA', '', '', '', '', '', 200)

		while UpdateOnscreenKeyboard() == 0 do
			DisableAllControlActions(0)
			Citizen.Wait(0)
		end

		if GetOnscreenKeyboardResult() then
			data.message = GetOnscreenKeyboardResult()
		end
	end

	if data.message ~= nil and data.message ~= '' then
		local coords = GetEntityCoords(PlayerPedId(), false)

		Valestia.InternalToServer('esx_addons_gcphone:startCall', data.number, data.message, {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})
	end
end)