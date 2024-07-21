local InfoVehicle = {}
local DataVehicle = {}
local ClothesVehicle = {}
local SaveTrunk = {}

function getDataVehicle(plate)
    ClothesVehicle = {}
    InfoVehicle = {}
    ClothesVehicle = {}
    TriggerServerCallback("izeyy:getChestVehicle", function(data, clothes)
        DataVehicle = data.dataTrunk
        InfoVehicle = data.infosTrunk
        ClothesVehicle = data.clothesTrunk
    end, plate)

end

function setTrunkInventoryData(plate, model, class)
    TriggerServerCallback("izeyy:getChestVehicle", function(data)
        if data == 'nil' then
            textTrunk = tonumber(0).." / "..tonumber(Config.WeightVehicle[class]).. Locales[Config.Language]['weight_unity']
            SendNUIMessage(
                {
                    action = "trunk:WeightBarText",
                    weightTrunk = tonumber(0),
                    maxWeightTrunk = tonumber(Config.WeightVehicle[class]),
                    textTrunk = textTrunk,
                    plate = Locales[Config.Language]['trunk_name']..plate
                }
            )
            SendNUIMessage(
                {
                    action = "setSecondInventoryItems",
                    itemList = {}
                }
            )
            return
        end

        DataVehicle = data.dataTrunk
        InfoVehicle = data.infosTrunk

        if InfoVehicle.weight ~= nil then 
            textTrunk = tonumber(InfoVehicle.weight).." / "..tonumber(InfoVehicle.maxweight).. Locales[Config.Language]['weight_unity']
            SendNUIMessage(
                {
                    action = "trunk:WeightBarText",
                    weightTrunk = tonumber(InfoVehicle.weight),
                    maxWeightTrunk = tonumber(InfoVehicle.maxweight),
                    textTrunk = textTrunk, 
                    plate = Locales[Config.Language]['trunk_name']..plate
                }
            )
        elseif InfoVehicle.weight == nil then 
            textTrunk = tonumber(0).." / "..tonumber(Config.WeightVehicle[class]).. Locales[Config.Language]['weight_unity']
            SendNUIMessage(
                {
                    action = "trunk:WeightBarText",
                    weightTrunk = tonumber(0),
                    maxWeightTrunk = tonumber(Config.WeightVehicle[class]),
                    textTrunk = textTrunk,
                    plate = Locales[Config.Language]['trunk_name']..plate
                }
            )
        end


        -- chestvehtenue, chestvehchaussures, chestvehmasque, chestvehpantalon, chestvehhaut, chestvehlunettes, chestvehchapeau, chestvehsac, chestvehchaine, chestvehcalque, chestvehbracelet, chestvehmontre, chestvehoreille, chestvehtshirt, chestvehgant = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
        -- if Config.ActiveAccount then
        --     if DataVehicle["accounts"] ~= nil then
        --         if DataVehicle["accounts"][Config.AccountTrunkMoney] > 0 then
        --             accountData = {
        --                 label = Config.AccountTrunkName[Config.AccountTrunkMoney],
        --                 count = DataVehicle["accounts"][Config.AccountTrunkMoney],
        --                 type = "item_account",
        --                 name = Config.AccountTrunkMoney,
        --                 image = Config.Pictures[Config.AccountTrunkMoney],
        --                 usable = false,
        --                 rare = false,
        --                 weight = 0,
        --                 plate = plate

        --             }
        --             table.insert(SaveTrunk.items, accountData)
        --         end
        --         if DataVehicle["accounts"][Config.AccountTrunkBlackMoney] > 0 then
        --             accountData = {
        --                 label = Config.AccountTrunkName[Config.AccountTrunkBlackMoney],
        --                 count = DataVehicle["accounts"][Config.AccountTrunkBlackMoney],
        --                 type = "item_account",
        --                 name = Config.AccountTrunkBlackMoney,
        --                 image = Config.Pictures[Config.AccountTrunkBlackMoney],
        --                 usable = false,
        --                 rare = false,
        --                 weight = 0,
        --                 plate = plate

        --             }
        --             table.insert(SaveTrunk.items, accountData)
        --         end
        --     end
        -- end
        if Config.ActiveAccount then
            if DataVehicle["accounts"] ~= nil then 
                for key, value in pairs(DataVehicle["accounts"]) do
                    if tonumber(value.count) > 0 then
                        accountData = {
                            label = Config.AccountTrunkName[key],
                            count = value.count,
                            limit = 0,
                            type = "item_account",
                            name = key,
                            image = Config.Pictures[key],
                            canRemove = false,
                            usable = false,
                            rare = false,
                            plate = plate

                        }
                        table.insert(SaveTrunk.items, accountData)
                    end
                end
            end
        end

        if DataVehicle["items"] ~= nil then 
            for key, value in pairs(DataVehicle["items"]) do

                itemTrunk = {
                    label = value.label,
                    count = value.count,
                    limit = 0,
                    type = "item_standard",
                    name = value.name,
                    image = Config.Pictures[value.name],
                    canRemove = false,
                    usable = false,
                    rare = false,
                    plate = plate
                }
                table.insert(SaveTrunk.items, itemTrunk)
            end
        end

        if DataVehicle["weapons"] ~= nil then 
            for key, value in pairs(DataVehicle["weapons"]) do

                weaponTrunk = {
                    label = value.label,
                    count = value.count,
                    limit = 0,
                    type = "item_weapon",
                    name = value.name,
                    image = Config.Pictures[value.name],
                    canRemove = false,
                    usable = false,
                    rare = false,
                    plate = plate

                }
                table.insert(SaveTrunk.items, weaponTrunk)
            end
        end

        if DataVehicle["clothes"] ~= nil then 
            for key, value in pairs(DataVehicle["clothes"]) do

                clothesTrunk = {
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
                    plate = plate

                }
                table.insert(SaveTrunk.items, clothesTrunk)
            end
        end




        SendNUIMessage(
            {
                action = "setSecondInventoryItems",
                itemList = SaveTrunk.items
            }
        )
end, plate)
end




RegisterNUICallback("PutIntoTrunk", function(data, cb)
    if IsPedRagdoll(PlayerPedId()) then
        NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
        return
    end
    if data.item.type == 'item_vetement' then
        dataClothe = {
            id = data.item.id,
            type = data.item.name,
            label = data.item.label,
            weight = Config.ClothesWeight[data.item.name],
        }
        TriggerServerEvent("izey:actionClothTrunk", 'deposit', dataVehicleIn, dataClothe)
        Wait(150)
        RefreshTrunk()

    elseif data.item.type == 'item_standard' then
        KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
            if result ~= nil then
                if tonumber(result) then
                    TriggerServerEvent("izeyy:actionItem", dataVehicleIn.plate, dataVehicleIn.class, "deposit", tonumber(result), data.item.name)
                    Wait(150)
                    RefreshTrunk()
                end
            end
        end);

    elseif data.item.type == 'item_weapon' then
        if not Config.WeaponNoGive[data.item.name] then 
            local playerPed = PlayerPedId() -- Obtenir le Ped du joueur local
            local weaponHash = GetSelectedPedWeapon(playerPed) -- Obtenir le hash de l'arme en main
            local weaponName = GetWeapontypeModel(weaponHash)
            if weaponName == data.item.name then
                SetCurrentPedWeapon(playerPed, 'WEAPON_UNARMED', true)
            end
            dataWeapon = {
                name = data.item.name,
                label = data.item.label,
                amount = 255 -- todo: check amount
            }
            TriggerServerEvent("izeyy:actionsWeapon", "deposit", dataVehicleIn, dataWeapon)
            Wait(150)
            RefreshTrunk()
        end

    elseif data.item.type == 'item_account' then
        KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
            if result ~= nil then
                if tonumber(result) then
                    dataMoney = {
                        type = data.item.name,
                        label = data.item.label,
                        count = tonumber(result)
                    }
                    TriggerServerEvent("izeyy:actionsAccount", "deposit", dataVehicleIn, dataMoney)
                    Wait(150)
                    RefreshTrunk()
                end
            end
        end);

    end
    -- loadPlayerInventory('trunk')
    -- setTrunkInventoryData(dataVehicleIn.plate, dataVehicleIn.model, dataVehicleIn.class)

    -- if type(data.number) == "number" and math.floor(data.number) == data.number then
    --     local count = tonumber(data.number)

    --     if data.item.type == "item_weapon" then
    --         count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
    --     end
    --     TriggerServerEvent("esx_trunk:putItem", trunkData.plate, data.item.type, data.item.name, count, trunkData.max, trunkData.myVeh, data.item.label)
    -- end

    -- Wait(250)
    -- loadPlayerInventory(currentMenu, true)

    cb("ok")
end)

RegisterNUICallback("TakeFromTrunk", function(data, cb)
    if IsPedRagdoll(PlayerPedId()) then
        NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
        return
    end
    if data.item.type == 'item_vetement' then
        dataClothe = {
            id = data.item.id,
            type = data.item.name,
            label = data.item.label,
            weight = Config.ClothesWeight[data.item.name],
        }
        TriggerServerEvent("izey:actionClothTrunk", 'remove', dataVehicleIn, dataClothe)
        Wait(150)
        RefreshTrunk()
    -- elseif data.item.type == 'item_standard' then
    --     KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
    --         if result ~= nil then
    --             if tonumber(result) then
    --                 TriggerServerEvent("izeyy:actionItem", dataVehicleIn.plate, dataVehicleIn.class, "remove", tonumber(result), data.item.name)
    --                 Wait(150)
    --                 RefreshTrunk()
    --             end
    --         end
    --     end);
    elseif data.item.type == 'item_standard' then
        KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
            if result ~= nil then
                if tonumber(result) then
                    local amount = tonumber(result)
                    if amount <= data.item.count and amount > 0 then
                        TriggerServerEvent("izeyy:actionItem", dataVehicleIn.plate, dataVehicleIn.class, "remove", amount, data.item.name)
                        Wait(150)
                        RefreshTrunk()
                    end
                end
            end
        end);
    elseif data.item.type == 'item_weapon' then
        dataWeapon = {
            name = data.item.name,
            label = data.item.label,
            amount = 255 -- todo: check amount
        }
        TriggerServerEvent("izeyy:actionsWeapon", "remove", dataVehicleIn, dataWeapon) 
        Wait(150)
        RefreshTrunk()


    -- elseif data.item.type == 'item_account' then

    --     KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
    --         if result ~= nil then
    --             if tonumber(result) then
    --                 dataMoney = {
    --                     type = data.item.name,
    --                     label = data.item.label,
    --                     count = tonumber(result)
    --                 }
    --                 TriggerServerEvent("izeyy:actionsAccount", "remove", dataVehicleIn, dataMoney)
    --                 Wait(150)
    --                 RefreshTrunk()
    --             end
    --         end
    --     end);

    -- end

    elseif data.item.type == 'item_account' then
        KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
            if result ~= nil then
                if tonumber(result) then
                    local amount = tonumber(result)
                    if amount <= data.item.count and amount > 0 then
                        dataMoney = {
                            type = data.item.name,
                            label = data.item.label,
                            count = amount
                        }
                        TriggerServerEvent("izeyy:actionsAccount", "remove", dataVehicleIn, dataMoney)
                        Wait(150)
                        RefreshTrunk()
                    else
                        -- Show an error message
                    end
                end
            end
        end);
    end
    cb("ok")
end)

function openmenuvehicle()
    if not Inv.isInTrunk then 

        dataVehicleIn = {}

        local playerPed	= PlayerPedId()
        local coords = GetEntityCoords(playerPed, true)
        local vehicle, distance = GetClosestVehicle(coords)
        local VehCoords = GetEntityCoords(vehicle)
        if not IsPedSittingInAnyVehicle(PlayerPedId()) then 

            if distance ~= -1 and distance <= 3.0 then
                local locked = GetVehicleDoorLockStatus(vehicle)
                if locked == 1 then

                    local class = GetVehicleClass(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    local model = GetEntityModel(vehicle)
                    DataVehicle["items"] = nil 
                    DataVehicle["clothes"] = nil 
                    DataVehicle["weapons"] = nil 
                    DataVehicle["accounts"] = nil
                    dataVehicleIn = {
                        plate = plate,
                        model = model,
                        class = class,
                    }
                    SaveTrunk.items = {}
                    TaskTurnPedToFaceCoord(playerPed, VehCoords.x, VehCoords.y, VehCoords.z, 0)
                    -- Inventaire:PlayAnimAdvanced(0, 'anim@heists@fleeca_bank@scope_out@return_case', 'trevor_action', coords.x, coords.y, coords.z, 0.0, 0.0, GetEntityHeading(playerPed), 2.0, 2.0, 1000, 49, 0.25)
                    -- TriggerServerEvent("ronflex:recievecoffrevehserverside", plate)
                    -- getDataVehicle(plate)

                    Inventaire:PlayAnimAdvanced(0, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", coords.x, coords.y, coords.z, 0, 0, GetEntityHeading(playerPed), 4.0, -4.0, -1, 49, 0.25, 0.0, 0, 0)
                    Wait(200)

                    SetVehicleDoorOpen(vehicle, 5, false, false)
                    
                    OpenCoffreVeh(VehCoords, plate, model, class)

                else
                    SendTextMessage(Locales[Config.Language]['trunk_vehicle_close'], 'error') 
                end
            else
                SendTextMessage(Locales[Config.Language]['trunk_vehicle_distance'], 'error')
            end
        else
            SendTextMessage(Locales[Config.Language]['trunk_vehicle_no_in'], 'error')
        end

    end
end

function RefreshTrunk()
    SaveTrunk.items = {}

    setTrunkInventoryData(dataVehicleIn.plate, dataVehicleIn.model, dataVehicleIn.class)
    loadPlayerInventory('trunk', nil, true, true)

end


RegisterNetEvent("lgd_inv:ActuInTrunk")
AddEventHandler("lgd_inv:ActuInTrunk", function(plate)
    SaveTrunk.items = {}

    setTrunkInventoryData(plate, dataVehicleIn.model, dataVehicleIn.class)
    loadPlayerInventory('trunk', nil, true, true)
end)

OpenCoffreVeh = function(CorrdVeh, plate, model, class)
    Inv.isInTrunk = true
    DisplayRadar(false)
    SetNuiFocus(true, true)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerServerEvent('lgd_inv:TableActuTrunk', dataVehicleIn.plate, true)

    Wait(100)
    setTrunkInventoryData(dataVehicleIn.plate, dataVehicleIn.model, dataVehicleIn.class)

    loadPlayerInventory('trunk', nil, true, true)

    SendNUIMessage(
        {
            action = "open:Inv",
            type = "trunk"
        }
    )

    SetTimecycleModifier("Bloom")
    SetTimecycleModifierStrength(1.50)
    Inventaire:hideHUD()
    -- CreatePedScreen(true)
    TriggerScreenblurFadeIn(0)

end

closeMenuVehicle = function()
    Inv.isInTrunk = false

    DisplayRadar(true)
    DeletePedScreen()
    SetNuiFocus(false, false)
    TriggerServerEvent('lgd_inv:TableActuTrunk', dataVehicleIn.plate, false)

    SendNUIMessage({action = "close:Inv"})
    if KeyboardUtils.isActive then
        SendNUIMessage({action = "close:Input"})
    end
    ClearTimecycleModifier()
    if Inv.noPedInv == true then
        SetKeepInputMode(false)
    end
    TriggerScreenblurFadeOut(0)
    FreezeEntityPosition(PlayerPedId(), false)

    local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed, true)
    local vehicle, distance = GetClosestVehicle(coords)
    Inventaire:PlayAnimAdvanced(0, 'anim@heists@fleeca_bank@scope_out@return_case', 'trevor_action', coords.x, coords.y, coords.z, 0.0, 0.0, GetEntityHeading(playerPed), 2.0, 2.0, 1000, 49, 0.25)
    Wait(1200)
    SetVehicleDoorShut(vehicle, 5, false)
end


RegisterCommand('trunk', function()
    if not Inv.inventoryLock then -- for export inventoryLock
        if not Inv.isInInventory then 
            if not Inv.isInTrunk then 
                openmenuvehicle()
            else
                closeMenuVehicle()
            end
        end
    end
end)


