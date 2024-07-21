--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
enableprice = true 

price = 500

RegisterServerEvent('es_carwash:checkmoney')
AddEventHandler('es_carwash:checkmoney', function ()
	if enableprice == true then
		local xPlayer = ESX.GetPlayerFromId(source)
		userMoney = xPlayer.getAccount('cash').money
		if userMoney >= price then
			xPlayer.removeAccountMoney('cash', price)
			TriggerClientEvent('es_carwash:success', source, price)
		else
			moneyleft = price - userMoney
			TriggerClientEvent('es_carwash:notenoughmoney', source, moneyleft)
		end
	else
		TriggerClientEvent('es_carwash:free', source)
	end
end)
