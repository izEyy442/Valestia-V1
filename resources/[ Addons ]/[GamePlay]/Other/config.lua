Config = {
    ESX = "esx:getSharedObject",
    Liste = {
        {time = 1, text = "1 Heure", reward = 110000},
        {time = 2, text = "2 Heure", reward = 120000},
        {time = 3, text = "3 Heure", reward = 130000},
        {time = 5, text = "5 Heure", reward = 150000},
    },
    Marker = {
        Pos = vector3(258.57,-782.93,30.51),
        Type = 2,
        Size = {0.2, 0.2, 0.2},
        Color = {45,110,185},
        Rotation = 180.0,
    },
    Zone = vector3(139.1, -637.4, 261.8),
    zoneSizeProtection = 10,
    Catalogue = {
        Pos = vector3(-800.1241, -202.7614, 36.9975),
        PosPreview = vector3(-805.2227, -201.9496, 37.1612),
        Heading = 161.6410,
    },
    Plane = {
        Actions = {
            {actions = vector3(-970.6, -2941.2, 14.9)},
        },
    },
    Boat = {
        Actions = {
            {actions = vector3(-735.018, -1344.49, 1.571926)},
        },
    },
    Gouv = {
        PosBlip = vector3(-1291.361, -570.5316, 30.57272),
        Armurerie = vector3(100.23686981201, -1346.6044921875, 29.359008789062),
        Vestiaire = vector3(-405.8138, 1075.087, 334.9006),
        Items = {
            {label = "Gazeuse", weapon = "WEAPON_PEPPERSPRAY", price = 50},
            {label = "Antidote Gazeuse", weapon = "WEAPON_ANTIDOTE", price = 50},
            {label = "Mégaphone", weapon = "WEAPON_MEGAPHONE", price = 100},
            {label = "Tazer", weapon = "WEAPON_STUNGUN", price = 250},
            {label = "Pistolet de combat", weapon = "WEAPON_COMBATPISTOL", price = 800},
            {label = "M4", weapon = "WEAPON_CARBINERIFLE", price = 1000},
        },
        ListeVehicle = {
            {label = "OneBeast", model = "onebeast", grade = 0},
            {label = "4x4", model = "pressuv", grade = 2},
            {label = "Dubsta", model = "dubstavip", grade = 2},
            {label = "Oracle", model = "oraclevip", grade = 2},
            {label = "Rebla", model = "reblavip", grade = 2},
            {label = "Schafter", model = "schaftervip", grade = 2},
            {label = "Cog", model = "cogvip", grade = 2},
            {label = "Baller", model = "ballervip", grade = 2},
            {label = "Xls", model = "xlsvip", grade = 2},
            {label = "Buffalo", model = "fbi", grade = 5},
        },
        SortirVehicule = vector3(-406.2701, 1192.317, 325.6418),
        PosSortirVehicule = vector3(-399.5314, 1198.125, 325.6418),
        HeadingSortirVehicule = 163.664,
        RangerVehicle = vector3(-419.8509, 1202.555, 325.6418),
        BossActions = vector3(261.6325, 204.1563, 110.2874),
    },
    FastFood = {
        blips = vector3(0,0,0),
        cuisine = vector3(0,0,0),
    },
    -- Vda = {
    --     OrgaOK = "ballas",
    --     Weapons = {
    --         {label = "Pétoire", model = "weapon_snspistol", price = 144500, type = "weapon"},
    --         {label = "Pistolet", model = "weapon_pistol", price = 176000, type = "weapon"},
    --         {label = "Pistolet Lourd", model = "weapon_heavypistol", price = 204000, type = "weapon"},
    --         {label = "Calibre 50", model = "weapon_pistol50", price = 200000, type = "weapon"},
    --         {label = "Mini SMG", model = "weapon_minismg", price = 756500, type = "weapon"},
    --         {label = "Micro SMG", model = "weapon_microsmg", price = 807500, type = "weapon"},
    --         {label = "AK-Compact", model = "weapon_compactrifle", price = 2312000, type = "weapon"},
    --         {label = "Carte de sécurité", model = "id_card_f", price = 63750, type = "item"},
    --     },
    -- },
    Illegal = {
        PosPoint = vector3(216.3, -800.9, 30.7),
        TypeMoneyUse = 'dirtycash',
        Items = {
            {name = "Menottes", price = 5000, type = "item", togivename = "menottes"},
            {name = "GHB", price = 2000, type = "item", togivename = "ghb"},
            {name = "Kevlar", price = 5000, type = "item", togivename = "kevlar"},
            {name = "Couteau", price = 10000, type = "weapon", togivename = "weapon_knife"},
        },
    },
    Peche = {
        fishingRod = "fishingrod",

        availableFish = {
            {name = "saumon", label = "Saumon", price = 29},
            {name = "cabillaud", label = "Cabillaud", price = 38},
            {name = "sardine", label = "Sardine", price = 30},
            {name = "truite", label = "Truite", price = 25},
            {name = "thon", label = "Thon", price = 48},
            {name = "brochet", label = "Brochet", price = 67},
        },
    
        vendor = {
            position = vector3(-1158.7344970703, 4923.9272460938, 222.51731872559),
            blipActive = true,
            sprite = 480,
            color = 51,
            size = 0.9,
            name = "Acheteur de poisson",

        },
    
        blips = {
            name = "Zone de pêche",
            sprite = 762,
            color = 38,
            size = 0.9
        },
    
        fishingZones = {
            {
                zoneCenter = vector3(2073.23, 4554.31, 31.31),
                radius = 10.0,
                heading = 202.01
            },
        },
    },
}

ConfigBlip = {
    fishingZones = {
        {pos = vector3(2073.23, 4554.31, 31.31)},
    },
    vendor = {
        {pos = vector3(-1158.7344970703, 4923.9272460938, 222.51731872559)}
    }
}

Config['usingOldESX'] = true

Config['enableNuiIndicator'] = false

Config['admingroups'] = {
    "founder",
}

Config["strings"] = {
    ['open'] = "Appuyez sur ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[E] pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ouvrir la porte",
    ['close'] = "Appuyez sur ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~[E] pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~fermer la porte",
}