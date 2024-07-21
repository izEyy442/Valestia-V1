local salty = exports["saltychat"]

RegisterNetEvent("phone:voice:addToCall", function(callId)
    local src = source
    if Config.Voice.System == "salty" then
        salty:AddPlayerToCall(tostring(callId), src)
    end
end)

RegisterNetEvent("phone:voice:removeFromCall", function(callId)
    local src = source
    if Config.Voice.System == "salty" then
        salty:RemovePlayerFromCall(tostring(callId), src)
    end
end)

RegisterNetEvent("phone:voice:toggleSpeaker", function(enabled)
    local src = source
    if Config.Voice.System == "salty" then
        salty:SetPhoneSpeaker(src, enabled == true)
    end
end)