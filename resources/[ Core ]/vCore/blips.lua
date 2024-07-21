Map = {
    -- { name="xxxxxxx", color = x, size = 0.60, id = X, ZoneBlip = false, Position = vector3(-xx.xx, xx.xx, xx.xx)},
}


CreateThread(function()
    for k,v in pairs(Map) do
        local blip = AddBlipForCoord(v.Position) 
        SetBlipSprite (blip, v.id)
        SetBlipDisplay(blip, 6)
        SetBlipScale  (blip, v.size)
        SetBlipColour (blip, v.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING") 
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
        if v.ZoneBlip then
            local zoneblip = AddBlipForRadius(v.Position, 800.0)
        SetBlipSprite(zoneblip,1)
        SetBlipColour(zoneblip, v.color)
        SetBlipAlpha(zoneblip,100)
        end
    end
end)