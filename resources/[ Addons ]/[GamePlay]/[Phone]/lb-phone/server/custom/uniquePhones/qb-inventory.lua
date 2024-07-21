CreateThread(function()
    if (Config.Item.Inventory ~= "qb-inventory" and Config.Item.Inventory ~= "lj-inventory") or not Config.Item.Unique or not Config.Item.Require then
        return
    end

    local QB = exports["qb-core"]:GetCoreObject()

    ---Function to get all items a player has with a specific name
    ---@param source number
    ---@param name string
    ---@return table items
    local function GetItemsByName(source, name)
        local inventory = QB.Functions.GetPlayer(source).PlayerData.items
        local items = {}
        for _, item in pairs(inventory) do
            if item?.name == name then
                items[#items+1] = item
            end
        end

        return items
    end

    ---Function to check if a player has a phone with a specific number
    ---@param source any
    ---@param phoneNumber string
    ---@return boolean
    function HasPhoneNumber(source, phoneNumber)
        debugprint("checking if " .. source .. " has a phone item with number", phoneNumber)
        local phones = GetItemsByName(source, Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone?.info?.lbPhoneNumber == phoneNumber then
                debugprint("they do")
                return true
            end
        end
        debugprint("they do not")
        return false
    end

    ---Function to set a phone number to a player's empty phone item
    ---@param source number
    ---@param phoneNumber string
    ---@return boolean success
    function SetPhoneNumber(source, phoneNumber)
        local qPlayer = QB.Functions.GetPlayer(source)
        local items = qPlayer.PlayerData.items
        for i = 1, #items do
            local item = items[i]
            if item and item.name == Config.Item.Name and item.info.lbPhoneNumber == nil then
                item.info.lbPhoneNumber = phoneNumber
                item.info.lbFormattedNumber = FormatNumber(phoneNumber)
                qPlayer.Functions.SetInventory(items, true)
                return true
            end
        end
        return false
    end

    function SetItemName(source, phoneNumber, name)
        local qPlayer = QB.Functions.GetPlayer(source)
        local items = qPlayer.PlayerData.items
        for i = 1, #items do
            local item = items[i]
            if item and item.name == Config.Item.Name and item.info.lbPhoneNumber == phoneNumber then
                item.info.lbPhoneName = name
                item.info.lbFormattedNumber = FormatNumber(phoneNumber)
                qPlayer.Functions.SetInventory(items, true)
                return true
            end
        end
    end

    QB.Functions.CreateUseableItem(Config.Item.Name, function(source, item)
        if item then
            TriggerClientEvent("lb-phone:usePhoneItem", source, item)
        end
    end)
end)