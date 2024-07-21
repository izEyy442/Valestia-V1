local acces = false
local VdaPos = 0
local VdaMenu = RageUI.CreateMenu("", "Vendeur d'armes illÉgal", 0, 0, 'commonmenu', 'interaction_bgd')
VdaMenu.Closed = function()
    open = false
end

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

local descs = {
    none = "~r~Pas de restriction de vente.",
    small = "~r~Aucune limite d'arme légère par gang/organisation.",
    medium = "~y~7 ~r~armes moyenne par gang/organisation.",
    hard = "~y~3 ~r~armes lourde par gang/organisation.",
};

---@param type string
---@return string
local function get_desc(type)
    return descs[type];
end

function OpenVdaMenu(lvl)
    if (not IsInPVP) then
        if open then
            open = false
            RageUI.Visible(VdaMenu,false)
            return
        else
            open = true
            RageUI.Visible(VdaMenu,true)
            CreateThread(function()
                while open do
                    local dist = #(GetEntityCoords(PlayerPedId()) - VdaPos)
                    if dist > 5.0 then
                        RageUI.CloseAll()
                        open = false
                    end
                    RageUI.IsVisible(VdaMenu,function()
                        RageUI.Line()
                        RageUI.Separator("VDA Niveau : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..lvl)
                        if lvl == 1 then
                            RageUI.Separator("Armes en vente ")
                            RageUI.Line()
                            for k,v in pairs (ConfigVDA.WeaponSell) do
                                RageUI.Button(v.WeaponLabel, get_desc(v.type), {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price.."$"}, true, {
                                    onSelected = function()
                                        TriggerServerEvent("Vda:BuyWeapon", v.WeaponName, v.price,v.WeaponLabel)
                                    end
                                })
                            end
                        elseif lvl == 2 then
                            RageUI.Separator(" Armes en vente ")
                            RageUI.Line()
                            for k,v in pairs (ConfigVDA.WeaponSellV2) do
                                RageUI.Button(v.WeaponLabel, get_desc(v.type), {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price.."$"}, true, {
                                    onSelected = function()
                                        TriggerServerEvent("Vda:BuyWeapon", v.WeaponName, v.price,v.WeaponLabel)
                                    end
                                })
                            end
                        elseif lvl == 3 then
                            RageUI.Separator(" Armes en vente ")
                            RageUI.Line()
                            for k,v in pairs (ConfigVDA.WeaponSellV3) do
                                RageUI.Button(v.WeaponLabel, get_desc(v.type), {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price.."$"}, true, {
                                    onSelected = function()
                                        TriggerServerEvent("Vda:BuyWeapon", v.WeaponName, v.price,v.WeaponLabel)
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

RegisterNetEvent("Vda:OpenMenu")
AddEventHandler("Vda:OpenMenu", function(lvl)
    OpenVdaMenu(lvl)
end)

RegisterNetEvent("Vda:AddBlips")
AddEventHandler("Vda:AddBlips", function()
    AddBlips()
end)

function AddBlips()
    CreateThread(function()
        local blip = AddBlipForCoord(VdaPos.x, VdaPos.y, VdaPos.z)
        SetBlipSprite(blip, 567)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[Privé] Vendeur d'armes illégal")
        EndTextCommandSetBlipName(blip)
    end)
end

function GetVdaCoords()
    ESX.TriggerServerCallback('Vda:GetVdaCoords', function(cb)
        VdaPos = cb
    end)
end

CreateThread(function()
    GetVdaCoords()
    Wait(2000)
    while true do
        local interval = 800
        local pCoords = GetEntityCoords(PlayerPedId())
        local dst = #(pCoords - VdaPos)
        if dst < 5.0 then
            interval = 1
            DrawMarker(27, VdaPos.x, VdaPos.y, VdaPos.z - 0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
            if dst < 1.0 then
                interval = 1
                if not RageUI.Visible(VdaMenu) then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler au ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vendeur d'armes")
                end
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent("Vda:CheckAccess")
                end
            end
        end

        Wait(interval)
    end
end)