---
--- @author Kadir#6666
--- Create at [20/04/2023] 16:30:08
--- Current project [Valestia-V1]
--- File name [report]
---

Shared:RegisterCommand("report", function(xPlayer, args)

    if (not xPlayer) then
        return
    end

    if (args[1] == nil) then
        return xPlayer.showNotification("Veuillez saisir au moins 1 mots dans votre motif.")
    end

    local reason = table.concat(args, " ")
    if (reason:len() > 50) then
        return xPlayer.showNotification("Veuillez saisir moins de mots dans votre motif.")
    end

    return JG.AdminManager:CreateReport(xPlayer, reason)

end, {help = "Permet d'envoyer un report au staff.", params = {
    {name = "raison", help = "Veuillez expliquer la raison de votre report en quelques mots."}
}});