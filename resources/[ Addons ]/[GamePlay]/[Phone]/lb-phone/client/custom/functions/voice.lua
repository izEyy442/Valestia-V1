local pma = exports["pma-voice"]
local mumble = exports["mumble-voip"]
local toko = exports["tokovoip_script"]

function AddToCall(callId)
    debugprint("Joining call", callId)
    if Config.Voice.System == "pma" then
        pma:addPlayerToCall(callId)
    elseif Config.Voice.System == "mumble" then
        mumble:addPlayerToCall(callId)
    elseif Config.Voice.System == "salty" then
        TriggerServerEvent("phone:voice:addToCall", callId)
    elseif Config.Voice.System == "toko" then
        toko:addPlayerToRadio(callId)
    end
end

function RemoveFromCall(callId)
    debugprint("Leaving call", callId)
    if Config.Voice.System == "pma" then
        pma:removePlayerFromCall()
    elseif Config.Voice.System == "mumble" then
        mumble:removePlayerFromCall()
    elseif Config.Voice.System == "salty" then
        TriggerServerEvent("phone:voice:removeFromCall", callId)
    elseif Config.Voice.System == "toko" then
        toko:removePlayerFromRadio(callId)
    end
end

function ToggleSpeaker(enabled)
    if Config.Voice.System == "salty" then
        TriggerServerEvent("phone:voice:toggleSpeaker", enabled)
    end
end

local MumbleIsPlayerTalking = MumbleIsPlayerTalking
local NetworkIsPlayerTalking = NetworkIsPlayerTalking
function IsTalking()
    if Config.Voice.System == "pma" or Config.Voice.System == "mumble" then
        return MumbleIsPlayerTalking(PlayerId())
    else
        return NetworkIsPlayerTalking(PlayerId())
    end
end

local function ConvertProximityToUnits(proximity)
    return -0.3045 * proximity^2 + 5.016 * proximity - 2.5919
end

function GetVoiceMaxDistance()
    local proximity = MumbleGetTalkerProximity()
    return ConvertProximityToUnits(proximity)
end

-- This thread is used to send the talking state to the frontend, used to record audio only when talking in-game
CreateThread(function()
    local talking = false

    RegisterNUICallback("isTalking", function(_, cb)
        cb(IsTalking())
    end)

    while true do
        Wait(100)

        if IsTalking() and not talking then
            talking = true
            SendReactMessage("camera:toggleMicrophone", talking)
        elseif not IsTalking() and talking then
            talking = false
            SendReactMessage("camera:toggleMicrophone", talking)
        end
    end
end)

-- proximity
local speakerEffect, callEffect
local data = {
    [`default`] = 0,
    [`freq_low`] = 100.0, -- Lower cutoff frequency
    [`freq_hi`] = 10000.0, -- Upper cutoff frequency
    [`rm_mod_freq`] = 300.0,
    [`fudge`] = 0.5, -- Add some randomness to the effect
    [`o_freq_lo`] = 200.0,
    [`o_freq_hi`] = 5000.0,
}

CreateThread(function()
    if Config.Voice.CallEffects then
        speakerEffect = CreateAudioSubmix("phonespeaker")
        SetAudioSubmixEffectRadioFx(speakerEffect, 0)
        SetAudioSubmixEffectParamInt(speakerEffect, 0, `default`, 1)

        callEffect = CreateAudioSubmix("phonecall")
        SetAudioSubmixEffectRadioFx(callEffect, 0)
        SetAudioSubmixEffectParamInt(callEffect, 0, `default`, 1)

        for hash, value in pairs(data) do
            SetAudioSubmixEffectParamFloat(speakerEffect, 0, hash, value)
            SetAudioSubmixEffectParamFloat(callEffect, 0, hash, value)
        end

        SetAudioSubmixEffectParamFloat(speakerEffect, 0, `rm_mix`, 0.15)
        SetAudioSubmixEffectParamFloat(callEffect, 0, `rm_mix`, 0.05)

        SetAudioSubmixOutputVolumes(speakerEffect, 0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
        SetAudioSubmixOutputVolumes(callEffect, 0, 0.25, 1.0, 0.0, 0.0, 1.0, 1.0)

        AddAudioSubmixOutput(speakerEffect, 0)
        AddAudioSubmixOutput(callEffect, 0)
    end
end)

local voiceTargets = {}
CreateThread(function()
    while true do
        local currentTargets = table.clone(voiceTargets)

        for source, audio in pairs(currentTargets) do
            MumbleAddVoiceTargetPlayerByServerId(1, source)
            if contains(watchingSources, source) then
                MumbleSetVolumeOverrideByServerId(source, 1.0)
            else
                MumbleSetVolumeOverrideByServerId(source, audio and 0.7 or -1.0)
            end
        end

        Wait(250)
    end
end)

RegisterNetEvent("phone:phone:setCallEffect", function(source, enabled)
    if Config.Voice.System == "pma" or Config.Voice.System == "mumble" and Config.Voice.CallEffects then
        debugprint("setCallEffect", source, enabled and callEffect or -1)
        MumbleSetSubmixForServerId(source, enabled and callEffect or -1)
    end
end)

RegisterNetEvent("phone:phone:addVoiceTarget", function(sources, audio, phoneCall)
    if type(sources) ~= "table" then
        sources = {sources}
    end

    for i = 1, #sources do
        local id = sources[i]
        if id == GetPlayerServerId(PlayerId()) then
            goto continue
        end

        voiceTargets[id] = audio or false
        if phoneCall and Config.Voice.CallEffects then
            MumbleSetSubmixForServerId(id, speakerEffect)
        end
        debugprint("Added voice target", id, audio)

        ::continue::
    end
end)

RegisterNetEvent("phone:phone:removeVoiceTarget", function(sources, phoneCall)
    if type(sources) ~= "table" then
        sources = {sources}
    end

    for i = 1, #sources do
        local id = sources[i]
        if id == GetPlayerServerId(PlayerId()) then
            goto continue
        end

        voiceTargets[id] = nil
        MumbleRemoveVoiceTargetPlayerByServerId(1, id)
        MumbleSetVolumeOverrideByServerId(id, -1.0)
        if phoneCall and Config.Voice.CallEffects then
            MumbleSetSubmixForServerId(id, -1)
        end
        debugprint("Removed voice target", id)

        ::continue::
    end
end)

-- instagram proximity
RegisterNetEvent("phone:instagram:enteredProximity", function(source, liveHost)
    if not contains(watchingSources, liveHost) then -- if we're not watching "liveHost", don't listen to "source"
        return
    end

    local player = GetPlayerFromServerId(source)
    if player and player ~= -1 and #(GetEntityCoords(GetPlayerPed(player)) - GetEntityCoords(PlayerPedId())) <= 15 then
        return
    end

    debugprint("Adding live target", source)
    voiceTargets[source] = true
end)

RegisterNetEvent("phone:instagram:leftProximity", function(source, liveHost)
    if not contains(watchingSources, liveHost) then -- if we're not watching "liveHost", don't listen to "source"
        return
    end

    voiceTargets[source] = nil
    MumbleRemoveVoiceTargetPlayerByServerId(1, source)
    MumbleSetVolumeOverrideByServerId(source, -1.0)
    debugprint("Removing live target", source)
end)

-- local _MumbleSetVolumeOverrideByServerId = MumbleSetVolumeOverrideByServerId
-- function MumbleSetVolumeOverrideByServerId(source, volume)
--     _MumbleSetVolumeOverrideByServerId(source, volume)
--     debugprint("MumbleSetVolumeOverrideByServerId", source, volume)
-- end