--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway

CreateThread(function()
    if _Config.clotheshop.showBlip then
        for _,value in pairs(_Config.clotheshop.positions.mainZone) do
            local blip = AddBlipForCoord(value.pos)
            SetBlipSprite(blip, _Config.clotheshop.positions.infoBlip.Sprite)
            SetBlipDisplay(blip, _Config.clotheshop.positions.infoBlip.Display)
            SetBlipScale(blip, _Config.clotheshop.positions.infoBlip.Scale)
            SetBlipColour(blip, _Config.clotheshop.positions.infoBlip.Color)
            SetBlipAsShortRange(blip, _Config.clotheshop.positions.infoBlip.Range)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(_Config.clotheshop.positions.infoBlip.Name)
            EndTextCommandSetBlipName(blip)
        end
    end

    while true do
        local interval = 750

        for _,v in pairs(_Config.clotheshop.positions.mainZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                -- DrawMarker(1,mc.x,mc.y,mc.z-3,0.0,0.0,0.0,0.0,0.0,0.0,3.0,3.0,3.0,45,110,185,255,true,false,0,true,nil,nil,false)
                DrawMarker(1, interactionPos.x, interactionPos.y, interactionPos.z-1.2, 0, 0, 0, _Config.markerGetter.Rotation, nil, nil, 2.5, 2.5, 0.9, _Config.markerGetter.Color[1], _Config.markerGetter.Color[2], _Config.markerGetter.Color[3], 220, 1, 1, 0, 0, nil, nil, 0)
            end
            if #(pCoords-interactionPos) < 2.0 then
                -- Draw3DText(interactionPos.x, interactionPos.y, interactionPos.z, "Appuyez sur [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~s~] pour vous changer.")
                ESX.ShowHelpNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Parcourir les Vetements~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(1, 51) then
                    TriggerServerEvent("shops:getVIP")
                    _Razzway:refreshData();
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        TriggerEvent("skinchanger:loadSkin", skin)
                    end)
                    Wait(180)
                    _Client.open:clothesMenu()
                end
            end
        end

        for _,v in pairs(_Config.clotheshop.positions.glassesZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                DrawMarker(_Config.miniMarkerGetter.Type, interactionPos.x, interactionPos.y, interactionPos.z-0.4, 0, 0, 0, _Config.miniMarkerGetter.Rotation, nil, nil, _Config.miniMarkerGetter.Size[1], _Config.miniMarkerGetter.Size[2], _Config.miniMarkerGetter.Size[3], _Config.miniMarkerGetter.Color[1], _Config.miniMarkerGetter.Color[2], _Config.miniMarkerGetter.Color[3], 270, 0, 1, 0, 0, nil, nil, 0)
            end
            if #(pCoords-interactionPos) < 1.0 then
                ESX.ShowHelpNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Parcourir les Lunettes~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(1, 51) then
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        TriggerEvent("skinchanger:loadSkin", skin)
                    end)
                    Wait(180)
                    _Client.open:glassesMenu()
                end
            end
        end

        for _,v in pairs(_Config.clotheshop.positions.helmetZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                DrawMarker(_Config.miniMarkerGetter.Type, interactionPos.x, interactionPos.y, interactionPos.z-0.4, 0, 0, 0, _Config.miniMarkerGetter.Rotation, nil, nil, _Config.miniMarkerGetter.Size[1], _Config.miniMarkerGetter.Size[2], _Config.miniMarkerGetter.Size[3], _Config.miniMarkerGetter.Color[1], _Config.miniMarkerGetter.Color[2], _Config.miniMarkerGetter.Color[3], 270, 0, 1, 0, 0, nil, nil, 0)
            end
            if #(pCoords-interactionPos) < 1.0 then
                ESX.ShowHelpNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Parcourir les Chapeau~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(1, 51) then
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        TriggerEvent("skinchanger:loadSkin", skin)
                    end)
                    Wait(180)
                    _Client.open:helmetMenu()
                end
            end
        end

        for _,v in pairs(_Config.clotheshop.positions.earsZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                DrawMarker(_Config.miniMarkerGetter.Type, interactionPos.x, interactionPos.y, interactionPos.z-0.4, 0, 0, 0, _Config.miniMarkerGetter.Rotation, nil, nil, _Config.miniMarkerGetter.Size[1], _Config.miniMarkerGetter.Size[2], _Config.miniMarkerGetter.Size[3], _Config.miniMarkerGetter.Color[1], _Config.miniMarkerGetter.Color[2], _Config.miniMarkerGetter.Color[3], 270, 0, 1, 0, 0, nil, nil, 0)
            end
            if #(pCoords-interactionPos) < 1.0 then
                ESX.ShowHelpNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Parcourir les Accesoire d\'Oreilles~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(1, 51) then
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        TriggerEvent("skinchanger:loadSkin", skin)
                    end)
                    Wait(180)
                    _Client.open:earsMenu()
                end
            end
        end

        for _,v in pairs(_Config.clotheshop.positions.chainZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                DrawMarker(_Config.miniMarkerGetter.Type, interactionPos.x, interactionPos.y, interactionPos.z-0.4, 0, 0, 0, _Config.miniMarkerGetter.Rotation, nil, nil, _Config.miniMarkerGetter.Size[1], _Config.miniMarkerGetter.Size[2], _Config.miniMarkerGetter.Size[3], _Config.miniMarkerGetter.Color[1], _Config.miniMarkerGetter.Color[2], _Config.miniMarkerGetter.Color[3], 270, 0, 1, 0, 0, nil, nil, 0)
            end
            if #(pCoords-interactionPos) < 1.0 then
                ESX.ShowHelpNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Parcourir les Chaines~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(1, 51) then
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        TriggerEvent("skinchanger:loadSkin", skin)
                    end)
                    Wait(180)
                    _Client.open:chainMenu()
                end
            end
        end

        Wait(interval)
    end
end)

RegisterNetEvent(_Prefix..':saveSkin')
AddEventHandler(_Prefix..':saveSkin', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end)