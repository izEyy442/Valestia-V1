RegisterNetEvent("vCore1:Valestia:player:receive_player_data", function(playerData)

    if (playerData and type(playerData) == "table") then

        Client:InitializePlayer(playerData);

    else

        TriggerServerEvent("Enums.Player.Events.KickPlayer", "Les données du joueur n'ont pas pu être chargées.")

    end

end);