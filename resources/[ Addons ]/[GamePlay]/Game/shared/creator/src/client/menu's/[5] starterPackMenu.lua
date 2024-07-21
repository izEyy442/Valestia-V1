function _Client.open:starterPackMenu()
    local starterPackMenu = RageUIClothes.CreateMenu("", __["how_start"])
    starterPackMenu.Closable = false;

    RageUIClothes.Visible(starterPackMenu, (not RageUIClothes.Visible(starterPackMenu)))
    UtilsCreator:CreatePlayerCam()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_DRUG_DEALER", 0, false)

    while starterPackMenu do
        Wait(0)

        RageUIClothes.IsVisible(starterPackMenu, function()
            FreezeEntityPosition(PlayerPedId(), true)
            RageUIClothes.Line()
            RageUIClothes.Button(__["kit_legal"], (__["kit_legal_desc"]):format(CreatorConfig.starterPack.legal["cash"], CreatorConfig.starterPack.legal["bank"]), {RightLabel = __["choose_this"]}, true, {
                onSelected = function()
                    TriggerServerEvent(_Prefix..":starter:setToPlayer", "legal")
                    UtilsCreator:goLift()
                end
            })
            RageUIClothes.Button(__["kit_illegal"], (__["kit_illegal_desc"]):format(CreatorConfig.starterPack.illegal["black_money"], CreatorConfig.starterPack.illegal["bank"], CreatorConfig.starterPack.illegal["weapon"]), {RightLabel = __["choose_this"]}, true, {
                onSelected = function()
                    TriggerServerEvent(_Prefix..":starter:setToPlayer", "illegal")
                    UtilsCreator:goLift()
                end
            })
        end)

        if not RageUIClothes.Visible(starterPackMenu) then
            starterPackMenu = RMenuClothes:DeleteType('starterPackMenu', true)
            FreezeEntityPosition(PlayerPedId(), false)
            UtilsCreator:KillCam()
        end
    end
end