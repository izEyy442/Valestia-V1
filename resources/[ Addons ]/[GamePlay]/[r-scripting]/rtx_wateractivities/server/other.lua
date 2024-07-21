function RemoveMoneyRTX(playersource, moneydata)
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer then
			xPlayer.removeAccountMoney('cash',moneydata)
		end
	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer then	
			xPlayer.Functions.RemoveMoney('cash', moneydata)	
		end
	elseif Config.Framework == "standalone" then
		
	end
end	

function GetMoneyRTX(playersource)
	local moneydata = 0
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer then
			print( xPlayer.getAccount('cash').money)
			moneydata = xPlayer.getAccount('cash').money
		end
	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer then	
			moneydata = xPlayer.Functions.GetMoney('cash')
		end
	elseif Config.Framework == "standalone" then
		moneydata = 99999999999
	
	end
	return moneydata
end

function GiveActivitesItem(playersource, itemname)
	if Config.WaterActivitiesViaItem then
		if Config.Framework == "esx" then
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				xPlayer.addInventoryItem(itemname, 1)			
			end		
		end
		if Config.Framework == "qbcore" then
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then	
				xPlayer.Functions.AddItem(itemname, 1, false, {})
			end		
		end		
	end
end

function RemoveActivitesItem(playersource, itemname)
	local removed = false
	if Config.WaterActivitiesViaItem then
		if Config.Framework == "esx" then
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				local itemdata = xPlayer.getInventoryItem(itemname)
				if itemdata.count >= 1 then				
					xPlayer.removeInventoryItem(itemname, 1)	
					removed = true
				end
			end		
		end
		if Config.Framework == "qbcore" then
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then	
				if xPlayer.Functions.GetItemByName(itemname).amount >= 1 then
					xPlayer.Functions.RemoveItem(itemname, 1, false, {})
					removed = true
				end
			end		
		end		
	else
		removed = true
	end
	return removed
end

if Config.Framework == "esx" then
	if Config.WaterActivitiesViaItem then
		ESX.RegisterUsableItem(Config.WaterActivitiesItemNames["banana"], function(source)
			local playersource = source
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Banana:SpawnBanana", playersource)					
			end
		end)	

		ESX.RegisterUsableItem(Config.WaterActivitiesItemNames["inflatable"], function(source)
			local playersource = source
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Inflatable:SpawnInflatable", playersource)					
			end
		end)	

		ESX.RegisterUsableItem(Config.WaterActivitiesItemNames["parasailing"], function(source)
			local playersource = source
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Parachute:SpawnParachute", playersource)					
			end
		end)	

		ESX.RegisterUsableItem(Config.WaterActivitiesItemNames["ski"], function(source)
			local playersource = source
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Ski:SpawnSki", playersource)					
			end
		end)	

		ESX.RegisterUsableItem(Config.WaterActivitiesItemNames["circle"], function(source)
			local playersource = source
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Circle:SpawnCircle", playersource)					
			end
		end)	

		ESX.RegisterUsableItem(Config.WaterActivitiesItemNames["bed1"], function(source)
			local playersource = source
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Bed:SpawnBed", playersource)					
			end
		end)	

		ESX.RegisterUsableItem(Config.WaterActivitiesItemNames["bed2"], function(source)
			local playersource = source
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Bed2:SpawnBed", playersource)					
			end
		end)

		ESX.RegisterUsableItem(Config.WaterActivitiesItemNames["bed3"], function(source)
			local playersource = source
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Bed3:SpawnBed", playersource)					
			end
		end)

		ESX.RegisterUsableItem(Config.WaterActivitiesItemNames["bed4"], function(source)
			local playersource = source
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Bed4:SpawnBed", playersource)					
			end
		end)
	end
end

if Config.Framework == "qbcore" then
	if Config.WaterActivitiesViaItem then
		QBCore.Functions.CreateUseableItem(Config.WaterActivitiesItemNames["banana"], function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Banana:SpawnBanana", playersource)					
			end
		end)	

		QBCore.Functions.CreateUseableItem(Config.WaterActivitiesItemNames["inflatable"], function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Inflatable:SpawnInflatable", playersource)					
			end
		end)	

		QBCore.Functions.CreateUseableItem(Config.WaterActivitiesItemNames["parasailing"], function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Parachute:SpawnParachute", playersource)					
			end
		end)	

		QBCore.Functions.CreateUseableItem(Config.WaterActivitiesItemNames["ski"], function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Ski:SpawnSki", playersource)					
			end
		end)	

		QBCore.Functions.CreateUseableItem(Config.WaterActivitiesItemNames["circle"], function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Circle:SpawnCircle", playersource)					
			end
		end)	

		QBCore.Functions.CreateUseableItem(Config.WaterActivitiesItemNames["bed1"], function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Bed:SpawnBed", playersource)					
			end
		end)	

		QBCore.Functions.CreateUseableItem(Config.WaterActivitiesItemNames["bed2"], function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Bed2:SpawnBed", playersource)					
			end
		end)

		QBCore.Functions.CreateUseableItem(Config.WaterActivitiesItemNames["bed3"], function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Bed3:SpawnBed", playersource)					
			end
		end)

		QBCore.Functions.CreateUseableItem(Config.WaterActivitiesItemNames["bed4"], function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then
				TriggerClientEvent("rtx_wateractivities:Bed4:SpawnBed", playersource)					
			end
		end)	
	end
end