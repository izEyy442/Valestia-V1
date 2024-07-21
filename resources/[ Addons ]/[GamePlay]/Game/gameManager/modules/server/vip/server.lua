--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local vips = {
    --'steam:1',
}

-- Pas touche
function isVip(player)
    local allowed = false
    for i,id in ipairs(vips) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand("vip", function(src)
    local xPlayer = ESX.GetPlayerFromId(src);
    xPlayer.updateVIP(function()
        xPlayer.triggerEvent("vCore3:AimeLesPigeons", xPlayer.getVIP(), xPlayer.getVIP() > 0);
    end);
end);
