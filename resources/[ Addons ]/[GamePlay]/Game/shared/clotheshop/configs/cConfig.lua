--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway
---@version 1.0

---@class _Config
_Config = {} or {}; 
_Config.getESX = "esx:getSharedObject"; --> Trigger de déclaration ESX (default : esx:getSharedObject)
_Config.markerGetter = {Type = 23, Size = {0.9, 0.9, 0.9}, Color = {45,110,185}, Rotation = 0.0} --> https://docs.fivem.net/docs/game-references/markers/
_Config.miniMarkerGetter = {Type = 2, Size = {0.2, 0.2, 0.2}, Color = {45,110,185}, Rotation = 180.0} --> https://docs.fivem.net/docs/game-references/markers/

_Config.clotheshop = {
    showBlip = true, --> Afficher ou non les blips sur la carte
    accessoriesPrice = 15, --> Prix à payer pour sauvegarder un accessoire
    price = 70, --> Prix à payer pour sauvegarder la tenue
    positions = {
        infoBlip = { --> https://docs.fivem.net/docs/game-references/blips/
            Name = "[Public] Magasin de vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.6,
            Color = 17,
            Range = true,
        },
        mainZone = { --> Point d'intéraction principal du magasin
            {pos = vector3(72.8544, -1396.9847, 29.6736)}, -- 1
            {pos = vector3(-711.41, -149.73, 37.41)}, -- 2
            {pos = vector3(-164.82, -306.04, 39.73)}, -- 3
            {pos = vector3(428.3115, -802.4881, 29.7886)}, -- 4 
            {pos = vector3(-826.9643, -1073.1176, 11.6256)}, -- 5
            {pos = vector3(-1448.32, -235.54, 49.81)}, -- 6
            {pos = vector3(9.1931, 6513.5654, 32.1753)}, -- 7
            {pos = vector3(124.86, -224.00, 54.55)}, -- 8
            {pos = vector3(1696.1396, 4826.9521, 42.3605)}, -- 9
            {pos = vector3(615.20, 2763.25, 42.08)}, -- 10
            {pos = vector3(1192.7694, 2713.0786, 38.5201)}, -- 11
            {pos = vector3(-1192.29, -768.28, 17.32)}, -- 12
            {pos = vector3(-3171.34, 1043.46, 20.86)}, -- 13
            {pos = vector3(-1105.9469, 2709.7502, 19.4053)}, -- 14
            {pos = vector3(5133.1436, -5090.7969, 2.7597)}, -- 15 (Cayo)
            {pos = vector3(1885.0649, 3810.8096, 33.6163)}, -- 16 (Sandy)
            {pos = vector3(-332.8533, 7209.6953, 6.7982)}, -- 17 (Roxwood)
        },
        glassesZone = { --> Point d'intéraction avec les lunettes
            {pos = vector3(80.3787, -1388.0022, 29.3758)}, -- 1
            {pos = vector3(-700.92, -157.01, 37.41)}, -- 2
            {pos = vector3(-166.08, -293.73, 39.73)}, -- 3
            {pos = vector3(420.9389, -810.6310, 29.4909)}, -- 4
            {pos = vector3(-815.9789, -1075.2529, 11.3279)}, -- 5
            {pos = vector3(-1451.37, -247.36, 49.82)}, -- 6
            {pos = vector3(-1.7470, 6512.8413, 31.8777)}, -- 7
            {pos = vector3(118.45, -223.66, 54.55)}, -- 8
            {pos = vector3(1689.7335, 4817.8926, 42.0629)}, -- 9
            {pos = vector3(621.24, 2765.65, 42.08)}, -- 10
            {pos = vector3(1201.4263, 2705.4951, 38.2224)}, -- 11
            {pos = vector3(-1186.99, -772.20, 17.33)}, -- 12
            {pos = vector3(-3177.98, 1044.44, 20.86)}, -- 13
            {pos = vector3(-1103.12, 2714.75, 19.11)}, -- 14
            {pos = vector3(-1094.8016, 2710.2754, 19.1077)}, -- 15 (Cayo)
            {pos = vector3(1886.0962, 3800.8977, 33.3189)}, -- 16 (Sandy)
            {pos = vector3(-340.1690, 7212.7944, 6.7982)}, -- 17 (Roxwood)
        },
        helmetZone = { --> Point d'intéraction avec les casques
            {pos = vector3(80.35, -1399.87, 29.37)}, -- 1
            {pos = vector3(-710.71, -162.19, 37.41)}, -- 2
            {pos = vector3(-155.65, -297.36, 39.73)}, -- 3
            {pos = vector3(420.56, -799.13, 29.49)}, -- 4
            {pos = vector3(-826.07, -1081.37, 11.33)}, -- 5
            {pos = vector3(-1459.78, -239.65, 49.79)}, -- 6
            {pos = vector3(6.71, 6520.87, 31.88)}, -- 7
            {pos = vector3(131.41, -211.93, 54.55)}, -- 8
            {pos = vector3(1687.98, 4829.10, 42.06)}, -- 9
            {pos = vector3(613.99, 2750.02, 42.08)}, -- 10
            {pos = vector3(1189.52, 2705.19, 38.22)}, -- 11
            {pos = vector3(-1204.33, -774.87, 17.31)}, -- 12
            {pos = vector3(-3164.35, 1054.94, 20.86)}, -- 13
            {pos = vector3(-1103.41, 2702.16, 19.11)}, -- 14
            {pos = vector3(5129.50, -5098.52, 2.20)}, -- 15 (Cayo)
            {pos = vector3(1881.0671, 3811.5791, 33.3188)}, -- 16 (Sandy)
            {pos = vector3(-331.1823, 7218.6270, 6.8037)}, -- 17 (Roxwood)
        },
        earsZone = { --> Point d'intéraction avec les oreilles
            {pos = vector3(78.57, -1390.91, 29.37)}, -- 1
            {pos = vector3(-715.28, -151.36, 37.41)}, -- 2
            {pos = vector3(-161.07, -308.10, 39.73)}, -- 3
            {pos = vector3(422.48, -808.20, 29.49)}, -- 4
            {pos = vector3(-819.18, -1075.20, 11.33)}, -- 5
            {pos = vector3(-1450.34, -231.84, 49.80)}, -- 6
            {pos = vector3(1.24, 6513.32, 31.88)}, -- 7
            {pos = vector3(123.78, -215.36, 54.55)}, -- 8
            {pos = vector3(1691.11, 4820.48, 42.06)}, -- 9
            {pos = vector3(619.48, 2756.07, 42.08)}, -- 10
            {pos = vector3(1198.60, 2707.13, 38.22)}, -- 11
            {pos = vector3(-1195.93, -776.05, 17.32)}, -- 12
            {pos = vector3(-3172.12, 1052.07, 20.86)}, -- 13
            {pos = vector3(-1097.80, 2709.66, 19.11)}, -- 14
            {pos = vector3(5139.78, -5097.50, 2.20)}, -- 15 (Cayo)
            {pos = vector3(1884.2274, 3803.7615, 33.3189)}, -- 16 (Sandy)
            {pos = vector3(-341.9411, 7217.1030, 6.7984)}, -- 17 (Roxwood)
        },
        chainZone = { --> Point d'intéraction avec les chaines
            {pos = vector3(76.9652, -1400.0835, 29.3759)}, -- 1
            {pos = vector3(-707.81, -153.03, 37.41)}, -- 2
            {pos = vector3(-164.62, -301.32, 39.73)}, -- 3
            {pos = vector3(424.0119, -799.3690, 29.4910)}, -- 4
            {pos = vector3(-827.5060, -1078.3385, 11.3279)}, -- 5
            {pos = vector3(-1449.83, -239.32, 49.81)}, -- 6
            {pos = vector3(9.2045, 6518.6929, 31.8777)}, -- 7
            {pos = vector3(127.25, -218.21, 54.55)}, -- 8
            {pos = vector3(1691.3740, 4829.5142, 42.0629)}, -- 9
            {pos = vector3(615.24, 2757.12, 42.08)}, -- 10
            {pos = vector3(1189.6593, 2708.6377, 38.2224)}, -- 11
            {pos = vector3(-1197.31, -771.90, 17.31)}, -- 12
            {pos = vector3(-3168.89, 1049.15, 20.86)}, -- 13
            {pos = vector3(-1105.5660, 2704.7312, 19.1077)}, -- 14
            {pos = vector3(5129.9072, -5094.0288, 2.4620)}, -- 15 (Cayo)
            {pos = vector3(1877.1708, 3810.2500, 33.3189)}, -- 16 (Sandy)
            {pos = vector3(-342.0085, 7213.3486, 6.7993)}, -- 17 (Roxwood)
        },
    },
}

---@class _Client
_Client = _Client or {};
_Client.open = {};
_Prefix = "ex-clotheshop"; --> Prefix des events
_Arrow = "~c~→~s~";
Render = {};