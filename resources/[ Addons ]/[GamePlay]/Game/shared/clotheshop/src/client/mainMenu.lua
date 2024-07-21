--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway
---@type function _Client.open:clothesMenu
function _Client.open:clothesMenu()
    local clothesMenu = RageUIClothes.CreateMenu('', 'Que souhaitez-vous faire ?')
    local myDressing = RageUIClothes.CreateSubMenu(clothesMenu, '','Mon Dressing')
    local changeMenu = RageUIClothes.CreateSubMenu(clothesMenu, '', 'Parcourir les Vetements')
    local validChangeMenu = RageUIClothes.CreateSubMenu(changeMenu, '', 'Enrengistrement de votre Tenue')

    clothesMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
    clothesMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})

    myDressing:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
    myDressing:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})

    changeMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
    changeMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})

    validChangeMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
    validChangeMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})

    Uclothes:loadPlayerAnime()
    Uclothes:CreatePlayerCam()
    FreezeEntityPosition(PlayerPedId(), true)

    RageUIClothes.Visible(clothesMenu, (not RageUIClothes.Visible(clothesMenu)))

    while clothesMenu do
        Wait(0)
        RageUIClothes.IsVisible(clothesMenu, function()
            -- RageUIClothes.Line()
            RageUIClothes.Button('Dressing', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" } , true, {
                onActive = function() Uclothes:OnRenderCam() end,
                onSelected = function()
                    _Razzway:refreshData()
                end
            }, myDressing)
            RageUIClothes.Button('Parcourir les Vêtements', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {onActive = function() Uclothes:OnRenderCam() end}, changeMenu)
            RageUIClothes.Line()
            RageUIClothes.Button(('Acheter les Vêtements %s$'):format(_Config.clotheshop.price), nil, { Color = { BackgroundColor = { 0, 115, 243, 170 } }, LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                onActive = function() Uclothes:OnRenderCam() end,
                onSelected = function()
                    TriggerServerEvent(_Prefix..':outfit:pay')
                    Wait(180)
                end
            }, validChangeMenu)
        end)

        RageUIClothes.IsVisible(myDressing, function()
            Render:myDressingMenu()
        end)

        RageUIClothes.IsVisible(changeMenu, function()
            Render:changeMenu()
        end)

        RageUIClothes.IsVisible(validChangeMenu, function()
            Render:validChangeMenu()
        end)

        if not RageUIClothes.Visible(clothesMenu)
            and not RageUIClothes.Visible(myDressing)
            and not RageUIClothes.Visible(changeMenu)
            and not RageUIClothes.Visible(validChangeMenu)
            then
            clothesMenu = RMenuClothes:DeleteType('clothesMenu', true)
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            Wait(180)
            FreezeEntityPosition(PlayerPedId(), false)
            Uclothes:KillCam()
        end
    end
end