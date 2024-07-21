Config["FibJob"] = {}

Config["FibJob"]["Fine"] = {
	{label = 'Usage abusif du klaxon', price = 200},
	{label = 'Franchir une ligne continue', price = 50},
	{label = 'Circulation à contresens', price = 150},
	{label = 'Demi-tour non autorisé', price = 100},
	{label = 'Circulation hors-route', price = 250},
	{label = 'Stationnement gênant / interdit', price = 200},
	{label = 'Non-respect d\'un stop', price = 100},
	{label = 'Véhicule non en état', price = 500},
	{label = 'Conduite sans permis', price = 700},
	{label = 'Délit de fuite', price = 4200},
	{label = 'Excès de vitesse < 5 kmh', price = 625},
	{label = 'Excès de vitesse 5-15 kmh', price = 1250},
	{label = 'Excès de vitesse 15-30 kmh', price = 1875},
	{label = 'Excès de vitesse > 30 kmh', price = 2500},
	{label = 'Dégradation de la voie publique', price = 3750},
	{label = 'Trouble à l\'ordre publique', price = 3750},
	{label = 'Entrave opération de police', price = 7500},
	{label = 'Insulte envers / entre civils', price = 1250},
	{label = 'Menace verbale envers civil', price = 5000},
	{label = 'Menace verbale envers policier', price = 7500},
	{label = 'Manifestation illégale', price = 6250},
	{label = 'Tentative de corruption', price = 2500},
	{label = 'Arme blanche sortie en ville', price = 10000},
	{label = 'Arme léthale sortie en ville', price = 25000},
	{label = 'Port d\'arme illégal', price = 50000},
	{label = 'Pris en flag lockpick', price = 2500},
	{label = 'Vol de voiture', price = 3750},
	{label = 'Vente de drogue', price = 37500},
	{label = 'Fabrication de drogue', price = 50000},
	{label = 'Possession de drogue', price = 30000},
	{label = 'Prise d\'ôtage civil', price = 41250},
	{label = 'Prise d\'ôtage agent de l\'état', price = 62500},
	{label = 'Braquage supérette', price = 20000},
	{label = 'Braquage de banque', price = 50000},
	{label = 'Tir sur civil', price = 50000},
	{label = 'Tir sur agent de l\'état', price = 62500},
	{label = 'Tentative de meurtre sur civil', price = 50000},
	{label = 'Tentative de meurtre sur agent', price = 62500},
	{label = 'Meurtre sur civil', price = 62500},
	{label = 'Meurte sur agent de l\'état', price = 75000},
}

Config["FibJob"]["MaxProps"] = 14

Config["FibJob"]["BossAction"] = vector3(2486.7341308594, -410.22579956055, 99.112205505371)
Config["FibJob"]["Armory"] = vector3(2524.781, -332.610, 101.893)
Config["FibJob"]["Garage"] = vector3(2540.183, -350.771, 92.993)
Config["FibJob"]["Cloakroom"] = vector3(2517.192, -345.211, 101.893)
Config["FibJob"]["SeizedTrunk"] = vector3(2521.338, -325.253, 101.893)
Config["FibJob"]["GarageSpawn"] = vector3(2540.604, -358.337, 92.993)
Config["FibJob"]["GarageHeading"] = 312.610
Config["FibJob"]["DeleteCar"] = vector3(-481.987, 6024.247, 31.34039)
Config["FibJob"]["CellZone"] = vector3(2507.924, -351.879, 105.690)
Config["FibJob"]["CellRadius"] = 30
Config["FibJob"]["CellEnd"] = vector3(2505.293, -384.332, 94.120)

Config["FibJob"]["SeizedTrunkAcess"] = 5

Config["FibJob"]["ArmoryWeapon"] = {
	{label = "Tazer", weapon = "weapon_stungun", grade = 0},
	{label = "Lampe torche", weapon = "weapon_flashlight", grade = 0},
	{label = "Matraque", weapon = "weapon_nightstick", grade = 0},
	{label = "Pistolet de combat", weapon = "weapon_combatpistol", grade = 1},
	{label = "Carabine d'assault", weapon = "weapon_carbinerifle", grade = 5},
    {label = "Fusil à pompe", weapon = "weapon_pumpshotgun", grade = 4},
}

Config["FibJob"]["CellTimeMin"] = 5
Config["FibJob"]["CellTimeMax"] = 15

Config["FibJob"]["Cell"] = {
	{label = "Cellule #1", position = vector3(2503.682, -352.936, 105.690)},
	{label = "Cellule #2", position = vector3(2506.414, -356.048, 105.690)},
	{label = "Cellule #3", position = vector3(2511.966, -350.403, 105.690)},
	{label = "Cellule #4", position = vector3(2509.435, -347.879, 105.690)},
}

Config["FibJob"]["GarageVehicle"] = {
	{label = "Buffalo banalisé", vehicle = "lspdbuffsumk", grade = 0},
    {label = "Buffalo banalisé 2", vehicle = "lspdbuffalostxum", grade = 0},
    {label = "Granger", vehicle = "USMSGranger", grade = 0},
    {label = "Buffalo", vehicle = "USMSBuffalo", grade = 0},
    {label = "Merit", vehicle = "USMSMerit", grade = 0},
    {label = "Patriot", vehicle = "USMSPatriot", grade = 0},
    {label = "Coach", vehicle = "USMSCoach", grade = 0},
    {label = "Washington", vehicle = "USMSWashington", grade = 0},
    {label = "Rumpo", vehicle = "USMSRumpo", grade = 0},
}

Config["FibJob"]["Uniform"] = {
	recruit = {
        male = {
            ['tshirt_1'] = 0,  ['tshirt_2'] = 1,
            ['torso_1'] = 810,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 172,
            ['pants_1'] = 0,   ['pants_2'] = 1,
            ['shoes_1'] = 9,   ['shoes_2'] = 0,
            ['chain_1'] = 347,    ['chain_2'] = 0,
            ['bags_1'] = 137,     ['bags_2'] = 0,
            ['bproof_1'] = 0,   ['bproof_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 340,  ['tshirt_2'] = 0,
            ['torso_1'] = 865,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 309,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 216,    ['chain_2'] = 0,
            ['bags_1'] = 120,     ['bags_2'] = 0,
        }
    },
    officer = {
        male = {
            ['tshirt_1'] = 0,  ['tshirt_2'] = 1,
            ['torso_1'] = 810,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 172,
            ['pants_1'] = 0,   ['pants_2'] = 1,
            ['shoes_1'] = 9,   ['shoes_2'] = 0,
            ['chain_1'] = 347,    ['chain_2'] = 0,
            ['bags_1'] = 137,     ['bags_2'] = 0,
            ['bproof_1'] = 0,   ['bproof_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 340,  ['tshirt_2'] = 0,
            ['torso_1'] = 865,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 309,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 216,    ['chain_2'] = 0,
            ['bags_1'] = 120,     ['bags_2'] = 0,
        }
    },
    sergeant = {
        male = {
            ['tshirt_1'] = 0,  ['tshirt_2'] = 1,
            ['torso_1'] = 810,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 172,
            ['pants_1'] = 0,   ['pants_2'] = 1,
            ['shoes_1'] = 9,   ['shoes_2'] = 0,
            ['chain_1'] = 347,    ['chain_2'] = 0,
            ['bags_1'] = 137,     ['bags_2'] = 0,
            ['bproof_1'] = 0,   ['bproof_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 340,  ['tshirt_2'] = 0,
            ['torso_1'] = 865,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 309,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 216,    ['chain_2'] = 0,
            ['bags_1'] = 120,     ['bags_2'] = 0,
        }
    },
    sergeant_chief = {
        male = {
            ['tshirt_1'] = 0,  ['tshirt_2'] = 1,
            ['torso_1'] = 810,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 172,
            ['pants_1'] = 0,   ['pants_2'] = 1,
            ['shoes_1'] = 9,   ['shoes_2'] = 0,
            ['chain_1'] = 347,    ['chain_2'] = 0,
            ['bags_1'] = 137,     ['bags_2'] = 0,
            ['bproof_1'] = 0,   ['bproof_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 340,  ['tshirt_2'] = 0,
            ['torso_1'] = 865,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 309,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 216,    ['chain_2'] = 0,
            ['bags_1'] = 120,     ['bags_2'] = 0,
        }
    },
    intendent = {
        male = {
            ['tshirt_1'] = 0,  ['tshirt_2'] = 1,
            ['torso_1'] = 810,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 172,
            ['pants_1'] = 0,   ['pants_2'] = 1,
            ['shoes_1'] = 9,   ['shoes_2'] = 0,
            ['chain_1'] = 347,    ['chain_2'] = 0,
            ['bags_1'] = 137,     ['bags_2'] = 0,
            ['bproof_1'] = 0,   ['bproof_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 340,  ['tshirt_2'] = 0,
            ['torso_1'] = 865,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 309,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 216,    ['chain_2'] = 0,
            ['bags_1'] = 120,     ['bags_2'] = 0,
        }
    },
    lieutenant = {
        male = {
            ['tshirt_1'] = 0,  ['tshirt_2'] = 1,
            ['torso_1'] = 810,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 172,
            ['pants_1'] = 0,   ['pants_2'] = 1,
            ['shoes_1'] = 9,   ['shoes_2'] = 0,
            ['chain_1'] = 347,    ['chain_2'] = 0,
            ['bags_1'] = 137,     ['bags_2'] = 0,
            ['bproof_1'] = 0,   ['bproof_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 340,  ['tshirt_2'] = 0,
            ['torso_1'] = 865,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 309,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 216,    ['chain_2'] = 0,
            ['bags_1'] = 120,     ['bags_2'] = 0,
        }
    },
    chef = {
        male = {
            ['tshirt_1'] = 0,  ['tshirt_2'] = 1,
            ['torso_1'] = 810,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 172,
            ['pants_1'] = 0,   ['pants_2'] = 1,
            ['shoes_1'] = 9,   ['shoes_2'] = 0,
            ['chain_1'] = 347,    ['chain_2'] = 0,
            ['bags_1'] = 137,     ['bags_2'] = 0,
            ['bproof_1'] = 0,   ['bproof_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 340,  ['tshirt_2'] = 0,
            ['torso_1'] = 865,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 309,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 216,    ['chain_2'] = 0,
            ['bags_1'] = 120,     ['bags_2'] = 0,
        }
    },
    boss = {
        male = {
            ['tshirt_1'] = 0,  ['tshirt_2'] = 1,
            ['torso_1'] = 810,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 172,
            ['pants_1'] = 0,   ['pants_2'] = 1,
            ['shoes_1'] = 9,   ['shoes_2'] = 0,
            ['chain_1'] = 347,    ['chain_2'] = 0,
            ['bags_1'] = 137,     ['bags_2'] = 0,
            ['bproof_1'] = 0,   ['bproof_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 340,  ['tshirt_2'] = 0,
            ['torso_1'] = 865,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 309,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 216,    ['chain_2'] = 0,
            ['bags_1'] = 120,     ['bags_2'] = 0,
        }
    },
    bullet = {
        male = {
            ['bproof_1'] = 90,   ['bproof_2'] = 3,
        },
        female = {
            ['bproof_1'] = 91,   ['bproof_2'] = 3,
        }
    },
	ungilet = {
		male = {
			['bproof_1'] = 0,  ['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = -1,  ['bproof_2'] = 0
		}
	},
}