local main_menu = RageUI.AddMenu("", "Programmer votre GoFast")
local startZone = Game.Zone("goFastStart")
local endZone = Game.Zone("goFastEnd")
local goFastStarted = false

CreateThread(function()
    local model = GetHashKey("a_m_y_business_02")
	local ped = CreatePed(4, model, Config["GoFast"]["StartPos"], Config["GoFast"]["PedHeading"], false, true)

    RequestModel(model)

    while not HasModelLoaded(model) do 
        Wait(1) 
    end

    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true)
	
end)

local GoFastBlips = function()
    BlipsGoFast = AddBlipForCoord(Config["GoFast"]["EndPos"])
	
	SetBlipSprite(BlipsGoFast, 272)
	SetBlipScale(BlipsGoFast, 0.85)
	SetBlipColour(BlipsGoFast, 1)
	SetBlipAlpha(BlipsGoFast, 200)
	PulseBlip(BlipsGoFast)
	SetBlipRoute(BlipsGoFast,  true)

end

RegisterNetEvent('vCore1:gofast:sendalert', function(message, coords)
    if coords == nil then

        ESX.ShowNotification("Nous avons perdu la trace du suspect")
        RemoveBlip(blipToSuspect)

    elseif DoesBlipExist(blipToSuspect) then
        RemoveBlip(blipToSuspect)
    else

        ESX.ShowNotification(message)
        blipToSuspect = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blipToSuspect, 161)
        SetBlipScale(blipToSuspect, 2.0)
        SetBlipColour(blipToSuspect, 3)
        PulseBlip(blipToSuspect)

    end

end)

main_menu:IsVisible(function(Items)
    Items:Button("Réaliser un GoFast", nil, {}, true, {

        onSelected = function()
            TriggerServerEvent("vCore1:gofast:start")
            goFastStarted = true
        end

    })
	
end)


startZone:Start(function()
    startZone:SetTimer(1000)
    startZone:SetCoords(Config["GoFast"]["StartPos"])
    

    startZone:IsPlayerInRadius(5.0, function()
        startZone:SetTimer(0)
        
        startZone:IsPlayerInRadius(2.0, function()
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour programmer un GoFast")

            startZone:KeyPressed("E", function()
                main_menu:Toggle()
            end)

        end, false, false)

    end, false, false)

    startZone:RadiusEvents(3.0, nil, function()
        main_menu:Close()
    end)

end)

RegisterNetEvent('vCore1:gofast:startendzone', function()
    GoFastBlips()
    
    endZone:Start(function()

        if goFastStarted then

            endZone:SetTimer(1000)
            endZone:SetCoords(Config["GoFast"]["EndPos"])

            endZone:IsPlayerInRadius(60, function()
                endZone:SetTimer(0)
                endZone:Marker(nil, nil, 3.0)
                
                endZone:IsPlayerInRadius(3, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir du véhicule")

                    endZone:KeyPressed("E", function()
                        local ped = PlayerPedId()
                        local vehicle = GetVehiclePedIsIn(ped, false)
                        local vehiclePlate = GetVehicleNumberPlateText(vehicle)

                        TriggerServerEvent("vCore1:gofast:end", vehiclePlate)
                        TaskLeaveVehicle(ped, vehicle, 0)
                        goFastStarted = false
                    end)

                end, false, true)

            end, false, true)

        else
            RemoveBlip(BlipsGoFast)
            endZone:Stop()
        end

    end)

end)