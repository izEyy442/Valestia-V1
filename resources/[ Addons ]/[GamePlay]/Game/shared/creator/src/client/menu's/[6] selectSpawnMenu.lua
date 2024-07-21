function _Client.open:selectSpawnMenu()
    local selectSpawnMenu = RageUIClothes.CreateMenu("", __["choose_spawn"])
    selectSpawnMenu.Closable = false;

    RageUIClothes.Visible(selectSpawnMenu, (not RageUIClothes.Visible(selectSpawnMenu)))
    UtilsCreator:CreatePlayerCam()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_TOURIST_MAP", 0, false)

    while selectSpawnMenu do
        Wait(0)

        RageUIClothes.IsVisible(selectSpawnMenu, function()
            FreezeEntityPosition(PlayerPedId(), true)
            -- RageUIClothes.Line()
            for _,spawn in pairs(CreatorConfig.afterSpawn) do
                RageUIClothes.Button(arrow.. spawn.name, nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
                    onSelected = function()
                        selectedName = spawn.name
                        selectedPos = spawn.pos
                        selectedHeading = spawn.head
                        UtilsCreator:endIdentity()
                    end
                })
            end
            -- RageUIClothes.Line()
        end)

        if not RageUIClothes.Visible(selectSpawnMenu) then
            selectSpawnMenu = RMenuClothes:DeleteType('selectSpawnMenu', true)
            FreezeEntityPosition(PlayerPedId(), false)
            UtilsCreator:KillCam()
        end
    end
end