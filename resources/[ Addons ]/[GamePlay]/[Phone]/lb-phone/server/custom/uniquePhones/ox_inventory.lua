CreateThread(function()
    if Config.Item.Inventory ~= "ox_inventory" or not Config.Item.Unique or not Config.Item.Require then
        return
    end

    ---Function to check if a player has a phone with a specific number
    ---@param source any
    ---@param phoneNumber string
    ---@return boolean
    function HasPhoneNumber(source, phoneNumber)
        debugprint("checking if " .. source .. " has a phone item with number", phoneNumber)
        local phones = exports.ox_inventory:Search(source, "slots", Config.Item.Name)
        if not phones then
            return false
        end

        for i = 1, #phones do
            if phones[i]?.metadata?.lbPhoneNumber == phoneNumber then
                debugprint("they do")
                return true
            end
        end
        return false
    end

    ---Function to set a phone number to a player's empty phone item
    ---@param source number
    ---@param phoneNumber string
    ---@return boolean success
    function SetPhoneNumber(source, phoneNumber)
        debugprint("setting phone number to", phoneNumber, "for", source)
        local phones = exports.ox_inventory:Search(source, "slots", Config.Item.Name)
        if not phones then
            return false
        end

        for i = 1, #phones do
            local phone = phones[i]
            if phone?.metadata?.lbPhoneNumber == nil then
                phone.metadata = {
                    lbPhoneNumber = phoneNumber,
                    lbFormattedNumber = FormatNumber(phoneNumber)
                }
                exports.ox_inventory:SetMetadata(source, phone.slot, phone.metadata)
                debugprint("set phone number to", phoneNumber, "for", source)
                return true
            end
        end

        return false
    end

    function SetItemName(source, phoneNumber, name)
        local phones = exports.ox_inventory:Search(source, "slots", Config.Item.Name)
        if not phones then
            return false
        end

        for i = 1, #phones do
            local phone = phones[i]
            if phone?.metadata?.lbPhoneNumber == phoneNumber then
                phone.metadata.lbPhoneName = name
                phone.metadata.lbFormattedNumber = FormatNumber(phoneNumber)
                exports.ox_inventory:SetMetadata(source, phone.slot, phone.metadata)
                return true
            end
        end

        return false
    end
end)