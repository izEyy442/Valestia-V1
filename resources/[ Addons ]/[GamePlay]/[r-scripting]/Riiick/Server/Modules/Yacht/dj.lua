local xSound = exports.xsound

RegisterNetEvent('Riiick:playMusic', function(YoutubeURL)
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer) then 
        local data,_ = GetDataYacht(xPlayer.identifier)

        local defaultVolume = 0.1
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - vector3(data.pdj.x, data.pdj.y, data.pdj.z))
        if dist < 3 then
            xSound:PlayUrlPos(-1, tostring('Yacht'..xPlayer.identifier), YoutubeURL, defaultVolume, coords)
            xSound:Distance(-1, tostring('Yacht'..xPlayer.identifier), 30)
        end
    end
end)

RegisterNetEvent('Riiick:stopMusic', function()
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer) then 
        local data,_ = GetDataYacht(xPlayer.identifier)

        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - vector3(data.pdj.x, data.pdj.y, data.pdj.z))
        if dist < 3 then
            xSound:Destroy(-1, tostring('Yacht'..xPlayer.identifier))
        end
    end
end)

RegisterNetEvent('Riiick:changeVolume', function(volume)
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer) then 
        local data,_ = GetDataYacht(xPlayer.identifier)
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - vector3(data.pdj.x, data.pdj.y, data.pdj.z))
        if dist < 3 then
            if not tonumber(volume) then return end
            xSound:setVolume(-1, tostring('Yacht'..xPlayer.identifier), volume)
        end
    end
end)

RegisterNetEvent('Riiick:pauseMusic', function()
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer) then 
        local data,_ = GetDataYacht(xPlayer.identifier)
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - vector3(data.pdj.x, data.pdj.y, data.pdj.z))
        if dist < 3 then
            xSound:Pause(-1, tostring('Yacht'..xPlayer.identifier))
        end
    end
end)

RegisterNetEvent('Riiick:resumeMusic', function()
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer) then 
        local data,_ = GetDataYacht(xPlayer.identifier)
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - vector3(data.pdj.x, data.pdj.y, data.pdj.z))
        if dist < 3 then
            xSound:Resume(-1, tostring('Yacht'..xPlayer.identifier))
        end
    end
end)