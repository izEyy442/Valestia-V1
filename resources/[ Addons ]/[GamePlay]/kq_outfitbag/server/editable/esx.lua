if Config.esxSettings.enabled then
    ESX = nil
    
    if Config.esxSettings.useNewESXExport then
        ESX = exports['es_extended']:getSharedObject()
    else
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end

    ESX.RegisterUsableItem(Config.bagItem, function(source)
        TriggerClientEvent('kq_outfitbag:placeBag', source, Config.bagItem)
    end)

    for k, item in pairs(Config.additionalItems) do
        ESX.RegisterUsableItem(item, function(source)
            TriggerClientEvent('kq_outfitbag:placeBag', source, item)
        end)
    end

    function RemoveBagItem(player, item)
        if item ~= Config.bagItem and not Contains(Config.additionalItems, item) then
            return
        end

        local xPlayer = ESX.GetPlayerFromId(player)
        xPlayer.removeInventoryItem(item, 1)
    end

    function PickupBag(player, item)
        if item ~= Config.bagItem and not Contains(Config.additionalItems, item) then
            return
        end

        local xPlayer = ESX.GetPlayerFromId(player)
        xPlayer.addInventoryItem(item, 1)
    end

    function GetDBPlayerOutfits(player)
        local identifier = _GetPlayerIdentifier(player)

        local result = MySQL.Sync.fetchAll("SELECT * FROM kq_extra WHERE `tag` = @tag AND `player` = @player ORDER BY `created_at`", {
            ['@tag'] = dbTag,
            ['@player'] = identifier,
        })

        return result
    end

    function SaveOutfit(player, outfit)
        local identifier = _GetPlayerIdentifier(player)

        local Query = "INSERT INTO kq_extra (`player`, `tag`, `data`) VALUES(@player, @tag, @data);"
        MySQL.Sync.insert(Query, {
            ['@player'] = identifier,
            ['@tag'] = dbTag,
            ['@data'] = json.encode(outfit),
        })
    end

    function DeleteOutfit(player, outfitId)
        local identifier = _GetPlayerIdentifier(player)

        local Query = "DELETE FROM kq_extra WHERE `player` = @player AND `tag` = @tag AND `id` = @id;"
        MySQL.Sync.execute(Query, {
            ['@player'] = identifier,
            ['@tag'] = dbTag,
            ['@id'] = outfitId,
        })
    end


    function _GetPlayerIdentifier(player)
        local xPlayer = ESX.GetPlayerFromId(player)

        return xPlayer.identifier
    end
end
