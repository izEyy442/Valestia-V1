local open = false 
local mainMenu = RageUI.CreateMenu('', 'Frigo Bahamas') 

mainMenu.Display.Header = true
mainMenu.Closed = function()
    open = false
    nomprenom = nil
    numero = nil
    heurerdv = nil
    rdvmotif = nil
end

local function KeyboardInputBahamas(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		return result
	else
		return nil
	end
end

RegisterNetEvent("bahamas:OpenMenuFrigo", function()
    if open then 
        open = false
        RageUI.Visible(mainMenu, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenu, true)

        CreateThread(function()
            while open do 
                RageUI.IsVisible(mainMenu, function()
                    local playerData = ESX.GetPlayerData()
                    local job = playerData.job.name
                    if job == 'bahamas' then 
                        RageUI.Separator("↓ Boisson ↓")

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Vin", nil, {RightLabel = "20$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "vine", 20, count)
                                end
                            end
                        })

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Mojito", nil, {RightLabel = "10$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "mojito", 10, count)
                                end
                            end 
                        })

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Ice Tea", nil, {RightLabel = "8$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "icetea", 8, count)
                                end
                            end
                        })

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Eau", nil, {RightLabel = "7$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "water", 7, count)
                                end
                            end
                        })

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Whisky-coca", nil, {RightLabel = "12$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "wiskycoca", 12, count)
                                end
                            end
                        })

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Coca", nil, {RightLabel = "6$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "coca", 6, count)
                                end
                            end
                        })

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Limonade", nil, {RightLabel = "7$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "limonade", 7, count)
                                end
                            end 
                        })

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Fanta", nil, {RightLabel = "10$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "fanta", 10, count)
                                end
                            end 
                        })

                        RageUI.Separator("↓ Nouriture ↓")

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Chips", nil, {RightLabel = "2$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "chips", 2, count)
                                end
                            end 
                        })

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Cacahuète", nil, {RightLabel = "1$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "cacahuete", 1, count)
                                end
                            end
                        })

                        RageUI.Button("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Acheter~s~ x1 Olive", nil, {RightLabel = "1$"}, not codesCooldown5 , {
                            onSelected = function()
                                local count = KeyboardInputBahamas("Combien ?", 'Indiquez un nombre', '', 2)
                                if count == "" and tonumber(count) == nil then
                                    ESX.ShowAdvancedNotification('Notification', "Bahamas", "Montant invalide", 'CHAR_CALL911', 8)
                                else
                                    TriggerServerEvent('bahamas:BuyItem', "olive", 1, count)
                                end
                            end 
                        })
                    else
                        RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'êtes pas ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Bahamas]~s~")
                        return
                    end
                end)			
                Wait(0)
            end
        end)
    end
end)