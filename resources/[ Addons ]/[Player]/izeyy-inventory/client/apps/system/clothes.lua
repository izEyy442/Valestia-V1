
if not Config.ActiveClothShop then
    return
end

Inv.OpenClothesMenu = false



Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local pCoords = GetEntityCoords(playerPed)
        local isProche = false

        for shopName, shopData in pairs(Config.PosClotheShop) do
            for _, coords in ipairs(shopData.coords) do
                local dist = #(pCoords - coords)
                if dist < Config.ClothMarkerDistance then
                    isProche = true
                    if Config.ClothActiveText then
                        DrawText3D(coords.x, coords.y, coords.z + 1.0, Config.ClothMarkerText)
                    end
                    DrawMarker(Config.ClothMarkerType, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.75, 0.75, 0.75, 20,100,200,230, false, true, false, false, false, false, false, false)
                end
                if dist < 3 then
                    if not Inv.OpenClothesMenu then 
                        ShowHelpNotification(Locales[Config.Language]['help_clothes_shop'])
                        if IsControlJustPressed(0, 38) then
                            Inv.OpenClothesMenu = true
                            OpenClotheShopMenu(shopData.menu, shopData.type)
                        end
                    end
                end
            end
        end

        if isProche then
            Wait(0)
        else
            Wait(750)
        end
    end
end)

Citizen.CreateThread(function()
    for shopName, shopData in pairs(Config.PosClotheShop) do
        for _, coords in ipairs(shopData.coords) do

            blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, shopData.blip.style)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip,shopData.blip.size)
            SetBlipColour(blip, shopData.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(shopName)
            EndTextCommandSetBlipName(blip)
        end
    end
end)




local menuIsOpened = false

local doplus1 = nil

local ClothShop = {
    SlideTShirt = 1,
    SlideGilet = 1,
    SlideTorse = 1,
    SlideBras = 1,
    SlideTShirt2 = 1,
    SlideGilet2 = 1,
    SlideTorse2 = 1,
    SlideBras2 = 1,
    Torse = {},
    tShirt = {},
    Gilet = {},
    Bras = {},
    IndexMalette = 1,
    IndexMalette2 = 1,
    MaletteList = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"},
    MaletteList2 = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"}
}




Config.TypeClothesAccess = {
    {index = 'helmet'},
    {index = 'glasses'},
    {index = 'ears'},
    {index = 'watches'},
    {index = 'bracelets'},
    {index = 'chain'},
    {index = 'bags'},
}




function OpenClotheShopMenu(header, Type)
    if Type == "clothes" then
        local maxValsI = {}
        TriggerEvent('skinchanger:getData', function(components, maxVals)
            maxValsI["tshirt_1"] = maxVals.tshirt_1
            maxValsI["torso_1"] = maxVals.torso_1
            maxValsI["bproof_1"] = maxVals.bproof_1
            maxValsI["pants_1"] = maxVals.pants_1
            maxValsI["shoes_1"] = maxVals.shoes_1
            maxValsI["helmet_1"] = maxVals.helmet_1
            maxValsI["glasses_1"] = maxVals.glasses_1
            maxValsI["ears_1"] = maxVals.ears_1
            maxValsI["bags_1"] = maxVals.bags_1
            maxValsI["gloves_1"] = maxVals.arms
            maxValsI["watches_1"] = maxVals.watches_1
            maxValsI["bracelets_1"] = maxVals.bracelets_1
            maxValsI["chain_1"] = maxVals.chain_1
            maxValsI["decals_1"] = maxVals.decals_1

            ClothShop.Torse = {}
            ClothShop.tShirt = {}
            ClothShop.Gilet = {}
            ClothShop.Bras = {}

            for i = 0, maxVals.torso_1, 1 do
                table.insert(ClothShop.Torse, {Name = tostring(i)})
            end
            for i = 0, maxVals.tshirt_1, 1 do
                table.insert(ClothShop.tShirt, {Name = tostring(i)})
            end
            for i = 0, maxVals.bproof_1, 1 do
                table.insert(ClothShop.Gilet, {Name = tostring(i)})
            end
            for i = 0, maxVals.arms, 1 do
                table.insert(ClothShop.Bras, {Name = tostring(i)})
            end
        end)
        local clothMenu = lgdUI.CreateMenu("", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local Haut = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local pantsMenu = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local shoesMenu = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local AccessoireMenu = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local helmetMenu = lgdUI.CreateSubMenu(AccessoireMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local glassesMenu = lgdUI.CreateSubMenu(AccessoireMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local earsMenu = lgdUI.CreateSubMenu(AccessoireMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local bagsMenu = lgdUI.CreateSubMenu(AccessoireMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local glovesMenu = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local watchesMenu = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local braceletsMenu = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local chainesMenu = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local badgesMenu = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local VariationMenu = lgdUI.CreateSubMenu(clothMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
        local iteratorSelected = nil
        local CurrentValue1 = nil
        local CurrentValue2 = nil
        local CurrentName = nil
        local CurrentCategory = nil
        clothMenu:DisplayGlare(false)
        VariationMenu:DisplayGlare(false)
        pantsMenu:DisplayGlare(false)
        shoesMenu:DisplayGlare(false)
        helmetMenu:DisplayGlare(false)
        glassesMenu:DisplayGlare(false)
        earsMenu:DisplayGlare(false)
        bagsMenu:DisplayGlare(false)
        glovesMenu:DisplayGlare(false)
        watchesMenu:DisplayGlare(false)
        braceletsMenu:DisplayGlare(false)
        chainesMenu:DisplayGlare(false)
        badgesMenu:DisplayGlare(false)
        Haut:DisplayGlare(false)
        AccessoireMenu:DisplayGlare(false)
        VariationMenu.Closed = function()
            Inventaire:DestroyCharCam()
        end
        glassesMenu.Closed = function()
            Inventaire:DestroyCharCam()
        end
        pantsMenu.Closed = function()
            Inventaire:DestroyCharCam()
        end
        Haut.Closed = function()
            Inventaire:DestroyCharCam()
        end
        shoesMenu.Closed = function()
            Inventaire:DestroyCharCam()
        end
        clothMenu.Closed = function()
            refreshskin()
            Inventaire:DestroyCharCam()
            menuIsOpened = false
            Inv.OpenClothesMenu = false
            lgdUI.Visible(clothMenu, false)
            FreezeEntityPosition(PlayerPedId(), false)
        end

        if menuIsOpened then
            menuIsOpened = false
            Inv.OpenClothesMenu = false
            lgdUI.Visible(clothMenu, false)
            refreshskin()
        else
            refreshskin()
            Wait(250)
            TriggerEvent('skinchanger:getSkin', function(skin)
                    menuIsOpened = true
                    lgdUI.Visible(clothMenu, true)
                    Citizen.CreateThread(function()
                        while menuIsOpened do
                            FreezeEntityPosition(PlayerPedId(), true)

                            lgdUI.IsVisible(clothMenu, function()
                                lgdUI.Button(Locales[Config.Language]['register_clothes'], nil, {RightLabel = "~g~"..Config.ClothPriceRegister.." $"}, true, {
                                    onSelected = function()
                                        KeyboardUtils.use(Locales[Config.Language]['choise_name_clothes'],function(result) 
                                            if result ~= nil then
                                                TriggerServerCallback('lgd_clothes:getmoney', function(cb)
                                                    if cb then
                                                        TriggerEvent('skinchanger:getSkin', function(outfit)
                                                            local skin = {
                                                                ["pants_1"] = tonumber(outfit.pants_1), 
                                                                ["pants_2"] = tonumber(outfit.pants_2), 
                                                                ["tshirt_1"] = tonumber(outfit.tshirt_1), 
                                                                ["tshirt_2"] = tonumber(outfit.tshirt_2), 
                                                                ["bproof_1"] = tonumber(outfit.bproof_1), 
                                                                ["bproof_2"] = tonumber(outfit.bproof_2), 
                                                                ["torso_1"] = tonumber(outfit.torso_1), 
                                                                ["torso_2"] = tonumber(outfit.torso_2), 
                                                                ["arms"] = tonumber(outfit.arms), 
                                                                ["arms_2"] = tonumber(outfit.arms_2), 
                                                                ["decals_1"] = tonumber(outfit.decals_1), 
                                                                ["decals_2"] = tonumber(outfit.decals_2),
                                                                ["mask_1"] = tonumber(outfit.mask_1),
                                                                ["mask_2"] = tonumber(outfit.mask_2),
                                                                ["helmet_1"] = tonumber(outfit.helmet_1),
                                                                ["helmet_2"] = tonumber(outfit.helmet_2),
                                                                ["shoes_1"] = tonumber(outfit.shoes_1), 
                                                                ["shoes_2"] = tonumber(outfit.shoes_2), 
                                                                ["chain_1"] = tonumber(outfit.chain_1), 
                                                                ["chain_2"] = tonumber(outfit.chain_2),
                                                            }
                                                            TriggerServerEvent("lgd_inv:addCloth", "outfit", result, skin)
    
                                                            SendTextMessage(Locales[Config.Language]['accept_paie_clothes'], 'success')
                                                        end)
                                                    else
                                                        SendTextMessage(Locales[Config.Language]['refuse_paie_clothes'], 'error')
                                                    end
                                                end, Config.ClothPriceRegister)
                                            end
                                        end);
                                
                                    end
                                })
                                lgdUI.Button(Locales[Config.Language]['save_clothes'], nil, {RightLabel = "~g~"..Config.ClothPriceSave.." $"}, true, {
                                    onSelected = function()
                                        TriggerServerCallback('lgd_clothes:getmoney', function(cb)
                                            if cb then
                                                Inventaire:save()
                                                SendTextMessage(Locales[Config.Language]['accept_paie_clothes'], 'success')

                                            else
                                                SendTextMessage(Locales[Config.Language]['accept_paie_clothes'], 'error')
                                            end
                                        end, Config.ClothPriceSave)
                                
                                    end
                                })
                                lgdUI.Line()
                                lgdUI.Button(Locales[Config.Language]['top'], nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        Inventaire:CreateCharCam('torso')
                                    end
                                }, Haut)
                                lgdUI.Button(Locales[Config.Language]['pants'], nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        CurrentValue1 = "pants_1"
                                        CurrentValue2 = "pants_2"
                                        CurrentName = Locales[Config.Language]['pants'].." "
                                        CurrentCategory = "pants"
                                        Inventaire:CreateCharCam('pants')
                                        TriggerEvent('skinchanger:change', CurrentValue2, 0)
                                    end,
                                }, pantsMenu)
                                lgdUI.Button(Locales[Config.Language]['shoes'], nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        CurrentValue1 = "shoes_1"
                                        CurrentValue2 = "shoes_2"
                                        CurrentName = Locales[Config.Language]['shoes'].." "
                                        CurrentCategory = "shoes"
                                        Inventaire:CreateCharCam('shoes')
                                        TriggerEvent('skinchanger:change', CurrentValue2, 0)
                                    end,
                                }, shoesMenu)

                                lgdUI.Button("Accessoires", nil, {RightLabel = "→"}, true, {}, AccessoireMenu)


                            end)
                            lgdUI.IsVisible(AccessoireMenu, function()

                                for k, v in pairs(Config.TypeClothesAccess) do
                                    lgdUI.Button(Locales[Config.Language][v.index], nil, {RightLabel = "→"}, true, {
                                        onSelected = function()
                                            CurrentValue1 = v.index.."_1"
                                            CurrentValue2 = v.index.."_2"
                                            CurrentName = Locales[Config.Language][v.index]
                                            CurrentCategory = v.index
                                            TriggerEvent('skinchanger:change', CurrentValue2, 0)
                                            if v.index == 'glasses' then
                                                Inventaire:CreateCharCam('face')
                                            end
                                        end,
                                    }, helmetMenu)
                                end
                                

                            end)
                            lgdUI.IsVisible(helmetMenu, function()
                                while not CurrentValue1 do
                                    Wait(1)
                                end

                                for i=0, maxValsI[CurrentValue1] + 1, 1 do
                                    lgdUI.Button(CurrentName.." : "..i, nil, {RightLabel = "~g~"..Config.ClothPrice[CurrentCategory].." $~s~"}, true, {
                                        onActive = function()
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                if tonumber(skin[CurrentValue1]) ~= tonumber(i-1) then
                                                    TriggerEvent('skinchanger:change', CurrentValue1, i-1)
                                                end
                                            end) 
                                        end,
                                        onSelected = function()
                                            iteratorSelected = i-1
                                            doplus1 = true
                                        end
                                    }, VariationMenu)
                                end
                            end)
                            lgdUI.IsVisible(Haut, function()
                                lgdUI.List(Locales[Config.Language]['t-shirt'], ClothShop.tShirt, ClothShop.SlideTShirt, nil, {}, true, {
                                    onListChange = function(Index)
                                        ClothShop.SlideTShirt = Index
                                        TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                                        TriggerEvent('skinchanger:change', 'tshirt_1', ClothShop.SlideTShirt-1)
                                    end
                                })
                                lgdUI.List(Locales[Config.Language]['color_t-shirt'], {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30}, ClothShop.SlideTShirt2, nil, {}, true, {
                                    onListChange = function(Index)
                                        ClothShop.SlideTShirt2 = Index
                                        TriggerEvent('skinchanger:change', 'tshirt_2', ClothShop.SlideTShirt2-1)
                                    end
                                })
                                lgdUI.List(Locales[Config.Language]['vest'], ClothShop.Gilet, ClothShop.SlideGilet, nil, {}, true, {
                                    onListChange = function(Index)
                                        ClothShop.SlideGilet = Index
                                        TriggerEvent('skinchanger:change', 'bproof_2', 0)
                                        TriggerEvent('skinchanger:change', 'bproof_1', ClothShop.SlideGilet-1)
                                    end
                                })
                                lgdUI.List(Locales[Config.Language]['color_vest'], {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30}, ClothShop.SlideGilet2, nil, {}, true, {
                                    onListChange = function(Index)
                                        ClothShop.SlideGilet2 = Index
                                        TriggerEvent('skinchanger:change', 'bproof_2', ClothShop.SlideGilet2-1)
                                    end
                                })
                                lgdUI.List(Locales[Config.Language]['torso'], ClothShop.Torse, ClothShop.SlideTorse, nil, {}, true, {
                                    onListChange = function(Index)
                                        ClothShop.SlideTorse = Index
                                        TriggerEvent('skinchanger:change', 'torso_2', 0)
                                        TriggerEvent('skinchanger:change', 'torso_1', ClothShop.SlideTorse-1)
                                    end
                                })
                                lgdUI.List(Locales[Config.Language]['color_torso'], {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30}, ClothShop.SlideTorse2, nil, {}, true, {
                                    onListChange = function(Index)
                                        ClothShop.SlideTorse2 = Index
                                        TriggerEvent('skinchanger:change', 'torso_2', ClothShop.SlideTorse2-1)
                                    end
                                })
                                lgdUI.List(Locales[Config.Language]['arm'], ClothShop.Bras, ClothShop.SlideBras, nil, {}, true, {
                                    onListChange = function(Index)
                                        ClothShop.SlideBras = Index
                                        TriggerEvent('skinchanger:change', 'arms_2', 0)
                                        TriggerEvent('skinchanger:change', 'arms', ClothShop.SlideBras-1)
                                    end
                                })
                                lgdUI.List(Locales[Config.Language]['color_arm'], {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30}, ClothShop.SlideBras2, nil, {}, true, {
                                    onListChange = function(Index)
                                        ClothShop.SlideBras2 = Index
                                        TriggerEvent('skinchanger:change', 'arms_2', ClothShop.SlideBras2-1)
                                    end
                                })
                                -- lgdUI.Button("Badge", nil, {RightLabel = "→"}, true, {
                                --     onSelected = function()
                                --         CurrentValue1 = "decals_1"
                                --         CurrentValue2 = "decals_2"
                                --         CurrentName = "Badge "
                                --         CurrentCategory = "calque"
                                --         TriggerEvent('skinchanger:change', CurrentValue2, 0)
                                --     end,
                                -- }, badgesMenu)
                                lgdUI.Button(Locales[Config.Language]['buy'], nil, {RightLabel = "~g~"..Config.ClothPrice['top'].." $"}, true, {
                                    onSelected = function()
                                        TriggerServerCallback('lgd_clothes:getmoney', function(cb)
                                            if cb then
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    local haut = {
                                                        ["tshirt_1"] = tonumber(skin.tshirt_1),
                                                        ["tshirt_2"] = tonumber(skin.tshirt_2),
                                                        ["bproof_1"] = tonumber(skin.bproof_1),
                                                        ["bproof_2"] = tonumber(skin.bproof_2),
                                                        ["torso_1"] = tonumber(skin.torso_1),
                                                        ["torso_2"] = tonumber(skin.torso_2),
                                                        ["arms"] = tonumber(skin.arms),
                                                        ["arms_2"] = tonumber(skin.arms_2),
                                                    }
                                                    TriggerServerEvent("lgd_inv:addCloth", "top", Locales[Config.Language]['top'].." "..skin.torso_1, haut)
                                                    SendTextMessage(Locales[Config.Language]['accept_paie_clothes'], 'success')
                                                    ClothShop.SlideTShirt = 1
                                                    ClothShop.SlideGilet = 1
                                                    ClothShop.SlideTorse = 1
                                                    ClothShop.SlideBras = 1
                                                    ClothShop.SlideTShirt2 = 1
                                                    ClothShop.SlideGilet2 = 1
                                                    ClothShop.SlideTorse2 = 1
                                                    ClothShop.SlideBras2 = 1
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent(Config.Trigger['saveSkin'], skin)
                                                    end)

                                                    lgdUI.GoBack() 
                                                    Inventaire:DestroyCharCam()
                                               
                                                end)
                                            else
                                                SendTextMessage(Locales[Config.Language]['accept_paie_clothes'], 'error')
                                            end
                                        end, Config.ClothPrice['top'])
                                    end
                                })
                            end)

                            lgdUI.IsVisible(pantsMenu, function()
                                for i=0, maxValsI["pants_1"], 1 do
                                    lgdUI.Button(Locales[Config.Language]['pants'].." : "..i, nil, {RightLabel = "~g~"..Config.ClothPrice['pants'].." $~s~"}, true, {
                                        onActive = function()
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                if tonumber(skin.pants_1) ~= tonumber(i) then
                                                    TriggerEvent('skinchanger:change', 'pants_1', i)
                                                end
                                            end) 
                                        end,
                                        onSelected = function()
                                            iteratorSelected = i
                                        end
                                    }, VariationMenu)
                                end
                            end)
                            lgdUI.IsVisible(shoesMenu, function()
                                for i=0, maxValsI["shoes_1"], 1 do
                                    lgdUI.Button(Locales[Config.Language]['shoes'].." : "..i, nil, {RightLabel = "~g~"..Config.ClothPrice['shoes'].." $~s~"}, true, {
                                        onActive = function()
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                if tonumber(skin.shoes_1) ~= tonumber(i) then
                                                    TriggerEvent('skinchanger:change', 'shoes_1', i)
                                                end
                                            end) 
                                        end,
                                        onSelected = function()
                                            iteratorSelected = i
                                        end
                                    }, VariationMenu)
                                end
                            end)



                            lgdUI.IsVisible(VariationMenu, function()
                                for j = 0, 30, 1 do 
                                    lgdUI.Button(Locales[Config.Language]['variation'].." : "..j, nil, {}, true, {
                                        onActive = function()
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                if CurrentValue2 == "tshirt_2" then
                                                    if tonumber(skin.tshirt_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "torso_2" then
                                                    if tonumber(skin.torso_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "bproof_2" then
                                                    if tonumber(skin.bproof_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "pants_2" then
                                                    if tonumber(skin.pants_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "shoes_2" then
                                                    if tonumber(skin.shoes_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "arms_2" then
                                                    if tonumber(skin.arms_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "helmet_2" then
                                                    if tonumber(skin.helmet_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "glasses_2" then
                                                    if tonumber(skin.glasses_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "ears_2" then
                                                    if tonumber(skin.ears_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "bags_2" then
                                                    if tonumber(skin.bags_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "watches_2" then
                                                    if tonumber(skin.watches_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "bracelets_2" then
                                                    if tonumber(skin.bracelets_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "chain_2" then
                                                    if tonumber(skin.chain_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                elseif CurrentValue2 == "decals_2" then
                                                    if tonumber(skin.decals_2) ~= tonumber(j) then
                                                        TriggerEvent('skinchanger:change', CurrentValue2, j)
                                                    end
                                                end
                                            end)      
                                        end,
                                        onSelected = function()

                                            TriggerServerCallback('lgd_clothes:getmoney', function(cb)
                                                if cb then
                                                    TriggerServerEvent("lgd_inv:buyClothData", CurrentCategory, CurrentName, CurrentValue1, iteratorSelected, CurrentValue2, j)
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent(Config.Trigger['saveSkin'], skin)
                                                    end)
                                                    SendTextMessage(Locales[Config.Language]['accept_paie_clothes'], 'success')

                                                    Wait(150)
                                                    Inventaire:DestroyCharCam()
                                                    lgdUI.GoBack()
                                                else
                                                    SendTextMessage(Locales[Config.Language]['accept_paie_clothes'], 'error')
                                                end
                                            end, Config.ClothPrice[CurrentCategory])
                                        end
                                    })
                                end
                            end)
                            Wait(1)
                        end
                    end)

            end)
        end
    end

    if Type == "mask" then
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.sex <=1 then
                local maxValsI = nil
                TriggerEvent('skinchanger:getData', function(components, maxVals)
                    maxValsI = maxVals.mask_1
                end)
                local iteratorSelected = nil
                local mainMenu = lgdUI.CreateMenu("", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
                local subMenu = lgdUI.CreateSubMenu(mainMenu, "", Locales[Config.Language]['sub_title_clothes'], nil, nil, header, header)
                mainMenu:DisplayGlare(false)
                subMenu:DisplayGlare(false)
                mainMenu.Closed = function()
                    refreshskin()
                    menuIsOpened = false
                    FreezeEntityPosition(PlayerPedId(), false)
                    lgdUI.Visible(mainMenu, false)
                end
                if menuIsOpened then
                    menuIsOpened = false
                    lgdUI.Visible(mainMenu, false)
                    refreshskin()
                else
                    refreshskin()   
                    menuIsOpened = true
                    lgdUI.Visible(mainMenu, true)
                    Citizen.CreateThread(function()
                        while menuIsOpened do
                            FreezeEntityPosition(PlayerPedId(), true)
                            lgdUI.IsVisible(mainMenu, function()
                                for j = 0, maxValsI, 1 do 
                                    lgdUI.Button(Locales[Config.Language]['mask'].." : "..j, nil, {RightLabel = "~g~"..Config.ClothPrice["mask"].." $~s~"}, true, {
                                        onActive = function()
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                if tonumber(skin.mask_1) ~= tonumber(j) then
                                                    TriggerEvent('skinchanger:change', 'mask_1', j)
                                                end
                                            end)
                                        end,
                                        onSelected = function()
                                            iteratorSelected = j
                                        end,
                                    }, subMenu)
                                end
                            end)
                            lgdUI.IsVisible(subMenu, function()
                                for j = 0, 30, 1 do 
                                    lgdUI.Button(Locales[Config.Language]['variation'].." : "..j, nil, {RightLabel = "~g~"..Config.ClothPrice["mask"].." $"}, true, {
                                        onActive = function()
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                if tonumber(skin.mask_2) ~= tonumber(j) then
                                                    TriggerEvent('skinchanger:change', 'mask_2', j)
                                                end
                                            end)
                                        end,
                                        onSelected = function()
                                            TriggerServerCallback('lgd_clothes:getmoney', function(cb)
                                                if cb then
                                                    TriggerServerEvent("lgd_inv:buyClothData", "mask", Locales[Config.Language]['mask'].." "..iteratorSelected, "mask_1", iteratorSelected, "mask_2", j)
                                                    -- refreshskin()
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent(Config.Trigger['saveSkin'], skin)
                                                    end)
                                                    SendTextMessage(Locales[Config.Language]['accept_paie_clothes'], 'success')
                                                    Wait(150)
                                                    Inventaire:DestroyCharCam()
                                                    lgdUI.GoBack()
                                                else
                                                    SendTextMessage(Locales[Config.Language]['accept_paie_clothes'], 'error')
                                                end
                                            end, Config.ClothPrice["mask"])
                                        end
                                    })
                                end
                            end)
                            Wait(1)
                        end
                    end)
                end
            else
               SendTextMessage("~r~Vous n'avez pas accès avec votre personnage.")
            end
        end)
    end
end






function refreshskin()
    TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end





function Inventaire:CreateCharCam(type,coordsto,pointto, fov)
    local fov = 50.0
    local coords = vector3(0.0,0.0,0.0)
    local point = vector3(0.0,0.0,0.0)
    if type == "face" then
        fov = 10.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),31086,0.0,0.0,0.0)
    elseif type == "root" then
        fov = 15.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),0,0.0,0.0,0.0)
    elseif type == "pants" then
        fov = 20.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),16335,0.0,-0.3,0.0)
    elseif type == "torso" then
        fov = 20.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),0,0.0,0.0,0.2)
    elseif type == "shoes" then
        fov = 10.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),24806,0.0,0.2,0.0)
    elseif type ~= nil and type:find("ZONE") then
        fov = 60.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),coordsto.x,coordsto.y,coordsto.z)
        point = pointto
    else
        fov = fov or 40.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,0.5)
        point = pointto or GetPedBoneCoords(PlayerPedId(),0,0.0,0.0,0.0)
    end
    if CharCamera == nil then
        DestroyAllCams()
        CharCamera = CreateCamera(26379945,1)
        SetCamCoord(CharCamera, coords)
        SetCamFov(CharCamera, fov)
        PointCamAtCoord(CharCamera, point)
        SetCamShakeAmplitude(CharCamera, 13.0)
        RenderScriptCams(1, 1, 1500, 1, 1)
    else

        lgdUI.PlaySound("MUGSHOT_CHARACTER_CREATION_SOUNDS","Zoom_In",false)
        SetCamCoord(CharCamera, coords)
        SetCamFov(CharCamera, fov)
        PointCamAtCoord(CharCamera, point)
        RenderScriptCams(1, 1, 1500, 1, 1)
    end
end

function Inventaire:DestroyCharCam()
    SetCamActive(CharCamera, false)
    RenderScriptCams(false, true, 500, true, true)
    DestroyCam(CharCamera)
    CharCamera = nil
end

