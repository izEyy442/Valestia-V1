---
--- @author Kadir#6666
--- Create at [19/05/2023] 10:08:57
--- Current project [Valestia-V1]
--- File name [JobCenter]
---

local job_center = Config["Jobs"]["Center"];
local job_list = Config["Jobs"]["List"];

if (type(job_center) ~= "table" or type(job_list) ~= "table") then
    return
end

Shared.Events:OnNet(Enums.Jobs.Center.Events.Server.Join, function(xPlayer, job_id)

    if (not xPlayer) then
        return
    end

    if (type(job_id) ~= "number") then
        return xPlayer.kick(("Event (%s, job_id) erreur détectée."):format(Enums.Jobs.Center.Events.Server.Join))
    end

    local job_center_coords = job_center.pos
    local player_coords = xPlayer.getCoords()

    if (#(player_coords-job_center_coords) > 2.0) then
        return xPlayer.kick(("Event (%s, player_coords) erreur détectée."):format(Enums.Jobs.Center.Events.Server.Join))
    end

    local job_selected = JobCenter.getFromId(job_id)

    if (not job_selected) then
        return xPlayer.kick(("Event (%s, job_selected) erreur détectée."):format(Enums.Jobs.Center.Events.Server.Join))
    end

    local player_job = xPlayer.getJob()

    if (player_job.name ~= "unemployed") then

        return xPlayer.kick(("Event (%s, player_job) erreur détectée."):format(Enums.Jobs.Center.Events.Server.Join))

    end

    xPlayer.setJob(job_selected["data"].name, (job_selected["data"].grade or 0))
    xPlayer.showNotification(("Vous venez de rejoindre une entreprise : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format(job_selected["data"].label))

end)

Shared.Events:OnNet(Enums.Jobs.Center.Events.Server.Quit, function(xPlayer)

    if (not xPlayer) then
        return
    end

    local job_center_coords = job_center.pos
    local player_coords = xPlayer.getCoords()

    if (#(player_coords-job_center_coords) > 2.0) then
        return xPlayer.kick(("Event (%s, player_coords) erreur détectée."):format(Enums.Jobs.Center.Events.Server.Quit))
    end

    local player_job = xPlayer.getJob()

    if (player_job.name == "unemployed") then

        return xPlayer.kick(("Event (%s, player_job) erreur détectée."):format(Enums.Jobs.Center.Events.Server.Quit))

    end

    xPlayer.setJob("unemployed", 0)
    xPlayer.showNotification(("Vous venez de quitter votre entreprise : \"~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~\"."):format(player_job.label))

end)