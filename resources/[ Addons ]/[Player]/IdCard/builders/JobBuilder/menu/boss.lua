local ESX = nil
local societyJobsmoney = nil
local jobsData = {};

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

RegisterNetEvent('jobbuilder:restarted', function(player)

    ESX.PlayerData = player

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end);

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

    ESX.PlayerData.job = job

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

local function JobBuilderKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

local JobsEmployeList = {}
local JobBuilder = {
    Boss = {}
};

function MenuBoss(LabelJob)
  local MenuBoss = RageUIJob.CreateMenu("", LabelJob)
  local MenuGestEmployeJobs = RageUIJob.CreateSubMenu(MenuBoss, "", LabelJob)
  local MenuGestEmployeJobs2 = RageUIJob.CreateSubMenu(MenuGestEmployeJobs, "", LabelJob)
    RageUIJob.Visible(MenuBoss, not RageUIJob.Visible(MenuBoss))
            while MenuBoss do
                Citizen.Wait(0)
                    RageUIJob.IsVisible(MenuBoss, true, true, true, function()

                    if societyJobsmoney ~= nil then
                        RageUIJob.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyJobsmoney}, true, function()
                        end)
                    end

                    RageUIJob.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local Cbmoney = JobBuilderKeyboardInput("Combien ?", '' , 15)
                            Cbmoney = tonumber(Cbmoney)
                            if Cbmoney == nil then
                                RageUIJob.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('JobBuilder:withdrawMoney', JobBuilder.Boss.SocietyName, Cbmoney)
                                RefreshJobsMoney()
                            end
                        end
                    end)

                    RageUIJob.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local Cbmoneyy = JobBuilderKeyboardInput("Montant", "", 10)
                            Cbmoneyy = tonumber(Cbmoneyy)
                            if Cbmoneyy == nil then
                                RageUIJob.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('JobBuilder:depositMoney', JobBuilder.Boss.SocietyName, Cbmoneyy)
                                RefreshJobsMoney()
                            end
                        end
                    end)


                    RageUIJob.ButtonWithStyle("Gestion employés", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                            local GangName = JobBuilder.Boss.Name
                            loadEmployeJobs(GangName)
                        end
                    end, MenuGestEmployeJobs)

            end, function()
            end)

            RageUIJob.IsVisible(MenuGestEmployeJobs, true, true, true, function()

                if #JobsEmployeList == 0 then
                    RageUIJob.Separator("")
                    RageUIJob.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Aucun Employé")
                    RageUIJob.Separator("")
                end

                for k,v in pairs(JobsEmployeList) do
                    RageUIJob.ButtonWithStyle(v.Name, false, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            Ply = v
                        end
                    end, MenuGestEmployeJobs2)
                end

            end, function()
            end)

            RageUIJob.IsVisible(MenuGestEmployeJobs2, true, true, true, function()

                RageUIJob.ButtonWithStyle("Virer ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Ply.Name,nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('JobBuilder:Bossvirer', Ply.InfoMec)
                        RageUIJob.CloseAll()
                    end
                end)

                RageUIJob.ButtonWithStyle("Promouvoir ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Ply.Name,nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('JobBuilder:Bosspromouvoir', Ply.InfoMec)
                        RageUIJob.CloseAll()
                    end
                end)

                RageUIJob.ButtonWithStyle("Destituer ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..Ply.Name,nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('JobBuilder:Bossdestituer', Ply.InfoMec)
                        RageUIJob.CloseAll()
                    end
                end)

            end, function()
            end)

            if not RageUIJob.Visible(MenuBoss) and not RageUIJob.Visible(MenuGestEmployeJobs) and not RageUIJob.Visible(MenuGestEmployeJobs2) then
            MenuBoss = RMenu:DeleteType("MenuBoss", true)
        end
    end
end

function loadEmployeJobs(jobName)
    ESX.TriggerServerCallback('JobBuilder:GetJobsEmploye', function(Employe)
        JobsEmployeList = Employe
    end, jobName)
end

function RefreshJobsMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('JobBuilder:getSocietyMoney', function(money)
            UpdateSocietyJobsMoney(money)
        end, "society_"..ESX.PlayerData.job.name)
    end
end

function UpdateSocietyJobsMoney(money)
    societyJobsmoney = ESX.Math.GroupDigits(money)
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for k,v in pairs(jobsData) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name and ESX.PlayerData.job.grade_name == 'boss' then
                local plyPos = GetEntityCoords(PlayerPedId())
                local Boss = vector3(json.decode(v.PosBoss).x, json.decode(v.PosBoss).y, json.decode(v.PosBoss).z)
                local dist = #(plyPos-Boss)
                if dist <= 20.0 then
                    Timer = 0
                    DrawMarker(2, Boss, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 45,110,185, 255, 0, 1, 0, 0, nil, nil, 0)
                end
                if dist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder aux actions patron")
                    if IsControlJustPressed(1,51) then
                        JobBuilder.Boss = v
                        ESX.OpenSocietyMenu(v.Name);
                        --RefreshJobsMoney()
                        --MenuBoss(v.Label)
                    end
                end
            end
        end
        Citizen.Wait(Timer)
    end
end);