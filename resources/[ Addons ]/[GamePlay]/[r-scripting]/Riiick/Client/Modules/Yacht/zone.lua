local riiick = Riiick:new()

RegisterNetEvent('Riiick:setYachtProperty')
AddEventHandler('Riiick:setYachtProperty', function(data)
	local sleep = 1000
    local blipMap = AddBlipForCoord(vector3(data.pv.x, data.pv.y, data.pv.z))
        SetBlipSprite(blipMap, 455)
        SetBlipDisplay(blipMap, 4)
        SetBlipScale(blipMap, 0.6)
        SetBlipColour(blipMap, 27)
        SetBlipAsShortRange(blipMap, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("[Propriété] Yacht")
        EndTextCommandSetBlipName(blipMap)
        SetBlipPriority(blipMap, 5)
    pspawnv_yacht = vector3(data.psv.x, data.psv.y, data.psv.z)
    veh_yacht = GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(data.v1)))
    veh2_yacht = GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(data.v2)))
    while true do
        local playerPed = PlayerPedId()
        local plyCoords = GetEntityCoords(playerPed, false)
        local zoneGarageYacht = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, data.pg.x, data.pg.y, data.pg.z)
        local zoneEntervehYacht = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, data.psv.x, data.psv.y, data.psv.z)
        local zoneSleepYacht = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, data.pdec.x, data.pdec.y, data.pdec.z)
        local zoneCoffreYacht = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, data.pv.x, data.pv.y, data.pv.z)
        local zoneDJYacht = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, data.pdj.x, data.pdj.y, data.pdj.z)
            if zoneGarageYacht <= 3.0 then
                sleep = 0
                DrawMarker(6,  data.pg.x, data.pg.y, data.pg.z-0.98, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.5, 0.5, 0.5, 255,250,0, 250, false, false, nil, false, false, false, false);
                riiick:drawTxt("[ ~y~E~s~ ] pour accéder au véhicule de la ~y~soute du yacht~s~.")
                if IsControlJustPressed(0, 51) then
                    garage_yacht:toggle(); 
                end
            elseif zoneGarageYacht > 3.5 then
                if garage_yacht:isOpen() then 
                    garage_yacht:close();
                end
            end
            if (zoneEntervehYacht <= 10.0) and (IsPedInAnyVehicle(playerPed)) then
                sleep = 0
                riiick:drawTxt("[ ~y~E~s~ ] pour ranger le véhicle dans la ~y~soute du yacht~s~.")
                if IsControlJustPressed(0, 51) then
                    if (GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(playerPed)))) == veh_yacht) then 
                        DoScreenFadeOut(500)
                        Wait(1000)
                        DeleteEntity(GetVehiclePedIsUsing(playerPed))
                        countveh_yacht = countveh_yacht + 1
                        SetEntityCoords(PlayerPedId(), data.pg.x, data.pg.y, data.pg.z)
                        Wait(1000)
                        DoScreenFadeIn(500)
                    elseif (GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(playerPed)))) == veh2_yacht) then
                        DoScreenFadeOut(500)
                        Wait(1000)
                        DeleteEntity(GetVehiclePedIsUsing(playerPed))
                        countveh2_yacht = countveh2_yacht + 1
                        SetEntityCoords(PlayerPedId(), data.pg.x, data.pg.y, data.pg.z)
                        Wait(1000)
                        DoScreenFadeIn(500)
                    end
                end

            end
            if zoneSleepYacht <= 3.0 then
                sleep = 0
                DrawMarker(6,  data.pdec.x, data.pdec.y, data.pdec.z-0.98, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.5, 0.5, 0.5, 255,250,0, 250, false, false, nil, false, false, false, false);
                riiick:drawTxt("[ ~y~E~s~ ] pour dormir dans le ~y~lit~s~. (~r~disconnect~s~)")
                if IsControlJustPressed(0, 51) then
                    DoScreenFadeOut(3000)
                    ExecuteCommand("e sleep")
                    Wait(4000)
                    TriggerServerEvent("Riiick:goToSleep")
                end
            end

            if zoneCoffreYacht <= 3.0 then
                sleep = 0
                DrawMarker(6,  data.pv.x, data.pv.y, data.pv.z-0.98, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.5, 0.5, 0.5, 255,250,0, 250, false, false, nil, false, false, false, false);
                riiick:drawTxt("[ ~y~E~s~ ] pour accéder au ~y~Coffre / Vestiaire~s~.")
                if IsControlJustPressed(0, 51) then
                    stockves_yacht:toggle(); 
                    ClothRefresh()
                end
            elseif zoneCoffreYacht > 3.5 then
                if stockves_yacht:isOpen() then 
                    stockves_yacht:close();
                end
            end

            if zoneDJYacht <= 3.0 then
                sleep = 0
                DrawMarker(6,  data.pdj.x, data.pdj.y, data.pdj.z-0.98, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.5, 0.5, 0.5, 255,250,0, 250, false, false, nil, false, false, false, false);
                riiick:drawTxt("[ ~y~E~s~ ] pour accéder au ~y~Platine~s~.")
                if IsControlJustPressed(0, 51) then
                    dj_yacht:toggle(); 
                end
            elseif zoneDJYacht > 3.5 then
                if dj_yacht:isOpen() then 
                    dj_yacht:close();
                end
            end

            if (zoneGarageYacht > 3.5) and (zoneEntervehYacht > 5.5) and (zoneSleepYacht > 3.5) and (zoneCoffreYacht > 3.5) and (zoneDJYacht > 3.5) then
                sleep = 1000
            end
        Wait(sleep)
    end
end) 