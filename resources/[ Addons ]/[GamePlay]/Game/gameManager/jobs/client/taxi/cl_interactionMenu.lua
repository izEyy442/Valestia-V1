---
--- @author Azagal
--- Create at [28/10/2022] 15:14:47
--- Current project [Silky-V1]
--- File name [interactionMenu]
---

Taxi = Taxi or {}

ServiceTaxi = false

function Taxi:interactionMenu()
    local mainMenu = RageUI.CreateMenu("", "Menu d'intéractions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while (mainMenu ~= nil) do
        RageUI.IsVisible(mainMenu, function()
            if ServiceTaxi then
                RageUI.Button("Envoyer une facture", nil, {
                    RightLabel = "→→"
                }, true, {
                    onSelected = function()
                        local amount = tonumber(KeyboardInput("Indiquez un montant", '', 5))
                        if amount == nil then
                            ESX.ShowNotification("Montant invalide")
                            return false
                        else
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Personne autour de vous.')
                            else
                                ESX.ShowNotification("~g~Facture envoyée avec succès !")
                                TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(closestPlayer), amount)
                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'taxi', 'Taxi', amount)
                            end
                        end
                    end
                });

                RageUI.Checkbox("Mission PNJ", nil, Taxi.missionData.actived, {}, {
                    onChecked = function()
                        TriggerServerEvent("Taxi:mission:retreive")
                    end,
                    onUnChecked = function()
                        TriggerServerEvent("Taxi:mission:stop")
                    end
                });
            else
                RageUI.Separator("Vous devez etre en service !")
            end
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end

        Wait(0)
    end
end

CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Wait(500)
    end
    while true do
        local interval = 1000
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)
        if ESX.PlayerData.job.name == 'taxi' then
            for k,v in pairs(Config.Jobs.Taxi.Clothes) do
                if #(coords - v.clothes) <= 10 then
                    DrawMarker(20, v.clothes, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    interval = 1
                    if #(coords - v.clothes) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            CreateThread(function()
                                openClothesforTaxi = true
                                TaxiClotheMenu()
                            end)
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function TaxiClotheMenu()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openClothesforTaxi do
        RageUI.IsVisible(mainMenu, function()
			if ServiceTaxi then
				RageUI.Button("Reprendre votre tenue civile", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						ServiceTaxi = false
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
					end
				})
			else
				RageUI.Button("Prendre votre tenue", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						ServiceTaxi = true
                        TriggerServerEvent('sendLogs:ServiceYes')
						SetTaxiUniform('Taxi', PlayerPedId())
					end
				})
			end
        end)

        local onPos = false
        for _, v in pairs(Config.Jobs.Taxi.Clothes) do
            if #(GetEntityCoords(PlayerPedId()) - v.clothes) > 10 then
                onPos = true
            end
        end

        -- if not RageUI.Visible(mainMenu) or onPos == false then
        --     mainMenu = RMenu:DeleteType('mainMenu', true)
        --     openClothesforTaxi = false
        -- end

        Citizen.Wait(0)
    end
end

function SetTaxiUniform()
    TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Taxi.Uniforms.male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Taxi.Uniforms.female)
		end
	end)
end

Keys.Register('F6','InteractionsJobTaxi', "Menu job Taxi", function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
        if (not IsInPVP) then
            Taxi:interactionMenu()
        end
    end
end)