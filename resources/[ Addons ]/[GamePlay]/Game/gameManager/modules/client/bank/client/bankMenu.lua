---
--- @author Azagal
--- Create at [23/10/2022] 19:36:21
--- Current project [Valestia-V1]
--- File name [bankMenu]
---

Bank = {}
local atmObjects = {
    "prop_fleeca_atm",
    "prop_atm_01",
    "prop_atm_03",
    "prop_atm_02"
}

local bankMenu = {

	player = {
		firstname = "default",
		lastname = "default",
    },
}

RegisterNetEvent('izeyy:bankMenu:receiveData', function(firstname, lastname)
	bankMenu.player.firstname = firstname
	bankMenu.player.lastname = lastname
end)

function Bank:openMenu(type)
    local accountMoney = 0
    local playerHasCard = nil
    local mainMenu = RageUI.CreateMenu("", "Banque")
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        local playerData = ESX.GetPlayerData()

        RageUI.IsVisible(mainMenu, function()
            for i = 1, #playerData.accounts do
                local selectedAccount = playerData.accounts[i]
                if (selectedAccount ~= nil) then
                    if (selectedAccount.name == "bank") then
                        accountMoney = selectedAccount.money
                    end
                end
            end

            for i = 1, #playerData.inventory do
                local selectedItem = playerData.inventory[i]
                if (selectedItem ~= nil) then
                    if (selectedItem.name == "cb") then
                        playerHasCard = true
                    end
                end
            end

            RageUI.Separator("Bonjour : ~h~~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..bankMenu.player.lastname.." "..bankMenu.player.firstname.."~h~")
            RageUI.Separator("Argent en Banque : ~h~~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..ESX.Math.GroupDigits(accountMoney).."$~s~~h~")
            RageUI.Line()

            RageUI.Button("Déposer de l'argent", nil, { LeftBadge = RageUI.BadgeStyle.Star, 
                RightLabel = "→→"
            }, type == "bank" or type == "atm" and playerHasCard == true, {
                onSelected = function()
                    local selectedCount = tonumber(KeyboardInput("Veuillez saisir la somme a déposer :", "", 7))
                    if (selectedCount ~= nil and selectedCount > 0) then
                        TriggerServerEvent("Bank:addMoney", selectedCount)
                    end
                end
            })

            RageUI.Button("Retirer de l'argent", nil, { LeftBadge = RageUI.BadgeStyle.Star,
                RightLabel = "→→"
            }, type == "bank" or type == "atm" and playerHasCard == true, {
                onSelected = function()
                    local selectedCount = tonumber(KeyboardInput("Veuillez saisir la somme a retirer :", "", 7))
                    if (selectedCount ~= nil and selectedCount > 0) then
                        TriggerServerEvent("Bank:removeMoney", selectedCount)
                    end
                end
            })

            RageUI.Line()

            if (type == "bank") then
                RageUI.Button("Récupérer ma carte (~h~~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~2000$~s~~h~)", nil, { LeftBadge = RageUI.BadgeStyle.Star,
                    RightLabel = "→→"
                }, type == "bank", {
                    onSelected = function()
                        TriggerServerEvent("Bank:buyCard")
                    end
                })
            elseif (type == "atm") then
                -- RageUI.Separator("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Une carte bancaire est nécessaire.")
                if ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "bcso" or ESX.PlayerData.job.name == "gouv" then
                    RageUI.Button("Pirater le distributeur", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, false, {
                    onSelected = function()
                    end
                })
                else

                    RageUI.Button("Pirater le distributeur", nil, {RightLabel = "→→"}, 
                    type == "atm", {
                        onSelected = function()
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                ESX.ShowNotification("~r~Erreur !~s~ Action impossible dans un véhicules")
                            else
                                TriggerServerEvent("Bank:hackATM", true)
                                RageUI.CloseAll()
                            end
                        end
                    }) 
                end
            end

        end)

        if (not RageUI.Visible(mainMenu)) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
        end

        Wait(0)
    end
end

RegisterNetEvent("Bank:startBruteForce")
AddEventHandler("Bank:startBruteForce", function()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local unarmedHash = GetHashKey("WEAPON_UNARMED")

    for i = 1, #atmObjects do
        local atmObject = atmObjects[i]
        if (atmObject ~= nil) then
            local closestObject = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 1.0, GetHashKey(atmObject), true, true, true)
            if (closestObject ~= 0) then
                SetCurrentPedWeapon(player, unarmedHash, true)
                startHack(playerCoords)
            end
        end
    end
end)

RegisterNetEvent("Bank:PoliceBlip")
AddEventHandler("Bank:PoliceBlip", function(pos, duration)
    PlaySoundFrontend(-1, "Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
    ESX.ShowAdvancedNotification("Notification","Banque", "Un civil a appellé la police à cause d'un possible cambriolage d'atm.", "CHAR_CALL911",9)

    local blip = AddBlipForCoord(pos)
    SetBlipSprite(blip , 161)
    SetBlipScale(blip , 3.0)
    SetBlipColour(blip, 47)
    PulseBlip(blip)

    Citizen.Wait(1000*duration)

    RemoveBlip(blip)

end)