--
--Created Date: 22:29 12/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Pound]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Config["Pound"] = {}; -- Don't touch this
Config["Pound"]["Prices"] = {}; -- Don't touch this
Config["Pound"]["Blips"] = {}; -- Don't touch this
Config["Pound"]["Vehicles"] = {}; -- Don't touch this

Config["Pound"]["Prices"]["SpawnVehicle"] = 500; -- Spawn vehicle price
Config["Pound"]["Prices"]["StoreVehicle"] = 750; -- Store vehicle price

Config["Pound"]["Blips"]["Enabled"] = true;
Config["Pound"]["Blips"]["Label"] = "[Public] Fourrières";
Config["Pound"]["Blips"]["Sprite"] = 67;
Config["Pound"]["Blips"]["Color"] = 28;

Config["Pound"]["Vehicles"]["SpawnLocked"] = true;
Config["Pound"]["Vehicles"]["SpawnIn"] = true;

Config["Pound"]["Zones"] = {

    --Pound_LosSantos
    {
        ["Menu"] = { x = 103.5842666626, y = -1074.3591308594, z = 29.192346572876 },
        ["Spawn"] = { x = 109.29666137695, y = -1056.4703369141, z = 29.192371368408, heading = 243.48464965820312 }
    },

    --Pound_Sandy
    {
        ["Menu"] = { x = 1644.10, y = 3808.20, z = 35.09 },
        ["Spawn"] = { x = 1627.84, y = 3788.45, z = 33.77, heading = 308.53 }
    },

    --Pound_Paleto
    {
        ["Menu"] = { x = -223.6, y = 6243.37, z = 31.49 },
        ["Spawn"] = { x = -230.88, y = 6255.89, z = 30.49, heading = 136.5 }
    },

    --Pound_LifeInvader
    {
        ["Menu"] = { x = -1151.388, y = -205.2902, z = 37.95996 },
        ["Spawn"] = { x = -1148.734, y = -219.0661, z = -219.0661, heading = 198.97 }
    },

    --Pound_CayoPerico
    {
        ["Menu"] = { x = 4493.901, y = -4445.047, z = 4.023436 },
        ["Spawn"] = { x = 4479.671, y = -4453.984, z = 4.136179, heading = 199.957 }
    },

        --Pound_CayoPerico
    {
        ["Menu"] = { x = 4493.901, y = -4445.047, z = 4.023436 },
        ["Spawn"] = { x = 4479.671, y = -4453.984, z = 4.136179, heading = 199.957 }
    },

       --Pound Roxwood 
    {
        ["Menu"] = { x = -290.1056, y = 7508.1509, z = 6.1367 },
        ["Spawn"] = { x = -302.9052, y = 7517.1787, z = 6.1367, heading = 188.2620 }
    },
    
    --Pound_Jail
    -- {
    --     ["Menu"] = { x = -1586.757, y = 5155.415, z = 19.637 },
    --     ["Spawn"] = { x = -1575.559, y = 5150.323, z = 19.98602, heading = 187.038223266 },
    -- }

};