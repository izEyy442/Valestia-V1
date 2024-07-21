--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local filter = {dressing = {index = 1}}

---@author Razzway
---@type function Render:myDressingMenu
function Render:myDressingMenu()
    -- RageUIClothes.Line()
    if _Razzway.Data == nil then 
        BLCCCCCCCCCC = false
        RageUIClothes.GoBack()
    elseif _Razzway.Data == {} then 
        RageUIClothes.Separator("Aucune tenue")
    else
        for _,v in pairs(_Razzway.Data) do
            if v.type == "outfit" then
                RageUIClothes.List((''..v.name..''):format(_Arrow), {
                    {Name = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Equiper la tenue~s~", Type = 1},
                    {Name = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Renommer la tenue~s~", Type = 2},
                    {Name = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Supprimer la tenue~s~", Type = 3},
                    {Name = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Prendre sur Sois~s~", Type = 4},
                }, filter.dressing.index, nil, { LeftBadge = RageUI.BadgeStyle.Star }, nil, {
                    onActive = function() Uclothes:OnRenderCam() end,
                    onListChange = function(Index, Item)
                        filter.dressing.index = Index;
                        selectedType = Item.Type;
                    end,
                    onSelected = function(Index, Item)
                        if selectedType == nil then selectedType = 1 end
                        if selectedType == 1 then
                            CreateThread(function()
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    TriggerEvent('skinchanger:loadClothes', skin, json.decode(v.data))
                                    Citizen.Wait(50)
                                    TriggerEvent('skinchanger:getSkin', function(skin_)
                                        TriggerServerEvent('esx_skin:save', skin_)
                                    end)
                                end)
                            end)
                            ESX.ShowAdvancedNotification('Notification', "Vêtements", "Vous avez enfilé la tenue : "..v.name, 'CHAR_CALL911', 8)
                        end
                        if selectedType == 2 then
                            local newName = Uclothes:input("Nouveau nom à attribuer :")
                            if newName == "" or newName == nil then
                                ESX.ShowAdvancedNotification('Notification', "Vêtements", "Vous devez attitré le nouveau nom de votre tenue pour l'enregistrer", 'CHAR_CALL911', 8)
                            else
                                CreateThread(function()
                                    TriggerEvent('skinchanger:getSkin', function(saveAppearance)
                                        Wait(25)
                                        TriggerServerEvent(_Prefix..":modifyData", v.id, newName)
                                        ESX.ShowAdvancedNotification('Notification', "Vêtements", "Vous avez attribué un nouveau nom à votre tenue :~h~\n- ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Ancien~s~ ~y~→~s~ ("..v.name..")\n- ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Nouveau~s~ ~y~→~s~ ("..newName..")", 'CHAR_CALL911', 8)
                                    end)
                                    Wait(50)
                                    RageUIClothes.GoBack()
                                end)
                            end
                        end

                        if selectedType == 3 then
                            table.remove(_Razzway.Data, _)
                            TriggerServerEvent(_Prefix..':deleteData', tonumber(v.id))
                        end

                        if selectedType == 4 then
                            local nameClothes = Uclothes:input("Nouveau nom de la tenue :")
                            if nameClothes ~= "" and nameClothes ~= nil then
                                exports['izeyy-inventory']:addClothes("outfit", nameClothes, json.decode(v.data))
                                RageUIClothes.GoBack()
                            else
                               ESX.ShowAdvancedNotification('Notification', "Vêtements", "Vous devez attitré le nom de votre tenue pour le prendre sur vous", 'CHAR_CALL911', 8)
                            end
                        end
                    end,
                })
            end
        end       
    end
end