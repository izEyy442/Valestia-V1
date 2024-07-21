--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@class _Razzway
_Razzway = {};
_Razzway.Data = {};

BLCCCCCCCCCC = true

---@author Razzway
---@type function _Razzway:refreshData
function _Razzway:refreshData()
  if BLCCCCCCCCCC == true then 
    TriggerServerEvent(_Prefix..":refreshData")
  end
end

RegisterNetEvent(_Prefix..":sendData")
AddEventHandler(_Prefix..":sendData", function(data)
    _Razzway.Data = data
    BLCCCCCCCCCC = true
end)