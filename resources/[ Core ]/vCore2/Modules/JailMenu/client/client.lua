ESX = nil
local jail = 0
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)
open = false

ConfigJailMenu = {
    {JailLabel = "Carkill", JailTache = 45},
    {JailLabel = "Conduite HRP", JailTache = 25},
    {JailLabel = "ForceRP / Copbait", JailTache = 30},
    {JailLabel = "FreeLoot", JailTache = 25},
    {JailLabel = "FreePunch", JailTache = 25},
    {JailLabel = "FreeShoot", JailTache = 30},
    {JailLabel = "Freekill", JailTache = 60},
    {JailLabel = "HRP Vocal", JailTache = 40},
    {JailLabel = "Hide Bush", JailTache = 80},
    {JailLabel = "Insinuation HRP", JailTache = 10},
    {JailLabel = "Insulte Parentale", JailTache = 60},
    {JailLabel = "MassRP", JailTache = 45},
    {JailLabel = "Metagaming", JailTache = 45},
    {JailLabel = "NoFear", JailTache = 30},
    {JailLabel = "NoPain", JailTache = 35},
    {JailLabel = "Offroad", JailTache = 40},
    {JailLabel = "PowerGaming", JailTache = 30},
    {JailLabel = "Refus De Scene", JailTache = 50},
}

RegisterNetEvent("JailMenu:OpenMenu")
AddEventHandler("JailMenu:OpenMenu", function(id)
    OpenJailMenu(id)
end)

local JailMenu = RageUI.CreateMenu("", "Menu Sanction", 0, 0, 'commonmenu', 'interaction_bgd')

JailMenu.Closed = function()
    open = false
end

function OpenJailMenu(id)
	if open then
		open = false
		RageUI.Visible(JailMenu,false)
		return
	else
		open = true
		RageUI.Visible(JailMenu,true)
		CreateThread(function()
			while open do

				RageUI.IsVisible(JailMenu,function() 
                    RageUI.Separator("ID sélectionné : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..id.."~s~")
                    RageUI.Separator("Staff : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..GetPlayerName(PlayerId()).."~s~")
                    RageUI.Line()
					for k,v in pairs(ConfigJailMenu) do
                        RageUI.Button(v.JailLabel.." [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..v.JailTache.."~s~]", "Le systeme de Sanction est en taches.", {RightLabel = "→→", LeftBadge = RageUI.BadgeStyle.Star}, true, {
                            onSelected = function()
                                TriggerServerEvent("JailMenu:JailPlayer", id, v.JailTache, v.JailLabel)
                                ESX.ShowNotification("Vous avez jail l'ID "..id.." pour "..v.JailTache.." taches ~s~")
                            end
                        })
                    end
                    RageUI.Line()
                    RageUI.Button("Taches Personalisé", nil, {LeftBadge = RageUI.BadgeStyle.Star, Color = { BackgroundColor = { 0, 115, 243, 225 } } }, true, {
                        onSelected = function()
                            local TacheRaison = KeyboardInput("Raison", "Entre la raison du jail", "", 20)
                            local tacheNumber = KeyboardInput("Tache", "Entre le nombre de taches", "", 3)
                            if TacheRaison ~= nil then
                                if tonumber(tacheNumber) ~= nil then
                                    if tonumber(tacheNumber) > 1 then
                                        if tonumber(tacheNumber) < 500 then
                                            TriggerServerEvent("JailMenu:JailPlayer", id, tacheNumber, TacheRaison)
                                            ESX.ShowNotification("Vous avez jail l'ID "..id.." pour "..tacheNumber.." taches ~s~")
                                            Wait(500)
                                            open = false
                                            RageUI.CloseAll()
                                        else
                                            ESX.ShowNotification("Veuillez saisir un chiffre entre ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1~c~-~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~500~s~")
                                        end
                                    else
                                        ESX.ShowNotification("Veuillez saisir un chiffre entre ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~1~c~-~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~500~s~")
                                    end 
                                else
                                    ESX.ShowNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Veuillez entrer un nombre de tache valide")
                                end
                            else
                                ESX.ShowNotification("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Veuillez entrer une raison valide")
                            end
                        end
                    })
				end)
				Citizen.Wait(1)
			end
		end)
	end
end