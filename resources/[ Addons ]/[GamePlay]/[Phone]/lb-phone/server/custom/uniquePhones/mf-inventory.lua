CreateThread(function()
    if Config.Item.Inventory ~= "mf-inventory" or not Config.Item.Unique or not Config.Item.Require or Config.Framework ~= "esx" then
        return
    end

    local export, ESX = pcall(function()
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

    ---Function to get all items a player has with a specific name
    ---@param source number
    ---@param name string
    ---@return table items
    local function GetItemsByName(source, name)
        local inventory = exports["mf-inventory"]:getInventoryItems(ESX.GetPlayerFromId(source).identifier)
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
            if phone?.metadata?["Phone Number"] == phoneNumber then
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
        debugprint("setting phone number to", phoneNumber, "for", source)
        local qPlayer = ESX.GetPlayerFromId(source)
        local items = exports["mf-inventory"]:getInventoryItems(qPlayer.identifier)
        for i = 1, #items do
            local item = items[i]
            if item and item.name == Config.Item.Name and item.metadata["Phone Number"] == nil then
                item.metadata["Phone Number"] = phoneNumber
                item.metadata["Formatted Number"] = FormatNumber(phoneNumber)
                exports["mf-inventory"]:setItemProperty(qPlayer.identifier,item.slot,"metadata",item.metadata)
                debugprint("set phone number to", phoneNumber, "for", source)
                return true
            end
        end
        return false
    end

    function SetItemName(source, phoneNumber, name)
        local qPlayer = ESX.GetPlayerFromId(source)
        local items = exports["mf-inventory"]:getInventoryItems(qPlayer.identifier)
        for i = 1, #items do
            local item = items[i]
            if item and item.name == Config.Item.Name and item.metadata["Phone Number"] == phoneNumber then
                item.metadata["Phone name"] = name
                item.metadata["Formatted Number"] = FormatNumber(phoneNumber)
                exports["mf-inventory"]:setItemProperty(qPlayer.identifier,item.slot,"metadata",item.metadata)
                return true
            end
        end
    end

    ESX.RegisterUsableItem(Config.Item.Name, function(source,itemName,remove,item)
        if item then
            TriggerClientEvent("lb-phone:usePhoneItem", source, item)
        end
    end)
end)