ESXLoaded = false
ESX = nil

function LoadESX()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end    
    
	ESX.PlayerData = ESX.GetPlayerData()

	while ESX.PlayerData == nil do 
		Wait(1)
	end

	Wait(500)
    ESXLoaded = true
	ESX.Logs.Success("ESX is Loaded")
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	LoadESX()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	Wait(1000)
	if not ESXLoaded then 
		LoadESX()
	end
end)