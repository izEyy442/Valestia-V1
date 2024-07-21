CreateThread(function()
    if Config.Item.Inventory ~= "core_inventory" or not Config.Item.Unique or not Config.Item.Require then
        return
    end

    if Config.Framework == 'qb' then
        QB = exports['qb-core']:GetCoreObject()
    elseif Config.Framework == 'esx' then
        export, ESX = pcall(function()
            return exports.es_extended:getSharedObject()
        end)
        if not export then
            while not ESX do
                TriggerEvent("esx:getSharedObject", function(obj)
                    ESX = obj
                end)
                Wait(500)
            end
        end
    end

    local function GetItemsByName(name)
        local inventory = {}
        local items = {}
        local callEnd = false

        if Config.Framework == 'qb' then
            QB.Functions.TriggerCallback('core_inventory:server:getInventory', function(inv)
                inventory = inv
                for _, item in pairs(inventory) do
                    if item.name == name then
                        items[#items + 1] = item
                    end
                end
                callEnd = true
            end)
        elseif Config.Framework == 'esx' then
            debugprint('get item by name', name)
            ESX.TriggerServerCallback('core_inventory:server:getInventory', function(inv)
                inventory = inv
                for _, item in pairs(inventory) do
                    if item.name == name then
                        items[#items + 1] = item
                    end
                end
                callEnd = true
            end)
        end
        while not callEnd do
            Wait(10)
        end
        debugprint('call end')
        for i, v in ipairs(items) do
            debugprint(i, v)
        end
        debugprint('return')
        return items
    end

    function GetFirstNumber()
        local phones = GetItemsByName(Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone.metadata.lbPhoneNumber then
                return phone.metadata.lbPhoneNumber
            end
        end
    end

    function HasPhoneNumber(number)
        local phones = GetItemsByName(Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone.metadata.lbPhoneNumber == number then
                return true
            end
        end
        return false
    end

    RegisterNetEvent("lb-phone:usePhoneItem", function(data)
        debugprint('use item', data)
        local number = data.metadata.lbPhoneNumber
        if number == nil then debugprint('trigger generate') TriggerEvent('lb-phone:generatePhoneNumber') end
        if number ~= currentPhone or number == nil then
            debugprint('Set phone client', number, currentPhone)
            SetPhone(number, true)
        end

        ToggleOpen(not phoneOpen)
    end)

    RegisterNetEvent("lb-phone:itemRemoved", function()
        Wait(500)
        if currentPhone and not HasPhoneItem(currentPhone) and Config.Item.Unique then
            SetPhone()
        end
    end)

    local waitingAdded = false
    RegisterNetEvent("lb-phone:itemAdded", function()
        Wait(500)
        if currentPhone or waitingAdded then
            return
        end

        waitingAdded = true
        local firstNumber = GetFirstNumber()
        SetPhone(firstNumber, true)
        waitingAdded = false
    end)
end)