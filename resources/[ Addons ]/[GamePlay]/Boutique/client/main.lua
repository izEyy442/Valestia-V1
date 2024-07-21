CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(500)
    end
end)
DoScreenFadeIn(500)

local selected = nil;
local lockmenu = true
local quittest = false
local blabla = true
local VehicleJournalier = {}
local components = {
    ["clip_default"] = 250,
    ["clip_extended"] = 500,
    ["clip_drum"] = 750,
    -- ["suppressor"] = 250,
    ["scope"] = 250,
    ["flashlight"] = 250,
    ["grip"] = 250,
    ["luxary_finish"] = 250
};
local blacklistedComponents = {
    ["luxary_finish"] = false,
    ["clip_default"] = false,
    ["suppressor"] = true,
    ["ammo_tracer"] = true,
    ["ammo_armor"] = true,
    ["ammo_fmj"] = true,
    ["ammo_explosive"] = true,
    ["ammo_hollowpoint"] = true,
    ["shells_explosive"] = true,
    ["shells_hollowpoint"] = true,
    ["shells_armor"] = true,
    ["shells_incendiary"] = true
};
local UNARMED = GetHashKey("WEAPON_UNARMED");

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Keys.Register("f1", "menuboutique", "Menu Boutique", function()

    if (IsInPVP) then return; end
    PlaySoundFrontend(-1, 'ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 1)
    OpenMenuMain()
end);

local Coins = 0
local LastVeh = nil
local LastLastVeh = nil
local lastPos = nil
local rot = nil
local index = {
    list = 1
}

local Button = 1

local Action = {
    'Visualiser',
    'Acheter'
 }

local ActionNN = {
   'Visualiser',
--    'Essayer',
   'Acheter'
}

CreateThread(function()
    Wait(2500)
    TriggerServerEvent('ewen:getFivemID')
end)

RegisterNetEvent('ewen:ReceiveFivemId', function(ReceiveInfo)
    fivemid = ReceiveInfo
end)

RegisterNetEvent("hello:bro", function()
    ESX.TriggerServerCallback('ewen:getPoints', function(result)
        Coins = result
    end)
end)

local VehicleSpawned = {}


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function OpenMenuMain()
    local menu = RageUI.CreateMenu("", "Boutique Valestia RP")
    local vehicles = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    local voitures = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    local menu_voiture = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    local avionhelico = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    local bateaux = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    local PacksMenu = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    -- local ArmesMenu = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    local ArmesShopMenu = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    local CustomArmesShopMenu = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    local CaseMenu = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    local VipMenu = RageUI.CreateSubMenu(menu, "", "Boutique Valestia RP")
    voitures.Closed = function()
        if not blabla then
            quittest = true
        end
        DoScreenFadeOut(500)
        Wait(1000)
        lockmenu = true
        DeleteEntity(LastVeh)
        DeleteEntity(LastLastVeh)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityVisible(PlayerPedId(), true, 0)
        SetEntityCoords(PlayerPedId(), lastPos)
        SetFollowPedCamViewMode(1)
        for k,v in pairs(VehicleSpawned) do
            if DoesEntityExist(v.model) then
                Wait(150)
                DeleteEntity(v.model)
                table.remove(VehicleSpawned, k)
            end
        end
        TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
        DoScreenFadeIn(500)
    end

    avionhelico.Closed = function()
        DeleteEntity(LastVeh)
        DeleteEntity(LastLastVeh)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityVisible(PlayerPedId(), true, 0)
        SetEntityCoords(PlayerPedId(), lastPos)
        SetFollowPedCamViewMode(1)
        for k,v in pairs(VehicleSpawned) do
            if DoesEntityExist(v.model) then
                Wait(150)
                DeleteEntity(v.model)
                table.remove(VehicleSpawned, k)
            end
        end
        TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
    end
    bateaux.Closed = function()
        DeleteEntity(LastVeh)
        DeleteEntity(LastLastVeh)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityVisible(PlayerPedId(), true, 0)
        SetEntityCoords(PlayerPedId(), lastPos)
        SetFollowPedCamViewMode(1)
        for k,v in pairs(VehicleSpawned) do
            if DoesEntityExist(v.model) then
                Wait(150)
                DeleteEntity(v.model)
                table.remove(VehicleSpawned, k)
            end
        end
        TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
    end

    ESX.TriggerServerCallback('ewen:getPoints', function(result)
        Coins = result
    end)
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu ~= nil do
        RageUI.IsVisible(menu, function()
            if fivemid == nil then
                fivemid = 'Aucun'
            end
            --RageUI.Separator('Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid)
            --RageUI.Separator('Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..Coins)
            RageUI.Button('~s~Accéder a la Boutique', "Accéder au site web (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Tebex~w~) du serveur.", { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://valestia.tebex.io'
                    })
                end
            })
            RageUI.Button('~s~Historique d\'achat', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    RageUI.CloseAll()
                    OpenHistoryMenu()
                end
            })
            -- RageUI.Line()
            -- RageUI.Button('~s~Exemplaire Limité', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→", Color = { BackgroundColor = { 0, 115, 243, 170 } } }, true, {
            --     onActive = function()
            --         RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
            --         end,
            --     onSelected = function()

            --     end
            -- }, ArmesShopMenu)
            RageUI.Line()
            RageUI.Button('~s~Vehicules', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()

                end
            }, menu_voiture)
            -- RageUI.Separator('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~_______________')
            -- if exports.Game:IsInSafeZone() and not exports.Game:isInCustom() and not exports.Game:IsInMenotte() and not exports.Game:IsInPorter() and not exports.Game:IsInOtage() then
            --     RageUI.Button('~s~Véhicules', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
            --         onActive = function()
            --             RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
            --             end,
            --             onSelected = function()
            --                 DoScreenFadeOut(500)
            --                 Wait(1000)
            --                 lastPos = GetEntityCoords(PlayerPedId())
            --                 rot = 1.0
            --                 SetEntityCoords(PlayerPedId(), vector3(-1072.865234375, -69.829559326172, -96.599792480469))
            --                 SetEntityHeading(PlayerPedId(), 184.531)
            --                 TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', true)
            --                 DoScreenFadeIn(500)
            --             end
            --         }, voitures)
            -- else
            --     RageUI.Button('~s~Véhicules', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
            --         onActive = function()
            --             RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
            --             end,
            --             onSelected = function()
            --                 ESX.ShowAdvancedNotification('Notification', "Boutique", "Vous devez être en Zone Safe pour acceder à cette catégorie", 'CHAR_CALL911', 8)
            --             end
            --         })
            -- end
                --RageUI.Button('~s~Armes Permanente', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
               --     onActive = function()
                 --       RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                  --      end,
                  --  onSelected = function()
    
                   -- end
                --}, ArmesShopMenu)
                RageUI.Button("~s~Customisation d'armes", nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                    onActive = function()
                        RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                        end,
                    onSelected = function()

                    end
                }, CustomArmesShopMenu)
            RageUI.Button('~s~Packs', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()

                end
            }, PacksMenu)

            -- RageUI.Button('~s~Caisse Mystère', nil, {}, true, {
            --     onActive = function()
            --         RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
            --         end,
            --     onSelected = function()

            --     end
            -- }, CaseMenu)
            RageUI.Button('~s~Caisse Mystère', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    ExecuteCommand("caseOpening")
                    RageUI.CloseAll()
                end,
            })
            -- RageUI.Line()
            -- RageUI.Separator('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~_______________')
            RageUI.Button("~s~VIP", nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()

                end
            }, VipMenu)
        end)
        -- RageUI.IsVisible(vehicles, function()
        --     RageUI.Button('Voitures', nil, {}, true, {
        --         onSelected = function()
        --             lastPos = GetEntityCoords(PlayerPedId())
        --             rot = 1.0
        --             SetEntityCoords(PlayerPedId(), vector3(-1072.865234375, -69.829559326172, -96.599792480469))
        --             SetEntityHeading(PlayerPedId(), 184.531)
        --             TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', true)
        --         end
        --     }, voitures)

        RageUI.IsVisible(voitures, function()
            for k,v in pairs(BoutiqueVehicles) do
                RageUI.List(v.label..'', ActionNN, index.list, nil, {}, lockmenu, {
                        onActive = function()
                            RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Prix : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..v.price..' Coins','~w~Modele : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..v.label, '~w~Description : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..v.description}, {})
                            FreezeEntityPosition(PlayerPedId(), true)
                            SetEntityVisible(PlayerPedId(), false, 0)
                            SetWeatherTypeNow('EXTRASUNNY')
                            SetFollowPedCamViewMode(4)
                            if LastVeh ~= nil then
                                rot = rot + 0.10
                                SetEntityHeading(LastVeh, rot)
                            end
                        end,
                        onListChange = function(Index, Item)
                            index.list = Index;
                            Button = Index;
                        end,
                        onSelected = function()
                            if lockmenu then
                                if Button == 1 then
                                    if not blabla then
                                        quittest = true
                                    end
                                    lockmenu = false
                                    SetEntityCoords(PlayerPedId(), vector3(-1072.5211181641, -76.566101074219, -95.524160766602))
                                    if ESX.Game.IsSpawnPointClear(vector3(-1072.5295410156, -80.985336303711, -94.599838256836), 100) then
                                        ESX.Game.SpawnLocalVehicle(v.model, vector3(-1072.5295410156, -80.985336303711, -94.599838256836), 111.14987182617188, function(vehicle)
                                            lockmenu = true
                                            LastVeh = vehicle
                                            FreezeEntityPosition(vehicle, true)
                                            SetVehicleDoorsLocked(vehicle, 2)
                                            SetEntityInvincible(vehicle, true)
                                            SetVehicleFixed(vehicle)
                                            SetVehicleDirtLevel(vehicle, 0.0)
                                            SetVehicleEngineOn(vehicle, true, true, true)
                                            SetVehicleLights(vehicle, 2)
                                            SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                            SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                            table.insert(VehicleSpawned, {model = vehicle})
                                        end)
                                    else
                                        lockmenu = false
                                        DeleteEntity(LastVeh)
                                        DeleteEntity(LastLastVeh)
                                        ESX.Game.SpawnLocalVehicle(v.model, vector3(-1072.5295410156, -80.985336303711, -94.599838256836), 111.14987182617188, function(vehicle)
                                            lockmenu = true
                                            LastVeh = vehicle
                                            FreezeEntityPosition(vehicle, true)
                                            SetVehicleDoorsLocked(vehicle, 2)
                                            SetEntityInvincible(vehicle, true)
                                            SetVehicleFixed(vehicle)
                                            SetVehicleDirtLevel(vehicle, 0.0)
                                            SetVehicleEngineOn(vehicle, true, true, true)
                                            
                                            SetVehicleLights(vehicle, 2)
                                            SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                            SetVehicleCustomSecondaryColour(vehicle, 33,33,33)

                                            table.insert(VehicleSpawned, {model = vehicle})
                                        end)
                                    end
                                elseif Button == 3 then
                                    if LastLastVeh == nil then
                                        lockmenu = false
                                        blabla = false
                                        if not blabla then
                                            quittest = false
                                        end
                                        DoScreenFadeOut(500)
                                        Wait(1000)
                                        ESX.ShowAdvancedNotification('Notification', "Boutique", "Vous disposez de 30 secondes pour votre test", 'CHAR_CALL911', 8)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        SetEntityVisible(PlayerPedId(), true, 0)
                                        SetFollowPedCamViewMode(1)
                                        SetEntityCoords(PlayerPedId(), -871.19, -3220.34, 13.94)
                                        DeleteEntity(LastVeh)
                                        DeleteEntity(LastLastVeh)
                                        ESX.Game.SpawnLocalVehicle(v.model, vector3(-871.19, -3220.34, 13.94), 111.14987182617188, function(vehicle)
                                            lockmenu = true
                                            LastLastVeh = vehicle
                                            SetVehicleDoorsLocked(vehicle, 2)
                                            SetEntityInvincible(vehicle, true)
                                            SetVehicleDirtLevel(vehicle, 0.0)
                                            SetVehicleEngineOn(vehicle, true, true, true)
                                            SetVehicleLights(vehicle, 2)
                                            SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                            SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                            table.insert(VehicleSpawned, {model = vehicle})
                                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                        end)
                                        SetTimeout(31000, function()
                                            if not quittest then
                                                lockmenu = false
                                                DoScreenFadeOut(500)
                                                Wait(1000)
                                                DeleteEntity(LastLastVeh)
                                                ESX.ShowAdvancedNotification('Notification', "Boutique", "Vous venez de finir votre test de 30 secondes", 'CHAR_CALL911', 8)
                                                SetEntityCoords(PlayerPedId(), vector3(-1072.5211181641, -76.566101074219, -95.524160766602))
                                                ESX.Game.SpawnLocalVehicle(v.model, vector3(-1072.5295410156, -80.985336303711, -94.599838256836), 111.14987182617188, function(vehicle)
                                                    lockmenu = true
                                                    LastVeh = vehicle
                                                    FreezeEntityPosition(vehicle, true)
                                                    SetVehicleDoorsLocked(vehicle, 2)
                                                    SetEntityInvincible(vehicle, true)
                                                    SetVehicleFixed(vehicle)
                                                    SetVehicleDirtLevel(vehicle, 0.0)
                                                    SetVehicleEngineOn(vehicle, true, true, true)
                                                    SetVehicleLights(vehicle, 2)
                                                    SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                                    SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                                    table.insert(VehicleSpawned, {model = vehicle})
                                                end)
                                                LastLastVeh = nil
                                                DoScreenFadeIn(500)
                                            end
                                            LastLastVeh = nil
                                            blabla = true
                                            quittest = false
                                        end)
                                        DoScreenFadeIn(500)
                                    else
                                        ESX.ShowAdvancedNotification('Notification', "Boutique", "Vous venez de faire un test attendez un peut", 'CHAR_CALL911', 8)
                                    end
                                elseif Button == 2 then
                                    if not blabla then
                                        quittest = true
                                    end
                                    local Confirm = KeyboardInput("Confirmer vous votre achat ?", "Oui / Non", 10)

                                    if Confirm == "Oui" then
                                        TriggerServerEvent('aBoutique:BuyVehicle', v.model, v.price, v.label)
                                        DeleteEntity(LastVeh)
                                        DeleteEntity(LastLastVeh)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        SetEntityVisible(PlayerPedId(), true, 0)
                                        SetEntityCoords(PlayerPedId(), lastPos)
                                        SetFollowPedCamViewMode(1)
                                        for k,v in pairs(VehicleSpawned) do
                                            if DoesEntityExist(v.model) then
                                                Wait(150)
                                                DeleteEntity(v.model)
                                                table.remove(VehicleSpawned, k)
                                            end
                                        end
                                        TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
                                        RageUI.CloseAll()
                                    else
                                        ESX.ShowAdvancedNotification('Notification', "Boutique", "Achat non confirmer", 'CHAR_CALL911', 8)
                                        DeleteEntity(LastVeh)
                                        DeleteEntity(LastLastVeh)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        SetEntityVisible(PlayerPedId(), true, 0)
                                        SetEntityCoords(PlayerPedId(), lastPos)
                                        SetFollowPedCamViewMode(1)
                                        for k,v in pairs(VehicleSpawned) do
                                            if DoesEntityExist(v.model) then
                                                Wait(150)
                                                DeleteEntity(v.model)
                                                table.remove(VehicleSpawned, k)
                                            end
                                        end
                                        TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
                                        RageUI.CloseAll()
                                    end
                                end
                        end
                    end
                })
            end
        end)
        RageUI.IsVisible(avionhelico, function()
            for k,v in pairs(BoutiqueAirPlaines) do
                RageUI.List(GetLabelText(v.model)..' | Prix : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..v.price, Action, index.list, nil, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
                    onActive = function()
                        FreezeEntityPosition(PlayerPedId(), true)
                        SetEntityVisible(PlayerPedId(), false, 0)
                        SetWeatherTypeNow('EXTRASUNNY')
                        SetFollowPedCamViewMode(4)
                        if LastVeh ~= nil then
                            rot = rot + 0.10
                            SetEntityHeading(LastVeh, rot)
                        end
                    end,
                    onListChange = function(Index, Item)
                        index.list = Index;
                        Button = Index;
                    end,
                    onSelected = function()
                        if Button == 1 then
                            if ESX.Game.IsSpawnPointClear(vector3(-970.8639, -2999.831, 13.945), 100) then
                                ESX.Game.SpawnLocalVehicle(v.model, vector3(-970.8639, -2999.831, 13.945), 337.120, function(vehicle)
                                    LastVeh = vehicle
                                    FreezeEntityPosition(vehicle, true)
                                    SetVehicleDoorsLocked(vehicle, 2)
                                    SetEntityInvincible(vehicle, true)
                                    SetVehicleFixed(vehicle)
                                    SetVehicleDirtLevel(vehicle, 0.0)
                                    SetVehicleEngineOn(vehicle, true, true, true)
                                    SetVehicleLights(vehicle, 2)
                                    SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                    SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                    table.insert(VehicleSpawned, {model = vehicle})
                                end)
                            else
                                DeleteEntity(LastVeh)
                                DeleteEntity(LastLastVeh)
                                ESX.Game.SpawnLocalVehicle(v.model, vector3(-970.8639, -2999.831, 13.945), 337.120, function(vehicle)
                                    LastVeh = vehicle
                                    FreezeEntityPosition(vehicle, true)
                                    SetVehicleDoorsLocked(vehicle, 2)
                                    SetEntityInvincible(vehicle, true)
                                    SetVehicleFixed(vehicle)
                                    SetVehicleDirtLevel(vehicle, 0.0)
                                    SetVehicleEngineOn(vehicle, true, true, true)
                                    SetVehicleLights(vehicle, 2)
                                    SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                    SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                    table.insert(VehicleSpawned, {model = vehicle})
                                end)
                            end
                        elseif Button == 2 then
                            TriggerServerEvent('aBoutique:BuyVehiclePlane', v.model, GetLabelText(v.model))
                            DeleteEntity(LastVeh)
                            DeleteEntity(LastLastVeh)
                            FreezeEntityPosition(PlayerPedId(), false)
                            SetEntityVisible(PlayerPedId(), true, 0)
                            SetEntityCoords(PlayerPedId(), lastPos)
                            SetFollowPedCamViewMode(1)
                            for k,v in pairs(VehicleSpawned) do
                                if DoesEntityExist(v.model) then
                                    Wait(150)
                                    DeleteEntity(v.model)
                                    table.remove(VehicleSpawned, k)
                                end
                            end
                            TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
                            RageUI.CloseAll()
                        end
                    end
                })
            end
		end)

        RageUI.IsVisible(bateaux, function()
            for k,v in pairs(BoutiqueBoat) do
                RageUI.List(GetLabelText(v.model)..' | Prix : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..v.price, Action, index.list, nil, { LeftBadge = RageUI.BadgeStyle.Star }, true, {
                    onActive = function()
                        FreezeEntityPosition(PlayerPedId(), true)
                        SetEntityVisible(PlayerPedId(), false, 0)
                        SetWeatherTypeNow('EXTRASUNNY')
                        SetFollowPedCamViewMode(4)
                        if LastVeh ~= nil then
                            rot = rot + 0.10
                            SetEntityHeading(LastVeh, rot)
                        end
                    end,
                    onListChange = function(Index, Item)
                        index.list = Index;
                        Button = Index;
                    end,
                    onSelected = function()
                        if Button == 1 then
                            if ESX.Game.IsSpawnPointClear(vector3(-1509.9216308594, -1143.5646972656, 0.29253068566322), 100) then
                                ESX.Game.SpawnLocalVehicle(v.model, vector3(-1509.9216308594, -1143.5646972656, 0.29253068566322), 249.82501220703125, function(vehicle)
                                    LastVeh = vehicle
                                    FreezeEntityPosition(vehicle, true)
                                    SetVehicleDoorsLocked(vehicle, 2)
                                    SetEntityInvincible(vehicle, true)
                                    SetVehicleFixed(vehicle)
                                    SetVehicleDirtLevel(vehicle, 0.0)
                                    SetVehicleEngineOn(vehicle, true, true, true)
                                    SetVehicleLights(vehicle, 2)
                                    SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                    SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                    table.insert(VehicleSpawned, {model = vehicle})
                                end)
                            else
                                DeleteEntity(LastVeh)
                                DeleteEntity(LastLastVeh)
                                ESX.Game.SpawnLocalVehicle(v.model, vector3(550.243, -3378.061, 5.843), 282.959, function(vehicle)
                                    LastVeh = vehicle
                                    FreezeEntityPosition(vehicle, true)
                                    SetVehicleDoorsLocked(vehicle, 2)
                                    SetEntityInvincible(vehicle, true)
                                    SetVehicleFixed(vehicle)
                                    SetVehicleDirtLevel(vehicle, 0.0)
                                    SetVehicleEngineOn(vehicle, true, true, true)
                                    SetVehicleLights(vehicle, 2)
                                    SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                    SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                    table.insert(VehicleSpawned, {model = vehicle})
                                end)
                            end
                        elseif Button == 2 then
                            TriggerServerEvent('aBoutique:BuyVehicleBoat', v.model, GetLabelText(v.model))
                            DeleteEntity(LastVeh)
                            DeleteEntity(LastLastVeh)
                            FreezeEntityPosition(PlayerPedId(), false)
                            SetEntityVisible(PlayerPedId(), true, 0)
                            SetEntityCoords(PlayerPedId(), lastPos)
                            SetFollowPedCamViewMode(1)
                            for k,v in pairs(VehicleSpawned) do
                                if DoesEntityExist(v.model) then
                                    Wait(150)
                                    DeleteEntity(v.model)
                                    table.remove(VehicleSpawned, k)
                                end
                            end
                            TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
                            RageUI.CloseAll()
                        end
                    end
                })
            end
		end)
        RageUI.IsVisible(PacksMenu, function()
            RageUI.Button('Création Gang', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "3000", RightBadge = RageUI.BadgeStyle.GoldMedal }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://valestiarp.tebex.io/'
                    })
                end
            })
            RageUI.Button('Création Organisation', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "4000", RightBadge = RageUI.BadgeStyle.GoldMedal }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://valestiarp.tebex.io/'
                    })
                end
            })
            RageUI.Button('Création Drogue', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "6000", RightBadge = RageUI.BadgeStyle.GoldMedal }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://valestiarp.tebex.io/'
                    })
                end
            })
            RageUI.Button('Création Entreprise', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "6000", RightBadge = RageUI.BadgeStyle.GoldMedal }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://valestiarp.tebex.io/'
                    })
                end
            })
            RageUI.Line()
            RageUI.Button('Ajout Yacht Perso', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "6000", RightBadge = RageUI.BadgeStyle.GoldMedal }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://valestiarp.tebex.io/'
                    })
                end
            })
            RageUI.Button('Ajout Véhicule au choix', "Une fois le pack acheté vous devrez faire un Ticket sur discord avec la preuve afin d'ajouter la voiture de votre choix (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~discord.gg/Valestiarp~w~)", { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "7000", RightBadge = RageUI.BadgeStyle.GoldMedal }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://valestiarp.tebex.io/'
                    })
                end
            })
            RageUI.Line()
            RageUI.Button('Vente d\'armes Illégal', "Pour en savoir plus et procéder au paiement veuillez m'envoyer un message privé sur Discord (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~zxnka~w~)", { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "15000", RightBadge = RageUI.BadgeStyle.GoldMedal }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://valestiarp.tebex.io/'
                    })
                end
            })
            RageUI.Button('Vente d\'armes Illégal 2', "Pour en savoir plus et procéder au paiement veuillez m'envoyer un message privé sur Discord (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~zxnka~w~)", { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "25000", RightBadge = RageUI.BadgeStyle.GoldMedal }, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://valestiarp.tebex.io/'
                    })
                end
            })
        end)

        RageUI.IsVisible(menu_voiture, function()
            if exports.Game:IsInSafeZone() and not exports.Game:isInCustom() and not exports.Game:IsInMenotte() and not exports.Game:IsInPorter() and not exports.Game:IsInOtage() then
                RageUI.Button('~s~Voitures', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                    onActive = function()
                        RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                        end,
                        onSelected = function()
                            DoScreenFadeOut(500)
                            Wait(1000)
                            lastPos = GetEntityCoords(PlayerPedId())
                            rot = 1.0
                            SetEntityCoords(PlayerPedId(), vector3(-1072.5211181641, -76.566101074219, -95.524160766602))
                            SetEntityHeading(PlayerPedId(), 182.28536987304688)
                            TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', true)
                            DoScreenFadeIn(500)
                        end
                    }, voitures)
            else
                RageUI.Button('~s~Voitures', "~h~Vous devez être en ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Zone Safe~s~ pour accéder à cette catégorie.",  { RightLabel = "→→" }, false, {
                    onActive = function()
                        RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                        end,
                        onSelected = function()
                            ESX.ShowAdvancedNotification('Notification', "Boutique", "Vous devez être en Zone Safe pour acceder à cette catégorie", 'CHAR_CALL911', 8)
                        end
                    })
            end
            if exports.Game:IsInSafeZone() and not exports.Game:isInCustom() and not exports.Game:IsInMenotte() and not exports.Game:IsInPorter() and not exports.Game:IsInOtage() then
                RageUI.Button('~s~Bateaux', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                    onActive = function()
                        RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                        end,
                        onSelected = function()
                            DoScreenFadeOut(500)
                            Wait(1000)
                            lastPos = GetEntityCoords(PlayerPedId())
                            rot = 1.0
                            SetEntityCoords(PlayerPedId(), vector3(-1501.0750732422, -1130.7200927734, 10.739769935608))
                            SetEntityHeading(PlayerPedId(), 314.2040710449219)
                            TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', true)
                            DoScreenFadeIn(500)
                        end
                    }, bateaux)
            else
                RageUI.Button('~s~Bateaux', "~h~Vous devez être en ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Zone Safe~s~ pour accéder à cette catégorie.",  { RightLabel = "→→" }, false, {
                    onActive = function()
                        RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                        end,
                        onSelected = function()
                            ESX.ShowAdvancedNotification('Notification', "Boutique", "Vous devez être en Zone Safe pour acceder à cette catégorie", 'CHAR_CALL911', 8)
                        end
                    })
            end
            if exports.Game:IsInSafeZone() and not exports.Game:isInCustom() and not exports.Game:IsInMenotte() and not exports.Game:IsInPorter() and not exports.Game:IsInOtage() then
                RageUI.Button('~s~Avion / Helico', nil,  { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                    onActive = function()
                        RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                        end,
                        onSelected = function()
                            DoScreenFadeOut(500)
                            Wait(1000)
                            lastPos = GetEntityCoords(PlayerPedId())
                            rot = 1.0
                            SetEntityCoords(PlayerPedId(), vector3(-978.84301757812, -2976.0131835938, 18.131383895874))
                            SetEntityHeading(PlayerPedId(), 193.26377868652344)
                            TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', true)
                            DoScreenFadeIn(500)
                        end
                    }, avionhelico)
            else
                RageUI.Button('~s~Avion / Helico', "~h~Vous devez être en ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Zone Safe~s~ pour accéder à cette catégorie.",  { RightLabel = "→→" }, false, {
                    onActive = function()
                        RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                        end,
                        onSelected = function()
                            ESX.ShowAdvancedNotification('Notification', "Boutique", "Vous devez être en Zone Safe pour acceder à cette catégorie", 'CHAR_CALL911', 8)
                        end
                    })
            end
        end)

        -- RageUI.IsVisible(ArmesMenu, function()
        --     RageUI.Button('Armes', nil, {}, true, {
        --         onSelected = function()

        --         end
        --     }, ArmesShopMenu)
        -- end)
        RageUI.IsVisible(ArmesShopMenu, function()

            for k,v in pairs(WeaponBoutique) do
                RageUI.Button(v.label, "Tout achat d'armes dans cette catégorie sera permanente (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~discord.gg/Valestiarp~w~) ", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = v.price, RightBadge = RageUI.BadgeStyle.GoldMedal }, true, {
                    onActive = function()
                        RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~Arme : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.label.."", "~w~Prix : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price..""}, {})
                        -- RageUI.RenderWeapons("vehicles", v.name)
                    end,
                    onSelected = function()
                        TriggerServerEvent('ewen:buyweapon', v.name, v.price, v.label)
                        RageUI.CloseAll()
                    end
                })
             end
        end)

        RageUI.IsVisible(CustomArmesShopMenu, function()
            local ped = PlayerPedId();
            local sWeapon = GetSelectedPedWeapon(ped);
            local weapon = ESX.GetWeaponFromHash(sWeapon);
            if (sWeapon ~= UNARMED) then
                local isPermanent = ESX.IsWeaponPermanent(weapon.name)
                if isPermanent then
                    RageUI.Separator("Armes Sélectionné : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..weapon.label)
                    RageUI.Line()
                    if (ESX.Table.SizeOf(weapon) > 0) then
                        for _, v in pairs(weapon.components) do
                            if (not blacklistedComponents[v.name]) then
                                RageUI.Button(v.label, nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = components[v.name] , RightBadge = RageUI.BadgeStyle.GoldMedal}, not HasPedGotWeaponComponent(ped, sWeapon, v.hash), {
                                    onActive = function()
                                        if (components[v.name]) then
                                            RageUI.Info(
                                                '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia',
                                                {
                                                    '~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'',
                                                    "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."",
                                                    "~w~Composant : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.label,
                                                    "~w~Prix : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~".. components[v.name]
                                                }, {

                                                }
                                            );
                                        else
                                            RageUI.Info(
                                                '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia',
                                                {
                                                    '~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'',
                                                    "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."",
                                                    "~w~Composant : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.label,
                                                    "~w~Prix : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~250"
                                                }, {

                                                }
                                            );
                                        end
                                    end,
                                    onSelected = function()
                                        TriggerServerEvent('tebex:on-process-checkout-weapon-custom', weapon.name, GetHashKey(v.name))
                                    end,
                                })
                            end
                        end
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Aucune personnalisation disponible")
                        RageUI.Separator("")
                    end
                else
                    RageUI.Separator("")
                    RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Aucune personnalisation sur cette arme")
                    RageUI.Separator("")
                end
            else
                RageUI.Separator("")
                RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas d'armes en main~s~")
                RageUI.Separator("")
            end
        end)
        RageUI.IsVisible(CaseMenu, function()
            for k,v in pairs(BoutiqueMysteryBox) do
                if v.model ~= 'caisse_fidelite' then
                    RageUI.List(v.label, Action, index.list, v.description, {}, true, {
                        onActive = function()
                            RageUI.RenderCaisse("caisse", v.model)
                            RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~Prix : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.price.." Coins",}, {})
                        end,
                        onListChange = function(Index, Item)
                            index.list = Index;
                            Button = Index;
                        end,
                        onSelected = function()
                            if Button == 1 then
                                OpenMenuPreviewCaisse(v.model, v.label)
                            elseif Button == 2 then
                                RageUI.CloseAll()
                                TriggerServerEvent('Valestia:process_checkout_case', v.model)
                            end
                        end
                    })
                else
                    RageUI.List(v.label..' | Bonus Fidélité', Action, index.list, nil, {}, true, {
                        onActive = function()
                            RageUI.RenderCaisse("caisse", v.model)
                            RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~ID Temporaire : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerServerId(PlayerId()).."" }, {})
                        end,
                        onListChange = function(Index, Item)
                            index.list = Index;
                            Button = Index;
                        end,
                        onSelected = function()
                            if Button == 1 then
                                OpenMenuPreviewCaisse(v.model, v.label)
                            elseif Button == 2 then
                                ESX.ShowAdvancedNotification('Notification', "Boutique", "Vous ne povuez pas acheter cette caisse", 'CHAR_CALL911', 8)
                            end
                        end
                    })
                end
            end
        end)
        RageUI.IsVisible(VipMenu, function()
            RageUI.Button('Mini VIP [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1 Mois~s~]', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = 1250, RightBadge = RageUI.BadgeStyle.GoldMedal}, true, {
                onActive = function()
                RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~Temps : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1 Mois","~w~VIP : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Mini", "~w~Bonus : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~500 Coins + 50 000$"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('eBoutique:BuyVIP', "gold")
                end,
            })
            RageUI.Button('VIP Expert [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1 Mois~s~]', nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = 2250, RightBadge = RageUI.BadgeStyle.GoldMedal}, true, {
                onActive = function()
                    RageUI.Info('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Boutique Valestia', {'~w~Code Boutique : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..fivemid..'', "~w~Coins : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Coins.."", "~w~Temps : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1 Mois","~w~VIP : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Expert", "~w~Bonus : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1000 Coins + 100 000$"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('eBoutique:BuyVIP', "diamond")
                end,
            })
        end)
        if not RageUI.Visible(menu)
        and not RageUI.Visible(vehicles)
        and not RageUI.Visible(voitures)
        and not RageUI.Visible(menu_voiture)
        and not RageUI.Visible(avionhelico)
        and not RageUI.Visible(bateaux)
        and not RageUI.Visible(PacksMenu)
        and not RageUI.Visible(ArmesMenu)
        and not RageUI.Visible(ArmesShopMenu)
        and not RageUI.Visible(CustomArmesShopMenu)
        and not RageUI.Visible(CaseMenu)
        and not RageUI.Visible(VipMenu)
        then
            menu = RMenu:DeleteType('menu', true)
		end
		Wait(0)
    end
end

RegisterNetEvent('aBoutique:BuyCustomMaxClient', function()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    FullCustom(vehicle)
end)

function FullCustom(veh)
	SetVehicleModKit(veh, 0)
	ToggleVehicleMod(veh, 18, true)
	ToggleVehicleMod(veh, 22, true)
	SetVehicleMod(veh, 16, 5, false)
	SetVehicleMod(veh, 12, 2, false)
	SetVehicleMod(veh, 11, 3, false)
	SetVehicleMod(veh, 14, 14, false)
	SetVehicleMod(veh, 15, 3, false)
	SetVehicleMod(veh, 13, 2, false)
	SetVehicleMod(veh, 23, 21, true)
	SetVehicleMod(veh, 0, 1, false)
	SetVehicleMod(veh, 1, 1, false)
	SetVehicleMod(veh, 2, 1, false)
	SetVehicleMod(veh, 3, 1, false)
	SetVehicleMod(veh, 4, 1, false)
	SetVehicleMod(veh, 5, 1, false)
	SetVehicleMod(veh, 6, 1, false)
	SetVehicleMod(veh, 7, 1, false)
	SetVehicleMod(veh, 8, 1, false)
	SetVehicleMod(veh, 9, 1, false)
	SetVehicleMod(veh, 10, 1, false)
	SetVehicleModKit(veh, 0)
	ToggleVehicleMod(veh, 20, true)
	SetVehicleModKit(veh, 0)
	SetVehicleNumberPlateTextIndex(veh, true)
    myCar = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
	TriggerServerEvent('esx_lscustom:refreshOwnedVehicle', myCar);
end

function OpenMenuPreviewCaisse(model, label)
    local CaissePreview = RageUI.CreateMenu('', "Boutique Valestia RP")
    RageUI.Visible(CaissePreview, not RageUI.Visible(CaissePreview))
    while CaissePreview do
        Wait(0)
        RageUI.IsVisible(CaissePreview, function()
            RageUI.Separator('Prévisualisation de la caisse : '..label)
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 4 then
                    RageUI.Button(v.label, nil, {RightLabel = '~p~Ultime'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('caissemystere', v.model)
                        end,
                        onSelected = function()

                        end
                    })
                end
            end
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 3 then
                    RageUI.Button(v.label, nil, {RightLabel = '~y~Légendaire'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('caissemystere', v.model)
                        end,
                        onSelected = function()

                        end
                    })
                end
            end
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 2 then
                    RageUI.Button(v.label, nil, {RightLabel = '~b~Rare'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('caissemystere', v.model)
                        end,
                        onSelected = function()

                        end
                    })
                end
            end
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 1 then
                    RageUI.Button(v.label, nil, {RightLabel = '~g~Commun'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('caissemystere', v.model)
                        end,
                        onSelected = function()

                        end
                    })
                end
            end
        end, function()
        end)

        if not RageUI.Visible(CaissePreview) then
            CaissePreview = RMenu:DeleteType('BoutiqueSub', true)
            Wait(100)
            OpenMenuMain()
        end
    end
end

-- OPENING CASE

local picture;

local mysterybox = RageUI.CreateMenu("Caisse Mystère", "Bonne chance !")

RegisterNetEvent('ewen:caisseopenclientside')
AddEventHandler('ewen:caisseopenclientside', function(animations, name, message)
    RageUI.Visible(mysterybox, not RageUI.Visible(mysterybox))
    CreateThread(function()
        Wait(250)
        for k, v in pairs(animations) do
            picture = v.name
            RageUI.PlaySound("HUD_FREEMODE_SOUNDSET", "NAV_UP_DOWN")
            if v.time == 5000 then
                RageUI.PlaySound("HUD_AWARDS", "FLIGHT_SCHOOL_LESSON_PASSED")
                ESX.ShowAdvancedNotification('Notification', 'Boutique', message, 'CHAR_VICE', 6)
                Wait(4000)
            end
            Wait(v.time)
        end
    end)
end)

CreateThread(function()
    while (true) do
        Wait(1.0)

        RageUI.IsVisible(mysterybox, function()
        end, function()
            if (picture) then
                RageUI.CaissePreviewOpen("caissemystere", picture)
            end
        end)


    end
end)

RegisterNetEvent('aBoutique:SendJournaliereBoutique')
AddEventHandler('aBoutique:SendJournaliereBoutique', function(vehicle)
    VehicleJournalier = vehicle
end)

CreateThread(function()
    Wait(1500)
    TriggerServerEvent('aBoutique:RetrieveJournaliereBoutique')
end)

CreateThread(function()
	Wait(2000)
	TriggerServerEvent('ewen:boutiquecashout')
end)