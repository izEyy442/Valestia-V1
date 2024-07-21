CreateThread(function()
    if Config.Item.Inventory ~= "ox_inventory" or not Config.Item.Unique or not Config.Item.Require then
        return
    end

    exports.ox_inventory:displayMetadata({
        lbPhoneNumber = "Phone number",
        lbFormattedNumber = "Formatted number",
        lbPhoneName = "Phone name",
    })

    function GetFirstNumber()
        local phones = exports.ox_inventory:Search("slots", Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone?.metadata?.lbPhoneNumber then
                return phone.metadata.lbPhoneNumber
            end
        end
    end

    function HasPhoneNumber(number)
        local phones = exports.ox_inventory:Search("slots", Config.Item.Name)
        if not phones then
            return false
        end

        for i = 1, #phones do
            local phone = phones[i]
            if phone?.metadata?.lbPhoneNumber == number then
                return true
            end
        end

        return false
    end

    exports("UsePhoneItem", function(_, slot)
        local number = slot.metadata?.lbPhoneNumber
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