ESX = nil
local LesVoitureSontSpawn = false

CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.ESX, function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

local ExpositionConcess = {
    {car = "windsor2", pos = vector3(-606.169, -1128.901, 21.378), heading = 300.0},
    {car = "broadway", pos = vector3(-606.140, -1136.154, 21.378), heading = 300.0},
    {car = "nightshade", pos = vector3(-611.849, -1121.870, 21.378), heading = 0.0},
    {car = "toros", pos = vector3(-606.0320, -1115.4115, 21.3727), heading = 238.7296},
    {car = "r300", pos = vector3(-612.389, -1096.632, 21.378), heading = 230.4801},
    {car = "tenf", pos = vector3(-615.906, -1105.836, 21.378), heading = 200.0},
    {car = "rhinehart", pos = vector3(-615.861, -1114.990, 21.378), heading = 340.0},
    {car = "tailgater2", pos = vector3(-615.809, -1129.035, 21.378), heading = 20.0},
    {car = "tulip2", pos = vector3(-605.8777, -1106.0625, 21.3786), heading = 242.1985},
--------1st floor--------
    {car = "gcmferraripurosangue", pos = vector3(-616.551, -1114.943, 24.908), heading = 180.0},
    {car = "ikx3m2p23", pos = vector3(-614.890, -1122.239, 24.908), heading = 270.0},
    {car = "megrs18", pos = vector3(-616.393, -1128.795, 24.908), heading = 360.0},
    {car = "golf8r", pos = vector3(-616.553, -1140.067, 24.908), heading = 180.0},
    {car = "cls63s", pos = vector3(-605.983, -1115.377, 24.908), heading = 240.0},
    {car = "x6mf96", pos = vector3(-605.901, -1128.901, 24.908), heading = 300.0},
    {car = "m5cs22", pos = vector3(-606.084, -1136.323, 24.908), heading = 300.0},
    {car = "panamturs21", pos = vector3(-606.186, -1143.160, 24.908), heading = 300.0},
    {car = "x3utopia23", pos = vector3(-609.855, -1151.292, 24.908), heading = 180.0},
    {car = "lp780r", pos = vector3(-607.461, -1161.422, 24.908), heading = 270.0},
}

Citizen.CreateThread(function()
    while ESX == nil do Wait(500) end
    while true do

        local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(-609.7217, -1124.0952, 22.3300))

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