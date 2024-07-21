local startPos = nil
local endPos = nil
local desc = ""
local NombreJoueurs = nil
local typeVeh = ""
local prix = 0
local ArgentPropre = false
local participantMax = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}
local IndexEvent = {
    participant = 1
}

OpenMenuStaffEvent = function()
    local main = RageUI.CreateMenu("Staff Event", "Que voulez-vous faire ?")
    local activites_staff_event = RageUI.CreateSubMenu(main, "Staff Event", "Que voulez-vous faire ?")

    RageUI.Visible(main, not RageUI.Visible(main))

    while main do
        Citizen.Wait(0)
        RageUI.IsVisible(main, function()
			RageUI.Button("Fixé la pos start", "Determine la position de dépars", {RightLabel = startPos}, true , {
                onSelected = function() 
                    startPos = GetEntityCoords(PlayerPedId())
                    ESX.ShowNotification("~o~Coordonée de début définit")
                end
            })
            RageUI.Button("Fixé la pos de fin", "Determine la position de fin", {RightLabel = endPos}, true , {
                onSelected = function() 
                    endPos = GetEntityCoords(PlayerPedId())
                    ESX.ShowNotification("~o~Coordonée de fin définit")
                end
            })
            RageUI.Button("Fixé la déscription de l'évent", "Desc: "..desc, {RightLabel = desc}, true , {
                onSelected = function() 
                    AddTextEntry("Déscription évent", "")
                    DisplayOnscreenKeyboard(1, "Déscription évent", '', "", '', '', '', 256)
                
                    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                        Citizen.Wait(0)
                    end
                
                    if UpdateOnscreenKeyboard() ~= 2 then
                        desc = GetOnscreenKeyboardResult()
                        Citizen.Wait(1)
                    else
                        Citizen.Wait(1)
                    end
                end
            })
            RageUI.Line()
            RageUI.List("Nombres de joueurs", participantMax, IndexEvent.participant, nil, {RightLabel = IndexEvent.participant}, true , {
                onListChange = function(Index)
                    IndexEvent.participant = Index
                end
            })
            RageUI.Button("Fixé le véhicule de l'event", "Véhicule: "..typeVeh, {RightLabel = typeVeh}, true , {
                onSelected = function() 
                    AddTextEntry("VehEvent", "")
                    DisplayOnscreenKeyboard(1, "VehEvent", '', "", '', '', '', 20)
                
                    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                        Citizen.Wait(0)
                    end
                
                    if UpdateOnscreenKeyboard() ~= 2 then
                        typeVeh = GetOnscreenKeyboardResult()
                        Citizen.Wait(1)
                    else
                        Citizen.Wait(1)
                    end
                end
            })
            RageUI.Button("Fixé le prix", "Prix: "..prix, {RightLabel = prix}, true , {
                onSelected = function() 
                    AddTextEntry("Prix évent", "")
                    DisplayOnscreenKeyboard(1, "Prix évent", '', "", '', '', '', 20)
                
                    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                        Citizen.Wait(0)
                    end
                
                    if UpdateOnscreenKeyboard() ~= 2 then
                        prix = tonumber(GetOnscreenKeyboardResult())
                        Citizen.Wait(1)
                    else
                        Citizen.Wait(1)
                    end
                end
            })
            RageUI.Line()
            RageUI.Checkbox("Argent propre ?", "Si activer, l'argent reçu sera de l'argent propre.", ArgentPropre, {}, {
                onUnChecked = function()
                    ArgentPropre = false
                end,
                onSelected = function(Index)
                    ArgentPropre = Index
                end,
            })
            RageUI.Button("~o~Validé l'évent", nil, {}, true , {
                onSelected = function() 
                    TriggerServerEvent("splayer_staff_event:SendInfo", startPos, endPos, desc, IndexEvent.participant, typeVeh, prix, ArgentPropre)
                end
            })
        end)
    end
    if not RageUI.Visible(main) and not RageUI.Visible(activites_staff_event) then
        main = RMenu:DeleteType('main', true)
        activites_staff_event = RMenu:DeleteType('principalMain', true)
    end
end

RegisterCommand("event", function()
    if ESX.GetPlayerData()['group'] == 'gerant' or ESX.GetPlayerData()['group'] == 'founder' then 
        OpenMenuStaffEvent()
    else
        ESX.ShowNotification("~r~Vous ne pouvez pas faire cela !~s~")
    end
end)