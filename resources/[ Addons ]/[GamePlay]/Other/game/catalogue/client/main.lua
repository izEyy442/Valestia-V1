ESX = nil
local desVehicles = {}
local desCategories= {}
local theCategories
local theCategorieslabel
local isInPreview = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.ESX, function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        local interval = 500
        local coords = GetEntityCoords(PlayerPedId())
        if #(coords - Config.Catalogue.Pos) <= 10 then
            interval = 1
            DrawMarker(Config.Marker.Type, Config.Catalogue.Pos, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], Config.Marker.Color[1], Config.Marker.Color[2], Config.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            if #(coords - Config.Catalogue.Pos) <= 3 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au catalogue")
                if IsControlJustReleased(0, 38) then
                    openCatalogue()
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

openCatalogue = function()
    local mainMenu = RageUI.CreateMenu("", "Consultez nos véhicules")
    local categories = RageUI.CreateSubMenu(mainMenu, "", "Choisissez une catégorie")
    local vehicle = RageUI.CreateSubMenu(mainMenu, "", "Choisissez un véhicule")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Liste des véhicules", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    getCategories()
                end
            }, categories)
        end)

        RageUI.IsVisible(categories, function()
            for k,v in pairs(desCategories) do
                if v.name ~= 'avionfdp' and v.name ~= 'superboat' then
                    RageUI.Button(v.label, nil , {RightLabel = "→"}, true, {
                        onSelected = function()
                            theCategories = v.name
                            theCategorieslabel = v.label
                            getVehicles()
                        end
                    }, vehicle)
                end
            end
        end)

        RageUI.IsVisible(vehicle, function()
            -- RageUI.Separator("Catégorie : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..theCategorieslabel)
            RageUI.Line()
            for k,v in pairs(desVehicles) do
                if v.category == theCategories then
                    RageUI.Button(v.name, nil, { RightLabel = v.price.."~g~$" }, true, {
                        onSelected = function()
                            local plyPed = PlayerPedId()
                            local vehicle = v.model
                            TriggerServerEvent('catalogue:changeBucket', "enter")
                            ESX.Game.SpawnLocalVehicle(vehicle, Config.Catalogue.PosPreview, Config.Catalogue.Heading, function (vehicle)
                                TaskWarpPedIntoVehicle(plyPed, vehicle, -1)
                                FreezeEntityPosition(vehicle, true)
                            end)
                            stopExitCar(true)
                            isInPreview = true
                            RageUI.CloseAll()
                            Citizen.Wait(100)
                            openPreview()
                        end
                    })
                end
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(categories) and not RageUI.Visible(vehicle) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            table.remove(desVehicles, k)
            table.remove(desCategories, k)
        end
        if not RageUI.Visible(categories) then
            desCategories = {}
        end
        if not RageUI.Visible(vehicle) then
            desVehicles = {}
        end
        Citizen.Wait(0)
    end
end

stopExitCar = function(active)
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
        while active do
            Citizen.Wait(0)
            if IsPedInAnyVehicle(ped) then
                DisableControlAction(0, 75, true)
                DisableControlAction(27, 75, true) 
            else
                break
            end
        end
    end)
end

openPreview = function()
    local preview = RageUI.CreateMenu("", "Véhicule prévisualisé")
    RageUI.Visible(preview, not RageUI.Visible(preview))
    while preview do
        RageUI.IsVisible(preview, function()
            RageUI.Button("Revenir au catalogue", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                    SetEntityCoords(PlayerPedId(), Config.Catalogue.Pos)
                    isInPreview = false
                    TriggerServerEvent('catalogue:changeBucket', "leave")
                    RageUI.CloseAll()
                end
            })
        end)
        if not RageUI.Visible(preview) and not isInPreview then
            preview = RMenu:DeleteType(preview, true)
        end
        if not RageUI.Visible(preview) and isInPreview then
            RageUI.Visible(preview, not RageUI.Visible(preview))
        end
        Citizen.Wait(0)
    end
end

getCategories = function()
    ESX.TriggerServerCallback('getCategories', function(cb)
        for i=1, #cb do
            local d = cb[i]
            table.insert(desCategories, {
                name = d.name,
                label = d.label,
            })
        end
    end)
end

getVehicles = function()
    ESX.TriggerServerCallback('getAllVehicles', function(result)
        for i=1, #result do
            local d = result[i]
            table.insert(desVehicles, {
                model = d.model,
                name = d.name,
                price = d.price * 2,
                category = d.category
            })
        end
    end)
end