---
--- @author Kadir#6666
--- Create at [30/05/2023] 19:07:11
--- Current project [Valestia-V1]
--- File name [PlayerDropped]
---

Shared.Events:OnNet(Enums.Administration.Client.PlayerDropped, function(player_character, player_name, player_coords, drop_reason)

    local arguments_is_wrong = (type(player_character) ~= "number" or type(player_name) ~= "string" or type(player_coords) ~= "vector3" or type(drop_reason) ~= "string");
    if (arguments_is_wrong) then
        return
    end

    local display_show = true

    SetTimeout(1000*30, function()
        display_show = nil;
    end);

    while (display_show) do

        local display_show_loop = 3000
        local player_dist = (#(Client.Player:GetCoords()-player_coords))

        if (player_dist <= 100.0) then

            display_show_loop = 0;
            Game:DrawText3D(vector3(player_coords.x, player_coords.y, (player_coords.z + 0.2)), Shared.Lang:Translate("admin_display_player_dropped", player_character, player_name, drop_reason), 0.6);

        end

        Wait(display_show_loop)

    end

end)