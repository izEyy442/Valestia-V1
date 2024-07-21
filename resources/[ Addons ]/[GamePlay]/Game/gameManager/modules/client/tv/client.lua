local data = {}

GenerateId = function(length, usecapital, usenumbers)
    local result = ''

    for i = 1, length do
        local randomised = string.char(math.random(97, 122))
        if usecapital then
            if math.random(1, 2) == 1 then
                randomised = randomised:upper()
            end
        end
        if usenumbers then
            if math.random(1, 2) == 1 then
                randomised = tostring(math.random(0, 9))
            end
        end
        result = result .. randomised
    end

    return result
end

VolumeCheck = function(id)
    if data[id]['DUI'] then
        if data[id]['ActualVolume'] ~= data[id]['Volume'] then
            local duiLong = data[id]['DUI']['Long']

            SendDuiMouseMove(duiLong, 75, 700)
            Wait(250)
            SendDuiMouseMove(duiLong, 95 + math.ceil(data[id]['Volume'] * 5), 702)
            Wait(5)
            SendDuiMouseDown(duiLong, 'left')
            Wait(7)
            SendDuiMouseUp(duiLong, 'left')

            SendDuiMouseMove(duiLong, 75, 500)

            data[id]['ActualVolume'] = data[id]['Volume']
        end
    end
end

CreateVideo = function(id, url, object, coords, scale, offset, time, volume)
    if data[id] then
        if data[id]['DUI'] then
            DestroyDui(data[id]['DUI']['Long'])
        end
        data[id] = nil
        Wait(500)
    end

    local distance = 10.0

    for k, v in pairs(Config['Objects']) do
        if v['Object'] == object then
            Distance = v['Distance']
            break
        end
    end

    data[id] = {
        ['URL'] = url,
        ['Time'] = time,
        ['Started'] = math.ceil(GetGameTimer() / 1000) + 1,
        ['Object'] = object,
        ['Coords'] = coords,
        ['Offset'] = offset,
        ['Scale'] = scale,
        ['Volume'] = volume,
        ['ActualVolume'] = 0,
        ['Distance'] = Distance
    }
end

RegisterNetEvent('tv:update')
AddEventHandler('tv:update', function(players)
    for k, v in pairs(players) do
        if v ~= nil then
            CreateVideo(k, v['URL'], v['Object'], v['Coords'], v['Scale'], v['Offset'], v['Time'], v['Volume'])

            if v['Duration'] then
                data[k]['Duration'] = v['Duration']
            end
        end
    end
end)

CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(50) end

    local SFHandle = RequestScaleformMovie('generic_texture_renderer')
    while not HasScaleformMovieLoaded(SFHandle) do Wait(1000) end

    TriggerServerEvent('tv:fetch')

    CreateThread(function()
        while true do
            Wait(500)

            for k, v in pairs(data) do
                Wait(100)
                local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), v['Distance'], GetHashKey(v['Object']))

                if v ~= nil then
                    local obj = GetClosestObjectOfType(v['Coords'], v['Distance'], GetHashKey(v['Object']))
                    if DoesEntityExist(obj) then
                        Wait(2500)
                        while #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= v['Distance'] and data[k] ~= nil and DoesEntityExist(obj) do
                            VolumeCheck(k)
                            Wait(500)
                        end
                    end
                end
            end
        end
    end)

    CreateThread(function()
        while true do
            Wait(500)

            for k, v in pairs(Config['Objects']) do
                Wait(100)
                local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey(v['Object']))
                if DoesEntityExist(obj) then
                    local playing = false
                    local CheckPlaying = GetGameTimer()
                    while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(obj)) <= 2.0 do
                        if CheckPlaying <= GetGameTimer() then
                            CheckPlaying = GetGameTimer() + 750
                            playing = false
                            for k, v in pairs(data) do
                                if v['Coords'] == GetEntityCoords(obj) then
                                    playing = true
                                end
                            end
                        end

                        if playing then
                            AddTextEntry(GetCurrentResourceName(), Strings['VolumeHelp'])

                            if IsControlJustReleased(0, 51) then
                                for k, v in pairs(data) do
                                    if v['Coords'] == GetEntityCoords(obj) then
                                        CreateThread(function()
                                            if v['DUI'] then
                                                SetDuiUrl(v['DUI']['Long'], Config['URL']:format(v['URL'], (math.floor(GetGameTimer() / 1000) + v['Time']) - v['Started']))
                                            end
                                        end)
                                    end
                                end
                            end
                        else
                            AddTextEntry(GetCurrentResourceName(), Strings['VideoHelp'])
                        end

                        DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
                        Wait(0)
                    end
                end
            end
        end
    end)

    while true do
        Wait(500)

        for k, v in pairs(data) do
            Wait(0)
            if v ~= nil then
                local obj = GetClosestObjectOfType(v['Coords'], v['Distance'], GetHashKey(v['Object']))
                if DoesEntityExist(obj) then
                    if #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= v['Distance'] then
                        if SFHandle ~= nil then
                            local duiLong = CreateDui(Config['URL']:format(v['URL'], (math.floor(GetGameTimer() / 1000) + v['Time']) - v['Started']), 1280, 720)
                            local dui = GetDuiHandle(duiLong)

                            local txd, txn = GenerateId(25, true, false), GenerateId(25, true, false)
                            CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd(txd), txn, dui)

                            v['DUI'] = {
                                ['Long'] = duiLong,
                                ['Obj'] = dui,
                            }

                            v['Texture'] = {
                                ['txd'] = txd,
                                ['txn'] = txn,
                            }

                            PushScaleformMovieFunction(SFHandle, 'SET_TEXTURE')
                            PushScaleformMovieMethodParameterString(v['Texture']['txd'])
                            PushScaleformMovieMethodParameterString(v['Texture']['txn'])

                            PushScaleformMovieFunctionParameterInt(0)
                            PushScaleformMovieFunctionParameterInt(0)
                            PushScaleformMovieFunctionParameterInt(1920)
                            PushScaleformMovieFunctionParameterInt(1080)

                            PopScaleformMovieFunctionVoid()

                            while #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= v['Distance'] and DoesEntityExist(obj) and data[k] ~= nil do
                                Wait(0)

                                if v['Duration'] then
                                    if (math.ceil(GetGameTimer() / 1000) - v['Started']) > v['Duration'] then
                                        DestroyDui(v['DUI']['Long'])
                                        data[k] = nil
                                        break
                                    end
                                end
                                DrawScaleformMovie_3dNonAdditive(SFHandle, GetOffsetFromEntityInWorldCoords(obj, v['Offset']), 0.0, GetEntityHeading(obj) * -1, 0.0, 2, 2, 2, v['Scale'] * 1, v['Scale'] * (9 / 16), 1, 2)
                            end

                            if data[k] then
                                DestroyDui(v['DUI']['Long'])

                                v['DUI'] = {}
                                v['Texture'] = {}
                            end
                        end
                    end
                end
            end
        end

    end
end)

RegisterCommand('tv', function(source, args)
    if args[1] then
        for k, v in pairs(Config['Objects']) do
            local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey(v['Object']))
            if DoesEntityExist(obj) then
                TriggerServerEvent('tv:add', args[1], v['Object'], GetEntityCoords(obj), v['Scale'], v['Offset'])
                break
            end
        end
    end
end)

RegisterCommand('volume', function(src, args)
    if args[1] then
        local volume = tonumber(args[1])
        if volume then
            if volume >= 0 then

                for k, v in pairs(data) do
                    if #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= 5.0 then
                        if volume == 1 then volume = 1.5 end
                        if volume > 10 then volume = 10 end
                        TriggerServerEvent('tv:setvolume', k, volume)
                        break
                    end
                end

            end
        end
    end
end)

RegisterCommand('tvstop', function(src, args)
    for k, v in pairs(data) do
        if #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= 5.0 then
            TriggerServerEvent('tv:destroy', k)
            break
        end
    end
end)

RegisterNetEvent('tv:delete')
AddEventHandler('tv:delete', function(id)
    if data[id] then
        if data[id]['DUI'] then
            DestroyDui(data[id]['DUI']['Long'])
        end
        data[id] = nil
    end
end)

RegisterNetEvent('tv:updatevolume')
AddEventHandler('tv:updatevolume', function(id, volume)
    if data[id] then
        data[id]['Volume'] = volume
    end
end)
         