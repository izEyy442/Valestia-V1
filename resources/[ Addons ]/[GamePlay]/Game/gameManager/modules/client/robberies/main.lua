--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local isRobbing = false
local currentRobbingData = {houseIndex = nil, step = 0, data = {}}
local housesBlips = {}
local housesDataSync = false
local housesData = {}
local closeToHouse = nil
local alreadyRobbedHouses = {}
local isPickingItem = false
local robbItems = {}
local c1 = "~b~"
local c2 = "~b~"

local resellerNPC = nil
local resellerBlip = nil
local resellerPos = nil
local itemsSold = false
local exited = false

-- local lockpickPrefix = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Etat de la serrure: "
local lockpick = { "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Crochetage en cours...", "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Crochetage en cours...", "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Crochetage en cours...", "~r~Crochetage terminé.", "~r~Crochetage terminé.", "~r~Ouverture de la porte." }

local menuDescByHouseState = {
    [true] = {title = "~l~Cambrioler", desc = "Appuyez pour commencer le cambriolage!", style = { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "~l~→→" }},
    [false] = {title = "~l~Repassez plus tard", desc = "Cette maison a été récemment vandalisée, repassez plus tard..", style = {} },
}

-- Police vars
local robbingBlip = {}
local ESX = nil
TriggerEvent(Config.Get.ESX, function(obj)
    ESX = obj
end)

Citizen.CreateThread(function()
    for _,house in pairs(robberiesConfiguration.houses) do
        local blip = AddBlipForCoord(house.outdoorVector)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        SetBlipSprite(blip, 730)
        SetBlipColour(blip, 81)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[Illégal] Cambriolage")
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    TriggerServerEvent("esx_robberies:getHousesStates")
    while not housesDataSync do Citizen.Wait(100) end
    RMenuv1.Add("rz-robberies", 'robb', RageUIv1.CreateMenu("","Cambriolage de maisons"))
    initMenuLoop()
    --[[for _,house in pairs(robberiesConfiguration.houses) do
        local blip = AddBlipForCoord(house.outdoorVector)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        SetBlipSprite(blip, 730)
        SetBlipColour(blip, 81)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[Illégal] Cambriolage")
        EndTextCommandSetBlipName(blip)
    end]]

    local wait = 1
    local closeRange = false

    while true do
        closeRange = false
        local pos = GetEntityCoords(PlayerPedId())
        if not isRobbing then
            for index,house in pairs(robberiesConfiguration.houses) do
                local thisHouseDistance = GetDistanceBetweenCoords(pos,house.outdoorVector, false)
                if thisHouseDistance <= 15 then
                    closeRange = true
                    DrawMarker(20, house.outdoorVector.x, house.outdoorVector.y,house.outdoorVector.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 45,110,185, 255, 55555, false, true, 2, false, false, false, false)
                    if thisHouseDistance <= 1 then
                        closeToHouse = index
                        if not RageUIv1.Visible(RMenuv1:Get("rz-robberies",'robb')) then
                            -- RageUIv1.Text({message = "Appuyez sur [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~s~] pour forcer la serrurre",time_display = 1})
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour forcer la serrurre")
                        end
                        if IsControlJustPressed(0, 51) then
                            housesDataSync = false
                            TriggerServerEvent("esx_robberies:getHousesStates")
                            while not housesDataSync do Citizen.Wait(100) end
                            alteRMenuv1Visibility_()
                        end
                    elseif thisHouseDistance > 1 and RageUIv1.Visible(RMenuv1:Get("rz-robberies",'robb')) then
                        RageUIv1.Visible(RMenuv1:Get("rz-robberies",'robb'), false)
                    end
                else
                    if closeRange ~= true then closeRange = false end
                end
            end
            if closeRange then wait = 1 else wait = 1000 end
        else
            if currentRobbingData.houseIndex ~= nil then
                if currentRobbingData.step == 0 and currentRobbingData.data.lockpick <= #lockpick then
                    RageUIv1.Text({message = lockpick[currentRobbingData.data.lockpick],time_display = 1})
                end
                if currentRobbingData.step == 1 then
                    RageUIv1.Text({message = "Temps restants : "..c2..currentRobbingData.data.maximumTime.." ~s~| Objets restants : "..c2..#robberiesConfiguration.houses[closeToHouse].objects})
                    for k,object in pairs(robberiesConfiguration.houses[closeToHouse].objects) do
                        DrawMarker(32, object.position.x, object.position.y,object.position.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 45,110,185, 255, 55555, false, true, 2, false, false, false, false)
                        local item = robberiesConfiguration.items[object.object]
                        if GetDistanceBetweenCoords(pos,object.position,false) <= 1 and not isPickingItem then
                            AddTextEntry("TEST", "Type: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..item.name.."~n~~s~Prix: ~g~"..item.resellerValue.."$~n~~s~Récupération: ~r~"..item.timeToTake.." secondes~s~~n~~n~Appuyez sur ~INPUT_CONTEXT~ pour voler")
                            DisplayHelpTextThisFrame("TEST", false)
                            if IsControlJustPressed(0,51) then
                                isPickingItem = true
                                FreezeEntityPosition(PlayerPedId(), true)
                                TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
                                Citizen.SetTimeout(1000*item.timeToTake, function()
                                    if isRobbing then
                                        isPickingItem = false
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        ClearPedTasksImmediately(PlayerPedId())
                                        table.remove(robberiesConfiguration.houses[closeToHouse].objects, k)
                                        table.insert(robbItems, {name = item.name, resell = item.resellerValue})
                                    end
                                end)
                            end
                        end
                    end
                    DrawMarker(20, robberiesConfiguration.houses[closeToHouse].exitVector.x, robberiesConfiguration.houses[closeToHouse].exitVector.y,robberiesConfiguration.houses[closeToHouse].exitVector.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 45,110,185, 255, 55555, false, true, 2, false, false, false, false)
                    if GetDistanceBetweenCoords(pos,robberiesConfiguration.houses[closeToHouse].exitVector,false) <= 1.5 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir de la maison")
                        -- AddTextEntry("EXIT", "Appuyez sur ~INPUT_CONTEXT~ pour terminer le cambriolage")
                        -- DisplayHelpTextThisFrame("EXIT", false)
                        if IsControlJustPressed(0,51) then
                            terminate()
                            ESX.ShowAdvancedNotification("Gary McKinnon","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cambriolage","Bravo pour ton cambriolage, tu as ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..#robbItems.." objects ~s~sur toi. Rends toi devant le reseller pour les revendres!","CHAR_HACKEUR",9)
                        end
                    end
                end
            end
            if currentRobbingData.step == 2 then
                -- RageUIv1.Text({message = "Rends-toi au ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~PawnShop~s~ pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~vendre~s~ tes objets.",time_display = 1})
                -- ESX.ShowAdvancedNotification("Gary McKinnon","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cambriolage","Rends-toi au ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~PawnShop~s~ pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~vendre~s~ tes objets.","CHAR_HACKEUR",9)
                if GetDistanceBetweenCoords(pos,resellerPos.vector,false) <= 150.0 then
                    if resellerNPC == nil then
                        local model = GetHashKey(robberiesConfiguration.reseller.model)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(100) end
                        local pedpos = groundVector_(resellerPos.vector.x, resellerPos.vector.y, resellerPos.vector.z)
                        resellerNPC = CreatePed(9, model, resellerPos.vector.x, resellerPos.vector.y, resellerPos.vector.z, resellerPos.heading, false, false)
                        SetEntityInvincible(resellerNPC, true)
                        SetBlockingOfNonTemporaryEvents(resellerNPC, true)
                        Citizen.Wait(3000)
                        FreezeEntityPosition(resellerNPC,true)
                        TaskStartScenarioInPlace(resellerNPC, robberiesConfiguration.reseller.waitingScenario, 0, true)
                    end
                    if GetDistanceBetweenCoords(pos,resellerPos.vector,false) <= 3.0 then

                        -- AddTextEntry("RESEL", "Appuyez sur ~INPUT_CONTEXT~ pour vendre "..#robbItems.. " object(s) volé(s)")
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre "..c2..#robbItems.." object(s) volé(s)")
                        -- DisplayHelpTextThisFrame("RESEL", false)
                        if IsControlJustPressed(0, 51) then
                            if resellerNPC ~= nil then DeleteEntity(resellerNPC) end
                            itemsSold = true
                            ClearAllBlipRoutes()
                            TriggerServerEvent("esx_robberies:money", robbItems);
                            RemoveBlip(resellerBlip)
                            Citizen.Wait(500)
                            isRobbing = false
                            currentRobbingData = {houseIndex = nil, step = 0, data = {}}
                            robbItems = {}

                    end
                end
            end
        end
      end
      Citizen.Wait(wait)
    end
end)

function terminate()
    if exited then return end
    itemsSold = false
    setPlayerInstancied(false)
    FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasksImmediately(PlayerPedId())
    SetEntityCoords(PlayerPedId(), robberiesConfiguration.houses[currentRobbingData.houseIndex].outdoorVector.x, robberiesConfiguration.houses[currentRobbingData.houseIndex].outdoorVector.y, robberiesConfiguration.houses[currentRobbingData.houseIndex].outdoorVector.z, false, false, false, false)
    TriggerEvent('instance:leave')

    closeToHouse = nil
    isPickingItem = false
    c1 = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"
    c2 = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"
    if #robbItems ~= 0 then
        ESX.ShowAdvancedNotification("Gary McKinnon","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cambriolage","Bravo pour ton cambriolage, tu as ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..#robbItems.." objects ~s~sur toi. Rends toi devant le reseller pour les revendres!","CHAR_HACKEUR",9)
        -- DrawAdvancedNotification_("Gary McKinnon","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cambriolage","Bravo pour ton cambriolage, tu as ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..#robbItems.." objects ~s~sur toi. Rends toi devant le reseller pour les revendres!","CHAR_HACKEUR",9)
        currentRobbingData.step = 2
        local randomPos = robberiesConfiguration.reseller.randomizeLocation()
        resellerPos = {vector = randomPos.vector, heading = randomPos.heading}

        resellerBlip = AddBlipForCoord(resellerPos.vector.x,resellerPos.vector.y,resellerPos.vector.z)
        SetBlipSprite(resellerBlip, 480)
        SetBlipDisplay(resellerBlip, 4)
        SetBlipScale(resellerBlip, 0.6)
        SetBlipColour(resellerBlip, 1)
        SetBlipAsShortRange(resellerBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[Illégal] Reseller")
        EndTextCommandSetBlipName(resellerBlip)
        SetBlipRoute(resellerBlip, true)
        SetBlipRouteColour(resellerBlip, 1)
    else
        isRobbing = false
        currentRobbingData = {houseIndex = nil, step = 0, data = {}}
        robbItems = {}
        itemsSold = true
        -- DrawAdvancedNotification_("Gary McKinnon","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cambriolage","T'es sérieux toi ? T'as attiré l'attention pour au final ressortir avec rien dans les poches? On se reverra...","CHAR_HACKEUR",9)
        ESX.ShowAdvancedNotification("Gary McKinnon","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cambriolage","T'es sérieux toi ? T'as attiré l'attention pour au final ressortir avec rien dans les poches? On se reverra...","CHAR_HACKEUR",9)
    end
    exited = true
    Citizen.SetTimeout((1000*60)*robberiesConfiguration.houses[currentRobbingData.houseIndex].timeToGoToReseller, function()
        if not itemsSold then
            if resellerNPC ~= nil then DeleteEntity(resellerNPC) end
            ESX.ShowAdvancedNotification("Gary McKinnon","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cambriolage","T'es vraiment une merde... Tu fais déplacer un reseller pour au final pas te pointer? J'en ai trop vu, à la prochaine!","CHAR_HACKEUR",9)
            -- DrawAdvancedNotification_("Gary McKinnon","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Cambriolage","T'es vraiment une merde... Tu fais déplacer un reseller pour au final pas te pointer? J'en ai trop vu, à la prochaine!","CHAR_HACKEUR",9)
            if resellerPos ~= nil then RemoveBlip(resellerBlip) end
            isRobbing = false
            currentRobbingData = {houseIndex = nil, step = 0, data = {}}
            resellerPos = nil
            robbItems = {}
        end
    end)
end

function initMenuLoop()
    Citizen.CreateThread(function()
        while true do
            RageUIv1.IsVisible(RMenuv1:Get("rz-robberies",'robb'),true,true,true,function()
                RageUIv1.ButtonWithStyle(menuDescByHouseState[housesData[closeToHouse].state].title,menuDescByHouseState[housesData[closeToHouse].state].desc, menuDescByHouseState[housesData[closeToHouse].state].style, housesData[closeToHouse].state, function(Hovered,Active,Selected)
                    if Selected then
                        RageUIv1.Visible(RMenuv1:Get("rz-robberies",'robb'), false)
                        local thisHouseAlreadyRobbed = false
                        for k,v in pairs(alreadyRobbedHouses) do
                            if v == closeToHouse then
                                thisHouseAlreadyRobbed = true
                            end
                        end
                        if not thisHouseAlreadyRobbed then
                            exited = false
                            setPlayerInstancied(true)
                            FreezeEntityPosition(PlayerPedId(), true)
                            Citizen.Wait(1000)
                            TriggerServerEvent("esx_robberies:houseRobbed", closeToHouse)
                            isRobbing = true
                            table.insert(alreadyRobbedHouses, closeToHouse)
                            currentRobbingData = {houseIndex = closeToHouse, step = 0, data = {lockpick = 1}}
                            TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
                            Citizen.Wait(3000)
                            initMission()
                        else
                            _print("Vous avez déjà cambriolé cette maison durant votre session")
                        end
                    end
                end)

            end, function()
            end, 1)
            Citizen.Wait(0)
        end
    end)
end

function initMission()
    Citizen.Wait(10)
    Citizen.CreateThread(function()
        while isRobbing and currentRobbingData.step == 0 and currentRobbingData.data.lockpick <= #lockpick do
            currentRobbingData.data.lockpick = currentRobbingData.data.lockpick + 1
            Citizen.Wait(1000)
        end
        FreezeEntityPosition(PlayerPedId(), false)
        local c = robberiesConfiguration.houses[closeToHouse].interiorVector
        ClearPedTasksImmediately(PlayerPedId())
        DoScreenFadeOut(2000)
        Citizen.Wait(1500)
        SetEntityCoords(PlayerPedId(), c.x,c.y,c.z)
        DoScreenFadeIn(2000)
        Citizen.Wait(1500)
        currentRobbingData.data.initialObjects = #robberiesConfiguration.houses[closeToHouse].objects
        currentRobbingData.data.copsCalledAfter = robberiesConfiguration.houses[closeToHouse].copsCalledAfter
        currentRobbingData.data.maximumTime = robberiesConfiguration.houses[closeToHouse].maximumTime
        currentRobbingData.step = 1
        local stopreason = nil
        local copsCalleds = false
        while isRobbing and stopreason == nil do
            if not copsCalleds then
                if currentRobbingData.data.copsCalledAfter <= 0 then
                    copsCalleds = true
                    c1 = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"
                    ESX.ShowAdvancedNotification("Notification","Valestia","Un témoin oculaire vous a aperçu et a contacté les ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~forces de l'ordre~s~, la police a donc été prévenue et connait votre localisation.","CHAR_CALL911",9)
                    -- DrawAdvancedNotification_("Notification","Valestia","Un témoin oculaire vous a aperçu et a contacté les ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~forces de l'ordre~s~, la police a donc été prévenue et connait votre localisation.","CHAR_CALL911",9)
                    TriggerServerEvent("esx_robberies:callThePolice", currentRobbingData.houseIndex)
                else
                    currentRobbingData.data.copsCalledAfter = currentRobbingData.data.copsCalledAfter-1
                end
            end
            if currentRobbingData.data.maximumTime <= 0 then
                currentRobbingData.data.maximumTime = 0
                c2 = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"
                stopreason = "TIME"
            else
                currentRobbingData.data.maximumTime = currentRobbingData.data.maximumTime - 1
            end
            Citizen.Wait(1000)
        end
        terminate()
    end)
end

function alteRMenuv1Visibility_()
    RageUIv1.Visible(RMenuv1:Get("rz-robberies",'robb'), not RageUIv1.Visible(RMenuv1:Get("rz-robberies",'robb')))
end

function groundVector_(x,y,z)
    local _,groundZ,_ = GetGroundZAndNormalFor_3dCoord(x,y,z)
    return vector3(x,y,groundZ)
end

RegisterNetEvent("esx_robberies:getHousesStates")
AddEventHandler("esx_robberies:getHousesStates", function(array)
    housesData = array
    housesDataSync = true
end)

RegisterNetEvent("initializePoliceBlip")
AddEventHandler("initializePoliceBlip", function(houseIndex,duration)
    PlaySoundFrontend(-1, "Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
    ESX.ShowAdvancedNotification("Notification","Valestia","Un civil a appellé la police à cause d'un possible cambriolage.","CHAR_CALL911",9)

    local houseVector = robberiesConfiguration.houses[houseIndex].outdoorVector

    local blip = AddBlipForCoord(houseVector.x, houseVector.y, houseVector.z)
    SetBlipSprite(blip , 161)
    SetBlipScale(blip , 3.0)
    SetBlipColour(blip, 47)
    PulseBlip(blip)

    Citizen.Wait(1000*duration)

    RemoveBlip(blip)

end)

RegisterNetEvent("esx_robberies:initializePoliceBlip")
AddEventHandler("esx_robberies:initializePoliceBlip", function(houseIndex,duration)
    PlaySoundFrontend(-1, "Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
    -- DrawAdvancedNotification_("Notification","Valestia","Un civil a appellé la police à cause d'un possible cambriolage.","CHAR_CALL911",9)
    ESX.ShowAdvancedNotification("Notification","Valestia","Un civil a appellé la police à cause d'un possible cambriolage.","CHAR_CALL911",9)

    local houseVector = robberiesConfiguration.houses[houseIndex].outdoorVector

    local blip = AddBlipForCoord(houseVector.x, houseVector.y, houseVector.z)
    SetBlipSprite(blip , 161)
    SetBlipScale(blip , 3.0)
    SetBlipColour(blip, 47)
    PulseBlip(blip)

    Citizen.Wait(1000*duration)

    RemoveBlip(blip)

end)

function setPlayerInstancied(bol)
    instancied = bol
    if bol then
    else
    end
    TriggerServerEvent("rs_instance:setPlayerInstanciedState", bol)
end

function DrawAdvancedNotification_(sender, subject, msg, textureDict, iconType)
    SetAudioFlag("LoadMPData", 1)
    PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
	AddTextEntry('AutoEventAdvNotiff', msg)
	BeginTextCommandThefeedPost('AutoEventAdvNotiff')
	EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
end

function CustomString()
    local txt = nil
    AddTextEntry("CREATOR_TXT", "Entrez votre texte.")
    DisplayOnscreenKeyboard(1, "CREATOR_TXT", '', "", '', '', '', 15)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        txt = GetOnscreenKeyboardResult()
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end
    return txt
end

function CustomStringCustomLenght(lenght)
    local txt = nil
    AddTextEntry("CREATOR_TXT", "Entrez votre texte.")
    DisplayOnscreenKeyboard(1, "CREATOR_TXT", '', "", '', '', '', lenght)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        txt = GetOnscreenKeyboardResult()
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end
    return txt
end