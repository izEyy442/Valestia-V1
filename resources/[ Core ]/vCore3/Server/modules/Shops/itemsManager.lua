---
--- @author Kadir#6666
--- Create at [12/05/2023] 15:12:02
--- Current project [Valestia-V1]
--- File name [itemsManager]
---

ESX.RegisterUsableItem("clip", function(player_id)

    local player_selected = ESX.GetPlayerFromId(player_id)

    if (not player_selected) then
        return
    end

    local player_selected_ped = GetPlayerPed(player_id)

    if (player_selected_ped == 0 or not DoesEntityExist(player_selected_ped)) then
        return
    end

    local player_selected_current_weapon = GetSelectedPedWeapon(player_selected_ped)
    local _, weapon_selected = ESX.GetWeapon(player_selected_current_weapon)

    if (type(weapon_selected) ~= "table" or type(weapon_selected.ammo) ~= "table") then
        return
    end

    if (not player_selected.hasWeapon(weapon_selected.name)) then
        return
    end

    local ammo_added = player_selected.addWeaponAmmo(weapon_selected.name, 50);

    if (not ammo_added) then
        return
    end

    player_selected.removeInventoryItem("clip", 1)

end)