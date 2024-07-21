CreateThread(function()
    while true do
        Wait(5000)
        local ped = PlayerPedId()
        for _,player in ipairs(GetActivePlayers()) do
            local everyone = GetPlayerPed(player)
            local everyoneveh = GetVehiclePedIsUsing(everyone)
            local vehicleClass = GetVehicleClass(everyoneveh)
            if vehicleClass ~= 14 and vehicleClass ~= 15 and vehicleClass ~= 16 then
                if IsPedInAnyVehicle(everyone, false) then
                    SetEntityNoCollisionEntity(ped, everyoneveh, false)
                    SetEntityNoCollisionEntity(everyoneveh, ped, false)
                else
                    SetEntityNoCollisionEntity(ped, everyone, false)
                end
            end
        end
    end
end)