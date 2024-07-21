CreateThread(function()
    if Config.Item.Inventory ~= "qs-inventory" or not Config.Item.Unique or not Config.Item.Require then
        return
    end

    local ESX, QBCore
    if Config.Framework == "esx" then
        ESX = exports['es_extended']:getSharedObject()
    elseif Config.Framework == "qb" then
        QBCore = exports["qb-core"]:GetCoreObject()
    end

    local function GetItemsByName(name)
        if Config.Framework == "esx" then
            local items = {}
            local inventory = ESX.GetPlayerData().inventory
            for _, item in pairs(inventory) do
                if item?.name == name then
                    items[#items+1] = item
                end
            end
            return items
        elseif Config.Framework == "qb" then
            local items = {}
            local inventory = QBCore.Functions.GetPlayerData().items
            for _, item in pairs(inventory) do
                if item?.name == name then
                    items[#items+1] = item
                end
            end
            return items
        end
    end

    function GetFirstNumber()
        local phones = GetItemsByName(Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone?.info?.lbPhoneNumber then
                return phone.info.lbPhoneNumber
            end
        end
    end

    function HasPhoneNumber(number)
        local phones = GetItemsByName(Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone?.info?.lbPhoneNumber == number then
                return true
            end
        end
        return false
    end

    RegisterNetEvent("lb-phone:usePhoneItem", function(data)
        local number = data.info?.lbPhoneNumber
        if number ~= currentPhone or number == nil then
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