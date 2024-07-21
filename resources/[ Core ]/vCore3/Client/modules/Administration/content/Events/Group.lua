---
--- @author Kadir#6666
--- Create at [24/04/2023] 20:05:43
--- Current project [Valestia-V1]
--- File name [Group]
---

Shared.Events:OnNet(Enums.Administration.Client.GroupSetValue, function(...)

    return Client.Admin:UpdateGroup(...)

end);

Shared.Events:OnNet(Enums.Administration.Client.GroupAdd, function(...)

    return Client.Admin:CreateGroup(...)

end);

Shared.Events:OnNet(Enums.Administration.Client.GroupDelete, function(...)

    return Client.Admin:DeleteGroup(...)

end);