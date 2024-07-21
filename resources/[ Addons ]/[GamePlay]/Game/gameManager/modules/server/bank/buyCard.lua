---
--- @author Azagal
--- Create at [23/10/2022] 20:25:41
--- Current project [Valestia-V1]
--- File name [buyCard]
---

RegisterNetEvent("Bank:buyCard", function()
    local playerSrc = source

    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    local cardPrice = 2000
    local hasCard = xPlayer.getInventoryItem("cb")
    if (hasCard == nil or hasCard.count == 0) then
        if (cardPrice <= xPlayer.getAccount("cash").money) then
            xPlayer.addInventoryItem("cb", 1)
            xPlayer.removeAccountMoney("cash", cardPrice)
            TriggerClientEvent("esx:showNotification", playerSrc, "Vous avez reçu votre ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~carte bancaire~s~.")
        else
            TriggerClientEvent("esx:showNotification", playerSrc, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas assez d'argent sur vous.")
        end
    else
        print("PLAYER ["..GetPlayerName(playerSrc).." ("..playerSrc..")] => Tried to cheat.")
    end
end)