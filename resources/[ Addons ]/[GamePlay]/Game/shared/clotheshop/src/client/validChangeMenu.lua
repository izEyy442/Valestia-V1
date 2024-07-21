--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local level = 20;
local msg = "Votre garde-robe est pleine, veuillez vous procurer le VIP ~y~Mini~w~ ou ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Extreme~w~ pour l'agrandir."

RegisterNetEvent('shops:setStatVip', function(call)

    if (call == 0) or (call == 1) then 
        level = 20;
    elseif (call == 2) then
        level = 25;
        msg = "Votre garde-robe est pleine, veuillez vous procurer le VIP ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Extreme~w~ pour l'agrandir."
    elseif (call == 3) then
        level = 30;
        msg = "Votre garde-robe est pleine."
    end

end);

---@author Razzway
---@type function Render:validChangeMenu
function Render:validChangeMenu()
    RageUIClothes.Separator("Voulez vous enrengistrer cette Tenue ?")
    RageUIClothes.Line()
    RageUIClothes.Button('Oui', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
        onActive = function() Uclothes:OnRenderCam() end,
        onSelected = function()

            if (#_Razzway.Data < level) then 
                
                local nameTenue = Uclothes:input('Spécifiez le nom de la tenue :');

                if (nameTenue == "" or nameTenue == nil) then
                    ESX.ShowAdvancedNotification('Notification', "Vêtements", "Vous devez attitré un nom à votre tenue pour pouvoir la sauvegarder", 'CHAR_CALL911', 8)
                else

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
                            ["ears_1"] = tonumber(outfit.ears_1), 
                            ["ears_2"] = tonumber(outfit.ears_2),
                            ["watches_1"] = tonumber(outfit.watches_1), 
                            ["watches_2"] = tonumber(outfit.watches_2),
                            ["glasses_1"] = tonumber(outfit.glasses_1), 
                            ["glasses_2"] = tonumber(outfit.glasses_2),
                            ["bracelets_1"] = tonumber(outfit.bracelets_1), 
                            ["bracelets_2"] = tonumber(outfit.bracelets_2),
                            ["bags_1"] = tonumber(outfit.bags_1), 
                            ["bags_2"] = tonumber(outfit.bags_2),
                        }
                        TriggerServerEvent(_Prefix..":saveData", "outfit", nameTenue, skin)
                        ESX.ShowNotification("Vous avez enregistré une nouvelle tenue.")
                    end);
                    _Razzway:refreshData();
                    RageUIClothes.CloseAll();

                end

            else
                ESX.ShowAdvancedNotification('Notification', "Vêtements", msg, 'CHAR_CALL911', 8)
            end

        end
    })
    RageUIClothes.Button('Non', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
        onActive = function() Uclothes:OnRenderCam() end,
        onSelected = function()
            RageUIClothes.CloseAll()
        end
    })
end