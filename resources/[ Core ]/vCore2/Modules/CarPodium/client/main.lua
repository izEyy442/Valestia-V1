ESX = nil
local LesVoitureSontSpawn = false

CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config2.ESX2, function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

local ExpositionConcess = {
    {car = "panthere", pos = vector3(-786.2710, -242.9615, 36.1612), heading = 337.1283},
    {car = "issi8", pos = vector3(-790.3253, -235.4040, 36.1612), heading = 338.9443},
    {car = "entity3", pos = vector3(-794.3246, -227.9860, 36.1612), heading = 344.9241},
    {car = "virtue", pos = vector3(-792.5871, -217.6880, 36.000), heading = 118.0218}, 
    {car = "golf8r", pos = vector3(-782.6094, -211.8215, 40.9919), heading = 95.6105}, 
    {car = "ikx3m2p23", pos = vector3(-778.6317, -219.1124, 40.9919), heading = 89.0525},
    {car = "m3g8021", pos = vector3(-774.5828, -226.4484, 41.9919), heading = 93.7468},
    {car = "rsq8mans", pos = vector3(-769.7576, -234.3200, 41.9919), heading = 79.9141},
}

Citizen.CreateThread(function()
    while ESX == nil do Wait(500) end
    while true do

        local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(-783.6695, -215.5364, 36.9975))

        if dist < 1500 then
            if not LesVoitureSontSpawn then 
                LesVoitureSontSpawn = true
                for k,v in pairs(ExpositionConcess) do
                    ESX.Game.SpawnLocalVehicle(v.car, v.pos, v.heading, function (vehicle)
                        FreezeEntityPosition(vehicle, true)
                    end)
                end
            else
                break
            end
        end
    Wait(10000)
	end
end)