local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterUsableItem('bag', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('bag', 1)
    
    TriggerClientEvent('Backpack:CheckBag', source, HasBag)
    if not HasBag then
        TriggerEvent('Backpack:InsertBag', source)
    else
        TriggerClientEvent('esx:showNotification', source, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous avez déja un sac sur vous !')
    end
end)

ESX.RegisterServerCallback('Backpack:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)

ESX.RegisterServerCallback('Backpack:getBag', function(source, cb)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier

        MySQL.Async.fetchAll('SELECT * FROM owned_bags WHERE identifier = @identifier ',{["@identifier"] = identifier}, function(bag)

            if bag[1] ~= nil then
                MySQL.Async.fetchAll('SELECT * FROM owned_bag_inventory WHERE id = @id ',{["@id"] = bag[1].id}, function(inventory)
                cb({bag = bag, inventory = inventory})
                end)
            else
                cb(nil)
            end
    end)
end)

ESX.RegisterServerCallback('Backpack:getAllBags', function(source, cb)
    local src = source

    MySQL.Async.fetchAll('SELECT * FROM owned_bags', {}, function(bags)
       
        if bags[1] ~= nil then
            cb(bags)
        else
            cb(nil)
        end
    end)
end)


ESX.RegisterServerCallback('Backpack:getBagInventory', function(source, cb, BagId)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier

        MySQL.Async.fetchAll('SELECT * FROM owned_bag_inventory WHERE id = @id ',{["@id"] = BagId}, function(bag)
        cb(bag)
    end)
end)

RegisterServerEvent('Backpack:InsertBag')
AddEventHandler('Backpack:InsertBag', function(source)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
    local xPlayer = ESX.GetPlayerFromId(src)
    local xPlayers = ESX.GetPlayers()

    TriggerClientEvent('Backpack:GiveBag', src)
    for i=1, #xPlayers, 1 do
        TriggerClientEvent('Backpack:ReSync', xPlayers[i], id)
     end
    MySQL.Async.execute('INSERT INTO owned_bags (identifier, id, x, y, z) VALUES (@identifier, @id, @x, @y, @z)', {['@identifier'] = identifier,['@id']  = math.random(1, 100000), ['@x']  = nil, ['@y'] = nil, ['@y'] = nil})
end)

RegisterServerEvent('Backpack:TakeItem')
AddEventHandler('Backpack:TakeItem', function(id, item, count, type)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll('SELECT * FROM owned_bags WHERE id = @id ',{["@id"] = id}, function(bag)
        MySQL.Async.fetchAll('SELECT * FROM owned_bag_inventory WHERE id = @id AND item = @item ',{["@id"] = id, ["@item"] = item}, function(result)

            if result[1] ~= nil then
                if type == 'weapon' then
                    xPlayer.addWeapon(item, count)
                elseif type == 'item' then
                    xPlayer.addInventoryItem(item, count)
                end
                if result[1].count - count <= 0 then
                    MySQL.Async.execute('DELETE FROM owned_bag_inventory WHERE id = @id AND item = @item AND count = @count',{['@id'] = id,['@item'] = item, ['@count'] = count })
                else
                    MySQL.Async.execute('UPDATE owned_bag_inventory SET count = @count WHERE item = @item', {['@item'] = item, ['@count'] = result[1].count - count})
                end

            end
        end)
    end)
end)

RegisterServerEvent('Backpack:PutItem')
AddEventHandler('Backpack:PutItem', function(id, item, label, count, type)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = ESX.GetPlayerFromId(src).identifier
	local update
    local insert
    
    MySQL.Async.fetchAll('SELECT * FROM owned_bags WHERE identifier = @identifier ',{["@identifier"] = identifier}, function(bag)


    if type == 'weapon' then
        xPlayer.removeWeapon(item, count)
		MySQL.Async.execute('INSERT INTO owned_bag_inventory (id, label, item, count) VALUES (@id, @label, @item, @count)', {['@id'] = id,['@item']  = item, ['@label']  = label, ['@count'] = count})
    elseif type == 'item' and count < 50 then
        xPlayer.removeInventoryItem(item, count)
		MySQL.Async.fetchAll('SELECT * FROM owned_bag_inventory WHERE id = @id ',{["@id"] = id}, function(result)
			if result[1] ~= nil then
				for i=1, #result, 1 do
					if result[i].item == item then
						count = count + result[i].count
						update = 1
					elseif result[i].item ~= item then
						insert = 1
					end
				end
                    if update == 1 then
                        MySQL.Async.execute('UPDATE owned_bag_inventory SET count = @count WHERE item = @item', {['@item'] = item, ['@count'] = count})
                    elseif insert == 1 then
                        MySQL.Async.execute('INSERT INTO owned_bag_inventory (id, label, item, count) VALUES (@id, @label, @item, @count)', {['@id'] = id,['@item']  = item, ['@label']  = label, ['@count'] = count})
                    end
                    else
                        MySQL.Async.execute('INSERT INTO owned_bag_inventory (id, label, item, count) VALUES (@id, @label, @item, @count)', {['@id'] = id,['@item']  = item, ['@label']  = label, ['@count'] = count})
			        end
		        end)
        else
            TriggerClientEvent('esx:showNotification', src, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous pouvez seulement avoir 50 items différents dans votre sac')
        end
    end)
end)

RegisterServerEvent('Backpack:PickUpBag')
AddEventHandler('Backpack:PickUpBag', function(id)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier

    MySQL.Async.fetchAll('UPDATE owned_bags SET identifier = @identifier, x = @x, y = @y, z = @z WHERE id = @id', {['@identifier'] = identifier, ['@id'] = id, ['@x'] = nil, ['@y'] = nil, ['@z'] = nil})
    TriggerClientEvent('Backpack:SetOntoPlayer', src, id)
    TriggerClientEvent('Backpack:ReSync', -1, id)
end)

RegisterNetEvent("Backpack:SyncObjDeleted")
AddEventHandler("Backpack:SyncObjDeleted", function(list)
    for k,v in pairs(list) do
        local entity = NetworkGetEntityFromNetworkId(v)
        Citizen.InvokeNative(`DELETE_ENTITY` & 0xFFFFFFFF, entity)
    end
end)

RegisterServerEvent('Backpack:DropBag')
AddEventHandler('Backpack:DropBag', function(id, x, y, z)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier

    MySQL.Async.fetchAll('UPDATE owned_bags SET identifier = @identifier, x = @x, y = @y, z = @z WHERE id = @id', {['@identifier'] = nil, ['@id'] = id, ['@x'] = x, ['@y'] = y, ['@z'] = z})
    TriggerClientEvent('Backpack:ReSync', -1, id)
end)