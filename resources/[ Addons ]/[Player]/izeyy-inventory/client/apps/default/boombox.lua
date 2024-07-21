local xSound = exports.xsound
local activeRadios = {}
local valueVolume = {}

local loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

local loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

function OpenBoomBoxSettings(boombox)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local radio = GetClosestObjectOfType(pedCoords, 5.0, `prop_boombox_01`, false)
    local radioCoords = GetEntityCoords(radio)

    if not activeRadios[radio] then
        activeRadios[radio] = {
            pos = radioCoords,
            data = {
                playing = false
            },
            sound = 50
        }
    else
        activeRadios[radio].pos = radioCoords
    end
    if not activeRadios[radio].data.playing then
        KeyboardUtils.use(Locales[Config.Language]['play_boombox'],function(url) 
            if url then
                local musicId = 'id_'..radio

                TriggerServerEvent("lgd_boombox:soundStatus", "play", musicId, { position = activeRadios[radio].pos, link = url, volume = 50/100, distance = 10 })
                activeRadios[radio].data = {playing = true, currentId = 'id_'..PlayerId()}
                TriggerServerEvent('lgd_boombox:syncActive', activeRadios)
            end
        end);
    else
        KeyboardUtils.use(Locales[Config.Language]['change_boombox'],function(url) 
            if url then
                local musicId = 'id_'..radio
                TriggerServerEvent("lgd_boombox:soundStatus", "play", musicId, { position = activeRadios[radio].pos, link = url, volume = 50/100, distance = 10 })
                activeRadios[radio].data = {playing = true, currentId = 'id_'..PlayerId()}
                TriggerServerEvent('lgd_boombox:syncActive', activeRadios)
            end
        end);
    end
end



local boomboxPlaced = function(obj)
    local coords = GetEntityCoords(obj)
    local heading = GetEntityHeading(obj)
    local targetPlaced = false
    valueVolume[obj] = {
        sound = 50,
        distance = 20
    }
    CreateThread(function()
        while DoesEntityExist(obj) do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(coords - playerCoords)
            if distance <= 1.5 then
                ShowHelpNotification((Locales[Config.Language]['information_boombox']):format(valueVolume[obj].sound, valueVolume[obj].distance))
                if IsDisabledControlJustReleased(0, 38) then
                    OpenBoomBoxSettings(obj)
                end
                if IsDisabledControlJustReleased(0, 23) then
                    local ped = PlayerPedId()
                    local pedCoords = GetEntityCoords(ped)
                    local radio = `prop_boombox_01`
                    local closestRadio = GetClosestObjectOfType(pedCoords, 3.0, radio, false)
                    local radioCoords = GetEntityCoords(closestRadio)                    
                    musicId = getRadio()
                    TaskTurnPedToFaceCoord(ped, radioCoords.x, radioCoords.y, radioCoords.z, 2000)
                    if not IsEntityPlayingAnim(ped, "pickup_object", "pickup_low", 3) then
                        RequestAnimDict("pickup_object")
                        while not HasAnimDictLoaded("pickup_object") do
                            Citizen.Wait(0)
                        end
                    
                        TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, 8.0, -1, 50, 0, false, false, false)
                    end                    Wait(1000)
                    if xSound:soundExists(musicId) then
                        TriggerServerEvent("lgd_boombox:soundStatus", "stop", musicId, {})
                    end
                    FreezeEntityPosition(closestRadio, false)
                    TriggerServerEvent("lgd_boombox:deleteObj", ObjToNet(closestRadio))
                    if activeRadios[closestRadio] then
                        activeRadios[closestRadio] = nil
                    end
                    TriggerServerEvent('lgd_boombox:syncActive', activeRadios)
                    ClearPedTasks(ped)
                end
                if IsDisabledControlJustReleased(0, 174) then
                    musicId = getRadio()
                    if tonumber(valueVolume[obj].sound) and tonumber(valueVolume[obj].sound) >= Config.MinVolume +5 then                    valueVolume[obj].sound = valueVolume[obj].sound - 5
                        valueVolume[obj].sound = valueVolume[obj].sound - 5
                        TriggerServerEvent("lgd_boombox:soundStatus", "volume", musicId, {volume = valueVolume[obj].sound/100})
                    end
                end
                if IsDisabledControlJustReleased(0, 175) then
                    musicId = getRadio()
                    if tonumber(valueVolume[obj].sound) and tonumber(valueVolume[obj].sound) <= Config.MaxVolume -5 then
                        valueVolume[obj].sound = valueVolume[obj].sound + 5
                        TriggerServerEvent("lgd_boombox:soundStatus", "volume", musicId, {volume = valueVolume[obj].sound/100})
                    end
                end

                if IsDisabledControlJustReleased(0, 173) then
                    musicId = getRadio()
                    if tonumber(valueVolume[obj].distance) and tonumber(valueVolume[obj].distance) >= Config.MinDistance +5 then
                        valueVolume[obj].distance = valueVolume[obj].distance - 5
                        TriggerServerEvent("lgd_boombox:soundStatus", "distance", musicId, {distance = valueVolume[obj].distance})
                    end
                end
                if IsDisabledControlJustReleased(0, 172) then
                    musicId = getRadio()
                    if tonumber(valueVolume[obj].distance) and tonumber(valueVolume[obj].distance) <= Config.MaxDistance -5 then
                        valueVolume[obj].distance = valueVolume[obj].distance + 5
                        TriggerServerEvent("lgd_boombox:soundStatus", "distance", musicId, {distance = valueVolume[obj].distance})
                    end
                end
                
                Wait(1)
            else
                Wait(1000)
            end
        end
    end)
end


function getRadio()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local radio = `prop_boombox_01`
    local closestRadio = GetClosestObjectOfType(pedCoords, 3.0, radio, false)
    local musicId = 'id_'..closestRadio
    return musicId
end

local hasBoomBox = function(radio)
    local equipRadio = true
    CreateThread(function()
        ShowHelpNotification(Locales[Config.Language]['pos_boombox'])
        while equipRadio do
            Wait(0)
            if IsControlJustReleased(0, 38) then
                equipRadio = false
                DetachEntity(radio)
                PlaceObjectOnGroundProperly(radio)
                FreezeEntityPosition(radio, true)
                boomboxPlaced(radio)
            end
        end
    end)
end


RegisterNetEvent('lgd_boombox:useBoombox')
AddEventHandler('lgd_boombox:useBoombox', function(activeBoxes)
    local ped = PlayerPedId()
    local hash = loadModel('prop_boombox_01')
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped,0.0,3.0,0.5))
    local radio = CreateObjectNoOffset(hash, x, y, z, true, false)
    SetModelAsNoLongerNeeded(hash)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`)
    AttachEntityToEntity(radio, ped, GetPedBoneIndex(ped, 57005), 0.32, 0, -0.05, 0.10, 270.0, 60.0, true, true, false, true, 1, true)
    hasBoomBox(radio)
end)



RegisterNetEvent('lgd_boombox:syncActive')
AddEventHandler('lgd_boombox:syncActive', function(activeBoxes)
    activeRadios = activeBoxes
end)


RegisterNetEvent('lgd_boombox:soundStatus')
AddEventHandler('lgd_boombox:soundStatus', function(type, musicId, data)
    CreateThread(function()
        if type == "position" then
            if xSound:soundExists(musicId) then
                xSound:Position(musicId, data.position)
            end
        end
        if type == "play" then
            TriggerServerEvent('wasabi_boombox:DiscordKnows',data.link)
            xSound:PlayUrlPos(musicId, data.link, data.volume, data.position)
            xSound:Distance(musicId, data.distance)
            xSound:setVolume(musicId, data.volume)
        end
        
        if type == "distance" then
            xSound:Distance(musicId, data.distance)
        end

        if type == "volume" then
            xSound:setVolume(musicId, data.volume)
        end

        if type == "stop" then
            xSound:Destroy(musicId)
        end
    end)
end)
    

RegisterNetEvent('lgd_boombox:deleteObj', function(netId)
    if DoesEntityExist(NetToObj(netId)) then
        DeleteObject(NetToObj(netId))
        if not DoesEntityExist(NetToObj(netId)) then
            TriggerServerEvent('lgd_boombox:objDeleted')
        end
    end
end)