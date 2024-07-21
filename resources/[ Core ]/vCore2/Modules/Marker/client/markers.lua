ESX = nil
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
        Citizen.Wait(100)
    end
    while ESX.GetPlayerData().job == nil do ---- Recherche du job du joueurs 
        Citizen.Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

ZonesListe = {
    ["Jetski"] = {
        Position = vector3(-1604.057, -1166.644, 1.365782),
        Public = true,
        Job = nil, 
        Job2 = nil, 
        Blip = {
            Name = "[Public] Location Jetski",
            Sprite = 471,
            Display = 4,
            Scale = 0.6,
            Color = 57
        },
        Action = function()
            MenuJetski()
        end
    },
    ["MenuSpawnScootBite"] = {
        Position = vector3(-415.98657226562, -2787.9643554688, 6.0003900527954),
        Public = false,
        Job = "postop", 
        Job2 = nil, 
        Blip = nil,
        Action = function()
            MenuSpawnScootBite()
        end
    },
    ["MenuDeleteScootBite"] = {
        Position = vector3(-408.22152709961, -2798.9208984375, 6.0003795623779), 
        Public = false,
        Job = "postop", 
        Job2 = nil, 
        Blip = nil,
        Action = function()
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if veh ~= nil then 
                DeleteEntity(veh) 
            end
        end
    },
}

CreateThread(function()
    for _,marker in pairs(ZonesListe) do
        if marker.Blip then
            local blip = AddBlipForCoord(marker.Position)

            SetBlipSprite(blip, marker.Blip.Sprite)
            SetBlipScale(blip, marker.Blip.Scale)
            SetBlipColour(blip, marker.Blip.Color)
            SetBlipDisplay(blip, marker.Blip.Display)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(marker.Blip.Name)
            EndTextCommandSetBlipName(blip)
        end
	end
end)

local inZone = false
local inZoneMarker = false

local interval = 750
local interval2 = 750
local interval3 = 750
local interval4 = 750
local interval5 = 750
local interval6 = 750
local interval7 = 750
local interval8 = 750
local interval9 = 750
local interval10 = 750

--- MenuJetski
CreateThread(function()
    while true do
        local pPed = PlayerPedId()
        local pc = GetEntityCoords(pPed)
        local mc = ZonesListe["Jetski"].Position
        local dif = #(mc - pc)
        --if ESX.PlayerData.job and ESX.PlayerData.job.name == "fib" then
            if dif > 6 then
                interval4 = 750
            else
                interval4 = 1
                if dif <= 1 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler a l'agent de location de ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~JetSki~w~.")
                    -- DrawMarker(2,mc.x,mc.y,mc.z,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.2,0.2,45,110,185,255,false,false,0,false,nil,nil,false)
                    if IsControlJustPressed(0, 51) then
                        MenuJetski()
                    end
                end
            end
        Wait(interval4)
    end
end)
