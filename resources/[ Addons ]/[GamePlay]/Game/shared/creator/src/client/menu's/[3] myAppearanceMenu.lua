local filter = {
    hair = {index = 1},
    beard = {index = 1},
    eyebrow = {index = 1},
    eyecolor = {index = 1},
    makeup = {index = 1},
    lipstick = {index = 1},
}

local settings = {
    Coiffure = 1,
    Barbe = 1,
    MakeUp = 1,
    Lipstick = 1,
    OpaPercentBarbe = 0,
    OpaPercentSourcil = 0,
    OpaPercentMakeUp = 0,
    OpaPercentLipstick = 0,
    ColorCheveux = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },
    ColorBarbes = {
        primary = { 1, 1 },
    },
    ColorSourcils = {
        primary = { 1, 1 }
    },
    ColorMakeUp = {
        primary = { 1, 1 },
        secondary = { 1, 1 },
    },
    ColorLipstick = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },
}

---@type function Render:myAppearanceMenu
function Render:myAppearanceMenu()
    RageUIClothes.Line()
    local Coiffure = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 2)-1, 1 do Coiffure[i] = i end
    local Barbes = {} for i = 0 , GetNumHeadOverlayValues(1)-1, 1 do Barbes[i] = i end
    local Sourcils = {} for i = 0 , GetNumHeadOverlayValues(2)-1, 1 do Sourcils[i] = i end
    local CouleurYeux = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}
    local Maquillage = {} for i = 0 , GetNumHeadOverlayValues(4)-1, 1 do Maquillage[i] = i end
    local Levres = {} for i = 0 , GetNumHeadOverlayValues(8)-1, 1 do Levres[i] = i end

    RageUIClothes.List(__["hair"], Coiffure, filter.hair.index, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, { onActive = function() UtilsCreator:OnRenderCam() end, onListChange = function(Index, Item) filter.hair.index = Index TriggerEvent(CreatorConfig.events.skinchanger..':change', 'hair_1', filter.hair.index - 1) end })
    RageUIClothes.List(__["beard"], Barbes, filter.beard.index, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, { onActive = function() UtilsCreator:OnRenderCam() end, onListChange = function(Index, Item) filter.beard.index = Index TriggerEvent(CreatorConfig.events.skinchanger..':change', 'beard_1', filter.beard.index - 1) end })
    RageUIClothes.List(__["eyebrow"], Sourcils, filter.eyebrow.index, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, { onActive = function() UtilsCreator:OnRenderCam() end, onListChange = function(Index, Item) filter.eyebrow.index = Index TriggerEvent(CreatorConfig.events.skinchanger..':change', 'eyebrows_1', filter.eyebrow.index - 1) end })
    RageUIClothes.List(__["eyecolor"], CouleurYeux, filter.eyecolor.index, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, { onActive = function() UtilsCreator:OnRenderCam() end, onListChange = function(Index, Item) filter.eyecolor.index = Index TriggerEvent(CreatorConfig.events.skinchanger..':change', 'eye_color', filter.eyecolor.index - 1) end })
    RageUIClothes.List(__["makeup"], Maquillage, filter.makeup.index, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, { onActive = function() UtilsCreator:OnRenderCam() end, onListChange = function(Index, Item) filter.makeup.index = Index TriggerEvent(CreatorConfig.events.skinchanger..':change', 'makeup_1', filter.makeup.index - 1) end })
    RageUIClothes.List(__["lipstick"], Levres, filter.lipstick.index, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, { onActive = function() UtilsCreator:OnRenderCam() end, onListChange = function(Index, Item) filter.lipstick.index = Index TriggerEvent(CreatorConfig.events.skinchanger..':change', 'lipstick_1', filter.lipstick.index - 1) end })

    -- Cheveux
    RageUIClothes.ColourPanel(__["main_color"], RageUIClothes.PanelColour.HairCut, settings.ColorCheveux.primary[1], settings.ColorCheveux.primary[2], {
        onColorChange = function(MinimumIndex, CurrentIndex)
            settings.ColorCheveux.primary[1] = MinimumIndex
            settings.ColorCheveux.primary[2] = CurrentIndex
            TriggerEvent(CreatorConfig.events.skinchanger..":change", "hair_color_1", settings.ColorCheveux.primary[2])
        end
    }, 2)
    RageUIClothes.ColourPanel(__["second_color"], RageUIClothes.PanelColour.HairCut, settings.ColorCheveux.secondary[1], settings.ColorCheveux.secondary[2], {
        onColorChange = function(MinimumIndex, CurrentIndex)
            settings.ColorCheveux.secondary[1] = MinimumIndex
            settings.ColorCheveux.secondary[2] = CurrentIndex
            TriggerEvent(CreatorConfig.events.skinchanger..":change", "hair_color_2", settings.ColorCheveux.secondary[2])
        end
    }, 2)

    -- barbes
    RageUIClothes.PercentagePanel(settings.OpaPercentBarbe, 'Opacité', '0%', '100%', {
        onProgressChange = function(Percentage)
            settings.OpaPercentBarbe = Percentage
            TriggerEvent(CreatorConfig.events.skinchanger..':change', 'beard_2',Percentage*10)
        end
    }, 3)
    RageUIClothes.ColourPanel("Couleur de barbe", RageUIClothes.PanelColour.HairCut, settings.ColorBarbes.primary[1], settings.ColorBarbes.primary[2], {
        onColorChange = function(MinimumIndex, CurrentIndex)
            settings.ColorBarbes.primary[1] = MinimumIndex
            settings.ColorBarbes.primary[2] = CurrentIndex
            TriggerEvent(CreatorConfig.events.skinchanger..":change", "beard_3", settings.ColorBarbes.primary[2])
        end
    }, 3)

    -- sourcils
    RageUIClothes.PercentagePanel(settings.OpaPercentSourcil, 'Opacité', '0%', '100%', {
        onProgressChange = function(Percentage)
            settings.OpaPercentSourcil = Percentage
            TriggerEvent(CreatorConfig.events.skinchanger..':change', 'eyebrows_2',Percentage*10)
        end
    }, 4)
    RageUIClothes.ColourPanel("Couleur des sourcils", RageUIClothes.PanelColour.HairCut, settings.ColorSourcils.primary[1], settings.ColorSourcils.primary[2], {
        onColorChange = function(MinimumIndex, CurrentIndex)
            settings.ColorSourcils.primary[1] = MinimumIndex
            settings.ColorSourcils.primary[2] = CurrentIndex
            TriggerEvent(CreatorConfig.events.skinchanger..":change", "eyebrows_3", settings.ColorSourcils.primary[2])
        end
    }, 4)

    -- maquillage
    RageUIClothes.PercentagePanel(settings.OpaPercentMakeUp, 'Opacité', '0%', '100%', {
        onProgressChange = function(Percentage)
            settings.OpaPercentMakeUp = Percentage
            TriggerEvent(CreatorConfig.events.skinchanger..':change', 'makeup_2', Percentage*10)
        end
    }, 6)
    RageUIClothes.ColourPanel(__["main_color"], RageUIClothes.PanelColour.MakeUp, settings.ColorMakeUp.primary[1], settings.ColorMakeUp.primary[2], {
        onColorChange = function(MinimumIndex, CurrentIndex)
            settings.ColorMakeUp.primary[1] = MinimumIndex
            settings.ColorMakeUp.primary[2] = CurrentIndex
            TriggerEvent(CreatorConfig.events.skinchanger..":change", "makeup_3", settings.ColorMakeUp.primary[2] - 1)
        end
    }, 6)
    RageUIClothes.ColourPanel(__["second_color"], RageUIClothes.PanelColour.MakeUp, settings.ColorMakeUp.secondary[1], settings.ColorMakeUp.secondary[2], {
        onColorChange = function(MinimumIndex, CurrentIndex)
            settings.ColorMakeUp.secondary[1] = MinimumIndex
            settings.ColorMakeUp.secondary[2] = CurrentIndex
            TriggerEvent(CreatorConfig.events.skinchanger..":change", "makeup_4", settings.ColorMakeUp.secondary[2] - 1)
        end
    }, 6)

    -- Rouge à lèvre
    RageUIClothes.PercentagePanel(settings.OpaPercentLipstick, 'Opacité', '0%', '100%', {
        onProgressChange = function(Percentage)
            settings.OpaPercentLipstick = Percentage
            TriggerEvent(CreatorConfig.events.skinchanger..':change', 'lipstick_2', Percentage*10)
        end
    }, 7)
    RageUIClothes.ColourPanel(__["main_color"], RageUIClothes.PanelColour.HairCut, settings.ColorLipstick.primary[1], settings.ColorLipstick.primary[2], {
        onColorChange = function(MinimumIndex, CurrentIndex)
            settings.ColorLipstick.primary[1] = MinimumIndex
            settings.ColorLipstick.primary[2] = CurrentIndex
            TriggerEvent(CreatorConfig.events.skinchanger..":change", "lipstick_3", settings.ColorLipstick.primary[2] - 1)
        end
    }, 7)
    RageUIClothes.ColourPanel(__["second_color"], RageUIClothes.PanelColour.HairCut, settings.ColorLipstick.secondary[1], settings.ColorLipstick.secondary[2], {
        onColorChange = function(MinimumIndex, CurrentIndex)
            settings.ColorLipstick.secondary[1] = MinimumIndex
            settings.ColorLipstick.secondary[2] = CurrentIndex
            TriggerEvent(CreatorConfig.events.skinchanger..":change", "lipstick_4", settings.ColorLipstick.secondary[2] - 1)
        end
    }, 7)
end