--[[
  This file is part of Silky RolePlay.
  Copyright (c) Silky RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

--------- PED & BLIPS -----------

-- First Locate --
DecorRegister("Parachute", 4)
pedHashP = "cs_fbisuit_01"
zoneP = vector3(424.97, 5614.0, 766.52)
HeadingP = 279.04
PedP = nil
HeadingSpawnP = 315.00

Citizen.CreateThread(function()
    local blipP = AddBlipForCoord(zoneP)
    SetBlipSprite(blipP, 94)
    SetBlipScale(blipP, 0.6)
    SetBlipShrink(blipP, true)
    SetBlipColour(blipP, 2)
    SetBlipAsShortRange(blipP, true)

    BeginTextCommandSetBlipName('STRING') 
    AddTextComponentString("[Activité] Saut en Parachute")
    EndTextCommandSetBlipName(blipP)
end)


function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end

--------- MAIN -----------
local locationspara = {
    vector3(424.97, 5614.0, 765.52),
}

local paraachat = {}

function OpenParachuteMenu()
    local mainMenu = RageUI.CreateMenu('', 'Faites vos achats')
    local payer = RageUI.CreateSubMenu(mainMenu, "", "Faites vos achats")

    mainMenu.Closed = function()
        open = false
        table.remove(paraachat, k)
    end

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        Wait(1)
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Parachute", "Achetez un parachute", {RightLabel = "138$/u"}, true, {}, payer)
            table.insert(paraachat, {
                label = "Parachute",
            })
        end)
        RageUI.IsVisible(payer, function()
            RageUI.Button("Panier: 1 parachute", nil, {RightLabel = "138$"}, true , {
            })
            RageUI.Button("Payer en liquide", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent('parachute:payer', 'cash')
                    table.remove(paraachat, k)
                    RageUI.CloseAll()
                    TriggerServerEvent('SilkyPass:taskCountAdd:standart', 7, 1)
                end
            })
            RageUI.Button("Payer en carte", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent('parachute:payer', 'bank')
                    RageUI.CloseAll()
                    TriggerServerEvent('SilkyPass:taskCountAdd:standart', 7, 1)
                end
            })
        end)
        if not RageUI.Visible(mainMenu) and not RageUI.Visible(payer) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local interval = 500
        for k,v in pairs(locationspara) do
            local coPlayer = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(coPlayer.x, coPlayer.y, coPlayer.z, v.x, v.y, v.z)
            if dist <= 20 then
                if dist <= 5 then
                    DrawMarker(6, v.x, v.y, v.z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 128, 255, 170, 0, 0, 0, 1, nil, nil, 0)
                    ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                    if IsControlJustPressed(0, 51) then
                        OpenParachuteMenu()
                    end
                end
                interval = 1
            end
        end
        Citizen.Wait(interval)
    end
end)

RegisterNetEvent('addPara')
AddEventHandler('addPara', function(xPlayer)

end)

RegisterNetEvent('removePara')
AddEventHandler('removePara', function(source)
    for k,v in pairs(paraachat) do
        table.remove(paraachat, k)
    end
end)