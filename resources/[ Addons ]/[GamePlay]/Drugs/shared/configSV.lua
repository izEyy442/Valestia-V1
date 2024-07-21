DrugsHandler.Settings = {
    PedSellHash = "s_m_m_bouncer_01",
    PedSellPosition = { --
        {pos = vector3(-2956.0654296875, 385.51504516602, 14.020688056946), heading = 259.798},
    },
}

DrugsHandler.Items = {
    ["Meth"] = {
        harvest = 40, -- Ajoute 5 de meth dans l'inventaire du joueur a chaque récolte.
        treatment = {40, 20}, -- [1] = 1ère valeur soit le nombre d'item(s) enlevé(s) au traitement, [2] = 2ème valeur soit le nombre d'item(s) ajouté(s) au joueur au traitement.
        resellPrice = 120
    },
    ["Weed"] = {
        harvest = 80,
        treatment = {80, 40},
        resellPrice = 240
    },
    ["Cocaïne"] = {
        harvest = 60,
        treatment = {60, 30},
        resellPrice = 170
    }
}

DrugsHandler.Upgrades = {
    ["Meth"] = {
        ["interior"] = {
            {name = "Avancé", value = "upgrade", price = 500000, desc = "Ajoutez une touche de modernité dans votre laboratoire, tout en étant équipé."}
        }
    },
    ["Weed"] = {
        ["interior"] = {
            {name = "Avancé", value = "upgrade", price = 350000, desc = "Ajoutez une touche de modernité dans votre laboratoire, tout en étant équipé."}
        },
        ["details"] = {
            {name = "Chaise", value = "weed_chairs", price = 22500, desc = "Ajoutez des chaises, pour pouvoir traiter votre récolte comme il se doit."}
        }
    },
    ["Cocaïne"] = {
        ["interior"] = {
            {name = "Avancé", value = "upgrade", price = 450000, desc = "Ajoutez une touche de modernité dans votre laboratoire, tout en étant équipé."}
        }
    }
}

DrugsHandler.Supplies = {
    ["Meth"] = {
        {name = "Matières premières", price = 6000, desc = "Ce lot contient différents éléments permettant la production de meth.\nDe la méthylamine, de l'acide sulfurique, de l'acétone, et du lithium."}
    },
    ["Weed"] = {
        {name = "Matières premières", price = 2500, desc = "Ce lot contient différents éléments permettant la production de weed sur un terrain.\nDe l'eau minérale (6.4PH), des graines de weeds, ainsi que de la terre fertile."}
    },
    ["Cocaïne"] = {
        {name = "Matières premières", price = 3500, desc = "Ce lot contient différents éléments permettant la production de cocaïne.\nDes feuilles de coca, du kérosène, paracétamol, glucoses."}
    }
}

DrugsHandler.Builds = {
    ["Meth"] = {
        Preview = "meth_labo",
        Labo = {
            {
                Index = 1,
                Price = 1500000,
                Entering = vector3(1887.552, 3913.489, 33.01824)
            }
        }
    },
    ["Weed"] = {
        Preview = "weed_labo",
        Labo = {
            {
                Index = 1,
                Price =  625000,
                Entering = vector3(-263.7796, 2196.29, 130.3989)
            }
        }
    },
    ["Cocaïne"] = {
        Preview = "coke_labo",
        Labo = {
            {
                Index = 1,
                Price = 850000,
                Entering = vector3(1075.438, -2330.212, 30.29385)
            }
        }
    }
}

DrugsHandler.Interiors = {
    ["Meth"] = {
        Position = {
            pos = vector3(997.54, -3200.58, -36.393),
            heading = 274.55
        },
        Harvest = {
            {pos = vector3(1005.80, -3200.40, -38.90)},
        },
        Treatment = vector3(1011.80, -3194.90, -38.99),
        Computer = vector3(1001.97, -3195.11, -38.99)
    },
    ["Weed"] = {
        Position = {
            pos = vector3(1065.97, -3183.45, -39.16),
            heading = 95.18
        },
        Harvest = {
            {pos = vector3(1051.658, -3196.057, -39.12837)},
            {pos = vector3(1051.605, -3190.533, -39.13086)},
            {pos = vector3(1056.194, -3189.949, -39.10868)},
            {pos = vector3(1062.883, -3193.293, -39.12915)},
            {pos = vector3(1063.073, -3198.179, -39.11026)},
            {pos = vector3(1063.658, -3204.737, -39.1482)},
            {pos = vector3(1057.423, -3205.962, -39.12839)},
            {pos = vector3(1057.647, -3199.784, -39.10919)},
            {pos = vector3(1051.781, -3205.776, -39.13504)}
        },
        Treatment = vector3(1039.759, -3204.596, -38.15),
        Computer = vector3(1044.22, -3194.85, -38.15)
    },
    ["Cocaïne"] = {
        Position = {
            pos = vector3(1088.67, -3187.83, -38.99),
            heading = 180.90
        },
        Harvest = {
            {pos = vector3(1090.54, -3196.65, -38.99)},
            {pos = vector3(1093.09, -3196.59, -38.99)},
            {pos = vector3(1095.34, -3196.65, -38.99)},
            {pos = vector3(1099.62, -3194.41, -38.99)},
            {pos = vector3(1101.75, -3193.77, -38.99)}
        },
        Treatment = vector3(1101.245, -3198.82, -39.60),
        Computer = vector3(1087.40, -3194.17, -38.99)
    }
}