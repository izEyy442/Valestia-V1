local needDisplayBag = false

RegisterNetEvent('sCore:cagoule')
AddEventHandler('sCore:cagoule', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 3.0 then
        ESX.ShowNotification('Aucun joueurs au alentours')
    else
        TriggerServerEvent('sCore:CagouletSet', GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent('sCore:CagouleSet')
AddEventHandler('sCore:CagouleSet', function()
    needDisplayBag = not needDisplayBag
    if needDisplayBag then 
        TriggerEvent('skinchanger:change', 'mask_1', 69)
        TriggerEvent('skinchanger:change', 'mask_2', 0)
    end
    while needDisplayBag do
        if not HasStreamedTextureDictLoaded('revolutionbag') then
            RequestStreamedTextureDict('revolutionbag')
            while not HasStreamedTextureDictLoaded('revolutionbag') do
                Citizen.Wait(50)
            end
        end

        DrawSprite('revolutionbag', 'headbag', 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
        Citizen.Wait(0)
    end
    SetStreamedTextureDictAsNoLongerNeeded('revolutionbag')
    TriggerEvent('skinchanger:change', 'mask_1', 0)
    TriggerEvent('skinchanger:change', 'mask_2', 0)
end)