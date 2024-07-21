--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

robberiesConfiguration = {

    reseller = {
        model = "a_m_y_business_02",
        waitingScenario = "WORLD_HUMAN_AA_SMOKE",
        busyScenario = "WORLD_HUMAN_CLIPBOARD",
        randomizeLocation = function()
            return robberiesConfiguration.reseller.locations[math.random(1,#robberiesConfiguration.reseller.locations)]
        end,
        locations = {
            {vector = vector3(569.09655761719, 2796.8266601563, 42.018283843994),heading = 276.6881103515625,},
        },
    },

    items = {
        ["TV"] = {name = "Téléviseur", resellerValue = 870, timeToTake = 10},
        ["CLOTHS"] = {name = "Vêtements", resellerValue = 213, timeToTake = 5},
        ["CLOTHSRICHE"] = {name = "Vêtements de Luxe", resellerValue = 609, timeToTake = 5},
        ["ECOMP"] = {name = "Composants électroniques", resellerValue = 48, timeToTake = 4},
        ["ORANGE"] = {name = "Fruits", resellerValue = 20, timeToTake = 2},
        ["TELEPHONE"] = {name = "iPhone", resellerValue = 85, timeToTake = 4},
        ["PORNO"] = {name = "Magasine Pornographique", resellerValue = 60, timeToTake = 1},
        ["PARFUM"] = {name = "Parfum Channel", resellerValue = 109, timeToTake = 3},
        ["TV4K60FPS"] = {name = "TV 4K 60FPS", resellerValue = 1100, timeToTake = 10},
        ["BOITEBIJOUX"] = {name = "Boite a Bijoux", resellerValue = 243, timeToTake = 10},
        ["PCPORTABLE"] = {name = "Asus Rog 144Hz", resellerValue = 158, timeToTake = 5},
        ["TABLEAU"] = {name = "Tableau Pablo Picasso", resellerValue = 426, timeToTake = 15},
        ["ECRANMAC"] = {name = "Ecran Mac", resellerValue = 150, timeToTake = 8},
        ["JAGUAR"] = {name = "Jaguar", resellerValue = 121, timeToTake = 5},
        ["PERCEUSE"] = {name = "Perceuse", resellerValue = 98, timeToTake = 6},
        ["DEVICE"] = {name = "Device", resellerValue = 380, timeToTake = 5},
        ["BOITEOUTILS"] = {name = "Boite a Outils", resellerValue = 182, timeToTake = 5},
        ["COMPRESSEUR"] = {name = "Compresseur", resellerValue = 243, timeToTake = 8},
        ["PEINTURE"] = {name = "Peinture", resellerValue = 109, timeToTake = 5},
        ["CHEVRE"] = {name = "Chevre Mécanique", resellerValue = 207, timeToTake = 5},
        ["ASPIRATEUR"] = {name = "Aspirateur Mécanique", resellerValue = 170, timeToTake = 6},
        ["BANSHEE"] = {name = "Tableau Banshee", resellerValue = 207, timeToTake = 5},
        ["OUTILS"] = {name = "Outils", resellerValue = 112, timeToTake = 5},
        ["FEUILLECASH"] = {name = "Feuille Cash", resellerValue = 197, timeToTake = 2},
        ["DOCUMENTS"] = {name = "Documents Labo", resellerValue = 95, timeToTake = 2},
        ["BILLET"] = {name = "Billet Cash Factory", resellerValue = 380, timeToTake = 2},
        ["BILLET1"] = {name = "Pile de Cash", resellerValue = 460, timeToTake = 5},
        ["BILLET2"] = {name = "Billet de Cash Factory", resellerValue = 125, timeToTake = 5},
        ["PRODUITCOC"] = {name = "Produit Cocaine", resellerValue = 69, timeToTake = 6},
        ["COCAINA"] = {name = "Cocaine", resellerValue = 78, timeToTake = 4},
        ["CANNA"] = {name = "Cannabis", resellerValue = 96, timeToTake = 2},
        ["CANNATRAIT"] = {name = "Cannabis traite", resellerValue = 61, timeToTake = 5},
        ["DISQUEDUR"] = {name = "Disque Dur", resellerValue = 62, timeToTake = 5},
        ["TABLEAUPAUVRE"] = {name = "Tableau Décoration", resellerValue = 147, timeToTake = 8},
        ["BROSSEADENTS"] = {name = "Brosse a dents", resellerValue = 20, timeToTake = 2},
        ["SECHECHEVEUX"] = {name = "Seche Cheveux", resellerValue = 50, timeToTake = 3},
        ["LIVRES"] = {name = "Livres", resellerValue = 74, timeToTake = 8},
        ["JACK"] = {name = "Bouteille de Jack", resellerValue = 94, timeToTake = 2},
    },

    houseRobRegen = 60, -- m
    houses = {
        -- Première maison
        {
            name = "Poor #1", 
            authority = "bcso",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 60,  -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856), 
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(-9.6128463745117, 6654.212890625, 31.700290679932), 
            objects = {
                {object = "TV", position = vector3(257.1346, -995.7486, -99.00864)},
                {object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864)},
                {object = "TV", position = vector3(262.5348, -1002.594, -99.00864)},
                {object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866)},
            },
        },

        -- Motel 1
        {
            name = "Motel #1", 
            authority = "police",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 60,  -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856), 
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(-812.63439941406, -980.78479003906, 14.161451339722), 
            objects = {
                {object = "TV", position = vector3(257.1346, -995.7486, -99.00864)},
                {object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864)},
                {object = "TV", position = vector3(262.5348, -1002.594, -99.00864)},
                {object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866)},
            },
        },

        -- Motel 3
        {
            name = "Motel #2", 
            authority = "police",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 60,  -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856), 
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(-1096.4398193359, -325.19491577148, 37.823669433594), 
            objects = {
                {object = "TV", position = vector3(257.1346, -995.7486, -99.00864)},
                {object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864)},
                {object = "TV", position = vector3(262.5348, -1002.594, -99.00864)},
                {object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866)},
            },
        },

        -- Nord Maison 1
        {
            name = "Nord #1", 
            authority = "bcso",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 60,  -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856), 
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(1674.7, 4681.23, 43.0554), 
            objects = {
                {object = "TV", position = vector3(257.1346, -995.7486, -99.00864)},
                {object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864)},
                {object = "TV", position = vector3(262.5348, -1002.594, -99.00864)},
                {object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866)},
            },
        },

        -- Nord Maison 2
        {
            name = "Nord #2", 
            authority = "bcso",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 60,  -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856), 
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(1639.286, 4879.404, 42.14068), 
            objects = {
                {object = "TV", position = vector3(257.1346, -995.7486, -99.00864)},
                {object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864)},
                {object = "TV", position = vector3(262.5348, -1002.594, -99.00864)},
                {object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866)},
            },
        },

        -- Nord Maison 3
        {
            name = "Nord #3", 
            authority = "bcso",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 90,  -- s
            interiorVector = vector3(346.4078, -1008.204, -99.19616), 
            exitVector = vector3(346.4414, -1012.916, -99.19616),
            outdoorVector = vector3(2566.722, 4283.192, 41.97382), 
            objects = {
                {object = "TV4K60FPS", position = vector3(338.2112, -996.6988, -99.19618)},
                {object = "CLOTHS", position = vector3(350.8822, -993.5962, -99.1961)},
                {object = "TABLEAUPAUVRE", position = vector3(347.1834, -998.0684, -99.19618)},
                {object = "BROSSEADENTS", position = vector3(347.2348, -994.2006, -99.19616)},
                {object = "SECHECHEVEUX", position = vector3(351.13, -999.2594, -99.19614)},
                {object = "PORNO", position = vector3(349.491, -997.4902, -99.1962)},
                {object = "LIVRES", position = vector3(345.3794, -997.0596, -99.19622)},
                {object = "JACK", position = vector3(342.3002, -1001.524, -99.19622)},
            },
        },

        -- Maison Riche 3
        {
            name = "Maison Nord", 
            authority = "bcso",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 60,  -- s
            interiorVector = vector3(265.2054, -1001.77, -99.00856), 
            exitVector = vector3(266.169, -1007.436, -101.0086),
            outdoorVector = vector3(1435.5925292969, 3657.0827636719, 34.377475738525), 
            objects = {
                {object = "TV", position = vector3(257.1346, -995.7486, -99.00864)},
                {object = "CLOTHS", position = vector3(259.9006, -1004.098, -99.00864)},
                {object = "TV", position = vector3(262.5348, -1002.594, -99.00864)},
                {object = "ECOMP", position = vector3(265.494, -995.7602, -99.00866)},
            },
        },

        -- Bureau Riche 1
        {
            name = "Bureau #1", 
            authority = "police",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 60,  -- s
            interiorVector =  vector3(-75.76, -824.05, 243.38),
            exitVector = vector3(-78.16, -833.54, 243.38),
            outdoorVector = vector3(-129.0316, -648.6616, 40.50116),
            objects = {
                {object = "TV4K60FPS", position = vector3(-69.90284, -808.3606, 243.3862)}, --
                {object = "CLOTHSRICHE", position = vector3(-78.27862, -812.5248, 243.386)}, --
                {object = "JAGUAR", position = vector3(-81.7245, -803.8906, 243.386)}, --
                {object = "ECRANMAC", position = vector3(-73.2182, -815.7464, 243.3858)}, --
                {object = "BOITEBIJOUX", position = vector3(-81.55038, -806.832, 243.386)}, --
                {object = "TABLEAU", position = vector3(-75.95762, -810.328, 243.3858)}, --
                {object = "ECRANMAC", position = vector3(-78.65768, -802.3368, 243.4008)}, --
            },
        },

        -- Cash Factory
        {
            name = "Cash Factory", 
            authority = "police",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 50,  -- s
            interiorVector =  vector3(1118.828, -3193.366, -40.39172),
            exitVector = vector3(1138.066, -3199.168, -39.66572),
            outdoorVector = vector3(66.065811157227, -1008.1539916992, 29.357421875),
            objects = {
                {object = "PCPORTABLE", position = vector3(1129.622, -3194.12, -40.39632)}, --
                {object = "OUTILS", position = vector3(1132.364, -3193.478, -40.3924)}, --
                {object = "FEUILLECASH", position = vector3(1138.232, -3196.974, -39.66566)}, --
                {object = "DOCUMENTS", position =  vector3(1138.146, -3193.772, -40.39424)}, --
                {object = "BILLET", position = vector3(1122.294, -3194.492, -40.39862)}, --
                {object = "BILLET1", position = vector3(1116.11, -3193.868, -40.39484)}, --
                {object = "BILLET2", position = vector3(1119.408, -3197.792, -40.3934)}, --
                {object = "BOITEOUTILS", position = vector3(1124.042, -3197.948, -40.39284)}, --
            },
        },

        -- Maison Riche 2
        {
            name = "Riche #2", 
            authority = "police",
            timeToGoToReseller = 10, -- minutes
            copsCalledAfter = 1,  -- s
            policeBlipDuration = 120, -- s
            maximumTime = 120,  -- s
            interiorVector =  vector3(-784.3764, 315.772, 187.9134),
            exitVector = vector3(-787.276, 315.7646, 187.9134),
            outdoorVector = vector3(-784.2752, 351.514, 87.99814),
            objects = {
                {object = "TV4K60FPS", position = vector3(-780.8774, 337.8312, 187.5458)}, --
                {object = "CLOTHSRICHE", position = vector3(-796.345, 328.3752, 190.7158)}, --
                {object = "ORANGE", position = vector3(-783.7184, 331.432, 187.313)}, --
                {object = "TELEPHONE", position = vector3(-793.3706, 342.2482, 187.1136)}, --
                {object = "TELEPHONE", position = vector3(-795.026, 321.9664, 187.3132)},
                {object = "PORNO", position = vector3(-796.241, 334.7748, 190.7158)}, --
                {object = "PARFUM", position = vector3(-805.5186, 332.3148, 190.716)}, --
                {object = "PCPORTABLE", position = vector3(-798.8718, 322.4496, 187.3132)}, --
                {object = "BOITEBIJOUX", position = vector3(-792.746, 327.9212, 187.3136)}, --
                {object = "TABLEAU", position = vector3(-792.5564, 331.6132, 190.7158)}, --
            },
        },
    },
}