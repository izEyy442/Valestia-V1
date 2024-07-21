local VehicleTrunk = {}
VehicleTrunk.data = {}

--- todo qu'on puisse déposer de l'argent et pour les lspd/bcso qu'il puisse détruire le coffre pour le vider complement

Keys.Register("L", "openCoffreMenu", "Touche pour ouvrir le coffre", function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    if IsPedInAnyVehicle(PlayerPedId(),  false) then
        ESX.ShowAdvancedNotification('Notification', "Coffre", "Vous ne pouvez ouvrir le coffre ici", 'CHAR_CALL911', 8)
        return
    else
        local selectedEntity = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 3.0, 0, 71)
        if (not selectedEntity or selectedEntity == 0) then
            ESX.ShowAdvancedNotification('Notification', "Coffre", "Aucun véhicule à proximité", 'CHAR_CALL911', 8)
        else
            VehicleTrunk.entity = selectedEntity
            TriggerServerEvent("VehicleTrunk:open", NetworkGetNetworkIdFromEntity(selectedEntity))
        end
    end
end)

RegisterNetEvent("VehicleTrunk:openMenu", function(trunkData)
    VehicleTrunk.data = trunkData

    local mainMenu = RageUI.CreateMenu("", "Véhicule Coffre")
    local myInventory = RageUI.CreateSubMenu(mainMenu, "", "Véhicule Coffre")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            if (VehicleTrunk.data ~= nil and DoesEntityExist(VehicleTrunk.entity)) then
                RageUI.Separator("Plaque : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..VehicleTrunk.data["plate"])
                RageUI.Separator("Place : "..VehicleTrunk.data["currentWeight"].."/"..VehicleTrunk.data["maxWeight"].." ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~KG~s~")
                RageUI.Button("Déposer", nil, {
                    RightLabel = "→→"
                }, true, {}, myInventory)
                RageUI.Separator("↓ Contenue du coffre ↓")
                local vehicleStash = VehicleTrunk.data["stash"]
                if (#vehicleStash == 0) then
                    RageUI.Button("Aucun", nil, {}, true, {})
                else
                    for i = 1, #vehicleStash do
                        local itemStash = vehicleStash[i]
                        if (itemStash ~= nil) then
                            RageUI.Button((itemStash.label or itemStash.name).." (x"..itemStash.count..")", nil, {
                                RightLabel = "→"
                            }, true, {
                                onSelected = function()
                                    local selectedCount = tonumber(KeyboardInput("Veuillez saisir la quantité que vous souhaitez.", "", 3))
                                    if (selectedCount ~= nil and selectedCount > 0) then
                                        TriggerServerEvent("VehicleTrunk:takeIn", NetworkGetNetworkIdFromEntity(VehicleTrunk.entity), itemStash.type, itemStash.name, selectedCount)
                                    end
                                end
                            })
                        end
                    end
                end
            end
        end)

        RageUI.IsVisible(myInventory, function()
            local playerData = ESX.GetPlayerData()
            local playerInventory = playerData["inventory"]
            local playerLoadout = playerData["loadout"]

            if (#playerInventory == 0 and #playerLoadout == 0) then
                RageUI.Button("Aucun", nil, {}, true, {})
            else
                for i = 1, #playerLoadout do
                    local weaponData = playerLoadout[i]
                    if (weaponData ~= nil) then
                        RageUI.Button(weaponData.label, nil, {
                            RightLabel = "→"
                        }, true, {
                            onSelected = function()
                                TriggerServerEvent("VehicleTrunk:putIn", NetworkGetNetworkIdFromEntity(VehicleTrunk.entity), "weapon", weaponData.name, 1)
                            end
                        })
                    end
                end

                for i = 1, #playerInventory do
                    local itemData = playerInventory[i]
                    if (itemData ~= nil) then
                        RageUI.Button(itemData.label.." (x"..itemData.count..")", nil, {
                            RightLabel = "→"
                        }, true, {
                            onSelected = function()
                                local selectedCount = tonumber(KeyboardInput("Veuillez saisir la quantité que vous souhaitez.", "", 3))
                                if (selectedCount ~= nil and selectedCount > 0) then
                                    TriggerServerEvent("VehicleTrunk:putIn", NetworkGetNetworkIdFromEntity(VehicleTrunk.entity), "standard", itemData.name, selectedCount)
                                end
                            end
                        })
                    end
                end
            end
        end)

        if (not RageUI.Visible(mainMenu) and not RageUI.Visible(myInventory)) or #(GetEntityCoords(PlayerPedId())-GetEntityCoords(VehicleTrunk.entity)) > 3.0 or VehicleTrunk.data == nil then
            mainMenu = RMenu:DeleteType(mainMenu, true)
        end

        Wait(0)
    end

    TriggerServerEvent("VehicleTrunk:open", NetworkGetNetworkIdFromEntity(VehicleTrunk.entity))
end)

RegisterNetEvent("VehicleTrunk:updateData", function(newData)
    VehicleTrunk.data = newData;
end)