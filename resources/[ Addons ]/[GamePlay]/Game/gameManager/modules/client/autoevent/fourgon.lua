--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

local ObjTable = {}
local sended = false
local sound = GetSoundId()

function RemoveProp(id)
    local entity = id
    SetEntityAsMissionEntity(entity, true, true)
    
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
    
    if (DoesEntityExist(entity)) then 
        DeleteEntity(entity)
    end 
end

function removeBlips()
    --StopSound(GetSoundId())
    RemoveBlip(blip)
    for k,v in pairs(ObjTable) do
        RemoveProp(v)
    end
end

function moneyEvent(data, zone)
    sended = false
    Citizen.CreateThread(function()

        blip = AddBlipForCoord(zone)
        SetBlipSprite(blip, 616)
        SetBlipScale(blip, 0.5)
        SetBlipColour(blip, 1)
        
        ESX.ShowAdvancedNotification('Notification', 'Event', data.message, 'CHAR_KIRINSPECTEUR', 2)
        local pPed = PlayerPedId()
        local pCoords = GetEntityCoords(pPed)
        local dst = GetDistanceBetweenCoords(pCoords, zone, true)
        while dst > 150 do
            Wait(100)
            pPed = PlayerPedId()
            pCoords = GetEntityCoords(pPed)
            dst = GetDistanceBetweenCoords(pCoords, zone, true)
            if EventStop then return end
            if EventStop then break end
        end

        if not EventStop then
            local ped1Model = GetHashKey("s_m_m_armoured_01")
            local positionped1 = vector3(zone.x+math.random(-5.0,5.0), zone.y+math.random(-5.0,5.0), zone.z)
            local positionheading = math.random(20,90)
            RequestModel(ped1Model)
            while not HasModelLoaded(ped1Model) do 
                Citizen.Wait(10) 
            end
            ped1 = CreatePed(9, ped1Model, positionped1, 90, false, false)
            SetEntityAsMissionEntity(ped1, true,true)
            SetBlockingOfNonTemporaryEvents(ped1, true)
            SetEntityInvincible(ped1, true)
            ApplyPedDamagePack(ped1, "Fall", 100, 100);
            SetEntityHealth(ped1, 0.0)
            TaskStartScenarioInPlace(ped1, "WORLD_HUMAN_BINOCULARS", 0, true)
            Citizen.CreateThread(function()
                Citizen.Wait(2000)
                FreezeEntityPosition(ped1,true)
            end)
            table.insert(ObjTable, ped1)
            local ped2Model = GetHashKey("s_m_m_armoured_02")
            local positionped2 = vector3(zone.x+math.random(-20.0,20.0), zone.y+math.random(-5.0,5.0), zone.z)
            local positionheading2 = math.random(90,180)
            RequestModel(ped2Model)
            while not HasModelLoaded(ped2Model) do 
                Citizen.Wait(10) 
            end
            ped2 = CreatePed(9, ped2Model, positionped2, -80, false, false)
            SetEntityAsMissionEntity(ped2, true,true)
            SetBlockingOfNonTemporaryEvents(ped2, true)
            SetEntityInvincible(ped2, true)
            ApplyPedDamagePack(ped2, "Fall", 100, 100);
            SetEntityHealth(ped2, 0.0)
            Citizen.CreateThread(function()
                Citizen.Wait(2000)
                FreezeEntityPosition(ped2,true)
            end)
            TaskStartScenarioInPlace(ped2, "WORLD_VEHICLE_BIKER", 0, true)
            table.insert(ObjTable, ped2)
            local blinder = GetHashKey("stockade")
            RequestModel(blinder)
            while not HasModelLoaded(blinder) do Wait(10) end
            local veh = CreateVehicle(blinder, zone, math.random(0.0,180.0), 0, 0)
            TriggerEvent('persistent-vehicles/register-vehicle', veh)
            SetVehicleUndriveable(veh, 1)
            FreezeEntityPosition(veh, 1)
            SetVehicleAlarm(veh, 1)
            SetVehicleAlarmTimeLeft(veh, 999999.0*9999)
            for i = 1,9 do
                SetVehicleDoorOpen(veh, i, 0, 1)
            end
            table.insert(ObjTable, veh)

            local ArgentRecup = 0
            while ArgentRecup < 10 do
                Wait(1)
                local randomProp = data.prop[math.random(1, #data.prop)]
                RequestModel(GetHashKey(randomProp))
                while not HasModelLoaded(GetHashKey(randomProp)) do Wait(10) end
                local randomZone = vector3(zone.x+math.random(-8.0,8.0), zone.y+math.random(-8.0,8.0), zone.z)

                local obj = CreateObject(GetHashKey(randomProp), randomZone, 0, 0, 0)
                table.insert(ObjTable, obj)
                PlaceObjectOnGroundProperly(obj)
                FreezeEntityPosition(obj, 1)

                local oCoords = GetEntityCoords(obj)
                local dst = GetDistanceBetweenCoords(pCoords, oCoords, 0)
                while dst > 2.0 do
                    Wait(1)
                    pPed = PlayerPedId()
                    oCoords = GetEntityCoords(obj)
                    pCoords = GetEntityCoords(pPed)
                    dst = GetDistanceBetweenCoords(pCoords, oCoords, 0)
                    ESX.ShowHelpNotification("Récupérer l'argent")
                    if EventStop then return end
                    if EventStop then break end
                end

                if not EventStop then
                    PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 1)
                    ArgentRecup = ArgentRecup + 1
                    local nombre = math.random(500,1263)
                    ESX.ShowAdvancedNotification('Notification', "Event", "Vous venez de gagnez "..nombre.."~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~$", 'CHAR_CALL911', 8)
                    TriggerServerEvent("RS_AUTOEVENT:GetArgent", nombre)
                    RemoveProp(obj)
                    if EventStop then return end
                    if EventStop then break end
                end

                if ArgentRecup >= 10 then
                    TriggerServerEvent("RS_AUTOEVENT:Recuperer")
                    StopSound(sound)
                    sended = true
                    for k,v in pairs(ObjTable) do
                        RemoveProp(v)
                    end
                    break
                end
                if EventStop then 
                    ArgentRecup = 99 break 
                end
            end

            if not sended then
                StopSound(sound)
                TriggerServerEvent("RS_AUTOEVENT:Recuperer")
                sended = true
            end
            StopSound(sound)
            ESX.ShowAdvancedNotification('Notification', 'Event', "Cargaison récupérée!", 'CHAR_KIRINSPECTEUR', 2)
            PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
        end
        for k,v in pairs(ObjTable) do
            RemoveProp(v)
        end
        ObjTable = {}
        RemoveBlip(blip)
    end)
end

function deleteEntityExists(entity)
    if entity ~= nil then DeleteEntity(entity) end 
end