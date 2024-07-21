local main_menu = RageUI.AddMenu("", "Faire ses papiers")
local paperZone = Game.Zone("identityPaper")

CreateThread(function()
    local model = GetHashKey("a_f_y_business_01")
	local ped = CreatePed(4, model, Config["IdentityPapers"]["Ped"], Config["IdentityPapers"]["PedHeading"], false, true)

    RequestModel(model)

    while not HasModelLoaded(model) do 
        Wait(1) 
    end

    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
	
end)

main_menu:IsVisible(function(Items)
    Items:Button("Faire une demande d'identité", nil, {RightLabel = ""..Config["IdentityPapers"]["Price"].."~g~$"}, true, {
        onSelected = function()
            TriggerServerEvent("vCore1:identitypapers:request")
        end
    })
end)

paperZone:Start(function()
    paperZone:SetTimer(1000)
    paperZone:SetCoords(Config["IdentityPapers"]["Ped"])

    paperZone:IsPlayerInRadius(10.0, function()
        paperZone:SetTimer(0)
        
        paperZone:IsPlayerInRadius(5.0, function()
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler à la dame")

            paperZone:KeyPressed("E", function()
                main_menu:Toggle()
            end)

        end, false, false)

    end, false, false)

    paperZone:RadiusEvents(5.0, nil, function()
        main_menu:Close()
    end)

end)
