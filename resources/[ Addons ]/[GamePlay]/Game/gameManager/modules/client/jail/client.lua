--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]


--- todo fix les false ban causé au unjail d'un player "jail:finish" 

ESX = nil
local isPlayerinJail = false
local jailStay = 0
local JailStayX = 0
local hasAPointToDo = false
local Choosen = nil
local motif

Pos = {
    {nb=1, x=958.21423339844, y=20.67241859436, z=116.16419219971},
    {nb=2, x=953.43096923828, y=26.38981628418, z=116.16419219971},
    {nb=3, x=949.82434082031, y=18.502368927002, z=116.16419219971},
    {nb=4, x=944.48028564453, y=23.027687072754, z=116.16412353516},
    {nb=5, x=939.89825439453, y=16.231126785278, z=116.16412353516},
    {nb=6, x=945.65606689453, y=9.7647037506104, z=116.16416168213},
    {nb=7, x=935.06243896484, y=7.3377795219421, z=116.16422271729},
    {nb=8, x=945.59594726562, y=-0.55837523937225, z=116.1636505127}
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    while ESX.GetPlayerData()['job'] == nil do
        Citizen.Wait(100)
    end
    TriggerServerEvent('jail:onConnecting')
end)


RegisterNetEvent('jail:PutIn')
AddEventHandler('jail:PutIn', function(jailNb, reason)
    isPlayerinJail = true
    exports['izeyy-inventory']:lockInventory(true)
    jailStay = tonumber(jailNb)
    JailStayX = jailStay
    motif = reason
    TriggerServerEvent('jail:SetInJail', jailStay, reason)
    beInJail()
    SetEntityCoords(PlayerPedId(), vector3(956.63323974609, 24.14598274231, 116.16425323486))
    TriggerEvent('vCore3:Valestia:pvpModeUpdated', true)
end)

RegisterNetEvent('jail:PutInBack')
AddEventHandler('jail:PutInBack', function(jailNb, reason)
    isPlayerinJail = true
    exports['izeyy-inventory']:lockInventory(true)
    jailStay = tonumber(jailNb)
    JailStayX = jailStay
    motif = reason
    TriggerServerEvent('jail:SetInJailBack', jailStay)
    beInJail()
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), vector3(956.63323974609, 24.14598274231, 116.16425323486))
    TriggerEvent('vCore3:Valestia:pvpModeUpdated', true)
end)

RegisterNetEvent('jail:UnPut')
AddEventHandler('jail:UnPut', function()
    isPlayerinJail = false
    exports['izeyy-inventory']:lockInventory(false)
    jailStay = 0
    TriggerServerEvent('jail:updateState', jailStay)
    Citizen.Wait(500)
    TriggerServerEvent('jail:remove', JailStayX)
    SetEntityInvincible(PlayerPedId(), false)
    RageUI.CloseAll()
    TriggerEvent('vCore3:Valestia:pvpModeUpdated', false)
end)

RegisterNetEvent('jail:finishAll')
AddEventHandler('jail:finishAll', function()
    isPlayerinJail = false
    exports['izeyy-inventory']:lockInventory(false)
    SetEntityCoords(PlayerPedId(), vector3(259.21295166016, -782.92779541016, 30.516191482544))
    SetEntityInvincible(PlayerPedId(), false)
    RageUI.CloseAll()
    TriggerEvent('vCore3:Valestia:pvpModeUpdated', false)
end)

beInJail = function()
    Citizen.CreateThread(function()
        local mainMenu = RageUI.CreateMenu("", "Faite vos Taches pour etre liberé")

        RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

        while jailStay > 0 do
            SetEntityInvincible(PlayerPedId(), true)

            RageUI.IsVisible(mainMenu, function()
                RageUI.Separator("ID : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()))
                RageUI.Separator("Raison Du Jail : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..motif)
                RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..jailStay.."~s~ : Taches Restante")
                RageUI.Line()
                RageUI.Button("~s~Se réanimer", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('vCore1:ambulance:jailRevive')
                        ClearPedTasks(PlayerPedId())
                    end
                })
            end)
            if not RageUI.Visible(mainMenu) and not isPlayerinJail then
                mainMenu = RMenu:DeleteType(mainMenu, true)
            end
            if not RageUI.Visible(mainMenu) and isPlayerinJail then
                RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
            end

            local coords = GetEntityCoords(PlayerPedId())
            if #(coords - vector3(956.63323974609, 24.14598274231, 116.16425323486)) > 100 then
                SetEntityCoords(PlayerPedId(), vector3(956.63323974609, 24.14598274231, 116.16425323486))
            end
            if not hasAPointToDo then
                for k,v in pairs(Pos) do
                    local nb = math.random(1, 8)
                    if v.nb == nb then
                        if not hasAPointToDo and Choosen ~= v.nb then
                            hasAPointToDo = true
                            x,y,z = v.x, v.y, v.z
                            CurrentBlip = AddBlipForCoord(v.x, v.y, v.z)
                            SetBlipRoute(CurrentBlip, 11)
                            Choosen = v.nb
                        end
                    end
                end
            end
            if hasAPointToDo then
                local coords = GetEntityCoords(PlayerPedId())
                if #(coords - vector3(x,y,z)) < 1.5 then
                    -- ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour réaliser votre tâche")
                    if IsControlJustPressed(0, 51) then
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BUM_WASH", -1, false)
                        Citizen.Wait(5000)
                        ClearPedTasksImmediately(PlayerPedId())
                        hasAPointToDo = false
                        jailStay = jailStay - 1
                        JailStayX = jailStay
                        TriggerServerEvent('jail:removeTask', jailStay)
                        RemoveBlip(CurrentBlip)
                    end
                end
                DrawMarker(20, x,y,z, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, 0.4, 0.4, 0.4, 45,110,185, 170, 0, 1, 0, 0, nil, nil, 0)
            end
            Citizen.Wait(0)
        end
        Citizen.Wait(1000)
        RemoveBlip(CurrentBlip)
        TriggerServerEvent('jail:finish')
        ESX.ShowNotification("Tes libre j'espere pas que tu reviendra")
    end)
end

Citizen.CreateThread(function()
	while true do
        if isPlayerinJail then
		    TriggerServerEvent('jail:HealPlayer')
        end
		Citizen.Wait(15000)
    end
end)

isInJail = function()
	if isPlayerinJail == true then
		return true
	else
		return false
	end
end