local stunnedCache = {}
local stunnedStack = 0

local function FadeOutStunnedTimecycle(from)
    local strength = from
    local increments = from / 100

    for _i = 1, 100 do
        Wait(50)
        strength = strength - increments

        if stunnedStack >= 1 then
            return
        end

        if strength <= 0 then
            break
        end

        SetTimecycleModifierStrength(strength)
    end

    SetTimecycleModifierStrength(0.0)
    ClearTimecycleModifier()
end

local function DoTaserEffect()
    stunnedStack = stunnedStack + 1
    SetTimecycleModifierStrength(0.5)
    SetTimecycleModifier("dont_tazeme_bro")

    Wait(8000)
    stunnedStack = stunnedStack - 1
    if stunnedStack == 0 then
        FadeOutStunnedTimecycle(0.5)
    end
end

AddEventHandler('gameEventTriggered', function(event, args)
    if event == "CEventNetworkEntityDamage" then
        local playerPed = PlayerPedId()
            if playerPed == args[1] then
            local attacker = args[2]
            local weaponHash = args[7]
            if attacker ~= -1 and (weaponHash == 911657153 or weaponHash == -1833087301) then
                SetTimeout(50, function()
                    local gameTimer = GetGameTimer()
                    if stunnedCache[attacker] and stunnedCache[attacker] + 2800 > gameTimer then
                        return
                    end

                    if IsPedBeingStunned(playerPed, 0) then
                        stunnedCache[attacker] = gameTimer
                        DoTaserEffect()
                    end
                end)
            end
        end
    end
end)