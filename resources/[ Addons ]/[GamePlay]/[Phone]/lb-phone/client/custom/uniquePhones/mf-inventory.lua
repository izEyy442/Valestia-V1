CreateThread(function()
    if Config.Item.Inventory ~= "mf-inventory" or not Config.Item.Unique or not Config.Item.Require or Config.Framework ~= "esx" then
        return
    end

    local ESX = exports["es_extended"]:getSharedObject()

    local function GetItemsByName(name)
        local items = {}
        local inventory = {}
        local promise = promise.new()
        exports["mf-inventory"]:getInventoryItems(ESX.GetPlayerData().identifier, function(data)
            inventory = data
            promise:resolve()
        end)
        Citizen.Await(promise)
        for _, item in pairs(inventory) do
            if item?.name == name then
                items[#items+1] = item
            end
        end
        return items
    end

    function GetFirstNumber()
        local phones = GetItemsByName(Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone?.metadata?["Phone Number"] then
                return phone.metadata["Phone Number"]
            end
        end
    end

    function HasPhoneNumber(number)
        local phones = GetItemsByName(Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone?.metadata?["Phone Number"] == number then
                return true
            end
        end
        return false
    end

    RegisterNetEvent("lb-phone:usePhoneItem", function(data)
        local number = data.metadata["Phone Number"]
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