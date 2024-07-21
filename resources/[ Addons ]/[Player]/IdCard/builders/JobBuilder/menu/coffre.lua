local ESX = nil
local jobsData = {};

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

	ESX.PlayerData = xPlayer
    PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

RegisterNetEvent('jobbuilder:restarted', function(player)

    ESX.PlayerData = player
    PlayerData = xPlayer

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

local JobBuilder = {
    Coffre = {}
};

function MenuCoffre(Label)
    local MenuCoffre = RageUIJob.CreateMenu("", "Interaction")
        RageUIJob.Visible(MenuCoffre, not RageUIJob.Visible(MenuCoffre))
            while MenuCoffre do
            Citizen.Wait(0)
            RageUIJob.IsVisible(MenuCoffre, true, true, true, function()

                RageUIJob.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Métier : "..Label)

                RageUIJob.ButtonWithStyle("Prendre objet",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        CoffreRetirer()
                        RageUIJob.CloseAll()
                    end
                end)

                RageUIJob.ButtonWithStyle("Déposer objet",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        CoffreDeposer()
                        RageUIJob.CloseAll()
                    end
                end)

                end, function()
                end)
            if not RageUIJob.Visible(MenuCoffre) then
            MenuCoffre = RMenu:DeleteType("MenuCoffre", true)
        end
    end
end


itemstock = {}
function CoffreRetirer()
    local StockCoffre = RageUIJob.CreateMenu("", JobBuilder.Coffre.Label)
    ESX.TriggerServerCallback('JobBuilder:getStockItems', function(items)
        itemstock = items
    end, JobBuilder.Coffre.Name)
    CreateThread(function()
        RageUIJob.Visible(StockCoffre, not RageUIJob.Visible(StockCoffre))
            while StockCoffre do
                Citizen.Wait(0);
                RageUIJob.IsVisible(StockCoffre, true, true, true, function()
                    if (type(itemstock) == "table") then
                        for k,v in pairs(itemstock) do
                            if (type(v) == "table") then
                                if v.count > 0 then
                                    RageUIJob.ButtonWithStyle("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~→~s~ "..v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                        if Selected then
                                            local cbRetirer = JobBuilderKeyboardInput("Combien ?", "", 15)
                                            TriggerServerEvent('JobBuilder:getStockItem', v.name, tonumber(cbRetirer), JobBuilder.Coffre.Name)
                                            CoffreRetirer()
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end, function()end);
                if not RageUIJob.Visible(StockCoffre) then
                StockCoffre = RMenu:DeleteType("Coffre", true)
            end
        end
    end);
end

function CoffreDeposer()
    local StockPlayer = RageUIJob.CreateMenu("", "Voici votre ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~inventaire")
    ESX.TriggerServerCallback('JobBuilder:getPlayerInventory', function(inventory)
        RageUIJob.Visible(StockPlayer, not RageUIJob.Visible(StockPlayer))
    while StockPlayer do
        Citizen.Wait(0)
            RageUIJob.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUIJob.ButtonWithStyle("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~→~s~ "..item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local cbDeposer = JobBuilderKeyboardInput("Combien ?", '' , 15)
                                            TriggerServerEvent('JobBuilder:putStockItems', item.name, tonumber(cbDeposer), JobBuilder.Coffre.Name)
                                            CoffreDeposer()
                                        end
                                    end)
                            end
                    end
                end
                    end, function()
                    end)
                if not RageUIJob.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for k,v in pairs(jobsData) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name then
                local plyPos = GetEntityCoords(PlayerPedId())
                local Coffre = vector3(json.decode(v.PosCoffre).x, json.decode(v.PosCoffre).y, json.decode(v.PosCoffre).z)
                local dist = #(plyPos-Coffre)
                if dist <= 20.0 then
                    Timer = 0
                    DrawMarker(2, Coffre, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 45,110,185, 255, 0, 1, 0, 0, nil, nil, 0)
                end
                if dist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder au coffre")
                    if IsControlJustPressed(1,51) then
                        JobBuilder.Coffre = v
                        ESX.OpenSocietyChest(v.Name);
                        --MenuCoffre(v.Label)
                    end
                end
            end
        end
        Citizen.Wait(Timer)
    end
end)