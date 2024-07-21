---
--- @author Azagal
--- Create at [23/10/2022] 20:25:36
--- Current project [Valestia-V1]
--- File name [removeMoney]
---

RegisterNetEvent("Bank:removeMoney", function(money)
    local playerSrc = source

    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    if (xPlayer.getAccount("bank").money >= money) then
        xPlayer.removeAccountMoney("bank", money)
        xPlayer.addAccountMoney("cash", money)
        xPlayer.showNotification("Vous venez de retiré ~g~"..money.."$~s~ de votre compte.")
    else
        xPlayer.showNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas cette somme dans votre compte bancaire.")
    end
end)