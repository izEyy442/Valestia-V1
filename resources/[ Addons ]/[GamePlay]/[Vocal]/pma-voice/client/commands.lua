ESX = exports['Framework']:getSharedObject()

local wasProximityDisabledFromOverride = false
disableProximityCycle = false
RegisterCommand('setvoiceintent', function(source, args)
    if GetConvarInt('voice_allowSetIntent', 1) == 1 then
        local intent = args[1]
        if intent == 'speech' then
            MumbleSetAudioInputIntent(`speech`)
        elseif intent == 'music' then
            MumbleSetAudioInputIntent(`music`)
        end
        LocalPlayer.state:set('voiceIntent', intent, true)
    end
end)

-- TODO: Better implementation of this?
RegisterCommand('vol', function(_, args)
	if not args[1] then return end
	setVolume(tonumber(args[1]))
end)

exports('setAllowProximityCycleState', function(state)
	type_check({state, "boolean"})
	disableProximityCycle = state
end)

function setProximityState(proximityRange, isCustom)
	local voiceModeData = Cfg.voiceModes[mode]
	MumbleSetTalkerProximity(proximityRange + 0.0)
	LocalPlayer.state:set('proximity', {
		index = mode,
		distance = proximityRange,
		mode = isCustom and "Custom" or voiceModeData[2],
	}, true)
	sendUIMessage({
		-- JS expects this value to be - 1, "custom" voice is on the last index
		voiceMode = isCustom and #Cfg.voiceModes or mode - 1
	})
end

exports("overrideProximityRange", function(range, disableCycle)
    type_check({ range, "number" })
    setProximityState(range, true)
    if disableCycle then
        disableProximityCycle = true
        wasProximityDisabledFromOverride = true
    end
end)

exports("clearProximityOverride", function()
    local voiceModeData = Cfg.voiceModes[mode]
    setProximityState(voiceModeData[1], false)
    if wasProximityDisabledFromOverride then
        disableProximityCycle = false
    end
end)

RegisterCommand('cycleproximity', function()
	-- Proximity is either disabled, or manually overwritten.
	if GetConvarInt('voice_enableProximityCycle', 1) ~= 1 or disableProximityCycle then return end
	local newMode = mode + 1

	-- If we're within the range of our voice modes, allow the increase, otherwise reset to the first state
	if newMode <= #Cfg.voiceModes then
		mode = newMode
	else
		mode = 1
	end

	setProximityState(Cfg.voiceModes[mode][1], false)
	TriggerEvent('pma-voice:setTalkingMode', mode)


	Citizen.CreateThread(function()
		local i = 0
		while i < 15 do
			Citizen.Wait(0)
			i = i + 1
			DrawMarker(1, GetEntityCoords(PlayerPedId()) - vector3(0, 0, 0.9), 0, 0, 0, 0, 0, 0, Cfg.voiceModes[mode][1] * 2.0, Cfg.voiceModes[mode][1] * 2.0, 0.8001, 5, 91, 250, 140, 0,0, 0,0)
		end
	end)

	ESX.ShowNotification('Votre porté de voix est de ' .. Cfg.voiceModes[mode][1] .. "m")

end, false)

if gameVersion == 'fivem' then
	RegisterKeyMapping('cycleproximity', 'Cycle Proximity', 'keyboard', GetConvar('voice_defaultCycle', 'F11'))
end