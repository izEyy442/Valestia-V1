local pma = exports["pma-voice"]
local currentChannel = 0

local Radio = {
    TickRadio = false,
    InfosRadio = false,
    Bruitages = true,
    Statut = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Allumé",
    VolumeRadio = 1,
    jobChannels = {
        {job = "police", min=1, max=15},
        {job = "bcso", min=1, max=15},
        {job = "fib", min=1, max=15},
        {job = "roxsherif", min=1, max=15},
        {job = "ambulance", min=1, max=15},
        {job = "gouv", min=1, max=15}
    },
}

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;

    if (inPVP) then

        Radio.TickRadio = false
        pma:setRadioChannel(0)
        pma:setVoiceProperty("radioEnabled", false);

    end

end);

RegisterCommand('radio', function()
    TriggerServerEvent("vCore1:radio:resquestMenu")
end)

RegisterNetEvent("vCore1:radio:player:resquestMenu", function(bool)

    if (IsInPVP) then return; end

    local radio = RageUI.CreateMenu("", "Menu radio")

    RageUI.Visible(radio, not RageUI.Visible(radio))

    while radio do
        Wait(0)

        RageUI.IsVisible(radio, function()

            if bool == true then

                radio.EnableMouse = false

                RageUI.Checkbox("Allumer / Eteindre", nil, Radio.TickRadio, { Style = RageUI.CheckboxStyle.Tick, LeftBadge = RageUI.BadgeStyle.Star }, {
                    onChecked = function()
                        Radio.TickRadio = true 
                        pma:setVoiceProperty("radioEnabled", true)
                        ESX.ShowAdvancedNotification('Notification', "Radio", "Radio Allumé", 'CHAR_CALL911', 8)
                    end,
                    onUnChecked = function()
                        Radio.TickRadio = false
                        pma:setRadioChannel(0)
                        pma:setVoiceProperty("radioEnabled", false)
                        ESX.ShowAdvancedNotification('Notification', "Radio", "Radio Eteinte", 'CHAR_CALL911', 8)
                    end,
                    onSelected = function(Index)
                        Radio.TickRadio = Index
                    end
                })

                -- RageUI.Button("Allumer / Eteindre", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                --     onSelected = function()
                --         if not Radio.TickRadio then 
                --             Radio.TickRadio = true 
                --             pma:setVoiceProperty("radioEnabled", true)
                --             ESX.ShowAdvancedNotification('Notification', "Radio", "Radio Allumé", 'CHAR_CALL911', 8)
                --         else
                --             Radio.TickRadio = false
                --             pma:setRadioChannel(0)
                --             pma:setVoiceProperty("radioEnabled", false)
                --             ESX.ShowAdvancedNotification('Notification', "Radio", "Radio Eteinte", 'CHAR_CALL911', 8)
                --         end
                --     end
                -- })

                if Radio.TickRadio then
                    -- RageUI.Separator("Radio: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Allumée")

                    -- if Radio.Bruitages then 
                    --     RageUI.Separator("Bruitages: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Activés")
                    -- else
                    --     RageUI.Separator("Bruitages: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Désactivés")
                    -- end

                    if Radio.VolumeRadio*100 <= 20 then 
                        ColorRadio = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" 
                    elseif Radio.VolumeRadio*100 <= 45 then 
                        ColorRadio ="~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" 
                    elseif Radio.VolumeRadio*100 <= 65 then 
                        ColorRadio ="~o~" 
                    elseif Radio.VolumeRadio*100 <= 100 then 
                        ColorRadio ="~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" 
                    end 

                    -- RageUI.Separator("Volume: "..ColorRadio..ESX.Math.Round(Radio.VolumeRadio*100).."~s~ %")

                    RageUI.Line()

                    RageUI.Button("Se connecter à une fréquence ", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→" }, true, {
                        onSelected = function()
                            local verif, Frequence = CheckQuantity(KeyboardInput("Frequence", "Frequence", "", 10))
                            local PlayerData = ESX.GetPlayerData(_source)
                            local restricted = {}
                            
                            if Frequence > 500 then
                                return
                            end
                            
                            for i,v in pairs(Radio.jobChannels) do
                                if Frequence >= v.min and Frequence <= v.max then
                                    table.insert(restricted, v)
                                end
                            end
                        
                            if #restricted > 0 then
                                for i,v in pairs(restricted) do
                                    if PlayerData.job.name == v.job and Frequence >= v.min and Frequence <= v.max then
                                        Radio.Frequence = tostring(Frequence)
                                        pma:setRadioChannel(Frequence)
                                        ESX.ShowAdvancedNotification('Notification', "Radio", "Fréquence définie sur "..Frequence.." MHZ", 'CHAR_CALL911', 8)
                                        currentChannel = Frequence
                                        break
                                    elseif i == #restricted then
                                        ESX.ShowAdvancedNotification('Notification', "Radio", "Echec de la connexion a la fréquence", 'CHAR_CALL911', 8)
                                        break
                                    end
                                end
                            else
                                Radio.Frequence = tostring(Frequence)
                                pma:setRadioChannel(Frequence)
                                ESX.ShowAdvancedNotification('Notification', "Radio", "Fréquence définie sur "..Frequence.." MHZ", 'CHAR_CALL911', 8)
                                currentChannel = Frequence
                            end
                        end
                    })

                    RageUI.Button("Se déconnecter de la fréquence", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, {
                        onSelected = function()
                            pma:setRadioChannel(0)
                            Radio.Frequence = "0"
                            ESX.ShowAdvancedNotification('Notification', "Radio", "Vous êtes déconnecter de la fréquence", 'CHAR_CALL911', 8)
                        end
                    })

                    -- RageUI.Button("Activer les bruitages", "Vous permet d'activer les bruitages'", {RightLabel = ">"}, true, {
                    --     onSelected = function()
                    --         if Radio.Bruitages then 
                    --             Radio.Bruitages = false
                    --             pma:setVoiceProperty("micClicks", false)
                    --             ESX.ShowAdvancedNotification('Notification', "Radio", "Bruitages radio désactives", 'CHAR_CALL911', 8)
                    --         else
                    --             Radio.Bruitages = true 
                    --             ESX.ShowAdvancedNotification('Notification', "Radio", "Bruitages radio activés", 'CHAR_CALL911', 8)
                    --             pma:setVoiceProperty("micClicks", true)
                    --         end
                    --     end
                    -- })
                else
                    -- RageUI.Separator("Radio: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Eteinte")
                end

            else
                RageUI.Separator("")
                RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Vous n'avez pas de radio")
                RageUI.Separator("")
            end

            end, function()
                RageUI.PercentagePanel(Radio.VolumeRadio, 'Volume', '0%', '100%', {
                    onProgressChange = function(Percentage)
                        Radio.VolumeRadio = Percentage
                        pma:setRadioVolume(Percentage)
                    end
                }, 5) 
            end)

            if not RageUI.Visible(radio) then
                radio = RMenu:DeleteType("radio")
            end

    end

end)

RegisterKeyMapping("radio", "Menu radio", "keyboard", "F4")