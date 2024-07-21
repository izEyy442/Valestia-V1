ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.ESX, function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job2 == nil do
        Citizen.Wait(500)
    end
    ESX.playerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job2 == nil do
        Citizen.Wait(500)
    end
    while true do
        local interval = 500
        local plyPos = GetEntityCoords(PlayerPedId())
        if #(plyPos - Config.Illegal.PosPoint) <= 10 then
            interval = 1
            DrawMarker(Config.Marker.Type, Config.Illegal.PosPoint, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], Config.Marker.Color[1], Config.Marker.Color[2], Config.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            if #(plyPos - Config.Illegal.PosPoint) <= 3 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu.")
                if IsControlJustPressed(0, 51) then
                    openIllegalMenu()
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

openIllegalMenu = function()
    local mainMenu = RageUI.CreateMenu("", "Faites vos achats")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            for k,v in pairs(Config.Illegal.Items) do
                RageUI.Button(v.name, nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price.."$"}, true ,{
                    onSelected = function()
                        if v.togivename then
                            TriggerServerEvent('illegal:buy', v.price, v.type, v.togivename)
                        end
                        RageUI.CloseAll()
                    end
                })
            end
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
        Citizen.Wait(0)
    end
end