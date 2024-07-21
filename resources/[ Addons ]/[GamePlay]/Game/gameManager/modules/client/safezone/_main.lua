---
--- @author Azagal
--- Create at [01/11/2022] 11:30:14
--- Current project [Valestia-V1]
--- File name [_main]
---

SafeZone = {}

SafeZone.Config = {
    zoneRadius = 80.0,
    zoneList = {
        { x = -1022.375, y = -1519.603, z = 5.592, isPVP = false, radius = 20 }, -- Location/Spawn
        { x = 320.263, y = -592.436, z = 43.269, isPVP = false, radius = 80 }, -- Pillbox
        { x = 114.0524, y = -1063.677, z = 29.19229, isPVP = false, radius = 60 }, -- Parking central
        { x = -392.434, y = -346.073, z = 70.956, isPVP = false, radius = 60 }, -- LSPD
        { x = -211.5676, y = -1326.962, z = 31.30048, isPVP = false, radius = 50 }, -- Bennys
        { x = -1291.627, y = -574.375, z = 44.567, isPVP = false, radius = 50 }, -- Palais
        { x = -1149.192, y = 2681.966, z = 18.093, isPVP = false, radius = 20 }, -- Military Garage
        { x = -1248.051, y = -386.145, z = 37.289, isPVP = false, radius = 20 }, -- Bloods Garage
        { x = -1265.782, y = -3387.759, z = 13.940, isPVP = false, radius = 30 }, -- Garage Avions
        { x = -508.573, y = -615.867, z = 30.298, isPVP = false, radius = 20 }, -- Garage Central
        { x = 1846.56, y = 2585.86, z = 45.67, isPVP = false, radius = 40 }, -- Prison
        { x = -223.4367, y = 6243.221, z = 31.492, isPVP = false, radius = 20 }, -- Fourriere Nord
        { x = 118.265, y = 6612.031, z = 31.879, isPVP = false, radius = 40 }, -- Garage Nord
        { x = 892.860, y = -44.151, z = 78.764, isPVP = false, radius = 20 }, -- Garage Casino
        { x = -949.010, y = -2959.901, z = 13.945, isPVP = false, radius = 80 }, -- Concess Avions
        { x = 1648.721, y = 3800.657, z = 34.876, isPVP = false, radius = 30 }, -- Fourriere Sandy
        { x = 1730.922, y = 3718.563, z = 34.079, isPVP = false, radius = 20 }, -- Garage Sandy
        { x = 374.4513, y = -1620.669, z = 29.291, isPVP = false, radius = 25 }, -- Fourriere Central
        { x = -941.516, y = -2449.459, z = 13.830, isPVP = false, radius = 20 }, -- Garage Airport
        { x = 1756.865, y = 2485.76, z = 45.81, isPVP = false, radius = 50 }, -- Prison Interior
        { x = -68.757, y = 74.977, z = 71.719, isPVP = false, radius = 30 }, -- Concess Voitures
        { x = -1677.867, y = 65.642, z =  63.936, isPVP = false, radius = 20 }, -- Garage Tenis
        { x = -332.547, y = -109.845, z =  39.013, isPVP = false, radius = 60 }, -- Ls Custom
        { x = 4987.118, y = -5712.377, z = 19.88021 , isPVP = true, radius = 10 }, -- Cayo Perico (PVP)
        { x = 194.0601, y = -987.9128, z = 28.3004 , isPVP = false, radius = 30 }, -- Arcadius
        { x = 216.7715, y = -809.5881, z = 30.73589 , isPVP = false, radius = 100 }, -- Garage Central
        { x = 952.47485351562, y = 23.323215484619, z = 116.16418457031, isPVP = false, radius = 100 }, -- Jail
        { x = 113.65849304199, y = 6615.568359375, z = 31.855197906494, isPVP = false, radius = 80 }, -- North Motors
        { x = 2539.8425292969, y = -384.47180175781, z = 92.993385314941 , isPVP = false, radius = 50 }, -- Bureau FIB
        { x = -794.8520, y = -219.9431, z = 37.1612 , isPVP = false, radius = 50 }, -- Luxury
        { x = -1193.372, y = -894.729, z = 13.886 , isPVP = false, radius = 50 } -- BurgerShot
    },
    
    disabledKeys = {
        {group = 2, key = 37, message = "~s~Il est impossible de sortir une arme dans cet endroit."},
        {group = 0, key = 24, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 69, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 92, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 106, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 168, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 160, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 45, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 25, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 80, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 140, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 250, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 263, message = "~s~Il est impossible d'engager un combat dans cet endroit."},
        {group = 0, key = 310, message = "~s~Il est impossible d'engager un combat dans cet endroit."}
    },
    messages = {
        onEntered = "🟢 Vous venez d'entrez en SafeZone",
        onExited = "🔴 Vous venez de sortir de SafeZone",
    },
    bypassJob = {
        active = true,
        list = {
            ["police"] = true,
            ["gouv"] = true,
            ["bcso"] = true,
            ["fib"] = true,
        }
    }
}