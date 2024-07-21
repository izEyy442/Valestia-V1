ESX = exports["Framework"]:getSharedObject();

ESX.RegisterServerCallback("iZeyy:RPCPlayerCount",function(src,cb)
    cb(GetNumPlayerIndices())
end)