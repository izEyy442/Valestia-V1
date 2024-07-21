--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local ESX = nil

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

local identifier
local characters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

function GetIdentifiers(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for k, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[k]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[k]
        end
        return identifiers
    else
        error("source is nil")
    end
end