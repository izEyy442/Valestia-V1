Config["LTDShop"] = {}

Config["LTDShop"]["Items"] = {
    {label = "Pain", item = "bread", price = 20},
    {label = "Eau", item = "water", price = 10},
    {label = "Pizza", item = "pizza", price = 20},
    {label = "Chips", item = "chips", price = 10},
    {label = "Cacahuète", item = "cacahuete", price = 8},
    {label = "Crêpes", item = "crêpes", price = 14},
    {label = "Orangina", item = "orangina", price = 40},
    {label = "Coca-Cola", item = "coca", price = 40},
    {label = "Limonade", item = "limonade", price = 40},
    {label = "IceTea", item = "icetea", price = 40},
    {label = "Fanta", item = "fanta", price = 40},
    {label = "Biere", item = "beer", price = 40},
    {label = "Jus d'Orange", item = "orange_juice", price = 40},
    {label = "Telephone", item = "phone", price = 1900},
    {label = "Radio", item = "radio", price = 400},
    {label = "Jumelles", item = "jumelles", price = 300},
    {label = "Boom Box", item = "boombox", price = 600},
    {label = "Canne a Peche", item = "fishingrod", price = 300},
}

Config["LTDShop"]["AllowedJob"] = {
    -- "ltd",
    -- "ltd2",
    "ltd3",
}

Config["LTDShop"]["Announce"] = {
    ["open"] = {
        -- ["ltd"] = "Le LTD de Little Seoul est désormais ouvert",
        -- ["ltd2"] = "Le LTD de Mirror Park est désormais ouvert",
        ["ltd3"] = "Le LTD de la Place Central est désormais ouvert",
    },
    ["close"] = {
        -- ["ltd"] = "Le LTD de Little Seoul est désormais fermer",
        -- ["ltd2"] = "Le LTD de Mirror Park est désormais fermer",
        ["ltd3"] = "Le LTD de la Place Central est désormais fermer",
    },
    ["recruitment"] = {
        -- ["ltd"] = "Le LTD de Little Seoul recrute des personnes rendez-vous au magasin",
        -- ["ltd2"] = "Le LTD de Mirror Park recrute des personnes rendez-vous au magasin",
        ["ltd3"] = "Le LTD de la Place Central recrute des personnes rendez-vous au magasin",
    }
}

Config["LTDShop"]["Blips"] = {
    -- {label = "[Entreprise] Ltd Little Seoul", sprite = 52, color = 1, position = vector3(-711.9003, -913.7907, 19.2156)},
    -- {label = "[Entreprise] Ltd Miror Park", sprite = 52, color = 1, position = vector3(1160.698, -324.2319, 69.20515)},
    {label = "[Entreprise] Ltd de la Place Central", sprite = 52, color = 1, position = vector3(242.46594238281, -902.13262939453, 29.622999191284)},
}

Config["LTDShop"]["JobPos"] = {
    -- {position = vector3(1165.414, -323.7688, 69.20515), job = "ltd2"},
    -- {position = vector3(1165.063, -322.0547, 69.20515), job = "ltd2"},
    -- {position = vector3(-705.6259, -913.1784, 19.2156), job = "ltd"},
    -- {position = vector3(-705.5605, -914.9172, 19.2156), job = "ltd"},
    {position = vector3(241.74267578125, -897.99792480469, 29.622999191284), job = "ltd3"},
    {position = vector3(239.79168701172, -897.37286376953, 29.622999191284), job = "ltd3"},
}

Config["LTDShop"]["Cloakroom"] = {
    -- {position = vector3(-709.5067, -907.0272, 19.2156), job = "ltd"},
    -- {position = vector3(1160.208, -316.8953, 69.20514), job = "ltd2"},
    {position = vector3(247.16940307617, -899.98626708984, 29.282011032104), job = "ltd3"},
}

Config["LTDShop"]["Chest"] = {
    -- {position = vector3(-709.3253, -904.2504, 19.2156), job = "ltd"},
    -- {position = vector3(1159.868, -314.2636, 69.20514), job = "ltd2"},
    {position = vector3(236.17288208008, -905.4892578125, 29.622980117798), job = "ltd3"},
}
Config["LTDShop"]["BossAction"] = {
    -- {position = vector3(-705.6313, -905.3317, 19.2156), job = "ltd"},
    -- {position = vector3(1163.832, -314.1656, 69.20506), job = "ltd2"},
    {position = vector3(241.21379089355, -905.13177490234, 29.622983932495), job = "ltd3"},
}

Config["LTDShop"]["Uniform"] = {
    Uniforms = {
        male = {
            ['bags_1'] = -1, ['bags_2'] = 0,
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 982, ['torso_2'] = 1,
            ['arms'] = 0,
            ['pants_1'] = 38, ['pants_2'] = 0,
            ['shoes_1'] = 21, ['shoes_2'] = 0,
            ['mask_1'] = -1, ['mask_2'] = 0,
            ['bproof_1'] = -1,
            ['bags_1'] = -1, ['bags_2'] = 0,
            ['helmet_1'] = 259, ['helmet_2'] = 0,
            ["decals_1"] = -1, ["decals_2"] = 0,
            ['chain_1'] = -1, ['chain_2'] = 0,
        },
        female = {
            ['bags_1'] = -1, ['bags_2'] = 0,
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 1071, ['torso_2'] = 1,
            ['arms'] = 0,
            ['pants_1'] = 42, ['pants_2'] = 7,
            ['shoes_1'] = 21, ['shoes_2'] = 0,
            ['mask_1'] = -1, ['mask_2'] = 0,
            ['bproof_1'] = -1,
            ['bags_1'] = -1, ['bags_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ["decals_1"] = -1, ["decals_2"] = 0,
            ['chain_1'] = -1, ['chain_2'] = 0,
        }
    }
}