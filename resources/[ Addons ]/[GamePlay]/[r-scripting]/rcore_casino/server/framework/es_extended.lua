if Framework.Active == 1 then
    ESX = nil
    GetCoreObject(Framework.Active, Framework.ES_EXTENDED_RESOURCE_NAME, function(object)
        ESX = object
    end)
end