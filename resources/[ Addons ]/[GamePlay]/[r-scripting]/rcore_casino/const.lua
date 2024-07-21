-- machine properties for each hash, for both server & client
machineHashes = {-1932041857, -1519644200, -430989390, 654385216, 161343630, 1096374064, 207578973, -487222358,
-271916471, -1885297978, -1072855969,  1031635129,  681595944, -1313086203, -731399252}
machineReelsRotations = {0.0, 23.0, 67.7, 90.5, 113.15, 135.37, 157.6, 0}
machineModels = {}
machineModels[-1932041857] = {
    name = "Angel Knight",
    bannerDict = "CasinoUI_Slots_Angel",
    model = "vw_prop_casino_slot_01a",
    display = "machine_01a",
    reels = "vw_prop_casino_slot_01a_reels",
    reelsBlurry = "vw_prop_casino_slot_01b_reels",
    sounds = "dlc_vw_casino_slot_machine_ak_player_sounds",
    announcer = "CAPA_ANAB",
    messageId = 1,
    maxBet = 500,
    jackpotLimiter = 100, -- jackpot can be hit max. once per 100 spins
    unluckyFactor = 5, -- each 5th spin will hit 0 chips no matter what, set unluckyFactor = 2 for each second spin, set to 0 to disable
    items = {{
        name = "Seven",
        value = 25000,
        ShowUpReducer = 70 -- Seven will have 100% (same) chance to hit for first time, then (-70%), 30% chance to hit second time, then (-70%), 9% chance to hit third time
    }, {
        name = "Plum",
        value = 5000,
        ShowUpReducer = 70
    }, {
        name = "Melon",
        value = 7500,
        ShowUpReducer = 70
    }, {
        name = "Star", -- fourth item of each machine is the first one on the scores display (the one thats enough if you hit once to get some chips)
        value = 500,
        ShowUpReducer = 80
    }, {
        name = "Piano", -- fifth item of each machine is the jackpot one
        value = 100000,
        ShowUpReducer = 80
    }, {
        name = "Cherry",
        value = 2500,
        ShowUpReducer = 70
    }, {
        name = "Bell",
        value = 10000,
        ShowUpReducer = 70
    }, {
        name = "-",
        value = 0,
        ShowUpReducer = 0
    }}
}
machineModels[-1519644200] = {
    name = "Impotent Rage",
    bannerDict = "CasinoUI_Slots_Impotent",
    model = "vw_prop_casino_slot_02a",
    display = "machine_02a",
    reels = "vw_prop_casino_slot_02a_reels",
    reelsBlurry = "vw_prop_casino_slot_02b_reels",
    sounds = "dlc_vw_casino_slot_machine_ir_player_sounds",
    announcer = "CAPA_AOAB",
    messageId = 2,
    maxBet = 125,
    jackpotLimiter = 100, -- jackpot can be hit max. once per 100 spins
    unluckyFactor = 5, -- each 5th spin will hit 0 chips no matter what, set unluckyFactor = 2 for each second spin, set to 0 to disable
    items = {{
        name = "Seven",
        value = 6250,
        ShowUpReducer = 70 -- Seven will have 100% (same) chance to hit for first time, then (-70%), 30% chance to hit second time, then (-70%), 9% chance to hit third time
    }, {
        name = "Plum",
        value = 1250,
        ShowUpReducer = 70
    }, {
        name = "Melon",
        value = 1875,
        ShowUpReducer = 70
    }, {
        name = "Flash", -- fourth item of each machine is the first one on the scores display (the one thats enough if you hit once to get some chips)
        value = 125,
        ShowUpReducer = 80
    }, {
        name = "Face", -- fifth item of each machine is the jackpot one
        value = 25000,
        ShowUpReducer = 80
    }, {
        name = "Cherry",
        value = 625,
        ShowUpReducer = 70
    }, {
        name = "Bell",
        value = 2500,
        ShowUpReducer = 70
    }, {
        name = "-",
        value = 0,
        ShowUpReducer = 0
    }}
}
machineModels[-430989390] = {
    name = "Space Rangers",
    bannerDict = "CasinoUI_Slots_Ranger",
    model = "vw_prop_casino_slot_03a",
    display = "machine_03a",
    reels = "vw_prop_casino_slot_03a_reels",
    reelsBlurry = "vw_prop_casino_slot_03b_reels",
    sounds = "dlc_vw_casino_slot_machine_rsr_player_sounds",
    announcer = "CAPA_APAB",
    messageId = 3,
    maxBet = 125,
    jackpotLimiter = 100, -- jackpot can be hit max. once per 100 spins
    unluckyFactor = 5, -- each 5th spin will hit 0 chips no matter what, set unluckyFactor = 2 for each second spin, set to 0 to disable
    items = {{
        name = "Seven",
        value = 6250,
        ShowUpReducer = 70 -- Seven will have 100% (same) chance to hit for first time, then (-70%), 30% chance to hit second time, then (-70%), 9% chance to hit third time
    }, {
        name = "Plum",
        value = 1250,
        ShowUpReducer = 70
    }, {
        name = "Melon",
        value = 1675,
        ShowUpReducer = 70
    }, {
        name = "Bottle", -- fourth item of each machine is the first one on the scores display (the one thats enough if you hit once to get some chips)
        value = 125,
        ShowUpReducer = 80
    }, {
        name = "Medal", -- fifth item of each machine is the jackpot one
        value = 25000,
        ShowUpReducer = 80
    }, {
        name = "Cherry",
        value = 625,
        ShowUpReducer = 70
    }, {
        name = "Bell",
        value = 2500,
        ShowUpReducer = 70
    }, {
        name = "-",
        value = 0,
        ShowUpReducer = 0
    }}
}
machineModels[654385216] = {
    name = "Fame or Shame",
    bannerDict = "CasinoUI_Slots_Fame",
    model = "vw_prop_casino_slot_04a",
    display = "machine_04a",
    reels = "vw_prop_casino_slot_04a_reels",
    reelsBlurry = "vw_prop_casino_slot_04b_reels",
    sounds = "dlc_vw_casino_slot_machine_fs_player_sounds",
    announcer = "CAPA_AQAB",
    messageId = 4,
    maxBet = 25,
    jackpotLimiter = 100, -- jackpot can be hit max. once per 100 spins
    unluckyFactor = 5, -- each 5th spin will hit 0 chips no matter what, set unluckyFactor = 2 for each second spin, set to 0 to disable
    items = {{
        name = "Seven",
        value = 1250,
        ShowUpReducer = 70 -- Seven will have 100% (same) chance to hit for first time, then (-70%), 30% chance to hit second time, then (-70%), 9% chance to hit third time
    }, {
        name = "Plum",
        value = 250,
        ShowUpReducer = 70
    }, {
        name = "Melon",
        value = 375,
        ShowUpReducer = 70
    }, {
        name = "Microphone", -- fourth item of each machine is the first one on the scores display (the one thats enough if you hit once to get some chips)
        value = 25,
        ShowUpReducer = 80
    }, {
        name = "Text", -- fifth item of each machine is the jackpot one
        value = 5000,
        ShowUpReducer = 80
    }, {
        name = "Cherry",
        value = 125,
        ShowUpReducer = 70
    }, {
        name = "Bell",
        value = 500,
        ShowUpReducer = 70
    }, {
        name = "-",
        value = 0,
        ShowUpReducer = 0
    }}
}
machineModels[161343630] = {
    name = "Deity of the Sun",
    bannerDict = "CasinoUI_Slots_Deity",
    model = "vw_prop_casino_slot_05a",
    display = "machine_05a",
    reels = "vw_prop_casino_slot_05a_reels",
    reelsBlurry = "vw_prop_casino_slot_05b_reels",
    sounds = "dlc_vw_casino_slot_machine_ds_player_sounds",
    announcer = "CAPA_AMAB",
    messageId = 5,
    maxBet = 2500,
    jackpotLimiter = 100, -- jackpot can be hit max. once per 100 spins
    unluckyFactor = 5, -- each 5th spin will hit 0 chips no matter what, set unluckyFactor = 2 for each second spin, set to 0 to disable
    items = {{
        name = "Seven",
        value = 125000,
        ShowUpReducer = 70 -- Seven will have 100% (same) chance to hit for first time, then (-70%), 30% chance to hit second time, then (-70%), 9% chance to hit third time
    }, {
        name = "Plum",
        value = 25000,
        ShowUpReducer = 70
    }, {
        name = "Melon",
        value = 37500,
        ShowUpReducer = 70
    }, {
        name = "Anhk", -- fourth item of each machine is the first one on the scores display (the one thats enough if you hit once to get some chips)
        value = 2500,
        ShowUpReducer = 80
    }, {
        name = "Pharoh", -- fifth item of each machine is the jackpot one
        value = 500000,
        ShowUpReducer = 80
    }, {
        name = "Cherry",
        value = 12500,
        ShowUpReducer = 70
    }, {
        name = "Bell",
        value = 50000,
        ShowUpReducer = 70
    }, {
        name = "-",
        value = 0,
        ShowUpReducer = 0 -- set to 0 for she same chance to hit (-)
    }}
}
machineModels[1096374064] = {
    name = "Twilight Knife",
    bannerDict = "CasinoUI_Slots_Knife",
    model = "vw_prop_casino_slot_06a",
    display = "machine_06a",
    reels = "vw_prop_casino_slot_06a_reels",
    reelsBlurry = "vw_prop_casino_slot_06b_reels",
    sounds = "dlc_vw_casino_slot_machine_kd_player_sounds",
    announcer = "CAPA_ARAB",
    messageId = 6,
    maxBet = 500,
    jackpotLimiter = 100, -- jackpot can be hit max. once per 100 spins
    unluckyFactor = 5, -- each 5th spin will hit 0 chips no matter what, set unluckyFactor = 2 for each second spin, set to 0 to disable
    items = {{
        name = "Seven",
        value = 25000,
        ShowUpReducer = 70 -- Seven will have 100% (same) chance to hit for first time, then (-70%), 30% chance to hit second time, then (-70%), 9% chance to hit third time
    }, {
        name = "Plum",
        value = 5000,
        ShowUpReducer = 70
    }, {
        name = "Melon",
        value = 7500,
        ShowUpReducer = 70
    }, {
        name = "Knife", -- fourth item of each machine is the first one on the scores display (the one thats enough if you hit once to get some chips)
        value = 500,
        ShowUpReducer = 80
    }, {
        name = "Saw", -- fifth item of each machine is the jackpot one
        value = 100000,
        ShowUpReducer = 80
    }, {
        name = "Cherry",
        value = 2500,
        ShowUpReducer = 70
    }, {
        name = "Bell",
        value = 10000,
        ShowUpReducer = 70
    }, {
        name = "-",
        value = 0,
        ShowUpReducer = 0
    }}
}
machineModels[207578973] = {
    name = "Diamond Miner",
    bannerDict = "CasinoUI_Slots_Diamond",
    model = "vw_prop_casino_slot_07a",
    display = "machine_07a",
    reels = "vw_prop_casino_slot_07a_reels",
    reelsBlurry = "vw_prop_casino_slot_07b_reels",
    sounds = "dlc_vw_casino_slot_machine_td_player_sounds",
    announcer = "CAPA_ALAB",
    messageId = 7,
    maxBet = 2500,
    jackpotLimiter = 100, -- jackpot can be hit max. once per 100 spins
    unluckyFactor = 5, -- each 5th spin will hit 0 chips no matter what, set unluckyFactor = 2 for each second spin, set to 0 to disable
    items = {{
        name = "Seven",
        value = 125000,
        ShowUpReducer = 70 -- Seven will have 100% (same) chance to hit for first time, then (-70%), 30% chance to hit second time, then (-70%), 9% chance to hit third time
    }, {
        name = "Plum",
        value = 25000,
        ShowUpReducer = 70
    }, {
        name = "Melon",
        value = 37500,
        ShowUpReducer = 70
    }, {
        name = "Diamond", -- fourth item of each machine is the first one on the scores display (the one thats enough if you hit once to get some chips)
        value = 2500,
        ShowUpReducer = 80
    }, {
        name = "Diamonds", -- fifth item of each machine is the jackpot one
        value = 500000,
        ShowUpReducer = 80
    }, {
        name = "Cherry",
        value = 12500,
        ShowUpReducer = 70
    }, {
        name = "Bell",
        value = 50000,
        ShowUpReducer = 70
    }, {
        name = "-",
        value = 0,
        ShowUpReducer = 0
    }}
}
machineModels[-487222358] = {
    name = "Evacuator",
    bannerDict = "CasinoUI_Slots_Evacuator",
    model = "vw_prop_casino_slot_08a",
    display = "machine_08a",
    reels = "vw_prop_casino_slot_08a_reels",
    reelsBlurry = "vw_prop_casino_slot_08b_reels",
    sounds = "dlc_vw_casino_slot_machine_hz_player_sounds",
    announcer = "CAPA_ASAB",
    messageId = 8,
    maxBet = 25,
    jackpotLimiter = 100, -- jackpot can be hit max. once per 100 spins
    unluckyFactor = 5, -- each 5th spin will hit 0 chips no matter what, set unluckyFactor = 2 for each second spin, set to 0 to disable
    items = {{
        name = "Seven",
        value = 1250,
        ShowUpReducer = 70 -- Seven will have 100% (same) chance to hit for first time, then (-70%), 30% chance to hit second time, then (-70%), 9% chance to hit third time
    }, {
        name = "Plum",
        value = 250,
        ShowUpReducer = 70
    }, {
        name = "Melon",
        value = 375,
        ShowUpReducer = 70
    }, {
        name = "Soldier", -- fourth item of each machine is the first one on the scores display (the one thats enough if you hit once to get some chips)
        value = 25,
        ShowUpReducer = 80
    }, {
        name = "Rocket", -- fifth item of each machine is the jackpot one
        value = 5000,
        ShowUpReducer = 80
    }, {
        name = "Cherry",
        value = 125,
        ShowUpReducer = 70
    }, {
        name = "Bell",
        value = 500,
        ShowUpReducer = 70
    }, {
        name = "-",
        value = 0,
        ShowUpReducer = 0
    }}
}

restrictedControls = {37, 157, 159, 160, 161, 162, 163, 164, 165, 158, 101, 337, 53, 54, 47, 140, 141, 263, 264, 142,
                      143, 24, 257, 44, 282, 283, 284, 285, 69, 70, 114, 99, 100, 102, 22, 74, 68, 25, 36, 345, 346,
                      347, 91, 92}

horseChairs = {{947.73120, 78.91850, 69.03276}, {948.63250, 79.12659, 69.03276}, {951.93240, 79.92471, 69.03276},

               {952.83370, 80.13280, 69.03276}, {953.83240, 80.36337, 69.03276}, {954.73360, 80.57192, 69.03276},

               {958.04430, 81.29948, 69.03276}, {958.94580, 81.50755, 69.03276}, {947.81390, 76.11526, 69.03276},

               {948.71520, 76.32335, 69.03276}, {952.55090, 77.24567, 69.03255}, {953.45230, 77.45328, 69.03276},

               {954.45100, 77.68385, 69.03276}, {955.35230, 77.89193, 69.03276}, {959.19890, 78.74368, 69.03276},

               {960.10010, 78.95177, 69.03276}}
horseChairsHeading = -167

horsePresets = {{
    nameId = "A_TETHERED_END",
    colors = {15553363, 5474797, 9858144, 4671302},
    odds = 27
}, {
    nameId = "BAD_EGG",
    colors = {16724530, 3684408, 14807026, 16777215},
    odds = 29
}, {
    nameId = "BANANA_HAMMOCK",
    colors = {13560920, 15582764, 16770746, 7500402},
    odds = 16
}, {
    nameId = "BETTER_THAN_NOTHING",
    colors = {16558591, 5090807, 10446437, 7493977},
    odds = 15
}, {
    nameId = "BLACK_ROCK_ROOSTER",
    colors = {5090807, 16558591, 3815994, 9393493},
    odds = 18
}, {
    nameId = "BLEET_ME_BABY",
    colors = {16269415, 16767010, 10329501, 16777215},
    odds = 7
}, {
    nameId = "BLUE_DREAM",
    colors = {2263807, 16777215, 9086907, 3815994},
    odds = 2
}, {
    nameId = "BORROWED_SORROW",
    colors = {4879871, 16715535, 3815994, 16777215},
    odds = 12
}, {
    nameId = "BOUNCY_BLESSED",
    colors = {16777215, 2263807, 16769737, 15197642},
    odds = 5
}, {
    nameId = "CANCELLED_CHECK",
    colors = {16777215, 16559849, 5716493, 3815994},
    odds = 28
}, {
    nameId = "CANT_BE_WRONGER",
    colors = {16338779, 16777215, 11166563, 6974058},
    odds = 25
}, {
    nameId = "CLAPBACK_CHARLIE",
    colors = {16760644, 3387257, 16701597, 16777215},
    odds = 10
}, {
    nameId = "CONSTANT_BRAG",
    colors = {6538729, 2249420, 16777215, 3815994},
    odds = 3
}, {
    nameId = "COUNTRY_STUCK",
    colors = {15913534, 15913534, 16304787, 15985375},
    odds = 21
}, {
    nameId = "CRACKERS_AND_PLEASE",
    colors = {15655629, 16240452, 16760474, 13664854},
    odds = 3
}, {
    nameId = "CREEPY_DENTIST",
    colors = {16320263, 16777215, 14920312, 16773316},
    odds = 7
}, {
    nameId = "CROCK_JANLEY",
    colors = {7176404, 15138618, 6308658, 13664854},
    odds = 8
}, {
    nameId = "DANCIN_POLE",
    colors = {4879871, 8453903, 11382189, 15724527},
    odds = 9
}, {
    nameId = "DANCIN_SHOES",
    colors = {16777215, 16777215, 16754809, 16777215},
    odds = 5
}, {
    nameId = "DARLING_RICKI",
    colors = {16732497, 16732497, 3815994, 16777215},
    odds = 22
}, {
    nameId = "DEAD_FAM",
    colors = {5739220, 5739220, 11382189, 15724527},
    odds = 26
}, {
    nameId = "DEAD_HEAT_HATTIE",
    colors = {16712909, 6935639, 8742735, 3877137},
    odds = 17
}, {
    nameId = "DEXIE_RUNNER",
    colors = {2136867, 16777215, 16761488, 3877137},
    odds = 6
}, {
    nameId = "DIVORCED_DOCTOR",
    colors = {3118422, 10019244, 14932209, 6121086},
    odds = 7
}, {
    nameId = "DOOZY_FLOOZY",
    colors = {2136867, 10241979, 8081664, 3815994},
    odds = 13
}, {
    nameId = "DOWNTOWN_RENOWN",
    colors = {16769271, 13724403, 9852728, 14138263},
    odds = 4
}, {
    nameId = "DR_DEEZ_REINS",
    colors = {13724403, 16769271, 6444881, 14138263},
    odds = 5
}, {
    nameId = "DREAM_SHATTERER",
    colors = {10017279, 4291288, 16304787, 15985375},
    odds = 1
}, {
    nameId = "DRONE_WARNING",
    colors = {1071491, 4315247, 14935011, 6121086},
    odds = 8
}, {
    nameId = "DRUNKEN_BRANDEE",
    colors = {3861944, 16627705, 14932209, 6121086},
    odds = 14
}, {
    nameId = "DURBAN_POISON",
    colors = {15583546, 4671303, 11836798, 3090459},
    odds = 20
}, {
    nameId = "FEED_THE_TROLLS",
    colors = {15567418, 4671303, 9985296, 3815994},
    odds = 30
}, {
    nameId = "FIRE_HAZARDS",
    colors = {5701417, 16711680, 16771760, 6970713},
    odds = 24
}, {
    nameId = "FLIPPED_WIG",
    colors = {16760303, 5986951, 12353664, 15395562},
    odds = 12
}, {
    nameId = "FRIENDLY_FIRE",
    colors = {8907670, 2709022, 9475214, 4278081},
    odds = 9
}, {
    nameId = "GETTING_HAUGHTY",
    colors = {5429688, 6400829, 16777215, 16773316},
    odds = 3
}, {
    nameId = "GHOST_DANK",
    colors = {15138618, 5272210, 14920312, 16773316},
    odds = 10
}, {
    nameId = "GLASS_OR_TINA",
    colors = {10241979, 12396337, 14920312, 15395562},
    odds = 23
}, {
    nameId = "LOS_SANTOS_SAVIOR",
    colors = {16777215, 13481261, 13667152, 3815994},
    odds = 5
}, {
    nameId = "HARD_TIME_DONE",
    colors = {5077874, 16777215, 15444592, 7820105},
    odds = 18
}, {
    nameId = "HELL_FOR_WEATHER",
    colors = {10408040, 2960685, 7424036, 10129549},
    odds = 2
}, {
    nameId = "HENNIGANS_STEED",
    colors = {7754308, 16777215, 12944259, 3815994},
    odds = 4
}, {
    nameId = "HIPPIE_CRACK",
    colors = {16736955, 16106560, 16771760, 6970713},
    odds = 23
}, {
    nameId = "HOT_AND_BOTHERED",
    colors = {16106560, 16770224, 16767659, 15843765},
    odds = 2
}, {
    nameId = "INVADE_GRENADE",
    colors = {9573241, 14703194, 9789279, 3815994},
    odds = 13
}, {
    nameId = "ITS_A_TRAP",
    colors = {44799, 14703194, 10968156, 16777215},
    odds = 1
}, {
    nameId = "KRAFF_RUNNING",
    colors = {7143224, 16753956, 10975076, 4210752},
    odds = 14
}, {
    nameId = "LEAD_IS_OUT",
    colors = {7895160, 4013373, 5855577, 11645361},
    odds = 3
}, {
    nameId = "LIT_AS_TRUCK",
    colors = {16075595, 6869196, 13530742, 7105644},
    odds = 1
}, {
    nameId = "LONELY_STEPBROTHER",
    colors = {16090955, 6272992, 16777215, 16777215},
    odds = 3
}, {
    nameId = "LOVERS_SPEED",
    colors = {13313356, 13313356, 5849409, 11623516},
    odds = 2
}, {
    nameId = "MEASLES_SMEEZLES",
    colors = {13911070, 5583427, 14935011, 6121086},
    odds = 15
}, {
    nameId = "MICRO_AGGRESSION",
    colors = {8604661, 10408040, 12944259, 3815994},
    odds = 8
}, {
    nameId = "MINIMUM_WAGER",
    colors = {9716612, 2960685, 16767659, 6708313},
    odds = 26
}, {
    nameId = "MISS_MARY_JOHN",
    colors = {7806040, 16777215, 16765601, 14144436},
    odds = 22
}, {
    nameId = "MISS_TRIGGERED",
    colors = {15632075, 11221989, 16777215, 16770037},
    odds = 19
}, {
    nameId = "MISTER_REDACTED",
    colors = {1936722, 14654697, 16763851, 3815994},
    odds = 19
}, {
    nameId = "MISTER_SCISSORS",
    colors = {10377543, 3815994, 14807026, 16777215},
    odds = 7
}, {
    nameId = "MONEY_TO_BURN",
    colors = {16775067, 11067903, 16770746, 7500402},
    odds = 30
}, {
    nameId = "MOON_ROCKS",
    colors = {16741712, 8669718, 16777215, 16777215},
    odds = 4
}, {
    nameId = "MR_WORTHWHILE",
    colors = {16515280, 6318459, 3815994, 9393493},
    odds = 2
}, {
    nameId = "MUD_DRAGON",
    colors = {65526, 16515280, 10329501, 16777215},
    odds = 5
}, {
    nameId = "NIGHTTIME_MARE",
    colors = {16711680, 4783925, 3815994, 3815994},
    odds = 16
}, {
    nameId = "NORTHERN_LIGHTS",
    colors = {65532, 4783925, 16766671, 15197642},
    odds = 15
}, {
    nameId = "NUNS_ORDERS",
    colors = {16760303, 16760303, 3815994, 14207663},
    odds = 9
}, {
    nameId = "OL_SKAG",
    colors = {16770048, 16770048, 3815994, 3815994},
    odds = 28
}, {
    nameId = "OLD_ILL_WILL",
    colors = {16737792, 16737792, 11166563, 6974058},
    odds = 29
}, {
    nameId = "OMENS_AND_ICE",
    colors = {12773119, 12773119, 5716493, 3815994},
    odds = 3
}, {
    nameId = "PEDESTRIAN",
    colors = {16777215, 16763043, 16701597, 16777215},
    odds = 25
}, {
    nameId = "PRETTY_AS_A_PISTOL",
    colors = {6587161, 6587161, 16777215, 3815994},
    odds = 4
}, {
    nameId = "QUESTIONABLE_DIGNITY",
    colors = {6329328, 16749602, 3815994, 3815994},
    odds = 12
}, {
    nameId = "REACH_AROUND_TOWN",
    colors = {15793920, 16519679, 14920312, 15395562},
    odds = 6
}, {
    nameId = "ROBOCALL",
    colors = {15466636, 10724259, 16760474, 13664854},
    odds = 4
}, {
    nameId = "SALT_N_SAUCE",
    colors = {11563263, 327629, 6308658, 13664854},
    odds = 1
}, {
    nameId = "SALTY_AND_WOKE",
    colors = {58867, 16777215, 16754809, 8082236},
    odds = 17
}, {
    nameId = "SCRAWNY_NAG",
    colors = {4909311, 16777215, 5849409, 11623516},
    odds = 30
}, {
    nameId = "SIR_SCRAMBLED",
    colors = {3700643, 7602233, 9852728, 14138263},
    odds = 26
}, {
    nameId = "SIZZURP",
    colors = {16777215, 1017599, 8742735, 3877137},
    odds = 13
}, {
    nameId = "SNATCHED_YOUR_MAMA",
    colors = {16772022, 16772022, 16761488, 3877137},
    odds = 1
}, {
    nameId = "SOCIAL_MEDIA_WARRIOR",
    colors = {7849983, 5067443, 8081664, 3815994},
    odds = 27
}, {
    nameId = "SQUARE_TO_GO",
    colors = {15913534, 7602233, 6444881, 14138263},
    odds = 6
}, {
    nameId = "STUDY_BUDDY",
    colors = {12320733, 16775618, 11836798, 3090459},
    odds = 15
}, {
    nameId = "STUPID_MONEY",
    colors = {15240846, 16777215, 9985296, 3815994},
    odds = 30
}, {
    nameId = "SUMPTIN_SAUCY",
    colors = {14967137, 3702939, 3815994, 14207663},
    odds = 1
}, {
    nameId = "SWEET_RELEAF",
    colors = {6343571, 3702939, 12353664, 15395562},
    odds = 4
}, {
    nameId = "TAX_THE_POOR",
    colors = {16761374, 15018024, 9475214, 4278081},
    odds = 13
}, {
    nameId = "TEA_ACHE_SEA",
    colors = {16743936, 3756172, 16777215, 16773316},
    odds = 24
}, {
    nameId = "TENPENNY",
    colors = {2899345, 5393472, 16777215, 4210752},
    odds = 10
}, {
    nameId = "THERE_SHE_BLOWS",
    colors = {11645361, 16777215, 16771542, 10123632},
    odds = 2
}, {
    nameId = "THROWING_SHADY",
    colors = {3421236, 5958825, 16771542, 3815994},
    odds = 21
}, {
    nameId = "THUNDER_SKUNK",
    colors = {15851871, 5395026, 15444592, 7820105},
    odds = 20
}, {
    nameId = "TOTAL_BELTER",
    colors = {16777215, 9463517, 7424036, 10129549},
    odds = 1
}, {
    nameId = "TURNT_MOOD",
    colors = {16760556, 16733184, 16767659, 15843765},
    odds = 12
}, {
    nameId = "UPTOWN_RIDER",
    colors = {4781311, 15771930, 16765601, 14144436},
    odds = 14
}, {
    nameId = "WAGE_OF_CONSENT",
    colors = {16760556, 10287103, 16767659, 6708313},
    odds = 21
}, {
    nameId = "WEE_SCUNNER",
    colors = {13083490, 16777215, 9789279, 3815994},
    odds = 8
}, {
    nameId = "WORTH_A_KINGDOM",
    colors = {13810226, 9115524, 5855577, 11645361},
    odds = 2
}, {
    nameId = "YAY_YO_LETS_GO",
    colors = {14176336, 9115524, 13530742, 7105644},
    odds = 3
}, {
    nameId = "YELLOW_SUNSHINE",
    colors = {16770310, 16751169, 16772294, 16777215},
    odds = 5
}}

LuckyWheelItems = {}
LuckyWheelItems["Drinks"] = {
    rotation = {0.0, 73.0, 145.0, 217.0},
    posibility = 100, -- from 1% to 100%
    soundName = "Win_RP",
    animName = "win"
}

LuckyWheelItems["Money1"] = {
    rotation = 343.0,
    posibility = 100,
    soundName = "Win_Cash",
    animName = "win",
    moneyReward = 2500
}

LuckyWheelItems["Money2"] = {
    rotation = 271.0,
    posibility = 90,
    soundName = "Win_Cash",
    animName = "win",
    moneyReward = 5000
}

LuckyWheelItems["Money3"] = {
    rotation = 199.0,
    posibility = 80,
    soundName = "Win_Cash",
    animName = "win",
    moneyReward = 7500
}

LuckyWheelItems["Money4"] = {
    rotation = 127.0,
    posibility = 70,
    soundName = "Win_Cash",
    animName = "win",
    moneyReward = 10000
}

LuckyWheelItems["Money5"] = {
    rotation = 55.0,
    posibility = 60,
    soundName = "Win_Cash",
    animName = "win",
    moneyReward = 15000
}

LuckyWheelItems["Money6"] = {
    rotation = 325.0,
    posibility = 50,
    soundName = "Win_Cash",
    animName = "win_big",
    moneyReward = 20000
}

LuckyWheelItems["Money7"] = {
    rotation = 253.0,
    posibility = 40,
    soundName = "Win_Cash",
    animName = "win_big",
    moneyReward = 30000
}

LuckyWheelItems["Money8"] = {
    rotation = 109.0,
    posibility = 30,
    soundName = "Win_Cash",
    animName = "win_big",
    moneyReward = 40000
}

LuckyWheelItems["Money9"] = {
    rotation = 19.0,
    posibility = 20,
    soundName = "Win_Cash",
    animName = "win_big",
    moneyReward = 50000
}

LuckyWheelItems["Chips1"] = {
    rotation = 307.0,
    posibility = 100,
    soundName = "Win_Chips",
    animName = "win",
    chipsReward = 10000
}

LuckyWheelItems["Chips2"] = {
    rotation = 235.0,
    posibility = 90,
    soundName = "Win_Chips",
    animName = "win",
    chipsReward = 15000
}

LuckyWheelItems["Chips3"] = {
    rotation = 181.0,
    posibility = 80,
    soundName = "Win_Chips",
    animName = "win",
    chipsReward = 20000
}

LuckyWheelItems["Chips4"] = {
    rotation = 91.0,
    posibility = 70,
    soundName = "Win_Chips",
    animName = "win_big",
    chipsReward = 25000
}

LuckyWheelItems["Vehicle"] = {
    rotation = 37.0,
    posibility = 10,
    soundName = "Win_Car",
    animName = "win_huge"
}

LuckyWheelItems["Nothing"] = {
    rotation = 289.0,
    posibility = 100,
    soundName = nil,
    animName = "Nothing"
}

LuckyWheelItems["Random"] = {
    rotation = 163.0,
    posibility = 100,
    soundName = "Win_Mystery",
    animName = "win_big"
}

DrinkingBarChairs = {{
    coords = {937.36140, 29.32331, 70.83323},
    rotation = {0.0, 0.0, -154.28580},
    heading = 205.714
}, {
    coords = {938.899, 29.675, 70.833},
    rotation = {0.0, 0.0, 180.0},
    heading = 180.0
}, {
    coords = {940.453, 29.327, 70.833},
    rotation = {0.0, 0.0, 154.285},
    heading = 154.286
}, {
    coords = {941.695, 28.331, 70.833},
    rotation = {0.0, 0.0, 128.571},
    heading = 128.571
}, {
    coords = {942.377, 26.902, 70.833},
    rotation = {0.0, 0.0, 102.857},
    heading = 102.857
}, {
    coords = {941.699, 23.907, 70.833},
    rotation = {0.0, 0.0, 51.428},
    heading = 51.429
}, {
    coords = {940.461, 22.898, 70.833},
    rotation = {0.0, 0.0, 25.714},
    heading = 25.714
}, {
    coords = {938.917, 22.544, 70.833},
    rotation = {0.0, 0.0, 0.0},
    heading = 0.0
}, {
    coords = {937.3594, 22.9068, 70.833},
    rotation = {0.0, 0.0, -25.714},
    heading = 334.286
}, {
    coords = {936.112, 23.891, 70.833},
    rotation = {0.0, 0.0, -51.428},
    heading = 308.572
}, {
    coords = {935.426, 25.314, 70.833},
    rotation = {0.0, 0.0, -77.142},
    heading = 282.857
}, {
    coords = {935.435, 26.901, 70.833},
    rotation = {0.0, 0.0, -102.857},
    heading = 257.143
}}

-- Adding own items is not supported for now.
-- Titles and prices can be adjusted

CasinoInventoryItems = {{
    key = "casino_beer",
    title = "Pisswasser",
    itemType = 2,
    price = 5,
    consumable = 1
}, {
    key = "casino_vodka",
    title = "Vodka Shot",
    itemType = 2,
    price = 10,
    luckyWheelAffected = true
}, {
    key = "casino_mountshot",
    title = "The Mount Whiskey Shot",
    itemType = 2,
    price = 55,
    luckyWheelAffected = true
}, {
    key = "casino_richardshot",
    title = "Richard's Whiskey Shot",
    itemType = 2,
    price = 190,
    luckyWheelAffected = true
}, {
    key = "casino_macbethshot",
    title = "Macbeth Whiskey Shot",
    itemType = 2,
    price = 350,
    luckyWheelAffected = true
}, {
    key = "casino_silverchamp",
    title = "Blêuter'd Champagne Silver",
    itemType = 2,
    price = 30000,
    vip = true
}, {
    key = "casino_goldchamp",
    title = "Blêuter'd Champagne Gold",
    itemType = 2,
    price = 50000,
    vip = true
}, {
    key = "casino_diamondchamp",
    title = "Blêuter'd Champagne Diamond",
    itemType = 2,
    price = 150000,
    vip = true
}, {
    key = Config.ChipsInventoryItem,
    title = "Diamond Casino Chips",
    itemType = 0
}, {
    key = "casino_beer",
    title = "Pisswasser",
    itemType = 1,
    price = 5,
    consumable = 1
}, {
    key = "casino_burger",
    title = "Burger",
    itemType = 1,
    price = 5,
    consumable = 2
}, {
    key = "casino_coke",
    title = "Kofola",
    itemType = 1,
    price = 5,
    consumable = 1
}, {
    key = "casino_sprite",
    title = "Sprite",
    itemType = 1,
    price = 5,
    consumable = 1
}, {
    key = "casino_luckypotion",
    title = "Lucky Potion",
    itemType = 1,
    price = 50,
    consumable = 1
}, {
    key = "casino_psqs",
    title = "P’s & Q’s",
    itemType = 1,
    price = 3,
    consumable = 2
}, {
    key = "casino_ego_chaser",
    title = "Ego Chaser",
    itemType = 1,
    price = 3,
    consumable = 2
}, {
    key = "casino_sandwitch",
    title = "Sandwitch",
    itemType = 1,
    price = 5,
    consumable = 2
}, {
    key = "casino_donut",
    title = "Donut",
    itemType = 1,
    price = 3,
    consumable = 2
}, {
    key = "casino_coffee",
    title = "Coffee",
    itemType = 1,
    price = 10,
    consumable = 1
}}

-- these are inventory items that players can win after spinning "Random" on the Lucky Wheel.
LuckyWheelRandomItems = {{
    inventoryName = "bread", -- item (inventory) name/key, case sensitive
    title = "Pain", -- title for the Lucky Wheel reward message
    amount = {1, 10} -- amount (random between 1 to 10)
}, {
    inventoryName = "water", -- item (inventory) name/key, case sensitive
    title = "Eau", -- title for the Lucky Wheel reward message
    amount = {1, 10} -- only 1
}}

PokerTableDatas = {}
PokerTableDatas[0] = {
    Banner = "casinoui_cards_three",
    Title = "Poker",
    PlaceBetsTime = 40,
    MinBetValueAntePlay = 10,
    MaxBetValueAntePlay = 5000,
    MinBetValuePairPlus = 10,
    MaxBetValuePairPlus = 500,
    UnluckyRound = 3 -- each 3rd round will be unlucky (high possibility that players get useless cards)
}

PokerTableDatas[2] = {
    Banner = "casinoui_cards_three_junior",
    Title = "Poker Junior",
    PlaceBetsTime = 15,
    MinBetValueAntePlay = 10,
    MaxBetValueAntePlay = 500,
    MinBetValuePairPlus = 10,
    MaxBetValuePairPlus = 50,
    UnluckyRound = 3 -- each 3rd round will be unlucky (high possibility that players get useless cards)
}

PokerTableDatas[3] = {
    Banner = "casinoui_cards_three_high",
    Title = "Poker High Stakes",
    PlaceBetsTime = 40,
    MinBetValueAntePlay = 1000,
    MaxBetValueAntePlay = 50000,
    MinBetValuePairPlus = 1000,
    MaxBetValuePairPlus = 5000,
    VIP = true,
    UnluckyRound = 3 -- each 3rd round will be unlucky (high possibility that players get useless cards)
}

BlackJackCardScores = {11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11, 2, 3,
                       4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10}

function BlackjackGetScoreFromCards(cards)
    local indexes = {}
    for k, v in pairs(cards) do
        table.insert(indexes, v.value)
    end
    return BlackjackCalculatePlayerHandScore(indexes)
end

-- calculate score from indexes
function BlackjackCalculatePlayerHandScore(cards)
    local total = 0
    local softHand = false

    for _, v in pairs(cards) do
        local s = BlackJackCardScores[v]
        if s == 11 then
            s = 1
            softHand = true
        end
        total = total + s
    end

    -- back from Ace *1* to Ace *11* to help the player
    if softHand and (total + 10) <= 21 then
        total = total + 10
    end

    if total == 21 and #(cards) == 2 then
        total = "blackjack"
    end

    return total, softHand
end

BlackjackTableDatas = {}

BlackjackTableDatas[0] = {
    Banner = "casinoui_cards_blackjack",
    Title = "Blackjack",
    PlaceBetsTime = 40,
    MinimumBet = 10,
    MaximumBet = 5000
}

BlackjackTableDatas[3] = {
    Banner = "casinoui_cards_blackjack_high",
    Title = "Blackjack High Stakes",
    PlaceBetsTime = 40,
    MinimumBet = 1000,
    MaximumBet = 50000,
    VIP = true
}

BlackjackTableDatas[2] = {
    Banner = "casinoui_cards_blackjack_junior",
    Title = "Blackjack Junior",
    PlaceBetsTime = 15,
    MinimumBet = 2,
    MaximumBet = 200
}

RouletteAnimationNumbers = {38, 19, 34, 15, 30, 11, 26, 7, 22, 3, 25, 6, 37, 18, 33, 14, 29, 10, 8, 27, 12, 31, 16, 35,
                            4, 23, 2, 21, 5, 24, 9, 28, 13, 32, 17, 36, 1, 20}

RouletteTableDatas = {}

RouletteTableDatas[0] = {
    Banner = "casinoui_roulette",
    Title = "Roulette",
    MaxBets = 10,
    MinBetValue = 10,
    MaxBetValue = 500,
    MaxBetValueOutside = 5000,
    MaxBetValueInside = 500,
    PlaceBetsTime = 40,
    SpinDelayMin = 5,
    SpinDelayMax = 12,
    UnluckyRound = 4, -- each 4th round spins to the unluckiest number and costs casino the least
    TriggerUnluckyRoundFrom = 10000 -- always switch to unluckiest number if the spun number costs casino more than this
}

RouletteTableDatas[2] = {
    Banner = "casinoui_roulette_junior",
    Title = "Roulette Junior",
    MaxBets = 10,
    MinBetValue = 1,
    MaxBetValue = 1000,
    MaxBetValueOutside = 1000,
    MaxBetValueInside = 200,
    PlaceBetsTime = 15,
    SpinDelayMin = 1,
    SpinDelayMax = 1,
    UnluckyRound = 6, -- each 6th round spins to the unluckiest number and costs casino the least
    TriggerUnluckyRoundFrom = 5000 -- always switch to unluckiest number if the spun number costs casino more than this
}

RouletteTableDatas[3] = {
    Banner = "casinoui_roulette_high",
    Title = "Roulette High Stakes",
    MaxBets = 10,
    MinBetValue = 100,
    MaxBetValue = 5000,
    MaxBetValueOutside = 50000,
    MaxBetValueInside = 5000,
    PlaceBetsTime = 40,
    SpinDelayMin = 5,
    SpinDelayMax = 12,
    VIP = true,
    UnluckyRound = 3, -- each 3rd round spins to the unluckiest number and costs casino the least
    TriggerUnluckyRoundFrom = 50000 -- always switch to unluckiest number if the spun number costs casino more than this
}

RouletteMaleVoices = {"S_M_Y_Casino_01_WHITE_01", "S_M_Y_Casino_01_WHITE_02", "S_M_Y_Casino_01_ASIAN_01",
                      "S_M_Y_Casino_01_ASIAN_02"}
RouletteFemaleVoices = {"S_F_Y_Casino_01_ASIAN_01", "S_F_Y_Casino_01_ASIAN_02", "S_F_Y_Casino_01_LATINA_01",
                        "S_F_Y_Casino_01_LATINA_02"}

-- Poker
PokerLetterIndex = {"a", "b", "c"}

PokerCardModels = {
    [1] = 'vw_prop_vw_club_char_a_a',
    [2] = 'vw_prop_vw_club_char_02a',
    [3] = 'vw_prop_vw_club_char_03a',
    [4] = 'vw_prop_vw_club_char_04a',
    [5] = 'vw_prop_vw_club_char_05a',
    [6] = 'vw_prop_vw_club_char_06a',
    [7] = 'vw_prop_vw_club_char_07a',
    [8] = 'vw_prop_vw_club_char_08a',
    [9] = 'vw_prop_vw_club_char_09a',
    [10] = 'vw_prop_vw_club_char_10a',
    [11] = 'vw_prop_vw_club_char_j_a',
    [12] = 'vw_prop_vw_club_char_q_a',
    [13] = 'vw_prop_vw_club_char_k_a',
    [14] = 'vw_prop_vw_dia_char_a_a',
    [15] = 'vw_prop_vw_dia_char_02a',
    [16] = 'vw_prop_vw_dia_char_03a',
    [17] = 'vw_prop_vw_dia_char_04a',
    [18] = 'vw_prop_vw_dia_char_05a',
    [19] = 'vw_prop_vw_dia_char_06a',
    [20] = 'vw_prop_vw_dia_char_07a',
    [21] = 'vw_prop_vw_dia_char_08a',
    [22] = 'vw_prop_vw_dia_char_09a',
    [23] = 'vw_prop_vw_dia_char_10a',
    [24] = 'vw_prop_vw_dia_char_j_a',
    [25] = 'vw_prop_vw_dia_char_q_a',
    [26] = 'vw_prop_vw_dia_char_k_a',
    [27] = 'vw_prop_vw_hrt_char_a_a',
    [28] = 'vw_prop_vw_hrt_char_02a',
    [29] = 'vw_prop_vw_hrt_char_03a',
    [30] = 'vw_prop_vw_hrt_char_04a',
    [31] = 'vw_prop_vw_hrt_char_05a',
    [32] = 'vw_prop_vw_hrt_char_06a',
    [33] = 'vw_prop_vw_hrt_char_07a',
    [34] = 'vw_prop_vw_hrt_char_08a',
    [35] = 'vw_prop_vw_hrt_char_09a',
    [36] = 'vw_prop_vw_hrt_char_10a',
    [37] = 'vw_prop_vw_hrt_char_j_a',
    [38] = 'vw_prop_vw_hrt_char_q_a',
    [39] = 'vw_prop_vw_hrt_char_k_a',
    [40] = 'vw_prop_vw_spd_char_a_a',
    [41] = 'vw_prop_vw_spd_char_02a',
    [42] = 'vw_prop_vw_spd_char_03a',
    [43] = 'vw_prop_vw_spd_char_04a',
    [44] = 'vw_prop_vw_spd_char_05a',
    [45] = 'vw_prop_vw_spd_char_06a',
    [46] = 'vw_prop_vw_spd_char_07a',
    [47] = 'vw_prop_vw_spd_char_08a',
    [48] = 'vw_prop_vw_spd_char_09a',
    [49] = 'vw_prop_vw_spd_char_10a',
    [50] = 'vw_prop_vw_spd_char_j_a',
    [51] = 'vw_prop_vw_spd_char_q_a',
    [52] = 'vw_prop_vw_spd_char_k_a'
}

function GetPlayingCardType(index)
    if index >= 1 and index <= 13 then -- CLUBS
        return 0
    elseif index >= 14 and index <= 26 then -- DIAMOND
        return 1
    elseif index >= 26 and index <= 39 then -- HEARTS
        return 2
    elseif index >= 39 and index <= 52 then -- SPADES
        return 3
    end
end

function PokerGetPairMultiplier(handValue)
    if handValue > 500 then
        return 40
    elseif handValue > 400 then
        return 30
    elseif handValue > 300 then
        return 6
    elseif handValue > 200 then
        return 4
    elseif handValue > 100 then
        return 1
    end

    return 0
end

function PokerGetAnteMultiplier(handValue)
    if handValue > 500 then
        return 5
    elseif handValue > 400 then
        return 4
    elseif handValue > 300 then
        return 1
    end
    return 0
end

function PokerGetChipModel(amount)
    if amount <= 10 then
        return GetHashKey('vw_prop_chip_10dollar_x1'), 0
    elseif amount > 10 and amount < 50 then
        return GetHashKey('vw_prop_chip_10dollar_st'), 10
    elseif amount >= 50 and amount < 100 then
        return GetHashKey('vw_prop_chip_50dollar_x1'), 0
    elseif amount >= 100 and amount < 200 then
        return GetHashKey('vw_prop_chip_100dollar_x1'), 0
    elseif amount >= 200 and amount < 500 then
        return GetHashKey('vw_prop_chip_100dollar_st'), 100
    elseif amount == 500 then
        return GetHashKey('vw_prop_chip_500dollar_x1'), 0
    elseif amount > 500 and amount < 1000 then
        return GetHashKey('vw_prop_chip_500dollar_st'), 500
    elseif amount == 1000 then
        return GetHashKey('vw_prop_chip_1kdollar_x1'), 0
    elseif amount > 1000 and amount < 5000 then
        return GetHashKey('vw_prop_chip_1kdollar_st'), 1000
    elseif amount == 5000 then
        return GetHashKey('vw_prop_plaq_5kdollar_x1'), 0
    elseif amount > 5000 and amount < 10000 then
        return GetHashKey('vw_prop_plaq_5kdollar_st'), 5000
    elseif amount == 10000 then
        return GetHashKey('vw_prop_plaq_10kdollar_x1'), 0
    elseif amount > 10000 then
        return GetHashKey('vw_prop_plaq_10kdollar_st'), 10000
    end
end

function GetPlayingCardValue(index)
    local vals = {
        -- 2
        [2] = 2,
        [15] = 2,
        [28] = 2,
        [41] = 2,
        -- 3
        [3] = 3,
        [16] = 3,
        [29] = 3,
        [42] = 3,
        -- 4
        [4] = 4,
        [17] = 4,
        [30] = 4,
        [43] = 4,
        -- 5
        [5] = 5,
        [18] = 5,
        [31] = 5,
        [44] = 5,
        -- 6
        [6] = 6,
        [19] = 6,
        [32] = 6,
        [45] = 6,
        -- 7
        [7] = 7,
        [20] = 7,
        [33] = 7,
        [46] = 7,
        -- 8
        [8] = 8,
        [21] = 8,
        [34] = 8,
        [47] = 8,
        -- 9
        [9] = 9,
        [22] = 9,
        [35] = 9,
        [48] = 9,
        -- 10
        [10] = 10,
        [23] = 10,
        [36] = 10,
        [49] = 10,
        -- JACK
        [11] = 11,
        [24] = 11,
        [37] = 11,
        [50] = 11,
        -- QUEEN
        [12] = 12,
        [25] = 12,
        [38] = 12,
        [51] = 12,
        -- KING
        [13] = 13,
        [26] = 13,
        [39] = 13,
        [52] = 13,
        -- ACE
        [1] = 14,
        [14] = 14,
        [27] = 14,
        [40] = 14
    }

    if vals[index] then
        return vals[index]
    else
        return 0
    end
end

PokerGetAllHandValues = function(handTable, bool_1, bool_2)
    if type(handTable) == 'table' then
        local c1, c2, c3 = GetPlayingCardValue(handTable[1]), GetPlayingCardValue(handTable[2]),
            GetPlayingCardValue(handTable[3])

        local handValue = 0

        -- FIRST CHECK
        if (c1 ~= c2 and c1 ~= c3) and c2 ~= c3 then
            local Flush = false

            handValue = c1 + c2 + c3

            if handValue == 19 then
                if (c1 == 14 or c1 == 2 or c1 == 3) and (c2 == 14 or c2 == 2 or c2 == 3) and
                    (c3 == 14 or c3 == 2 or c3 == 3) then
                    Flush = true
                end
            elseif handValue == 9 then
                if (c1 == 2 or c1 == 3 or c1 == 4) and (c2 == 2 or c2 == 3 or c2 == 4) and
                    (c3 == 2 or c3 == 3 or c3 == 4) then
                    Flush = true
                end
            elseif handValue == 12 then
                if (c1 == 3 or c1 == 4 or c1 == 5) and (c2 == 3 or c2 == 4 or c2 == 5) and
                    (c3 == 3 or c3 == 4 or c3 == 5) then
                    Flush = true
                end
            elseif handValue == 15 then
                if (c1 == 4 or c1 == 5 or c1 == 6) and (c2 == 4 or c2 == 5 or c2 == 6) and
                    (c3 == 4 or c3 == 5 or c3 == 6) then
                    Flush = true
                end
            elseif handValue == 18 then
                if (c1 == 5 or c1 == 6 or c1 == 7) and (c2 == 5 or c2 == 6 or c2 == 7) and
                    (c3 == 5 or c3 == 6 or c3 == 7) then
                    Flush = true
                end
            elseif handValue == 21 then
                if (c1 == 6 or c1 == 7 or c1 == 8) and (c2 == 6 or c2 == 7 or c2 == 8) and
                    (c3 == 6 or c3 == 7 or c3 == 8) then
                    Flush = true
                end
            elseif handValue == 24 then
                if (c1 == 7 or c1 == 8 or c1 == 9) and (c2 == 7 or c2 == 8 or c2 == 9) and
                    (c3 == 7 or c3 == 8 or c3 == 9) then
                    Flush = true
                end
            elseif handValue == 27 then
                if (c1 == 8 or c1 == 9 or c1 == 10) and (c2 == 8 or c2 == 9 or c2 == 10) and
                    (c3 == 8 or c3 == 9 or c3 == 10) then
                    Flush = true
                end
            elseif handValue == 30 then
                if (c1 == 9 or c1 == 10 or c1 == 11) and (c2 == 9 or c2 == 10 or c2 == 11) and
                    (c3 == 9 or c3 == 10 or c3 == 11) then
                    Flush = true
                end
            elseif handValue == 33 then
                if (c1 == 10 or c1 == 11 or c1 == 12) and (c2 == 10 or c2 == 11 or c2 == 12) and
                    (c3 == 10 or c3 == 11 or c3 == 12) then
                    Flush = true
                end
            elseif handValue == 36 then
                if (c1 == 11 or c1 == 12 or c1 == 13) and (c2 == 11 or c2 == 12 or c2 == 13) and
                    (c3 == 11 or c3 == 12 or c3 == 13) then
                    -- something true
                    Flush = true
                end
            elseif handValue == 39 then
                if (c1 == 12 or c1 == 13 or c1 == 14) and (c2 == 12 or c2 == 13 or c2 == 14) and
                    (c3 == 12 or c3 == 13 or c3 == 14) then
                    -- something true
                    Flush = true
                end
            end

            if Flush then
                if handValue == 19 then
                    handValue = 6
                end

                if GetPlayingCardType(handTable[1]) == GetPlayingCardType(handTable[2]) and
                    GetPlayingCardType(handTable[1]) == GetPlayingCardType(handTable[3]) then
                    return handValue + 500
                end

                return handValue + 300
            end
        end

        handValue = 0

        -- SECOND CHECK
        if (c1 == c2) and c1 ~= c3 then -- pairs
            if not bool_1 and not bool_2 then
                return (c1 + c2) + 100
            else
                return c3
            end
        elseif (c2 == c3) and c2 ~= c1 then -- pairs
            if not bool_1 and not bool_2 then
                return (c2 + c3) + 100
            else
                return c1
            end
        elseif (c3 == c1) and c3 ~= c2 then -- pairs
            if not bool_1 and not bool_2 then
                return (c1 + c3) + 100
            else
                return c2
            end
        elseif c1 == c2 and c1 == c3 then -- 3 of a kind
            return c1 + c2 + c3 + 400
        elseif GetPlayingCardType(handTable[1]) == GetPlayingCardType(handTable[2]) and GetPlayingCardType(handTable[1]) ==
            GetPlayingCardType(handTable[3]) then
            handValue = 200
        end

        -- third check if it runs here

        if c1 > c2 and c1 > c3 then
            if bool_1 then
                if c2 > c3 then
                    return handValue + c2
                else
                    return handValue + c3
                end
            elseif bool_2 then
                if c2 > c3 then
                    return handValue + c3
                else
                    return handValue + c2
                end
            end

            return handValue + c1
        elseif c2 > c1 and c2 > c3 then
            if bool_1 then
                if c1 > c3 then
                    return handValue + c1
                else
                    return handValue + c3
                end
            elseif bool_2 then
                if c1 > c3 then
                    return handValue + c3
                else
                    return handValue + c1
                end
            end

            return handValue + c2
        elseif c3 > c1 and c3 > c2 then
            if bool_1 then
                if c1 > c2 then
                    return handValue + c1
                else
                    return handValue + c2
                end
            elseif bool_2 then
                if c1 > c2 then
                    return handValue + c2
                else
                    return handValue + c1
                end
            end

            return handValue + c3
        end

        return handValue
    else
        return 0
    end
end

PokerHandValueCode = function(handValue)
    if handValue > 500 then
        return "STRAIGHT_FLUSH"
    elseif handValue > 400 then
        return "THREE_OF_A_KIND"
    elseif handValue > 300 then
        return "STRAIGHT"
    elseif handValue > 200 then
        return "FLUSH"
    elseif handValue > 100 then
        if handValue == 128 then
            return "PAIR_OF_ACES"
        elseif handValue == 104 then
            return "PAIR_OF_2"
        elseif handValue == 106 then
            return "PAIR_OF_3"
        elseif handValue == 108 then
            return "PAIR_OF_4"
        elseif handValue == 110 then
            return "PAIR_OF_5"
        elseif handValue == 112 then
            return "PAIR_OF_6"
        elseif handValue == 114 then
            return "PAIR_OF_7"
        elseif handValue == 116 then
            return "PAIR_OF_8"
        elseif handValue == 118 then
            return "PAIR_OF_9"
        elseif handValue == 120 then
            return "PAIR_OF_10"
        elseif handValue == 122 then
            return "PAIR_OF_JACKS"
        elseif handValue == 124 then
            return "PAIR_OF_QUEENS"
        elseif handValue == 126 then
            return "PAIR_OF_KINGS"
        end
    elseif handValue == 2 then
        return "CARD_2_HIGH"
    elseif handValue == 3 then
        return "CARD_3_HIGH"
    elseif handValue == 4 then
        return "CARD_4_HIGH"
    elseif handValue == 5 then
        return "CARD_5_HIGH"
    elseif handValue == 6 then
        return "CARD_6_HIGH"
    elseif handValue == 7 then
        return "CARD_7_HIGH"
    elseif handValue == 8 then
        return "CARD_8_HIGH"
    elseif handValue == 9 then
        return "CARD_9_HIGH"
    elseif handValue == 10 then
        return "CARD_10_HIGH"
    elseif handValue == 11 then
        return "CARD_JACK_HIGH"
    elseif handValue == 12 then
        return "CARD_QUEEN_HIGH"
    elseif handValue == 13 then
        return "CARD_KING_HIGH"
    else
        return "CARD_ACE_HIGH"
    end

    return ''
end

CashierDatas = {{
    coords = vector3(950.038879, 31.957714, 71.838463),
    heading = 79.5398,
    model = "a_f_y_bevhills_02",
    enabled = false
}, {
    coords = vector3(950.305969, 33.064224, 71.838608),
    heading = 62.3299,
    model = "a_f_y_business_04",
    enabled = true
}, {
    coords = vector3(951.129578, 33.638176, 71.838776),
    heading = 29.9910,
    model = "a_f_y_bevhills_04",
    enabled = false
}}

RestrictedAreas = {{
    coords = vector3(971.588440, 55.133335, 71.232895),
    radius = 4,
    safearea = vector3(970.177429, 60.277283, 70.833603),
    type = 1 -- vip area
}, {
    coords = vector3(973.960022, 43.803104, 71.232925),
    radius = 4,
    safearea = vector3(975.234436, 39.013519, 70.833046),
    type = 1
}, {
    coords = vector3(973.904480, 72.475937, 70.233070),
    radius = 4,
    safearea = vector3(978.945190, 67.074020, 70.232880),
    type = 2 -- boss area
}, {
    coords = vector3(983.803284, 31.696259, 70.239868),
    radius = 4,
    safearea = vector3(985.455200, 36.655685, 70.232964),
    type = 2 -- boss area #2
}}

CasinoSeating = {{
    type = "vip",
    coords = vector3(973.864197, 57.084072, 70.683571),
    heading = 127.8010559082
}, {
    type = "vip",
    coords = vector3(974.217041, 56.559361, 70.683617),
    heading = 118.2010559082
}, {
    type = "vip",
    coords = vector3(974.477234, 55.974682, 70.683617),
    heading = 105.9010559082
}, {
    type = "vip",
    coords = vector3(974.602844, 55.398994, 70.683571),
    heading = 97.5010559082
}, {
    type = "vip",
    coords = vector3(974.623779, 54.772339, 70.683571),
    heading = 85.8010559082
}, {
    type = "vip",
    coords = vector3(974.531067, 54.148682, 70.683571),
    heading = 73.801055908201
}, {
    type = "vip",
    coords = vector3(974.297791, 53.572998, 70.683571),
    heading = 63.301055908201
}, {
    type = "vip",
    coords = vector3(973.956787, 53.066277, 70.683571),
    heading = 51.901055908201
}, {
    type = "vip",
    coords = vector3(973.511169, 52.604530, 70.683571),
    heading = 40.501055908201
}, {
    type = "vip",
    coords = vector3(973.026672, 52.262718, 70.683571),
    heading = 28.501055908201
}, {
    type = "vip",
    coords = vector3(972.455444, 51.992867, 70.683571),
    heading = 18.901055908201
}, {
    type = "vip",
    coords = vector3(971.872253, 51.866936, 70.683571),
    heading = 7.5010559082008
}, {
    type = "vip",
    coords = vector3(971.220276, 51.821964, 70.683655),
    heading = -3.5989440917991
}, {
    type = "vip",
    coords = vector3(970.637085, 51.935902, 70.683655),
    heading = -15.298944091799
}, {
    type = "vip",
    coords = vector3(970.056885, 52.181767, 70.683655),
    heading = -25.798944091799
}, {
    type = "vip",
    coords = vector3(969.539490, 52.484600, 70.683655),
    heading = -38.098944091799
}, {
    type = "vip",
    coords = vector3(969.063965, 52.910366, 70.683655),
    heading = -46.798944091799
}, {
    type = "vip",
    coords = vector3(968.737976, 53.405094, 70.683655),
    heading = -57.598944091799
}, {
    type = "vip",
    coords = vector3(968.441895, 53.950798, 70.683578),
    heading = -71.698944091799
}, {
    type = "vip",
    coords = vector3(968.295349, 54.556465, 70.683578),
    heading = -82.798944091799
}, {
    type = "vip",
    coords = vector3(968.271423, 55.183121, 70.683578),
    heading = -92.098944091799
}, {
    type = "vip",
    coords = vector3(968.367126, 55.803780, 70.683578),
    heading = -102.5989440918
}, {
    type = "vip",
    coords = vector3(971.462097, 42.408127, 70.683571),
    heading = 307.801
}, {
    type = "vip",
    coords = vector3(971.100220, 42.911850, 70.683571),
    heading = 298.201
}, {
    type = "vip",
    coords = vector3(970.863953, 43.505524, 70.683571),
    heading = 287.401
}, {
    type = "vip",
    coords = vector3(970.711426, 44.102196, 70.683571),
    heading = 276.601
}, {
    type = "vip",
    coords = vector3(970.684509, 44.740845, 70.683571),
    heading = 264.601
}, {
    type = "vip",
    coords = vector3(970.783203, 45.343513, 70.683571),
    heading = 254.401
}, {
    type = "vip",
    coords = vector3(971.022461, 45.928192, 70.683571),
    heading = 242.401
}, {
    type = "vip",
    coords = vector3(971.351440, 46.449905, 70.683571),
    heading = 232.801
}, {
    type = "vip",
    coords = vector3(971.785095, 46.923645, 70.683571),
    heading = 220.501
}, {
    type = "vip",
    coords = vector3(972.278564, 47.286446, 70.683571),
    heading = 210.001
}, {
    type = "vip",
    coords = vector3(972.879700, 47.520317, 70.683571),
    heading = 198.901
}, {
    type = "vip",
    coords = vector3(973.465881, 47.661240, 70.683571),
    heading = 187.201
}, {
    type = "vip",
    coords = vector3(974.090942, 47.685226, 70.683571),
    heading = 176.701
}, {
    type = "vip",
    coords = vector3(974.698059, 47.598274, 70.683571),
    heading = 163.8009
}, {
    type = "vip",
    coords = vector3(975.293213, 47.382393, 70.683571),
    heading = 153.90099999999
}, {
    type = "vip",
    coords = vector3(975.825562, 47.067566, 70.683571),
    heading = 141.30099999999
}, {
    type = "vip",
    coords = vector3(976.283142, 46.632805, 70.683571),
    heading = 131.40099999999
}, {
    type = "vip",
    coords = vector3(976.645020, 46.117088, 70.683571),
    heading = 119.70099999999
}, {
    type = "vip",
    coords = vector3(976.890259, 45.559395, 70.683571),
    heading = 109.50099999999
}, {
    type = "vip",
    coords = vector3(977.048767, 44.959724, 70.683571),
    heading = 96.600999999993
}, {
    type = "vip",
    coords = vector3(977.075684, 44.324074, 70.683571),
    heading = 86.400999999994
}, {
    type = "vip",
    coords = vector3(977.006897, 43.685425, 70.683571),
    heading = 75.600999999994
}, {
    type = "main",
    coords = vector3(949.020020, 25.384600, 71.283943),
    heading = 383.401
}, {
    type = "main",
    coords = vector3(948.412903, 25.117577, 71.283943),
    heading = 387.301
}, {
    type = "main",
    coords = vector3(947.799805, 24.733543, 71.283943),
    heading = 392.101
}, {
    type = "main",
    coords = vector3(947.234558, 24.331509, 71.283943),
    heading = 398.701
}, {
    type = "main",
    coords = vector3(946.678284, 23.845467, 71.283943),
    heading = 402.601
}, {
    type = "main",
    coords = vector3(946.175842, 23.368425, 71.283943),
    heading = 407.101
}, {
    type = "main",
    coords = vector3(945.748169, 22.843380, 71.283943),
    heading = 411.301
}, {
    type = "main",
    coords = vector3(945.320496, 22.252329, 71.283943),
    heading = 413.401
}, {
    type = "main",
    coords = vector3(944.964600, 21.718283, 71.283943),
    heading = 413.401
}, {
    type = "main",
    coords = vector3(944.551880, 21.247242, 71.283943),
    heading = 408.601
}, {
    type = "main",
    coords = vector3(944.142151, 20.761200, 71.283943),
    heading = 404.101
}, {
    type = "main",
    coords = vector3(943.696533, 20.353165, 71.283943),
    heading = 399.901
}, {
    type = "main",
    coords = vector3(943.215027, 19.975132, 71.283943),
    heading = 393.601
}, {
    type = "main",
    coords = vector3(942.655762, 19.636103, 71.283943),
    heading = 390.301
}, {
    type = "main",
    coords = vector3(942.096497, 19.339077, 71.283943),
    heading = 384.301
}, {
    type = "main",
    coords = vector3(941.540222, 19.117058, 71.283943),
    heading = 378.901
}, {
    type = "main",
    coords = vector3(940.957031, 18.907040, 71.283943),
    heading = 375.301
}, {
    type = "main",
    coords = vector3(940.328979, 18.760027, 71.283943),
    heading = 370.501
}, {
    type = "main",
    coords = vector3(939.715881, 18.667019, 71.283943),
    heading = 364.201
}, {
    type = "main",
    coords = vector3(939.102783, 18.652018, 71.283943),
    heading = 360.601
}, {
    type = "main",
    coords = vector3(938.474731, 18.673019, 71.283943),
    heading = 355.801
}, {
    type = "main",
    coords = vector3(937.837708, 18.721024, 71.283943),
    heading = 352.201
}, {
    type = "main",
    coords = vector3(937.248535, 18.787029, 71.283943),
    heading = 347.101
}, {
    type = "main",
    coords = vector3(936.599548, 18.991047, 71.283943),
    heading = 345.301
}, {
    type = "main",
    coords = vector3(935.923645, 19.123058, 71.283943),
    heading = 349.501
}, {
    type = "main",
    coords = vector3(935.238770, 19.210066, 71.283943),
    heading = 355.201
}, {
    type = "main",
    coords = vector3(934.506042, 19.231068, 71.283943),
    heading = 359.401
}, {
    type = "main",
    coords = vector3(933.764343, 19.222067, 71.283943),
    heading = 364.201
}, {
    type = "main",
    coords = vector3(933.070496, 19.117058, 71.283943),
    heading = 369.601
}, {
    type = "main",
    coords = vector3(932.430481, 18.985046, 71.283943),
    heading = 372.301
}, {
    type = "corner1",
    coords = vector3(948.023865, 37.068600, 71.104912),
    heading = 388.801
}, {
    type = "corner1",
    coords = vector3(953.250854, 36.772335, 71.104912),
    heading = 320.0
}, {
    type = "aroundpodium",
    coords = vector3(931.415771, 36.241268, 71.545090),
    heading = 146.0
}, {
    type = "aroundpodium",
    coords = vector3(932.543274, 35.710560, 71.545090),
    heading = 158.0
}, {
    type = "aroundpodium",
    coords = vector3(933.709656, 35.356754, 71.545090),
    heading = 167.0
}, {
    type = "aroundpodium",
    coords = vector3(934.944824, 35.281796, 71.545090),
    heading = 178.0
}, {
    type = "aroundpodium",
    coords = vector3(936.102234, 35.320774, 71.545090),
    heading = 185.0
}, {
    type = "aroundpodium",
    coords = vector3(937.304504, 35.626606, 71.545090),
    heading = 197.0
}, {
    type = "aroundpodium",
    coords = vector3(938.393127, 36.034382, 71.545090),
    heading = 205.0
}, {
    type = "aroundpodium",
    coords = vector3(939.478760, 36.667034, 71.544601),
    heading = 214.0
}, {
    type = "aroundpodium",
    coords = vector3(940.390930, 37.497578, 71.544601),
    heading = 224.0
}, {
    type = "aroundpodium",
    coords = vector3(941.204407, 38.508022, 71.544601),
    heading = 233.0
}, {
    type = "aroundpodium",
    coords = vector3(941.808533, 39.608418, 71.544601),
    heading = 245.0
}, {
    type = "aroundpodium",
    coords = vector3(942.230225, 40.783772, 71.544601),
    heading = 252.0
}, {
    type = "aroundpodium",
    coords = vector3(942.415649, 41.956127, 71.544601),
    heading = 263.0
}, {
    type = "aroundpodium",
    coords = vector3(942.427612, 42.984562, 71.544601),
    heading = 272.3
}, {
    type = "office_sofa",
    coords = vector3(955.623840, 61.706299, 74.866776),
    heading = 236.65
}, {
    type = "office_sofa",
    coords = vector3(956.034241, 62.426178, 74.866776),
    heading = 236.65
}, {
    type = "office_sofa",
    coords = vector3(956.474670, 63.116062, 74.866776),
    heading = 236.65
}, {
    type = "office_chair",
    coords = vector3(958.139893, 57.111599, 74.949997),
    heading = -69.35 + 180.0
}, {
    type = "office_chair",
    coords = vector3(957.042297, 57.897167, 74.949997),
    heading = 189.4
}}

SLOT_MACHINE_COORDS = {{654385216, vector3(941.029907, 51.136482, 70.432777), 13.000042915344,
                        vector3(0.0, 0.0, 13.000043)},
                       {161343630, vector3(941.731262, 51.398033, 70.432777), 28.000038146973,
                        vector3(0.0, 0.0, 28.000038)},
                       {1096374064, vector3(942.337402, 51.835964, 70.432777), 42.999984741211,
                        vector3(0.0, 0.0, 42.999985)},
                       {207578973, vector3(942.814697, 52.407734, 70.432777), 57.999969482422,
                        vector3(0.0, 0.0, 57.999969)},
                       {-487222358, vector3(943.127686, 53.084503, 70.432777), 73.000068664551,
                        vector3(0.0, 0.0, 73.000069)},
                       {-1932041857, vector3(953.007874, 54.348637, 70.432762), 283.00006103516,
                        vector3(0.0, 0.0, -76.999924)},
                       {-1519644200, vector3(953.274963, 53.648956, 70.432762), 298.0, vector3(0.0, 0.0, -62.000008)},
                       {-430989390, vector3(953.712097, 53.039745, 70.432762), 313.00003051758,
                        vector3(0.0, 0.0, -46.999981)},
                       {654385216, vector3(954.290283, 52.559547, 70.432762), 328.0, vector3(0.0, 0.0, -32.000000)},
                       {161343630, vector3(954.970764, 52.248093, 70.432762), 342.99996948242,
                        vector3(0.0, 0.0, -17.000023)},
                       {1096374064, vector3(955.706421, 52.122353, 70.432762), 358.0, vector3(0.0, 0.0, -1.999995)},
                       {207578973, vector3(956.448669, 52.192181, 70.432770), 12.99991607666,
                        vector3(0.0, 0.0, 12.999916)},
                       {-1932041857, vector3(959.764221, 42.677299, 70.432777), 223.00009155273,
                        vector3(0.0, 0.0, -136.999908)},
                       {-1519644200, vector3(959.289917, 42.107395, 70.432777), 238.00001525879,
                        vector3(0.0, 0.0, -121.999985)},
                       {-430989390, vector3(958.983582, 41.427593, 70.432777), 253.0, vector3(0.0, 0.0, -106.999992)},
                       {161343630, vector3(955.422791, 41.357056, 70.432762), 76.000022888184,
                        vector3(0.0, 0.0, 76.000023)},
                       {654385216, vector3(958.857544, 40.694187, 70.432777), 268.00006103516,
                        vector3(0.0, 0.0, -91.999931)},
                       {161343630, vector3(958.932800, 39.952370, 70.432777), 283.00006103516,
                        vector3(0.0, 0.0, -76.999924)},
                       {1096374064, vector3(954.714355, 40.779537, 70.432762), 4.0000133514404,
                        vector3(0.0, 0.0, 4.000013)},
                       {207578973, vector3(953.946228, 41.274803, 70.432762), 292.0, vector3(0.0, 0.0, -68.000015)},
                       {-487222358, vector3(954.179932, 42.158409, 70.432762), 220.00006103516,
                        vector3(0.0, 0.0, -139.999939)},
                       {654385216, vector3(955.092407, 42.209244, 70.432762), 147.99998474121,
                        vector3(0.0, 0.0, 147.999985)},
                       {-430989390, vector3(954.687195, 46.439892, 70.432762), 4.0000133514404,
                        vector3(0.0, 0.0, 4.000013)},
                       {-1519644200, vector3(955.395569, 47.017410, 70.432762), 76.000022888184,
                        vector3(0.0, 0.0, 76.000023)},
                       {-1932041857, vector3(955.065247, 47.869606, 70.432762), 147.99998474121,
                        vector3(0.0, 0.0, 147.999985)},
                       {161343630, vector3(954.152649, 47.818771, 70.432762), 220.00006103516,
                        vector3(0.0, 0.0, -139.999939)},
                       {161343630, vector3(950.745789, 50.208580, 70.432762), 76.000022888184,
                        vector3(0.0, 0.0, 76.000023)},
                       {1096374064, vector3(950.037354, 49.631062, 70.432762), 4.0000133514404,
                        vector3(0.0, 0.0, 4.000013)},
                       {207578973, vector3(949.269165, 50.126331, 70.432762), 292.0, vector3(0.0, 0.0, -68.000015)},
                       {-487222358, vector3(949.502869, 51.009930, 70.432762), 220.00006103516,
                        vector3(0.0, 0.0, -139.999939)},
                       {-1932041857, vector3(945.133911, 49.087036, 70.432762), 147.99998474121,
                        vector3(0.0, 0.0, 147.999985)},
                       {-1519644200, vector3(945.464294, 48.234848, 70.432762), 76.000022888184,
                        vector3(0.0, 0.0, 76.000023)},
                       {-430989390, vector3(944.755859, 47.657326, 70.432762), 4.0000133514404,
                        vector3(0.0, 0.0, 4.000013)},
                       {654385216, vector3(943.987671, 48.152596, 70.432762), 292.0, vector3(0.0, 0.0, -68.000015)},
                       {161343630, vector3(944.221313, 49.036198, 70.432762), 220.00006103516,
                        vector3(0.0, 0.0, -139.999939)},
                       {-1519644200, vector3(977.284912, 48.752167, 69.232758), 57.999969482422,
                        vector3(0.000000, 0.000000, 57.999969)},
                       {-430989390, vector3(977.595337, 49.430489, 69.232758), 72.999900817871,
                        vector3(0.000000, 0.000000, 72.999901)},
                       {654385216, vector3(977.721558, 50.173805, 69.232758), 87.999961853027,
                        vector3(0.000000, 0.000000, 87.999962)},
                       {161343630, vector3(977.649353, 50.915798, 69.232758), 103.00006103516,
                        vector3(0.000000, -0.000000, 103.000061)},
                       {1096374064, vector3(977.386047, 51.612301, 69.232758), 117.99999237061,
                        vector3(0.000000, -0.000000, 117.999992)},
                       {207578973, vector3(976.952820, 52.213417, 69.232758), 133.00001525879,
                        vector3(0.000000, -0.000000, 133.000015)},
                       {-487222358, vector3(976.377747, 52.682724, 69.232758), 147.99998474121,
                        vector3(0.000000, -0.000000, 147.999985)}}

AMBIENT_TABLES_PED_SKINS = {"a_f_m_bevhills_01", "a_m_m_bevhills_01", "a_m_m_fatlatin_01", "a_f_y_beach_01",
                            "a_f_y_fitness_01", "a_f_y_smartcaspat_01", "a_m_m_mexlabor_01", "a_m_m_tennis_01",
                            "a_m_y_beachvesp_01", "a_f_y_vinewood_04", "a_f_y_hipster_02", "a_f_y_hippie_01",
                            "a_f_y_eastsa_01", "a_f_o_soucent_01", "a_f_m_tramp_01"}

AMBIENT_POKER_COORDS = {vector3(985.048096, 66.630257, 69.232758), vector3(988.462524, 64.285561, 69.232758),
                        vector3(994.909546, 58.218338, 68.432755), vector3(996.348633, 51.735916, 68.432755),
                        vector3(993.234497, 43.616024, 69.232758), vector3(998.439453, 61.031857, 68.432755),
                        vector3(991.465027, 40.094330, 69.232758), vector3(1000.784363, 51.024963, 68.432755)}

AMBIENT_BJ_COORDS = {vector3(982.489319, 62.903961, 69.232689), vector3(985.903748, 60.559361, 69.232689),
                     vector3(989.037842, 45.724499, 69.232689), vector3(987.268433, 42.203384, 69.232689),
                     vector3(1002.383057, 60.507923, 68.432755), vector3(1004.183716, 53.192421, 68.432755)}

AMBIENT_RL_COORDS = {vector3(982.164490, 52.203957, 69.232758), vector3(984.302185, 55.935375, 69.232750),
                     vector3(985.912476, 49.010471, 69.232750), vector3(999.481628, 57.888916, 68.432755),
                     vector3(999.885986, 54.403336, 68.432755), vector3(1004.790466, 57.295071, 68.432755)}

CASINO_MAIN_DOORS = {{
    doorhash = "cas_ent_1",
    model = 21324050,
    coords = vec3(924.859009, 45.119484, 81.543098)
}, {
    doorhash = "cas_ent_2",
    model = 21324050,
    coords = vec3(926.347046, 47.515320, 81.543098)
}, {
    doorhash = "cas_ent_3",
    model = 21324050,
    coords = vec3(924.785339, 44.822117, 81.534195)
}, {
    doorhash = "cas_ent_4",
    model = 21324050,
    coords = vec3(960.274231, 32.653469, 72.404907)
}, {
    doorhash = "cas_ent_5",
    model = 21324050,
    coords = vec3(958.141296, 33.978157, 72.404907)
}, {
    doorhash = "cas_ent_6",
    model = 21324050,
    coords = vec3(923.376038, 42.731743, 81.543098)
}, {
    doorhash = "cas_ent_7",
    model = 21324050,
    coords = vec3(926.188293, 47.248829, 81.543098)
}, {
    doorhash = "cas_ent_8",
    model = 21324050,
    coords = vec3(923.450500, 42.696152, 81.534195)
}, {
    doorhash = "cas_ent_9",
    model = 21324050,
    coords = vec3(926.271179, 47.206696, 81.534195)
}, {
    doorhash = "cas_ent_10",
    model = 21324050,
    coords = vec3(924.706238, 44.862366, 81.543098)
}, {
    doorhash = "cas_ent_11",
    model = 21324050,
    coords = vec3(926.438171, 47.468220, 81.534195)
}, {
    doorhash = "cas_ent_12",
    model = 21324050,
    coords = vec3(927.676880, 49.645515, 81.543098)
}, {
    doorhash = "cas_ent_13",
    model = 21324050,
    coords = vec3(927.773926, 49.594986, 81.534195)
}}

CASINO_SECOND_ROOM_COORDS = vector3(976.686646, 56.992809, 70.833015)
LUCKY_WHEEL_COORDS = vector3(949.696777, 45.061569, 70.632759)
LUCKY_WHEEL_HEADING = 328.0

DrinkingBar_Bartenders = {{
    id = 1,
    model = "a_f_y_juggalo_01",
    animCoords = vector3(936.87, 28.062, 72.098),
    animRot = vector3(0.0, 0.0, 230.0),
    pedCoords = vector3(937.470, 27.262, 71.833710),
    heading = 51.795830,
    initialPos = vector3(936.056213, 28.557487, 71.866394),
    initialHeading = 232.476425,
    ped = nil,
    beingUsed = false
}, {
    id = 2,
    model = "a_f_y_skater_01",
    animCoords = vector3(940.574585, 26.011707, 71.833725) - vector3(-0.785522, 0.447319, -0.219734) +
        vector3(0.25, 0.0, 0.04),
    animRot = vector3(0.0, 0.0, -100.207207 + 180),
    pedCoords = vector3(940.574585, 26.011707, 71.833725) + vector3(0.25, 0.0, 0.0),
    heading = 85.861 + 180.0,
    initialPos = vector3(942.597107, 25.532, 71.8337),
    initialHeading = 85.86169,
    ped = nil,
    beingUsed = false
}}

OfficeCameraDevices = {{
    coords = vector3(925.024780, 50.432518, 75.058456),
    rotation = vector3(-15.839401, 0.055073, -177.802414)
}, {
    coords = vector3(928.227783, 35.230648, 75.059410),
    rotation = vector3(-19.787815, 0.056088, -41.583603)
}, {
    coords = vector3(931.025024, 24.558271, 75.057327),
    rotation = vector3(-24.753372, 0.053798, -76.945351)
}, {
    coords = vector3(956.598572, 44.455349, 74.993057),
    rotation = vector3(-15.054199, 0.056523, 99.147614)
}, {
    coords = vector3(946.468750, 51.119892, 75.055443),
    rotation = vector3(-16.119329, 0.055979, -142.443512)
}, {
    coords = vector3(965.696655, 62.316010, 73.037582),
    rotation = vector3(-14.242103, 0.058238, 179.804932)
}, {
    coords = vector3(975.784302, 58.566769, 72.850052),
    rotation = vector3(-16.115484, 0.058053, -135.433838)
}, {
    coords = vector3(990.005310, 57.423016, 72.849609),
    rotation = vector3(-24.068998, 0.055350, -101.218811)
}, {
    coords = vector3(992.928040, 52.029884, 72.847641),
    rotation = vector3(-16.826946, 0.057177, 89.742340)
}, {
    coords = vector3(987.553406, 42.199780, 72.908089),
    rotation = vector3(-38.920761, 0.045590, -89.961861)
}, {
    coords = vector3(982.671997, 63.062813, 72.911072),
    rotation = vector3(-33.802067, 0.049521, -78.948074)
}, {
    coords = vector3(972.825684, 35.062084, 72.717789),
    rotation = vector3(-11.154554, 0.055674, -43.145477)
}, {
    coords = vector3(968.624878, 69.226860, 73.600983),
    rotation = vector3(-12.115792, 0.057562, 111.385239)
}, {
    coords = vector3(956.772949, 65.128922, 73.596024),
    rotation = vector3(-14.139241, 0.057556, 17.286900)
}}

OfficeBossMarkerPosition = vector3(958.92, 55.23, 74.44)
OfficeTableEnterPosition = vector3(957.281433, 54.995884, 75.442604)
OfficeTableAnimPosition = vector3(956.668579, 55.526340, 75.442604)
OfficeTableAnimHeading = 143.0

CASINO_AREA_MIN = vector3(917.2999, 11.4262, 69.3906)
CASINO_AREA_MAX = vector3(1008.9715, 87.1460, 81.4528)
INSIDE_TRACK_AREA = vector3(953.096069, 78.122246, 71.277939)
BAR_CAMERA_POS_BEFORE = vector3(932.636902, 38.688480, 74.394287)
BAR_CAMERA_POS = vector3(935.007813, 33.887733, 73.609909)

CasinoBlips = {}
MissionBlips = {}
BLIP_POS_INSIDETRACK = vector(954.561646, 72.986542)
BLIP_POS_TABLEGAMES = vector(989.810486, 53.888123)
BLIP_POS_EXTERIORBLIP = vector(928.574463, 47.377232)

RADAR_MAP_POS = vector(974.893921, 22.800049)

WAITRESS_MODEL = "a_f_y_juggalo_01" -- set to nil if you want to disable the walking waitress
WAITRESS_PATH = {{932.287720, 50.718979, 72.069969}, {929.538452, 50.887203, 72.072639},
                 {925.719971, 42.768543, 72.277740}, {925.934570, 39.950974, 72.273712},
                 {929.062317, 35.397503, 72.202820}, {937.187622, 33.535217, 71.833702},
                 {945.774536, 38.778717, 71.433044}, {945.697632, 44.169106, 71.432899},
                 {947.562134, 49.304249, 71.432869}, {946.247131, 62.416157, 70.833008},
                 {967.909668, 68.196686, 70.832970}, {969.801575, 63.434124, 70.832970},
                 {977.080078, 57.232189, 70.832970}, {979.985107, 51.520607, 70.237991},
                 {979.922791, 44.187733, 70.833862}, {976.404297, 37.064850, 70.832863},
                 {971.814209, 38.145546, 70.832893}, {964.692261, 45.328400, 70.832909},
                 {960.282227, 47.010174, 71.437874}, {955.739197, 44.384418, 71.432907},
                 {952.182068, 44.324543, 71.432892}, {950.350098, 39.840286, 71.432899},
                 {934.543945, 32.319328, 71.833702}, {929.583923, 33.902943, 71.833702},
                 {926.595825, 40.193607, 72.273888}, {923.816406, 47.192982, 72.073524},
                 {924.071167, 48.997070, 72.073395}, {929.166138, 51.117424, 72.072861}}

INSIDE_TRACK_CAM_POS = vector3(955.19, 71.98, 73.34)
INSIDE_TRACK_CAM_ROT = vector3(-13.88, 0.05, 11.87)

CASINO_TOILET_POS = vector3(997.90 + 1.2, 80.980 - 0.2, 69.929718017578 + 0.35)
CASINO_TOILET_HEADING = 280.0

PRICE_ANIM_HEADING = 190
CASHIER_DOORS = {
    pos = vector3(951.095581, 27.268860, 71.983383),
    heading = 237.84129333496
}

INSIDE_TRACK_WALL = {
    coords = vector3(952.819, 82.3239, 71.750),
    heading = 328.4
}
DIGITAL_WALL_MODEL = "vw_vwint01_video_overlay"

PODIUMOBJECT_POS = vector3(935.104980, 42.565639, 71.273697)
ELEVATORS = {{
    leftPosition = vec3(975.526794, 73.482430, 69.229164),
    rightPosition = vec3(978.059021, 71.900017, 69.229149),
    rotation = vector3(0.000000, -0.000000, 328.0),
    heading = 328.0,
    dropPosition = vec3(954.240234, 57.936405, 75.432686)
}, {
    leftPosition = vec3(952.449341, 57.643650, 74.429672),
    rightPosition = vec3(953.845398, 59.877773, 74.431488),
    rotation = vector3(0.000000, -0.000000, 57.99993896484),
    heading = 57.99993896484,
    dropPosition = vec3(976.083862, 71.525627, 70.233093)
}}
CASINO_IPLS = {"hei_dlc_windows_casino", "hei_dlc_casino_aircon", "vw_dlc_casino_door", "hei_dlc_casino_door"}
