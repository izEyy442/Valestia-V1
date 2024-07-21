ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        ESX.PlayerData = ESX.GetPlayerData()
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end
    if ESX.IsPlayerLoaded() then
        ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

openedMenu = false

local chasseMenu = RageUIv3.CreateMenu("", "Chasse")
chasseMenu.Closed = function() FreezeEntityPosition(PlayerPedId(), false) openedMenu = false hasChasse = nil end

function openMenu(chasse)
    if openedMenu then
        openedMenu = false
        RageUIv3.Visible(chasseMenu, false)
        return
    else
        openedMenu = true
        hasChasse = nil
        RageUIv3.Visible(chasseMenu, true)
        FreezeEntityPosition(PlayerPedId(), true)
        Citizen.CreateThread(function()
            while openedMenu  and hasChasse == nil do
                Wait(250)
                ESX.TriggerServerCallback('Chasse:check', function(returnChasse)
                    hasChasse = returnChasse
                end, GetEntityCoords(PlayerPedId()))
            end
        end)
        Citizen.CreateThread(function()
            while ESX.GetPlayerData().job == nil do
                Citizen.Wait(500)
            end
            if ESX.IsPlayerLoaded() then
                ESX.PlayerData = ESX.GetPlayerData()
            end
            while openedMenu do
                Wait(1.0)
                RageUIv3.IsVisible(chasseMenu, true, false, true, function()
                    RageUIv3.Separator("~c~↓~s~ Actions disponible ~c~↓~s~")
                    RageUIv3.Separator("")
                    if hasChasse == nil then
                        RageUIv3.Separator("")
                        RageUIv3.Separator("~c~Chargement ...")
                        RageUIv3.Separator("")
                    else
                        if not hasChasse then
                            RageUIv3.Button("Commencer la chasse", nil, {RightLabel = "→→"}, true, function(h, a ,s)
                                if s then
                                    TriggerServerEvent("Chasse:start", GetEntityCoords(PlayerPedId()), chasse)
                                end
                            end)
                        else
                            RageUIv3.Button("Arrêter la chasse", nil, {RightLabel = "→→"}, true, function(h, a ,s)
                                if s then
                                    TriggerServerEvent("Chasse:stop", true, GetEntityCoords(PlayerPedId()), chasse)
                                end
                            end)
                        end
                    end
                end)
            end
        end)
    end
end

RegisterNetEvent("Chasse:addCount")
AddEventHandler("Chasse:addCount", function(name, count)
    for k,v in pairs(Chasse.Boucherie.Items) do
        if v.itemViande == name or v.itemMorviande == name then
            v.count = v.count+count
        end
    end
end)

RegisterNetEvent("Chasse:removeCount")
AddEventHandler("Chasse:removeCount", function(name, count)
    for k,v in pairs(Chasse.Boucherie.Items) do
        if v.itemViande == name or v.itemMorviande == name then
            v.count = v.count-count
        end
    end
end)

RegisterNetEvent("core:addCountFish")
AddEventHandler("core:addCountFish", function(name, count)
    for k,v in pairs(Chasse.Poissonnerie.Items) do
        if v.itemFish == name or v.itemMorfish == name then
            v.count = v.count+count
        end
    end
end)

RegisterNetEvent("core:removeCountFish")
AddEventHandler("core:removeCountFish", function(name, count)
    for k,v in pairs(Chasse.Poissonnerie.Items) do
        if v.itemFish == name or v.itemMorfish == name then
            v.count = v.count-count
        end
    end
end)

function sChasseInput(textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1',  '', inputText, '', '', '', maxLength)
    while (UpdateOnscreenKeyboard() ~= 1) and (UpdateOnscreenKeyboard() ~= 2) do
         DisableAllControlActions(0)
         Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
         return GetOnscreenKeyboardResult()
    else
         return nil
    end
end
