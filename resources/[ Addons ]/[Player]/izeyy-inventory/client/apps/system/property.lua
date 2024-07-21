local Property = {}
dataProperty = {}
function setPropertyData(id)

    TriggerServerCallback("izeyy:getChestProperty", function(data)
        Property.items = {}
        weight = data.weight
        maxWeight = data.maxWeight
        accounts = data.accounts
        items = data.items
        weapons = data.weapons
        clothes = data.clothes

        SendNUIMessage(
            {
                action = "trunk:WeightBarText",
                weightTrunk = tonumber(weight),
                maxWeightTrunk = tonumber(maxWeight),
                textTrunk = '', 
                plate = Locales[Config.Language]['property_name'].. id
            }
        )


        if Config.ActiveAccount then
            if accounts ~= nil then 
                for key, value in pairs(accounts) do
                    if tonumber(value.count) > 0 then
                        accountData = {
                            label = Config.AccountTrunkName[value.name],
                            count = value.count,
                            limit = 0,
                            type = "item_account",
                            name = value.name,
                            image = Config.Pictures[value.name],
                            canRemove = false,
                            usable = false,
                            rare = false,
                            property = id
                        }
                        table.insert(Property.items, accountData)
                    end
                end
            end
        end

        if items ~= nil then 
            for key, value in pairs(items) do
                itemsData = {
                    label = value.label,
                    count = value.count,
                    limit = 0,
                    type = "item_standard",
                    name = value.name,
                    image = Config.Pictures[value.name],
                    canRemove = false,
                    usable = false,
                    rare = false,
                    property = id
                }
                table.insert(Property.items, itemsData)
            end
        end

        if weapons ~= nil then 
            for key, value in pairs(weapons) do
                weaponData = {
                    label = value.label,
                    count = 1,
                    limit = 0,
                    type = "item_weapon",
                    name = value.name,
                    image = Config.Pictures[value.name],
                    canRemove = false,
                    usable = false,
                    rare = false,
                    property = id
                }
                table.insert(Property.items, weaponData)
            end
        end

        if clothes ~= nil then 
            for key, value in pairs(clothes) do
                clothesData = {
                    label = value.label,
                    count = 1,
                    limit = 0,
                    type = "item_vetement",
                    name = value.name,
                    image = Config.Pictures[value.name],
                    id = value.id,
                    canRemove = false,
                    usable = false,
                    rare = false,
                    property = id
                }
                table.insert(Property.items, clothesData)
            end
        end



        SendNUIMessage(
            {
                action = "setSecondInventoryItems",
                itemList = Property.items
            }
        )
    end, id)
end




function RefreshProperty(idProperty)
    Property.items = {}
    setPropertyData(idProperty)

    loadPlayerInventory('trunk', nil, true, true)
end


RegisterNetEvent("lgd_inv:ActuInProperty")
AddEventHandler("lgd_inv:ActuInProperty", function(idProperty)
    Property.items = {}
    setPropertyData(idProperty)

    loadPlayerInventory('trunk', nil, true, true)
end)




OpenPropertyChest = function(idProperty)
    Inv.isInProperty = true

    DisplayRadar(false)
    SetNuiFocus(true, true)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerServerEvent('lgd_inv:TableActuProperty', idProperty, true)

    Wait(100)
    setPropertyData(idProperty)

    loadPlayerInventory('trunk', nil, true, true)

    SendNUIMessage(
        {
            action = "open:Inv",
            type = "property"
        }
    )

    SetTimecycleModifier("Bloom")
    SetTimecycleModifierStrength(1.50)
    Inventaire:hideHUD()
    CreatePedScreen(true)
    TriggerScreenblurFadeIn(0)

end

exports("openProperty", function(idProperty)
    dataProperty = {
        id = idProperty
    }
    OpenPropertyChest(idProperty)
end)

RegisterCommand('property_chest', function()
    if not Inv.inventoryLock then -- for export inventoryLock
        if not Inv.isInInventory and not Inv.isInTrunk and not Inv.isInProperty then 
            dataProperty = {
                id = 1
            }
            OpenPropertyChest(1)
        end
    end
end)


RegisterNUICallback("PutIntoProperty", function(data, cb)
    if IsPedRagdoll(PlayerPedId()) then
        NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
        return
    end

    if data.item.type == 'item_vetement' then
        item = {
            idProperty = data.item.property,
            name = data.item.id,
            label = data.item.label,
            weight = Config.ClothesWeight[data.item.name],
            type = 'clothe'
        }
        TriggerServerEvent("izey:actionProperty", 'deposit', item)

    elseif data.item.type == "item_standard" then
        KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
            if result ~= nil then
                if tonumber(result) then
                    item = {
                        idProperty = data.item.property,
                        name = data.item.name,
                        label = data.item.label,
                        weight = data.item.weight,
                        count = result,
                        type = 'item'
                    }
                    TriggerServerEvent("izey:actionProperty", 'deposit', item)
                end
            end
        end);
    elseif data.item.type == "item_weapon" then
        if not Config.WeaponWeight[data.item.name] then 
            weight = Config.WeaponDefaultWeight 
        else
            weight = Config.WeaponWeight[data.item.name]
        end
        item = {
            idProperty = data.item.property,
            name = data.item.name,
            label = data.item.label,
            weight = weight,
            type = 'weapon'
        }
        TriggerServerEvent("izey:actionProperty", 'deposit', item)
    elseif data.item.type == "item_account" then
        KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
            if result ~= nil then
                if tonumber(result) then
                    item = {
                        idProperty = data.item.property,
                        name = data.item.name,
                        label = data.item.label,
                        count = result,
                        type = 'account'
                    }
                    TriggerServerEvent("izey:actionProperty", 'deposit', item)
                end
            end
        end);
    end

    cb("ok")
end)

RegisterNUICallback("TakeFromProperty", function(data, cb)
    if IsPedRagdoll(PlayerPedId()) then
        NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
        return
    end

    if data.item.type == 'item_vetement' then
        item = {
            idProperty = data.item.property,
            name = data.item.id,
            label = data.item.label,
            weight = Config.ClothesWeight[data.item.name],
            type = 'clothe'
        }
        TriggerServerEvent("izey:actionProperty", 'remove', item)

    elseif data.item.type == "item_standard" then
        KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
            if result ~= nil then
                if tonumber(result) then
                    item = {
                        idProperty = data.item.property,
                        name = data.item.name,
                        label = data.item.label,
                        weight = data.item.weight,
                        count = result,
                        type = 'item'
                    }
                    TriggerServerEvent("izey:actionProperty", 'remove', item)
                end
            end
        end);
    elseif data.item.type == "item_weapon" then
        if not Config.WeaponWeight[data.item.name] then 
            weight = Config.WeaponDefaultWeight 
        else
            weight = Config.WeaponWeight[data.item.name]
        end
        item = {
            idProperty = data.item.property,
            name = data.item.name,
            label = data.item.label,
            weight = weight,
            type = 'weapon'
        }
        TriggerServerEvent("izey:actionProperty", 'remove', item)
    elseif data.item.type == "item_account" then
        KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
            if result ~= nil then
                if tonumber(result) then
                    item = {
                        idProperty = data.item.property,
                        name = data.item.name,
                        label = data.item.label,
                        count = result,
                        type = 'account'
                    }
                    TriggerServerEvent("izey:actionProperty", 'remove', item)
                end
            end
        end);
    end
    cb("ok")
end)