local ESX, currentFishing

RegisterNetEvent("setFishingState")
AddEventHandler("setFishingState", function(state, message)
    currentFishing = state
    if message then ESX.ShowAdvancedNotification('Notification', 'Pêche', message, 'CHAR_CALL911', 8) end
end)

RegisterNetEvent("startFishing")
AddEventHandler("startFishing", function(fishingZoneId, banane)
    if banane then
        currentFishing = true
        local heading = Config.Peche.fishingZones[fishingZoneId].heading
        TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", GetEntityCoords(PlayerPedId()), heading, -1, false, true)
        ESX.ShowAdvancedNotification('Notification', 'Pêche', "Vous commencez à pecher...", 'CHAR_CALL911', 8)
        while currentFishing do
            Wait(1)
            DisableControlAction(0, 73, true)
        end
    end
end)

RegisterNetEvent("stopFishing")
AddEventHandler("stopFishing", function(message)
    if not currentFishing then return end
    if message then ESX.ShowAdvancedNotification('Notification', 'Pêche', message, 'CHAR_CALL911', 8) end
    currentFishing = false
    ClearPedTasksImmediately(PlayerPedId())
    local obj, dst = ESX.Game.GetClosestObject()
    local isFishingRod = (GetEntityModel(obj) == -1910604593)
    if isFishingRod then
        NetworkRequestControlOfEntity(obj)
        while not NetworkHasControlOfEntity(obj) do
            Wait(10)
        end
        SetEntityAsMissionEntity(obj, 0,0)
        DeleteEntity(obj)
    end
end)

Citizen.CreateThread(function()
    TriggerEvent(Config.ESX, function(obj)
        ESX = obj
    end)
    currentFishing = false

    while true do
        local interval = 250
        local playerPos = GetEntityCoords(PlayerPedId())
        if not currentFishing then
            for k,v in pairs(Config.Peche.fishingZones) do
                local zoneCenter = v.zoneCenter
                local dst = #(playerPos-zoneCenter)
                if dst <= v.radius then
                    interval = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer à pêcher dans cette zone")
                    if IsControlJustPressed(0, 51) then
                        currentFishing = true
                        TriggerServerEvent("startFishing", k)
                    end
                end
            end

            local vendorZone = Config.Peche.vendor.position
            local dst = #(playerPos-vendorZone)
            if dst <= 30.0 then
                interval = 0
                DrawMarker(22, vendorZone, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 45,110,185, 255, 55555, false, true, 2, false, false, false, false)
                if dst <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre tous vos poissons")
                    if IsControlJustPressed(0, 51) then
                        TriggerServerEvent("sellfishs")
                    end
                end
            end
        end
        Wait(interval)
    end
end)

--- BLIPS ---
Citizen.CreateThread(function()
	local PecheBlips = AddBlipForCoord(2073.23, 4554.31, 31.31)

	SetBlipSprite(PecheBlips, 480)
	SetBlipDisplay(PecheBlips, 4)
	SetBlipScale(PecheBlips, 0.65)
	SetBlipColour(PecheBlips, 38)
	SetBlipAsShortRange(PecheBlips, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName('[Métier Libre] Pêche')
	EndTextCommandSetBlipName(PecheBlips)
end)

Citizen.CreateThread(function()
	local vendeurBlips = AddBlipForCoord(-1158.7344970703, 4923.9272460938, 222.51731872559)

	SetBlipSprite(vendeurBlips, 480)
	SetBlipDisplay(vendeurBlips, 4)
	SetBlipScale(vendeurBlips, 0.65)
	SetBlipColour(vendeurBlips, 51)
	SetBlipAsShortRange(vendeurBlips, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName('[Métier Libre] Acheteur de poisson')
	EndTextCommandSetBlipName(vendeurBlips)
end) 