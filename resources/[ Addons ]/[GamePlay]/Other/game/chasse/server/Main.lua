ESX = nil
TriggerEvent("esx:getSharedObject", function(ViceESX) ESX = ViceESX end)

local playerChasse = {}

ESX.RegisterServerCallback("Chasse:check", function(source, cb, lastPos)
    if #(GetEntityCoords(GetPlayerPed(source))-lastPos) > 1.5 then  
        xPlayer.ban(0, '(Chasse:check)');
        return
    end
    if playerChasse[source] then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("Chasse:start", function(lastPos, chasse)
    local source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if #(GetEntityCoords(GetPlayerPed(source))-lastPos) > 15 then
            xPlayer.ban(0, '(Chasse:start)');
            return
        end
        playerChasse[source] = true
        itemName = string.upper("WEAPON_MUSKET")

        if xPlayer.hasWeapon(itemName) then
            TriggerClientEvent("esx:showNotification",source,"Vous ne pouvez pas prendre deux fois la même ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~arme~s~.")
        else
            xPlayer.addWeapon("WEAPON_MUSKET", 255)
        end
        TriggerClientEvent("Chasse:returnStart", source, chasse)
    end
end)

RegisterServerEvent("Chasse:stop")
AddEventHandler("Chasse:stop", function(message, lastPos, chasse)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if playerChasse[source] then
            xPlayer.removeWeapon("WEAPON_MUSKET", 0)
            playerChasse[source] = false
            TriggerClientEvent("Chasse:returnStop", source, chasse, message)
        end
    end
end)

AddEventHandler('playerDropped', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.removeWeapon("WEAPON_MUSKET", 0)
    end
end)

RegisterNetEvent("Chasse:addItem", function(itemName, count)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    for i = 1, #Chasse.Position[1].animal.model do

        if (Chasse.Position[1].animal.model[i].item == itemName) then
            if xPlayer then
                if playerChasse[source] then
                    if xPlayer.canCarryItem(itemName, tonumber(count)) then
                        TriggerClientEvent("esx:showNotification", source, "Bien, Vous avez ramassé ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x"..count.." viande~s~ !")
                        xPlayer.addInventoryItem(itemName, tonumber(count))
                    else
                        TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez de place sur vous pour récupérer la viande")
                    end
                else
                    xPlayer.ban(0, '(Chasse:addItem)');
                    return
                end
            end
            break;
        end

    end

end)