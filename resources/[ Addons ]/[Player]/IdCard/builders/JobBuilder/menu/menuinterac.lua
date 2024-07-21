local ESX = nil
local Blips                   = {}
local JobBlips                = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('jobbuilder:restarted', function(player)
    ESX.PlayerData = player
end);

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end);

local JobBuilder = {
    ActiveF6 = {},
};

function MenuMetie(metier)
    local MenuMetier = RageUIJob.CreateMenu("", JobBuilder.ActiveF6.Label)
    local getpoint = RageUIJob.CreateSubMenu(MenuMetier, "", JobBuilder.ActiveF6.Label)

        RageUIJob.Visible(MenuMetier, not RageUIJob.Visible(MenuMetier))
            while MenuMetier do
                Citizen.Wait(0)
                    RageUIJob.IsVisible(MenuMetier, true, true, true, function()

                    RageUIJob.Separator("↓ GPS ↓")

                    RageUIJob.ButtonWithStyle("Mes zones", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    end, getpoint)



                    end, function()
                    end)

                    RageUIJob.IsVisible(getpoint, true, true, true, function()

                    RageUIJob.ButtonWithStyle("Coordonnées de récolte", "Vous met le point GPS", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ESX.TriggerServerCallback('JobBuilder:getAllJobsForF6', function(result)
                                for k,v in pairs(result) do
                                    local position1 = vector3(json.decode(v.PosRecolte).x, json.decode(v.PosRecolte).y, json.decode(v.PosRecolte).z)
                                    SetNewWaypoint(position1.x, position1.y);
                                end
                            end)
                        end
                    end)

                    RageUIJob.ButtonWithStyle("Coordonnées de traitement", "Vous met le point GPS", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ESX.TriggerServerCallback('JobBuilder:getAllJobsForF6', function(result)
                                for k,v in pairs(result) do
                                    local position2 = vector3(json.decode(v.PosTraitement).x, json.decode(v.PosTraitement).y, json.decode(v.PosTraitement).z)
                                    SetNewWaypoint(position2.x, position2.y);
                                end
                            end)
                        end
                    end)

                    RageUIJob.ButtonWithStyle("Coordonnées de vente", "Vous met le point GPS", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ESX.TriggerServerCallback('JobBuilder:getAllJobsForF6', function(result)
                                for k,v in pairs(result) do
                                    local position3 = vector3(json.decode(v.PosVente).x, json.decode(v.PosVente).y, json.decode(v.PosVente).z)
                                    SetNewWaypoint(position3.x, position3.y);
                                end
                            end)
                        end
                    end)

                    end, function()
                    end)

            if not RageUIJob.Visible(MenuMetier) and not RageUIJob.Visible(getpoint) then
            MenuMetier = RMenu:DeleteType("Menu Fouille", true)
        end
    end
end

Keys.Register('F6', 'Job', 'Ouvrir le menu de votre Entreprise Perso', function()

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        for k,v in pairs(result) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name then
                JobBuilder.ActiveF6 = v
                MenuMetie(v)
            end
        end
    end)

end)

