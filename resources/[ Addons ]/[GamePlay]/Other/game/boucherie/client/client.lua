local config = {
    color = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~",
    ped = {pos = vector3(961.6025390625,-2111.5151367188,30.948392868042), heading = 94.76, model = "s_m_y_factory_01"},
    menu = {pos = vector3(961.33172607422,-2111.466796875,31.948392868042), message = "Appuyez sur ~INPUT_CONTEXT~ pour parler a l'acheteur~s~."},
    items = {
        {
            itemReseller = "viande_1",
            itemSeller = "morviande_1",
            label = "Viande Blanche",
            priceSeller = 10,
            priceReseller = 125,
        },
        {
            itemReseller = "viande_2",
            itemSeller = "morviande_2",
            label = "Viande Rouge",
            priceSeller = 12,
            priceReseller = 150
        }
    },
}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
   end
   if ESX.IsPlayerLoaded() then
        ESX.PlayerData = ESX.GetPlayerData()
   end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local function BoucherieInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry("FMMC_KEY_TIP1", TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

local function openMenu()
    local mainMenu = RageUIv3.CreateMenu("", "Boucherie")
    local resellerMenu = RageUIv3.CreateMenu("", "Boucherie")
    local sellerMenu = RageUIv3.CreateMenu("", "Boucherie")

    RageUIv3.Visible(resellerMenu, not RageUIv3.Visible(resellerMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while mainMenu do
        Wait(1)
        RageUIv3.IsVisible(resellerMenu, true, true, true, function()
            for k,v in pairs(config.items) do
                RageUIv3.Button("Vendre de la "..config.color..""..v.label, nil, {RightLabel = v.priceReseller.."~g~$~s~"}, true, function(h, a, s)
                    if s then
                        local count = tonumber(BoucherieInput("Veuillez saisir une "..config.color.."quantité~s~ :", "", 3))
                        if count == "" or count == nil then return ESX.ShowAdvancedNotification('Notification', 'Boucherie', "Cette quantité est invalide", 'CHAR_CALL911', 8) end
                        TriggerServerEvent("Boucherie:sellItem", v.itemReseller, count)
                    end
                end)
            end
        end)

        if not RageUIv3.Visible(mainMenu) and not RageUIv3.Visible(resellerMenu) and not RageUIv3.Visible(sellerMenu) then
            mainMenu = RMenu:DeleteType("menu", true)
        end
    end

    FreezeEntityPosition(PlayerPedId(), false)
end 

CreateThread(function()
    local model = GetHashKey(config.ped.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(10)
    end
    local ped = CreatePed(9, model, config.ped.pos, config.ped.heading, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)

    while true do
        local waiting = 250
        local pedCoords = GetEntityCoords(PlayerPedId())

        if #(pedCoords-config.menu.pos) < 1.0 then
            waiting = 1
            ESX.ShowHelpNotification(config.menu.message)
            if IsControlJustReleased(0, 51) then
                openMenu()
            end
        end

        Wait(waiting)
    end
end)