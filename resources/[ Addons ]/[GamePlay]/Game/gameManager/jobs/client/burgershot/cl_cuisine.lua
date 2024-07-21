local open = false 
local tacosMain5 = RageUI.CreateMenu('', 'Interaction')
tacosMain5.Display.Header = true 
tacosMain5.Closed = function()
    open = false
end

RegisterNetEvent("burgershot:OpenMenuPreparation", function()
    if open then
        open = false
        RageUI.Visible(tacosMain5, false)
        return
    else
        open = true
        RageUI.Visible(tacosMain5, true)
        CreateThread(function()
            while open do
              RageUI.IsVisible(tacosMain5,function()
                local playerData = ESX.GetPlayerData()
                local job = playerData.job.name
                if job == 'burgershot' then
                    RageUI.Separator("↓ BurgerShot ↓")
                    RageUI.Button("Préparer un Burger Classique", "Requis : Pain + Steak Haché + Garnitures", {RightLabel = "→→"}, true , {
                        onSelected = function()
                            local playerPed = PlayerPedId()
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BBQ', 0, true)
                            Citizen.Wait(6500)
                            TriggerServerEvent('burgershot:brugerclassique')
                            ClearPedTasksImmediately(playerPed)
                        end
                    })
                else
                    RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'êtes pas ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Concessionnaire Bateau]~s~")
                    return
                end
              end)
              Citizen.Wait(0)
            end
        end)
    end
end)