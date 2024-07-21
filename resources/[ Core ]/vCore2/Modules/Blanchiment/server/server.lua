ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local pass = false
RegisterServerEvent("Blanchiment")
AddEventHandler("Blanchiment", function(taux,minimal)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local sblackmoney = xPlayer.getAccount("dirtycash").money
    local transfere = sblackmoney - sblackmoney*taux/100
    local gang = xPlayer.job2.name
    local name1 = xPlayer.getFirstName()
    local name2 = xPlayer.getLastName()
    local ppos = GetEntityCoords(GetPlayerPed(src))
    for k,v in pairs (ConfigWashMoney.ConfigBlanchiment) do
        if #(v.pos - ppos) > 10 then
            return
        else
            pass = true
        end
    end
    if pass then
        if xPlayer ~= nil then 
            if sblackmoney >= minimal then 
                xPlayer.removeAccountMoney("dirtycash",sblackmoney)
                xPlayer.addAccountMoney("cash",transfere)
                xPlayer.showNotification("Vous avez blanchis ~r~ "..sblackmoney.."$ ~s~ pour ~g~"..transfere.."$")
                SendLogs("Blanchiment","Blanchiment","Minimal requis : **"..minimal.."$** \nTaux de blanchiment : **"..taux.."%**\n Nom RP du joueur : **".. name1.." "..name2.."**\n Groupe / gang du Joueur : **"..gang.."**\nLicense du joueur : **"..xPlayer.identifier.."**\nArgent Sale avant blanchiment : **"..sblackmoney.."$**\nArgent propre gagne : **"..transfere.."$**","https://discord.com/api/webhooks/1226975511440527481/AbacUmitQDy0wDTZE31ch252kpsBkXnmZINKelnaPAAk28fZ2kT9hFqdgQl0r7Ft5Amq")
                pass = false
            else
                xPlayer.showNotification("Vous ne pouvez pas blanchir en dessous de ~r~"..minimal.."$")
                pass = false
            end
        end
    else
        xPlayer.ban(0,"(Blanchiment)")
        pass = false
    end
end)

ESX.RegisterServerCallback("GetBlacKMoney",function(source,cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    cb(xPlayer.getAccount('dirtycash').money)
end)