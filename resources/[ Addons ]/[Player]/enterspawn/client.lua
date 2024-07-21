ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

AddEventHandler('esx:playerLoaded', function()
    CreateThread(function()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            if skin ~= nil then
                StartConnect()
            end
        end)
    end)
end)

local playerSpawned = false

function StartConnect()
    SendNUIMessage({ type = "SET_SHOW_ATH", show = false }) 
    
    SendNUIMessage({
        action = "showConnexion",
    })
    SetNuiFocus(true, true)
    TriggerScreenblurFadeIn(0)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityVisible(PlayerPedId(), false, 0)
    CameraConnect = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamCoord(CameraConnect, 911.05352783203, 40.92586517334, 120.77506256104)
    SetCamRot(CameraConnect, 0.0, 0.0, 250.9906311035156)
    SetCamFov(CameraConnect, 90.97)
    ShakeCam(CameraConnect, "HAND_SHAKE", 0.2)
    SetCamActive(CameraConnect, true)
    RenderScriptCams(true, false, 2000, true, true)
    DisplayRadar(false)

end

function ValidateConnect()
    local pPed = PlayerPedId()
    SetNuiFocus(false, false)
    Wait(1000)
    DoScreenFadeOut(1500)
    Wait(2000)
    RenderScriptCams(false, false, 0, true, true)
    Wait(1000)
    FreezeEntityPosition(pPed, false)
    SetEntityVisible(pPed, true, 0)
    TriggerScreenblurFadeOut(2000)
    Wait(1000)
    DoScreenFadeIn(2000)
    Wait(1000)
    DisplayRadar(true)
    playerLoaded = true

    
    SendNUIMessage({ type = "SET_SHOW_ATH", show = true })
    
end


RegisterNuiCallback("CloseUI", function()
    ValidateConnect()
    ESX.ShowNotification("Bon retour parmi nous sur ValestiaRP")
end)

exports('playerLoaded', function()
    return playerLoaded
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    playerLoaded = true
end)