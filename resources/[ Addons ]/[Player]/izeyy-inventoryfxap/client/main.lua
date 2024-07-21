local tenue, chaussures, masque, pantalon, haut, lunettes, chapeau, sac, chaine, calque, bracelet, montre, oreille = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
local totalWeight = 0
local currentMenu = 'item'

Inv.isInInventory = false
Inv.inventoryLock = false

-----------------------------------------------------------------------------------------------------------------------------------------------------------

function openInventory()
    if not Inv.inventoryLock then -- for export inventoryLock
        Inv.isInInventory = true
        -- TriggerEvent("hud:hide", true)
        
        DisplayRadar(false)

        SetNuiFocus(true,true)

        if currentMenu ~= 'item' then
            items = nil
            currentMenu = 'item'
            loadPlayerInventory(currentMenu)
        else
            loadPlayerInventory(currentMenu)
        end

        SendNUIMessage({action = "open:Inv", type = "normal"})
        Inventaire:hideHUD()

        TriggerScreenblurFadeIn(0)

        CreatePedScreen(false)

        SetTimecycleModifierStrength(1.50)
        
        -- TriggerScreenblurFadeIn(20)
        -- SetTimecycleModifier("ArenaEMP")
    end
end


function closeInventory()
    Inv.isInInventory = false
    Inv.openInvPlayer = false
    

    DisplayRadar(true)
    DeletePedScreen()
    SetNuiFocus(false, false)

    SendNUIMessage({action = "close:Inv"})
    if KeyboardUtils.isActive then
        SendNUIMessage({action = "close:Input"})
    end
    ClearTimecycleModifier()
    TriggerScreenblurFadeOut(0)
    if Inv.noPedInv == true then
        SetKeepInputMode(false)
    end
    if Inv.isInTrunk then 
        Inv.isInTrunk = false
        TriggerServerEvent('lgd_inv:TableActuTrunk', dataVehicleIn.plate, false)
        FreezeEntityPosition(PlayerPedId(), false)
        local playerPed	= PlayerPedId()
        local coords = GetEntityCoords(playerPed, true)
        local vehicle, distance = GetClosestVehicle(coords)
        Inventaire:PlayAnimAdvanced(0, 'anim@heists@fleeca_bank@scope_out@return_case', 'trevor_action', coords.x, coords.y, coords.z, 0.0, 0.0, GetEntityHeading(playerPed), 2.0, 2.0, 1000, 49, 0.25)
        Wait(1200)
        SetVehicleDoorShut(vehicle, 5, false)
    end

    TriggerScreenblurFadeOut(0)

    -- TriggerEvent('hud:show')
end



RegisterNUICallback('close', function(data)
    if Inv.isInInventory or Inv.openInvPlayer then 
        Inv.isInInventory = false
        Inv.openInvPlayer = false
        DisplayRadar(true)
        DeletePedScreen()
        SetNuiFocus(false, false)

        ClearTimecycleModifier()
        TriggerScreenblurFadeOut(0)
        if Inv.noPedInv == true then
            SetKeepInputMode(false)
        end

        return
    end
    if Inv.isInTrunk then
        Inv.isInTrunk = false
    
        DisplayRadar(true)
        DeletePedScreen()
        SetNuiFocus(false, false)
        TriggerServerEvent('lgd_inv:TableActuTrunk', dataVehicleIn.plate, false)

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

        return

    end
    if Inv.isInProperty then 
        Inv.isInProperty = false
        DisplayRadar(true)
        DeletePedScreen()
        SetNuiFocus(false, false)
        TriggerServerEvent('lgd_inv:TableActuProperty', dataProperty.id, false)

        FreezeEntityPosition(PlayerPedId(), false)
        ClearTimecycleModifier()
        TriggerScreenblurFadeOut(0)
        if Inv.noPedInv == true then
            SetKeepInputMode(false)
        end

        return
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if (IsScreenFadedOut()) then
            closeInventory()
        end
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        BlockWeaponWheelThisFrame()
        SetPedCanSwitchWeapon(PlayerPedId(), false)

        if Inv.isInInventory or Inv.isInTrunk or Inv.openInvPlayer or Inv.isInProperty then 
            Citizen.Wait(0)
            SetMouseCursorVisibleInMenus(false)
        end
    end
end)



function GetInventoryOpen()
    return Inv.isInInventory or Inv.isInTrunk or Inv.openInvPlayer or Inv.isInProperty
end

exports('getInInventory', function()
    return GetInventoryOpen()
end)

exports('closeInventory', closeInventory)

exports('lockInventory', function(info)
    Inv.inventoryLock = info
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('inventory', function()
    if not Inv.isInInventory and not Inv.openInvPlayer and not Inv.isInTrunk and not Inv.isInProperty then
        openInventory()
    -- elseif Inv.isInInventory or Inv.openInvPlayer then 
    --     Inv.openInvPlayer = false
    --     closeInventory()
    end
end)

RegisterCommand('keybind_1', function()
    useitem(1)
end)

RegisterCommand('keybind_2', function()
    useitem(2)
end)

RegisterCommand('keybind_3', function()
    useitem(3)
end)

RegisterCommand('keybind_4', function()
    useitem(4)
end)

RegisterCommand('keybind_5', function()
    useitem(5)
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------

function NotificationItem(item, label, count, info)
    if info then
        signe = '+'
    elseif not info then
        signe = '-'
    else
        signe = ' '
    end 
    if item ~= nil or item ~= '' then
        SendNUIMessage({
            action = "ItemNotify",
            message = label,
            icon = Config.Pictures[item],
            count = signe..''..count,
            info = count,
        })
    end
end


exports("notifItem", function(item, label, count, info)
    NotificationItem(item, label, count, info)
end)



-----------------------------------------------------------------------------------------------------------------------------------------------------------


function NotificationInInventory(msg, type)
    if not Config.UseNotificationInventory then
        SendTextMessage(msg, type)
    else
        if msg ~= nil or msg ~= '' then
            SendNUIMessage({
                action = "InvNotify",
                message = msg,
                timeout = 4000,
            })
        end
    end
end


exports("notifInventory", function(msg, type)
    NotificationInInventory(msg, type)
end)

RegisterNetEvent("inv:Notification")
AddEventHandler("inv:Notification", function(msg, type)
    NotificationInInventory(msg, type)

end)




-----------------------------------------------------------------------------------------------------------------------------------------------------------


currentCallback = nil

-- RegisterCommand('keyboard', function()
-- 	KeyboardUtils.use("Ecrivez le message",function(data) 
-- 	end);
-- end)


KeyboardUtils = {isActive = false}

AddEventHandler("kbi:cancel",function() 
    KeyboardUtils.isActive = false
end)


function KeyboardUtils.use(title,cb)
    if not KeyboardUtils.isActive then
        KeyboardUtils.isActive = true
        useKeyboard(title,function(data)
            cb(data)
            KeyboardUtils.isActive = false
        end)
    end
end


exports("keyboardUI", function(title,cb)
    useKeyboard(title,cb);
end)


function useKeyboard(title,cb)
    SetTimeout(200,function()
        if not Inv.isInInventory and not Inv.isInTrunk and not Inv.openInvPlayer and not Inv.isInProperty then
            SetNuiFocus(true,true);
        end
        if Inv.noPedInv == true then
            SetKeepInputMode(false)
        end
        currentCallback = cb;
        SendNUIMessage({action="open:Input",title=title and title or ""});
    end)
end


RegisterNUICallback("send",function(data)
    if not Inv.isInInventory and not Inv.isInTrunk and not Inv.openInvPlayer and not Inv.isInProperty then
        SetNuiFocus(false,false);
    end
    if Inv.noPedInv == true then
        SetKeepInputMode(true)
    end
    if currentCallback then
        currentCallback(data.text);
        currentCallback = nil;
    end
end)

RegisterNUICallback("cancel",function(data)
    if not Inv.isInInventory and not Inv.isInTrunk and not Inv.openInvPlayer and not Inv.isInProperty then
        SetNuiFocus(false,false);
    end
    if Inv.noPedInv == true then
        SetKeepInputMode(true)
    end
    currentCallback(nil);
    currentCallback = nil;
    TriggerEvent("kbi:cancel");
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- RegisterCommand('debug', function()
--     removePedInv(true)
-- end)

Inv.noPedInv = false

function removePedInv(bool)
    Inv.noPedInv = GetFieldValueFromName('izeyy-inventory').pedscreen
    if Inv.noPedInv == false or  Inv.noPedInv == nil then
        Inv.noPedInv = true
        SetFieldValueFromNameEncode('izeyy-inventory', {pedscreen = bool})
    else
        if Inv.noPedInv == true then
            Inv.noPedInv = false
            SetFieldValueFromNameEncode('izeyy-inventory', {pedscreen = bool})
        end
    end
end

exports("removePedInv", removePedInv)



KEEP_FOCUS = false
local threadCreated = false
local controlDisabled = {1, 2, 3, 4, 5, 6, 18, 24, 25, 37, 69, 70, 111, 117, 118, 182, 199, 200, 257}

function SetKeepInputMode(bool)
    if SetNuiFocusKeepInput then
        SetNuiFocusKeepInput(bool)
    end

    KEEP_FOCUS = bool

    if not threadCreated and bool then
        threadCreated = true

        Citizen.CreateThread(function()
            while KEEP_FOCUS do
                Wait(0)
                for _,v in pairs(controlDisabled) do
                    DisableControlAction(0, v, true)
                end
            end

            threadCreated = false
        end)
    end
end

function CreatePedScreen(firstTime)
    Inv.noPedInv = GetFieldValueFromName('izeyy-inventory').pedscreen
    if Inv.noPedInv == true then
        return SetKeepInputMode(true)

    end
    if Config.UseNPC then 
        local playerPed	= PlayerPedId()
        local coords = GetEntityCoords(playerPed, true)
        local vehicle, distance = GetClosestVehicle(coords)
        if distance ~= -1 and distance <= 5.0 then
            return
        end
    end

    local menuType = "FE_MENU_VERSION_EMPTY_NO_BACKGROUND"
    ActivateFrontendMenu(GetHashKey(menuType), false, -1)
    Wait(50)
    clonedPed = ClonePed(PlayerPedId(), 0, false, false)

    local x, y, z = table.unpack(GetEntityCoords(clonedPed))
    SetEntityCoords(clonedPed, x, y, z + 5.5)
    --FreezeEntityPosition(clonedPed, true)
    N_0x4668d80430d6c299(clonedPed)
    GivePedToPauseMenu(clonedPed, 1)

    RequestScaleformMovie("PAUSE_MP_MENU_PLAYER_MODEL")
    ReplaceHudColourWithRgba(117, 0, 0, 0, 0)
    SetBlockingOfNonTemporaryEvents(clonedPed, true)
    SetPauseMenuPedLighting(true)
    SetPauseMenuPedSleepState(true)
end

function DeletePedScreen()
    if DoesEntityExist(clonedPed) then
        DeleteEntity(clonedPed)
    end
    SetFrontendActive(false)
    ReplaceHudColourWithRgba(117, 0, 0, 0, 186)
end

function RefreshPedScreen()
    if DoesEntityExist(clonedPed) then
        if Inv.isInInventory or Inv.isInTrunk or Inv.openInvPlayer or Inv.isInProperty then 
            ClonePedToTarget(PlayerPedId(), clonedPed)
        end
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    SetFrontendActive(false)
    ReplaceHudColourWithRgba(117, 0, 0, 0, 186)
    DeleteEntity(clonedPed)
    ClearTimecycleModifier()
    TriggerScreenblurFadeOut(0)
    if Inv.noPedInv == true then
        SetKeepInputMode(false)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------------------------


SetFieldValueFromNameEncode = function(stringName, data)
	SetResourceKvp(stringName, json.encode(data))
end

GetFieldValueFromName = function(stringName)
	local data = GetResourceKvpString(stringName)
	return data and json.decode(data) or {}
end

Inv.FastWeapons = GetFieldValueFromName('izeyy-inventory').name and GetFieldValueFromName('izeyy-inventory').name or {}


-----------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("UpdateTotal")
AddEventHandler("UpdateTotal", function()
    totalWeight = 0
    for k,v in ipairs(ESX.GetPlayerData().inventory) do
		if v.count > 0 then
            totalWeight = totalWeight + (v.weight * v.count)
        end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------------------------


function KeyboardInput(textEntry, maxLength)
    AddTextEntry("Message", textEntry)
    DisplayOnscreenKeyboard(1, "Message", '', '', '', '', '', maxLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end









RegisterCommand('invbug', function()
    if invbug then 
        SetNuiFocus(false, false)
        SetKeepInputMode(false)
    else
        SetNuiFocus(true, true)
        SetKeepInputMode(true)
    end
    invbug = not invbug
end)






local dataInv = {}
dataInv.clothes2 = {}

function loadPlayerInventory(result, coffre, category, poid)
        TriggerServerCallback("izeyko:getPlayerInventory", function(data)
            items = {}
            fastItems = {}
			dataInv.inventory = data.inventory
			accounts = data.accounts
    		dataInv.weapons = data.weapons
    		dataInv.clothes = data.clothes
    		dataInv.idCard = data.idcard
    		dataInv.phone = data.phone
			weight = data.weight
            maxWeight = data.maxWeight
            if not category then
                SendNUIMessage({
                    action = "setItems",
                    text = "" ..(weight).. " / " ..(maxWeight).. Locales[Config.Language]['weight_unity'],
                    maxWeight = maxWeight,
                    weight = weight,
                })
            end

            if poid then
                SendNUIMessage({
                    action = "Inv:WeightBarText",
                    text = "" ..tonumber(weight).. " / " ..tonumber(maxWeight).. Locales[Config.Language]['weight_unity'],
                    maxWeight = tonumber(maxWeight),
                    weight = tonumber(weight),
                })
            end



            
			-- if Config.IncludeCash and money ~= nil and money > 0 then
			-- 	moneyData = {
			-- 		label = "Espèces",
			-- 		name = "cash",
			-- 		type = "item_money",
			-- 		count = money,
			-- 		usable = false,
			-- 		rare = false,
			-- 		weight = 0
			-- 	}
			-- 	table.insert(items, moneyData)
			-- end
            -- if dataInv.idCard ~= nil then
            --     for key, value in pairs(dataInv.idCard) do
            --         if dataInv.idCard[key].type == 'id' then
            --             nameCard = "Carte d'identité"
            --         end

            --         cardData = {
            --             label = nameCard,
            --             count = 1,
            --             type = "item_idcard",
            --             name = dataInv.idCard[key].type,
            --             image = Config.Pictures[dataInv.idCard[key].type],
            --             usable = true,
            --             id = dataInv.idCard[key].id,
            --             value = dataInv.idCard[dataInv.idCard[key].id],
            --             rare = false,
            --             weight = 1
            --         }
            --         table.insert(items, cardData)
            --     end
            -- end
            if Config.Framework == "esx" then

                -- ███████╗███████╗██╗  ██╗
                -- ██╔════╝██╔════╝╚██╗██╔╝
                -- █████╗  ███████╗ ╚███╔╝ 
                -- ██╔══╝  ╚════██║ ██╔██╗ 
                -- ███████╗███████║██╔╝ ██╗
                -- ╚══════╝╚══════╝╚═╝  ╚═╝
                                        
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
                if Config.ActivePhoneUnique then
                    if dataInv.phone ~= nil then
                        for k, v in pairs(dataInv.phone) do
                            dataInv.phone = {
                                label = v.numberLabel,
                                count = 1,
                                type = "item_phone",
                                name = Config.ItemPhoneName,
                                image = Config.Pictures['phone'],
                                usable = true,
                                value = v.number,
                                rare = false,
                                weight = 0
                            }
                            table.insert(items, dataInv.phone)
                        end
                    end
                end
                if Config.ActiveIdCard then
                    if dataInv.idCard ~= nil then
                        for k, v in pairs(dataInv.idCard) do
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

                if dataInv.inventory ~= nil then
                    for key, value in pairs(dataInv.inventory) do

                        if dataInv.inventory[key].count <= 0 then
                            dataInv.inventory[key] = nil
                        else
                            if json.encode(Inv.FastWeapons) ~= "[]" then
                                for k,v in pairs(Inv.FastWeapons) do 
                                    for fast, bind in pairs(Inv.FastWeapons) do
                                        if dataInv.inventory[key].name == bind then
                                            table.insert(fastItems, {
                                                label = dataInv.inventory[key].label,
                                                count = dataInv.inventory[key].count,
                                                limit = -1,
                                                type = dataInv.inventory[key].type,
                                                name = dataInv.inventory[key].name,
                                                image = Config.Pictures[dataInv.inventory[key].name],
                                                usable = true,
                                                rare = false,
                                                slot = fast
                                            })
                                        end
                                    end
                                end
                            end
                            dataInv.inventory[key].type = "item_standard"
                            dataInv.inventory[key].usable = true
                            dataInv.inventory[key].image = Config.Pictures[dataInv.inventory[key].name]
                            dataInv.inventory[key].count = dataInv.inventory[key].count
                            table.insert(items, dataInv.inventory[key])
                        end
                    end
                end

                if dataInv.weapons ~= nil then
                    for key, value in pairs(dataInv.weapons) do
                        munition = dataInv.weapons[key].ammo
                        -- if weapons[key].ammo <= 0 then
                        --     weapons[key] = nil
                        -- else
                            if json.encode(Inv.FastWeapons) ~= "[]" then
                                for k,v in pairs(Inv.FastWeapons) do 
                                    for fast, bind in pairs(Inv.FastWeapons) do
                                        if dataInv.weapons[key].name == bind then
                                            table.insert(fastItems, {
                                                label = dataInv.weapons[key].label,
                                                count = 1,
                                                limit = -1,
                                                type = dataInv.weapons[key].type,
                                                name = dataInv.weapons[key].name,
                                                image = Config.Pictures[dataInv.weapons[key].name],
                                                usable = true,
                                                rare = false,
                                                slot = fast
                                            })
                                        end
                                    end
                                end
                            end
                            dataInv.weapons[key].type = "item_weapon"
                            dataInv.weapons[key].count = 1
                            dataInv.weapons[key].usable = true
                            dataInv.weapons[key].image = Config.Pictures[dataInv.weapons[key].name]
                            table.insert(items, dataInv.weapons[key])
                        -- end
                    end
                end


                if dataInv.clothes ~= nil then
                    for k, v in pairs(dataInv.clothes) do
                        dataInv.clothes2 = {
                            label = v.label,
                            count = 1,
                            type = "item_vetement",
                            name = v.type,
                            image = Config.Pictures[v.type],
                            value = v.clothe,
                            id = v.id,
                            usable = true,
                            rare = true,
                            slot = nil
                        }
                        table.insert(items, dataInv.clothes2)
                    end
                end
            elseif Config.Framework == "qb" then

                --  ██████╗ ██████╗  ██████╗ ██████╗ ██████╗ ███████╗
                -- ██╔═══██╗██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔════╝
                -- ██║   ██║██████╔╝██║     ██║   ██║██████╔╝█████╗  
                -- ██║▄▄ ██║██╔══██╗██║     ██║   ██║██╔══██╗██╔══╝  
                -- ╚██████╔╝██████╔╝╚██████╗╚██████╔╝██║  ██║███████╗
                --  ╚══▀▀═╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
                                                                  
                if Config.ActiveAccount then
                    labelAccount = Config.AccountName['cash']
                    if PlayerData.money.cash > 0 then
                        accountData = {
                            label = labelAccount,
                            count = PlayerData.money.cash,
                            type = "item_account",
                            name = 'cash',
                            image = Config.Pictures['cash'],
                            usable = false,
                            rare = false,
                            weight = 0
                        }
                        table.insert(items, accountData)
                    end
                end

                if dataInv.inventory ~= nil then
                    for key, value in pairs(dataInv.inventory) do
                        if dataInv.inventory[key].amount <= 0 then
                            dataInv.inventory[key] = nil
                        else
                            if json.encode(Inv.FastWeapons) ~= "[]" then
                                for k,v in pairs(Inv.FastWeapons) do 
                                    for fast, bind in pairs(Inv.FastWeapons) do
                                        if dataInv.inventory[key].name == bind then
                                            table.insert(fastItems, {
                                                label = dataInv.inventory[key].label,
                                                count = dataInv.inventory[key].amount,
                                                limit = -1,
                                                type = dataInv.inventory[key].type,
                                                name = dataInv.inventory[key].name,
                                                image = Config.Pictures[dataInv.inventory[key].name],
                                                usable = true,
                                                rare = false,
                                                slot = fast
                                            })
                                        end
                                    end
                                end
                            end
                            dataInv.inventory[key].type = "item_standard"
                            dataInv.inventory[key].usable = true
                            dataInv.inventory[key].image = Config.Pictures[dataInv.inventory[key].name]
                            dataInv.inventory[key].count = dataInv.inventory[key].amount
                            table.insert(items, dataInv.inventory[key])
                        end
                    end
                end
                
                if dataInv.clothes ~= nil then
                    for k, v in pairs(dataInv.clothes) do
                        dataInv.clothes2 = {
                            label = v.label,
                            count = 1,
                            type = "item_vetement",
                            name = v.type,
                            image = Config.Pictures[v.type],
                            value = v.clothe,
                            id = v.id,
                            usable = true,
                            rare = true,
                            slot = nil
                        }
                        table.insert(items, dataInv.clothes2)
                    end
                end
            end


            if result == 'slot' then
                SendNUIMessage({ action = "updateSlot", fastItems = fastItems, text = texts, crMenu = currentMenu, itemTrunk = 'no'})
            elseif result == 'trunk' then
                SendNUIMessage({ action = "setItems", itemList = items, fastItems = fastItems, text = texts, crMenu = currentMenu, itemTrunk = 'trunk'})
            else
                SendNUIMessage({ action = "setItems", itemList = items, fastItems = fastItems, text = texts, crMenu = currentMenu, itemTrunk = 'no'})
            end
        end, GetPlayerServerId(PlayerId()))
end


-- category 
RegisterNUICallback('category', function(data)
    items = {}
    cateClothes = {}
    if data.type == 'all' then
        if not Inv.isInTrunk then
            loadPlayerInventory('item', nil, true)
        else
            loadPlayerInventory('trunk', nil, true, true)
        end
    elseif data.type == 'item' then
        if dataInv.inventory ~= nil then
            for key, value in pairs(dataInv.inventory) do
                if dataInv.inventory[key].count <= 0 then
                    dataInv.inventory[key] = nil
                else
                    if json.encode(Inv.FastWeapons) ~= "[]" then
                        for k,v in pairs(Inv.FastWeapons) do 
                            for fast, bind in pairs(Inv.FastWeapons) do
                                if dataInv.inventory[key].name == bind then
                                    table.insert(fastItems, {
                                        label = dataInv.inventory[key].label,
                                        count = dataInv.inventory[key].count,
                                        limit = -1,
                                        type = dataInv.inventory[key].type,
                                        name = dataInv.inventory[key].name,
                                        image = Config.Pictures[dataInv.inventory[key].name],
                                        usable = true,
                                        rare = false,
                                        slot = fast
                                    })
                                end
                            end
                        end
                    end
                    dataInv.inventory[key].type = "item_standard"
                    dataInv.inventory[key].usable = true
                    dataInv.inventory[key].image = Config.Pictures[dataInv.inventory[key].name]
                    table.insert(items, dataInv.inventory[key])
                end
            end
        end
        SendNUIMessage({ action = "setItems", itemList = items, fastItems = fastItems, text = texts, crMenu = currentMenu})
    elseif data.type == 'weapon' then
        if dataInv.weapons ~= nil then
            for key, value in pairs(dataInv.weapons) do
                munition = dataInv.weapons[key].ammo
                -- if weapons[key].ammo <= 0 then
                --     weapons[key] = nil
                -- else
                    if json.encode(Inv.FastWeapons) ~= "[]" then
                        for k,v in pairs(Inv.FastWeapons) do 
                            for fast, bind in pairs(Inv.FastWeapons) do
                                if dataInv.weapons[key].name == bind then
                                    table.insert(fastItems, {
                                        label = dataInv.weapons[key].label,
                                        count = 255,
                                        limit = -1,
                                        type = dataInv.weapons[key].type,
                                        name = dataInv.weapons[key].name,
                                        image = Config.Pictures[dataInv.weapons[key].name],
                                        usable = true,
                                        rare = false,
                                        slot = fast
                                    })
                                end
                            end
                        end
                    end
                    dataInv.weapons[key].type = "item_weapon"
                    dataInv.weapons[key].usable = true
                    dataInv.weapons[key].image = Config.Pictures[dataInv.weapons[key].name]
                    table.insert(items, dataInv.weapons[key])
                -- end
            end
        end
        SendNUIMessage({ action = "setItems", itemList = items, fastItems = fastItems, text = texts, crMenu = currentMenu})
    elseif data.type == 'clothes' then
        if dataInv.clothes ~= nil then
            for k, v in pairs(dataInv.clothes) do
                dataInv.clothes2 = {
                    label = v.label,
                    count = 1,
                    type = "item_vetement",
                    name = v.type,
                    image = Config.Pictures[v.type],
                    value = v.clothe,
                    id = v.id,
                    usable = true,
                    rare = true,
                    slot = nil
                }
                table.insert(items, dataInv.clothes2)
            end
        end
        SendNUIMessage({ action = "setItems", itemList = items, fastItems = fastItems, text = texts, crMenu = currentMenu})

    end

end)

-- use Item 






RegisterNUICallback('useItem', function(data)
    
    if (not Inv.isInTrunk) then

        if IsPedRagdoll(PlayerPedId()) then
            NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
        else
            if data.item.type == "item_standard" then 
                if Config.Framework == "qb" then
                    --  ██████╗ ██████╗  ██████╗ ██████╗ ██████╗ ███████╗
                    -- ██╔═══██╗██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔════╝
                    -- ██║   ██║██████╔╝██║     ██║   ██║██████╔╝█████╗  
                    -- ██║▄▄ ██║██╔══██╗██║     ██║   ██║██╔══██╗██╔══╝  
                    -- ╚██████╔╝██████╔╝╚██████╗╚██████╔╝██║  ██║███████╗
                    --  ╚══▀▀═╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
                    if Config.ActivePhoneUnique then
                        if data.item.name == "phone" then
                            TriggerServerEvent('izey:CreatePhone')
                            Wait(50)
                            loadPlayerInventory('item', nil, true, true)
                            return
                        end
                    end
                    if Config.IdCardName[data.item.name] then 
                        local value = {
                            firstname = PlayerData.charinfo.firstname,
                            lastname =PlayerData.charinfo.lastname,
                            dateofbirth = PlayerData.charinfo.birthdate,
                            sex = PlayerData.charinfo.gender,
                            height = 0
                        }
                        SendNUIMessage({
                            action="open:MenuIdCard", 
                            info = value,
                            type = data.item.name,
                        });
                        return
                    end
                    TriggerServerEvent(Config.Trigger["useItem"], data.item.name)
                elseif Config.Framework == "esx" then

                    -- ███████╗███████╗██╗  ██╗
                    -- ██╔════╝██╔════╝╚██╗██╔╝
                    -- █████╗  ███████╗ ╚███╔╝ 
                    -- ██╔══╝  ╚════██║ ██╔██╗ 
                    -- ███████╗███████║██╔╝ ██╗
                    -- ╚══════╝╚══════╝╚═╝  ╚═╝
                    
                    if Config.ActivePhoneUnique then
                        if data.item.name == "phone" then
                            TriggerServerEvent('izey:CreatePhone')
                            Wait(50)
                            loadPlayerInventory('item', nil, true, true)
                            return
                        end
                    end
                    TriggerServerEvent(Config.Trigger["useItem"], data.item.name)

                end
            elseif data.item.type == "item_phone" then 

                closeInventory()
                TriggerEvent('lb-phone:usePhoneItem', data.item.value)

            elseif data.item.type == "item_weapon" then 

                local ped = PlayerPedId()
                if not weaponLock then
                    weaponLock = true
                    if  weaponEquiped ~= data.item.name then
                        weaponEquiped = data.item.name
                        SetCurrentPedWeapon(ped, data.item.name, true)
                        Wait(150)
                        weaponLock = false
                    else 
                        weaponEquiped = nil
                        SetCurrentPedWeapon(ped, 'WEAPON_UNARMED', true)
                        Wait(150)
                        weaponLock = false
                    end 
                end

            elseif data.item.type == "item_vetement" then
                Inventaire:ApplyClothes(data.item.value)
                RefreshPedScreen()
            elseif data.item.type == "item_idcard" then
                SendNUIMessage({
                    action="open:MenuIdCard", 
                    info = data.item.value,
                    type = data.item.name,
                });


            end
        end
        if Config.CloseUI[data.item.name] and data.item.type ~= "item_phone" then 
            closeInventory()
        else
            Wait(50)
            loadPlayerInventory('item', nil, true, true)
        end

    end

end)



--  rename clothes

RegisterNUICallback('renameItem', function(data)
    if IsPedRagdoll(PlayerPedId()) then
        NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
    else
        if data.item.type == "item_vetement" then
            -- closeInventory()
            KeyboardUtils.use(Locales[Config.Language]['title_clothes'],function(result) 
                if result ~= nil and result ~= '' and result ~= ' ' then
                    TriggerServerEvent('izey:renameItem', data.item.id, result)
                    NotificationInInventory((Locales[Config.Language]['rename_clothes']):format(result), 'success')
                    Wait(50)
                    loadPlayerInventory('item', nil, true)
                else
                    NotificationInInventory(Locales[Config.Language]['rename_error_clothes'], 'error')
                end
            end);
        end
    end

end)



Config.trashList = {
    "prop_snow_bin_01",
    "prop_snow_dumpster_01",
    "prop_snow_bin_02",
    "prop_dumpster_4a",
    "prop_bin_05a",
    "prop_bin_01a",
    "prop_dumpster_02b",
    "prop_bin_12a",
    "prop_bin_08a",
    "prop_bin_06a",
    "prop_bin_02a",
    "prop_dumpster_01a",
    "prop_dumpster_02a",
    "prop_cs_bin_02",
    "prop_bin_07b",
    "prop_bin_07c",
    "prop_bin_07a",
    "prop_bin_03a",
    "prop_bin_08open",
    "prop_bin_delpiero_b",
    "prop_bin_delpiero",
    "prop_bin_04a",
    "prop_bin_09a",
    "prop_dumpster_3a",
    "prop_dumpster_4b",
    "sc1_07_clinical_bin",
    "prop_gas_binunit01",
    "prop_bin_14a",
    "prop_cs_dumpster_01a",
    "v_serv_waste_bin1",
    "prop_bin_11b",
    "prop_bin_10a",
    "prop_bin_beach_01a",
    "prop_bin_11a",
    "prop_bin_13a",
    "prop_bin_beach_01d",
    "prop_bin_10b",
    "prop_bin_14b",
    "prop_cs_bin_01",
    "prop_cs_bin_03",
    "v_ret_gc_bin",
    "v_ret_csr_bin",
    "v_med_bin",
    "mp_b_kit_bin_01",
    "hei_heist_kit_bin_01",
    "ch_prop_casino_bin_01a",
    "vw_prop_vw_casino_bin_01a",
    "prop_recyclebin_01a",
    "prop_recyclebin_04_a",
    "prop_recyclebin_04_b",
    "prop_recyclebin_05_a",
    "prop_recyclebin_02b",
    "prop_recyclebin_02a",
    "prop_recyclebin_02_d",
    "prop_recyclebin_02_c"
}






RegisterNUICallback('deleteItem', function(data)

    if (not Inv.isInTrunk) then

        local playerPed =  PlayerPedId()
        local playerPosition = GetEntityCoords(playerPed)
        local found = GetClosestObject(Config.trashList, playerPosition)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if (not found) or #(GetEntityCoords(found)-playerPosition) >= 2 then
            NotificationInInventory(Locales[Config.Language]['trash_distance'], 'error')
            return
        end
        if IsPedRagdoll(PlayerPedId())  then
            NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
            return
        end

        if data.item.type == "item_standard" then
            KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
                if result ~= nil then
                    if tonumber(result) then
                        TriggerServerEvent('izey:removeItem', data.item.type, data.item.name, tonumber(result))
                        TaskPlayAnim(playerPed, "random@domestic", "pickup_low" , 8.0, -8.0, 1780, 35, 0.0, false, false, false)
                        loadPlayerInventory('item', nil, true, true)
                    end
                end
            end);

        elseif data.item.type == "item_weapon" then
            if not Config.WeaponNoGive[data.item.name] then 
                TriggerServerEvent('izey:removeItem', data.item.type, data.item.name)
                loadPlayerInventory('item', nil, true, true)
            end
        elseif data.item.type == "item_account" then
            KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
                if result ~= nil then
                    if tonumber(result) then
                        
                        TriggerServerEvent('izey:removeItem', data.item.type, data.item.name, tonumber(result))
                        loadPlayerInventory('item', nil, true, true)
                    end
                end
            end);
        elseif data.item.type == "item_vetement" then

            TriggerServerEvent('izey:removeItem', data.item.type, data.item.id, 1)
            NotificationItem(data.item.name, data.item.label, 1, false)
            loadPlayerInventory('item', nil, true, true)

        elseif data.item.type == "item_phone" then
            TriggerServerEvent('izey:removeItem', 'item_phone', data.item.value, 1)
            Wait(150)
            loadPlayerInventory('item', nil, true, true)
            TriggerEvent('lb-phone:itemRemoved')
        end

    end

end)

-- give item 

RegisterNUICallback('giveItem', function(data)

    if (not Inv.isInTrunk) then

        local playerPed = PlayerPedId()

        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        if IsPedRagdoll(playerPed)  then
            NotificationInInventory(Locales[Config.Language]['no_possible'], 'error')
            return
        end
        if data.item.type == "item_standard" then
            if not Config.ItemNoGive[data.item.name] then 
    
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance < 2.5 then
                    KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
                        if result ~= nil then
                            if tonumber(result) then
                                function_inv:RequestAnimDict("mp_common", function()
                                    TaskPlayAnim(playerPed, "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
                                end)
                                TriggerServerEvent('izey:giveItem', GetPlayerServerId(closestPlayer), data.item.name, tonumber(result), "item_standard")
                                loadPlayerInventory('item', nil, true, true)
    
                            end
                        end
                    end);
    
                else 
                    NotificationInInventory(Locales[Config.Language]['no_player'], 'error')
                end
            else
                NotificationInInventory(Locales[Config.Language]['no_give_item'], 'error')
    
            end
        elseif data.item.type == "item_weapon" then
            if not Config.WeaponNoGive[data.item.name] then 
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance < 2.5 then
                    function_inv:RequestAnimDict("mp_common", function()
                        TaskPlayAnim(playerPed, "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
                    end)
                    TriggerServerEvent('izey:giveItem', GetPlayerServerId(closestPlayer), data.item.name, 255, "item_weapon", data.item.label)
                    Wait(150)
                    loadPlayerInventory('item', nil, true, true)
                else 
                    NotificationInInventory(Locales[Config.Language]['no_player'], 'error')
                end
            else
                NotificationInInventory(Locales[Config.Language]['no_give_weapon'], 'error')
    
            end
    
        elseif data.item.type == "item_account" then 
            local closestPlayer, closestDistance = GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance < 2.5 then
                KeyboardUtils.use(Locales[Config.Language]['quantite'],function(result) 
                    if result ~= nil then
                        if tonumber(result) then
                            function_inv:RequestAnimDict("mp_common", function()
                                TaskPlayAnim(playerPed, "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
                            end)
                            TriggerServerEvent('izey:giveItem', GetPlayerServerId(closestPlayer), data.item.name, tonumber(result), "item_account")
                            loadPlayerInventory('item', nil, true, true)
                        end
                    end
                end);
            else 
                NotificationInInventory(Locales[Config.Language]['no_player'], 'error')
            end
        elseif data.item.type == "item_vetement" then 
            local closestPlayer, closestDistance = GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance < 2.5 then
    
                function_inv:RequestAnimDict("mp_common", function()
                    TaskPlayAnim(playerPed, "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
                end)
                TriggerServerEvent('izey:giveItem', GetPlayerServerId(closestPlayer), data.item.id, 1, "item_vetement")
                Wait(150)
                loadPlayerInventory('item', nil, true, true)
            else 
                NotificationInInventory(Locales[Config.Language]['no_player'], 'error')
            end
    
        elseif data.item.type == "item_phone" then 
            local closestPlayer, closestDistance = GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance < 2.5 then
    
                function_inv:RequestAnimDict("mp_common", function()
                    TaskPlayAnim(playerPed, "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
                end)
                TriggerServerEvent('izey:giveItem', GetPlayerServerId(closestPlayer), data.item.number, 1, data.item.type)
                Wait(150)
                loadPlayerInventory('item', nil, true, true)
            else 
                NotificationInInventory(Locales[Config.Language]['no_player'], 'error')
            end
        end

    end

end)






function ExecAnimInv(anim1, anim2)
    local ped = PlayerPedId()

    RequestAnimDict(anim1)
    while not HasAnimDictLoaded(anim1) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, anim1, anim2, 8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(1000) 
end







-- CreateThread(function()
--     while true do
--         local time = 500
--         if totalWeight >= 40000 then
--             time = 1
--             DisableControlAction(0, 21, true)
--             DisableControlAction(0, 22, true)

--             if NotificationWeight then
--                 NotificationWeight = false
--                 ShowNotification('Personnage ('..(totalWeight/1000)..' KG)\n~r~Vous êtes trop lourd pour courir.')
--             end
--         else
--             NotificationWeight = true
--         end
--         Wait(time)
--     end
-- end)

