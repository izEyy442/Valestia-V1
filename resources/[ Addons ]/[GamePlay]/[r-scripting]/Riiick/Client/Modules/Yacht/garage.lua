countveh_yacht = 1 
countveh2_yacht = 4 
veh_yacht = nil
veh2_yacht = nil
pspawnv_yacht = nil 

garage_yacht = RageUI.CreateMenu(" ", "Yacht Garage");

garage_yacht:isVisible(function(items)
    if countveh_yacht > 0 then 
        items:Button(veh_yacht, nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = countveh_yacht}, true,{
            onSelected = function() 
                if ESX.Game.IsSpawnPointClear(pspawnv_yacht, 5) then 
                    if garage_yacht:isOpen() then 
                        garage_yacht:toggle();
                    end
                    countveh_yacht = countveh_yacht - 1
                    DoScreenFadeOut(500)
                    Wait(1000)
                    ESX.Game.SpawnVehicle(veh_yacht, pspawnv_yacht, 100.0, function(vehicle)
                        SetEntityCoords(PlayerPedId(), pspawnv_yacht)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        exports["vCore3"]:SetFuel(vehicle, 100)
                        Wait(1000)
                        DoScreenFadeIn(500)
                    end)
                else
                    ESX.ShowNotification("Un véhicule vous empêche d'en sortir un autre !")
                end
            end
        });
    else
        items:Button(veh_yacht, nil, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end
    if countveh2_yacht > 0 then 
        items:Button(veh2_yacht, nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = countveh2_yacht}, true,{
            onSelected = function() 
                if ESX.Game.IsSpawnPointClear(pspawnv_yacht, 5) then 
                    if garage_yacht:isOpen() then 
                        garage_yacht:toggle();
                    end
                    countveh2_yacht = countveh2_yacht - 1
                    DoScreenFadeOut(500)
                    Wait(1000)
                    ESX.Game.SpawnVehicle(veh2_yacht, pspawnv_yacht, 100.0, function(vehicle)
                        SetEntityCoords(PlayerPedId(), pspawnv_yacht)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        Wait(1000)
                        DoScreenFadeIn(500)
                    end)
                else
                    ESX.ShowNotification("Un véhicule vous empêche d'en sortir un autre !")
                end
            end
        });
    else
        items:Button(veh2_yacht, nil, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end
end);