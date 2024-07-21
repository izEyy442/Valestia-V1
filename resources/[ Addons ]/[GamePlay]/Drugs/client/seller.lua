SellDrugPointMenu = RageUI.CreateMenu("", "Gestion des Laboratoire(s)")
SellDrugPointSubMenu = RageUI.CreateSubMenu(SellDrugPointMenu, "", "Laboratoire(s) disponibles")
SellDrugPointMenu.Closed = function()  
    RageUI.Visible(SellDrugPointMenu, false) 
    RageUI.Visible(SellDrugPointSubMenu, false) 
    DrugsHandler.MenuIsOpen = false
    DrugsHandler.CurrentLabo = nil
    DrugsHandler.Infos = {}
    DrugsHandler.WaitingFor = false
    FreezeEntityPosition(PlayerPedId(), false)
end 

SellDrugPointSubMenu.Closed = function()
    DrugsHandler.WaitingFor = false
end

OpenSellDrugPointMenu = function()
    if DrugsHandler.MenuIsOpen then 
        DrugsHandler.MenuIsOpen = false 
        RageUI.Visible(SellDrugPointMenu,false)
    else
        DrugsHandler.MenuIsOpen = true 
        RageUI.Visible(SellDrugPointMenu, true)
        CreateThread(function()
            while DrugsHandler.MenuIsOpen do 
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(SellDrugPointMenu, function()
                    for drugs , value in pairs(DrugsHandler.ConfigBuilds) do
                        RageUI.Button(drugs, false, {RightLabel = "→"}, true, {
                            onSelected = function()
                                DrugsHandler.CurrentLabo = drugs
                                Wait(180)
                                DrugsHandler.WaitingFor = true
                            end
                        },SellDrugPointSubMenu)
                    end
                end)
                RageUI.IsVisible(SellDrugPointSubMenu, function()
                    if DrugsHandler.WaitingFor == true then 
                        RageUI.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Laboratoire de "..DrugsHandler.CurrentLabo.." disponibles~s~ ↓")
                        for key, value in pairs (DrugsHandler.ConfigBuilds[DrugsHandler.CurrentLabo].Labo) do 
                            RageUI.Button("Laboratoire de "..string.lower(DrugsHandler.CurrentLabo).." #"..key, "Prix d'achat : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..value.Price.."", {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ →"}, true, {
                                onSelected = function()
                                    DrugsHandler.Infos = {Price = value.Price, Type = DrugsHandler.CurrentLabo, Value = key}
                                    TriggerServerEvent("Laboratories:BuyLaboratories", DrugsHandler.Infos)
                                    SellDrugPointMenu.Closed()
                                end
                            })
                        end 
                    end
                end)
                Wait(1)
            end
        end)
    end
end 
