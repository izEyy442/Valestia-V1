if Config.qbSettings.enabled then

    local sqlDriver = Config.qbSettings.sqlDriver

    if Config.qbSettings.useNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end

    QBCore.Functions.CreateUseableItem(Config.bagItem, function(source)
        TriggerClientEvent('kq_outfitbag:placeBag', source, Config.bagItem)
    end)

    for k, item in pairs(Config.additionalItems) do
        QBCore.Functions.CreateUseableItem(item, function(source)
            TriggerClientEvent('kq_outfitbag:placeBag', source, item)
        end)
    end

    function RemoveBagItem(player, item)
        if item ~= Config.bagItem and not Contains(Config.additionalItems, item) then
            return
        end
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        xPlayer.Functions.RemoveItem(item, 1)
    end

    function PickupBag(player, item)
        if item ~= Config.bagItem and not Contains(Config.additionalItems, item) then
            return
        end

        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        xPlayer.Functions.AddItem(item, 1)
    end

    function GetDBPlayerOutfits(player)
        local identifier = _GetPlayerIdentifier(player)

        local query = 'SELECT * FROM kq_extra WHERE `tag` = @tag AND `player` = @player ORDER BY `created_at`'
        local data = {
            ['@tag'] = dbTag,
            ['@player'] = identifier,
        }

        if sqlDriver == 'oxmysql' then
            if Config.qbSettings.oldOxmysql then
                return exports[sqlDriver]:fetchSync(query, data)
            end
            return exports[sqlDriver]:query_async(query, data)
        else
            local result = exports[sqlDriver]:executeSync(query, data)
            return result
        end
    end

    function SaveOutfit(player, outfit)
        local identifier = _GetPlayerIdentifier(player)

        local query = 'INSERT INTO kq_extra (`player`, `tag`, `data`) VALUES(@player, @tag, @data);'
        local data = {
            ['@player'] = identifier,
            ['@tag'] = dbTag,
            ['@data'] = json.encode(outfit),
        }

        if sqlDriver == 'oxmysql' then
            exports[sqlDriver]:insertSync(query, data)
        else
            exports[sqlDriver]:executeSync(query, data)
        end
    end

    function DeleteOutfit(player, outfitId)
        local identifier = _GetPlayerIdentifier(player)

        local query = 'DELETE FROM kq_extra WHERE `player` = @player AND `tag` = @tag AND `id` = @id;'
        local data = {
            ['@player'] = identifier,
            ['@tag'] = dbTag,
            ['@id'] = outfitId,
        }

        if sqlDriver == 'oxmysql' then
            exports[sqlDriver]:updateSync(query, data)
        else
            exports[sqlDriver]:executeSync(query, data)
        end
    end



    function _GetPlayerIdentifier(player)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))

        return xPlayer.PlayerData.citizenid
    end
end
