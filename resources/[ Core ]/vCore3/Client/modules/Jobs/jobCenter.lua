---
--- @author Kadir#6666
--- Create at [19/05/2023] 10:19:09
--- Current project [Valestia-V1]
--- File name [jobCenter]
---

local job_center = Config["Jobs"]["Center"];
local job_list = Config["Jobs"]["List"];

if (type(job_center) ~= "table" or type(job_list) ~= "table") then
    return
end

CreateThread(function()

    Game.Blip("jobCenter",
        {
            coords = { x = job_center.pos["x"], y = job_center.pos["y"], z = job_center.pos["z"] },
            label = ("[Public] %s"):format(job_center.label),
            sprite = 590,
            color = 63
        }
    );

    local job_center_menu = RageUI.AddMenu("", job_center.label);

    job_center_menu:IsVisible(function(Items)

        local player_job = Client.Player:GetJob()

        if (player_job) then

            for i = 1, #job_list do

                local selected_job = job_list[i]

                if (type(selected_job) == "table" and (selected_job.data["free_access"] == true) and (selected_job.data["name"] ~= player_job.name)) then

                    Items:Button(selected_job.data["label"], (player_job.name ~= "unemployed" and "Vous devez : \"~y~démissionner de votre emploi actuel~s~\"."), {
                    }, (player_job.name == "unemployed"), {

                        onSelected = function()

                            return Shared.Events:ToServer(Enums.Jobs.Center.Events.Server.Join, tonumber(i))

                        end;

                    })

                end

            end

            Items:Button("Démissionner", (player_job.name ~= "unemployed" and "Attention : \"~y~Aucun retour possible si vous cliquez.~s~\""), {
            }, player_job.name ~= "unemployed", {

                onSelected = function()

                    return Shared.Events:ToServer(Enums.Jobs.Center.Events.Server.Quit)

                end;

            });

        end

    end)

    local job_center_zone = Game.Zone("JobCenter");

    job_center_zone:Start(function()

        job_center_zone:SetTimer(1000);

        if (job_center and type(job_center.pos) == "vector3") then

            job_center_zone:SetCoords(job_center.pos);

            job_center_zone:IsPlayerInRadius(50, function()

                job_center_zone:SetTimer(0);
                job_center_zone:Marker(nil, nil, 0.75);

                job_center_zone:IsPlayerInRadius(2, function()

                    job_center_zone:Text(("[E] ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~"):format(job_center.label));
                    job_center_zone:KeyPressed("E", function()

                        if (not job_center_menu:IsShowing()) then
                            job_center_menu:Toggle();
                        else
                            job_center_menu:Close();
                        end

                    end);

                end);

            end);

            job_center_zone:RadiusEvents(2, nil, function()

                if (job_center_menu:IsShowing()) then
                    job_center_menu:Close();
                end

            end);

        end

    end)

end)