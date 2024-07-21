local acces = false
local BmaPos = 0
local BmaMenu = RageUI.CreateMenu("", "BlackMarket", 0, 0, 'commonmenu', 'interaction_bgd')
BmaMenu.Closed = function()
    open = false
end

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

function OpenBmaMenu(lvl)
    if (not IsInPVP) then
        if open then
            open = false
            RageUI.Visible(BmaMenu,false)
            return
        else
            open = true
            RageUI.Visible(BmaMenu,true)
            CreateThread(function()
                while open do 
                    local dist = #(GetEntityCoords(PlayerPedId()) - BmaPos)
                    if dist > 5.0 then
                        RageUI.CloseAll()
                        open = false
                    end
                    RageUI.IsVisible(BmaMenu,function()
                        -- RageUI.Line()
                        -- RageUI.Separator("Bma Niveau : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..lvl)
                        if lvl == 1 then
                            -- RageUI.Separator("Armes en vente ")
                            -- RageUI.Line()
                            -- for k,v in pairs (ConfigBma.WeaponSell) do
                            --     RageUI.Button(v.WeaponLabel, nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price.."$"}, true, {
                            --         onSelected = function()
                            --             TriggerServerEvent("Bma:BuyWeapon", v.WeaponName, v.price,v.WeaponLabel)
                            --         end
                            --     })
                            -- end
                            -- RageUI.Separator("Objets en vente")
                            -- RageUI.Line()
                            -- for k,v in pairs (ConfigBma.ItemSell) do
                            --     RageUI.Button(v.ItemLabel, nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price.."$"}, true, {
                            --         onSelected = function()
                            --             TriggerServerEvent("Bma:BuyItem", v.ItemName, v.price,v.ItemLabel)
                            --         end
                            --     })
                            -- end
                        elseif lvl == 2 then 
                            -- RageUI.Separator(" Armes en vente ")
                            -- RageUI.Line()
                            -- for k,v in pairs (ConfigBma.WeaponSellV2) do
                            --     RageUI.Button(v.WeaponLabel, nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price.."$"}, true, {
                            --         onSelected = function()
                            --             TriggerServerEvent("Bma:BuyWeapon", v.WeaponName, v.price,v.WeaponLabel)
                            --         end
                            --     })
                            -- end
                            -- RageUI.Line()
                            -- RageUI.Separator("↓ Objets en vente ↓")
                            -- RageUI.Line()
                            for k,v in pairs (ConfigBma.ItemSell) do
                                RageUI.Button(v.ItemLabel, nil, {RightLabel = "[~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price.."$~s~]"}, true, {
                                    onSelected = function()
                                        TriggerServerEvent("Bma:BuyItem", v.ItemName, v.price,v.ItemLabel)
                                    end
                                })
                            end
                        end
                        
                    end)
                    Wait(1)
                end
            end)
        end
    else
        ESX.ShowNotification("Impossible en mode PvP...")
    end
end
RegisterNetEvent("Bma:OpenMenu")
AddEventHandler("Bma:OpenMenu", function(lvl)
    OpenBmaMenu(lvl)
end)
RegisterNetEvent("Bma:AddBlips")
AddEventHandler("Bma:AddBlips", function()
    AddBlips()
end)
function AddBlips()
    CreateThread(function()
        local blip = AddBlipForCoord(BmaPos.x, BmaPos.y, BmaPos.z)
        SetBlipSprite(blip, 567)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[GameMaster] Fournisseur d'outils")
        EndTextCommandSetBlipName(blip)
    end)

end

function GetBmaCoords()
    ESX.TriggerServerCallback('Bma:GetBmaCoords', function(cb)
        BmaPos = cb
    end)
end

CreateThread(function()
    GetBmaCoords()
    Wait(2000)
    while true do
        local interval = 800
        local pCoords = GetEntityCoords(PlayerPedId())
        local dst = #(pCoords - BmaPos)
        if dst < 5.0 then
            interval = 1
            if dst < 1.0 then
                interval = 1
                if not RageUI.Visible(BmaMenu) then
                    DrawMarker(1, BmaPos.x, BmaPos.y, BmaPos.z - 1.10, 0, 0, 0, 0, 0, 0, 1.1, 1.1, 0.5, 45,110,185, 200, 1, 0, 0, 0)
                    Draw3DText(BmaPos.x, BmaPos.y, BmaPos.z, "Appuyez sur [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~s~] ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vente d'outils")
                end
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent("Bma:CheckAccess")
                end
            end
        end
    
        Wait(interval)
    end
end)