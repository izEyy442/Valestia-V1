function GetCoreObject(framework, resourceName, callBack)
    -- ES_EXTENDED
    if framework == 1 then
        xpcall(function()
            callBack(exports[resourceName or 'es_extended']['getSharedObject']())
        end, function(error)
            CreateThread(function()
                local tries = 10
                local ESX
                while not ESX do
                    Wait(100)
                    TriggerEvent(Framework.ESX_SHARED_OBJECT, function(obj)
                        ESX = obj
                    end)
                    tries = tries - 1
                    if tries == 0 then
                        print("You forgot to change ESX shared object in config, please do it now or the script wont work properly.")
                        return
                    end
                end
                callBack(ESX)
            end)
        end)
    end

    -- QBCORE / custom
    if framework == 2 then
        xpcall(function()
            callBack(exports[resourceName or 'qb-core']['GetCoreObject']())
        end, function(error)
            xpcall(function()
                callBack(exports[resourceName or 'qb-core']['GetSharedObject']())
            end, function(error)
                CreateThread(function()
                    local tries = 10
                    local QBC
                    while not QBC do
                        Wait(100)
                        TriggerEvent(Framework.QBCORE_SHARED_OBJECT, function(obj)
                            QBC = obj
                        end)
                        tries = tries - 1
                        if tries == 0 then
                            print("You forgot to change QBC shared object in config, please do it now or the script wont work properly.")
                            return
                        end
                    end
                    callBack(QBC)
                end)
            end)
        end)
    end
end