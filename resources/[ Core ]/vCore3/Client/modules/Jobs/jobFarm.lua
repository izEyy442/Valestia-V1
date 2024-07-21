---
--- @author Kadir#6666
--- Create at [21/05/2023] 15:11:53
--- Current project [Valestia-V1]
--- File name [jobFarm]
---

local job_center = Config["Jobs"]["Center"];
local job_list = Config["Jobs"]["List"];

if (type(job_center) ~= "table" or type(job_list) ~= "table") then
    return
end

local farm_jobs = JobCenter.getAllFarm()
local farm_jobs_zone = Game.Zone("FarmJobs")
local farm_jobs_menu = RageUI.AddMenu("", "Menu de service")

local farm_job_current;

local function stopFarmJob(callback)

    if (type(farm_job_current) == "table") then

        if (farm_job_current.mission_blip and DoesBlipExist(farm_job_current.mission_blip)) then
            RemoveBlip(farm_job_current.mission_blip);
        end

        farm_job_current = nil;

    end

    if (callback) then callback(); end

end

Shared.Events:OnNet(Enums.Jobs.Farm.Events.Client.ServiceUpdate, function(serviceData)

    stopFarmJob(function()
        farm_job_current = (type(serviceData) == "table" and serviceData) or nil;
    end)

end)

for jobId, jobValues in pairs(farm_jobs) do

    local job_data = jobValues["data"]
    local farm_data = jobValues["farm"]

    if (type(farm_data) == "table") then

        Game.Blip(("FarmJobs:%s"):format(jobId),
            {
                coords = {
                    x = farm_data["interact"].coords["x"],
                    y = farm_data["interact"].coords["y"],
                    z = farm_data["interact"].coords["z"]
                },
                label = ("[Métier] %s"):format(job_data.label),
                sprite = ((type(farm_data["blip"]) == "table" and farm_data["blip"].sprite) or 457),
                color = ((type(farm_data["blip"]) == "table" and farm_data["blip"].color) or 38)
            }
        );

        CreateThread(function()

            local ped_model_loaded = Game.Streaming:RequestModel(farm_data["interact"].ped)

            if (ped_model_loaded) then

                local ped_on_create = CreatePed(4, farm_data["interact"].ped, farm_data["interact"].coords["x"], farm_data["interact"].coords["y"], farm_data["interact"].coords["z"], farm_data["interact"].coords["w"], false, true)
                SetEntityInvincible(ped_on_create, true)
                SetBlockingOfNonTemporaryEvents(ped_on_create, true)
                FreezeEntityPosition(ped_on_create, true)

            end

        end)

    end

end

farm_jobs_menu:IsVisible(function(Items)

    local farm_job_selected = farm_jobs_menu:GetData("job_id")
    local farm_job_selected_data = JobCenter.getFromId(farm_job_selected)

    if (type(farm_job_selected_data) == "table") then

        Items:Button(("%s son service"):format(type(farm_job_current) ~= "table" and "Prendre" or "Quitter"), nil, {
        }, true, {

            onSelected = function()

                Shared.Events:ToServer(Enums.Jobs.Farm.Events.Server.TakeService, farm_job_selected)

            end

        })

    end

end)

farm_jobs_zone:Start(function()

    farm_jobs_zone:SetTimer(1500);

    local player_job = Client.Player:GetJob();

    if (type(farm_job_current) == "table" and not farm_job_current["passed"]) then

        local farm_job_selected = JobCenter.getFromId(farm_job_current.id)

        if (type(farm_job_selected) == "table" and type(farm_job_current.mission) == "number") then

            local farm_job_selected_farm = farm_job_selected["farm"];

            local farm_job_data_missions = ((type(farm_job_selected_farm) == "table" and type(farm_job_selected_farm.points) == "table") and (farm_job_selected_farm.points["list"] or {}))
            local farm_job_data_missions_help = ((type(farm_job_selected_farm) == "table" and type(farm_job_selected_farm.points) == "table") and (farm_job_selected_farm.points["help"] or {}))
            local farm_job_data_missions_action = ((type(farm_job_selected_farm) == "table" and type(farm_job_selected_farm.points) == "table") and (farm_job_selected_farm.points["action"] or {}))
            local farm_job_data_missions_current = farm_job_data_missions[farm_job_current.mission]

            if (type(farm_job_data_missions_current) == "vector3") then

                local farm_job_data_missions_blip = farm_job_current.mission_blip

                if (not farm_job_data_missions_blip or not DoesBlipExist(farm_job_data_missions_blip)) then

                    ESX.ShowAdvancedNotification("Information", "Travail", "Une ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~nouvelle tâche~s~ vous a été confiée, ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~allez-y~s~ !")
                    SetNewWaypoint(farm_job_data_missions_current["x"], farm_job_data_missions_current["y"])

                    local blip_on_create = AddBlipForCoord(farm_job_data_missions_current)
                    SetBlipSprite(blip_on_create, (farm_job_data_missions_help["blip"] and farm_job_data_missions_help["blip"].sprite) or 11)
                    SetBlipColour(blip_on_create, (farm_job_data_missions_help["blip"] and farm_job_data_missions_help["blip"].color) or 0)
                    SetBlipScale(blip_on_create, 0.60)
                    SetBlipAlpha(blip_on_create, 200)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString((farm_job_data_missions_help["blip"] and farm_job_data_missions_help["blip"].name) or "Point de Travail")
                    EndTextCommandSetBlipName(blip_on_create)

                    farm_job_current.mission_blip = blip_on_create;

                end

                farm_jobs_zone:SetCoords(farm_job_data_missions_current)

                farm_jobs_zone:IsPlayerInRadius(10, function()

                    farm_jobs_zone:SetTimer(0);
                    farm_jobs_zone:Marker();

                    farm_jobs_zone:IsPlayerInRadius(3.0, function()

                        Game.Notification:ShowHelp(("Appuyez sur ~INPUT_PICKUP~ pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~."):format((farm_job_data_missions_help["text"] or "travailler")), true);
                        farm_jobs_zone:KeyPressed("E", function()

                            farm_job_current["passed"] = true;

                            local time_on_wait = (farm_job_data_missions_action.timer or 5000);

                            SetEntityCoords(Client.Player:GetPed(), farm_job_data_missions_current, false, false, false, false)
                            FreezeEntityPosition(Client.Player:GetPed(), true);

                            Game.Streaming:RequestAnimDict(farm_job_data_missions_action.animation[1], function()
                                TaskPlayAnim(Client.Player:GetPed(), farm_job_data_missions_action.animation[1], farm_job_data_missions_action.animation[2], 8.0, -8.0, time_on_wait, 2, 0, false, false, false)
                            end)

                            time_on_wait = (GetGameTimer() + time_on_wait)
                            while (GetGameTimer() < time_on_wait) do
                                Wait(500)
                            end

                            FreezeEntityPosition(Client.Player:GetPed(), false);
                            Shared.Events:ToServer(Enums.Jobs.Farm.Events.Server.FinishMission)

                        end);


                    end);

                end, false);

            end

            local farm_job_selected_data = farm_job_selected["data"];
            if ((player_job and farm_job_selected_data) and player_job.name ~= farm_job_selected_data.name) then
                stopFarmJob()
            end

        end

    end

    for jobId, jobValues in pairs(farm_jobs) do

        local job_data = jobValues["data"]
        local farm_data = jobValues["farm"]

        if ((type(job_data) == "table" and type(farm_data) == "table") and (job_data.name == player_job.name)) then

            farm_jobs_zone:SetCoords(vector3(farm_data["interact"].coords["x"], farm_data["interact"].coords["y"], (farm_data["interact"].coords["z"] + 1.8)));

            farm_jobs_zone:IsPlayerInRadius(3.0, function()

                farm_jobs_zone:SetTimer(0)

                farm_jobs_zone:Text(("[~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~s~] Parler"):format(job_center.label));
                farm_jobs_zone:KeyPressed("E", function()

                    if (not farm_jobs_menu:IsShowing()) then
                        farm_jobs_menu:SetData("job_id", jobId)
                        farm_jobs_menu:Toggle();
                    else
                        farm_jobs_menu:Close();
                    end

                end);

            end, false);

            farm_jobs_zone:RadiusEvents(3.0, nil, function()

                if (farm_jobs_menu:IsShowing()) then
                    farm_jobs_menu:Close();
                end

            end);

        end

    end

end)