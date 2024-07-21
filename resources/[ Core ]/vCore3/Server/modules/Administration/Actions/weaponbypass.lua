---
--- @author Kadir#6666
--- Create at [02/05/2023] 21:40:31
--- Current project [Valestia-V1]
--- File name [weaponbypass]
---

-- vCore3:Valestia:weapon_bypass

---
--- @author Kadir#6666
--- Create at [26/04/2023] 00:05:49
--- Current project [Valestia-V1]
--- File name [setPed]
---

Shared:RegisterCommand("weaponbypass", function(xPlayer, args)

    if (xPlayer == nil) then
        return
    end

    xPlayer.triggerEvent("vCore3:Valestia:weapon_bypass")

end, {
    help = "Permets de ne plus avoir l'animation."
}, {
    permission = "weapon_bypass"
});