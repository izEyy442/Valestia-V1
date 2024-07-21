---
--- @author Kadir#6666
--- Create at [19/05/2023] 09:53:57
--- Current project [Valestia-V1]
--- File name [Jobs]
---

Config["Jobs"] = {}; -- Don't touch this

Config["Jobs"]["Center"] = {

    label = "Centre du Travail",
    pos = vector3(-267.45495605469, -959.06372070312, 31.217529296875)

};

Config["Jobs"]["List"] = {

    {

        data = {
            name = "jardinier",
            label = "Jardinier",
            free_access = true
        },

        farm = {

            blip = {
                sprite = 385,
                color = 2
            },

            interact = {

                ped = GetHashKey("s_m_m_gardener_01"),
                coords = vector4(-1348.4703369141, 142.64175415039, 55.424926757812, 124.72441101074)

            },

            pay = {
                min = 20,
                max = 50
            },

            points = {

                help = {

                    blip = {
                        sprite = 11,
                        color = 25,
                        name = "Mauvaise herbe"
                    },

                    text = "arracher les mauvaises herbes"

                },

                action = {
                    timer = 3000,
                    animation = {"missarmenian3_gardener", "idle_a"}
                },

                list = {

                    vector3(-1317.5208740234, 124.50988769531, 56.18310546875),
                    vector3(-1315.5428466797, 125.52527618408, 56.317993164062),
                    vector3(-1311.5736083984, 120.17143249512, 56.11572265625),
                    vector3(-1283.5384521484, 134.24176025391, 56.806640625),
                    vector3(-1280.8483886719, 147.29670715332, 57.328979492188),
                    vector3(-1280.8483886719, 147.29670715332, 57.328979492188)

                }

            }

        }

    },

    {

        data = {
            name = "postop",
            label = "PostOP",
            free_access = true
        },

        farm = {

            blip = {
                sprite = 318,
                color = 9
            },

            interact = {

                ped = GetHashKey("s_m_m_postal_01"),
                coords = vector4(-423.20233154297, -2788.5187988281, 5.0007901191711, 321.210693359375)

            },

            pay = {
                min = 50,
                max = 90
            },

            points = {

                help = {

                    blip = {
                        sprite = 11,
                        color = 5,
                        name = "Livraison des Colis"
                    },

                    text = "livrer le colis"

                },

                action = {
                    timer = 2800,
                    animation = {"pickup_object", "pickup_low"}
                },

                list = {

                    vector3(349.64117431641, -1027.8193359375, 29.330722808838),
                    vector3(278.5244140625, -1071.6163330078, 29.439785003662),
                    vector3(72.981979370117, -1027.3178710938, 29.475648880005),
                    vector3(-116.84878540039, -603.35675048828, 36.281078338623),
                    vector3(-58.918254852295, -616.38940429688, 37.356781005859),
                    vector3(-277.68121337891, 282.68505859375, 89.886909484863),
                    vector3(-668.21020507813, -971.59313964844, 22.340837478638),
                    vector3(-569.76446533203, -1047.814453125, 22.326824188232),
                    vector3(114.60526275635, -1038.7124023438, 29.287015914917),
                    vector3(223.19284057617, 372.78314208984, 106.36162567139)

                }

            }

        }

    },

    {

        data = {
            name = "chantier",
            label = "Chantier",
            free_access = true
        },

        farm = {

            blip = {
                sprite = 566,
                color = 44
            },

            interact = {

                ped = GetHashKey("s_m_y_construct_01"),
                coords = vector4(36.520156860352, 6549.3891601563, 31.425601959229, 311.8599853515625)

            },

            pay = {
                min = 30,
                max = 70
            },

            points = {

                help = {

                    blip = {
                        sprite = 11,
                        color = 44,
                        name = "Travail sur chantier"
                    }

                },

                action = {
                    timer = 3500,
                    animation = { "amb@world_human_hammering@male@base", "base" }
                },

                list = {

                    vector3(65.780220031738, 6523.951171875, 30.570327758789),
                    vector3(73.247116088867, 6528.1513671875, 30.570316314697),
                    vector3(80.182731628418, 6538.5122070313, 30.676441192627),
                    vector3(87.734535217285, 6542.9521484375, 30.676471710205),
                    vector3(91.742813110352, 6550.3603515625, 30.676471710205),
                    vector3(101.15622711182, 6549.1005859375, 30.676471710205),
                    vector3(98.177017211914, 6545.5288085938, 30.676471710205),
                    vector3(94.890892028809, 6539.5146484375, 30.663034439087)

                }

            }

        }

    }

};