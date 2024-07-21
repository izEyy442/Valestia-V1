PlayerInv = {}

Inv.openInvPlayer = false

openPlayerLoot = function()
    if not Inv.inventoryLock then -- for export inventoryLock
        if Config.ActiveJobForLoot then 
            if not Config.JobForLoot[PlayerData.job.name] then
                return
            end
        end
        local closestPlayer, closestDistance = GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance < 2.5 then
            local closestPed = GetPlayerPed(closestPlayer)
            if Config.HandsupForLoot then
                if not IsEntityPlayingAnim(closestPed, 'random@mugging3', 'handsup_standing_base', 3) then
                    return SendTextMessage(Locales[Config.Language]['no_player_handsup'], 'error')
                end
            end

            if not Inv.openInvPlayer then
                Inv.openInvPlayer = true

                openPlayerInventory(closestPlayer)
            end
        else 
            SendTextMessage(Locales[Config.Language]['no_player'], 'error')
        end
    end
end
RegisterCommand('fouiller', function()
    openPlayerLoot()
end)
exports('openPlayerLoot', openPlayerLoot)

function openPlayerInventory(closestPlayer)
    
    DisplayRadar(false)
    SetNuiFocus(true, true)

    RefreshPlayerTool(closestPlayer)

    SendNUIMessage(
        {
            action = "open:Inv",
            type = "player"
        }
    )



    SetTimecycleModifier("Bloom")
    SetTimecycleModifierStrength(1.50)
    Inventaire:hideHUD()
    CreatePedScreen(true)
    TriggerScreenblurFadeIn(0)

end


function loadPlayerLootInv(closestPlayer)
    TriggerServerCallback("izeyko:getPlayerOtherInventory", function(data)
        items = {}
        fastItems = {}
        PlayerInv.inventory = data.inventory
        accounts = data.accounts
        PlayerInv.weapons = data.weapons
        PlayerInv.clothes = data.clothes
        PlayerInv.idCard = data.idcard
        PlayerInv.phone = data.phone
        weight = data.weight
        maxWeight = data.maxWeight


        
        SendNUIMessage({
            action = "trunk:WeightBarText",
            textTrunk = "" ..tonumber(weight).. " / " ..tonumber(maxWeight).. Locales[Config.Language]['weight_unity'],
            maxWeightTrunk = tonumber(maxWeight),
            weightTrunk = tonumber(weight),
            plate = 'Inventaire'
        })





        if Config.ActiveAccount then
            if accounts ~= nil then
                for key, value in pairs(accounts) do
                    if Config.Account[accounts[key].name] then
                        labelAccount = Config.AccountName[accounts[key].name]
                        if accounts[key].money > 0 then
                            accountData = {
                                label = labelAccount,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                image = Config.Pictures[accounts[key].name],
                                usable = false,
                                rare = false,
                                weight = 0
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end
        end
        -- if Config.ActivePhoneUnique then
        --     if PlayerInv.phone ~= nil then
        --         for k, v in pairs(PlayerInv.phone) do
        --             PlayerInv.phone = {
        --                 label = 'Téléphone',
        --                 count = 1,
        --                 type = "item_phone",
        --                 name = 'phone',
        --                 image = Config.Pictures['phone'],
        --                 usable = false,
        --                 value = v.number,
        --                 active = v.active,
        --                 rare = false,
        --                 weight = 0
        --             }
        --             table.insert(items, PlayerInv.phone)
        --         end
        --     end
        -- end
        if Config.ActiveIdCard then
            if PlayerInv.idCard ~= nil then
                for k, v in pairs(PlayerInv.idCard) do
                    nameCard = Config.IdCardName[v.type].name
                    idcardData = {
                        label = nameCard,
                        count = 0.5,
                        limit = 0,
                        type = "item_idcard",
                        name = v.type,
                        image = Config.Pictures[v.type],
                        value = v.information,
                        id = v.id,
                        usable = true,
                        rare = true,
                        slot = nil
                    }
                    table.insert(items, idcardData)
                end
            end
        end

        if PlayerInv.inventory ~= nil then
            for k, v in pairs(PlayerInv.inventory) do
                PlayerInv.DataInv = {
                    label = v.label,
                    count = v.count,
                    limit = -1,
                    type = "item_standard",
                    name = v.name,
                    image = Config.Pictures[v.name],
                    usable = false,
                    rare = false,
                    slot = nil
                }
                table.insert(items, PlayerInv.DataInv)
            end
        end

        
        if PlayerInv.weapons ~= nil then
            for k, v in pairs(PlayerInv.weapons) do
                PlayerInv.DataWeap = {
                    label = v.label,
                    count = 1,
                    limit = -1,
                    type = "item_weapon",
                    name = v.name,
                    image = Config.Pictures[v.name],
                    usable = false,
                    rare = false,
                    slot = nil
                }
                table.insert(items, PlayerInv.DataWeap)
            end
        end



        if PlayerInv.clothes ~= nil then
            for k, v in pairs(PlayerInv.clothes) do
                PlayerInv.clothes2 = {
                    label = v.label,
                    count = 0.2,
                    limit = -1,
                    type = "item_vetement",
                    name = v.type,
                    image = Config.Pictures[v.type],
                    value = v.clothe,
                    id = v.id,
                    usable = true,
                    rare = true,
                    slot = nil
                }
                table.insert(items, PlayerInv.clothes2)
            end
        end
        SendNUIMessage(
            {
                action = "setSecondInventoryItems",
                itemList = items
            }
        )
    end, GetPlayerServerId(closestPlayer))
end

function RefreshPlayerTool(closestPlayer)
    loadPlayerLootInv(closestPlayer)
    Wait(100)

    loadPlayerInventory('trunk', nil, true, true)

end


RegisterNUICallback("PutIntoPlayer", function(data, cb)
    if IsPedRagdoll(PlayerPedId()) then
        NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
        return
    end
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance < 2.5 then
        local dataLoot = {
            player = GetPlayerServerId(PlayerId()),
            target = GetPlayerServerId(closestPlayer),
            type = data.item.type,
            id = data.item.id,
            name = data.item.name,
            label = data.item.label
        }
        if data.item.type == 'item_vetement' then
            TriggerServerEvent("izey:putToPlayer", dataLoot)
            Wait(100)
            RefreshPlayerTool(closestPlayer)
        elseif data.item.type == 'item_standard' then
            KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
                if result ~= nil then
                    if tonumber(result) then
                        TriggerServerEvent("izey:putToPlayer", dataLoot, tonumber(result))
                        Wait(100)
                        RefreshPlayerTool(closestPlayer)
                    end
                end
            end);
        elseif data.item.type == 'item_weapon' then
            if not Config.WeaponNoGive[data.item.name] then 
                TriggerServerEvent("izey:putToPlayer", dataLoot, 255)
                Wait(100)
                RefreshPlayerTool(closestPlayer)
            end
        elseif data.item.type == 'item_account' then

            KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
                if result ~= nil then
                    if tonumber(result) then
                        TriggerServerEvent("izey:putToPlayer", dataLoot, tonumber(result))
                        Wait(100)
                        RefreshPlayerTool(closestPlayer)
                    end
                end
            end);
        end
    end
    cb("ok")
end)

RegisterNUICallback("TakeFromPlayer", function(data, cb)
    if IsPedRagdoll(PlayerPedId()) then
        NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
        return
    end
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance < 2.5 then
        local dataLoot = {
            player = GetPlayerServerId(closestPlayer),
            target = GetPlayerServerId(PlayerId()),
            type = data.item.type,
            id = data.item.id,
            name = data.item.name,
            label = data.item.label
        }
        if data.item.type == 'item_vetement' then
            TriggerServerEvent("izey:putToPlayer", dataLoot)
            Wait(100)
            RefreshPlayerTool(closestPlayer)
        elseif data.item.type == 'item_standard' then
            KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
                if result ~= nil then
                    if tonumber(result) then
                        TriggerServerEvent("izey:putToPlayer", dataLoot, tonumber(result))
                        Wait(100)
                        RefreshPlayerTool(closestPlayer)
                    end
                end
            end);
        elseif data.item.type == 'item_weapon' then
            if not Config.WeaponNoGive[data.item.name] then 

                TriggerServerEvent("izey:putToPlayer", dataLoot, 255)
                Wait(100)
                RefreshPlayerTool(closestPlayer)
            end
        elseif data.item.type == 'item_account' then

            KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
                if result ~= nil then
                    if tonumber(result) then
                        TriggerServerEvent("izey:putToPlayer", dataLoot, tonumber(result))
                        Wait(100)
                        RefreshPlayerTool(closestPlayer)
                    end
                end
            end);
        end
    end
    cb("ok")
end)