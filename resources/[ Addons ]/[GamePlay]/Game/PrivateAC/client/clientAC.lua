ESX = nil
local isLoaded = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
	ESX.TriggerServerCallback('screenshot:getwebhook', function(aaa)
        WebHook = aaa
    end)
end)

AddEventHandler('esx:playerLoaded', function(xPlayer)
    Wait(120000)
    isLoaded = true
end)

RegisterNetEvent("vCore1:GetScreen")
AddEventHandler("vCore1:GetScreen", function()
    exports['screenshot-basic']:requestScreenshotUpload(WebHook, "files[]", function(data)
    end)
end)