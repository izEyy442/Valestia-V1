Config["Road_Radar"] = {}

Config["Road_Radar"]["PriceL1"] = 180 -- normal speed < 20
Config["Road_Radar"]["PriceL2"] = 235 -- normal speed  < 30
Config["Road_Radar"]["PriceL3"] = 300 -- normal speed < 50
Config["Road_Radar"]["PriceL4"] = 375 -- normal speed  >= 50

Config["Road_Radar"]["Zones"] = {

    {
        ["Radar"] = { x = 398.12, y = -1050.50, z = 29.39 },
        ["SpeedLimit"] = 130,
        ["Radius"] = 35
    },

    {
        ["Radar"] = { x = -270.35, y = -1139.82, z = 23.09 },
        ["SpeedLimit"] = 130,
        ["Radius"] = 40
    },

    {
        ["Radar"] = { x = -251.45, y = -661.61, z = 33.25 },
        ["SpeedLimit"] = 130,
        ["Radius"] = 40
    },

    {
        ["Radar"] = { x = 169.67, y = -819.68, z = 31.17 },
        ["SpeedLimit"] = 130,
        ["Radius"] = 40
    },

    {
        ["Radar"] = { x = 1613.86, y = 1122.46, z = 82.66 },
        ["SpeedLimit"] = 250,
        ["Radius"] = 40
    },

    {
        ["Radar"] = { x = -2318.29, y = -322.42, z = 13.79 },
        ["SpeedLimit"] = 250,
        ["Radius"] = 40
    },

    {
        ["Radar"] = { x = 2431.51, y = -177.62, z = 87.96 },
        ["SpeedLimit"] = 250,
        ["Radius"] = 40
    },

}

Config["Road_Radar"]["BypassJob"] = {
    "police",
    "ambulance",
    "gouv",
    "bcso",
    "fib"
}