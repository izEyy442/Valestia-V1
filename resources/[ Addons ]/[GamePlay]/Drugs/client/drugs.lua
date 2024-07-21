ESX  = nil
inLaboratories = false 

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    DrugsHandler.Functions.GetUser()
    DrugsHandler.Functions.GetLabos()
    DrugsHandler.Functions.OwnedBlips()
    DrugsHandler.Functions.GetConfig()
end)

InteractDrugMenu = RageUI.CreateMenu("", "Intéractions disponibles")
InteractListDrugMenu = RageUI.CreateSubMenu(InteractDrugMenu, "", "Laboratoires disponibles")
InteractDrugMenu.Closed = function()  
    RageUI.Visible(InteractDrugMenu, false) 
    RageUI.Visible(InteractListDrugMenu, false) 
    DrugsHandler.MenuIsOpen = false
    FreezeEntityPosition(PlayerPedId(), false)
end 

local enteringCooldown = false 

RegisterNetEvent("Laboratories:OpenInteractMenu")
AddEventHandler("Laboratories:OpenInteractMenu", function(drugsData, identifier)
    DrugsHandler.LaboData = drugsData
    if DrugsHandler.MenuIsOpen then 
        DrugsHandler.MenuIsOpen = false 
        RageUI.Visible(InteractDrugMenu,false)
    else
        DrugsHandler.MenuIsOpen = true 
        RageUI.Visible(InteractDrugMenu, true)
        CreateThread(function()
            while DrugsHandler.MenuIsOpen do 
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(InteractDrugMenu, function()
                    local pCoords = GetEntityCoords(PlayerPedId())
                    for i = 1, #DrugsHandler.LaboData do 
                        if DrugsHandler.LaboData[i].owner == identifier then 
                            DrugsHandler.LaboData[i].exiting = pCoords
                            RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Laboratoire de "..string.lower(DrugsHandler.LaboData[i].type).."~s~ ↓")
                            RageUI.Button("Entrer dans votre laboratoire", false, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    if not enteringCooldown then 
                                        enteringCooldown = true 
                                        TriggerServerEvent("Laboratories:EnteringLaboratories", DrugsHandler.LaboData[i].id, DrugsHandler.LaboData[i].type, DrugsHandler.LaboData[i].value)
                                        SetTimeout(450, function()
                                            enteringCooldown = false
                                        end)
                                    end
                                end
                            })
                        end
                    end   
                    RageUI.Button("Liste des laboratoires", false, {RightLabel = "→"}, true, {}, InteractListDrugMenu)         
                end)
                RageUI.IsVisible(InteractListDrugMenu, function()
                    RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Liste des laboratoire(s)~s~ ↓")
                    for i = 1, #DrugsHandler.LaboData do 
                        if DrugsHandler.LaboData[i].owner ~= identifier then 
                            DrugsHandler.LaboData[i].exiting = pCoords
                            RageUI.Button("Entrer dans le laboratoire "..DrugsHandler.LaboData[i].id, false, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    local password = DrugsHandler.Functions.Input("Password", "Mot de passe :", "", 20)
                                    password = tonumber(password)
                                    if password == DrugsHandler.LaboData[i].password then 
                                        if not enteringCooldown then 
                                            enteringCooldown = true 
                                            TriggerServerEvent("Laboratories:EnteringIntoOtherLaboratories", DrugsHandler.LaboData[i].id, DrugsHandler.LaboData[i].type, DrugsHandler.LaboData[i].value)
                                            SetTimeout(450, function()
                                                enteringCooldown = false
                                            end)
                                        end
                                    else
                                        ESX.ShowAdvancedNotification('Notification', 'Laboratoire', "Mot de passe invalide", 'CHAR_CALL911', 8)
                                    end 
                                end
                            })
                        end
                    end   
                end)
                Wait(1)
            end
        end)
    end
end)

local currentUsing = nil
local WaitingForUpgrade = false 
local laboId = nil 

ComputerMenu = RageUI.CreateMenu("", "Intéractions disponibles")
ComputerBuySuppliesMenu = RageUI.CreateSubMenu(ComputerMenu, "", "Matières disponibles")
ComputerUpgradeMenu = RageUI.CreateSubMenu(ComputerMenu, "", "Améliorations disponibles")
ComputerGestionMenu = RageUI.CreateSubMenu(ComputerMenu, "", "Intéractions disponibles")
ComputerStorageMenu = RageUI.CreateSubMenu(ComputerMenu, "", "Intéractions disponibles")
ComputerDepositMenu = RageUI.CreateSubMenu(ComputerStorageMenu, "", "Objets disponibles")
ComputerWithdrawMenu = RageUI.CreateSubMenu(ComputerStorageMenu, "", "Objets disponibles")
ComputerUpgradeSubMenu = RageUI.CreateSubMenu(ComputerUpgradeMenu, "", "Améliorations disponibles")
ComputerMenu.Closed = function()  
    RageUI.Visible(ComputerMenu, false)
    RageUI.Visible(ComputerUpgradeMenu, false) 
    RageUI.Visible(ComputerGestionMenu, false) 
    RageUI.Visible(ComputerUpgradeSubMenu, false)  
    DrugsHandler.MenuIsOpen = false
    FreezeEntityPosition(PlayerPedId(), false)
    currentUsing, WaitingForUpgrade, laboId = nil, false, nil
end 
ComputerUpgradeSubMenu.Closed = function()
    currentUsing, WaitingForUpgrade, laboId = nil, false, nil
end


RegisterNetEvent("Laboratories:OpenComputerMenu")
AddEventHandler("Laboratories:OpenComputerMenu", function(yourIdentifier)
    local isLocked = false 
    if DrugsHandler.MenuIsOpen then 
        DrugsHandler.MenuIsOpen = false 
        RageUI.Visible(ComputerMenu,false)
    else
        DrugsHandler.MenuIsOpen = true 
        RageUI.Visible(ComputerMenu, true)
        refreshInventory()
        getData()
        CreateThread(function()
            while DrugsHandler.MenuIsOpen do 
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(ComputerMenu, function()
                    RageUI.Button("Achat de matières premières", false, {RightLabel = "→"}, true, {}, ComputerBuySuppliesMenu)
                    RageUI.Button("Améliorations du laboratoire", "Vous permez d'ajoutés des exclusivités à votre laboratoire.", {RightLabel = "→"}, true, {},ComputerUpgradeMenu)
                    RageUI.Button("Gestion du laboratoire", "Vous permez différentes actions sur votre laboratoire.", {RightLabel = "→"}, true, {},ComputerGestionMenu)
                    --RageUI.Button("Stockage du laboratoire", "Vous permez de déposer des objets en sécurité, hors de votre inventaire.", {RightLabel = "→"}, true, {},ComputerStorageMenu)
                end)
                RageUI.IsVisible(ComputerBuySuppliesMenu, function()
                    for i = 1, #DrugsHandler.LaboData do 
                        local labo = DrugsHandler.LaboData[i]
                        local production = labo.production
                        for t = 1, #production do 
                            if production[t] ~= 1 then 
                                isLocked = true 
                            end
                        end
                        for k,v in pairs(DrugsHandler.ConfigSupplies[labo.type]) do
                            if isLocked == false then 
                                RageUI.Button(v.name, v.desc, {RightLabel = ("Prix : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s $"):format(v.price)}, true, {
                                    onSelected = function()
                                        TriggerServerEvent("Laboratories:BuySupplies", labo.id, labo.type, v.price, production, labo.data)
                                    end
                                })
                            else
                                RageUI.Button("Matière premières", "Certains de vos terrains sont encore occupés.", {}, false, {})
                            end
                        end
                    end
                end)
                RageUI.IsVisible(ComputerUpgradeMenu, function()
                    RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Améliorations~s~ ↓")
                    for i = 1, #DrugsHandler.LaboData do 
                        local labo = DrugsHandler.LaboData[i]
                        for k,v in pairs(DrugsHandler.ConfigUpgrades[labo.type]) do 
                            RageUI.Button(catName(k), false, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    currentUsing = k
                                    Wait(180)
                                    WaitingForUpgrade = true
                                end
                            },ComputerUpgradeSubMenu)
                        end
                    end
                end)
                RageUI.IsVisible(ComputerUpgradeSubMenu, function()
                    if WaitingForUpgrade == true then 
                        for i = 1, #DrugsHandler.LaboData do 
                            local labo = DrugsHandler.LaboData[i]
                            local int = labo.data.interiorStatus
                            for k,v in pairs(DrugsHandler.ConfigUpgrades[labo.type][currentUsing]) do 
                                if currentUsing ~= "details" then 
                                    if int == v.value then 
                                        RageUI.Button(v.name, "Vous possèdez déjà ceci.", {RightLabel = "→"}, false, {})
                                    else
                                        RageUI.Button(v.name, v.desc, {RightLabel = ("Prix : %s ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ $"):format(v.price)}, true, {
                                            onSelected = function()
                                                TriggerServerEvent("Laboratories:UpgradeLaboratories", currentUsing, v.value, v.price, labo.type, labo.id, labo.data)
                                            end
                                        })
                                    end
                                else
                                    RageUI.Button(v.name, v.desc, {RightLabel = ("Prix : %s ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ $"):format(v.price)}, true, {
                                        onSelected = function()
                                            TriggerServerEvent("Laboratories:UpgradeLaboratories", currentUsing, v.value, v.price, labo.type, labo.id, labo.data)
                                        end
                                    }) 
                                end
                            end
                        end
                    end
                end)
                RageUI.IsVisible(ComputerGestionMenu, function()
                    RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Gestion du laboratoire~s~ ↓")
                    for i = 1, #DrugsHandler.LaboData do 
                        local data = DrugsHandler.LaboData[i]
                        RageUI.Button(("État du laboratoire: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~"):format(labName(data.data.interiorStatus)), false, {}, true, {})
                        RageUI.Button(("Code du laboratoire: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~"):format(data.password), false, {}, true, {})
                        if data.owner == yourIdentifier then 
                            RageUI.Button("Changer le code du laboratoire", false, {}, true, {
                                onSelected = function()
                                    local newPassword = DrugsHandler.Functions.Input("newPassword", "Veuillez indiquer le nouveau mot de passe", "", 4)
                                    if newPassword ~= "" or newPassword ~= nil then 
                                        newPassword = tonumber(newPassword)
                                        if type(newPassword) == "number" then 
                                            TriggerServerEvent("Laboratories:changePassword", data.id, newPassword)
                                        end
                                    end
                                end
                            })
                            RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Révoquer votre laboratoire~s~", "Attention cette action est irréversible.", {RightBadge = RageUI.BadgeStyle.Alert}, true, {
                                onSelected = function()
                                    TriggerServerEvent("Laboratories:DeleteLaboratories", data.id, data.type, data.value)
                                    ComputerMenu.Closed()
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(ComputerStorageMenu, function()
                    RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Gestion du stockage~s~ ↓")
                    RageUI.Button("Déposer dans le stockage", false, {RightLabel = "→"}, true, {
                        onSelected = function()
                            getData()
                        end
                    },ComputerDepositMenu)
                    RageUI.Button("Retirer du stockage", false, {RightLabel = "→"}, true, {
                        onSelected = function()
                            getData()
                        end
                    },ComputerWithdrawMenu)
                end)
                RageUI.IsVisible(ComputerDepositMenu, function()
                    RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Inventaire~s~ ↓")
                    for _, item in pairs(ESX.PlayerData.inventory) do
                        if item.count > 0 then
                            RageUI.Button(("%s - [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~]"):format(item.label, item.count), false , {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Déposer~s~ →"}, true, {
                                onSelected = function()
                                    local DepositAmount = DrugsHandler.Functions.Input("DepositAmount", "Combien souhaitez-vous déposer ?", "", 3)
                                    if DepositAmount ~= "" or DepositAmount ~= nil then 
                                        DepositAmount = tonumber(DepositAmount)
                                        if type(DepositAmount) == "number" then 
                                            TriggerServerEvent("Laboratories:DepositItems", laboId, DataStorage, item.name, DepositAmount)
                                            Wait(250)
                                            getData()
                                            refreshInventory()
                                        end
                                    end
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(ComputerWithdrawMenu, function()
                    RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Contenu du coffre~s~ ↓")
                    for k,v in pairs (DrugsHandler.LaboData) do 
                        for t,b in pairs (v.storage) do 
                            RageUI.Button(("%s - [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~]"):format(b.label, b.count), false , {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Retirer~s~ →"}, true, {
                                onSelected = function()
                                    local WithdrawAmount = DrugsHandler.Functions.Input("WithdrawAmount", "Combien souhaitez-vous retirer ?", "", 3)
                                    if WithdrawAmount ~= "" or WithdrawAmount ~= nil then 
                                        WithdrawAmount = tonumber(WithdrawAmount)
                                        if type(WithdrawAmount) == "number" then 
                                            TriggerServerEvent("Laboratories:WithdrawItems", v.id, v.storage, t, WithdrawAmount)
                                            Wait(250)
                                            getData()
                                            refreshInventory()
                                        end
                                    end
                                end
                            })
                        end
                    end
                end)
                Wait(1)
            end
        end)
    end
end)

getData = function()
    DataStorage = {}
    for i = 1, #DrugsHandler.LaboData do 
        laboId = DrugsHandler.LaboData[i].id
        DataStorage = DrugsHandler.LaboData[i].storage
    end
end