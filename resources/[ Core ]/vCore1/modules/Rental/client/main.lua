CreateThread(function()

    local LoadNPC = function(model, pos, heading)
        local model = GetHashKey(model)
        local ped = CreatePed(4, model, pos, heading, false, true)
    
        RequestModel(model)
    
        while not HasModelLoaded(model) do 
            Wait(1) 
        end
        
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    end

    local LoadBlips = function(name, pos, label)
        local blip = Game.Blip(name,
            {
                coords = pos,
                label = label,
                sprite = 280,
                color = 5,
            }
        );

        blip:Show()
    end

    Wait(5000)

    for key, infos in pairs(Config["Rental"]) do
        local RentalZone = Game.Zone("Rental".. key)
        local main_menu = RageUI.AddMenu("", "Location")

        LoadNPC(infos['pedmodel'], infos["PedPos"], infos["PedHeading"])
        LoadBlips("RentalZone" .. key, infos["PedPos"], infos["BlipLabel"])

        main_menu:IsVisible(function(Items)
            Items:Button(infos["CarLabel"], nil, {RightLabel = infos["Price"].. "~g~$"}, true, {
                onSelected = function()
                    TriggerServerEvent("vCore1:rental:spawnVehicle", key)
                end
            })
        end)
        RentalZone:Start(function()
            RentalZone:SetTimer(1000)
            RentalZone:SetCoords(infos["PedPos"])
        
            RentalZone:IsPlayerInRadius(5.0, function()
                RentalZone:SetTimer(0)
                
                RentalZone:IsPlayerInRadius(2.0, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la location")
        
                    RentalZone:KeyPressed("E", function()
                        main_menu:Toggle()
                    end)
        
                end, false, false)
        
            end, false, false)
        
            RentalZone:RadiusEvents(3.0, nil, function()
                main_menu:Close()
            end)
        end)
    end
end)