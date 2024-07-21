QBCore = nil

ESX = nil

if Config.Framework == "qbcore" then
	QBCore = exports[Config.QBCoreFrameworkResourceName]:GetCoreObject()
	if Config.WaterParkPaymentRequired then
		if Config.WaterParkPass then
			QBCore.Functions.CreateUseableItem("waterpass", function(source, item)
				local playersource = source
				local Player = QBCore.Functions.GetPlayer(playersource)
				if Player then
					Player.Functions.RemoveItem("waterpass", 1)
					waterpass[playersource] = true
					TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["waterpassactivated"])
					TriggerClientEvent("rtx_waterpark:WaterPassActivated", playersource)
				end
			end)			
			RegisterServerEvent("rtx_waterpark:WaterParkEntry")
			AddEventHandler("rtx_waterpark:WaterParkEntry", function()
				local playersource = source
				local Player = QBCore.Functions.GetPlayer(playersource)
				if Player then		
					if Player.Functions.GetItemByName("waterpassunlimited").amount >= 1 or waterpass[playersource] ~= nil then		
						waterparkpayed[playersource] = true
						TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["waterpass"])
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, false)
						TriggerClientEvent("rtx_waterpark:WaterParkTicketPayed", playersource)
						Wait(Config.TurnStileLockWait)
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, true)					
					else
						if Player.Functions.GetMoney('cash') >= Config.WaterParkEntryPrice then
							Player.Functions.RemoveMoney('cash', Config.WaterParkEntryPrice)			
							waterparkpayed[playersource] = true
							TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["payedentry"])
							TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, false)
							TriggerClientEvent("rtx_waterpark:WaterParkTicketPayed", playersource)
							Wait(Config.TurnStileLockWait)
							TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, true)
						else
							TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["notenoughmoney"])
						end
					end
				end
			end)		
		else
			RegisterServerEvent("rtx_waterpark:WaterParkEntry")
			AddEventHandler("rtx_waterpark:WaterParkEntry", function()
				local playersource = source
				local Player = QBCore.Functions.GetPlayer(playersource)
				if Player then		
					if Player.Functions.GetMoney('cash') >= Config.WaterParkEntryPrice then
						Player.Functions.RemoveMoney('cash', Config.WaterParkEntryPrice)			
						waterparkpayed[playersource] = true
						TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["payedentry"])
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, false)
						TriggerClientEvent("rtx_waterpark:WaterParkTicketPayed", playersource)
						Wait(Config.TurnStileLockWait)
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, true)
					else
						TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["notenoughmoney"])
					end
				end
			end)
		end
	end	
end

if Config.Framework == "esx" then
	if Config.ESXFramework.newversion == true then
		ESX = exports["es_extended"]:getSharedObject()
	else
		TriggerEvent(Config.ESXFramework.getsharedobject, function(obj) 
			ESX = obj 
		end)
	end
	if Config.WaterParkPaymentRequired then
		if Config.WaterParkPass then
			ESX.RegisterUsableItem("waterpass", function(source)
				local playersource = source
				local xPlayer = ESX.GetPlayerFromId(playersource)
				if xPlayer then
					xPlayer.removeInventoryItem("waterpass", 1)
					waterpass[playersource] = true
					TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["waterpassactivated"])
					TriggerClientEvent("rtx_waterpark:WaterPassActivated", playersource)					
				end
			end)			
			RegisterServerEvent("rtx_waterpark:WaterParkEntry")
			AddEventHandler("rtx_waterpark:WaterParkEntry", function()
				local playersource = source
				local xPlayer = ESX.GetPlayerFromId(playersource)
				if xPlayer then			
					local waterpassitem = xPlayer.getInventoryItem("waterpassunlimited")					
					if waterpassitem.count >= 1 or waterpass[playersource] ~= nil then		
						waterparkpayed[playersource] = true
						TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["waterpass"])
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, false)
						TriggerClientEvent("rtx_waterpark:WaterParkTicketPayed", playersource)
						Wait(Config.TurnStileLockWait)
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, true)		
					else
						if xPlayer.getMoney() >= Config.WaterParkEntryPrice then
							xPlayer.removeMoney(Config.WaterParkEntryPrice)			
							waterparkpayed[playersource] = true
							TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["payedentry"])
							TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, false)
							TriggerClientEvent("rtx_waterpark:WaterParkTicketPayed", playersource)
							Wait(Config.TurnStileLockWait)
							TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, true)
						else
							TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["notenoughmoney"])
						end
					end
				end
			end)		
		else
			RegisterServerEvent("rtx_waterpark:WaterParkEntry")
			AddEventHandler("rtx_waterpark:WaterParkEntry", function()
				local playersource = source
				local xPlayer = ESX.GetPlayerFromId(playersource)
				if xPlayer then			
					if xPlayer.getMoney() >= Config.WaterParkEntryPrice then
						xPlayer.removeMoney(Config.WaterParkEntryPrice)			
						waterparkpayed[playersource] = true
						TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["payedentry"])
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, false)
						TriggerClientEvent("rtx_waterpark:WaterParkTicketPayed", playersource)
						Wait(Config.TurnStileLockWait)
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, true)
					else
						TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["notenoughmoney"])
					end
				end
			end)
		end
	end	
end

if Config.Framework == "standalone" then
	-- you need add here your money check function
	if Config.WaterParkPaymentRequired then
		if Config.WaterParkPass then
			--[[ 
			
			-- you need edit this usable for your framework (this is example from esx) (You can create ticket on our discord and we can help you with that)
			ESX.RegisterUsableItem("waterpass", function(source)
				local playersource = source
				local xPlayer = ESX.GetPlayerFromId(playersource)
				if xPlayer then
					xPlayer.removeInventoryItem("waterpass", 1)
					waterpass[playersource] = true
					TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["waterpassactivated"])
					TriggerClientEvent("rtx_waterpark:WaterPassActivated", playersource)					
				end
			end)						
			
			--You need edit this trigger for your framework (this is example from esx, you need replace item check with your item check from your framework) (You can create ticket on our discord and we can help you with that)
						
			RegisterServerEvent("rtx_waterpark:WaterParkEntry")
			AddEventHandler("rtx_waterpark:WaterParkEntry", function()
				local playersource = source		
				local waterpassitem = xPlayer.getInventoryItem("waterpassunlimited")					
				if waterpassitem.count >= 1 or waterpass[playersource] ~= nil then		
					waterparkpayed[playersource] = true
					TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["waterpass"])
					TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, false)
					TriggerClientEvent("rtx_waterpark:WaterParkTicketPayed", playersource)
					Wait(Config.TurnStileLockWait)
					TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, true)		
				else
					if xPlayer.getMoney() >= Config.WaterParkEntryPrice then
						xPlayer.removeMoney(Config.WaterParkEntryPrice)			
						waterparkpayed[playersource] = true
						TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["payedentry"])
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, false)
						TriggerClientEvent("rtx_waterpark:WaterParkTicketPayed", playersource)
						Wait(Config.TurnStileLockWait)
						TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, true)
					else
						TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["notenoughmoney"])
					end
				end
			end)	
			]]--
		else
			RegisterServerEvent("rtx_waterpark:WaterParkEntry")
			AddEventHandler("rtx_waterpark:WaterParkEntry", function()
				local playersource = source
				waterparkpayed[playersource] = true
				TriggerClientEvent("rtx_waterpark:Notify", playersource, Language[Config.Language]["payedentry"])
				TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, false)
				TriggerClientEvent("rtx_waterpark:WaterParkTicketPayed", playersource)
				Wait(Config.TurnStileLockWait)
				TriggerClientEvent("rtx_waterpark:WaterParkLock", -1, true)
			end)		
		end
	end
end