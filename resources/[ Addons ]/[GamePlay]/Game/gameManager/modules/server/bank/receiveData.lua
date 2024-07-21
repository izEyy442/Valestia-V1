---
--- @author iZeyy
--- Create at [13/13/2023] 03:51:31
--- Current project [Valestia-V1]
--- File name [receiveData]
---

AddEventHandler('esx:playerLoaded', function(source)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer) then

		TriggerClientEvent("izeyy:bankMenu:receiveData", source, xPlayer.getFirstName(), xPlayer.getLastName())
        
    end
    
end)