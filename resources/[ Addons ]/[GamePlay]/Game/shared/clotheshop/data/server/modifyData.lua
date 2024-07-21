--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway

RegisterNetEvent(_Prefix..":modifyData")
AddEventHandler(_Prefix..":modifyData", function(id, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute("UPDATE clothes_data SET name = @name WHERE id = @id", {
        ["@id"] = id,
        ["@name"] = name,
    })
    if (_ServerConfig.enableLogs) then
        _Server:toDiscord(_ServerConfig.param.name, (xPlayer.getName()..' a attribué un nouveau nom à sa tenue | ID tenue : %s - Nom : %s'):format(id, name), _ServerConfig.param.colorJaune)
    end
end)