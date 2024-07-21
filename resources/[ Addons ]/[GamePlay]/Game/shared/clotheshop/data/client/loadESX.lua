--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway
---@version 1.0

ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent(_Config.getESX, function(obj) ESX = obj end)
        Wait(10)
    end
end)