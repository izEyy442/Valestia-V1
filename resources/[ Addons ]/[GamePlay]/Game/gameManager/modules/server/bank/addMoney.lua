---
--- @author Azagal
--- Create at [23/10/2022] 20:25:30
--- Current project [Valestia-V1]
--- File name [addMoney]
---

RegisterNetEvent("Bank:addMoney", function(money)
    local playerSrc = source

    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    if (xPlayer.getAccount("cash").money >= money) then
        xPlayer.removeAccountMoney("cash", money)
        xPlayer.addAccountMoney("bank", money)
        xPlayer.showNotification("Vous venez de deposer ~g~"..money.."$~s~ sur votre compte.")
    else
        xPlayer.showNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas cette somme sur vous.")
    end
end)