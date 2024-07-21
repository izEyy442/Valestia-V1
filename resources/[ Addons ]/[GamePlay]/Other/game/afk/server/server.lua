local AfkTime = {}

ESX = nil
-- TriggerEvent(fInvest.ESXEvents, function(obj) ESX = obj end)
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('requteInvestTime')
AddEventHandler('requteInvestTime', function(result)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM `eInvest` WHERE `license` = @license', {
        ['@license'] = xPlayer.identifier
    }, function(result)
        if result[1] then
            if not AfkTime[xPlayer.source] then
                AfkTime[xPlayer.source] = {}
                AfkTime[xPlayer.source].time = result[1].time
                AfkTime[xPlayer.source].type = result[1].type
                TriggerClientEvent("requestClientAfkTime", xPlayer.source, AfkTime[xPlayer.source].time)
                if #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - fInvest.Position) < 150 then
                    SetEntityCoords(GetPlayerPed(xPlayer.source), fInvest.ReturnPosition)
                end
                --TriggerClientEvent("esx:showNotification", source,'Vous avez un investissement en cours.\nIl vous reste ~HUD_COLOUR_CONTROLLER_FRANKLIN~'..result[1].time..' minutes pour le finir.')
            end
        else
            AfkTime[xPlayer.source] = {}
            AfkTime[xPlayer.source].time = 0
            AfkTime[xPlayer.source].type = 0
            if #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - fInvest.Position) < 150 then
                TriggerClientEvent("esx:showNotification", source,'Vous êtes dans la zone Investissement alors que vous n\'avez pas d\'investissement.')
                SetEntityCoords(GetPlayerPed(xPlayer.source), fInvest.ReturnPosition)
            end
        end
    end)
end)

RegisterNetEvent('GoInvest')
AddEventHandler('GoInvest', function(result)
    local xPlayer = ESX.GetPlayerFromId(source)
    local type = result
    local time = fInvest.InvestReward[type].heures
    local argentdujoueurbank = xPlayer.getAccount('bank').money

    if argentdujoueurbank >= fInvest.InvestReward[type].invest then
        xPlayer.removeAccountMoney('bank', fInvest.InvestReward[type].invest)
        AfkTime[xPlayer.source].time = fInvest.InvestReward[type].heures*60
        AfkTime[xPlayer.source].type = type
        SetEntityCoords(GetPlayerPed(xPlayer.source), fInvest.Position)
        TriggerClientEvent("requestClientAfkTime", xPlayer.source, AfkTime[xPlayer.source].time)
        --TriggerClientEvent("esx:showNotification", source,'Tu as lancer un investissement pour gagner ~HUD_COLOUR_CONTROLLER_FRANKLIN~'..fInvest.InvestReward[type].reward..' pour ~HUD_COLOUR_CONTROLLER_FRANKLIN~'..fInvest.InvestReward[type].heures..' heures')
    elseif xPlayer.getAccount('bank').money >= fInvest.InvestReward[type].invest then
        xPlayer.removeAccountMoney('bank', fInvest.InvestReward[type].invest)
        AfkTime[xPlayer.source].time = fInvest.InvestReward[type].heures*60
        AfkTime[xPlayer.source].type = type
        SetEntityCoords(GetPlayerPed(xPlayer.source), fInvest.Position)
        TriggerClientEvent("requestClientAfkTime", xPlayer.source, AfkTime[xPlayer.source].time)
        --TriggerClientEvent("esx:showNotification", source,'Tu as lancer un investissement pour gagner ~HUD_COLOUR_CONTROLLER_FRANKLIN~'..fInvest.InvestReward[type].reward..' pour ~HUD_COLOUR_CONTROLLER_FRANKLIN~'..fInvest.InvestReward[type].heures..' heurs')
    else
        TriggerClientEvent("esx:showNotification", source,'Vous n\'avez pas l\'argent nécéssaire')
    end
end)

RegisterNetEvent('UpdateAfkTick')
AddEventHandler('UpdateAfkTick', function(result)
    local xPlayer = ESX.GetPlayerFromId(source)
    if AfkTime[xPlayer.source].time-1 == result then
        AfkTime[xPlayer.source].time = result
        TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
        TriggerClientEvent('esx_status:add', source, 'hunger', 1000000)
        if AfkTime[xPlayer.source].time == 0 then
            TriggerClientEvent("esx:showNotification", source,'Vous avez terminé votre investissement félication !\nVous avez gagner ~HUD_COLOUR_CONTROLLER_FRANKLIN~'..fInvest.InvestReward[AfkTime[xPlayer.source].type].reward..'$\n~HUD_COLOUR_CONTROLLER_FRANKLIN~/invest pour relancer un investissement')
            xPlayer.addAccountMoney('cash', fInvest.InvestReward[AfkTime[xPlayer.source].type].reward)
            MySQL.Async.execute('DELETE FROM eInvest WHERE `license` = @license', {
                ['@license'] = xPlayer.identifier
            })
            AfkTime[xPlayer.source] = {}
            TriggerClientEvent("requestClientAfkTime", xPlayer.source, 0)
            SetEntityCoords(GetPlayerPed(xPlayer.source), fInvest.ReturnPosition)
        end
    else
        xPlayer.ban(0, '(UpdateAfkTick)');
    end
end)

AddEventHandler('playerDropped', function (reason)
    local xPlayer = ESX.GetPlayerFromId(source);
    if (not xPlayer) then return; end
    if AfkTime[xPlayer.source] == nil then
        return
    else
        if AfkTime[xPlayer.source].time >= 1 then
            MySQL.Async.fetchAll('SELECT * FROM `eInvest` WHERE `license` = @license', {
                ['@license'] = xPlayer.identifier
            }, function(result)
                if result[1] then
                    MySQL.Async.execute('UPDATE eInvest SET time = @time, type = @type WHERE license = @license',{
                        ['@license'] = xPlayer.identifier,
                        ['@time'] = AfkTime[xPlayer.source].time,
                        ['@type'] = AfkTime[xPlayer.source].type,
                    })
                else
                    MySQL.Async.execute('INSERT INTO eInvest (license, time, type) VALUES (@license, @time, @type)', {
                        ['@license'] = xPlayer.identifier,
                        ['@time'] = AfkTime[xPlayer.source].time,
                        ['@type'] = AfkTime[xPlayer.source].type,
                    }, function()
                    end)
                end
            end)
        end
    end
end)