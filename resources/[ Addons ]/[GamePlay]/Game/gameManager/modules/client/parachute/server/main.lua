--[[
  This file is part of Silky RolePlay.
  Copyright (c) Silky RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

RegisterServerEvent('parachute:payer')
AddEventHandler('parachute:payer', function(type)
    local price = 138
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if type == 'cash' then
        if xPlayer.getAccount('cash').money >= price then
            if xPlayer.hasWeapon('GADGET_PARACHUTE') then
                TriggerClientEvent('esx:showNotification', source, "Vous avez déjà un parachute.")
            else       
                if (xPlayer.canCarryItem('GADGET_PARACHUTE', 1)) then        
                    xPlayer.removeAccountMoney('cash', price)
                    xPlayer.addWeapon('GADGET_PARACHUTE', 42)
                else
                    xPlayer.showNotification("~r~Vous n'avez pas de place sur vous !")
                end
            end
        else
            xPlayer.showNotification("~r~Vous n'avez pas assez d'argent !");
        end
    elseif type == 'bank' then
        if xPlayer.getAccount('bank').money >= price then
            if xPlayer.hasWeapon('GADGET_PARACHUTE') then
                TriggerClientEvent('esx:showNotification', source, "Vous avez déjà un parachute.")
                TriggerClientEvent('shops:removeBank', source)
            else
                if (xPlayer.canCarryItem('GADGET_PARACHUTE', 1)) then
                    xPlayer.removeAccountMoney('bank', price)
                    xPlayer.addWeapon('GADGET_PARACHUTE', 42)
                    TriggerClientEvent('addPara', source)
                    TriggerClientEvent('removePara', source)
                else
                    xPlayer.showNotification("~r~Vous n'avez pas de place sur vous !")
                end
            end
        else
            xPlayer.showNotification("~r~Vous n'avez pas assez d'argent !");
        end
    end
end)