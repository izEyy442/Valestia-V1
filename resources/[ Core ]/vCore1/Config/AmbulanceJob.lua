Config["AmbulanceJob"] = {}

Config["AmbulanceJob"]["RespawnTime"] = 300 -- secondes

Config["AmbulanceJob"]["RespawnPosition"] = {
    vector3(-1862.4909667969, -353.04922485352, 49.24609375),
    vector3(1839.448, 3672.506, 34.27676),
    vector3(-248.1505, 6331.917, 32.42622)
}

Config["AmbulanceJob"]["PharmacyShop"] = {
    {label = "Bandage", item = "bandage", price = 500, utility = "small"},
    {label = "Medikit", item = "medikit", price = 1250, utility = "big"},
    {label = "DÃ©fibrillateur", item = "defibrillateur", price = 2000, utility = "resuscitation"}
}

Config["AmbulanceJob"]["Price"] = {
    ["small"] = 1000,
    ["big"] = 2500,
    ["resuscitation"] = 4000
}

Config["AmbulanceJob"]["Garage"] = vector3(-1885.8801269531, -301.38208007812, 49.218570709229)
Config["AmbulanceJob"]["GarageSpawn"] = vector3(-1898.2557373047, -302.16693115234, 49.277523040771)
Config["AmbulanceJob"]["GarageHeading"] = 56.340370178222656
Config["AmbulanceJob"]["DeleteCar"] = vector3(-1899.6578369141, -332.55065917969, 49.231739044189)
Config["AmbulanceJob"]["BossAction"] = vector3(-1845.5028076172, -347.49920654297, 84.019660949707)
Config["AmbulanceJob"]["Cloakroom"] = vector3(-1815.2126464844, -356.03726196289, 49.462463378906)
Config["AmbulanceJob"]["Pharmacy"] = vector3(-1864.4024658203, -321.01403808594, 49.456958770752)
Config["AmbulanceJob"]["DoctorPed"] = vector3(-1847.2344970703, -340.46246337891, 48.447402954102)
Config["AmbulanceJob"]["DoctorPedHeading"] = 136.2335968017578
Config["AmbulanceJob"]["RespawnDoctorPosition"] = vector3(-1859.1906738281, -348.81875610352, 49.387924194336)
Config["AmbulanceJob"]["Cooldown"] = 10 -- secondes

Config["AmbulanceJob"]["GarageVehicle"] = {
    {label = "Baller SAMS", vehicle = "nkballer7ems", grade = 0},
    {label = "Granger SAMS", vehicle = "nkgranger2ems", grade = 0},
    {label = "Ambulance Box SAMS", vehicle = "nkambulance", grade = 0},
    {label = "Buffalo STX SAMS", vehicle = "nkstxems", grade = 0},
}

Config["AmbulanceJob"]["Uniform"] = {
    Uniforms = {
        male = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 34, ['tshirt_2'] = 0,
            ['torso_1'] = 32, ['torso_2'] = 18,
            ['arms'] = 92,
            ['pants_1'] = 19, ['pants_2'] = 0,
            ['shoes_1'] = 21, ['shoes_2'] = 0,
            ['mask_1'] = -1, ['mask_2'] = 0,
            ['bproof_1'] = -1,
            ['bags_1'] = -1, ['bags_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ["decals_1"] = 0, ["decals_2"] = 0,
            ['chain_1'] = 48, ['chain_2'] = 0,
        },
        female = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 34, ['tshirt_2'] = 0,
            ['torso_1'] = 32, ['torso_2'] = 18,
            ['arms'] = 93,
            ['pants_1'] = 154, ['pants_2'] = 0,
            ['shoes_1'] = 21, ['shoes_2'] = 0,
            ['mask_1'] = -1, ['mask_2'] = 0,
            ['bproof_1'] = -1,
            ['bags_1'] = -1, ['bags_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ["decals_1"] = 0, ["decals_2"] = 0,
            ['chain_1'] = 48, ['chain_2'] = 0,
        }
    }
}