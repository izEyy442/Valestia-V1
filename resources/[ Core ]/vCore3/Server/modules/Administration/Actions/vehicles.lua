---
--- @author Kadir#6666
--- Create at [26/04/2023] 21:46:46
--- Current project [Valestia-V1]
--- File name [vehicles]
---

---@param xPlayer xPlayer
---@param name string
---@param args []
local function VehicleAction(xPlayer, name, args)

    if (not xPlayer) then
        return
    end

    if (name == "vehicle_spawn" or name == "vehicle_give") then

        local player_selected_id = tonumber(args[2])
        local player_selected_data = xPlayer.source ~= player_selected_id and ESX.GetPlayerFromId(player_selected_id) or xPlayer
        if (player_selected_data == nil) then
            return
        end

        local vehicle_model = tostring(args[1])
        if (vehicle_model == nil) then
            return
        end

        local vehicle_plate = JG.VehicleManager:GenerateUniquePlate()
        if (vehicle_plate == nil) then
            return
        end

        JG.VehicleManager:CreateVehicle(vehicle_model, player_selected_data.getCoords(), 0.0, vehicle_plate, function(vehicle_created, vehicle_created_properties)

            JG.KeyManager:AddKey(player_selected_data, VehicleKey, vehicle_plate, "vehicle", true)
            vehicle_created:SetDriver(player_selected_data)

            local vehicle_created_temp_type = GetVehicleType(vehicle_created:GetHandle())
            local vehicle_created_type = vehicle_created_temp_type == "automobile" and "car" or vehicle_created_temp_type == "bike" and "moto" or vehicle_created_temp_type == "heli" and "plane" or vehicle_created_temp_type

            if (name == "vehicle_give" and vehicle_created_properties ~= nil) then

                MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state, boutique, stored, type) VALUES (@owner, @plate, @vehicle, @state, @boutique, @stored, @type)', {
                    ['@owner']   = player_selected_data.getIdentifier(),
                    ['@plate']   = vehicle_plate,
                    ['@vehicle'] = json.encode(vehicle_created_properties),
                    ['@state']   = 0,
                    ['@boutique'] = 1,
                    ["@stored"] = 0,
                    ['@type'] = vehicle_created_type
                })

                JG.Discord:SendMessage(
                        "Admin:GiveVehicle",
                        ("***%s*** vient de donner un véhicule de façon permanente à ***%s***."):format(xPlayer.getName(), player_selected_data.getName()),
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
                                name = "Véhicule donné",
                                value = ("(*%s*) __%s__ [***%s***]"):format(vehicle_created_type, vehicle_model, vehicle_plate),
                                inline = true
                            }

                        }
                );

            else

                JG.Discord:SendMessage(
                        "Admin:Car",
                        ("***%s*** vient de donner un véhicule de façon temporaire à ***%s***."):format(xPlayer.getName(), player_selected_data.getName()),
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
                                name = "Véhicule donné",
                                value = ("(*%s*) __%s__ [***%s***]"):format(vehicle_created_type, vehicle_model, vehicle_plate),
                                inline = true
                            }

                        }
                );

            end

        end, player_selected_data);

    else

        local entity_network_id = tonumber(args[1])

        if (entity_network_id == nil or entity_network_id == 0) then
            return
        end

        local entity_selected = NetworkGetEntityFromNetworkId(entity_network_id)
        if (entity_selected == nil or entity_selected == 0 or not DoesEntityExist(entity_selected)) then
            return
        end

        if (name == "vehicle_delete") then

            local vehicle_plate = GetVehicleNumberPlateText(entity_selected)
            local vehicle_is_in_manager = JG.VehicleManager:GetVehicleByPlate(vehicle_plate) ~= nil

            if (vehicle_is_in_manager) then
                JG.VehicleManager:RemoveVehicle(vehicle_plate)

                if (not JG.VehicleManager:GetIfPlateIsTaken(vehicle_plate)) then
                    JG.KeyManager:RemoveKey("vehicle", vehicle_plate, true);
                end

                return
            else
                return DeleteEntity(entity_selected)
            end

        elseif (name == "vehicle_take_key") then

            local vehicle_plate = GetVehicleNumberPlateText(entity_selected)
            local vehicle_plate_converted = Shared.Vehicle:ConvertPlate(vehicle_plate);
            local vehicle_key = JG.KeyManager:GetKey("vehicle", vehicle_plate_converted);

            if (vehicle_key) then

                local vehicle_owner = vehicle_key:GetDefaultOwner()
                local vehicle_player = ESX.GetPlayerFromIdentifier(vehicle_owner)
                local vehicle_author = vehicle_player ~= nil and vehicle_player.getName() or vehicle_owner

                vehicle_key:SetOwner(xPlayer);
                Shared.Events:ToClient(xPlayer, Enums.VehicleKeys.Events.UpdateKeys);

                xPlayer.showNotification(("Vous avez pris de force la clé du véhicule [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~] de ~y~%s~s~."):format(vehicle_plate, vehicle_author))

            else

                xPlayer.showNotification("Ce véhicule n'a pas de clé.")

            end

        else

            return Shared.Events:Broadcast(Enums.Administration.Client.Actions.Entity, name, entity_network_id)

        end

    end

end

Shared:RegisterCommand("car", function(xPlayer, args)

    return VehicleAction(xPlayer, "vehicle_spawn", args)

end, {help = "Permet de faire apparaître un véhicule", params = {
    {name = "vehicle_model", help = "Model du véhicule que vous souhaitez faire apparaître"},
    {name = "player_target", help = "ID du joueur, celui qui va recevoir le véhicule"}
}}, {
    permission = "vehicle_spawn"
});

Shared:RegisterCommand("givecar", function(xPlayer, args)

    return VehicleAction(xPlayer, "vehicle_give", args)

end, {help = "Permet de se donner un véhicule de façon permanente", params = {
    {name = "vehicle_model", help = "Model du véhicule que vous souhaitez faire apparaître"},
    {name = "player_id", help = "ID du joueur, celui qui va recevoir le véhicule"}
}}, {
    permission = "vehicle_give"
});

Shared:RegisterCommand("dv", function(xPlayer, args)

    if (xPlayer == nil) then
        return
    end

    local radius_selected = args[1] ~= nil and tonumber(args[1]) or 1.5;
    if (radius_selected >= 50 and radius_selected <= 0) then
        return
    end

    local player_coords = xPlayer.getCoords()
    local vehicle_list = GetAllVehicles()
    local vehicle_number_deleted = 0

    for i = 1, #vehicle_list do

        local vehicle_selected = vehicle_list[i]

        if (vehicle_selected ~= 0 and DoesEntityExist(vehicle_selected) and (#(player_coords-GetEntityCoords(vehicle_selected)) <= radius_selected)) then

            VehicleAction(xPlayer, "vehicle_delete", {
                NetworkGetNetworkIdFromEntity(vehicle_selected)
            })

            vehicle_number_deleted = vehicle_number_deleted + 1

        end

    end

    if (vehicle_number_deleted > 0) then
        xPlayer.showNotification(("Vous avez supprimé ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s véhicules~s~."):format(vehicle_number_deleted))
    end

end, {help = "Permet de supprimer un véhicule", params = {
    {name = "radius", help = "Rayon dans lequel les véhicules vont être supprimés"}
}}, {
    permission = "vehicle_delete"
});

Shared.Events:OnNet(Enums.Administration.Server.Actions.Entity, function(xPlayer, action_name, ...)

    if (not xPlayer) then
        return
    end

    local player_group = JG.AdminManager:GetPlayerGroup(xPlayer)
    if (not JG.AdminManager:PlayerIsStaff(xPlayer)) then
        return
    elseif (action_name ~= "vehicle_spawn" and not JG.AdminManager:GroupHasPermission(player_group, action_name) or JG.AdminManager:StaffGetValue(xPlayer.source, "state") ~= true) then
        return
    end

    return VehicleAction(xPlayer, action_name, { ... })

end);