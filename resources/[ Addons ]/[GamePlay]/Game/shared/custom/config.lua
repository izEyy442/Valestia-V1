--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

CustomHandler = {}
CustomHandler.ResetUpgrade = true 
CustomHandler.Upgrades = {}
CustomHandler.SetUpgrades = {}
CustomHandler.JobAllowed = "mecano" -- Job requis pour accéder au point de customisation 
CustomHandler.SocietyBilling = "society_mecano" -- Société devant payer les modifications effectuées sur le véhicule customisé 

CustomHandler.List = {
    CustomZones = { -- Zones d'intéractions pour le point de customisation 
        {position = vector3(-226.94,-1327.68,30.89)}
    },
    PriceOfXenon = 150, -- Prix des phares xénon
    PriceOfTurbo = 2000, -- Prix du turbo
    PriceOfSmoke = 500, -- Prix fumée des pneus
    PriceOfPlate = 250, -- Prix de la plaque
    PriceOfWindow = 400, -- Prix de la teinture des fenêtres 
    PriceOfNeon = 840, -- Prix des néons
    paintingsPrice = {
        ["primaryColor"] = 350, -- Prix peinture principale 
        ["secondaryColor"] = 270, -- Prix peinture secondaire
        ["pearlescentColor"] = 400, -- Prix nacrage  
        ["wheelColor"] = 125 -- Prix peinture roues 
    },
    vehicleClassMultiplier = { -- Multiplie le prix de base selon la catégorie du véhicule customisé 
        [0] = 1, -- Compacts
        [1] = 1, -- Sedans
        [2] = 1, -- SUVs
        [3] = 1, -- Coupes
        [4] = 1, -- Muscle
        [5] = 2, -- Sports Classics
        [6] = 3, -- Sports
        [7] = 4, -- Super
        [8] = 1, -- Motorcycles
        [9] = 1, -- Off-road
        [10] = 1, -- Industrial
        [11] = 1, -- Utility
        [12] = 1, -- Vans
        [13] = 1, -- Cycles
        [14] = 1, -- Boats
        [15] = 1, -- Helicopters
        [16] = 1, -- Planes
        [17] = 1, -- Service
        [18] = 1, -- Emergency
        [19] = 1, -- Military
        [20] = 1, -- Commercial
        [21] = 1, --Trains
    },
    Categories = { -- Nom des catégories, avec leur prix (catPrice)
        {name = "Aileron", modType = 0, catPrice = 200}, -- modifier le prix = modifier catPrice 
        {name = "Pare-choc avant", modType = 1, catPrice = 200},
        {name = "Pare-choc arrière", modType = 2, catPrice = 200},
        {name = "Bas de caisse", modType = 3, catPrice = 200},
        {name = "Pot d'échappement", modType = 4, catPrice = 200},
        {name = "Cage", modType = 5, catPrice = 200},
        {name = "Grille", modType = 6, catPrice = 200},
        {name = "Capot", modType = 7, catPrice = 200},
        {name = "Aile gauche", modType = 8, catPrice = 200},
        {name = "Aile droite", modType = 9, catPrice = 200},
        {name = "Toit", modType = 10, catPrice = 200},
        {name = "Klaxon", modType = 14, catPrice = 200},
        {name = "Roues", modType = 23, catPrice = 200},
        {name = "Contour Plaque", modType = 25, catPrice = 200},
        {name = "Plaque-Avant", modType = 26, catPrice = 200},
        {name = "Intérieurs", modType = 27, catPrice = 200},
        {name = "Décorations intérieures", modType = 28, catPrice = 200},
        {name = "Intérieur(s)", modType = 29, catPrice = 200},
        {name = "Tableau de bord", modType = 30, catPrice = 200},
        {name = "Portière(s)", modType = 31, catPrice = 200},
        {name = "Sièges", modType = 32, catPrice = 200},
        {name = "Volant", modType = 33, catPrice = 200},
        {name = "Levier de vitesse", modType = 34, catPrice = 200},
        {name = "Plaque", modType = 35, catPrice = 200},
        {name = "Enceintes", modType = 36, catPrice = 200},
        {name = "Coffre", modType = 37, catPrice = 200},
        {name = "Suspension hydraulique", modType = 38, catPrice = 200},
        {name = "Bloc moteur", modType = 39, catPrice = 200},
        {name = "Filtre à air", modType = 40, catPrice = 200},
        {name = "Jambe de suspension", modType = 41, catPrice = 200},
        {name = "Contour(s) phares", modType = 42, catPrice = 200},
        {name = "Antenne", modType = 43, catPrice = 200},
        {name = "Prise d'air", modType = 44, catPrice = 200},
        {name = "Réservoir", modType = 45, catPrice = 200},
        {name = "Déflécteur", modType = 46, catPrice = 200},
        {name = "UNK47", modType = 47, catPrice = 200},
        {name = "Autocollants", modType = 48, catPrice = 200}
    },
    Upgrade = { -- Catégories d'amélioration de performances (changement de prix = catPrice)
        {name = "Moteur", modType = 11, catPrice = 1000},
        {name  = "Frein", modType = 12, catPrice = 1000},
        {name  = "Transmission", modType = 13, catPrice = 1000},
        {name  = "Suspension", modType = 15, catPrice = 1000},
        {name  = "Armure", modType = 16, catPrice = 1000},
    },
    --- ↓ Ne pas toucher ↓ --- 
    SmokeColor = {
        {colorName = "Blanc", r = 255, g = 255, b = 255},
        {colorName = "Gris Ardoise", r = 112, g = 128, b = 144},
        {colorName = "Bleu", r = 0, g = 0, b = 255},
        {colorName = "Bleu Clair", r = 0, g = 150, b = 255},
        {colorName = "Bleu Marine", r = 0, g = 0, b = 128},
        {colorName = "Bleu Ciel", r = 135, g = 206, b = 235},
        {colorName = "Turquoise", r = 0, g = 245, b = 255},
        {colorName = "Vert Menthe", r = 50, g = 255, b = 155},
        {colorName = "Vert Citron", r = 0, g = 255, b = 0},
        {colorName = "Olive", r = 128, g = 128, b = 0},
        {colorName = "Jaune", r = 255, g = 255, b = 0},
        {colorName = "Or", r = 255, g = 215, b = 0},
        {colorName = "Orange", r = 255, g = 165, b = 0},
        {colorName = "Blé", r = 245, g = 222, b = 179},
        {colorName = "Rouge", r = 255, g = 0, b = 0},
        {colorName = "Rose", r = 255, g = 161, b = 211},
        {colorName = "Rose clair", r = 255, g = 0, b = 255},
        {colorName = "Violet", r = 153, g = 0, b = 153},
        {colorName = "Ivoire", r = 41, g = 36, b = 33}
    },
    Windows = {Index = 1, "Teinté", "Semi-Teinté", "Peu-Teinté", "Normal"},
    Plate = {Index = 1, "Noire & Jaune", "Bleu & Jaune","Blanche & Bleu"},
    listOfColors = {
        {label = "Noir"},
        {label = "Graphite"},
        {label = "Noir Métalisé"},
        {label = "Acier Fondu"},
        {label = "Argenté"},
        {label = "Gris Métallisé"},
        {label = "Acier Laminé"},
        {label = "Gris Foncé"},
        {label = "Gris Rocheux"},
        {label = "Gris Nuit"},
        {label = "Aluminium"},
        {label = "Noir Anthracite"},
        {label = "Noir Mat"},
        {label = "Gris Mat"},
        {label = "Gris Clair"},
        {label = "Nuit Sombre"},
        {label = "Noir Profond"},
        {label = "Gris Bitume"},
        {label = "Gris Béton"},
        {label = "Argent Sombre"},
        {label = "Magnésite"},
        {label = "Pétrole"},
        {label = "Argent"},
        {label = "Zinc"},
        {label = "dolomite"},
        {label = "Argent Bleuté"},
        {label = "Titane"},
        {label = "Rouge"},
        {label = "Rouge Turin"},
        {label = "Coquelicot"},
        {label = "Rouge Cuivré"},
        {label = "Rouge Cardinal"},
        {label = "Rouge Brique"},
        {label = "Grenat"},
        {label = "Pourpre"},
        {label = "Framboise"},
        {label = "Tangerine"},
        {label = "Or"},
        {label = "Orange"},
        {label = "Rouge Mat"},
        {label = "Rouge Foncé"},
        {label = "Orange Mat"},
        {label = "Jaune"},
        {label = "Rouge Pulpeux"},
        {label = "Rouge Brillant"},
        {label = "Cuivre"},
        {label = "Rouge Pale"},
        {label = "Marronclair"},
        {label = "Marron Foncé"},
        {label = "Vert Foncé"},
        {label = "Vert Rally"},
        {label = "Vert Sapin"},
        {label = "Vert Olive"},
        {label = "Vert Clair"},
        {label = "Topaze"},
        {label = "Vert Lime"},
        {label = "Vert Forêt"},
        {label = "Vert Pelouse"},
        {label = "Vert Impérial"},
        {label = "Vert Bouteille"},
        {label = "Bleu clair"},
        {label = "Bleu galaxy"},
        {label = "Bleu foncé"},
        {label = "Bleu azur"},
        {label = "Bleu marine"},
        {label = "Lapis lazuli"},
        {label = "Acier Bleue"},
        {label = "Bleu diamant"},
        {label = "Surfer"},
        {label = "Pastel"},
        {label = "Bleu celeste"},
        {label = "Indigo"},
        {label = "Violet Profond"},
        {label = "Bleu rally"},
        {label = "Bleu paradis"},
        {label = "Bleu nuit"},
        {label = "Violet Foncé"},
        {label = "Bleu cyan"},
        {label = "Cobalt"},
        {label = "Bleu electrique"},
        {label = "Bleu horizon"},
        {label = "Améthyste"},
        {label = "Bleu métallisé"},
        {label = "Aigue marine"},
        {label = "Bleu agathe"},
        {label = "Zirconium"},
        {label = "Spinelle"},
        {label = "Tourmaline"},
        {label = "Jaune Blé"},
        {label = "Jaune Rally"},
        {label = "Bronze"},
        {label = "Jaune Clair"},
        {label = "Vert Citrus"},
        {label = "Champagne"},
        {label = "Marron Métallisé"},
        {label = "Expresso"},
        {label = "Chocolat"},
        {label = "Terre Cuite"},
        {label = "Marbre"},
        {label = "Sable"},
        {label = "Sépia"},
        {label = "Bison"},
        {label = "Palmier"},
        {label = "Caramel"},
        {label = "Rouille"},
        {label = "Chataigne"},
        {label = "Vanille"},
        {label = "Crème"},
        {label = "Marron"},
        {label = "Noisette"},
        {label = "Coquillage"},
        {label = "Blanc"},
        {label = "Blanc Polair"},
        {label = "Beige"},
        {label = "Acajou"},
        {label = "Chaudron"},
        {label = "Blond"},
        {label = "Chrome Brossé"},
        {label = "Chrome Noir"},
        {label = "Aluminium Brossé"},
        {label = "Chrome"},
        {label = "Blanc Mat"},
        {label = "Neige"},
        {label = "Orange Clair"},
        {label = "Pèche"},
        {label = "Vert Anis"},
        {label = "Jaune Pâle"},
        {label = "Paradis"},
        {label = "Kaki"},
        {label = "Gravillon"},
        {label = "Citrouille"},
        {label = "Coton"},
        {label = "Albâtre"},
        {label = "Vert Army"},
        {label = "Blanc Pure"},
        {label = "Rose Electrique"},
        {label = "Rose Saumon"},
        {label = "Rose Dragée"},
        {label = "Orange Lambo"},
        {label = "Bubble gum"},
        {label = "Bleu minuit"},
        {label = "Violet Mystique"},
        {label = "Rouge Vin"},
        {label = "Gris Chasseur"},
        {label = "Violet Métallisé"},
        {label = "Bleu interdit"},
        {label = "Carbone"},
        {label = "Violet Mat"},
        {label = "Violet Profond Mat"},
        {label = "Volcano"},
        {label = "Vert Sombre"},
        {label = "Vert Chasseur"},
        {label = "Terre Foncé"},
        {label = "Désert"},
        {label = "Amarylisse"},
        {label = "Gris"},
        {label = "Bleu glacier"},
        {label = "Or Pure"},
        {label = "Or Brossé"},
        {label = "Or Clair"}
    },
    CatButtons = {
        {name = "Esthétiques" , subMenu = CustomAestheticMenu},
        {name = "Peintures", subMenu = CustomColorMenu},
        {name = "Améliorations des performances", subMenu = CustomUpgradeMenu},
        {name = "Fumée des pneus", subMenu = CustomTyreMenu},
        {name = "Extras", subMenu = CustomExtrasMenu},
        {name = "Liste des modifications", subMenu = CustomListMenu},
    },
    ModTypeValue = {
        ["modSpoilers"] = 0,
        ["modFrontBumper"] = 1,
        ["modRearBumper"] = 2,
        ["modSideSkirt"] = 3,
        ["modExhaust"] = 4,
        ["modFrame"] = 5,
        ["modGrille"] = 6,
        ["modHood"] = 7,
        ["modFender"] = 8,
        ["modRightFender"] = 9,
        ["modRoof"] = 10,
        ["modEngine"] = 11,
        ["modBrakes"] = 12,
        ["modTransmission"] = 13,
        ["modHorns"] = 14,
        ["modSuspension"] = 15,
        ["modArmor"] = 16,
        ["modTurbo"] = 18,
        ["modSmokeEnabled"] = 20,
        ["modXenon"] = 22,
        ["modFrontWheels"] = 23,
        ["modBackWheels"] = 24,
        ["modPlateHolder"] = 25,
        ["modVanityPlate"] = 26,
        ["modTrimA"] = 27,
        ["modOrnaments"] = 28,
        ["modDashboard"] = 29,
        ["modDial"] = 30,
        ["modDoorSpeaker"] = 31,
        ["modSeats"] = 32,
        ["modSteeringWheel"] = 33,
        ["modShifterLeavers"] = 34,
        ["modAPlate"] = 35,
        ["modSpeakers"] = 36,
        ["modTrunk"] = 37,
        ["modHydrolic"] = 38,
        ["modEngineBlock"] = 39,
        ["modAirFilter"] = 40,
        ["modStruts"] = 41,
        ["modArchCover"] = 42,
        ["modAerials"] = 43,
        ["modTrimB"] = 44,
        ["modTank"] = 45,
        ["modWindows"] = 46,
        ["modLivery"] = 48
    },
    XenonHeadlightCheckbox = false,
    EnableTurbo = false,
    SmokeColorCheckbox = false,
    NeonCheckbox = false
}