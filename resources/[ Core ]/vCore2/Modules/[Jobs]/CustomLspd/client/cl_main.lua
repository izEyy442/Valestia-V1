
local openCustomMenu = false

local PoliceCustom = {
    DefaultPrimaireColour = 1,
    DefaultSecondaireColour = 1,
    DefaultInteriorColour = 1,
    DefaultDashboardColour = 1,
    DefaultNacrageColour = 1,
    DefaultTypeRouesColour = 1,
    DefaultJantesPrincipales = 1,
    DefaultColourJantes = 1,
    DefaultKlaxon = 1,
    DefaultTeinteVitres = 1,
    DefaultTypesPlaques = 1,
    DefaultLivery = 1,
    DefaultColourPhares = 1,
    DefaultFrein = 1,
    DefaultMoteur = 1,
    DefaultTransmission = 1,
    DefaultSuspension = 1,

    DefaultAileron = 1,
    DefaultParechocAvant = 1,
    DefaultParechocArriere = 1,
    DefaultCarrosserie = 1,
    DefaultEchappement = 1,
    DefaultCadre = 1,
    DefaultCalandre = 1,
    DefaultCapot = 1,
    DefaultAutocollantGauche = 1,
    DefaultAutocollantDroit = 1,
    DefaultToit = 1,
    DefaultSupportPlaque = 1,
    DefaultPlaqueAvant = 1,
    DefaultFigurine = 1,
    DefaultDashboardMotif = 1,
    DefaultCadran = 1,
    DefaultHautParleurPortes = 1,
    DefaultMotifSieges = 1,
    DefaultVolant = 1,
    DefaultLevier = 1,
    DefaultLogoCustom = 1,
    DefaultHautParleurVitre = 1,
    DefaultHautParleurCoffre = 1,
    DefaultHydrolique = 1,
    DefaultVisualMoteur = 1,
    DefaultFiltresAir = 1,
    DefaultEntretoises = 1,
    DefaultCouverture = 1,
    DefaultAntenne = 1,
    DefaultStyle = 1,
    DefaultFenetre = 1,
    DefaultReservoir = 1,

    Price = 0,
    PriceExtra = 0,
    PricePrimary = 0,
    PriceSecondary = 0,
    PriceInterieurs = 0,
    PriceDashboard = 0,
    PriceNacrage = 0,
    PriceJantesPrincipales = 0,
    PriceWheelColor = 0,
    PriceKlaxon = 0,
    PricePharesXenons = 0,
    PricePlateIndex = 0,
    PriceLivery = 0,
    PriceColorPhares = 0,
    PriceAileron = 0,
    PriceParechocAvant = 0,
    PriceParechocArriere = 0,
    PriceCarrosserie = 0,
    PriceEchappement = 0,
    PriceCadre = 0,
    PriceCalandre = 0,
    PriceCapot = 0,
    PriceAutocollantGauche = 0,
    PriceAutocollantDroit = 0,
    PriceToit = 0,
    PriceSupportPlaque = 0,
    PricePlaqueAvant = 0,
    PriceFigurine = 0,
    PriceDashboardMotif = 0,
    PriceCadran = 0,
    PriceHautParleurPortes = 0,
    PriceMotifSieges = 0,
    PriceVolant = 0,
    PriceLevier = 0,
    PriceLogo = 0,
    PriceHautParleurVitre = 0,
    PriceHautParleurCoffre = 0,
    PriceHydrolique = 0,
    PriceVisualMoteur = 0,
    PriceFiltresAir = 0,
    PriceEntretoises = 0,
    PriceCouverture = 0,
    PriceAntenne = 0,
    PriceReservoir = 0,
    PriceFenetre = 0,
    PriceStyle = 0,
    PriceSuspension = 0,
    PriceTransmission = 0,
    PriceMoteur = 0,
    PriceFrein = 0,
    PriceTurbo = 0,

    ExtraList = {
        { id = 1, index = 1 },
        { id = 2, index = 1 },
        { id = 3, index = 1 },
        { id = 4, index = 1 },
        { id = 5, index = 1 },
        { id = 6, index = 1 },
        { id = 7, index = 1 },
        { id = 8, index = 1 },
        { id = 9, index = 1 },
        { id = 10, index = 1 },
        { id = 11, index = 1 },
        { id = 12, index = 1 },
        { id = 13, index = 1 },
        { id = 14, index = 1 },
        { id = 15, index = 1 },
        { id = 16, index = 1 },
        { id = 17, index = 1 },
        { id = 18, index = 1 },
        { id = 19, index = 1 },
        { id = 20, index = 1 },
    },
}

function GetModObjects(veh, mod)
	local int = {"Default"}
	for i = 0, tonumber(GetNumVehicleMods(veh, mod)) - 1 do
		local toBeInserted = i
		local labelName = GetModTextLabel(veh, mod, i)
		if labelName ~= nil then
			local name = tostring(GetLabelText(labelName))
			if name ~= "NULL" then
				toBeInserted = name
			end
		end
		int[#int + 1] = toBeInserted
	end

	return int
end

function GetMitrailVeh(TableCustoms)
    local mitraill = false

    for k, v in pairs(TableCustoms) do
        if string.match(v, "Mitraill") or string.match(v, "Gun") then
            mitraill = true
        end
    end
    return mitraill
end


function OpenLSPDCustom()
    local mainMenu = RageUI.CreateMenu('', 'Custom de la voiture')
    mainMenu.Closable = false

    subMenuRoues = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuCustom = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuExtra = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    PoliceCustom.Vehicle = GetVehiclePedIsIn(PlayerPedId())
    Wait(150)
    PoliceCustom.ColourPrimarySecondaryColourJantes = {}
    PoliceCustom.ColourIntDashNacrage = {}
    PoliceCustom.JantesPrincipales = {}
    PoliceCustom.JantesArrieres = {}
    PoliceCustom.MaxLivery = {}
    PoliceCustom.MaxKlaxon = {}
    PoliceCustom.CoulorPhares = {}
    for i = 1, 160, 1 do 
        table.insert(PoliceCustom.ColourPrimarySecondaryColourJantes, i) 
    end 
    for i = 1, 158, 1 do 
        table.insert(PoliceCustom.ColourIntDashNacrage, i) 
    end
    for i = 1, GetNumVehicleMods(PoliceCustom.Vehicle, 23) + 1, 1 do
        table.insert(PoliceCustom.JantesPrincipales, i) 
    end
    for i = 1, GetNumVehicleMods(PoliceCustom.Vehicle, 24) + 1, 1 do
        table.insert(PoliceCustom.JantesArrieres, i) 
    end
    for i = 1, GetVehicleLiveryCount(PoliceCustom.Vehicle), 1 do
        table.insert(PoliceCustom.MaxLivery, i) 
    end
    for i = 1, 59, 1 do 
        table.insert(PoliceCustom.MaxKlaxon, i) 
    end
    for i = 1, 12, 1 do 
        table.insert(PoliceCustom.CoulorPhares, i)
    end

    SetVehicleModKit(PoliceCustom.Vehicle, 0)

    Wait(150)

    while openCustomMenu do

        RageUI.IsVisible(mainMenu, function()

            RageUI.Button("Roues", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, {}, subMenuRoues)
            RageUI.Button("Custom", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, {}, subMenuCustom)
            RageUI.Button("Extras", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, {}, subMenuExtra)

            RageUI.Line()

            RageUI.Button("Sauvegarder et Quitter", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
                
                onSelected = function()
                    openCustomMenu = false
                end
            })
        end)

        RageUI.IsVisible(subMenuRoues, function()
            RageUI.List("Type de roues", {"Original", "Tout Terrain"}, PoliceCustom.DefaultTypeRouesColour, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultTypeRouesColour = Index
                    PoliceCustom.DefaultJantesPrincipales = 1

                    SetVehicleWheelType(PoliceCustom.Vehicle, PoliceCustom.DefaultTypeRouesColour - 1)

                    PoliceCustom.JantesLoadPrincipales = {}
                    PoliceCustom.JantesLoadArrieres = {}
                    for i = 1, GetNumVehicleMods(PoliceCustom.Vehicle, 23) + 1, 1 do
                        table.insert(PoliceCustom.JantesLoadPrincipales, i) 
                    end
                    PoliceCustom.JantesPrincipales = PoliceCustom.JantesLoadPrincipales
                end,
            })
            RageUI.List("Jantes principales", PoliceCustom.JantesPrincipales, PoliceCustom.DefaultJantesPrincipales, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultJantesPrincipales = Index

                    SetVehicleMod(PoliceCustom.Vehicle, 23, PoliceCustom.DefaultJantesPrincipales - 2, GetVehicleModVariation(PoliceCustom.Vehicle, 23))
                end,
            })
            RageUI.List("Couleurs des jantes", PoliceCustom.ColourPrimarySecondaryColourJantes, PoliceCustom.DefaultColourJantes, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultColourJantes = Index

                    local extraJantes = GetVehicleExtraColours(PoliceCustom.Vehicle)
                    SetVehicleExtraColours(PoliceCustom.Vehicle, extraJantes, PoliceCustom.DefaultColourJantes - 1)
                end,
            })
        end)

        RageUI.IsVisible(subMenuCustom, function()
            RageUI.List("Teinte des vitres", {"Normal", "Black", "Smoke Black", "Simple Smoke", "Stock"}, PoliceCustom.DefaultTeinteVitres, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultTeinteVitres = Index

                    SetVehicleWindowTint(PoliceCustom.Vehicle, PoliceCustom.DefaultTeinteVitres - 1)
                end,
            })
            if GetNumVehicleMods(PoliceCustom.Vehicle, 1) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 1)) then
                    RageUI.List("Pare-choc avant", GetModObjects(PoliceCustom.Vehicle, 1), PoliceCustom.DefaultParechocAvant, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultParechocAvant = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 1, PoliceCustom.DefaultParechocAvant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 2) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 2)) then
                    RageUI.List("Pare-choc arriére", GetModObjects(PoliceCustom.Vehicle, 2), PoliceCustom.DefaultParechocArriere, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultParechocArriere = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 2, PoliceCustom.DefaultParechocArriere - 2, false)
                        end,
                    })
                end
            end
        end)

        RageUI.IsVisible(subMenuExtra, function()
            if extraTable == nil then extraTable = {} end
            for i= 1, 20 do
                if DoesExtraExist(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                    if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                        RageUI.Button("Extra #"..i, nil, {}, true, {
                            onSelected = function()
                                if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                    extraTable[i] = true
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 0)
                                else
                                    extraTable[i] = false
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 1)
                                end
                            end
                        })
                    else
                        RageUI.Button("Extra #"..i, nil, { RightBadge = RageUI.BadgeStyle.Tick }, true, {
                            onSelected = function()
                                if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                    extraTable[i] = true
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 0)
                                else
                                    extraTable[i] = false
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 1)
                                end
                            end
                        })
                    end
                end
            end
        end)


        Wait(0)
    end
end

local ListVeh = {
    'LSPDscorcher',
    'nkcruiser',
    'nkbuffalos',
    'nkstx',
    'nktorrence',
    'code3bmw',
    'nkscout',
    'nkfugitive',
    'nkgranger2',
    'lspdbuffsumk',
    'lspdbuffalostxum',
    'poltaxi',
    'LSPDbus',
    'riot',
    'nkcaracara2',
    'nkcoquette',
    'nkomnisegt',
}

local function DrawiZeyyInstructionBarNotification(x, y, z, text)
	local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, false)

	if distance <= 6 then
		SetTextScale(0.35, 0.35)
		SetTextFont(10)
		SetTextProportional(1)
		SetTextColour(235, 235, 235, 215)
		SetTextEntry("STRING")
		SetTextCentre(true)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		local factor = (string.len(text)) / 370
		ClearDrawOrigin()
	end
end

CreateThread(function()
    while true do
        local Timer = 800

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade >= 0 then
            local plycrdjob = GetEntityCoords(PlayerPedId())
            local CustomPoliceCoords = vector3(-599.76306152344, -397.24597167969, 31.160076141357)
            local dist = #(CustomPoliceCoords - plycrdjob)
            
            if (dist < 10) then
                Timer = 0

                DrawMarker(6, -599.76306152344, -397.24597167969, 31.160076141357 -1, 1.0, 1.0, 90.0, 0, 0, 0, 3.0, 3.0, 3.0, 0, 131, 255, 155, 0, 0, 0, 0)
                DrawMarker(1, -599.76306152344, -397.24597167969, 31.160076141357 -3.5, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 0, 131, 255, 155, 0, 0, 0, 0)
                
                if (dist < 5 and not openCustomMenu) then
                    DrawiZeyyInstructionBarNotification(-599.76306152344, -397.24597167969, 31.160076141357 + 0.2, "Appuyez sur [~b~E~s~] pour accéder custom votre vehicule de police")
                    if IsControlJustPressed(1,51) then
                        CreateThread(function()
                            local IsVeh = false
                            for i=1, #ListVeh do
                                local vehicleModel = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))
                                local Name = GetDisplayNameFromVehicleModel(vehicleModel)
                                if (string.lower(ListVeh[i]) == string.lower(Name)) then
                                    IsVeh = true
                                end
                            end

                            if (IsVeh) then
                                openCustomMenu = true
                                OpenLSPDCustom()
                            end
                        end)
                    end
                end
            else
                if openCustomMenu then 
                    openCustomMenu = false
                    RageUI.CloseAll()
                end
            end

            if openCustomMenu and not IsPedInAnyVehicle(PlayerPedId(), false) then
                openCustomMenu = false
                RageUI.CloseAll()
            end

        end

        Wait(Timer)
    end
end)
