local main_menu = RageUI.AddMenu("", "Magasin de Masque")
local filter = {Mask1 = 1, Mask2 = 1}

local function KillCam()
    RenderScriptCams(0, 1, 1500, 0, 0)
    SetCamActive(cam, false)
    ClearPedTasks(PlayerPedId())
    DestroyAllCams(true)
end

local function CreateHeadCam()
    CreateThread(function()
        local pPed = PlayerPedId()
        local pos = GetOffsetFromEntityInWorldCoords(pPed, 0.0, 1.0, 0.7)
        local posLook = GetOffsetFromEntityInWorldCoords(pPed, 0.0, 0.0, 0.65)

        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)

        SetCamActive(cam, true)
        SetCamCoord(cam, pos.x, pos.y, pos.z)
        SetCamFov(cam, 25.0)
        PointCamAtCoord(cam, posLook.x, posLook.y, posLook.z)
        RenderScriptCams(1, 1, 1500, 0, 0)

        while true do
            Wait(500)
            if not main_menu:IsOpen() then

                FreezeEntityPosition(pPed, false)
                KillCam()

                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)

                break

            end
        end
    end)
end

CreateThread(function()
    for k, v in pairs(Config["MaskShop"]["Pos"]) do
        Game.Blip("MaskZone#"..k,
            {
                coords = v,
                label = Config["MaskShop"]["BlipLabel"],
                sprite = 362,
                color = 17,
            }
        );
    end
end)

main_menu:IsVisible(function(Items)
    local Mask1 = {}
    local Mask2 = {}
    local numberOfVariations1 = GetNumberOfPedPropDrawableVariations(PlayerPedId(), 0)
    local numberOfVariations2 = GetNumberOfPedTextureVariations(PlayerPedId(), 1, filter.Mask1)

    for i = 0, numberOfVariations1 do 
        Mask1[i] = i-1
    end

    for i = 0, numberOfVariations2 do 
        Mask2[i] = i-1
    end

    FreezeEntityPosition(PlayerPedId(), true)

    Items:List("Masque", Mask1, filter.Mask1, "Appuyez ~h~ENTRER~h~ pour choisir un numéro", {}, true, {
        onListChange = function(Index)
            filter.Mask1 = Index
            filter.Mask2 = 1
            TriggerEvent('skinchanger:change', 'mask_1', filter.Mask1)
            TriggerEvent('skinchanger:change', 'mask_2', filter.Mask2)
        end,

        onSelected = function()
            local number = tostring(Shared:KeyboardInput("Numero de masque", 3))
            if (Shared:InputIsValid(number, "number")) then
                if tonumber(number) <= tonumber(numberOfVariations1) then

                    filter.Mask1 = number+1
                    filter.Mask2 = 1
                    TriggerEvent('skinchanger:change', 'mask_1', filter.Mask1)
                    TriggerEvent('skinchanger:change', 'mask_2', filter.Mask2)

                end
            end
        end
    })

    Items:List("Variation", Mask2, filter.Mask2, "Appuyez ~h~ENTRER~h~ pour choisir un numéro", {}, true, {
        onListChange = function(Index)
            filter.Mask2 = Index
            TriggerEvent('skinchanger:change', 'mask_2', filter.Mask2)
        end,
        onSelected = function()
            local number = tostring(Shared:KeyboardInput("Numero de masque", 2))
            if (Shared:InputIsValid(number, "number")) then

                if tonumber(number) <= tonumber(numberOfVariations2) then
                    filter.Mask2 = number+1
                    TriggerEvent('skinchanger:change', 'mask_1', filter.Mask1)
                    TriggerEvent('skinchanger:change', 'mask_2', filter.Mask2)
                end
                
            end
        end
    })

    Items:Button("Payer le masque", nil, {Color = { BackgroundColor = { 0, 140, 0, 160 } }}, true, {
        onSelected = function()
            TriggerServerEvent("vCore1:maskshop:pay")
            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)                                    
            end)
            RageUI.CloseAll()
        end
    })
end)

CreateThread(function()
    for k, v in pairs(Config["MaskShop"]["Pos"]) do
        local MaskZone = Game.Zone("MaskShop#"..k)

        MaskZone:Start(function()

            MaskZone:SetTimer(1000)
            MaskZone:SetCoords(v)
        
            MaskZone:IsPlayerInRadius(5.0, function()
                MaskZone:SetTimer(0)
        
                MaskZone:IsPlayerInRadius(2.0, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au magasin de masque")
        
                    MaskZone:KeyPressed("E", function()
                        main_menu:Toggle()
                        CreateHeadCam()
                    end)
        
                end, false, false)
        
            end, false, false)
        
            MaskZone:RadiusEvents(3.0, nil, function()
                main_menu:Close()
            end)
        
        end)
        
    end
end)