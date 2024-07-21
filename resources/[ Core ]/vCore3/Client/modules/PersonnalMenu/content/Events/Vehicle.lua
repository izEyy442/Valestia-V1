--[[
----
----Created Date: 6:27 Thursday December 22nd 2022
----Author: vCore3
----Made with ❤
----
----File: [Vehicle]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local personnalMenu = Shared.Storage:Get("personnal_menu");
local personnalMenuData = Shared.Storage:Get("personnal_menu_data");

---@return string
personnalMenuData:Set("ToStringEngine", function()

    if (GetIsVehicleEngineRunning(Client.Player:GetVehicle())) then

        return Shared.Lang:Translate("personnal_menu_vehicle_engine_on");

    else

        return Shared.Lang:Translate("personnal_menu_vehicle_engine_off");

    end

end);

Game.Vehicle:PlayerEntering(function()

    if (Client.Player:IsInVehicle(-1)) then

        personnalMenuData:Set("isInVehicle", true);

    else

        personnalMenuData:Set("isInVehicle", false);

    end

end);

Game.Vehicle:PlayerLeft(function()

    ---@type UIMenu
    local vehicleMenu = personnalMenu:Get("vehicle_menu");

    personnalMenuData:Set("isInVehicle", false);

    if (vehicleMenu:IsShowing()) then

        RageUI.GoBack();

    end

end);

Game.Vehicle:PlayerSwitchSeat(function()

    if (Client.Player:IsInVehicle(-1)) then

        personnalMenuData:Set("isInVehicle", true);

    else

        personnalMenuData:Set("isInVehicle", false);

    end

end);