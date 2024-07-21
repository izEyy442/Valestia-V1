function Render:myOutfitMenu()
    -- RageUIClothes.Line()
    for _,outfit in pairs(CreatorConfig.outfit) do
        RageUIClothes.Button(outfit.label, nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
            onActive = function() UtilsCreator:OnRenderCam() end,
            onSelected = function()
                UtilsCreator:applySkinSpecific(outfit)
            end
        })
    end
end