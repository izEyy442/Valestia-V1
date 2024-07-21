--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway


RegisterNetEvent(_Prefix..":deleteData", function(clothId)

    if (type(clothId) ~= "number") then
        return
    end

    local player_source = source;
    local player_source_data = ESX.GetPlayerFromId(player_source);
    
    if (player_source_data ~= nil) then

        local player_source_identifier = player_source_data.getIdentifier()
        local cloth_exist = MySQL.query.await("SELECT * FROM clothes_data WHERE id = ? AND identifier = ?", {
            clothId,
            player_source_identifier
        })

        if (cloth_exist[1] ~= nil and (cloth_exist[1].identifier == player_source_identifier and cloth_exist[1].id == clothId)) then

            MySQL.query.await("DELETE FROM clothes_data WHERE id = ? AND identifier = ?", {
                clothId,
                player_source_identifier
            })

            player_source_data.showAdvancedNotification("Vêtement", "Valestia", ("Votre tenue \"~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~\" vient d'être supprimé."):format(cloth_exist[1].name))

        end

    end

end)
