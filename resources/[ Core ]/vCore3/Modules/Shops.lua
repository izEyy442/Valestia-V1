Config["Shops"] = {};
Config["Shops"].list = {
    {
        label = "Supérette",
        categories = {
            ["food"] = { label = "Nourriture", placement = 1 },
            ["drink"] = { label = "Boisson", placement = 2 },
            -- ["objects"] = { label = "Objets", placement = 3 }

        },
        items = {
            
            ["bread"] = {
                cat = "food",
                label = "Pain",
                price = 20
            },

            ["water"] = {
                cat = "drink",
                label = "Bouteille d'eau",
                price = 20
            },

            -- ["phone"] = {
            --     cat = "objects",
            --     label = "Téléphone",
            --     price = 1500
            -- },
        },
        positions = {
            vector3(2557.45, 382.28, 108.42),
            vector3(-3038.93, 585.95, 7.7),
            vector3(-3241.92, 1001.46, 12.63),
            vector3(547.43, 2671.71, 41.95),
            vector3(1729.21, 6414.13, 34.83),
            vector3(2678.91, 3280.67, 55.04),
            vector3(1135.8, -982.28, 46.21),
            vector3(-1222.91, -906.98, 12.12),
            vector3(-1487.55, -379.10, 39.96),
            vector3(-707.40, -913.72, 19.21),
            vector3(1163.53, -323.75, 69.20),
            vector3(373.87, 325.89, 103.36),
            vector3(-1820.52, 792.51, 137.91),
            vector3(1698.38, 4924.40, 41.86),
            vector3(26.57, -1347.26, 29.49),
            vector3(-48.58, -1756.82, 29.42),
            vector3(1392.75, 3604.76, 34.98),
            vector3(-522.3742, 7562.1665, 6.5240), --roxwood
            vector3(-1228.2397460938, 6927.294921875, 20.475091934204)

        },
    },
    {
        label = "Ammu-Nation",
        blip = {
            sprite = 110,
            display = 4,
            scale = 0.7,
            color = 66,
            range = true
        },
        categories = {
            ["letal"] = { label = "Létale", placement = 1, licenses = { "weapon" } },
            ["melee"] = { label = "Mêlée", placement = 2 },
            ["accessories"] = { label = "Accessoires", placement = 3 }
        },
        items = {

            ["weapon"] = {
                type = "license",
                label = "Permis port d'armes",
                price = 250000
            },

            ["weapon_knife"] = {
                type = "weapon",
                cat = "melee",
                label = "Couteau",
                price = 10000
            },
            ["weapon_bat"] = {
                type = "weapon",
                cat = "melee",
                label = "Batte de baseball",
                price = 12500
            },
            ["weapon_machete"] = {
                type = "weapon",
                cat = "melee",
                label = "Machette",
                price = 15000
            },

            ["weapon_snspistol"] = {
                type = "weapon",
                cat = "letal",
                label = "Pétoire",
                price = 150000
            },
            ["weapon_pistol"] = {
                type = "weapon",
                cat = "letal",
                label = "Pistolet",
                price = 200000
            },

            ["clip"] = {
                cat = "accessories",
                label = "Chargeur",
                price = 5000
            },

            ["jumelles"] = {
                cat = "accessories",
                label = "Jumelles",
                price = 2500
            },

            ["kevlar"] = {
                cat = "accessories",
                label = "Kevlar Lourd",
                price = 120000
            },

            ["kevlarmid"] = {
                cat = "accessories",
                label = "Kevlar Medium",
                price = 70000
            },

            ["kevlarlow"] = {
                cat = "accessories",
                label = "Kevlar Léger",
                price = 50000
            },


        },
        positions = {
            vector3(-662.4192, -935.4647, 21.82921),
            vector3(810.5966, -2157.017, 29.61898),
            vector3(1693.578, 3759.426, 34.7053),
            vector3(-330.4556, 6083.456, 31.45476),
            vector3(251.9472, -49.86555, 69.94102),
            vector3(21.82369, -1107.19, 29.797),
            vector3(2568.004, 294.5252, 108.7348),
            vector3(-1117.884, 2698.496, 18.55412),
            vector3(842.4682, -1033.3, 28.19486),
            vector3(-1798.8354, 8376.4297, 36.2346), --roxwood
            vector3(-1305.939, -394.0775, 36.69574)
        }
    }
}