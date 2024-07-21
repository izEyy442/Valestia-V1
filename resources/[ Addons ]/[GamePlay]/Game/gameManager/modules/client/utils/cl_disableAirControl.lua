local vehicleClassDisableControl = {
    [0] = true,     --compacts
    [1] = true,     --sedans
    [2] = true,     --SUV's
    [3] = true,     --coupes
    [4] = true,     --muscle
    [5] = true,     --sport classic
    [6] = true,     --sport
    [7] = true,     --super
    [8] = false,    --motorcycle
    [9] = true,     --offroad
    [10] = true,    --industrial
    [11] = true,    --utility
    [12] = true,    --vans
    [13] = false,   --bicycles
    [14] = false,   --boats
    [15] = false,   --helicopter
    [16] = false,   --plane
    [17] = true,    --service
    [18] = true,    --emergency
    [19] = false    --military
}

-- Main thread
Citizen.CreateThread(function()
    while true do
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            Wait(0)
            local player = GetPlayerPed(-1)
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleClass = GetVehicleClass(vehicle)

            if ((GetPedInVehicleSeat(vehicle, -1) == player) and vehicleClassDisableControl[vehicleClass]) then
                if IsEntityInAir(vehicle) then
                    DisableControlAction(2, 59)
                    DisableControlAction(2, 60)
                end
            end
        else
            Wait(1000)
        end
    end
end)