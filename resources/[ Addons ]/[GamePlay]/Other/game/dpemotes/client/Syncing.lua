local isRequestAnim = false
local requestedemote = ''
local targetPlayerId = ''

if DPc.SharedEmotesEnabled then
    RegisterCommand('nearby', function(source, args, raw)
        if #args > 0 then
            local emotename = string.lower(args[1])
            target, distance = GetClosestPlayer()
            if (distance ~= -1 and distance < 3) then
                if RP.Shared[emotename] ~= nil then
                    dict, anim, ename = table.unpack(RP.Shared[emotename])
                    TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), emotename)
                    SimpleNotify(DPc.Languages[lang]['sentrequestto'] ..
                        GetPlayerName(target) .. " ~w~(~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" .. ename .. "~w~)")
                else
                    EmoteChatMessage("'" .. emotename .. "' " .. DPc.Languages[lang]['notvalidsharedemote'] .. "")
                end
            else
                SimpleNotify(DPc.Languages[lang]['nobodyclose'])
            end
        else
            NearbysOnCommand()
        end
    end, false)
end

RegisterNetEvent("SyncPlayEmote")
AddEventHandler("SyncPlayEmote", function(emote, player)
    EmoteCancel()
    Wait(300)
    targetPlayerId = player
    if RP.Shared[emote] ~= nil then
        if RP.Shared[emote].AnimationOptions and RP.Shared[emote].AnimationOptions.Attachto then
            local targetEmote = RP.Shared[emote][4]
            if not targetEmote or not RP.Shared[targetEmote] or not RP.Shared[targetEmote].AnimationOptions or
                not RP.Shared[targetEmote].AnimationOptions.Attachto then
                local plyServerId = GetPlayerFromServerId(player)
                local ply = PlayerPedId()
                local pedInFront = GetPlayerPed(plyServerId ~= 0 and plyServerId or GetClosestPlayer())
                local bone = RP.Shared[emote].AnimationOptions.bone or -1 -- No bone
                local xPos = RP.Shared[emote].AnimationOptions.xPos or 0.0
                local yPos = RP.Shared[emote].AnimationOptions.yPos or 0.0
                local zPos = RP.Shared[emote].AnimationOptions.zPos or 0.0
                local xRot = RP.Shared[emote].AnimationOptions.xRot or 0.0
                local yRot = RP.Shared[emote].AnimationOptions.yRot or 0.0
                local zRot = RP.Shared[emote].AnimationOptions.zRot or 0.0
                AttachEntityToEntity(ply, pedInFront, GetPedBoneIndex(pedInFront, bone), xPos, yPos, zPos, xRot, yRot,
                    zRot, false, false, false, true, 1, true)
            end
        end
        OnEmotePlay(RP.Shared[emote])
        return
    elseif RP.Dances[emote] ~= nil then
        OnEmotePlay(RP.Dances[emote])
        return
    end
end)

RegisterNetEvent("SyncPlayEmoteSource")
AddEventHandler("SyncPlayEmoteSource", function(emote, player)
    local ply = PlayerPedId()
    local plyServerId = GetPlayerFromServerId(player)
    local pedInFront = GetPlayerPed(plyServerId ~= 0 and plyServerId or GetClosestPlayer())

    local SyncOffsetFront = 1.0
    local SyncOffsetSide = 0.0
    local SyncOffsetHeight = 0.0
    local SyncOffsetHeading = 180.1

    local AnimationOptions = RP.Shared[emote] and RP.Shared[emote].AnimationOptions
    if AnimationOptions then
        if AnimationOptions.SyncOffsetFront then
            SyncOffsetFront = AnimationOptions.SyncOffsetFront + 0.0
        end
        if AnimationOptions.SyncOffsetSide then
            SyncOffsetSide = AnimationOptions.SyncOffsetSide + 0.0
        end
        if AnimationOptions.SyncOffsetHeight then
            SyncOffsetHeight = AnimationOptions.SyncOffsetHeight + 0.0
        end
        if AnimationOptions.SyncOffsetHeading then
            SyncOffsetHeading = AnimationOptions.SyncOffsetHeading + 0.0
        end

        if (AnimationOptions.Attachto) then
            local bone = AnimationOptions.bone or -1
            local xPos = AnimationOptions.xPos or 0.0
            local yPos = AnimationOptions.yPos or 0.0
            local zPos = AnimationOptions.zPos or 0.0
            local xRot = AnimationOptions.xRot or 0.0
            local yRot = AnimationOptions.yRot or 0.0
            local zRot = AnimationOptions.zRot or 0.0
            AttachEntityToEntity(ply, pedInFront, GetPedBoneIndex(pedInFront, bone), xPos, yPos, zPos, xRot, yRot, zRot,
                false, false, false, true, 1, true)
        end
    end
    local coords = GetOffsetFromEntityInWorldCoords(pedInFront, SyncOffsetSide, SyncOffsetFront, SyncOffsetHeight)
    local heading = GetEntityHeading(pedInFront)
    SetEntityHeading(ply, heading - SyncOffsetHeading)
    SetEntityCoordsNoOffset(ply, coords.x, coords.y, coords.z, 0)
    EmoteCancel()
    Wait(300)
    targetPlayerId = player
    if RP.Shared[emote] ~= nil then
        OnEmotePlay(RP.Shared[emote])
        return
    elseif RP.Dances[emote] ~= nil then
        OnEmotePlay(RP.Dances[emote])
        return
    end
end)

RegisterNetEvent("SyncCancelEmote")
AddEventHandler("SyncCancelEmote", function(player)
    if targetPlayerId and targetPlayerId == player then
        targetPlayerId = nil
        EmoteCancel()
    end
end)

function CancelSharedEmote(ply)
    if targetPlayerId then
        TriggerServerEvent("ServerEmoteCancel", targetPlayerId)
        targetPlayerId = nil
    end
end

RegisterNetEvent("ClientEmoteRequestReceive")
AddEventHandler("ClientEmoteRequestReceive", function(emotename, etype)
    isRequestAnim = true
    requestedemote = emotename

    if etype == 'Dances' then
        _, _, remote = table.unpack(RP.Dances[requestedemote])
    else
        _, _, remote = table.unpack(RP.Shared[requestedemote])
    end

    PlaySound(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 0, 0, 1)
    SimpleNotify(DPc.Languages[lang]['doyouwanna'] .. remote .. "~w~)")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsControlJustPressed(1, 246) and isRequestAnim then
            target, distance = GetClosestPlayer()
            if (distance ~= -1 and distance < 3) then
                if RP.Shared[requestedemote] ~= nil then
                    _, _, _, otheremote = table.unpack(RP.Shared[requestedemote])
                elseif RP.Dances[requestedemote] ~= nil then
                    _, _, _, otheremote = table.unpack(RP.Dances[requestedemote])
                end
                if otheremote == nil then otheremote = requestedemote end
                TriggerServerEvent("JEVALIDELADANCE", GetPlayerServerId(target), requestedemote, otheremote)
                isRequestAnim = false
            else
                SimpleNotify(DPc.Languages[lang]['nobodyclose'])
            end
        elseif IsControlJustPressed(1, 182) and isRequestAnim then
            SimpleNotify(DPc.Languages[lang]['refuseemote'])
            isRequestAnim = false
        end
    end
end)

function GetPlayerFromPed(ped)
    for _, player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == ped then
            return player
        end
    end
    return -1
end

function GetPedInFront()
    local player = PlayerId()
    local plyPed = GetPlayerPed(player)
    local plyPos = GetEntityCoords(plyPed, false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
    local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 10.0, 12
        , plyPed, 7)
    local _, _, _, _, ped2 = GetShapeTestResult(rayHandle)
    return ped2
end

function NearbysOnCommand(source, args, raw)
    local NearbysCommand = ""
    for a in pairsByKeys(RP.Shared) do
        NearbysCommand = NearbysCommand .. "" .. a .. ", "
    end
    EmoteChatMessage(NearbysCommand)
    EmoteChatMessage(DPc.Languages[lang]['emotemenucmd'])
end

function SimpleNotify(message)
    if DPc.NotificationsAsChatMessage then
        TriggerEvent("chat:addMessage", { color = { 255, 255, 255 }, args = { tostring(message) } })
    else
        ESX.ShowAdvancedNotification('Notification', 'Menu Emote', message, 'CHAR_CALL911', 8)
    end
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index, value in ipairs(players) do
        local target = GetPlayerPed(value)
        if (target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"],
                plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
