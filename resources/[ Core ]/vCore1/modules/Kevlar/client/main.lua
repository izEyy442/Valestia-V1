local Kevlared = false

local function Ragdoll(timer)
    local ragdoll = true

    SetTimeout(timer, function()
        ragdoll = false
    end)

    CreateThread(function()
        while ragdoll do
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
            ResetPedRagdollTimer(PlayerPedId())
            Wait(1)
        end
    end)
end

AddEventHandler("entityDamaged", function(player)
    local ped = PlayerPedId()

    if player == ped then
        
        if GetPedArmour(ped) ~= 0 then
            Kevlared = true
        elseif GetPedArmour(ped) <= 0 and Kevlared then
            ESX.ShowNotification("Votre Kevlar c'est briser")
            ClearTimecycleModifier()
            SetTimecycleModifier("hud_def_blur")
            Ragdoll(3000)
            SetTimeout(3000, function()
                ClearTimecycleModifier()
                TriggerServerEvent("vCore1:kevlar:remove")
                SetEntityMaxSpeed(ped, 10.0)
                Kevlared = false
            end)
        elseif GetPedArmour(ped) <= 25 and Kevlared then
            SetEntityMaxSpeed(ped, 6.0)
        elseif GetPedArmour(ped) <= 50 and Kevlared then
            SetEntityMaxSpeed(ped, 5.0)
        end

    end
end)

RegisterNetEvent("vCore1:kevlar:add", function(speed)
    local player = PlayerPedId()

    ExecuteCommand("me est en train de s'équiper d'un kevlar")

    ESX.Streaming.RequestAnimDict('clothingshirt', function()
        TaskPlayAnim(player, 'clothingshirt', 'try_shirt_positive_d', 8.0, -8, -1, 49, 0, 0, 0, 0)
        Citizen.Wait(4000)
        ClearPedSecondaryTask(player)
    end)

    SetEntityMaxSpeed(player, speed)
    Kevlared = true
end)

RegisterNetEvent("vCore1:kevlar:removetoclient", function()
    SetEntityMaxSpeed(PlayerPedId(), 10.0)
    Kevlared = false
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local armour = GetPedArmour(ped)
        if armour > 10 then
            TriggerServerEvent("vCore1:kevlar:verif")
        end
        Wait(10000)
    end
end)