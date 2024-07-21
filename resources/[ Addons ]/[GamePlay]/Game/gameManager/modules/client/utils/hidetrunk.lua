local inTrunk = false

ESX = nil
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if inTrunk then
            local vehicle = GetEntityAttachedTo(PlayerPedId())
            if DoesEntityExist(vehicle) or not IsPedDeadOrDying(PlayerPedId()) or not IsPedFatallyInjured(PlayerPedId()) then
                local coords = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'boot'))
                SetEntityCollision(PlayerPedId(), false, false)
                DrawText3D(coords, '[E] pour quitter le coffre')
                SetTimecycleModifier('NG_blackout')

                if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                    SetEntityVisible(PlayerPedId(), false, false)
                else
                    if not IsEntityPlayingAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 3) then
                        loadDict('timetable@floyd@cryingonbed@base')
                        TaskPlayAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)

                        SetEntityVisible(PlayerPedId(), true, false)
                    end
                end
                if IsControlJustReleased(0, 38) and inTrunk then
                    SetCarBootOpen(vehicle)
                    SetEntityCollision(PlayerPedId(), true, true)
                    Wait(750)
                    inTrunk = false
                    DetachEntity(PlayerPedId(), true, true)
                    SetEntityVisible(PlayerPedId(), true, false)
                    ClearPedTasks(PlayerPedId())
                    SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
                    Wait(250)
                    SetVehicleDoorShut(vehicle, 5)
                    SetTimecycleModifier('')
                end
            else
                SetEntityCollision(PlayerPedId(), true, true)
                DetachEntity(PlayerPedId(), true, true)
                SetEntityVisible(PlayerPedId(), true, false)
                ClearPedTasks(PlayerPedId())
                SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
            end
        end
    end
end)   

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Citizen.CreateThread(function()
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while not NetworkIsSessionStarted() or ESX.GetPlayerData().job == nil do Wait(0) end
    while true do

        if (not IsInPVP) then
            local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 10.0, 0, 70)
            local lockStatus = GetVehicleDoorLockStatus(vehicle)
            if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle,-1)
            then
                local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
                if trunk ~= -1 then
                    local coords = GetWorldPositionOfEntityBone(vehicle, trunk)
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords, true) <= 1.5 then
                        if not inTrunk then
                            if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                                DrawText3D(coords, '[E] Se cacher\n[H] Ouvrir')
                                    if IsControlJustReleased(0, 74) then
                                        if lockStatus == 1 then 
                                            SetCarBootOpen(vehicle)
                                        elseif lockStatus == 2 then
                                            ESX.ShowAdvancedNotification('Notification', "Coffre", "Le véhicule est verrouillé", 'CHAR_CALL911', 8)
                                        end
                                    end
                            else
                                DrawText3D(coords, '[E] Se cacher\n[H] Fermer')
                                if IsControlJustReleased(0, 74) then
                                    SetVehicleDoorShut(vehicle, 5)
                                end
                            end
                        end
                        if IsControlJustReleased(0, 51) and not inTrunk then
                            local player = ESX.Game.GetClosestPlayer()
                            local playerPed = GetPlayerPed(player)
                            if not exports.Game:IsInPorter() and not exports.Game:IsInOtage() then
                                if lockStatus == 1 then
                                    if DoesEntityExist(playerPed) then
                                        if not IsEntityAttached(playerPed) or GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(PlayerPedId()), true) >= 5.0 then
                                            SetCarBootOpen(vehicle)
                                            Wait(350)
                                            AttachEntityToEntity(PlayerPedId(), vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
                                            loadDict('timetable@floyd@cryingonbed@base')
                                            TaskPlayAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
                                            Wait(50)
                                            inTrunk = true

                                            Wait(1500)
                                            SetVehicleDoorShut(vehicle, 5)
                                        else
                                            ESX.ShowAdvancedNotification('Notification', "Coffre", "Il y a déjà quelqu'un dans le coffre", 'CHAR_CALL911', 8)
                                        end
                                    end
                                elseif lockStatus == 2 then
                                    ESX.ShowAdvancedNotification('Notification', "Coffre", "Le véhicule est verrouillé", 'CHAR_CALL911', 8)
                                end
                            else
                                ESX.ShowAdvancedNotification('Notification', "Coffre", "Vous ne pouvez pas faire cela en etant porter", 'CHAR_CALL911', 8)
                            end
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

IsInTrunk = function()
	if inTrunk == true then
		return true
	else
		return false
	end
end

function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end