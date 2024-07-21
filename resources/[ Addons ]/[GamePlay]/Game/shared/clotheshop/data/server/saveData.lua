--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway

RegisterNetEvent(_Prefix..":saveData")
AddEventHandler(_Prefix..":saveData", function(type, name, data)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if type == "outfit" then
        MySQL.Async.execute("INSERT INTO `clothes_data` (identifier, name, data, type) VALUES (@identifier, @name, @data, @type)", {
            ["@identifier"] = xPlayer.identifier,
            ["@name"] = name,
            ["@data"] = json.encode(data),
            ["@type"] = type,
        })
    end
    if (_ServerConfig.enableLogs) then
        _Server:toDiscord(_ServerConfig.param.name, (xPlayer.getName()..' a enregitré une nouvelle tenue dans son dressing | Nom : %s'):format(name), _ServerConfig.param.colorVert)
    end
end)