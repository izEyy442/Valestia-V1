menuOpened, menuCat, menus = false, "drugsbuilder", {}

local builder = {
    -- Valeur de base
    name = nil,
    rawItem = nil,
    treatedItem = nil,

    -- Valeur numériques
    harvestCount = nil,
    treatmentCount = nil,
    treatmentReward = nil,
    sellCount = nil,
    sellRewardPerCount = nil,
    sale = nil,

    -- Potisions
    harvest = nil,
    treatement = nil,
    vendor = nil,
}

local function input(TextEntry, ExampleText, MaxStringLenght, isValueInt)
    
	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) 
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(1000) 
		blockinput = false 
        if isValueInt then 
            local isNumber = tonumber(result)
            if isNumber then return result else return nil end
        end

		return result
	else
		Citizen.Wait(1000)
		blockinput = false 
		return nil
	end
end

local function canCreateDrug()
    return name ~= nil and name ~= "" and harvestCount ~= nil and harvestCount >= 1 and treatmentCount ~= nil and treatmentCount >= 1 and treatmentReward ~= nil and treatmentReward >= 1 and sellCount ~= nil and sellCount >= 1 and sellRewardPerCount ~= nil and sellRewardPerCount >= 1 and sale ~= nil and harvest ~= nil and treatement ~= nil and vendor ~= nil
end

local function subCat(string)
    return menuCat.."_"..string
end

local function addMenu(name)
    RMenu.Add(menuCat, subCat(name), RageUIv2.CreateMenu("","Gestion des drogues"))
    RMenu:Get(menuCat, subCat(name)).Closed = function()end
    table.insert(menus, name)
end

local function addSubMenu(name, depend)
    RMenu.Add(menuCat, subCat(name), RageUIv2.CreateSubMenu(RMenu:Get(menuCat, subCat(depend)), "", "Gestion des drogues"))
    RMenu:Get(menuCat, subCat(name)).Closed = function()end
    table.insert(menus, name)
end

local function valueNotDefault(value)
    if not value or value == "" then return "" else return "~s~ : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..tostring(value) end
end

local function okIfDef(value)
    if not value or value == "" then return "" else return "~s~ : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Défini" end
end

local function delMenus()
    for k,v in pairs(menus) do 
        RMenu:Delete(menuCat, v)
    end
end

function openMenu35(drugs) 
    local colorVar = "~s~"
    local actualColor = 1
    local colors = {"~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~", "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~","~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"}

    menuOpened = true
    addMenu("main")
    addSubMenu("builder", "main")
    RageUIv2.Visible(RMenu:Get(menuCat, subCat("main")), true)

    Citizen.CreateThread(function()
        while menuOpened do
            Wait(800)
            if colorVar == "~s~" then colorVar = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" else colorVar = "~s~" end
        end
    end)

    Citizen.CreateThread(function()
        while menuOpened do 
            Wait(500)
            actualColor = actualColor + 1
            if actualColor > #colors then actualColor = 1 end
        end
    end)

    Citizen.CreateThread(function()
        while menuOpened do
            local shouldClose = true
            RageUIv2.IsVisible(RMenu:Get(menuCat,subCat("main")),true,true,true,function()
                shouldClose = false
                -- RageUIv2.Line()
                local total = 0
                for _,_ in pairs(drugs) do
                    total = total + 1
                end
                if total <= 0 then
                    RageUIv2.ButtonWithStyle("Aucune drogue active", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUI.BadgeStyle.Tick }, true, function() end)
                else
                    for drugID, drugsInfos in pairs(drugs) do
                        RageUIv2.ButtonWithStyle("~s~"..drugsInfos.name, "L'action (~r~supprimer~s~) est irréversible", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "[~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Supprimer~s~]"}, true, function(_,_,s)
                            if s then
                                shouldClose = true
                                TriggerServerEvent("exedrugs_deletedrug", drugID)
                            end
                        end)
                    end
                end

                RageUIv2.Line()

                RageUIv2.ButtonWithStyle("~s~Création de Drogue", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)

                end, RMenu:Get(menuCat, subCat("builder")))
            end, function()    
            end, 1)

            RageUIv2.IsVisible(RMenu:Get(menuCat,subCat("builder")),true,true,true,function()
                shouldClose = false
                -- Informations de base
                -- RageUIv2.Line()
                RageUIv2.ButtonWithStyle("~s~Nom de la drogue"..valueNotDefault(builder.name), "Vous permets de définir le nom de votre drogue", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, false)
                        if result ~= nil then builder.name = result end
                    end
                end)
                RageUIv2.ButtonWithStyle("~s~Item non traité"..valueNotDefault(builder.rawItem), "Vous permets de définir l'item non traité", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, false)
                        if result ~= nil then builder.rawItem = result end
                    end
                end)
                RageUIv2.ButtonWithStyle("~s~Item traité"..valueNotDefault(builder.treatedItem), "Vous permets de définir l'item traité", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, false)
                        if result ~= nil then builder.treatedItem = result end
                    end
                end)
                -- Valeur numériques
                RageUIv2.Line()
                RageUIv2.ButtonWithStyle("~s~Récompense récolte"..valueNotDefault(builder.harvestCount), "Vous permets de définir la récompense (x items) pour une récolte", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.harvestCount = result end
                    end
                end)
                RageUIv2.ButtonWithStyle("~s~Nécéssaire traitement"..valueNotDefault(builder.treatmentCount), "Vous permets de définir combien de votre drogue sont nécéssaire pour la transformer", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.treatmentCount = result end
                    end
                end)
                RageUIv2.ButtonWithStyle("~s~Récompense traitement"..valueNotDefault(builder.treatmentReward), "Vous permets de définir la récompense (x items) pour un traitement", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"} , true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.treatmentReward = result end
                    end
                end)
                RageUIv2.ButtonWithStyle("~s~Pochon Nécéssaire a la revente"..valueNotDefault(builder.sellCount), "Vous permets de définir combien de votre drogue sont nécéssaire pour la vendre", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.sellCount = result end
                    end
                end)
                RageUIv2.ButtonWithStyle("~s~Récompense d'argent a la revente"..valueNotDefault(builder.sellRewardPerCount), "Vous permets de définir la récompense (x argent) pour une revente", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.sellRewardPerCount = result end
                    end
                end)
                RageUIv2.ButtonWithStyle("~s~Type d'argent a la revente"..valueNotDefault(builder.sale), "Vous permets de définir l'argent sale (1) ou propre(0)", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 1, true)
                        if result ~= nil then builder.sale = result end
                    end
                end)
                -- Positions et points
                RageUIv2.Line()
                RageUIv2.ButtonWithStyle("~s~Position récolte"..okIfDef(builder.harvest), "Vous permets de définir la position de la récolte", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local pos = GetEntityCoords(PlayerPedId())
                        builder.harvest = {x = pos.x, y = pos.y, z = pos.z}
                    end
                end)
                RageUIv2.ButtonWithStyle("~s~Position traitement"..okIfDef(builder.treatement), "Vous permets de définir la position du traitement", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local pos = GetEntityCoords(PlayerPedId())
                        builder.treatement = {x = pos.x, y = pos.y, z = pos.z}
                    end
                end)
                RageUIv2.ButtonWithStyle("~s~Position revente"..okIfDef(builder.vendor), "Vous permets de définir la position de la revente", {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        local pos = GetEntityCoords(PlayerPedId())
                        builder.vendor = {x = pos.x, y = pos.y, z = pos.z}
                    end
                end)
                -- Interactions
                RageUIv2.Line()
                RageUIv2.ButtonWithStyle("Validez et crée la Drogue", nil, { LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUI.BadgeStyle.Tick, Style = { Font = { Font = 4, Scale = 0.35 } } }, true, function(_,_,s)
                    if s then
                        shouldClose = true
                        ESX.ShowAdvancedNotification('Notification', 'DrugsBuilder', "Création de la drogue en cours...", 'CHAR_CALL911', 8)
                        TriggerServerEvent("exedrugs_create", builder)
                    end
                end)
            end, function()    
            end, 1)


            if shouldClose and menuOpened then
                menuOpened = false
            end

            Wait(0)
        end

        delMenus()
    end)
end