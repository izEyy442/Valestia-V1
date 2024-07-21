--- todo dans la config qu'on puisse mettre a vendre des item et qu'on puisse WL plusieurs orga/gang

-- ESX = nil
-- local VdaPosition

-- local IsInPVP = false;

-- AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
--     IsInPVP = inPVP;
-- end);

-- Citizen.CreateThread(function()
--     while ESX == nil do
--         TriggerEvent(Config.ESX, function(obj) ESX = obj end)
--         Citizen.Wait(500)
--     end
--     while ESX.GetPlayerData().job == nil do
--         Citizen.Wait(500)
--     end
--     while ESX.GetPlayerData().job2 == nil do
--         Citizen.Wait(500)
--     end
--     ESX.TriggerServerCallback('vda:getPos', function(Pos)
--         VdaPosition = Pos
--     end)
--     ESX.playerData = ESX.GetPlayerData()
-- end)

-- RegisterNetEvent('esx:setJob2')
-- AddEventHandler('esx:setJob2', function(job2)
--     ESX.playerData.job2 = job2
-- end)

-- Citizen.CreateThread(function()
--     while ESX.GetPlayerData()['job'] == nil do
--         Citizen.Wait(500)
--     end
--     while ESX.GetPlayerData()['job2'] == nil do
--         Citizen.Wait(500)
--     end
--     while VdaPosition == nil do
--         Citizen.Wait(500)
--     end
--     while true do
--         local interval = 500
--         if(not IsInPVP) then
--             if ESX.PlayerData.job2.name == Config.Vda.OrgaOK then
--                 local pCoords = GetEntityCoords(PlayerPedId())
--                 if #(pCoords - VdaPosition) <= 10 then
--                     interval = 1
--                     DrawMarker(Config.Marker.Type, VdaPosition, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], Config.Marker.Color[1], Config.Marker.Color[2], Config.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
--                     if #(pCoords - VdaPosition) <= 3 then
--                         ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la vente d'armes.")
--                         if IsControlJustPressed(0, 51) then
--                             openVdaMenu()
--                         end
--                     end
--                 end
--             end
--         end
--         Citizen.Wait(interval)
--     end
-- end)

-- openVdaMenu = function()
--     local mainMenu = RageUI.CreateMenu("", "Achat en argent sale")

--     RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

--     while mainMenu do
--         RageUI.IsVisible(mainMenu, function()
--             for k,v in pairs(Config.Vda.Weapons) do
--                 RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.label, nil, {RightLabel = v.price.."$"}, true, {
--                     onSelected = function()
--                         TriggerServerEvent('vda:pay', v.price, v.model, v.label, v.type)
--                     end
--                 })
--             end
--         end)
--         if not RageUI.Visible(mainMenu) then
--             mainMenu = RMenu:DeleteType(mainMenu, true)
--         end
--         Citizen.Wait(0)
--     end
-- end