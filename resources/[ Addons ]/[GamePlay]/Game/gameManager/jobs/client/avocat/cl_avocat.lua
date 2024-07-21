ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

openAvocatF6 = function()
    local mainMenu = RageUI.CreateMenu("", "Interaction")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()

            RageUI.Separator("↓ Gestion Annonces ~s~ ↓")
            RageUI.Button("Annonce", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    OpenAnnouncementMenu()
                end
            })
            RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Ouvertures]~s~", nil, {RightLabel = "→"}, not avocatCooldown1, {
                onSelected = function()
                    avocatCooldown1 = true
                    TriggerServerEvent('Ouvre:avocat')

                    CreateThread(function()
                        Wait(15000)
                        avocatCooldown1 = false
                    end)
                end
            })
            RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Fermetures]~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~", nil, {RightLabel = "→"}, not avocatCooldown2, {
                onSelected = function()
                    avocatCooldown2 = true
                    TriggerServerEvent('Ferme:avocat')

                    CreateThread(function()
                        Wait(15000)
                        avocatCooldown2 = false
                    end)
                end
            })
            RageUI.Button("Annonce ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[Recrutement]", nil, {RightLabel = "→"}, not avocatCooldown3, {
                onSelected = function()
                    avocatCooldown3 = true
                    TriggerServerEvent('Recru:avocat')

                    CreateThread(function()
                        Wait(15000)
                        avocatCooldown3 = false
                    end)
                end
            })
            RageUI.Separator("↓ Gestion Facture ~s~ ↓")
            RageUI.Button("Faire une ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Facture", nil, {RightLabel = ""}, true , {
                onSelected = function()
                    local montant = KeyboardInputavocat("Montant:", 'Indiquez un montant', '', 7)
                    if tonumber(montant) == nil then
                        ESX.ShowAdvancedNotification('Notification', "Avocat", "Montant invalide", 'CHAR_CALL911', 8)
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowAdvancedNotification('Notification', "Avocat", "Personne autour de vous", 'CHAR_CALL911', 8)
						else
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_avocat', "avocat", amount)
						end
                    end
                end
            })
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
        end
        Citizen.Wait(0)
    end
end

function OpenAnnouncementMenu()
    local annonce = KeyboardInput("Entrez votre annonce", "", 100)
    if annonce and annonce ~= "" then
        TriggerServerEvent('Avocat:annonce', annonce)
    end
end

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Keys.Register('F6','InteractionsJobAvocat', "Menu job Avocat", function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'avocat' then

        if (not IsInPVP) then
            openAvocatF6()
        end

    end
end)

local open = false
local mainMenu = RageUI.CreateMenu('', 'Avocat')
local subMenu1 = RageUI.CreateMenu('', 'Avocat')
mainMenu.Display.Header = true
mainMenu.Closed = function()
    open = false
    nomprenom = nil
    numero = nil
    heurerdv = nil
    rdvmotif = nil
end

RegisterNetEvent("Avocat:openMenuRendezVous", function()
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
            RageUI.Button("Appeler un Avocat", nil, {RightLabel = "→→"}, not codesCooldown5 , {
                    onSelected = function()
                    codesCooldown5 = true
                TriggerServerEvent('Appel:avocat')
                ESX.ShowAdvancedNotification('Notification', "Avocat", "Votre message a bien été envoyé aux avocats", 'CHAR_CALL911', 8)
                Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
                end
            })
            RageUI.Button("Prendre Rendez-Vous", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                end
            }, subMenu1)
        end)

        RageUI.IsVisible(subMenu1, function()
            RageUI.Button("Nom & Prénom", nil, {RightLabel = nomprenom}, true , {
                onSelected = function()
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Prénom & Nom", "Prénom & Nom", "", "", "", 20)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                    Citizen.Wait(1)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        nomprenom = GetOnscreenKeyboardResult()
                    end
                end
			})

            RageUI.Button("Numéro de Téléphone", nil, {RightLabel = numero}, true , {
                onSelected = function()
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "555-", "555-", "", "", "", 10)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                       Citizen.Wait(1)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        numero = GetOnscreenKeyboardResult()
            		end
                end
            })

            RageUI.Button("Heure du Rendez-vous", nil, {RightLabel = heurerdv}, true , {
                onSelected = function()
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "15h40", "15h40", "", "", "", 10)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                       Citizen.Wait(1)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        heurerdv = GetOnscreenKeyboardResult()
                    end
                end
            })

            RageUI.Button("Motif du Rendez-vous", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Motif", "Motif", "", "", "", 120)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                       Citizen.Wait(1)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        rdvmotif = GetOnscreenKeyboardResult()
                    end
                end
            })

            RageUI.Button("Valider la Demande", "", { Color = {BackgroundColor = { 76, 175, 80, 50}} }, true, {
                onSelected = function()
                        if (nomprenom == nil or nomprenom == '') then
                            ESX.ShowAdvancedNotification('Notification', "Avocat", "Vous n\'avez pas rempli votre Nom/Prénom", 'CHAR_CALL911', 8)
                        elseif (numero == nil or numero == '') then
                            ESX.ShowAdvancedNotification('Notification', "Avocat", "Vous n\'avez pas rempli votre Numéro", 'CHAR_CALL911', 8)
                        elseif (heurerdv == nil or heurerdv == '') then
                            ESX.ShowAdvancedNotification('Notification', "Avocat", "Vous n\'avez pas rempli l'heure de votre Rendez-vous", 'CHAR_CALL911', 8)
                        elseif (rdvmotif == nil or rdvmotif == '' or rdvmotif == "Motif") then
                            ESX.ShowAdvancedNotification('Notification', "Avocat", "Vous n\'avez pas rempli le motif de votre Rendez-vous", 'CHAR_CALL911', 8)
                    else
                        RageUI.CloseAll()
                        TriggerServerEvent("Rdv:Avocat", nomprenom, numero, heurerdv, rdvmotif)
                        ESX.ShowAdvancedNotification('Notification', "Avocat", "Votre Demande de Rendez-vous a bien été envoyée", 'CHAR_CALL911', 8)
                        nomprenom = nil
                        numero = nil
                        heurerdv = nil
                        rdvmotif = nil
                    end
                end
			})
		end)
            Wait(0)
        end
        end)
    end
end)

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(-1978.5653, -493.6388, 25.9067)

    SetBlipSprite (blip, 408)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.7)
    SetBlipColour (blip, 37)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('[Public] Cabinet d\'Avocat')
    EndTextCommandSetBlipName(blip)

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
end)


local npc = {
    {hash="a_m_y_business_02", x = -768.687, y = -614.0397, z = 30.26, a = 351.68090820313},
}

Citizen.CreateThread(function()
    for _, item2 in pairs(npc) do
        local hash = GetHashKey(item2.hash)
        while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
        end
        ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        SetBlockingOfNonTemporaryEvents(ped2, true)
        FreezeEntityPosition(ped2, true)
        SetEntityInvincible(ped2, true)
    end
end)
