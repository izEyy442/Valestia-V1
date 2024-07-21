ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
	TriggerServerEvent("exedrugs_requestDrugs")
	startMakerLoop()
end)

RegisterNetEvent("exedrugs_openMenu")
AddEventHandler("exedrugs_openMenu", function(drugs)
	if not menuOpened then openMenu35(drugs) end
end)

RegisterNetEvent("exedrugs_updateDrugs")
AddEventHandler("exedrugs_updateDrugs", function(drugs)
	updateDrugs(drugs)
end)

