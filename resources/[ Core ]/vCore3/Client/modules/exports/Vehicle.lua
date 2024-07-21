---
--- @author Kadir#6666
--- Create at [08/05/2023] 14:57:49
--- Current project [Valestia-V1]
--- File name [Vehicle]
---

exports("GetFuel", function(entity)
    return Shared.Storage:Get("FuelSys"):Get("GetFuel")(entity)
end)

exports("SetFuel", function(entity, fuel)
    return Shared.Storage:Get("FuelSys"):Get("SetFuel")(entity, fuel)
end)