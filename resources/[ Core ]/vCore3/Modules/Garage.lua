--
--Created Date: 21:19 12/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Garage]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Config["Garage"] = {}; -- Don't touch this
Config["Garage"]["Blips"] = {}; -- Don't touch this
Config["Garage"]["Vehicles"] = {}; -- Don't touch this

Config["AdvancedNotification"]["GarageSellVehicle"] = {};
Config["AdvancedNotification"]["GarageSellVehicle"]["TextureName"] = "CHAR_DEFAULT";
Config["AdvancedNotification"]["GarageSellVehicle"]["IconType"] = 1;
Config["AdvancedNotification"]["GarageSellVehicle"]["flash"] = true;
Config["AdvancedNotification"]["GarageSellVehicle"]["SaveToBrief"] = false;
Config["AdvancedNotification"]["GarageSellVehicle"]["HudColorIndex"] = 140;

Config["Garage"]["Blips"]["Enabled"] = true;
Config["Garage"]["Blips"]["List"] = {

    ["default"] = {
        label = "Garage Public",
        sprite = 357,
        color = 3
    },

    ["boat"] = {
        label = "Garage Bateaux",
        sprite = 780,
        color = 3
    },

    ["plane"] = {
        label = "Helipad",
        sprite = 43,
        color = 3
    }

};

Config["Garage"]["Vehicles"]["SpawnLocked"] = true;
Config["Garage"]["Vehicles"]["SpawnIn"] = true;

Config["Garage"]["Zones"] = {

        -- [VEHICLE]

        -- Bennys
        {
            ["Spawn"] = { x = -161.51, y = -1310.45, z = 31.37 },
            ["Out"] = { x = -155.45, y = -1307.8, z = 31.27, heading = 90.71 },
            ["Delete"] = { x = -154.51, y = -1304.22, z = 31.29 }
        },

        -- Central Parking
        {
            ["Spawn"] = { x = 216.1959, y = -809.9877, z = 30.72172 },
            ["Out"] = { x = 228.7852, y = -806.3931, z = 30.5224, heading = 158.4217376709 },
            ["Delete"] = { x = 224.4598, y = -759.3973, z = 30.82524 }
        },

        -- Parinkg Central
        -- {
        --     ["Spawn"] = { x = 103.6013, y = -1074.556, z = 29.19238 },
        --     ["Out"] = { x = 109.421, y = -1056.418, z = 29.19234, heading = 245.07125854492 },
        --     ["Delete"] = { x = 117.4622, y = -1081.565, z = 29.2214 }
        -- },

        -- Sandy
        {
            ["Spawn"] = { x = 1737.59, y = 3710.2, z = 33.14 },
            ["Out"] = { x = 1737.84, y = 3719.28, z = 33.04, heading = 21.22 },
            ["Delete"] = { x = 1722.66, y = 3713.74, z = 33.21 }
        },

        -- Paleto
        {
            ["Spawn"] = { x = 58.529708862305, y = 6401.4819335938, z = 31.225772857666 },
            ["Out"] = { x = 67.970016479492, y = 6400.5161132812, z = 31.225772857666, heading = 165.760986328125 },
            ["Delete"] = { x = 67.627288818359, y = 6410.5551757812, z = 31.225772857666 }
        },

        -- Cayo Perico
        {
            ["Spawn"] = {x = 4519.7934570312, y = -4515.0595703125, z = 4.4937744140625},
            ["Out"] = {x = 4512.3427734375, y = -4517.1826171875, z = 4.123046875, heading = 22.677164077759},
            ["Delete"] = {x = 4512.3427734375, y = -4517.1826171875, z = 4.123046875}
        },

        -- Richman
        {
            ["Spawn"] = { x = -1677.4064941406, y = 66.392608642578, z = 63.912300109863 },
            ["Out"] = { x = -1670.0708007813, y = 65.420959472656, z = 63.912300109863, heading = 289.063232421875 },
            ["Delete"] = { x = -1679.3759765625, y = 73.71312713623, z = 64.101188659668 }
        },

        -- Vagos
        {
            ["Spawn"] = { x = 722.18328857422, y = -2016.3392333984, z = 29.292125701904 },
            ["Out"] = { x = 725.47436523438, y = -2031.9857177734, z = 29.292125701904, heading = 29.28413772583 },
            ["Delete"] = { x = 717.09851074219, y = -2023.1691894531, z = 29.292053222656 }
        },

        -- Bloods
        {
            ["Spawn"] = { x = -1250.502, y = -396.3816, z = 37.28932 },
            ["Out"] = { x = -1245.31, y = -388.0357, z = 37.28932, heading = 295.95599365234 },
            ["Delete"] = { x = -1254.78, y = -389.3844, z = 37.28938 }
        },

         --Hospital Ocean
         {
             ["Spawn"] = { x = -1904.457, y = -333.8412, z = 49.4283 },
             ["Out"] = { x = -1896.798, y = -335.5756, z = 49.23235, heading = 321.17831420898 },
             ["Delete"] = { x = -1890.75, y = -340.5831, z = 49.26398 }
         },

        -- Military
        {
            ["Spawn"] = { x = -1148.959, y = 2682.05, z = 18.09392 },
            ["Out"] = { x = -1150.694, y = 2675.76, z = 18.09392, heading = 132.23852539063 },
            ["Delete"] = { x = -1161.74, y = 2671.946, z = 18.09392 }
        },

        -- Garage Rouge
        {
            ["Spawn"] = { x = -282.89190673828, y = -887.22882080078, z = 31.080614089966 },
            ["Out"] = { x = -296.68637084961, y = -885.11071777344, z = 31.080623626709, heading = 167.0000457763672 },
            ["Delete"] = { x = -299.04827880859, y = -899.83825683594, z = 31.080619812012 }
        },

        -- Casino
        {
            ["Spawn"] = { x = 892.86, y = -44.15121, z = 78.76414 },
            ["Out"] = { x = 885.0427, y = -40.03032, z = 78.76414, heading = 323.74569702148 },
            ["Delete"] = { x = 897.8321, y = -33.32176, z = 78.76414 }
        },

        -- Airport
        {
            ["Spawn"] = { x = -936.238, y = -2433.057, z = 13.83647 },
            ["Out"] = { x = -924.486, y = -2441.069, z = 13.84149, heading = 122.51920318604 },
            ["Delete"] = { x = -949.6402, y = -2442.867, z = 13.83086 }
        },

        -- Hospital
        {
            ["Spawn"] = { x = -821.34, y = -1267.75, z = 5.150578 },
            ["Out"] = { x = -817.4161, y = -1281.129, z = 5.00039, heading = 256.4479 },
            ["Delete"] = { x = -828.0484, y = -1263.913, z =  5.000388 }
        },

        -- Gouv proche lspd
        {
            ["Spawn"] = {x = -582.6383, y = -172.3038, z = 37.81154}, 
            ["Out"] = {x = -573.9974, y = -168.2229, z = 37.35837, heading = 292.87},
            ["Delete"] = {x = -549.5462, y = -157.9245, z = 38.27}
        },

                -- Gouv le vrai
        {
            ["Spawn"] = {x = -411.5205, y = 1240.4031, z = 325.6418},
            ["Out"] = {x = -412.7220, y = 1231.7922, z = 325.6418, heading = 234.1661},
            ["Delete"] = {x = -397.8991, y = 1236.2991, z = 325.6418}
        },


                -- roxwood
        {
            ["Spawn"] = {x = -209.3233, y = 7706.7554, z = 6.3278},
            ["Out"] = {x = -192.2231, y = 7705.4673, z = 6.3278, heading = 40.2411},
            ["Delete"] = {x = -215.9559, y = 7694.0117, z = 6.3278}
        },

        --Garage_Jail
        -- {
        --     ["Spawn"] = { x = -1581.359, y = 5168.955, z = 19.57253 },
        --     ["Out"] = { x = -1575.559, y = 5150.323, z = 19.98602, heading = 187.038223266 },
        --     ["Delete"] = { x = -1585.321, y = 5158.748, z = 19.6095 }
        -- },

        -- [BOAT]

        -- LS Dock
        {
            ["Type"] = "boat",
            ["Spawn"] = { x = -800.690125, y = -1494.606567, z = 1.578735 },
            ["Out"] = {x = -795.072509765625, y = -1502.3209228515626, z = -0.4263916015625, heading = 104.88188934326},
            ["Delete"] = {x = -795.072509765625, y = -1502.3209228515626, z = -0.4263916015625}
        },

        -- Sandy Dock
        {
            ["Type"] = "boat",
            ["Spawn"] = {x = 1333.3187255859, y = 4270.4702148438, z = 31.487182617188},
            ["Out"] = {x = 1334.61, y = 4264.68, z = 29.86, heading = 87.0},
            ["Delete"] = {x = 1334.61, y = 4264.68, z = 29.86}
        },

        -- Paleto Dock
        {
            ["Type"] = "boat",
            ["Spawn"] = {x = -986.5358, y = 6589.8330, z = 1.8818},
            ["Out"] = {x = -1014.798, y = 6598.6870, z = -0.4751, heading = 98.0485},
            ["Delete"] = {x = -290.46, y = 6622.72, z = -0.47477427124977}
        },

        -- chumash
        {
            ["Type"] = "boat",
            ["Spawn"] = {x = -3304.7944, y = 956.0582, z = 2.0568},
            ["Out"] = {x = -3328.2515, y = 947.3129, z = -0.4751, heading = 121.4470}, 
            ["Delete"] = {x = -3314.3652, y = 942.0706, z = -0.4749}
        },

        -- Cayo Perico Dock
        {
            ["Type"] = "boat",
            ["Spawn"] = {x = 4898.2153320312, y = -5168.9799804688, z = 2.4549560546875},
            ["Out"] = {x = 4893.5341796875, y = -5168.3471679688, z = -0.4263916015625, heading = 337.32284545898},
            ["Delete"] = {x = -984.0161, y = 6595.8379, z = -0.5593}
        },

        -- [PLANE]

        -- LS
        {
            ["Type"] = "plane",
            ["Spawn"] = {x = -1242.2901611328, y = -3393.1252441406, z = 13.9296875},
            ["Out"] = {x = -1275.4285888672, y = -3388.3779296875, z = 13.9296875, heading = 331.65353393555},
            ["Delete"] = {x = -1275.4285888672, y = -3388.3779296875, z = 13.9296875}
        },

        -- Sandy
        {
            ["Type"] = "plane",
            ["Spawn"] = {x = 1726.6153564453, y = 3291.3361816406, z = 41.17578125},
            ["Out"] = {x = 1707.7846679688, y = 3254.2680664062, z = 41.024169921875, heading = 102.04724884033},
            ["Delete"] = {x = 1707.7846679688, y = 3254.2680664062, z = 41.024169921875}
        },

        -- Cayo Perico
        {
            ["Type"] = "plane",
            ["Spawn"] = {x = 4462.2329101562, y = -4468.6943359375, z = 4.240966796875},
            ["Out"] = {x = 4483.8989257812, y = -4493.419921875, z = 4.1904296875, heading = 102.04724884033},
            ["Delete"] = {x = 4483.8989257812, y = -4493.419921875, z = 4.1904296875}
        }
};