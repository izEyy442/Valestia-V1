function _Client.open:creatoRMenuClothes()
    local creatoRMenuClothes = RageUIClothes.CreateMenu("", "Faites votre personnage")
    local myAppearanceMenu = RageUIClothes.CreateSubMenu(creatoRMenuClothes, "", "Mon apparence")
    local myOutfitMenu = RageUIClothes.CreateSubMenu(creatoRMenuClothes, "", "Choisir une tenue")

    creatoRMenuClothes:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = __["right_rotation"]})
    creatoRMenuClothes:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = __["left_rotation"]})

    myAppearanceMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = __["right_rotation"]})
    myAppearanceMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = __["left_rotation"]})

    myOutfitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = __["right_rotation"]})
    myOutfitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = __["left_rotation"]})

    creatoRMenuClothes.Closable = false;
    myAppearanceMenu.EnableMouse = true;

    RageUIClothes.Visible(creatoRMenuClothes, (not RageUIClothes.Visible(creatoRMenuClothes)))
    UtilsCreator:CreatePlayerCam()
    UtilsCreator:loadPlayerAnime()

    local filter = {
        sex = {index = 1},
        face = {index = 1},
        skin= {index = 1},
    }

    while creatoRMenuClothes do
        Wait(0)

        RageUIClothes.IsVisible(creatoRMenuClothes, function()
            FreezeEntityPosition(PlayerPedId(), true)
            local Face = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46}
            local Skin = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46}
            -- RageUIClothes.Line()
            RageUIClothes.List(("%s"..__["sex"]):format(arrow), {
                {Name = "Homme", Value = 0},
                {Name = "Femme", Value = 1},
            }, filter.sex.index, nil, {LeftBadge = RageUI.BadgeStyle.Star}, nil, {
                onActive = function() UtilsCreator:OnRenderCam() end,
                onListChange = function(Index, Item)
                    filter.sex.index = Index;
                end,
                onSelected = function(Index, Item)
                    if Item.Value == 1 then
                        TriggerEvent(CreatorConfig.events.skinchanger..':change', 'sex', Item.Value)
                        Citizen.Wait(50)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                        TriggerEvent('skinchanger:loadClothes', skin, {['bags_1'] = 0, ['bags_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['torso_1'] = 32, ['torso_2'] = 2, ['arms'] = 15, ['pants_1'] = 26, ['pants_2'] = 1, ['shoes_1'] = 17, ['shoes_2'] = 0, ['mask_1'] = 0, ['mask_2'] = 0, ['glasses_1'] = -1, ['glasses_2'] = 0, ['bproof_1'] = 0, ['bproof_2'] = 0, ['helmet_1'] = -1, ['helmet_2'] = 0, ['chain_1'] = 0, ['chain_2'] = 0, ['decals_1'] = 0, ['decals_2'] = 0})
                    end)
                    else
                        TriggerEvent(CreatorConfig.events.skinchanger..':change', 'sex', Item.Value)
                        Citizen.Wait(50)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                        TriggerEvent('skinchanger:loadClothes', skin, {['bags_1'] = 0, ['bags_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['torso_1'] = 5, ['torso_2'] = 2, ['arms'] = 5, ['pants_1'] = 1, ['pants_2'] = 0, ['shoes_1'] = 32, ['shoes_2'] = 0, ['mask_1'] = 0, ['mask_2'] = 0, ['bproof_1'] = 0, ['bproof_2'] = 0, ['helmet_1'] = -1, ['helmet_2'] = 0, ['chain_1'] = 0, ['chain_2'] = 0, ['decals_1'] = 0, ['decals_2'] = 0})
                    end)
                end
            end,
        })
            RageUIClothes.List(("%s"..__["face"]):format(arrow), Face, filter.face.index, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, { onActive = function() UtilsCreator:OnRenderCam() end, onListChange = function(Index, Item) filter.face.index = Index TriggerEvent(CreatorConfig.events.skinchanger..':change', 'face', filter.face.index - 1) end })
            RageUIClothes.List(("%s"..__["skin"]):format(arrow), Skin, filter.skin.index, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, { onActive = function() UtilsCreator:OnRenderCam() end, onListChange = function(Index, Item) filter.skin.index = Index TriggerEvent(CreatorConfig.events.skinchanger..':change', 'skin', filter.skin.index - 1) end })
            RageUIClothes.Button(("%s"..__["my_appearance"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUI.BadgeStyle.Barber}, true, {onActive = function() UtilsCreator:OnRenderCam() end}, myAppearanceMenu)
            RageUIClothes.Button(("%s"..__["my_outfit"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUI.BadgeStyle.Clothes}, true, {onActive = function() UtilsCreator:OnRenderCam() end}, myOutfitMenu)
            RageUIClothes.Button(__["valid_character"], nil, {LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUIClothes.BadgeStyle.Tick}, true, {
                onActive = function() UtilsCreator:OnRenderCam() end,
                onSelected = function()
                    if CreatorConfig.starterPack.enable then
                        TriggerEvent(CreatorConfig.events.skinchanger..':getSkin', function(skin)
                            TriggerServerEvent(CreatorConfig.events.skin..':save', skin)
                        end)
                        UtilsCreator:goKitchen()
                    else
                        TriggerEvent(CreatorConfig.events.skinchanger..':getSkin', function(skin)
                            TriggerServerEvent(CreatorConfig.events.skin..':save', skin)
                        end)
                        UtilsCreator:goLift()
                    end
                end
            })
        end)

        RageUIClothes.IsVisible(myAppearanceMenu, function()
            Render:myAppearanceMenu()
        end)

        RageUIClothes.IsVisible(myOutfitMenu, function()
            Render:myOutfitMenu()
        end)

        if not RageUIClothes.Visible(creatoRMenuClothes)
            and not RageUIClothes.Visible(myAppearanceMenu)
            and not RageUIClothes.Visible(myOutfitMenu)
            then
            creatoRMenuClothes = RMenuClothes:DeleteType("creatoRMenuClothes", true)
            FreezeEntityPosition(PlayerPedId(), false)
            UtilsCreator:KillCam()
        end
    end
end
