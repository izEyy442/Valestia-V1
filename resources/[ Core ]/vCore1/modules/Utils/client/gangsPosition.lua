local isActive = false
local blips = {}

RegisterNetEvent("vCore1:gang:receiveGangPosition", function(data)
    isActive = not isActive

    if (isActive) then
    
        if (data) then

            for k, v in pairs(data) do
                blip = AddBlipForCoord(v.x, v.y, v.z)
                table.insert(blips, blip)

                SetBlipSprite(blip, 418)
                SetBlipColour(blip, 1)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("[Organisation] "..v.name)
                EndTextCommandSetBlipName(blip)
            end

        end

    else

        for k, v in pairs(blips) do
            RemoveBlip(v)
        end

        blips = {}

    end
    
end)