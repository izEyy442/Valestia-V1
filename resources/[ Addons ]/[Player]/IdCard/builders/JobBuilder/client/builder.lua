local ESX = nil
local modEdit = false
local allJobs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    PlayerData = xPlayer
end)

RegisterNetEvent('jobbuilder:restarted', function(player)
    ESX.PlayerData = player
    PlayerData = player
end);

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local function JobBuilderKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

local JobBuilder = {
    Name = nil,
    Label = nil,
    PosVeh = nil,
    PosBoss = nil,
    PosCoffre = nil,
    PosSpawnVeh = nil,
    nameItemR = nil,
    labelItemR = nil,
    PosRecolte = nil,
    nameItemT = nil,
    labelItemT = nil,
    PosTraitement = nil,
    PosVente = nil,
    vehInGarage = {},
    PrixVente = nil,
    Confirm = nil,
    Confirm1 = nil,
    Confirm2 = nil,
    Confirm3 = nil,
    Confirm4 = nil,
    Confirm5 = nil,
    Confirm6 = nil,
    Confirm7 = nil,
    Confirm8 = nil,
    Choisimec = false,
}


local function menuJobBuilder()
    local MenuP = RageUIJob.CreateMenu('', 'Créer un job')
        MenuP.Closed = function()
            resetInfo()
        end
            RageUIJob.Visible(MenuP, not RageUIJob.Visible(MenuP))
            while MenuP do
                Citizen.Wait(0)

            RageUIJob.IsVisible(MenuP, true, true, true, function()

            RageUIJob.ButtonWithStyle("Nom du setjob",nil, {RightLabel = JobBuilder.Name}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.Name = JobBuilderKeyboardInput("Nom du job", "", 30)
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Nom ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Label du job",nil, {RightLabel = JobBuilder.Label}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.Label = JobBuilderKeyboardInput("Label du job", "", 30)
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Label ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Placer le point coffre",nil, {RightLabel = JobBuilder.Confirm}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosCoffre = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm = "✅"
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Point coffre ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Placer le point patron",nil, {RightLabel = JobBuilder.Confirm1}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosBoss = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm1 = "✅"
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Point menu boss ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Placer le point du garage",nil, {RightLabel = JobBuilder.Confirm2}, true, function(Hovered, Active, Selected)
                if Selected then

                    local coords = GetEntityCoords(PlayerPedId());

                    JobBuilder.PosVeh = coords;
                    JobBuilder.Confirm2 = "✅"
                    JobBuilder.Choisimec = true
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Point garage ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Placer le point de spawn véhicule",nil, {RightLabel = JobBuilder.Confirm3}, true, function(Hovered, Active, Selected)
                if Selected then

                    local coords = GetEntityCoords(PlayerPedId());
                    local heading = GetEntityHeading(PlayerPedId());

                    JobBuilder.PosSpawnVeh = vector4(coords.x, coords.y, coords.z, heading)
                    JobBuilder.Confirm3 = "✅"
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Position spawn véhicule ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Placer le point de rangement véhicule",nil, {RightLabel = JobBuilder.ConfirmDelete}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.vehInGarage = GetEntityCoords(PlayerPedId())
                    JobBuilder.ConfirmDelete = "✅"
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Position delete véhicule ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Farm  ~s~↓")

            RageUIJob.ButtonWithStyle("Nom de l'item récolte",nil, {RightLabel = JobBuilder.nameItemR}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.nameItemR = JobBuilderKeyboardInput("Nom de l'item récolte", "", 30)
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Item récolte ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Label de l'item récolte",nil, {RightLabel = JobBuilder.labelItemR}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.labelItemR = JobBuilderKeyboardInput("Label de l'item récolte", "", 30)
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Label de l'item récolte ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Position de la récolte",nil, {RightLabel = JobBuilder.Confirm6}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosRecolte = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm6 = "✅"
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Position de la récolte ajouté", time_display = 2500 })
                end
            end)


            RageUIJob.ButtonWithStyle("Nom de l'item traitement",nil, {RightLabel = JobBuilder.nameItemT}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.nameItemT = JobBuilderKeyboardInput("Nom de l'item traitement", "", 30)
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Nom de l'item traitement ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Label de l'item traitement",nil, {RightLabel = JobBuilder.labelItemT}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.labelItemT = JobBuilderKeyboardInput("Label de l'item traitement", "", 30)
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Label de l'item traitement ajouté", time_display = 2500 })

                end
            end)

            RageUIJob.ButtonWithStyle("Position du traitement",nil, {RightLabel = JobBuilder.Confirm4}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosTraitement = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm4 = "✅"
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Position du traitement ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Position de la vente",nil, {RightLabel = JobBuilder.Confirm5}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosVente = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm5 = "✅"
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Position de vente ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.ButtonWithStyle("Prix de la vente",nil, {RightLabel = JobBuilder.PrixVente}, true, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PrixVente = tonumber(JobBuilderKeyboardInput("Prix vente ?", "", 30))
                    RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Prix de vente ajouté", time_display = 2500 })
                end
            end)

            RageUIJob.Separator('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~↓ Actions ↓')

            RageUIJob.ButtonWithStyle("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Valider",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    if JobBuilder.vehInGarage == nil or JobBuilder.Name == nil or JobBuilder.Label == nil or JobBuilder.PosVeh == nil or JobBuilder.PosCoffre == nil or JobBuilder.PosBoss == nil or JobBuilder.PosSpawnVeh == nil or JobBuilder.nameItemR == nil or JobBuilder.labelItemR == nil or JobBuilder.PosRecolte == nil or JobBuilder.nameItemT == nil or JobBuilder.labelItemT == nil or JobBuilder.PosTraitement == nil then
                        RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Un ou plusieurs champs n\'ont pas été défini !", time_display = 2500 })
                    else
                        TriggerServerEvent('JobBuilder:addJob', JobBuilder)
                        RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Job ajoute avec succès !", time_display = 2500 })
                        resetInfo()
                        RageUIJob.CloseAll()
                    end
                end
            end)

            RageUIJob.ButtonWithStyle('~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annuler' , nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                resetInfo()
                RageUIJob.CloseAll()
                RageUIJob.Text({ message = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Annulé !", time_display = 2500 })
            end
        end)

        end, function()
        end)

        if not RageUIJob.Visible(MenuP) then
            MenuP = RMenu:DeleteType("MenuP", true)
        end
    end
end


RegisterCommand('createjob', function()
	ESX.TriggerServerCallback('JobBuilder:getUsergroup', function(plyGroup)
		if plyGroup ~= nil and (plyGroup == 'founder') then
            menuJobBuilder()
        else
            --print("Vous n'avez pas les permissions d'ouvrir le ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~JobsBuilder.")
        end
	end)
end, false)


function resetInfo()
    JobBuilder.Name = nil
    JobBuilder.Label = nil
    JobBuilder.PosVeh = nil
    JobBuilder.PosBoss = nil
    JobBuilder.PosCoffre = nil
    JobBuilder.PosSpawnVeh = nil
    JobBuilder.nameItemR = nil
    JobBuilder.labelItemR = nil
    JobBuilder.PosRecolte = nil
    JobBuilder.nameItemT = nil
    JobBuilder.labelItemT = nil
    JobBuilder.PosTraitement = nil
    JobBuilder.PosVente = nil
    JobBuilder.vehInGarage = {}
    JobBuilder.Confirm = nil
    JobBuilder.Confirm1 = nil
    JobBuilder.Confirm2 = nil
    JobBuilder.Confirm3 = nil
    JobBuilder.Confirm4 = nil
    JobBuilder.Confirm5 = nil
    JobBuilder.Confirm6 = nil
    JobBuilder.Confirm7 = nil
    JobBuilder.Confirm8 = nil
    JobBuilder.Choisimec = false
    JobBuilder.PrixVente = nil
end

local function menuGestJobs()
    local MenuGestion = RageUIJob.CreateMenu("", ' ')
    local MenuGestionSub = RageUIJob.CreateSubMenu(MenuGestion, "", ' ')
    RageUIJob.Visible(MenuGestion, not RageUIJob.Visible(MenuGestion))
    while MenuGestion do
        Citizen.Wait(0)

        RageUIJob.IsVisible(MenuGestion, true, true, true, function()

            RageUIJob.Checkbox("Activer/Désactiver le mode modification",nil, modEdit,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    modEdit = Checked
                    if Checked then
                        RageUIJob.Text({message = "Vous avez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Activer~s~ le mode modification !", time_display = 2500})
                    else
                        RageUIJob.Text({message = "Vous avez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Désactiver~s~ le mode modification !", time_display = 2500})
                    end
                end
            end)

    if modEdit then

        for k,v in pairs(allJobs) do

        RageUIJob.ButtonWithStyle("Entreprise : "..v.Label,nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            if Selected then
                jobSelect = v
            end
        end, MenuGestionSub)

        end
    end

        end, function()
        end)

        RageUIJob.IsVisible(MenuGestionSub, true, true, true, function()

            RageUIJob.ButtonWithStyle("Position du garage",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'Posgarage', plyPos, jobSelect.Name)
                end
            end)

            RageUIJob.ButtonWithStyle("Position spawn véhicule",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'Posspawn', plyPos, jobSelect.Name)
                end
            end)

            RageUIJob.ButtonWithStyle("Position du menu boss",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosBoss', plyPos, jobSelect.Name)
                end
            end)

            RageUIJob.ButtonWithStyle("Position du coffre",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosCoffre', plyPos, jobSelect.Name)
                end
            end)

            RageUIJob.ButtonWithStyle("Position de la récolte",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosRecolte', plyPos, jobSelect.Name)
                end
            end)

            RageUIJob.ButtonWithStyle("Position du traitement",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosTraitement', plyPos, jobSelect.Name)
                end
            end)

            RageUIJob.ButtonWithStyle("Position de la vente",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosVente', plyPos, jobSelect.Name)
                end
            end)

            RageUIJob.ButtonWithStyle("Prix de la vente",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local priceVenteNew = JobBuilderKeyboardInput("Prix de la vente ?", "", 30)
                    TriggerServerEvent('JobBuilder:editJob', 'PrixVente', tonumber(priceVenteNew), jobSelect.Name)
                end
            end)

        end, function()
        end)

        if not RageUIJob.Visible(MenuGestion) and not RageUIJob.Visible(MenuGestionSub) then
            MenuGestion = RMenu:DeleteType("MenuGestion", true)
        end
    end
end


RegisterCommand('gestionjob', function()
	ESX.TriggerServerCallback('JobBuilder:getUsergroup', function(plyGroup)
		if plyGroup ~= nil and (plyGroup == 'founder') then
            ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
                allJobs = result
            end)
            menuGestJobs()
        else
            --print("Vous n'avez pas les permissions de ouvrir le ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Gestion d'entreprise.")
        end
	end)
end, false)