RegisterNetEvent('vCore1:maskshop:pay', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config["MaskShop"]["Price"]

    if (xPlayer) then

        if xPlayer.getAccount('cash').money >= price then
            xPlayer.removeAccountMoney('cash', price)
            xPlayer.showNotification("Vous avez payer "..price.." ~g~$")
        else
            xPlayer.showNotification("Vous n'avez pas assez d'argent sur vous")
        end
        
    end
end)