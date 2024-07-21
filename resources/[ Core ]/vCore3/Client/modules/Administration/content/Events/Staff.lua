---
--- @author Kadir#6666
--- Create at [22/04/2023] 14:09:47
--- Current project [Valestia-V1]
--- File name [Staff]
---

Shared.Events:OnNet(Enums.Administration.Client.Init, function(data)

    if (Client.Admin == nil and data ~= nil and type(data) == "table") then

        Client:LoadAdminListener(function()

            Client.Admin["staff"] = data["staff"] or {};
            Client.Admin["reports"] = data["reports"] or {};
            Client.Admin["group"] = data["group"] or {};

            while (Client.Admin.Utils == nil) do
                Wait(500)
            end

            Client.Admin.Utils:SetItems((data["items"] or {}))

        end)

    end

end);

Shared.Events:OnNet(Enums.Administration.Client.StaffSetValue, function(playerId, key, value)

    if (key == nil) then
        return
    end

    while (Client.Admin == nil) do
        Wait(500)
    end

    return Client.Admin:StaffSetValue(playerId, key, value)

end);

Shared.Events:OnNet(Enums.Administration.Client.StaffAdd, function(playerData)

    if (playerData == nil or type(playerData) ~= "table") then
        return
    end

    while (Client.Admin == nil) do
        Wait(500)
    end

    return Client.Admin:AddStaff(playerData)

end);

Shared.Events:OnNet(Enums.Administration.Client.StaffRemove, function(playerId)

    if (playerId == nil) then
        return
    end

    while (Client.Admin == nil) do
        Wait(500)
    end

    return Client.Admin:RemoveStaff(playerId)

end);