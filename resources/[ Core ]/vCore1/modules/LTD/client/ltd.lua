local main_menu = RageUI.AddMenu("", "Annonce")
local ltd_menu = RageUI.AddMenu("", "LTD")
local cloakroom_menu = RageUI.AddMenu("", "Vestiaire")
local pay_menu = RageUI.AddSubMenu(ltd_menu, "", "Facture")
local items_menu = RageUI.AddSubMenu(pay_menu, "", "Panier")

local hasAddItem = false
local isInService = false
local buyItems = {}
local walletItems = {}

local function reloadTable()
    hasAddItem = false
    buyItems = {}
    walletItems = {}

    for k, v in pairs(Config["LTDShop"]["Items"]) do
        buyItems[v.item] = {}
        buyItems[v.item].count =  0
        buyItems[v.item].price =  v.price
    end

end

---@param playerID number
local function playerMarker(player)
    if (player ~= -1) then
        local ped = GetPlayerPed(player)
        local pos = GetEntityCoords(ped)

        DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, Config["MarkerRGB"]["R"], Config["MarkerRGB"]["G"], Config["MarkerRGB"]["B"], Config["MarkerRGB"]["A1"], 0, 1, 2, 0, nil, nil, 0)
    end
end

CreateThread(function()
    reloadTable()
end)

ltd_menu:IsVisible(function(Items)

    for k, v in pairs(Config["LTDShop"]["Items"]) do
        local finalPrice = v.price - v.price * 30/100
        Items:Button(v.label.." | Bénéfice : "..finalPrice.."$", nil, {RightLabel = buyItems[v.item].count.." ("..v.price*buyItems[v.item].count.."~g~$~s~)"}, true, {
            onSelected = function()
                local count = tostring(Shared:KeyboardInput("Combien ?", 3))

                if (Shared:InputIsValid(count, "number")) then
                    if (tonumber(count) > 0) then
                        buyItems[v.item].item = v.label
                        buyItems[v.item].count = count
                        hasAddItem = true
                    else
                        ESX.ShowNotification("Veuillez entrer un nombre valide")
                    end
                else
                    ESX.ShowNotification("Veuillez entrer un nombre valide")
                end

            end
        })
    end

    Items:Button("Valider", nil, {Color = {BackgroundColor = RageUI.ItemsColour.Green}}, hasAddItem, {}, pay_menu)

end)

pay_menu:IsVisible(function(Items)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    Items:Button("Voir les articles acheter", nil, {}, true, {}, items_menu)

    Items:Button("Paiement par Carte", nil, {}, true, {
        onActive = function()
            if closestPlayer ~= -1 and closestDistance <= 2.5 then
                playerMarker(closestPlayer)
            end
        end,
        onSelected = function()
            local PlayerData = ESX.GetPlayerData()

            for k, v in pairs(buyItems) do
                if (tonumber(v.count) > 0) then
                    table.insert(walletItems, {
                        item = k, 
                        count = v.count, 
                        price = v.price*v.count, 
                        society = PlayerData.job.name
                    })
                end
            end
            if closestPlayer ~= -1 and closestDistance <= 2.5 then
                TriggerServerEvent("vCore1:ltd:buy", GetPlayerServerId(closestPlayer), walletItems, "bank")
                hasAddItem = false
                walletItems = {}
                RageUI.CloseAll()
            else
                ESX.ShowNotification("Aucun joueur à proximité")
            end
        end
    })
    Items:Button("Paiement par Cash", nil, {}, true, {
        onActive = function()
            if closestPlayer ~= -1 and closestDistance <= 2.5 then
                playerMarker(closestPlayer)
            end
        end,
        onSelected = function()
            for k, v in pairs(buyItems) do
                if (tonumber(v.count) > 0) then
                    table.insert(walletItems, {
                        item = k, 
                        count = v.count, 
                        price = v.price*v.count, 
                        society = "ltd"
                    })
                end
            end

            if closestPlayer ~= -1 and closestDistance <= 5 then
                TriggerServerEvent("vCore1:ltd:buy", GetPlayerServerId(closestPlayer), walletItems, "cash")
                hasAddItem = false
                walletItems = {}
                RageUI.CloseAll()
            else
                ESX.ShowNotification("Aucun joueur à proximité")
            end
        end
    })
end)

items_menu:IsVisible(function(Items)
    for k, v in pairs(buyItems) do
        if (tonumber(v.count) > 0) then
            Items:Button(v.item, nil, {RightLabel = v.count}, true, {})
        end
    end
end)

local function setUniform(type)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config["LTDShop"]["Uniform"][type].male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config["LTDShop"]["Uniform"][type].female)
		end
	end)
end

cloakroom_menu:IsVisible(function(Items)
    Items:Button("Prendre sa tenue", nil, {}, true, {
        onSelected = function()  
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            setUniform("Uniforms")
            TriggerServerEvent("vCore1:job:takeService", job, true)
            ESX.ShowNotification("Vous avez pris votre service")
            isInService = true
        end
    })
    Items:Button("Reprendre ses vêtements", nil, {}, true, {
        onSelected = function()
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            TriggerServerEvent("vCore1:job:takeService", job, false)
            ESX.ShowNotification("Vous avez quitter votre service")
            isInService = false
        end
    })
end)

RegisterNetEvent("vCore1:player:ltd:receiveBill", function(price)

    if (price ~= nil) then

        CreateThread(function()

            local timer = Shared.Timer(7)
            timer:Start()

            while true do
                ESX.ShowHelpNotification(("Vous avez reçu une facture de ~h~%s~h~ ~g~$~st~ \n[~g~Y~s~] pour accepter la Facture \n[~r~N~s~] pour refuser la Facture"):format(price))
                
                if (timer:HasPassed()) then
                    ESX.ShowNotification("Vous n'avez pas payé la facture à temps")
                    TriggerServerEvent("vCore1:ltd:payBill", false)
                    break
                end

                if IsControlJustReleased(0, 246) then
                    TriggerServerEvent("vCore1:ltd:payBill", true)
                    break
                end

                if IsControlJustReleased(0, 249) then
                    TriggerServerEvent("vCore1:ltd:payBill", false)
                    break
                end

                Wait(0)
            end

        end)

    end

end)

CreateThread(function()

    for k, v in pairs(Config["LTDShop"]["Blips"]) do
        Game.Blip("MaskZone"..k,
            {
                coords = v.position,
                label = v.label,
                sprite = v.sprite,
                color = v.color,
            }
        );
    end

    for k, v in pairs(Config["LTDShop"]["JobPos"]) do
        local JobZone = Game.Zone("JobLTDZone"..k)

        JobZone:Start(function()

            JobZone:SetTimer(1000)
            JobZone:SetCoords(v.position)

            JobZone:IsPlayerInRadius(3.0, function()
                JobZone:SetTimer(0)
                local playerData = ESX.GetPlayerData()
                local job = playerData.job.name
                
                if job == v.job then

                    if isInService then

                        JobZone:Marker()

                        JobZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder à la caisse")
                        JobZone:IsPlayerInRadius(2.0, function()

                            JobZone:KeyPressed("E", function()
                                reloadTable()
                                ltd_menu:Toggle()
                            end)

                        end, false, false)

                    end

                end

            end, false, false)

            JobZone:RadiusEvents(1.0, nil, function()
                ltd_menu:Close()
            end)
        end)

    end

    for k, v in pairs(Config["LTDShop"]["Cloakroom"]) do

        local CloakroomZone = Game.Zone("CloakroomLTDZone"..k)

        CloakroomZone:Start(function()

            CloakroomZone:SetTimer(1000)
            CloakroomZone:SetCoords(v.position)

            CloakroomZone:IsPlayerInRadius(3.0, function()
                CloakroomZone:SetTimer(0)
                local playerData = ESX.GetPlayerData()
                local job = playerData.job.name

                if job == v.job then
                        
                    CloakroomZone:Marker()

                    CloakroomZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder au vestiaire")
                    CloakroomZone:IsPlayerInRadius(2.0, function()

                        CloakroomZone:KeyPressed("E", function()
                            cloakroom_menu:Toggle()
                        end)

                    end, false, false)

                end

            end, false, false)

            CloakroomZone:RadiusEvents(3.0, nil, function()
                cloakroom_menu:Close()
            end)
        end)

    end

    for k, v in pairs(Config["LTDShop"]["Chest"]) do

        local ChestZone = Game.Zone("ChestLTDZone"..k)

        ChestZone:Start(function()

            ChestZone:SetTimer(1000)
            ChestZone:SetCoords(v.position)

            ChestZone:IsPlayerInRadius(3.0, function()
                ChestZone:SetTimer(0)
                local playerData = ESX.GetPlayerData()
                local job = playerData.job.name

                if job == v.job then
                        
                    ChestZone:Marker()

                    ChestZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder au coffre")
                    ChestZone:IsPlayerInRadius(2.0, function()

                        ChestZone:KeyPressed("E", function()
                            ESX.OpenSocietyChest(v.job)
                        end)

                    end, false, false)

                end

            end, false, false)

        end)

    end

    for k, v in pairs(Config["LTDShop"]["BossAction"]) do

        local BossZone = Game.Zone("BossActionLTDZone"..k)

        BossZone:Start(function()

            BossZone:SetTimer(1000)
            BossZone:SetCoords(v.position)

            BossZone:IsPlayerInRadius(3.0, function()
                BossZone:SetTimer(0)
                local playerData = ESX.GetPlayerData()
                local job = playerData.job.name
                local grade = playerData.job.grade_name

                if job == v.job then

                    if grade == "boss" then
                        
                        BossZone:Marker()

                        BossZone:Text("Appuyez sur ~c~["..Shared:ServerColorCode().."E~c~]~s~ pour accéder à l'action patron")
                        BossZone:IsPlayerInRadius(2.0, function()

                            BossZone:KeyPressed("E", function()
                                ESX.OpenSocietyMenu(v.job)
                            end)

                        end, false, false)

                    end

                end

            end, false, false)

        end)

    end

end)

RegisterNetEvent("vCore1:ltd:player:sendAnnounce", function(message)
    ESX.ShowNotification(message)
end)

main_menu:IsVisible(function(Items)

    if (isInService) then

        Items:Button("Annonce - Ouverture", nil, {}, true, {
            onSelected = function()
                TriggerServerEvent("vCore1:ltd:sendAnnounce", "open")
            end
        })
        Items:Button("Annonce - Fermeture", nil, {}, true, {
            onSelected = function()
                TriggerServerEvent("vCore1:ltd:sendAnnounce", "close")
            end
        })
        Items:Button("Annonce - Recrutement", nil, {}, true, {
            onSelected = function()
                TriggerServerEvent("vCore1:ltd:sendAnnounce", "recruitment")
            end
        })

    else
        Items:Separator("Vous devez être en service")
    end
end)


Shared:RegisterKeyMapping("vCore1:ltdinteractmenu:use", { label = "open_menu_ltdInteract" }, "F6", function()
    if not IsInPVP then
        local playerData = ESX.GetPlayerData()
        local job = playerData.job.name

        for k, v in pairs(Config["LTDShop"]["AllowedJob"]) do
            if (job == v) then
                main_menu:Toggle()
                break
            end
        end

	end
end)