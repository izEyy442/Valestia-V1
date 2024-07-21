VehicleTrunk = VehicleTrunk or {}
VehicleTrunk.List = {}

CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM trunk_inventory", {
    }, function(results)
        for i = 1, #results do
            local result = results[i]
            result.items = json.decode(result.items)
            
            if (result ~= nil) then
                local createdTrunk
                if (VehicleTrunk.List[result.vehiclePlate] == nil) then
                    createdTrunk = VehicleTrunk:new(result.vehicleModel, result.vehiclePlate, true, true)
                end

                while (createdTrunk == nil) do
                    Wait(500)
                end

                for i = 1, #result.items do
                    local item = result.items[i]
                    if (item ~= nil) then
                        createdTrunk:addItem(item.type, item.name, item.count)
                    end
                end
            end
        end
    end)
end)

function VehicleTrunk.GetTrunkFromPlate(vehPlate)
    return VehicleTrunk.List[vehPlate]
end

function VehicleTrunk:new(model, plate, hasOwner, isCreated)
    local newTrunk = {}
    setmetatable(newTrunk, self)
    self.__index = self

    newTrunk.model = tonumber(model)
    newTrunk.plate = tostring(plate)
    newTrunk.hasOwner = hasOwner or false

    if (hasOwner == true and isCreated == false) then
        MySQL.Async.execute('INSERT INTO trunk_inventory (vehicleModel, vehiclePlate, items) VALUES (@vehicleModel, @vehiclePlate, @items)', {
            vehicleModel = model,
            vehiclePlate = plate,
            items = json.encode({})
        })
    end

    newTrunk.inTrunk = nil
    newTrunk.stash = {}

    VehicleTrunk.List[plate] = newTrunk
    return newTrunk
end

function VehicleTrunk:getModel()
    return self.model
end

function VehicleTrunk:getPlate()
    return self.plate
end

function VehicleTrunk:vehicleIsOwned()
    return self.hasOwner
end

function VehicleTrunk:getMaxWeight()
    local vehicleModel = self:getModel()
    if (vehicleModel) then
        return VehicleTrunk.Config["maxWeight"][vehicleModel] or 150.0
    end
end

function VehicleTrunk:getCurrentWeight()
    local trunkWeight = 0
    local vehStash = self.stash
    for i = 1, #vehStash do
        local selectedItem = vehStash[i]
        if (selectedItem ~= nil) then
            local itemData = ESX.GetItem(selectedItem.name) or {weight = VehicleTrunk.Config.weapons[selectedItem.name]}
            if (itemData ~= nil) then
                if (itemData.weight == nil) then
                    return
                end
                trunkWeight = trunkWeight + (selectedItem.count * itemData.weight)
            end
        end
    end
    return trunkWeight
end

function VehicleTrunk:canCarry(itemType, item, count)
    local selectedItem
    if (itemType == "standard") then
        selectedItem = ESX.GetItem(item)
    elseif (itemType == "weapon") then
        selectedItem = {
            weight = VehicleTrunk.Config.weapons[item]
        }
    end

    if (selectedItem ~= nil) then
        if (selectedItem.weight == nil) then
            return false
        end

        local addWeight = count * selectedItem.weight
        if (addWeight ~= nil) then
            local resultWeight = self:getCurrentWeight() + addWeight
            if (resultWeight > self:getMaxWeight()) then
                return false
            else
                return true
            end
        end
    end
end

function VehicleTrunk:getItemIndex(type, name)
    local vehStash = self.stash
    for i = 1, #vehStash do
        local selectedItem = vehStash[i]
        if (selectedItem ~= nil and selectedItem.type == type and selectedItem.name == name) then
            return i
        end
    end
end

function VehicleTrunk:addItem(itemType, name, count, callback)
    if (not self:canCarry(itemType, name, count)) then
        return
    end

    local itemValues = ESX.GetItem(name) or { label = ESX.GetWeaponLabel(name) }
    if (not itemValues) then
        return
    end

    local itemIndex = self:getItemIndex(itemType, name)
    if (itemIndex ~= nil) then
        local itemData = self.stash[itemIndex]
        itemData.count = itemData.count + count
    else
        table.insert(self.stash, {
            type = itemType,
            name = name,
            label = itemValues.label,
            count = count
        })
    end

    self:save();

    if (callback ~= nil and type(callback) == "function") then
        callback(true)
    end
end

function VehicleTrunk:removeItem(itemType, name, count, callback)
    local itemIndex = self:getItemIndex(itemType, name)
    if (itemIndex ~= nil) then
        local itemData = self.stash[itemIndex]

        if (count > itemData.count) then
            return
        end

        local resultCount = itemData.count - count
        if (resultCount < 1) then
            table.remove(self.stash, itemIndex)
        else
            itemData.count = itemData.count - count
        end

        self:save();

        if (callback ~= nil and type(callback) == "function") then
            callback(true)
        end
    end
end

function VehicleTrunk:open(playerSrc, entityId)
    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    if (self.inTrunk == nil) then
        local entityCoords = GetEntityCoords(NetworkGetEntityFromNetworkId(entityId))
        local playerCoords = GetEntityCoords(GetPlayerPed(playerSrc))

        if (#(playerCoords-entityCoords) > 10.0) then
            return
        end

        self.inTrunk = playerSrc
        TriggerClientEvent("VehicleTrunk:openMenu", playerSrc, {
            plate = self:getPlate(),
            stash = self.stash,
            maxWeight = self:getMaxWeight(),
            currentWeight = self:getCurrentWeight()
        })
    else
        if (self.inTrunk == playerSrc) then
            self.inTrunk = nil
            TriggerClientEvent("VehicleTrunk:updateData", playerSrc, nil)
        else
            local entityCoords = GetEntityCoords(NetworkGetEntityFromNetworkId(entityId))
            local lastPlayerCoords = GetEntityCoords(GetPlayerPed(self.inTrunk))
            if (ESX.GetPlayerFromId(self.inTrunk) == nil or #(lastPlayerCoords-entityCoords) > 5.0) then
                local playerCoords = GetEntityCoords(GetPlayerPed(playerSrc))
                if (#(playerCoords-entityCoords) > 5.0) then
                    return
                end

                TriggerClientEvent("VehicleTrunk:updateData", self.inTrunk, nil)
                self.inTrunk = playerSrc
                TriggerClientEvent("VehicleTrunk:openMenu", playerSrc, {
                    plate = self:getPlate(),
                    stash = self.stash,
                    maxWeight = self:getMaxWeight(),
                    currentWeight = self:getCurrentWeight()
                })
            else
                TriggerClientEvent("esx:showNotification", playerSrc, "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Une autre personne regarde déjà dans le coffre.")
            end
        end
    end
end


function VehicleTrunk:refreshForPlayer(playerSrc)
    TriggerClientEvent("VehicleTrunk:updateData", playerSrc, {
        plate = self:getPlate(),
        stash = self.stash,
        maxWeight = self:getMaxWeight(),
        currentWeight = self:getCurrentWeight()
    })
end

function VehicleTrunk:save()
    if (self:vehicleIsOwned()) then
        MySQL.Async.execute('UPDATE trunk_inventory SET items = @items WHERE vehiclePlate = @plate', {
            plate = tostring(self:getPlate()),
            items = json.encode(self.stash)
        })
    end
end