--[[
----
----Created Date: 12:48 Sunday April 9th 2023
----Author: vCore3
----Made with ❤
----
----File: [carkill]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local _PlyPed = PlayerPedId;
local GamePool = GetGamePool;
local _GetPedInSeat = GetPedInVehicleSeat;
local _VehSeatFree = IsVehicleSeatFree;
local _IsPedAPlayer = IsPedAPlayer;
local _SetNoColEntity = SetEntityNoCollisionEntity;
local _Wait = Wait;

--CreateThread(function()
--
--    while true do
--        
--        local ped = _PlyPed();
--        local vehicles = GamePool('CVehicle');
--
--        for i = 1, #vehicles do
--
--            local isSeatFree = _VehSeatFree(vehicles[i], -1);
--
--            if (not isSeatFree) then
--
--                local vehPed = _GetPedInSeat(vehicles[i], -1);
--                local isAPlayer = _IsPedAPlayer(vehPed);
--
--                if (isAPlayer) then
--
--                    _SetNoColEntity(vehicles[i], ped, true);
--                    _SetNoColEntity(ped, vehicles[i], true);
--
--                end
--
--            end
--
--        end
--
--        _Wait(0);
--
--    end
--
--end);