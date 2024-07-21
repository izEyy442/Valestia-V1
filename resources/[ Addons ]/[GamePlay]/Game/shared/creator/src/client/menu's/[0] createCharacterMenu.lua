-- ---@type function _Client.open:createCharacteRMenuClothes
-- function _Client.open:createCharacteRMenuClothes()
--     local createCharacteRMenuClothes = RageUIClothes.CreateMenu("", __["welcome"])
--     createCharacteRMenuClothes.Closable = false;

--     RageUIClothes.Visible(createCharacteRMenuClothes, (not RageUIClothes.Visible(createCharacteRMenuClothes)))

--     while createCharacteRMenuClothes do
--         RageUIClothes.IsVisible(createCharacteRMenuClothes, function()
--             Wait(0)
--             RageUIClothes.Line()
--             RageUIClothes.Button(__["create_my_character"], nil, {}, true, {
--                 onSelected = function()
--                     DoScreenFadeOut(2000)
--                     while not IsScreenFadedOut() do Wait(1) end
--                     Wait(1200)
--                     UtilsCreator:KillCam()
--                     SetEntityCoords(PlayerPedId(), CreatorConfig.firstSpawn.pos, false, false, false, false)
--                     SetEntityHeading(PlayerPedId(), CreatorConfig.firstSpawn.heading)
--                     UtilsCreator:SetPlayerBuckets(true)
--                     UtilsCreator:PlayAnimeCreator()
--                     UtilsCreator:CreatePlayerCam()
--                     SetEntityInvincible(PlayerPedId(), false)
--                     FreezeEntityPosition(PlayerPedId(), false)
--                     DoScreenFadeIn(750)
--                     _Client.open:identityMenu()
--                 end
--             })
--         end)

--         if not RageUIClothes.Visible(createCharacteRMenuClothes) then
--             createCharacteRMenuClothes = RMenuClothes:DeleteType('createCharacteRMenuClothes', true)
--         end
--     end
-- end

local grrRazzway = false
local loading = 0.0

---@type function _Client.open:createCharacteRMenuClothes
function _Client.open:createCharacteRMenuClothes()
    local createCharacteRMenuClothes = RageUIClothes.CreateMenu("", __["welcome"])
    createCharacteRMenuClothes.Closable = false;

    RageUIClothes.Visible(createCharacteRMenuClothes, (not RageUIClothes.Visible(createCharacteRMenuClothes)))

    while createCharacteRMenuClothes do
        RageUIClothes.IsVisible(createCharacteRMenuClothes, function()
            Wait(0)
            RageUIClothes.Button(__["create_my_character"], __["create_character_desc"], { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, not grrRazzway, {
                onSelected = function()
                    grrRazzway = true
                end
            })
            -- RageUIClothes.Line()
            if grrRazzway then
                RageUIClothes.PercentagePanel(loading, "Création de vos données... ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..math.floor(loading*100).."%", "", "", {})

                if loading < 1.0 then
                    loading = loading + 0.001
                else
                    loading = 0
                end

                if loading >= 1.0 then
                    DoScreenFadeOut(2000)
                    while not IsScreenFadedOut() do Wait(1) end
                    Wait(1200)
                    UtilsCreator:KillCam()
                    SetEntityCoords(PlayerPedId(), CreatorConfig.firstSpawn.pos, false, false, false, false)
                    SetEntityHeading(PlayerPedId(), CreatorConfig.firstSpawn.heading)
                    UtilsCreator:SetPlayerBuckets(true)
                    UtilsCreator:PlayAnimeCreator()
                    UtilsCreator:CreatePlayerCam()
                    SetEntityInvincible(PlayerPedId(), false)
                    FreezeEntityPosition(PlayerPedId(), false)
                    DoScreenFadeIn(750)
                    _Client.open:identityMenu()
                end
            end
        end)

        if not RageUIClothes.Visible(createCharacteRMenuClothes) then
            createCharacteRMenuClothes = RMenuClothes:DeleteType('createCharacteRMenuClothes', true)
        end
    end
end
