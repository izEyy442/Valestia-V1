ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("JailMenu:AntiMassJail")
AddEventHandler("JailMenu:AntiMassJail", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.ban(0, "(JailMenu:AntiMassJail)");
end)


RegisterServerEvent("JailMenu:JailPlayer")
AddEventHandler("JailMenu:JailPlayer", function(targetId, time, raison)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(targetId)

    if (xPlayer) then
        if xPlayer.getGroup() ~= "user" then
            MySQL.Async.fetchAll('SELECT 1 FROM jail WHERE identifier = @identifier', {
                ['@identifier'] = tPlayer.identifier
            },function(result)
                if result[1] then
                    xPlayer.showNotification("~r~Le joueur est déjà en prison~s~")
                else
                    TriggerClientEvent("jail:PutIn", targetId, time, raison)
                    SendLogs("Jail", "Valestia | Jail", "Le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) a été envoyé en prison pour **"..raison.."** avec **"..time.."** objet(s) par **"..xPlayer.name.."** (***"..xPlayer.identifier.."***)", "https://discord.com/api/webhooks/1226958627957641297/sUVfx5E1HfJySwWM6EFB4Ckxlkp_C1NbNINHYL0C2EY2AD-jIM4ycANch51QoONDZ98M")
                end
            end)
        else
            xPlayer.ban(0, "(JailMenu:JailPlayer)")
        end
    else
        local tPlayer = ESX.GetPlayerFromId(targetId)
        MySQL.Async.fetchAll('SELECT 1 FROM jail WHERE identifier = @identifier', {
            ['@identifier'] = tPlayer.identifier
        },function(result)
            if result[1] then
                print("Le joueur est déjà en prison")
            else
                TriggerClientEvent("jail:PutIn", targetId, time, raison)
                SendLogs("Jail", "Valestia | Jail", "Le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) a été envoyé en prison pour **"..raison.."** avec **"..time.."** objet(s) par **"..((xPlayer and xPlayer.name) or "Console").."** (***"..((xPlayer and xPlayer.identifier) or "CONSOLE:IDENTIFIER").."***)", "https://discord.com/api/webhooks/1226958627957641297/sUVfx5E1HfJySwWM6EFB4Ckxlkp_C1NbNINHYL0C2EY2AD-jIM4ycANch51QoONDZ98M")
            end
        end)
    end
end)