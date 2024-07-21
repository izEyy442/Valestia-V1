--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway

RegisterServerEvent(_Prefix..":refreshData")
AddEventHandler(_Prefix..":refreshData", function()
    local playerSrc = source
    local xPlayer = ESX.GetPlayerFromId(playerSrc)

    MySQL.Async.fetchAll('SELECT * FROM clothes_data WHERE identifier = @identifier', {
        ["@identifier"] = xPlayer.identifier
    }, function(result)
        TriggerClientEvent(_Prefix..":sendData", playerSrc, result)
    end)
end)