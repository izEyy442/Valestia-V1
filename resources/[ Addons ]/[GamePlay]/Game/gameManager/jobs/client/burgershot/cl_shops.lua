local open = false 
local MenuShopBurgerShot = RageUI.CreateMenu('', 'Frigo') 
MenuShopBurgerShot.Display.Header = true 
MenuShopBurgerShot.Closed = function()
  	open = false
end

RegisterNetEvent("burgershot:OpenMenuShop", function()
	if open then
		open = false
		RageUI.Visible(MenuShopBurgerShot, false)
		return
	else
		open = true 
		RageUI.Visible(MenuShopBurgerShot, true)
		CreateThread(function()
			while open do
				RageUI.IsVisible(MenuShopBurgerShot, function() 
					local playerData = ESX.GetPlayerData()
					local job = playerData.job.name
					if job == 'burgershot' then 
						RageUI.Separator("↓ Cuisine ↓")

						RageUI.Button("Cornichons", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1$"}, true , {
							onSelected = function()
								TriggerServerEvent('burgershot:BuyItem', 'cornichons', 1)
							end
						})

						RageUI.Button("Salades", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~3$"}, true , {
							onSelected = function()
								TriggerServerEvent('burgershot:BuyItem', 'salade', 3)
							end
						})

						RageUI.Button("Tomates", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~2$"}, true , {
							onSelected = function()
								TriggerServerEvent('burgershot:BuyItem', 'tomates', 2)
							end
						})

						RageUI.Button("Steak Haché", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~5$"}, true , {
							onSelected = function()
								TriggerServerEvent('burgershot:BuyItem', 'steak', 5)
							end
						})

						RageUI.Button("Pain", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~2$"}, true , {
							onSelected = function()
								TriggerServerEvent('burgershot:BuyItem', 'painburger', 2)
							end
						})

						RageUI.Separator("↓ Frites ↓")

						RageUI.Button("Frites", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~3$"}, true , {
							onSelected = function()
								TriggerServerEvent('burgershot:BuyItem', 'frites', 3)
							end
						})

						RageUI.Separator("↓ Boissons ↓")

						RageUI.Button("Coca", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1$"}, true , {
							onSelected = function()
								TriggerServerEvent('burgershot:BuyItem', 'coca', 1)
							end
						})
			
						RageUI.Button("Orangina", nil, {RightLabel = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1$"}, true , {
							onSelected = function()
								TriggerServerEvent('burgershot:BuyItem', 'orangina', 1)
							end
						})
					else
						RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'êtes pas ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Concessionnaire Bateau]~s~")
						return
					end
				end)
				Citizen.Wait(wait)
			end
		end)
	end
end)