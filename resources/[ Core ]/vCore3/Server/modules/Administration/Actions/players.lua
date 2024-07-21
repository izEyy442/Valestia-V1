---
--- @author Kadir#6666
--- Create at [29/04/2023] 19:10:25
--- Current project [Valestia-V1]
--- File name [accounts]
---

---@param xPlayer xPlayer
---@param coords_index number
Shared.Events:OnNet(Enums.Administration.Server.Actions.Player.TeleportCoords, function(xPlayer, coords_index, player_id)

    player_id = tonumber(player_id)

    if (xPlayer == nil) then
        return
    end

    local player_group = JG.AdminManager:GetPlayerGroup(xPlayer)
    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (not JG.AdminManager:StaffGetValue(xPlayer.source, "state")) then
        return
    end

    local target_player_selected = ESX.GetPlayerFromId(player_id)
    local target_player_ped = GetPlayerPed(player_id)
    if (not target_player_selected) then
        return
    end

    local target_player_group = JG.AdminManager:GetPlayerGroup(target_player_selected)
    local target_player_is_staff = JG.AdminManager:PlayerIsStaff(target_player_selected)
    local target_player_is_staff_higher = JG.AdminManager:GroupIsHigher(player_group, target_player_group, true)

    if ((target_player_is_staff == true and JG.AdminManager:StaffGetValue(target_player_selected.source, "state") == true and target_player_is_staff_higher ~= true)) then

        return

    end

    local coords_data = Config["Admin"]["TeleportCoords"][coords_index]
    if (coords_data == nil) then
        return
    end

    SetEntityCoords(target_player_ped, coords_data["coords"])
    xPlayer.showNotification(("Vous avez amené le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) dans la position (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(target_player_selected.source, target_player_selected.getName(), coords_data.value))

end)

---@param xPlayer xPlayer
---@param player_id number
Shared.Events:OnNet(Enums.Administration.Server.Actions.Player.Freeze, function(xPlayer, player_id)

    player_id = tonumber(player_id)

    if (xPlayer == nil) then
        return
    end

    local player_group = JG.AdminManager:GetPlayerGroup(xPlayer)
    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (not JG.AdminManager:StaffGetValue(xPlayer.source, "state")) then
        return
    end

    local target_player_selected = ESX.GetPlayerFromId(player_id)
    local target_player_ped = GetPlayerPed(player_id)
    if (not target_player_selected) then
        return
    end

    local target_player_group = JG.AdminManager:GetPlayerGroup(target_player_selected)
    local target_player_is_staff = JG.AdminManager:PlayerIsStaff(target_player_selected)
    local target_player_is_staff_higher = JG.AdminManager:GroupIsHigher(player_group, target_player_group, true)

    if ((target_player_is_staff == true and JG.AdminManager:StaffGetValue(target_player_selected.source, "state") == true and target_player_is_staff_higher ~= true)) then

        return

    end

    Shared.Events:Broadcast(Enums.Administration.Client.Actions.Entity, "entity_freeze", NetworkGetNetworkIdFromEntity(target_player_ped))

end)

Shared.Events:OnNet(Enums.Administration.Server.Actions.Player.GetInventory, function(xPlayer, player_source)

    if (xPlayer == nil) then
        return
    end

    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (not JG.AdminManager:StaffGetValue(xPlayer.source, "state")) then
        return
    end

    local player_selected = ESX.GetPlayerFromId(player_source)
    if (player_selected == nil) then
        return
    end

    xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveInventory, player_selected.source, {
        items = player_selected.getInventory(),
        weapons = player_selected.getLoadout()
    })

end)


Shared:RegisterCommand("giveitem", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    end

    local item_name, item_count = tostring(args[2]), tonumber(args[3])
    if (type(item_name) ~= "string" or type(item_count) ~= "number") then
        return
    end

    local item_selected = ESX.GetItem(item_name)

    if (item_selected == nil) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'item ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ n'existe pas."):format(item_name)))
    end

    if (not player_selected_data.canCarryItem(item_name, item_count)) then
        return (xPlayer ~= nil and xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) manque de place dans son inventaire pour pouvoir lui donner cela."):format(player_selected_data.source, player_selected_data.getName())))
    end

    player_selected_data.addInventoryItem(item_name, item_count)

    JG.Discord:SendMessage(
            "Admin:GiveItem",
            ("***%s*** vient de donner un item à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = player_selected_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected_data.getName(),
                    inline = true
                },

                {
                    name = "Item donné",
                    value = ("___%s___ (**%s**) ***x%s***"):format(item_selected.label, item_name, item_count),
                    inline = true
                }

            }
    );

    if (xPlayer ~= nil) then

        xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveInventory, player_selected_data.source, {
            items = player_selected_data.getInventory(),
            weapons = player_selected_data.getLoadout()
        })

        xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) vient de recevoir x~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s %s~s~ dans son inventaire."):format(player_selected_data.source, player_selected_data.getName(), item_count, item_selected.label))

    end

end, {help = "Permet de donner un item dans l'inventaire d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez donner l'item dans son inventaire"},
    {name = "item_name", help = "Nom de l'item que vous souhaitez donner"},
    {name = "item_count", help = "Quantité que vous souhaitez donner"}
}}, {
    permission = "player_manage_item"
})

Shared:RegisterCommand("removeitem", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    elseif (xPlayer ~= nil and xPlayer.source ~= player_selected_data.source and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), player_selected_data.getGroup())) then
        return
    end

    local item_name, item_count = tostring(args[2]), tonumber(args[3])
    if (type(item_name) ~= "string" or type(item_count) ~= "number") then
        return
    end

    local item_selected = ESX.GetItem(item_name)

    if (item_selected == nil) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'item ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ n'existe pas."):format(item_name)))
    elseif (item_selected ~= nil and not item_selected.canRemove) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'item ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ ne peux pas être supprimé."):format(item_name)))
    end

    local player_inventory_item = player_selected_data.getInventoryItem(item_name)
    if (player_inventory_item ~= nil and player_inventory_item.count > 0) then

        item_count = (((player_inventory_item.count >= item_count) and item_count) or player_inventory_item.count)
        player_selected_data.removeInventoryItem(item_name, item_count)

        JG.Discord:SendMessage(
                "Admin:RemoveItem",
                ("***%s*** vient de supprimer un item à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
                {

                    {
                        name = "Identifiant du STAFF",
                        value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                        inline = true
                    },
                    {
                        name = "ID session du STAFF",
                        value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                        inline = true
                    },
                    {
                        name = "Pseudo du STAFF",
                        value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                        inline = true
                    },

                    {
                        name = "Identifiant du Joueur",
                        value = player_selected_data.getIdentifier(),
                        inline = true
                    },
                    {
                        name = "ID session du Joueur",
                        value = player_selected_data.source,
                        inline = true
                    },
                    {
                        name = "Pseudo du Joueur",
                        value = player_selected_data.getName(),
                        inline = true
                    },

                    {
                        name = "Item supprimé",
                        value = ("___%s___ (**%s**) ***x%s***"):format(item_selected.label, item_name, item_count),
                        inline = true
                    }

                }
        );

        if (xPlayer ~= nil) then

            xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveInventory, player_selected_data.source, {
                items = player_selected_data.getInventory(),
                weapons = player_selected_data.getLoadout()
            })

            xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) vient de perdre x~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s %s~s~ de son inventaire."):format(player_selected_data.source, player_selected_data.getName(), item_count, item_selected.label))

        end

    else

        return (xPlayer ~= nil and xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) n'a pas cet item ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ dans son inventaire."):format(player_selected_data.source, player_selected_data.getName(), item_selected.label)))

    end

end, {help = "Permet de retirer un item de l'inventaire d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez retirer l'item de son inventaire"},
    {name = "item_name", help = "Nom de l'item que vous souhaitez retirer"},
    {name = "item_count", help = "Quantité que vous souhaitez retirer"}
}}, {
    permission = "player_manage_item"
})

Shared:RegisterCommand("clearitems", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    elseif (xPlayer ~= nil and xPlayer.source ~= player_selected_data.source and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), player_selected_data.getGroup())) then
        return
    end

    local player_selected_data_inventory = player_selected_data.getInventory(true)

    if (player_selected_data_inventory ~= nil and #player_selected_data_inventory > 0) then

        for i = 1, #player_selected_data_inventory do

            local player_selected_data_inventory_item = player_selected_data_inventory[i]

            if (player_selected_data_inventory_item ~= nil and player_selected_data_inventory_item.count > 0) then

                player_selected_data.removeInventoryItem(player_selected_data_inventory_item.name, player_selected_data_inventory_item.count)

            end

        end

        JG.Discord:SendMessage(
                "Admin:ClearItems",
                ("***%s*** vient de supprimer l'inventaire de ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
                {

                    {
                        name = "Identifiant du STAFF",
                        value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                        inline = true
                    },
                    {
                        name = "ID session du STAFF",
                        value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                        inline = true
                    },
                    {
                        name = "Pseudo du STAFF",
                        value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                        inline = true
                    },

                    {
                        name = "Identifiant du Joueur",
                        value = player_selected_data.getIdentifier(),
                        inline = true
                    },
                    {
                        name = "ID session du Joueur",
                        value = player_selected_data.source,
                        inline = true
                    },
                    {
                        name = "Pseudo du Joueur",
                        value = player_selected_data.getName(),
                        inline = true
                    },

                    {
                        name = "Inventaire supprimé",
                        value = json.encode((player_selected_data_inventory or {})),
                        inline = true
                    }

                }
        );

        if (xPlayer ~= nil) then

            xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveInventory, player_selected_data.source, {
                items = player_selected_data.getInventory(),
                weapons = player_selected_data.getLoadout()
            })


            xPlayer.showNotification(("L'inventaire du joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) a bien été vidé."):format(player_selected_data.source, player_selected_data.getName()))

        end

    else

        return (xPlayer ~= nil and xPlayer.showNotification(("L'inventaire du joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) n'a pas pu être identifié ou il est déjà vidé."):format(player_selected_data.source, player_selected_data.getName())))

    end

end, {help = "Permet de vider l'inventaire d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez vider son inventaire"}
}}, {
    permission = "player_manage_item"
})

Shared:RegisterCommand("giveweapon", function(xPlayer, args)

    local player_selected_id = tonumber(args[1]);
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    end

    local weapon_name, weapon_ammo = tostring(args[2]), tonumber(args[3])
    if (type(weapon_name) ~= "string" or type(weapon_ammo) ~= "number") then
        return
    end

    local weapon_selected = ESX.GetWeaponLabel(weapon_name)
    local player_allowed_danger = (ESX.IsAllowedForDanger(xPlayer) or xPlayer == nil);
    local is_penetrator = weapon_name:lower() == "weapon_penetrator";

    if (weapon_selected == nil) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ n'existe pas."):format(weapon_name)))
    elseif (not player_allowed_danger and is_penetrator) then
        player_selected_data.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ est obtenable seulement par vCore3."):format(weapon_selected));
        return (xPlayer ~= nil and xPlayer.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ est obtenable seulement par vCore3."):format(weapon_selected)));
    elseif (weapon_selected ~= nil and Shared:IsWeaponPermanent(weapon_name) == true and not player_allowed_danger) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ est permanente donc ne peux pas être donné."):format(weapon_selected)))
    end

    if (player_selected_data.hasWeapon(weapon_name)) then
        return (xPlayer ~= nil and xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) semble déjà avoir l'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(player_selected_data.source, player_selected_data.getName(), weapon_selected)))
    end

    player_selected_data.addWeapon(weapon_name, weapon_ammo)

    JG.Discord:SendMessage(
            "Admin:GiveWeapon",
            ("***%s*** vient de donner une arme à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = player_selected_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected_data.getName(),
                    inline = true
                },

                {
                    name = "Arme donnée",
                    value = ("___%s___ (**%s**) ***x%s***"):format(weapon_selected, weapon_name, weapon_ammo),
                    inline = true
                }

            }
    );

    if (xPlayer ~= nil) then

        xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveInventory, player_selected_data.source, {
            items = player_selected_data.getInventory(),
            weapons = player_selected_data.getLoadout()
        })

        xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) vient de recevoir l'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(player_selected_data.source, player_selected_data.getName(), weapon_selected))

    end

end, {help = "Permet de donner une arme dans l'inventaire d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez donner l'arme dans son inventaire"},
    {name = "weapon_name", help = "Nom de l'arme que vous souhaitez donner"},
    {name = "weapon_ammo", help = "Quantité de munitions que vous souhaitez donner"}
}}, {
    permission = "player_manage_item"
})

Shared:RegisterCommand("removeweapon", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    elseif (xPlayer ~= nil and xPlayer.source ~= player_selected_data.source and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), player_selected_data.getGroup())) then
        return
    end

    local weapon_name = tostring(args[2])
    if (type(weapon_name) ~= "string") then
        return
    end

    local weapon_selected = ESX.GetWeaponLabel(weapon_name)
    local player_allowed_danger = (ESX.IsAllowedForDanger(xPlayer) or xPlayer == nil)

    if (weapon_selected == nil) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ n'existe pas."):format(weapon_name)))
    elseif (weapon_selected ~= nil and Shared:IsWeaponPermanent(weapon_name) == true and not player_allowed_danger) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ est permanente donc ne peux pas être supprimé."):format(weapon_selected)))
    end

    if (not player_selected_data.hasWeapon(weapon_name)) then
        return (xPlayer ~= nil and xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) ne semble pas posséder l'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(player_selected_data.source, player_selected_data.getName(), weapon_selected)))
    end

    player_selected_data.removeWeapon(weapon_name)

    JG.Discord:SendMessage(
            "Admin:RemoveWeapon",
            ("***%s*** vient de supprimer une arme à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = player_selected_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected_data.getName(),
                    inline = true
                },

                {
                    name = "Arme supprimée",
                    value = ("___%s___ (**%s**)"):format(weapon_selected, weapon_name),
                    inline = true
                }

            }
    );

    if (xPlayer ~= nil) then

        xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveInventory, player_selected_data.source, {
            items = player_selected_data.getInventory(),
            weapons = player_selected_data.getLoadout()
        })

        xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) vient de perdre l'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(player_selected_data.source, player_selected_data.getName(), weapon_selected))

    end

end, {help = "Permet de supprimer une arme de l'inventaire d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez supprimer l'arme de son inventaire"},
    {name = "weapon_name", help = "Nom de l'arme que vous souhaitez supprimer"}
}}, {
    permission = "player_manage_item"
})

Shared:RegisterCommand("clearweapons", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    elseif (xPlayer ~= nil and xPlayer.source ~= player_selected_data.source and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), player_selected_data.getGroup())) then
        return
    end

    local player_selected_data_weapons = player_selected_data.getLoadout()

    if (player_selected_data_weapons ~= nil and #player_selected_data_weapons > 0) then

        for i = 1, #player_selected_data_weapons do

            local player_selected_data_inventory_weapon = player_selected_data_weapons[i]

            if (player_selected_data_inventory_weapon ~= nil and not Shared:IsWeaponPermanent(player_selected_data_inventory_weapon.name)) then

                player_selected_data.removeWeapon(player_selected_data_inventory_weapon.name)

            end

        end

        JG.Discord:SendMessage(
                "Admin:ClearWeapons",
                ("***%s*** vient de supprimer les armes à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
                {

                    {
                        name = "Identifiant du STAFF",
                        value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                        inline = true
                    },
                    {
                        name = "ID session du STAFF",
                        value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                        inline = true
                    },
                    {
                        name = "Pseudo du STAFF",
                        value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                        inline = true
                    },

                    {
                        name = "Identifiant du Joueur",
                        value = player_selected_data.getIdentifier(),
                        inline = true
                    },
                    {
                        name = "ID session du Joueur",
                        value = player_selected_data.source,
                        inline = true
                    },
                    {
                        name = "Pseudo du Joueur",
                        value = player_selected_data.getName(),
                        inline = true
                    },

                    {
                        name = "Armes supprimées",
                        value = json.encode((player_selected_data_weapons or {})),
                        inline = true
                    }

                }
        );

        if (xPlayer ~= nil) then

            xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveInventory, player_selected_data.source, {
                items = player_selected_data.getInventory(),
                weapons = player_selected_data.getLoadout()
            })

            xPlayer.showNotification(("Les armes du joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) ont bien été supprimées."):format(player_selected_data.source, player_selected_data.getName()))

        end

    else

        return (xPlayer ~= nil and xPlayer.showNotification(("Les armes du joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) n'ont pas pu être identifiées ou sont déjà supprimées."):format(player_selected_data.source, player_selected_data.getName())))

    end

end, {help = "Permet de vider les armes d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez retirer ses armes"}
}}, {
    permission = "player_manage_item"
})

Shared:RegisterCommand("giveammo", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    end

    local weapon_name, weapon_ammo = tostring(args[2]), tonumber(args[3])
    if (type(weapon_name) ~= "string" or type(weapon_ammo) ~= "number") then
        return
    end

    local weapon_selected = ESX.GetWeaponLabel(weapon_name)
    if (weapon_selected == nil) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ n'existe pas."):format(weapon_name)))
    end

    if (not player_selected_data.hasWeapon(weapon_name)) then
        return (xPlayer ~= nil and xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) ne semble pas posséder l'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(player_selected_data.source, player_selected_data.getName(), weapon_selected)))
    end

    player_selected_data.addWeaponAmmo(weapon_name, weapon_ammo)

    JG.Discord:SendMessage(
            "Admin:GiveWeaponAmmo",
            ("***%s*** vient de donner des munitions d'une arme à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = player_selected_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected_data.getName(),
                    inline = true
                },

                {
                    name = "Munitions données",
                    value = ("___%s___ (**%s**) | ***x%s***"):format(weapon_selected, weapon_name, weapon_ammo),
                    inline = true
                }

            }
    );

    return (xPlayer ~= nil and xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) vient de recevoir les munitions (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x%s~s~) de l'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(player_selected_data.source, player_selected_data.getName(), weapon_ammo, weapon_selected)))

end, {help = "Permet d'ajouter des munitions à une arme de l'inventaire d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez donner les munitions"},
    {name = "weapon_name", help = "Nom de l'arme que vous souhaitez pour donner les munitions"},
    {name = "weapon_ammo", help = "Nombre de munitions que vous souhaitez pour donner pour l'arme"}
}}, {
    permission = "player_manage_item"
})

Shared:RegisterCommand("giveweaponcomponent", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    end

    local weapon_name, weapon_component = tostring(args[2]), tostring(args[3])
    if (type(weapon_name) ~= "string" or type(weapon_component) ~= "string") then
        return
    end

    local weapon_selected = ESX.GetWeaponLabel(weapon_name)
    if (weapon_selected == nil) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ n'existe pas."):format(weapon_name)))
    end

    if (not player_selected_data.hasWeapon(weapon_name)) then
        return (xPlayer ~= nil and xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) ne semble pas posséder l'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(player_selected_data.source, player_selected_data.getName(), weapon_selected)))
    end

    local weapon_component_selected = ESX.GetWeaponComponent(weapon_name, weapon_component)
    if (weapon_component_selected == nil) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ ne contient pas ce composant (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(weapon_selected, weapon_component)))
    end

    if (player_selected_data.hasWeaponComponent(weapon_name, weapon_component)) then
        return (xPlayer ~= nil and xPlayer.showNotification(("L'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ contient déjà ce composant (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(weapon_selected, weapon_component_selected.label)))
    end

    player_selected_data.addWeaponComponent(weapon_name, weapon_component)

    JG.Discord:SendMessage(
            "Admin:GiveWeaponComponent",
            ("***%s*** vient de donner un composant d'une arme à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = player_selected_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected_data.getName(),
                    inline = true
                },

                {
                    name = "Composant donné",
                    value = ("___%s___ (**%s**) | %s"):format(weapon_selected, weapon_name, weapon_component_selected.label),
                    inline = true
                }

            }
    );

    return (xPlayer ~= nil and xPlayer.showNotification(("Le joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) vient de recevoir le composant (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) de l'arme ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(player_selected_data.source, player_selected_data.getName(), weapon_component_selected.label, weapon_selected)))

end, {help = "Permet d'ajouter un composant à une arme de l'inventaire d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez donner le composant"},
    {name = "weapon_name", help = "Nom de l'arme que vous souhaitez pour donner le composant"},
    {name = "weapon_component", help = "Nom du composant vous souhaitez pour l'ajouter sur l'arme"}
}}, {
    permission = "player_manage_item"
})

Shared.Events:OnNet(Enums.Administration.Server.Actions.Player.GetAccounts, function(xPlayer, player_source)

    if (xPlayer == nil) then
        return
    end

    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (not JG.AdminManager:StaffGetValue(xPlayer.source, "state")) then
        return
    end

    local player_selected = ESX.GetPlayerFromId(player_source)
    if (player_selected == nil) then
        return
    end

    xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveAccounts, player_selected.source, player_selected.getAccounts(true))

end)

Shared:RegisterCommand("giveaccountmoney", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    elseif (xPlayer ~= nil and xPlayer.source ~= player_selected_data.source and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), player_selected_data.getGroup())) then
        return
    end

    local account_name, account_value = tostring(args[2]), tonumber(args[3])
    if (type(account_name) ~= "string" or type(account_value) ~= "number") then
        return
    end

    local account_selected = player_selected_data.getAccount(account_name)
    if (account_selected == nil) then
        return (xPlayer ~= nil and xPlayer.showNotification("Ce type de compte n'existe pas."))
    end

    player_selected_data.showNotification(("Ajout d'argent dans votre compte financier ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ de %s~g~$~s~."):format(ESX.GetAccountLabel(account_selected.name), account_value))
    player_selected_data.addAccountMoney(account_name, account_value)

    JG.Discord:SendMessage(
            "Admin:GiveAccountMoney",
            ("***%s*** vient de donner de l'argent à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = player_selected_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected_data.getName(),
                    inline = true
                },

                {
                    name = "Compte financié",
                    value = ("%s (__%s__) | + **%s$**"):format(ESX.GetAccountLabel(account_selected.name), account_selected.name, account_value),
                    inline = true
                }

            }
    );

    if (xPlayer ~= nil) then

        xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveAccounts, player_selected_data.source, player_selected_data.getAccounts(true))
        xPlayer.showNotification(("Ajout d'argent dans le compte financier ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ de %s~g~$~s~ du joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(ESX.GetAccountLabel(account_selected.name), account_value, player_selected_data.source, player_selected_data.getName()))

    end

end, {help = "Permet de donner de l'argent dans un compte en particuler", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez donner de l'argent"},
    {name = "account_name", help = "Le nom du compte que vous sélectionnez pour l'argent"},
    {name = "account_value", help = "Le montant que vous souhaitez ajouter au compte"}
}}, {
    permission = "player_manage_money"
})

Shared:RegisterCommand("removeaccountmoney", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    elseif (xPlayer ~= nil and xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveAccounts, player_selected_data.source, player_selected_data.getAccounts(true)) and xPlayer.source ~= player_selected_data.source and not exports["vCore3"]:GroupIsHigher(xPlayer.getGroup(), player_selected_data.getGroup())) then
        return
    end

    local account_name, account_value = tostring(args[2]), tonumber(args[3])
    if (type(account_name) ~= "string" or type(account_value) ~= "number") then
        return
    end

    local account_selected = player_selected_data.getAccount(account_name)
    if (account_selected == nil) then
        return (xPlayer ~= nil and xPlayer.showNotification("Ce type de compte n'existe pas."))
    end

    account_value = (((account_selected.money >= account_value) and account_value) or account_selected.money)

    if (account_value <= 0) then
        return (xPlayer ~= nil and xPlayer.showNotification(("Ce compte (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~) est vide."):format(ESX.GetAccountLabel(account_selected.name))))
    end

    player_selected_data.showNotification(("Perte d'argent dans votre compte financier ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ de %s~g~$~s~."):format(ESX.GetAccountLabel(account_selected.name), account_value))
    player_selected_data.removeAccountMoney(account_name, account_value)

    JG.Discord:SendMessage(
            "Admin:RemoveAccountMoney",
            ("***%s*** vient de retirer de l'argent à ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = player_selected_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected_data.getName(),
                    inline = true
                },

                {
                    name = "Compte financié",
                    value = ("%s (__%s__) | - **%s$**"):format(ESX.GetAccountLabel(account_selected.name), account_selected.name, account_value),
                    inline = true
                }

            }
    );

    if (xPlayer ~= nil) then

        xPlayer.triggerEvent(Enums.Administration.Client.Actions.ReceiveAccounts, player_selected_data.source, player_selected_data.getAccounts(true))
        xPlayer.showNotification(("Perte d'argent dans le compte financier ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ de %s~g~$~s~ du joueur (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(ESX.GetAccountLabel(account_selected.name), account_value, player_selected_data.source, player_selected_data.getName()))

    end

end, {help = "Permet de retirer de l'argent dans un compte en particuler", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez retirer de l'argent"},
    {name = "account_name", help = "Le nom du compte que vous sélectionnez pour l'argent"},
    {name = "account_value", help = "Le montant que vous souhaitez retirer au compte"}
}}, {
    permission = "player_manage_money"
})

Shared:RegisterCommand("setjob", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    end

    local job_name, job_grade = tostring(args[2]), tostring(args[3])
    if (type(job_name) ~= "string" or type(job_grade) ~= "string") then
        return
    end

    if (not ESX.DoesJobExist(job_name, job_grade)) then
        return (xPlayer ~= nil and xPlayer.showNotification("Ce métier n'existe pas."))
    end

    local last_job = player_selected_data.getJob()
    player_selected_data.setJob(job_name, job_grade)

    JG.Discord:SendMessage(
            "Admin:SetJob",
            ("***%s*** vient de changer le métier de ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = player_selected_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected_data.getName(),
                    inline = true
                },

                {
                    name = "Nouveau métier",
                    value = ("%s (__%s__)"):format(job_name, job_grade),
                    inline = true
                },
                {
                    name = "Ancien métier",
                    value = ("%s (__%s__)"):format(last_job.name, last_job.grade),
                    inline = true
                }

            }
    );

    player_selected_data.showNotification(("Votre métier a bien été mis à jour (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(job_name, job_grade))

    return (xPlayer ~= nil and xPlayer.showNotification(("Le métier du joueur a bien été mis à jour (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(job_name, job_grade)))

end, {help = "Permet de change le métier d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez changer le métier"},
    {name = "job", help = "Le nom du métier que vous souhaitez donner au joueur"},
    {name = "grade_id", help = "Le grade du métier que vous souhaitez donner au joueur"}
}}, {
    permission = "player_setjob"
})

Shared:RegisterCommand("setjob2", function(xPlayer, args)

    local player_selected_id = tonumber(args[1])
    local player_selected_data = (xPlayer == nil or xPlayer.source ~= player_selected_id) and ESX.GetPlayerFromId(player_selected_id) or xPlayer

    if (player_selected_data == nil) then
        return
    end

    local job_name, job_grade = tostring(args[2]), tostring(args[3])
    if (type(job_name) ~= "string" or type(job_grade) ~= "string") then
        return
    end

    if (not ESX.DoesJobExist(job_name, job_grade)) then
        return (xPlayer ~= nil and xPlayer.showNotification("Ce second métier n'existe pas."))
    end

    local last_job = player_selected_data.getJob2()
    player_selected_data.setJob2(job_name, job_grade)

    JG.Discord:SendMessage(
            "Admin:SetJob2",
            ("***%s*** vient de changer le second métier de ***%s***."):format(((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"), player_selected_data.getName()),
            {

                {
                    name = "Identifiant du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getIdentifier()) or "CONSOLE:IDENTIFIER"),
                    inline = true
                },
                {
                    name = "ID session du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.source) or "CONSOLE:SOURCE"),
                    inline = true
                },
                {
                    name = "Pseudo du STAFF",
                    value = ((type(xPlayer) == "table" and xPlayer.getName()) or "CONSOLE"),
                    inline = true
                },

                {
                    name = "Identifiant du Joueur",
                    value = player_selected_data.getIdentifier(),
                    inline = true
                },
                {
                    name = "ID session du Joueur",
                    value = player_selected_data.source,
                    inline = true
                },
                {
                    name = "Pseudo du Joueur",
                    value = player_selected_data.getName(),
                    inline = true
                },

                {
                    name = "Nouveau second métier",
                    value = ("%s (__%s__)"):format(job_name, job_grade),
                    inline = true
                },
                {
                    name = "Ancien second métier",
                    value = ("%s (__%s__)"):format(last_job.name, last_job.grade),
                    inline = true
                }

            }
    );

    player_selected_data.showNotification(("Votre second métier a bien été mis à jour (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(job_name, job_grade))

    return (xPlayer ~= nil and xPlayer.showNotification(("Le second métier du joueur a bien été mis à jour (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ - ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~)."):format(job_name, job_grade)))

end, {help = "Permet de change le second métier d'un joueur", params = {
    {name = "player_id", help = "ID du joueur, celui que vous souhaitez changer le second métier"},
    {name = "job", help = "Le nom du second métier que vous souhaitez donner au joueur"},
    {name = "grade_id", help = "Le grade du second métier que vous souhaitez donner au joueur"}
}}, {
    permission = "player_setjob"
})

Shared:RegisterCommand("pos", function(xPlayer)

    if (not xPlayer) then
        return
    end

    local player_ped = GetPlayerPed(xPlayer.source)

    if (player_ped ~= 0 and DoesEntityExist(player_ped)) then

        local player_coords = GetEntityCoords(player_ped)
        local player_heading = GetEntityHeading(player_ped)
        local coords_text = ("Position: ^4%s^0, Heading: ^4%s^0"):format(("vector3(%s, %s, %s)"):format(player_coords.x, player_coords.y, player_coords.z), player_heading)

        Shared.Log:Success(coords_text)

    end

end, {help = "Permet d'avoir votre position sous un format (Vector3)"}, true)