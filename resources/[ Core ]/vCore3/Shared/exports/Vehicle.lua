--
--Created Date: 23:44 12/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Vehicle]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@param networkId number
---@param callback fun(vehicleHandle: number)
exports("GetByNetworkId", function(networkId, callback)
    Shared.Vehicle:GetByNetworkId(networkId, callback);
end);