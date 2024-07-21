RegisterNetEvent("kq_realoffroad:server:createStatebag", function(veh, wheelDepthState, wheelDepth) 
    local vehicle = NetworkGetEntityFromNetworkId(veh)
    Entity(vehicle).state:set(wheelDepthState, wheelDepth, true)
end)