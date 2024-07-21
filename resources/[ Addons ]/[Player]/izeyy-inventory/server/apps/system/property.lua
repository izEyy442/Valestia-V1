InProperty = {}


RegisterServerCallback("izeyy:getChestProperty", function(source, cb, id)   
    local xPlayer = GetPlayerFromId(source)
    local dataProperty = dataFromProperty(source, id)


    cb(dataProperty)
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("lgd_inv:TableActuProperty")
AddEventHandler("lgd_inv:TableActuProperty", function(id, bool)
    print(id, bool)
    if bool then
        if not InProperty[id] then
            InProperty[id] = {} 
        end
        table.insert(InProperty[id], source)
    else
        if InProperty[id] then
            for i, existingSource in ipairs(InProperty[id]) do
                if existingSource == source then
                    print(existingSource)
                    table.remove(InProperty[id], i)
                    break 
                end
            end
        end
    end
end)

function RefreshProperty(player)
    for id, sources in pairs(InProperty) do
        for _, source in ipairs(sources) do
            TriggerClientEvent("lgd_inv:ActuInProperty", source, id)
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------


RegisterNetEvent("izey:actionProperty")
AddEventHandler("izey:actionProperty", function(type, data)
    action_Property[data.type][type](source, data)
    RefreshProperty()
end)




