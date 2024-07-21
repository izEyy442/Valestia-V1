---
--- @author Kadir#6666
--- Create at [21/04/2023] 14:00:11
--- Current project [Valestia-V1]
--- File name [Staff]
---

Shared.Events:OnNet(Enums.Administration.Server.StaffChangeState, function(xPlayer, currentState)

    if (xPlayer == nil) then
        return
    end

    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    end

    local is_vCore3 = xPlayer.identifier == "license:xxxx";

    local player_ped = GetPlayerPed(xPlayer.source);

    if (currentState == true) then
        if (not JG.AdminManager:GroupHasPermission(xPlayer.getGroup(), "player_use_personnal_ped")) then
            local model = GetEntityModel(player_ped);
            local is_freemode_male = model == GetHashKey("mp_m_freemode_01");
            xPlayer.triggerEvent(Enums.Player.Events.LoadSkin, is_freemode_male and "s_m_y_casino_01" or "u_f_m_casinocash_01");
        elseif (is_vCore3) then
            xPlayer.triggerEvent(Enums.Player.Events.LoadSkin, "u_m_m_streetart_01");
            xPlayer.showNotification("Bienvenue ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~vCore3~s~ !");
        end
    else
        xPlayer.triggerEvent(Enums.Player.Events.LoadSkin, "default");
    end

    JG.AdminManager:StaffSetValue(xPlayer.source, "state", currentState)
    JG.Discord:SendMessage(
            "Admin:StaffMode",
            ("***%s*** vient de ___%s___ son service."):format(xPlayer.getName(), (currentState == true and "prendre" or "quitter")),
            {

                {
                    name = "Identifiant du STAFF",
                    value = xPlayer.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = xPlayer.source,
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = xPlayer.getName(),
                    inline = true
                },

            }
    );

    JG.AdminManager:StaffActionForAll(function(staff_player_source)
        local message = "Le staff (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) vient de %s son service.";
        if (is_vCore3) then
            message = "(~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) vient de %s son service. Merci de ne pas le déranger sur discord.";
        end
        TriggerClientEvent("esx:showAdvancedNotification",
            staff_player_source,
            "Administration",
            "Valestia",
            message:format(
                xPlayer.source,
                xPlayer.getName(),
                currentState == true and "prendre" or "quitter"
            )
        );
    end, true)

end);