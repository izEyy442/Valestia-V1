local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

--- Menu Spawn Scootbite
function MenuSpawnScootBite()
    local main = RageUI.CreateMenu("", "Menu Vehicule Post-OP")
    RageUI.Visible(main, not RageUI.Visible(main))
    while main do
        Wait(0)
        local plyped = PlayerPedId()
        local playcoords = GetEntityCoords(plyped)
        local menucoords = ZonesListe["MenuSpawnScootBite"].Position
        local dif = #(playcoords - menucoords )
        if dif > 7 then 
            RageUI.CloseAll()
        end
        RageUI.IsVisible(main, function()
            for k, v in pairs(PostOP.Voiture) do
                RageUI.Button(v.label, nil, { LeftBadge = RageUI.BadgeStyle.Star }, ESX.PlayerData.job.grade >= v.minimum_grade, {
                    onSelected = function()
                        TriggerServerEvent('izeyy:spawnVehicle2', v.name, vector3(-412.6584777832, -2793.9565429688, 6.0003895759583), 311.009521484375);
                        RageUI.CloseAll()
                    end
                })
            end
        end)
        if not RageUI.Visible(main) then
            main = RMenu:DeleteType('main', true)
        end
    end
end

--- Marker Spawn Scootbite
CreateThread(function()
    while true do
        local pPed = PlayerPedId()
        local pc = GetEntityCoords(pPed)
        local mc = ZonesListe["MenuSpawnScootBite"].Position
        local dif = #(mc - pc)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "postop" then
            if dif > 6 then
                interval9 = 750
            else
                interval9 = 1
                if dif <= 3 then
                    Draw3DText(mc.x, mc.y, mc.z, "Appuyez sur [~b~E~w~] pour accéder au ~b~Vehicule")
                    DrawMarker(1,mc.x,mc.y,mc.z-1.5,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0,45,110,185,255,true,true,0,true,nil,nil,false)
                    if IsControlJustPressed(0, 51) then
                        MenuSpawnScootBite()
                    end
                end
            end
        end
        Wait(interval9)
    end
end)

--- Marker Delete Scootbite
CreateThread(function()
    while true do
        local pPed = PlayerPedId()
        local vh = GetVehiclePedIsIn(pPed, false)
        local pc = GetEntityCoords(pPed)
        local mc = ZonesListe["MenuDeleteScootBite"].Position
        local dif = #(mc - pc)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "postop" then
            if dif > 15 then
                interval7 = 750
            else
                interval7 = 1
                if dif <= 5 then
                    Draw3DText(mc.x, mc.y, mc.z, "Appuyez sur [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~w~] pour rendre votre ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Scooter")
                    DrawMarker(1,mc.x,mc.y,mc.z-3,0.0,0.0,0.0,0.0,0.0,0.0,3.0,3.0,3.0,45,110,185,255,true,false,0,true,nil,nil,false)
                    if IsControlJustPressed(0, 51) then
                        if vh ~= nil then
                            DeleteEntity(vh)
                        else
                            ESX.ShowAdvancedNotification('Notification', "Post-OP", "Vous n'etes pas sur votre Vehicule de service", 'CHAR_CALL911', 8)
                        end
                    end
                end
            end
        end
        Wait(interval7)
    end
end)