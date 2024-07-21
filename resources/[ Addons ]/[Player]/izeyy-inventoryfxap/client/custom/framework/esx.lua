--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end


if Config.esxVersion == 'new' then
	ESX = exports['es_extended']:getSharedObject()
elseif Config.esxVersion == 'old' then
    ESX = nil
    while not ESX do
        TriggerEvent(Config.Trigger["getSharedObject"], function(obj)
            ESX = obj
        end)
        Wait(500)
    end
end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    PlayerLoaded = true
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)



function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function GetPlayerIdentifier()
	return ESX.GetPlayerData().identifier
end

function GetClosestPlayer()
	return ESX.Game.GetClosestPlayer()
end

function GetClosestVehicle(coords)
	return ESX.Game.GetClosestVehicle(coords)
end

 

function SendTextMessage(msg, type)
    if type == 'inform' then 
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    end
    if type == 'error' then 
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    end
    if type == 'success' then 
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    end
end

function ShowHelpNotification(msg)
	AddTextEntry('HelpNotification', msg)
	BeginTextCommandDisplayHelp('HelpNotification')
	EndTextCommandDisplayHelp(0, false, true, -1)
end
    
function DrawText3D(x, y, z, text)
	SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

AddEventHandler('onClientResourceStart', function (resourceName)
    if(GetCurrentResourceName() == resourceName) then
        ESX = exports['es_extended']:getSharedObject()
        PlayerData = ESX.GetPlayerData()
        PlayerLoaded = true
    end
end)