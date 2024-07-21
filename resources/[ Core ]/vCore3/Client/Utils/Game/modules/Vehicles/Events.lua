--[[
----
----Created Date: 4:34 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Events]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

Shared.Events:OnNet(Enums.Vehicles.Events.RequestProperties, function(plate, networkId)
    Shared.Vehicle:GetByNetworkId(networkId, function(vehicle)
        Shared.Events:Protected(Enums.Vehicles.Events.ReceiveProperties, plate, vehicle and Game.Vehicle:GetProperties(vehicle) or {});
    end);
end);

Shared.Events:OnNet(Enums.Vehicles.Events.SetProperties, function(plate, networkId, properties)
    Shared.Vehicle:GetByNetworkId(networkId, function(vehicle)
        local props = properties;
        Game.Vehicle:RequestControl(vehicle, function()
            Game.Vehicle:SetProperties(vehicle, props);
            Shared.Events:Protected(Enums.Vehicles.Events.ReceiveProperties, plate, vehicle and Game.Vehicle:GetProperties(vehicle) or {});
        end);
    end);
end);