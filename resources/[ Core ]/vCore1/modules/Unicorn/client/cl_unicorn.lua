local main_menu = RageUI.AddMenu("", "Gestion Vanilla Unicorn")
local bar_menu = RageUI.AddMenu("", "Bar Vanilla Unicorn")
local CloakroomProtect_menu = RageUI.AddMenu("", "Tenue Securité Vanilla Unicorn")
local CloakroomDanse_menu = RageUI.AddMenu("", "Tenue Vanilla Unicorn")
local armory_menu = RageUI.AddMenu("", "Armurerie Vanilla Unicorn")
local garage_menu = RageUI.AddMenu("", "Garage Vanilla Unicorn")
local loot_menu = RageUI.AddSubMenu(main_menu, "", "Fouiller le joueur")

local isInService = true

local InventoryItems = {}
local IventoryWeapon = {}
local InventoryBlackMoney = {}

local UnicornStatus = {

    UnicornStatusList = {

        "Ouverture",
        "Fermeture",
        "Recrutement"

    },
    
    UnicornStatusListIndex = 1

}

local UnicornDanceuse = {

    UnicornDanceuseList = {

        "Faire entrer en scène",
        "Dire d'arrêter"

    },
    
    UnicornDanceuseListIndex = 1

}

-- Zone Sys
CreateThread(function()

    for k, v in pairs(Config["Unicorn"]["JobPos"]) do
        local BarZone = Game.Zone("UnicornBarZone")

        BarZone:Start(function()

            BarZone:SetTimer(1000)
            BarZone:SetCoords(v.position)

            BarZone:IsPlayerInRadius(3.0, function()
                BarZone:SetTimer(0)
                local playerData = ESX.GetPlayerData()
                local job = playerData.job.name
                
                if job == "unicorn" then

                    BarZone:Marker()

                    BarZone:Text("Appuyez sur [E] pour accéder au Bar.")
                    BarZone:IsPlayerInRadius(2.0, function()

                        BarZone:KeyPressed("E", function()
                            bar_menu:Toggle()
                        end)

                    end, false, false)

                end

            end, false, false)

            BarZone:RadiusEvents(1.0, nil, function()
                bar_menu:Close()
            end)
        end)

    end

    local CloakroomProtect = Game.Zone("UnicornCloakroomProtect")

    CloakroomProtect:Start(function()

        CloakroomProtect:SetTimer(1000)
        CloakroomProtect:SetCoords(vector3(107.4715423584, -1299.4831542969, 28.768808364868))

        CloakroomProtect:IsPlayerInRadius(8.0, function()
            CloakroomProtect:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name
            local grade = playerData.job.grade

            if job == "unicorn" then

                if grade >= Config["Unicorn"]["VideurAcces"] then

                    CloakroomProtect:Marker()

                    CloakroomProtect:Text("Appuyez sur [E] pour vous changer.")
                    CloakroomProtect:IsPlayerInRadius(2.0, function()

                        CloakroomProtect:KeyPressed("E", function()
                            CloakroomProtect_menu:Toggle()
                        end)

                    end, false, false)

                end

            end

        end, false, false)
        
    end)

    local CloakroomDanse = Game.Zone("CloakroomDanseUnicorn")

    CloakroomDanse:Start(function()

        CloakroomDanse:SetTimer(1000)
        CloakroomDanse:SetCoords(vector3(107.62177276611, -1304.6292724609, 28.768808364868))

        CloakroomDanse:IsPlayerInRadius(8.0, function()
            CloakroomDanse:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "unicorn" then

                CloakroomDanse:Marker()

                CloakroomDanse:Text("Appuyez sur [E] pour vous changer.")
                CloakroomDanse:IsPlayerInRadius(2.0, function()

                    CloakroomDanse:KeyPressed("E", function()
                        CloakroomDanse_menu:Toggle()
                    end)

                end)

            end

        end, false, false)
    end)

    local ArmoryUnicorn = Game.Zone("ArmoryUnicornZone")

    ArmoryUnicorn:Start(function()

        ArmoryUnicorn:SetTimer(1000)
        ArmoryUnicorn:SetCoords(Config["Unicorn"]["ArmoryPos"])

        ArmoryUnicorn:IsPlayerInRadius(8.0, function()
            ArmoryUnicorn:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name
            local grade = playerData.job.grade

            if job == "unicorn" then

                if grade >= Config["Unicorn"]["VideurAcces"] then

                    if isInService then

                        ArmoryUnicorn:Marker()

                        ArmoryUnicorn:Text("Appuyez sur [E] pour vous equiper.")
                        ArmoryUnicorn:IsPlayerInRadius(2.0, function()

                            ArmoryUnicorn:KeyPressed("E", function()
                                armory_menu:Toggle()
                            end)

                        end, false, false)

                    end

                end

            end

        end, false, false)
        
    end)

    local GarageUnicorn = Game.Zone("ArmoryUnicornZone")

    GarageUnicorn:Start(function()

        GarageUnicorn:SetTimer(1000)
        GarageUnicorn:SetCoords(Config["Unicorn"]["Garage"])

        GarageUnicorn:IsPlayerInRadius(8.0, function()
            GarageUnicorn:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name
            local grade = playerData.job.grade

            if job == "unicorn" then

                if grade >= 0 then

                    if isInService then

                        GarageUnicorn:Marker()

                        GarageUnicorn:Text("Appuyez sur [E] pour vous sortir un vehicule.")
                        GarageUnicorn:IsPlayerInRadius(2.0, function()

                            GarageUnicorn:KeyPressed("E", function()
                                garage_menu:Toggle()
                            end)

                        end, false, false)

                    end

                end

            end

        end, false, false)
        
    end)

    local DeleteZone = Game.Zone("DeleteUnicornZone")

    DeleteZone:Start(function()

        DeleteZone:SetTimer(1000)
        DeleteZone:SetCoords(Config["Unicorn"]["DeleteCar"])

        DeleteZone:IsPlayerInRadius(60, function()
            DeleteZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            if job == "unicorn" then

                DeleteZone:Marker(nil, nil, 3.0)

                DeleteZone:IsPlayerInRadius(8.0, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule")

                    DeleteZone:KeyPressed("E", function()
                        local ped = PlayerPedId()
                        local vehicle = GetVehiclePedIsIn(ped, false)

                        TaskLeaveVehicle(ped, vehicle, 0)
                        SetTimeout(2000, function()
                            DeleteEntity(vehicle)
                        end)
                    end)

                end, false, true)

            end

        end, false, true)

    end)

    local BossActionZone = Game.Zone("BossActionUnicornZone")

    BossActionZone:Start(function()

        BossActionZone:SetTimer(1000)
        BossActionZone:SetCoords(Config["Unicorn"]["BossAction"])

        BossActionZone:IsPlayerInRadius(8.0, function()
            BossActionZone:SetTimer(0)
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name
            local grade = playerData.job.grade

            if job == "unicorn" then

                if grade >= 3 then

                    BossActionZone:Marker()

                    BossActionZone:Text("Appuyez sur [E] pour gérer l'entreprise.")
                    BossActionZone:IsPlayerInRadius(2.0, function()

                        BossActionZone:KeyPressed("E", function()
                            ESX.OpenSocietyMenu("unicorn")
                        end)

                    end, false, false)

                end

            end

        end, false, false)
        
    end)

end)

-- Menu F6 Vanilla Unicorn
main_menu:IsVisible(function(Items)

    if isInService then

        Items:Separator("[ Employé  : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" ..GetPlayerName(PlayerId()).."~s~ | Grade : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..ESX.PlayerData.job.grade_label.."~s~ ]")

	    Items:Line()

        Items:List("Annonces Simple", UnicornStatus.UnicornStatusList, UnicornStatus.UnicornStatusListIndex, nil, {}, true, {
            onListChange = function(index)
                UnicornStatus.UnicornStatusListIndex = index
            end,
            onSelected = function(index)
                if index == 1 then
                    TriggerServerEvent("CoreVrmtUhq:unicorn:sendOpenAnnounce")
                elseif index == 2 then
                    TriggerServerEvent("CoreVrmtUhq:unicorn:sendCloseAnnounce")
                elseif index == 3 then
                    TriggerServerEvent("CoreVrmtUhq:unicorn:sendRecruitAnnounce")
                end
            end
        })
    
        Items:Button("Annonces Personnalisé", nil, {}, true, {
            onSelected = function()
                local text = tostring(Shared:KeyboardInput("Tapez votre annonces personnalisé (60 Caractere maximum) :", 60))
                if text then
                    TriggerServerEvent("CoreVrmtUhq:unicorn:sendCustomAnnounce", text)
                end
            end
        })
    
        Items:Line()
    
        Items:Button("Appliquer une facture", nil, {}, true, {
            onSelected = function()
                local montant = Shared:KeyboardInput("Montant de la facture :", 10)
                if tonumber(montant) == nil then
                    ESX.ShowAdvancedNotification('Notification', "Vanilla Unicorn", "Montant invalide veuillez entrez des caractere numérique entre 0 a 9", 'CHAR_CALL911', 8)
                    return false
                else
                    amount = (tonumber(montant))
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowAdvancedNotification('Notification', "Vanilla Unicorn", "Personne autour de vous", 'CHAR_CALL911', 8)
                    else
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'unicorn', 'Vanilla Unicorn', amount)
                    end
                end
            end
        })
    
        local playerData = ESX.GetPlayerData()
        local job = playerData.job.name
        local grade = playerData.job.grade
    
        local player, distance = ESX.Game.GetClosestPlayer()
        local isHandsUP = IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3)
    
        if job == "unicorn" then
    
            if grade >= Config["Unicorn"]["VideurAcces"] then
    
                Items:Button("Fouiller la personne", nil, {}, true, {
                    onSelected = function()
                        if player ~= -1 and distance <= 5.0 then
                            if isHandsUP then
                                ExecuteCommand("me fouille l'individu")
                                TriggerServerEvent("CoreVrmtUhq:unicorn:requestInventory", GetPlayerServerId(closestPlayer))
                            else
                                ESX.ShowNotification("La personne en face ne lève pas les mains")
                            end
                        else
                            ESX.ShowNotification("Personne autour de vous")
                        end
                    end
                }, loot_menu)
    
            end
    
        end

        Items:Line()

        Items:List("Danceuse", UnicornDanceuse.UnicornDanceuseList, UnicornDanceuse.UnicornDanceuseListIndex, nil, {}, true, {
            onListChange = function(index)
                UnicornDanceuse.UnicornDanceuseListIndex = index
            end,
            onSelected = function(index)
                if index == 1 then
                    TriggerServerEvent("CoreVrmtUhq:unicorn:startDance")
                elseif index == 2 then
                    TriggerServerEvent("CoreVrmtUhq:Unicorn:StopStrip")
                end
            end
        })
        
    else

        Items:Separator("")
        Items:Separator("Vous n'etes pas en Service")
        Items:Separator("")

    end

    if not (loot_menu:IsOpen()) then
        InventoryBlackMoney = {}
        InventoryItems = {}
        IventoryWeapon = {}
    end

end)

-- Pute qui dance
RegisterNetEvent("CoreVrmtUhq:Unicorn:StartStrip")
AddEventHandler("CoreVrmtUhq:Unicorn:StartStrip", function()
    local PedModel = GetHashKey("csb_stripper_01")
    RequestModel(PedModel)
    while not HasModelLoaded(PedModel) do
        Wait(10)
    end
    Pnj = CreatePed(1, "csb_stripper_01", 100.90223693848, -1293.7604980469, 29.268459320068, 265.902+180, false, true)
    PedToNet(Pnj)
    SetEntityInvincible(Pnj, true)
    SetBlockingOfNonTemporaryEvents(Pnj, true)
    TaskGoToCoordAnyMeans(Pnj, 112.62257385254, -1287.0357666016, 28.888299942017)
    Wait(3000)
    RequestAnimDict("mini@strip_club@pole_dance@pole_dance3")
    while not HasAnimDictLoaded("mini@strip_club@pole_dance@pole_dance3") do
        Citizen.Wait(100)
    end
    Scene2 = CreateSynchronizedScene(112.62257385254, -1287.0357666016, 28.888299942017, vec3(0.0, 0.0, 0.0), 2)
    TaskSynchronizedScene(Pnj, Scene2, "mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", 1.0, -4.0, 261, 0, 0)
    SetSynchronizedSceneLooped(Scene1, 1)
    SetModelAsNoLongerNeeded(PedModel)
    EnDance = true
end)

RegisterNetEvent("CoreVrmtUhq:Unicorn:StopStrip")
AddEventHandler("CoreVrmtUhq:Unicorn:StopStrip", function()
    ClearPedTasksImmediately(PedModel)
    TaskGoToCoordAnyMeans(PedModel, 100.90223693848, -1293.7604980469, 29.268459320068, 265.902+180, 0, 0, 786603, 1.0)
    Wait(5000)
    DeleteEntity(PedModel)
	EnDance = false
end)

-- Bar Vanilla Unicorn
bar_menu:IsVisible(function(Items)

    for k,v in pairs(Config["Unicorn"]["UnicornBarShop"]) do

        Items:Button(v.label, "Apres l'achat de l'items ~b~"..v.label.."~s~ le coffre de la societé sera debité de ~g~"..v.price.."$", {}, true, {
            onSelected = function()
                TriggerServerEvent("CoreVrmtUhq:unicorn:buyItem", v.item, v.price)
            end
        })

    end

end)

-- Tenue Vanilla Unicorn Videur
local function setUniformVideur(type)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config["Unicorn"]["UniformVideur"][type].male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config["Unicorn"]["UniformVideur"][type].female)
		end
	end)
end

CloakroomProtect_menu:IsVisible(function(Items)
    Items:Button("Prendre sa tenue de Videur", nil, {}, true, {
        onSelected = function()  
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            setUniformVideur("Uniforms")
            TriggerServerEvent("CoreVrmtUhq:job:takeService", "unicorn", true)
            ESX.ShowNotification("Vous avez pris votre service de Videur")
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
            TriggerServerEvent("CoreVrmtUhq:job:takeService", "unicorn", false)
            ESX.ShowNotification("Vous avez quitter votre service")
            isInService = false
        end
    })
end)

-- Danseur/euse Vanilla Unicorn
local function setUniformDanse(type)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config["Unicorn"]["UniformDanse"][type].male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config["Unicorn"]["UniformDanse"][type].female)
		end
	end)
end

CloakroomDanse_menu:IsVisible(function(Items)
    Items:Button("Prendre sa tenue de Danse", nil, {}, true, {
        onSelected = function()  
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name

            setUniformDanse("Uniforms")
            TriggerServerEvent("CoreVrmtUhq:job:takeService", "unicorn", true)
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
            TriggerServerEvent("CoreVrmtUhq:job:takeService", "unicorn", false)
            ESX.ShowNotification("Vous avez quitter votre service")
            isInService = false
        end
    })
end)

-- ArmoryPos Vanilla Unicorn
armory_menu:IsVisible(function(Items)

    for k,v in pairs(Config["Unicorn"]["ArmoryWeapon"]) do

        Items:Button(v.label, nil, {}, true, {
            onSelected = function()
                local playerData = ESX.GetPlayerData()
                local job = playerData.job.name
                local grade = playerData.job.grade
    
                if job == "unicorn" then
    
                    if grade >= Config["Unicorn"]["VideurAcces"] then
    
                        if isInService then
    
                            TriggerServerEvent('unicorn:payWeapon', v.weapon)
    
                        end
    
                    end
    
                end
            end
        })

    end

    Items:Button("Prendre un gilet par balle", nil, {}, true, {
        onSelected = function()
            local playerData = ESX.GetPlayerData()
            local job = playerData.job.name
            local grade = playerData.job.grade

            if job == "unicorn" then

                if grade >= Config["Unicorn"]["VideurAcces"] then

                    if isInService then

                        TriggerServerEvent("CoreVrmtUhq:unicorn:takeVest")

                    end

                end

            end

        end
    })

end)

-- Garage Vanilla Unicorn
garage_menu:IsVisible(function(Items)
    local playerData = ESX.GetPlayerData()
    local grade = playerData.job.grade

    for k, v in pairs(Config["Unicorn"]["GarageVehicle"]) do
        if tonumber(grade) >= tonumber(v.grade) then
            Items:Button(v.label, nil, { RightLabel = "→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("CoreVrmtUhq:unicorn:spawnVehicle", v.vehicle, v.label)
                    garage_menu:Close()
                end
            })
        end
    end
end)

loot_menu:IsVisible(function(Items)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local getPlayerSearch = GetPlayerPed(closestPlayer)
    local isHandsUP = IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3)

    if isHandsUP then
        if closestPlayer ~= -1 and closestDistance < 5.0 then

            if next(InventoryBlackMoney) ~= nil or next(InventoryItems) ~= nil or next(IventoryWeapon) ~= nil then

                if next(InventoryBlackMoney) ~= nil then
                    Items:Separator("↓ Argent non déclaré ↓")

                    for k,v in pairs(InventoryBlackMoney) do
                        Items:Button("Argent non déclaré :", nil, {RightLabel = ""..v.label.." ~g~$"}, true, {
                            onSelected = function()
                                local money = tostring(Shared:KeyboardInput("Somme a confisqué ? (Somme: "..v.label.."~g~ $~s~)", 7))
                                if (Shared:InputIsValid(money, "number")) then
                                    if tonumber(money) > 1 then
                                        if v.label >= tonumber(money) then
                                            v.label = v.label - tonumber(money)
                                            TriggerServerEvent("CoreVrmtUhq:unicorn:takeItem", GetPlayerServerId(closestPlayer),  v.itemType, v.value, tonumber(money))
                                        end
                                    else
                                        ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                    end
                                end
                            end
                        })
                    end

                else
                    Items:Separator("Chargement de l'argent..")
                end

                Items:Separator("↓ Items ↓")
                if next(InventoryItems) ~= nil then

                    for k,v in pairs(InventoryItems) do
                        if v.count > 0 then
                            Items:Button("Nom: "..v.label, nil, {RightLabel = ""..v.count.." exemplaires"}, true , {
                                onSelected = function()
                                    local item = tostring(Shared:KeyboardInput("Somme a prendre ? (Somme: "..Shared:ServerColorCode()..""..v.count.."~s~)", 3))
                                    if (Shared:InputIsValid(item, "number")) then
                                        if tonumber(item) > 0 then
                                            if v.count <= 0 then
                                                table.remove(InventoryItems, k)
                                            else
                                                v.count = v.count - tonumber(item)
                                            end
                                            TriggerServerEvent("CoreVrmtUhq:unicorn:takeItem", GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(item))
                                        else
                                            ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                        end
                                    end
                                end
                            })
                        else
                            Items:Separator("l'inventaire est vide")
                        end
                    end

                else
                    Items:Separator("l'inventaire est vide")
                end

                Items:Separator("↓ Armes ↓")
                if next(IventoryWeapon) ~= nil then

                    for k,v in pairs(IventoryWeapon) do
                        local isPermanent = ESX.IsWeaponPermanent(v.value)

                        if not isPermanent then
                            Items:Button(""..v.label, nil, {}, true, {
                                onSelected = function()
                                    table.remove(IventoryWeapon, k)
                                    TriggerServerEvent("CoreVrmtUhq:unicorn:takeItem", GetPlayerServerId(closestPlayer),  v.itemType, v.value, 1)
                                end
                            })
                        else
                            Items:Button(""..v.label, "Vous pouvez pas prendre cette arme car elle est permanente", {}, false, {})
                        end

                    end

                else
                    Items:Separator("Aucune arme dans l'inventaire")
                end

            else
                Items:Separator("Chargement en cours..")
            end
        else
            InventoryBlackMoney = {}
            InventoryItems = {}
            IventoryWeapon = {}
            RageUI.GoBack()
        end
    else
        InventoryBlackMoney = {}
        InventoryItems = {}
        IventoryWeapon = {}
        RageUI.GoBack()
    end
end, nil, function()
    InventoryBlackMoney = {}
    InventoryItems = {}
    IventoryWeapon = {}
end)

-- Open Menu
Shared:RegisterKeyMapping("CoreVrmtUhq:unicorn:use", { label = "open_menu_interact" }, "F6", function()

    local playerData = ESX.GetPlayerData()
    local job = playerData.job.name

    if job == "unicorn" then

        main_menu:Toggle()

	end

end)