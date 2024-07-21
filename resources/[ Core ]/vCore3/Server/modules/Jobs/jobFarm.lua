---
--- @author Kadir#6666
--- Create at [22/05/2023] 19:14:19
--- Current project [Valestia-V1]
--- File name [jobFarm]
---

local job_center = Config["Jobs"]["Center"];
local job_list = Config["Jobs"]["List"];

if (type(job_center) ~= "table" or type(job_list) ~= "table") then
    return
end

local FarmJob = {}
FarmJob["PlayersIn"] = {}

---@param player_id number
function FarmJob.playerIsIn(player_id)

    local player_selected = ESX.GetPlayerFromId(player_id)

    if (FarmJob["PlayersIn"][player_id] and not player_selected) then
        FarmJob["PlayersIn"][player_id] = nil;
    end

    return FarmJob["PlayersIn"][player_id] or false

end

function FarmJob.generateMission(job_id)

    if (type(job_id) ~= "number") then
        return;
    end

    local job_selected = JobCenter.getFromId(job_id)
    local job_selected_farm = (type(job_selected) == "table" and job_selected["farm"]);

    if (type(job_selected_farm) ~= "table") then
        return;
    end

    local point_index = math.random(1, #job_selected_farm["points"].list)
    return point_index;

end

Shared.Events:OnNet(Enums.Jobs.Farm.Events.Server.TakeService, function(xPlayer, job_id)

    if (not xPlayer) then
        return
    end

    if (type(job_id) ~= "number") then
        return --[[TODO : CREATE KICK OF PLAYER]];
    end

    local job_selected = JobCenter.getFromId(job_id)

    if (not job_selected) then
        return --[[TODO : CREATE KICK OF PLAYER]];
    end

    local player_coords = xPlayer.getCoords();
    local player_job = xPlayer.getJob();
    local player_job_service = FarmJob.playerIsIn(xPlayer.source);

    local job_selected_data = job_selected["data"];
    local job_selected_farm = job_selected["farm"];
    local job_selected_farm_coords = vector3(job_selected_farm["interact"].coords["x"], job_selected_farm["interact"].coords["y"], job_selected_farm["interact"].coords["z"])

    if (type(job_selected_farm) ~= "table" or ((job_selected_data and player_job) and player_job.name ~= job_selected_data.name)) then
        return --[[TODO : CREATE KICK OF PLAYER]];
    elseif (#(player_coords-job_selected_farm_coords) > 3.0) then
        return --[[TODO : CREATE KICK OF PLAYER]];
    elseif (type(player_job_service) == "table" and player_job_service.id ~= job_id) then
        player_job_service = nil;
    end

    if (type(player_job_service) == "table" and player_job_service.id == job_id) then

        FarmJob["PlayersIn"][xPlayer.source] = nil;
        xPlayer.showNotification("Vous venez de ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~finir votre service~s~.")

    else

        FarmJob["PlayersIn"][xPlayer.source] = {
            id = job_id,
            mission = FarmJob.generateMission(job_id)
        };
        xPlayer.showNotification("Vous êtes maintenant ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~en service~s~.")

    end


    xPlayer.triggerEvent(Enums.Jobs.Farm.Events.Client.ServiceUpdate, FarmJob["PlayersIn"][xPlayer.source])

end)

Shared.Events:OnNet(Enums.Jobs.Farm.Events.Server.FinishMission, function(xPlayer)

    if (not xPlayer) then
        return
    end

    local player_coords = xPlayer.getCoords();
    local player_job = xPlayer.getJob();
    local player_job_service = FarmJob.playerIsIn(xPlayer.source);

    if (type(player_job_service) ~= "table") then
        return --[[TODO : CREATE KICK OF PLAYER]];
    end

    local job_selected = JobCenter.getFromId(player_job_service.id)

    if (not job_selected) then
        return --[[TODO : CREATE KICK OF PLAYER]];
    end

    local job_selected_data = job_selected["data"];
    local job_selected_farm = job_selected["farm"];
    local job_selected_farm_mission = (type(job_selected_farm.points) == "table" and type(job_selected_farm.points["list"]) == "table") and job_selected_farm.points["list"][player_job_service.mission];
    local job_selected_farm_pay = (type(job_selected_farm["pay"]) == "table" and job_selected_farm["pay"]) or {};

    if (type(job_selected_farm) ~= "table" or ((job_selected_data and player_job) and player_job.name ~= job_selected_data.name)) then
        return --[[TODO : CREATE KICK OF PLAYER]];
    elseif (type(job_selected_farm_mission) ~= "vector3") then
        return --[[TODO : CREATE KICK OF PLAYER]];
    elseif (type(job_selected_farm_mission) == "vector3" and (#(player_coords-job_selected_farm_mission) > 3.0)) then
        return --[[TODO : CREATE KICK OF PLAYER]];
    end

    local job_selected_farm_money = math.random(job_selected_farm_pay.min or 750, job_selected_farm_pay.max or 1850)

    if (type(job_selected_farm_money) == "number") then

        local player_account = xPlayer.getAccount("cash")

        if (type(player_account) == "table" and type(player_account.money) == "number") then

            xPlayer.addAccountMoney("cash", job_selected_farm_money)
            xPlayer.showAdvancedNotification("Information", "Travail", ("Vous avez reçu %s~g~$~s~."):format(ESX.Math.GroupDigits(job_selected_farm_money)))

            local mission_on_generate = FarmJob.generateMission(player_job_service.id);

            while (mission_on_generate == FarmJob["PlayersIn"][xPlayer.source].mission) do
                mission_on_generate = FarmJob.generateMission(player_job_service.id);
                Wait(500)
            end

            FarmJob["PlayersIn"][xPlayer.source] = {
                id = player_job_service.id,
                mission = mission_on_generate
            };
            xPlayer.triggerEvent(Enums.Jobs.Farm.Events.Client.ServiceUpdate, FarmJob["PlayersIn"][xPlayer.source])

        end

    end

end)