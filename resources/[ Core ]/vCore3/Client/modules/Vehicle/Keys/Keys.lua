--[[
----
----Created Date: 8:54 Friday October 14th 2022
----Author: vCore3
----Made with ❤
----
----File: [Keys]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@param vehicle number
---@return number
local function getDoorsStatus(vehicle)
    return GetVehicleDoorLockStatus(vehicle);
end

---@return boolean
local function playerIsInVehicle()
    if (IsPedInAnyVehicle(Client.Player:GetPed())) then
        return true;
    end
    return false;
end

---@return number, boolean
local function getVehicleAndPlayer()
    local isInVehicle = false;
    local vehicle;
    local distance;
    if (playerIsInVehicle()) then

        vehicle = GetVehiclePedIsIn(Client.Player:GetPed());
        isInVehicle = true;

    else

        vehicle, distance = Game.Vehicle:GetClosest(Client.Player:GetCoords());;

        if (distance ~= -1 and distance < 5) then
            isInVehicle = true;
        else
            vehicle = nil;
        end

    end

    return vehicle, isInVehicle;
end

local function keyAnimation(vehicle)
    local plyPed = Client.Player:GetPed();

    Game.Streaming:RequestAnimDict("anim@mp_player_intmenu@key_fob@", function()
        Game.Object:Spawn(GetHashKey("p_car_keys_01"), vector3(0.0, 0.0, 0.0), function(object)
            SetEntityCollision(object, false, false);
            AttachEntityToEntity(object, plyPed, GetPedBoneIndex(plyPed, 57005), 0.09, 0.03, -0.02, -76.0, 13.0, 28.0, false, true, true, true, 0, true);

            SetCurrentPedWeapon(plyPed, GetHashKey("WEAPON_UNARMED"), true);
            ClearPedTasks(plyPed);
            TaskTurnPedToFaceEntity(plyPed, vehicle, 500);

            TaskPlayAnim(plyPed, "anim@mp_player_intmenu@key_fob@", "fob_click", 3.0, 3.0, 1000, 16);
            RemoveAnimDict("anim@mp_player_intmenu@key_fob@");
            PlaySoundFromEntity(-1, "Remote_Control_Fob", vehicle, "PI_Menu_Sounds", true, 0);
            Wait(1250);

            DetachEntity(object, false, false);
            DeleteObject(object);
        end);
    end);
end

local function changeLockStatus(vehicle)

    local locked = getDoorsStatus(vehicle);

    if (locked == 1 or locked == 0) then
        SetVehicleDoorsLocked(vehicle, 2)

        Shared.Events:ToServer(Enums.VehicleKeys.Events.LockVehicle, GetVehicleNumberPlateText(vehicle));

        PlayVehicleDoorCloseSound(vehicle, 1);
        ESX.ShowNotification("Vous avez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~verrouiller~s~ votre véhicule");
    elseif (locked == 2) then
        SetVehicleDoorsLocked(vehicle, 1)
        
        Shared.Events:ToServer(Enums.VehicleKeys.Events.UnlockVehicle, GetVehicleNumberPlateText(vehicle));

        PlayVehicleDoorOpenSound(vehicle, 0);
        ESX.ShowNotification("Vous avez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~déverrouiller~s~ votre véhicule");
    end
end

Shared.Events:OnNet(Enums.VehicleKeys.Events.GetPlayerKey, function(hasKey)
    if (hasKey) then
        local vehicle, inveh = getVehicleAndPlayer();

        if (vehicle) then
            if (not inveh) then
                keyAnimation(vehicle);
            end
            changeLockStatus(vehicle);
            keyAnimation(vehicle);
        end
    else
        Game.Notification:ShowAdvanced(
            Config["ServerName"] or "vCore3 Script",
            Shared.Lang:Translate("vehicle_key_notification_header"),
            Shared.Lang:Translate("key_vehicle_no_key"),
            Config["AdvancedNotification"]["VehicleKeys"]["TextureName"],
            Config["AdvancedNotification"]["VehicleKeys"]["IconType"],
            Config["AdvancedNotification"]["VehicleKeys"]["flash"],
            Config["AdvancedNotification"]["VehicleKeys"]["SaveToBrief"],
            Config["AdvancedNotification"]["VehicleKeys"]["HudColorIndex"]
        );
    end
end)

Shared.Events:OnNet(Enums.VehicleKeys.Events.ReceiveAllPlayerKeys, function(keys)
    Client.Player:SetValue("VehicleKeys", keys);
end);

Shared:RegisterKeyMapping("vCore3:Keys:Use", { label = "key_open_vehicle" }, "U", function()
    local vehicle = getVehicleAndPlayer();

    if (vehicle) then

        Shared.Events:Protected(Enums.VehicleKeys.Events.RequestPlayerKey, GetVehicleNumberPlateText(vehicle));

    else

        Game.Notification:ShowSimple(Shared.Lang:Translate("no_vehicle_found"));

    end

end);