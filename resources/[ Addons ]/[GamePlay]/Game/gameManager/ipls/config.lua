--[[
    VSSVSSN: This is a project that has started the process of a fully customizable RP framework.
    This is meant to make options for IPL loading easy for everyone.
    Props and IPLs are customizable. However be careful with the ConfigIpls because you can make things buggy.
    All IPLs are listed above. Props are below. Make sure that you remember what you've changed unless you bug something out.
--]]
ConfigIpls                                       = {}
-- Sets the use of customizable IPLs usage customizable by the server owner/devs.
-- This will be multipurposed to also be a properties script. It will NOT be based on ESX or vRP as this is intended to be used for my custom framework but shouldn't be hard to convert.
ConfigIpls.iplsCustomizable                      = true
-- This will pin the interior in memory for quicker loading. This may cause memory issues if the server is running a lot of resources.
ConfigIpls.pinInteriorInMemory                   = false
--[[
    IPLs
]]
---------------------------------------------------------------
-- Diamond Casino & Resort - Works if used with +set sv_enforceGameBuild 2060 otherwise doesn't work natively yet.
--[[
    +set sv_enforceGameBuild 2060 needs to be used outside of the ConfigIpls file and at startup.

    Example of Windows batch file:
    @RMDIR /S /Q "C:\Server\server-data\cache"
    cd /d C:\Server\server-data
    C:\Server\FXServer.exe  +exec server.cfg +set onesync legacy +set sv_enforceGameBuild 2060
]]
ConfigIpls.diamondCasinoAndResort                = true  -- 1100.000, 220.000, -50.000/1295.000, 230.000, -50.000/1380.000, 200.000, -50.000/976.636, 70.295, 115.164
ConfigIpls.penthouse                             = true  -- 976.636, 70.295, 115.164
ConfigIpls.casinoCarPark                         = true  -- 1380.000, 200.000, -50.000
-- Apartments
-- Apartment One. Choose Only One
ConfigIpls.apartmentOneModern                    = false -- -786.8663, 315.7642, 217.6385
ConfigIpls.apartmentOneMoody                     = false -- -787.0749, 315.8198, 217.6386
ConfigIpls.apartmentOneVirbrant                  = false -- -786.6245, 315.6175, 217.6385
ConfigIpls.apartmentOneSharp                     = false -- -787.0902, 315.7039, 217.6384
ConfigIpls.apartmentOneMonochrome                = false -- -786.9887, 315.7393, 217.6386
ConfigIpls.apartmentOneSeductive                 = false -- -787.1423, 315.6943, 217.6384
ConfigIpls.apartmentOneRegal                     = false -- -787.029, 315.7113, 217.6385
ConfigIpls.apartmentOneAqua                      = true  -- -786.9469, 315.5655, 217.6383
-- Apartment Two. Choose Only One
ConfigIpls.apartmentTwoModern                    = false -- -786.9563, 315.6229, 187.9136
ConfigIpls.apartmentTwoMoody                     = false -- -786.8195, 315.5634, 187.9137
ConfigIpls.apartmentTwoVirbrant                  = false -- -786.9584, 315.7974, 187.9135
ConfigIpls.apartmentTwoSharp                     = false -- -787.0155, 315.7071, 187.9135
ConfigIpls.apartmentTwoMonochrome                = false -- -786.8809, 315.6634, 187.9136
ConfigIpls.apartmentTwoSeductive                 = false  -- -787.0961, 315.815, 187.9135
ConfigIpls.apartmentTwoRegal                     = false -- -787.0574, 315.6567, 187.9135
ConfigIpls.apartmentTwoAqua                      = true  -- -786.9756, 315.723, 187.9134
-- Apartment Three. Choose Only One
ConfigIpls.apartmentThreeModern                  = false -- -774.0126, 342.0428, 196.6864
ConfigIpls.apartmentThreeMoody                   = false -- -774.1382, 342.0316, 196.6864
ConfigIpls.apartmentThreeVirbrant                = false -- -774.0223, 342.1718, 196.6863
ConfigIpls.apartmentThreeSharp                   = false -- -773.8976, 342.1525, 196.6863
ConfigIpls.apartmentThreeMonochrome              = false -- -774.0675, 342.0773, 196.6864
ConfigIpls.apartmentThreeSeductive               = false -- -773.9552, 341.9892, 196.6862
ConfigIpls.apartmentThreeRegal                   = false -- -774.0109, 342.0965, 196.6863
ConfigIpls.apartmentThreeAqua                    = true  -- -774.0349, 342.0296, 196.6862
-- offices
ConfigIpls.ceoOffices                            = true
-- Arcadius Business Center. Choose Only One.
ConfigIpls.arcadiusOldSpiceWarm                  = false  -- -141.4966, -620.8292, 168.8204
ConfigIpls.arcadiusOldSpiceVintage               = false  -- -141.5361, -620.9186, 168.8204
ConfigIpls.arcadiusOldSpiceClassical             = false -- -141.3997, -620.9006, 168.8204
ConfigIpls.arcadiusExecutiveContrast             = false -- -141.2896, -620.9618, 168.8204
ConfigIpls.arcadiusExecutiveRich                 = false -- -141.1987, -620.913, 168.8205
ConfigIpls.arcadiusExecutiveCool                 = false -- -141.5429, -620.9524, 168.8204
ConfigIpls.arcadiusPowerBrokerIce                = false -- -141.392, -621.0451, 168.8204
ConfigIpls.arcadiusPowerBrokerConservative       = false -- -141.1945, -620.8729, 168.8204
ConfigIpls.arcadiusPowerBrokerPolished           = true  -- -141.4924, -621.0035, 168.8205
-- Maze Bank. Choose Only One.
ConfigIpls.mazeBankOldSpiceWarm                  = false -- -75.44054, -827.1487, 243.3859
ConfigIpls.mazeBankOldSpiceClassical             = false -- -75.63942, -827.1022, 243.3859
ConfigIpls.mazeBankOldSpiceVintage               = false -- -75.47446, -827.2621, 243.386
ConfigIpls.mazeBankExecutiveRich                 = false -- -75.8466, -826.9893, 243.3859
ConfigIpls.mazeBankExecutiveCool                 = false -- -75.49945, -827.05, 243.386
ConfigIpls.mazeBankExecutiveContrast             = false -- -75.49827, -827.1889, 243.386
ConfigIpls.mazeBankPowerBrokerIce                = false -- -75.56978, -827.1152, 243.3859
ConfigIpls.mazeBankPowerBrokerConservative       = false -- -75.51953, -827.0786, 243.3859
ConfigIpls.mazeBankPowerBrokerPolished           = true  -- -75.41915, -827.1118, 243.3858
-- Maze Bank West. Choose Only One.
ConfigIpls.mazeWestOldSpiceWarm                  = false -- -1392.617, -480.6363, 72.04208
ConfigIpls.mazeWestOldSpiceClassical             = false -- -1392.532, -480.7649, 72.04207
ConfigIpls.mazeWestOldSpiceVintage               = false -- -1392.611, -480.5562, 72.04214
ConfigIpls.mazeWestExecutiveRich                 = false -- -1392.667, -480.4736, 72.04217
ConfigIpls.mazeWestExecutiveCool                 = false -- -1392.542, -480.4011, 72.04211
ConfigIpls.mazeWestExecutiveContrast             = false -- -1392.626, -480.4856, 72.04212
ConfigIpls.mazeWestPowerBrokerIce                = false -- -1392.563, -480.549, 72.0421
ConfigIpls.mazeWestPowerBrokerConservative       = false -- -1392.528, -480.475, 72.04206
ConfigIpls.mazeWestPowerBrokerPolished           = true  -- -1392.416, -480.7485, 72.04207
-- Lom Bank. Choose Only One.
ConfigIpls.lomBankOldSpiceWarm                   = false -- -1579.702, -565.0366, 108.5229
ConfigIpls.lomBankOldSpiceClassical              = false -- -1579.643, -564.9685, 108.5229
ConfigIpls.lomBankOldSpiceVintage                = false -- -1579.681, -565.0003, 108.523
ConfigIpls.lomBankExecutiveRich                  = false -- -1579.756, -565.0661, 108.523
ConfigIpls.lomBankExecutiveCool                  = false -- -1579.678, -565.0034, 108.5229
ConfigIpls.lomBankExecutiveContrast              = false -- -1579.583, -565.0399, 108.5229
ConfigIpls.lomBankPowerBrokerIce                 = false -- -1579.677, -565.0689, 108.5229
ConfigIpls.lomBankPowerBrokerConservative        = false -- -1579.708, -564.9634, 108.5229
ConfigIpls.lomBankPowerBrokerPolished            = true  -- -1579.693, -564.8981, 108.5229
-- Trevor/Trash or Tidy. Only choose one.
ConfigIpls.trevorsTrailerTrash                   = false -- 1985.481, 3828.768, 32.5
ConfigIpls.trevorsTrailerTidy                    = true  -- 1985.481, 3828.768, 32.5
-- Cargo Ships. Only Choose One
ConfigIpls.normalCargoShip                       = true  -- -163.3628, -2385.161, 5.999994
ConfigIpls.sunkCargoShip                         = false -- -163.3628, -2385.161, 5.999994
ConfigIpls.burningCargoShip                      = false -- -163.3628, -2385.161, 5.999994
-- Red Carpet - 300.5927, 300.5927, 104.3776
-- redCarpet

-- Rekt Stilthouse. Choose Only One
ConfigIpls.stilthouseDestroyed                   = false -- -1020.518, 663.27, 153.5167
ConfigIpls.stilthouseRebuild                     = true  -- -1020.518, 663.27, 153.5167
-- Train Crash. Choose Only one.
ConfigIpls.trainCrash                            = false -- 3084.73, -4770.709, 15.26167
ConfigIpls.noTrainCrash                          = true  -- 532.1309, 4526.187, 89.79387
-- Warehouses
ConfigIpls.wareHouseOne                          = true  -- 1009.5, -3196.6, -39.0
ConfigIpls.wareHouseTwo                          = true  -- 1051.491, -3196.536, -39.148
ConfigIpls.wareHouseThree                        = true  -- 1093.6, -3196.6, -38.998
ConfigIpls.wareHouseFour                         = true
ConfigIpls.wareHouseFive                         = true  -- 1165.0, -3196.6, -39.013
ConfigIpls.wareHouseSmall                        = true  -- 1094.988, -3101.776, -39.0
ConfigIpls.wareHouseMedium                       = true  -- 1056.486, -3105.724, -39.0
ConfigIpls.wareHouseLarge                        = true  -- 1006.967, -3102.079, -39.0035
-- Bunkers
ConfigIpls.zancudoBunkerClosed                   = true  -- -3058.714, 3329.19, 12.5844
ConfigIpls.route68BunkerClosed                   = false -- 24.43542, 2959.705, 58.35517
ConfigIpls.oilfieldsBunkerClosed                 = false -- 481.0465, 2995.135, 43.96672
ConfigIpls.desertBunkerClosed                    = false -- 848.6175, 2996.567, 45.81612
ConfigIpls.smokeTreeBunkerClosed                 = false -- 2126.785, 3335.04, 48.21422
ConfigIpls.scrapYardBunkerClosed                 = false -- 2493.654, 3140.399, 51.28789
ConfigIpls.grapeseedBunkerClosed                 = false -- 1823.961, 4708.14, 42.4991
ConfigIpls.palletoBunkerClosed                   = false -- -783.0755, 5934.686, 24.31475
ConfigIpls.route1Bunker                          = false -- -3180.466, 1374.192, 19.9597
ConfigIpls.farmhouseBunker                       = false -- -3180.466, 1374.192, 19.9597
ConfigIpls.rantonCanyonBunkerClosed              = false -- -391.3216, 4363.728, 58.65862
--
ConfigIpls.bunkerInterior                        = true  -- 892.638, -3245.866, -98.265
-- Import/Export
ConfigIpls.importExport                          = true  -- 994.593, -3002.594, -39.647
-- Clubhouses
ConfigIpls.clubHouseOne                          = true  -- 1107.04, -3157.399, -37.519
ConfigIpls.clubHouse2                            = true  -- 998.4809, -3164.711, -38.907
-- Lost
ConfigIpls.lostTrailerPark                       = true  -- 49.494, 3744.472, 46.386
ConfigIpls.lostSafeHouse                         = true  -- 984.155, -95.366, 74.50
-- Zancudo
ConfigIpls.zancudoGates                          = true  -- -1600.301, 2806.731, 18.797
ConfigIpls.zancudoRiver                          = true  -- 86.815, 3191.649, 30.463
ConfigIpls.joshsHouse                            = true  -- -1117.163, 303.1, 66.522
ConfigIpls.cassidyCreek                          = true  -- -425.677, 4433.404, 27.325
ConfigIpls.graffiti                              = true  -- 1861.28, 2402.11, 58.53/2697.32, 3162.18, 58.1/2119.12, 3058.21, 53.25
ConfigIpls.ussLuxington                          = true  -- 3082.312 -4717.119 15.262
-- Yachts
ConfigIpls.gunrunningHeistYacht                  = true  -- 1373.828, 6737.393, 6.707596
ConfigIpls.dignityHeistYacht                     = false  -- -2027.946, -1036.695, 6.707587
ConfigIpls.galaxySuperYacht                      = false  -- -2043.974,-1031.582, 11.981
-- The Rest
ConfigIpls.arenaWars                             = false  -- 2706.825478, -3732.605478, 140.1562
ConfigIpls.simeonIpl                             = true  -- 47.162, -1115.333, 26.5
ConfigIpls.vangelicoJewelry                      = true  -- -637.202, -239.163, 38.1
ConfigIpls.maxRenda                              = true  -- -585.825, -282.72, 35.455
ConfigIpls.unionDepository                       = true  -- 2.697, -667.017, 16.130
ConfigIpls.morgue                                = true  -- 239.752, -1360.650, 39.534
ConfigIpls.cluckinBell                           = true  -- -146.384, 6161.5, 30.2
ConfigIpls.oneilsFarm                            = true  -- 2447.9, 4973.4, 47.7
ConfigIpls.oneilsFarmBurnt                       = false -- 2447.9, 4973.4, 47.7
ConfigIpls.fbiLobby                              = true  -- 105.456, -745.484, 44.755
ConfigIpls.iFruitBillboard                       = true  -- iFruit Billboard
ConfigIpls.lesterFactory                         = true  -- 716.84, -962.05, 31.59
ConfigIpls.lifeInvader                           = true  -- -1047.9, -233.0, 39.0
ConfigIpls.tunnels                               = true  -- Tunnels
ConfigIpls.carWash                               = true  -- 55.7, -1391.3, 30.5
ConfigIpls.fameOrShame                           = true  -- -248.492, -2010.509, 34.574
ConfigIpls.banhamCanyonHouse                     = true  -- -3086.428, 339.252, 6.372
ConfigIpls.laMesaGarage                          = true  -- 970.275, -1826.570, 31.115
ConfigIpls.hillValleyChurch                      = true  -- -282.464, 2835.845, 55.914
ConfigIpls.ratonCanyonRiver                      = true  -- -1652.83, 4445.28, 2.52
ConfigIpls.bahamaMamas                           = true  -- -1388.0, -618.420, 30.820
ConfigIpls.redCarpet                             = true  -- 300.593, 199.759, 104.378
ConfigIpls.ufo                                   = false  -- -2052.0, 3237, 1457.0/2490.5, 3774.8, 2414.0/501.53, 5593.86, 796.23
ConfigIpls.northYankton                          = false -- 3217.697, -4834.826, 111.815
ConfigIpls.smugglers                             = true  -- -1266.0, -3014.0, -47.0
ConfigIpls.doomsday                              = true  -- 483.2006225586, 4810.5405273438, -58.919288635254
ConfigIpls.planeCrash                            = true  -- 2814.7, 4758.5, 50.0
ConfigIpls.nightClubs                            = true  -- -1569.15, -3016.0, -74.41
--------------------------------------------------------------------------------
--[[
    Props
]]
-- Warehouse 1 - 1009.5, -3196.6, -38.99682
-- bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo
ConfigIpls.methLabBasic                          = false
ConfigIpls.methLabEmpty                          = false
ConfigIpls.methLabProduction                     = true
ConfigIpls.methLabSecurityHigh                   = true
ConfigIpls.methLabSetup                          = false
ConfigIpls.methLabUpgrade                        = true
-- Warehouse 2 - 1051.491, -3196.536, -39.14842
-- 	bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo
ConfigIpls.weedDrying                            = false
ConfigIpls.weedProduction                        = true
ConfigIpls.weedSetup                             = false
ConfigIpls.weedStandardEquip                     = false
ConfigIpls.weedUpgradeEquip                      = true
ConfigIpls.weedGrowthAStage1                     = false
ConfigIpls.weedGrowthAStage2                     = false
ConfigIpls.weedGrowthAStage3                     = true
ConfigIpls.weedGrowthBStage1                     = false
ConfigIpls.weedGrowthBStage2                     = false
ConfigIpls.weedGrowthBStage3                     = true
ConfigIpls.weedGrowthCStage1                     = false
ConfigIpls.weedGrowthCStage2                     = false
ConfigIpls.weedGrowthCStage3                     = true
ConfigIpls.weedGrowthDStage1                     = false
ConfigIpls.weedGrowthDStage2                     = false
ConfigIpls.weedGrowthDStage3                     = true
ConfigIpls.weedGrowthEStage1                     = false
ConfigIpls.weedGrowthEStage2                     = false
ConfigIpls.weedGrowthEStage3                     = true
ConfigIpls.weedGrowthFStage1                     = false
ConfigIpls.weedGrowthFStage2                     = false
ConfigIpls.weedGrowthFStage3                     = true
ConfigIpls.weedGrowthGStage1                     = false
ConfigIpls.weedGrowthGStage2                     = false
ConfigIpls.weedGrowthGStage3                     = true
ConfigIpls.weedGrowthHStage1                     = false
ConfigIpls.weedGrowthHStage2                     = false
ConfigIpls.weedGrowthHStage3                     = true
ConfigIpls.weedGrowthIStage1                     = false
ConfigIpls.weedGrowthIStage2                     = false
ConfigIpls.weedGrowthIStage3                     = true
ConfigIpls.weedHoseA                             = true
ConfigIpls.weedHoseB                             = true
ConfigIpls.weedHoseC                             = true
ConfigIpls.weedHoseD                             = true
ConfigIpls.weedHoseE                             = true
ConfigIpls.weedHoseF                             = true
ConfigIpls.weedHoseG                             = true
ConfigIpls.weedHoseH                             = true
ConfigIpls.weedHoseI                             = true
ConfigIpls.weedlightGrowthAStage23Standard       = false
ConfigIpls.weedlightGrowthBStage23Standard       = false
ConfigIpls.weedlightGrowthCStage23Standard       = false
ConfigIpls.weedlightGrowthDStage23Standard       = false
ConfigIpls.weedlightGrowthEStage23Standard       = false
ConfigIpls.weedlightGrowthFStage23Standard       = false
ConfigIpls.weedlightGrowthHStage23Standard       = false
ConfigIpls.weedlightGrowthIStage23Standard       = false
ConfigIpls.weedlightGrowthJStage23Standard       = false
ConfigIpls.weedlightGrowthAStage23Upgrade        = true
ConfigIpls.weedlightGrowthBStage23Upgrade        = true
ConfigIpls.weedlightGrowthCStage23Upgrade        = true
ConfigIpls.weedlightGrowthDStage23Upgrade        = true
ConfigIpls.weedlightGrowthEStage23Upgrade        = true
ConfigIpls.weedlightGrowthFStage23Upgrade        = true
ConfigIpls.weedlightGrowthGStage23Upgrade        = true
ConfigIpls.weedlightGrowthHStage23Upgrade        = true
ConfigIpls.weedlightGrowthIStage23Upgrade        = true
ConfigIpls.weedLowSecurity                       = false
ConfigIpls.weedSecurityUpgrade                   = true
ConfigIpls.weedChairs                            = true
-- Warehouse 3 - 1093.6, -3196.6, -38.99841
-- bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo
ConfigIpls.cocainSecurityLow                     = false
ConfigIpls.cocainSecurityHigh                    = true
ConfigIpls.cocainequipmentBasic                  = false
ConfigIpls.cocainequipmentUpgrade                = true
ConfigIpls.cocainSetup                           = false
ConfigIpls.cocainProductionBasic                 = false
ConfigIpls.cocainProductionUpgrade               = true
ConfigIpls.cocainTableEquipmentUpgeade           = true
ConfigIpls.cocainCokePressBasic                  = false
ConfigIpls.cocainCokePressUpgrade                = true
ConfigIpls.cocainCokeCut01                       = true
ConfigIpls.cocainCokeCut02                       = true
ConfigIpls.cocainCokeCut03                       = true
ConfigIpls.cocainCokeCut04                       = true
ConfigIpls.cocainCokeCut05                       = true
-- Warehouse 4 - 1121.897, -3195.338, -40.4025
-- bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo
ConfigIpls.cfcCashPile10a                        = false
ConfigIpls.cfcCashPile10b                        = false
ConfigIpls.cfcCashPile10c                        = false
ConfigIpls.cfcCashPile10D                        = true
ConfigIpls.cfcCashPile20a                        = false
ConfigIpls.cfcCashPile20b                        = false
ConfigIpls.cfcCashPile20c                        = false
ConfigIpls.cfcCashPile20d                        = true
ConfigIpls.cfcCashPile100a                       = false
ConfigIpls.cfcCashPile100b                       = false
ConfigIpls.cfcCashPile100c                       = false
ConfigIpls.cfcCashPile100d                       = true
ConfigIpls.cfcLowSecurity                        = false
ConfigIpls.cfcSecurity                           = true
ConfigIpls.cfcSetup                              = false
ConfigIpls.cfcStandardEquipment                  = false
ConfigIpls.cfcStandardNoProd                     = false
ConfigIpls.cfcUpgradeEquip                       = true
ConfigIpls.cfcUpgradeEquipNoProd                 = false
ConfigIpls.cfcMoneyCutter                        = true
ConfigIpls.cfcSpecialChairs                      = true
ConfigIpls.cfcDryerAOff                          = false
ConfigIpls.cfcDryerAOn                           = true
ConfigIpls.cfcDryerAOpen                         = false
ConfigIpls.cfcDryerBOff                          = false
ConfigIpls.cfcDryerBOn                           = true
ConfigIpls.cfcDryerBOpen                         = false
ConfigIpls.cfcDryerCOff                          = false
ConfigIpls.cfcDryerCOn                           = true
ConfigIpls.cfcDryerCOpen                         = false
ConfigIpls.cfcDryerDOff                          = false
ConfigIpls.cfcDryerDOn                           = true
ConfigIpls.cfcDryerDOpen                         = false


-- Warehouse 5 - 1165, -3196.6, -39.01306
-- bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo

-- Bunkers - 899.5518,-3246.038, -98.04907

ConfigIpls.bunkerStyleA                          = true
ConfigIpls.bunkerStyleB                          = false
ConfigIpls.bunkerStyleC                          = false
ConfigIpls.bunkerStandardSet                     = false
ConfigIpls.bunkerUpgradeSet                      = true
ConfigIpls.bunkerStandardSecuritySet             = false
ConfigIpls.bunkerUpgradeSecuritySet              = true
ConfigIpls.bunkerOfficeBlockerSet                = false
ConfigIpls.bunkerOfficeUpgradeSet                = true
ConfigIpls.bunkerGunRangeBlockerSet              = false
ConfigIpls.bunkerWallBlocker                     = false
ConfigIpls.bunkerGunRangeLights                  = true
ConfigIpls.bunkerGunLockerUpgrade                = true
ConfigIpls.bunkerGunSchematicSet                 = true

-- FIB Lobby - 110.4, -744.2, 45.7496

ConfigIpls.fibProps                              = true

-- Clubhouse 1 - 1107.04, -3157.399, -37.51859
-- bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo
ConfigIpls.clubhouse1CashStash1                  = false
ConfigIpls.clubhouse1CashStash2                  = false
ConfigIpls.clubhouse1CashStash3                  = true
ConfigIpls.clubhouse1CokeStash1                  = false
ConfigIpls.clubhouse1CokeStash2                  = false
ConfigIpls.clubhouse1CokeStash3                  = true
ConfigIpls.clubhouse1CounterfeitStash1           = false
ConfigIpls.clubhouse1CounterfeitStash2           = false
ConfigIpls.clubhouse1CounterfeitStash3           = false
ConfigIpls.clubhouse1WeedStash1                  = false
ConfigIpls.clubhouse1WeedStash2                  = false
ConfigIpls.clubhouse1WeedStash3                  = true
ConfigIpls.clubhouse1IDStash1                    = false
ConfigIpls.clubhouse1IDStash2                    = false
ConfigIpls.clubhouse1IDStash3                    = true
ConfigIpls.clubhouse1MethStash1                  = false
ConfigIpls.clubhouse1MethStash2                  = false
ConfigIpls.clubhouse1MethStash3                  = true
ConfigIpls.clubhouse1Decorative1                 = false
ConfigIpls.clubhouse1Decorative2                 = true
ConfigIpls.clubhouse1Furnishings1                = false
ConfigIpls.clubhouse1Furnishings2                = true
ConfigIpls.clubhouse1Walls1                      = false
ConfigIpls.clubhouse1Walls2                      = true
ConfigIpls.clubhouse1Murals1                     = false
ConfigIpls.clubhouse1Murals2                     = false
ConfigIpls.clubhouse1Murals3                     = false
ConfigIpls.clubhouse1Murals4                     = false
ConfigIpls.clubhouse1Murals5                     = false
ConfigIpls.clubhouse1Murals6                     = false
ConfigIpls.clubhouse1Murals7                     = false
ConfigIpls.clubhouse1Murals8                     = false
ConfigIpls.clubhouse1Murals9                     = true
ConfigIpls.clubhouse1GunLocker                   = true
ConfigIpls.clubhouse1ModBooth                    = true
ConfigIpls.clubhouse1NoGunLocker                 = false
ConfigIpls.clubhouse1NoModBooth                  = false

-- Clubhouse 2 - 998.4809, -3164.711, -38.90733
-- bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo
ConfigIpls.clubhouse2CashLarge                   = true
ConfigIpls.clubhouse2CashMedium                  = false
ConfigIpls.clubhouse2Cashsmall                   = false
ConfigIpls.clubhouse2CokeLarge                   = true
ConfigIpls.clubhouse2CokeMedium                  = false
ConfigIpls.clubhouse2CashSmall                   = false
ConfigIpls.clubhouse2CounterfeitLarge            = true
ConfigIpls.clubhouse2CounterfeitMedium           = false
ConfigIpls.clubhouse2CounterfeitSmall            = false
ConfigIpls.clubhouse2IDLarge                     = true
ConfigIpls.clubhouse2IDMedium                    = false
ConfigIpls.clubhouse2IDSmall                     = false
ConfigIpls.clubhouse2MethLarge                   = true
ConfigIpls.clubhouse2MethMedium                  = false
ConfigIpls.clubhouse2MethSmall                   = false
ConfigIpls.clubhouse2WeedLarge                   = true
ConfigIpls.clubhouse2WeedMedium                  = false
ConfigIpls.clubhouse2WeedSmall                   = false
ConfigIpls.clubhouse2Decorative1                 = false
ConfigIpls.clubhouse2Decorative2                 = true
ConfigIpls.clubhouse2Furnishings1                = false
ConfigIpls.clubhouse2Furnishings2                = true
ConfigIpls.clubhouse2Walls1                      = false
ConfigIpls.clubhouse2Walls2                      = true
ConfigIpls.clubhouse2LowerWallsDefault           = true
ConfigIpls.clubhouse2GunLocker                   = true
ConfigIpls.clubhouse2ModBooth                    = true
ConfigIpls.clubhouse2NoGunLocker                 = false
ConfigIpls.clubhouse2NoModBooth                  = false
-- Import/Export - 994.5925, -3002.594, -39.64699
ConfigIpls.importExportDecor1                    = true
ConfigIpls.importExportDecor2                    = false
ConfigIpls.importExportDecor3                    = false
ConfigIpls.importExportDecor4                    = false
ConfigIpls.importExportLightingOptions1          = false
ConfigIpls.importExportLightingOptions2          = false
ConfigIpls.importExportLightingOptions3          = false
ConfigIpls.importExportLightingOptions4          = false
ConfigIpls.importExportLightingOptions5          = false
ConfigIpls.importExportLightingOptions6          = false
ConfigIpls.importExportLightingOptions7          = false
ConfigIpls.importExportLightingOptions8          = false
ConfigIpls.importExportLightingOptions9          = true
ConfigIpls.importExportNumberStyle1N1            = false
ConfigIpls.importExportNumberStyle1N2            = false
ConfigIpls.importExportNumberStyle1N3            = true
ConfigIpls.importExportNumberStyle2N1            = false
ConfigIpls.importExportNumberStyle2N2            = false
ConfigIpls.importExportNumberStyle2N3            = true
ConfigIpls.importExportNumberStyle3N1            = false
ConfigIpls.importExportNumberStyle3N2            = false
ConfigIpls.importExportNumberStyle3N3            = true
ConfigIpls.importExportNumberStyle4N1            = false
ConfigIpls.importExportNumberStyle4N2            = false
ConfigIpls.importExportNumberStyle4N3            = true
ConfigIpls.importExportNumberStyle5N1            = false
ConfigIpls.importExportNumberStyle5N2            = false
ConfigIpls.importExportNumberStyle5N3            = true
ConfigIpls.importExportNumberStyle6N1            = false
ConfigIpls.importExportNumberStyle6N2            = false
ConfigIpls.importExportNumberStyle6N3            = true
ConfigIpls.importExportNumberStyle7N1            = false
ConfigIpls.importExportNumberStyle7N2            = false
ConfigIpls.importExportNumberStyle7N3            = true
ConfigIpls.importExportNumberStyle8N1            = false
ConfigIpls.importExportNumberStyle8N2            = false
ConfigIpls.importExportNumberStyle8N3            = true
ConfigIpls.importExportNumberStyle9N1            = false
ConfigIpls.importExportNumberStyle9N2            = false
ConfigIpls.importExportNumberStyle9N3            = true
ConfigIpls.importExportFloorVinyl1               = true
ConfigIpls.importExportFloorVinyl2               = true
ConfigIpls.importExportFloorVinyl3               = true
ConfigIpls.importExportFloorVinyl4               = true
ConfigIpls.importExportFloorVinyl5               = true
ConfigIpls.importExportFloorVinyl6               = true
ConfigIpls.importExportFloorVinyl7               = true
ConfigIpls.importExportFloorVinyl8               = true
ConfigIpls.importExportFloorVinyl9               = true
ConfigIpls.importExportFloorVinyl10              = true
ConfigIpls.importExportFloorVinyl11              = true
ConfigIpls.importExportFloorVinyl12              = true
ConfigIpls.importExportFloorVinyl13              = true
ConfigIpls.importExportFloorVinyl14              = true
ConfigIpls.importExportFloorVinyl15              = true
ConfigIpls.importExportFloorVinyl16              = true
ConfigIpls.importExportFloorVinyl17              = true
ConfigIpls.importExportFloorVinyl18              = true
ConfigIpls.importExportFloorVinyl19              = true
ConfigIpls.importExportBasicStyleSet             = true
ConfigIpls.importExportBrandedStyleSet           = false
ConfigIpls.importExportUrbanStyleSet             = false
ConfigIpls.importExportCarFloorHatch             = true
ConfigIpls.importExportDoorBlocker               = false
-- CEO Offices
ConfigIpls.ceoCashSet1                           = false
ConfigIpls.ceoCashSet2                           = false
ConfigIpls.ceoCashSet3                           = false
ConfigIpls.ceoCashSet4                           = false
ConfigIpls.ceoCashSet5                           = false
ConfigIpls.ceoCashSet6                           = false
ConfigIpls.ceoCashSet7                           = false
ConfigIpls.ceoCashSet8                           = false
ConfigIpls.ceoCashSet9                           = false
ConfigIpls.ceoCashSet10                          = false
ConfigIpls.ceoCashSet11                          = false
ConfigIpls.ceoCashSet12                          = false
ConfigIpls.ceoCashSet13                          = false
ConfigIpls.ceoCashSet14                          = false
ConfigIpls.ceoCashSet15                          = false
ConfigIpls.ceoCashSet16                          = false
ConfigIpls.ceoCashSet17                          = false
ConfigIpls.ceoCashSet18                          = false
ConfigIpls.ceoCashSet19                          = false
ConfigIpls.ceoCashSet20                          = false
ConfigIpls.ceoCashSet21                          = false
ConfigIpls.ceoCashSet22                          = false
ConfigIpls.ceoCashSet23                          = false
ConfigIpls.ceoCashSet24                          = false
ConfigIpls.ceoOfficeBooze                        = false
ConfigIpls.ceoOfficeChairs                       = false
ConfigIpls.ceoSwagArt1                           = false
ConfigIpls.ceoSwagArt2                           = false
ConfigIpls.ceoSwagArt3                           = false
ConfigIpls.ceoBoozeCigs                          = false
ConfigIpls.ceoBoozeCigs2                         = false
ConfigIpls.ceoBoozeCigs3                         = false
ConfigIpls.ceoSwagCounterfeit                    = false
ConfigIpls.ceoSwagCounterfeit2                   = false
ConfigIpls.ceoSwagCounterfeit3                   = false
ConfigIpls.ceoSwagDrugBags                       = false
ConfigIpls.ceoSwagDrugBags2                      = false
ConfigIpls.ceoSwagDrugBags3                      = false
ConfigIpls.ceoDrugStatue                         = false
ConfigIpls.ceoDrugStatue2                        = false
ConfigIpls.ceoDrugStatue3                        = false
ConfigIpls.ceoElectronic                         = false
ConfigIpls.ceoElectronic2                        = false
ConfigIpls.ceoElectronic3                        = false
ConfigIpls.ceoFurCoats                           = false
ConfigIpls.ceoFurCoats2                          = false
ConfigIpls.ceoFurCoats3                          = false
ConfigIpls.ceoSwagGems                           = false
ConfigIpls.ceoSwagGems2                          = false
ConfigIpls.ceoSwagGems3                          = false
ConfigIpls.ceoSwagGuns                           = false
ConfigIpls.ceoSwagGuns2                          = false
ConfigIpls.ceoSwagGuns3                          = false
ConfigIpls.ceoSwagIvory                          = false
ConfigIpls.ceoSwagIvory2                         = false
ConfigIpls.ceoSwagIvory3                         = false
ConfigIpls.ceoSwagJewelWatch                     = false
ConfigIpls.ceoSwagJewelWatch2                    = false
ConfigIpls.ceoSwagJewelWatch3                    = false
ConfigIpls.ceoSwagMed                            = false
ConfigIpls.ceoSwagMed2                           = false
ConfigIpls.ceoSwagMed3                           = false
ConfigIpls.ceoSwagPills                          = false
ConfigIpls.ceoSwagPills2                         = false
ConfigIpls.ceoSwagPills3                         = false
ConfigIpls.ceoSwagSilver                         = false
ConfigIpls.ceoSwagSilver2                        = false
ConfigIpls.ceoSwagSilver3                        = false

-- CEO Garages - {795.75439453125, -2997.3317871094, -22.960731506348}

ConfigIpls.ceoGaragesDecor1                      = false
ConfigIpls.ceoGaragesDecor2                      = false
ConfigIpls.ceoGaragesDecor3                      = false
ConfigIpls.ceoGaragesDecor4                      = true
ConfigIpls.ceoGaragesLightingOptions1            = false
ConfigIpls.ceoGaragesLightingOptions2            = false
ConfigIpls.ceoGaragesLightingOptions3            = false
ConfigIpls.ceoGaragesLightingOptions4            = false
ConfigIpls.ceoGaragesLightingOptions5            = false
ConfigIpls.ceoGaragesLightingOptions6            = false
ConfigIpls.ceoGaragesLightingOptions7            = false
ConfigIpls.ceoGaragesLightingOptions8            = false
ConfigIpls.ceoGaragesLightingOptions9            = true
ConfigIpls.ceoGaragesNumberingStyle1n1           = false
ConfigIpls.ceoGaragesNumberingStyle1n2           = false
ConfigIpls.ceoGaragesNumberingStyle1n3           = true
ConfigIpls.ceoGaragesNumberingStyle2n1           = false
ConfigIpls.ceoGaragesNumberingStyle2n2           = false
ConfigIpls.ceoGaragesNumberingStyle2n3           = true
ConfigIpls.ceoGaragesNumberingStyle3n1           = false
ConfigIpls.ceoGaragesNumberingStyle3n2           = false
ConfigIpls.ceoGaragesNumberingStyle3n3           = true
ConfigIpls.ceoGaragesNumberingStyle4n1           = false
ConfigIpls.ceoGaragesNumberingStyle4n2           = false
ConfigIpls.ceoGaragesNumberingStyle4n3           = true
ConfigIpls.ceoGaragesNumberingStyle5n1           = false
ConfigIpls.ceoGaragesNumberingStyle5n2           = false
ConfigIpls.ceoGaragesNumberingStyle5n3           = true
ConfigIpls.ceoGaragesNumberingStyle6n1           = false
ConfigIpls.ceoGaragesNumberingStyle6n2           = false
ConfigIpls.ceoGaragesNumberingStyle6n3           = true
ConfigIpls.ceoGaragesNumberingStyle7n1           = false
ConfigIpls.ceoGaragesNumberingStyle7n2           = false
ConfigIpls.ceoGaragesNumberingStyle7n3           = true
ConfigIpls.ceoGaragesNumberingStyle8n1           = false
ConfigIpls.ceoGaragesNumberingStyle8n2           = false
ConfigIpls.ceoGaragesNumberingStyle8n3           = true
ConfigIpls.ceoGaragesNumberingStyle9n1           = false
ConfigIpls.ceoGaragesNumberingStyle9n2           = false
ConfigIpls.ceoGaragesNumberingStyle9n3           = true
ConfigIpls.ceoGaragesBasicStyleSet               = true

-- CEO Vehicle Shops - {730.63916015625, -2993.2373046875, -38.999904632568}

ConfigIpls.ceoVehGaragesFloorVinyl1              = false
ConfigIpls.ceoVehGaragesFloorVinyl2              = false
ConfigIpls.ceoVehGaragesFloorVinyl3              = false
ConfigIpls.ceoVehGaragesFloorVinyl4              = false
ConfigIpls.ceoVehGaragesFloorVinyl5              = false
ConfigIpls.ceoVehGaragesFloorVinyl6              = false
ConfigIpls.ceoVehGaragesFloorVinyl7              = false
ConfigIpls.ceoVehGaragesFloorVinyl8              = false
ConfigIpls.ceoVehGaragesFloorVinyl9              = false
ConfigIpls.ceoVehGaragesFloorVinyl10             = false
ConfigIpls.ceoVehGaragesFloorVinyl12             = false
ConfigIpls.ceoVehGaragesFloorVinyl13             = false
ConfigIpls.ceoVehGaragesFloorVinyl14             = false
ConfigIpls.ceoVehGaragesFloorVinyl15             = false
ConfigIpls.ceoVehGaragesFloorVinyl16             = false
ConfigIpls.ceoVehGaragesFloorVinyl17             = false
ConfigIpls.ceoVehGaragesFloorVinyl18             = false
ConfigIpls.ceoVehGaragesFloorVinyl19             = true

-- Document Forgery Office - {1163.842,-3195.7,-39.008}

ConfigIpls.dfoChair1                             = true
ConfigIpls.dfoChair2                             = true
ConfigIpls.dfoChair3                             = true
ConfigIpls.dfoChair4                             = true
ConfigIpls.dfoChair5                             = true
ConfigIpls.dfoChair6                             = true
ConfigIpls.dfoChair7                             = true
ConfigIpls.dfoClutter                            = false
ConfigIpls.dfoEquipmentBasic                     = false
ConfigIpls.dfoequipmentUpgrade                   = true
ConfigIpls.dfoInteriorBasic                      = false
ConfigIpls.dfoInteriorUpgrade                    = true
ConfigIpls.dfoProduction                         = true
ConfigIpls.dfoSecurityHigh                       = true
ConfigIpls.dfoSecurityLow                        = false
ConfigIpls.dfoSetup                              = true

-- Doomsday Facility - {483.2, 4810.5, -58.9}

ConfigIpls.doomsdayFacilityDecal                 = true
ConfigIpls.doomsdayFacilityLounge                = true
ConfigIpls.doomsdayFacilityCannon                = true
ConfigIpls.doomsdayClutter                       = false
ConfigIpls.doomsdayFacilityCrewEmblem            = true
ConfigIpls.doomsdayFacilityShell                 = true
ConfigIpls.doomsdayFacilitySecurity              = true
ConfigIpls.doomsdayFacilitySleep                 = true
ConfigIpls.doomsdayFacilityTrophy                = true
ConfigIpls.doomsdayFacilityMedicComplete         = true
ConfigIpls.doomsdayFacilityMedicOutfit           = true
ConfigIpls.doomsdayFacilityServerFarmOutfit      = true
ConfigIpls.doomsdayColorDecal                    = 255
ConfigIpls.doomsdayColorLounge                   = 255
ConfigIpls.doomsdayColorCannon                   = 255
ConfigIpls.doomsdayColorClutterColor             = 255
ConfigIpls.doomsdayColorCrewEmblem               = 255
ConfigIpls.doomsdayColorShell                    = 255
ConfigIpls.doomsdayColorSecurity                 = 255
ConfigIpls.doomsdayColorSleep                    = 255
ConfigIpls.doomsdayColorTrophy                   = 255
ConfigIpls.doomsdayColorMedicComplete            = 255
ConfigIpls.doomsdayColorMedicOutfit              = 255
ConfigIpls.doomsdayColorServerFarmOutfit         = 255

-- Smugglers Run Hangar - {-1266.0, -3014.0, -47.0}

ConfigIpls.smugglersLighting                     = true
ConfigIpls.smugglersShell                        = true
ConfigIpls.smugglersBedroomTint                  = true
ConfigIpls.smugglersCraneTint                    = true
ConfigIpls.smugglersModerea                      = true
ConfigIpls.smugglersLightingTintProps            = true
ConfigIpls.smugglersFloor                        = true
ConfigIpls.smugglersFloorDecal                   = true
ConfigIpls.smugglersBedroomModern                = true
ConfigIpls.smugglersOfficeModern                 = true
ConfigIpls.smugglersBedroomBlindsOpen            = true
ConfigIpls.smugglersLightingWallTint             = true
ConfigIpls.smugglersShellColor                   = 0
ConfigIpls.smugglerBedroomTintColor              = 0
ConfigIpls.smugglerCraneTintColor                = 0
ConfigIpls.smugglersModareaColor                 = 0
ConfigIpls.smugglersLightTintPropsColor          = 0
ConfigIpls.smugglersFloorDecalColor              = 0
ConfigIpls.smugglersBedRoomModernColor           = 0
ConfigIpls.smugglersOfficeModernColor            = 0
ConfigIpls.smugglersBedRoomBlindOpenColor        = 0
ConfigIpls.smugglersLightingWallTintColor        = 0
-- Penthouse - 
ConfigIpls.penthouseManagerDefault               = false
ConfigIpls.penthouseManagerWorkout               = true
ConfigIpls.penthousePattern1                     = false
ConfigIpls.penthousePattern2                     = false
ConfigIpls.penthousePattern3                     = false
ConfigIpls.penthousePattern4                     = false
ConfigIpls.penthousePattern5                     = false
ConfigIpls.penthousePattern6                     = false
ConfigIpls.penthousePattern7                     = false
ConfigIpls.penthousePattern8                     = false
ConfigIpls.penthousePattern9                     = true
ConfigIpls.penthouseSpaBarOpen                   = true
ConfigIpls.penthouseSpaBarClosed                 = false
ConfigIpls.penthouseMediaBarOpen                 = true
ConfigIpls.penthouseMediaBarClosed               = false
ConfigIpls.penthouseDealer                       = true
ConfigIpls.penthouseNoDealer                     = false
ConfigIpls.penthouseArcadeModern                 = false
ConfigIpls.penthouseArcadeRetro                  = true
ConfigIpls.penthouseBarClutter                   = false
ConfigIpls.penthouseBarClutter1                  = false
ConfigIpls.penthouseBarClutter2                  = false
ConfigIpls.penthouseBarClutter3                  = false
ConfigIpls.penthouseBarLight0                    = false
ConfigIpls.penthouseBarLight1                    = true
ConfigIpls.penthouseBarParty0                    = false
ConfigIpls.penthouseBarParty1                    = false
ConfigIpls.penthouseBarParty2                    = false
ConfigIpls.penthouseBarPartyAfter                = false
ConfigIpls.penthouseGuestBlocker                 = false
ConfigIpls.penthouseOfficeBlocker                = false
ConfigIpls.penthouseCineBlocker                  = false
ConfigIpls.penthouseSpaBlocker                   = false
ConfigIpls.penthouseBarBlocker                   = false
ConfigIpls.penthouseBarBlocker                   = false
ConfigIpls.penthouseBlocker                      = false
ConfigIpls.penthouseTvs                          = true
ConfigIpls.penthouseMirrors                      = true
ConfigIpls.penthouseEdgeBlend                    = false
ConfigIpls.penthouseWallArt                      = true
ConfigIpls.penthouseSafeDoorOfficeL              = false
ConfigIpls.penthouseSafeDoorOfficeR              = false
ConfigIpls.penthouseGunCase1                     = true
ConfigIpls.penthouseGunCase2                     = true
ConfigIpls.penthouseSpaWater1                    = false
ConfigIpls.penthouseSpaWater2                    = false
ConfigIpls.penthouseSpaWater3                    = true
ConfigIpls.penthouseSigns                        = true
-- In my research I found that these can be set between 0 and 3. May be able to be set higher but I haven't found anything higher.
ConfigIpls.penthouseTintShellColor               = 0
ConfigIpls.penthouseSpaxShellColor               = 0
ConfigIpls.penthouseSpaShellColor                = 0
ConfigIpls.penthouseSbtShellColor                = 0
ConfigIpls.penthouseMbtShellColor                = 0
ConfigIpls.penthousePattern1Color                = 0
ConfigIpls.penthousePattern2Color                = 0
ConfigIpls.penthousePattern3Color                = 0
ConfigIpls.penthousePattern4Color                = 0
ConfigIpls.penthousePattern5Color                = 0
ConfigIpls.penthousePattern6Color                = 0
ConfigIpls.penthousePattern7Color                = 0
ConfigIpls.penthousePattern8Color                = 0
ConfigIpls.penthousePattern9Color                = 0
-- Arena Wars - 
ConfigIpls.crowdA                                = true
ConfigIpls.crowdB                                = true
ConfigIpls.crowdC                                = true
ConfigIpls.crowdD                                = true
-- Choose only one.
ConfigIpls.dystopianScene                        = true
ConfigIpls.scifiScene                            = false
ConfigIpls.wastelandScene                        = false
-- Choose only one.
ConfigIpls.dystopianScene1                       = true
ConfigIpls.dystopianScene2                       = false
ConfigIpls.dystopianScene3                       = false
ConfigIpls.dystopianScene4                       = false
ConfigIpls.dystopianScene5                       = false
ConfigIpls.dystopianScene6                       = false
ConfigIpls.dystopianScene7                       = false
ConfigIpls.dystopianScene8                       = false
ConfigIpls.dystopianScene9                       = false
ConfigIpls.dystopianScene10                      = false
ConfigIpls.dystopianScene11                      = false
ConfigIpls.dystopianScene12                      = false
ConfigIpls.dystopianScene13                      = false
ConfigIpls.dystopianScene14                      = false
ConfigIpls.dystopianScene15                      = false
ConfigIpls.dystopianScene16                      = false
ConfigIpls.dystopianScene17                      = false
-- Choose Only One
ConfigIpls.scifiScene1                           = true
ConfigIpls.scifiScene2                           = false
ConfigIpls.scifiScene3                           = false
ConfigIpls.scifiScene4                           = false
ConfigIpls.scifiScene5                           = false
ConfigIpls.scifiScene6                           = false
ConfigIpls.scifiScene7                           = false
ConfigIpls.scifiScene8                           = false
ConfigIpls.scifiScene9                           = false
ConfigIpls.scifiScene10                          = false
-- Choose Only One
ConfigIpls.wastelandScene1                       = true
ConfigIpls.wastelandScene2                       = false
ConfigIpls.wastelandScene3                       = false
ConfigIpls.wastelandScene4                       = false
ConfigIpls.wastelandScene5                       = false
ConfigIpls.wastelandScene6                       = false
ConfigIpls.wastelandScene7                       = false
ConfigIpls.wastelandScene8                       = false
ConfigIpls.wastelandScene9                       = false
ConfigIpls.wastelandScene10                      = false
-- Nightclub
-- Choose Only One
ConfigIpls.clubNameGalaxy                        = false
ConfigIpls.clubNameStudioLosSantos               = false
ConfigIpls.clubNameOmega                         = false
ConfigIpls.clubNameTechnoLogie                   = false
ConfigIpls.clubNameGefangnis                     = false
ConfigIpls.clubNameMaisonette                    = false
ConfigIpls.clubNameTonysFunHouse                 = false
ConfigIpls.clubNameThePalace                     = false
ConfigIpls.clubNameParadise                      = true
-- Choose One
ConfigIpls.nightClubStyle1                       = false
ConfigIpls.nightClubStyle2                       = false
ConfigIpls.nightClubStyle3                       = true
-- Choose One
ConfigIpls.nightClubPodium1                      = false
ConfigIpls.nightClubPodium2                      = false
ConfigIpls.nightClubPodium3                      = true
-- Choose One
ConfigIpls.nightClubSetup                        = false
ConfigIpls.nightClubSetupUpgrade                 = true
ConfigIpls.nightClubSecurityUpgrade              = true
ConfigIpls.nightClubsDjBooth1                    = false
ConfigIpls.nightClubsDjBooth2                    = false
ConfigIpls.nightClubsDjBooth3                    = false
ConfigIpls.nightClubsDjBooth4                    = true
-- You can have all of these on at once but it is not recommended.
-- Customize to your liking but be careful.
ConfigIpls.nightClubsLightsOne1                  = false
ConfigIpls.nightClubsLightsOne2                  = false
ConfigIpls.nightClubsLightsOne3                  = false
ConfigIpls.nightClubsLightsOne4                  = true
ConfigIpls.nightClubsLightsTwo1                  = false
ConfigIpls.nightClubsLightsTwo2                  = false
ConfigIpls.nightClubsLightsTwo3                  = false
ConfigIpls.nightClubsLightsTwo4                  = true
ConfigIpls.nightClubsLightsThree1                = false
ConfigIpls.nightClubsLightsThree2                = false
ConfigIpls.nightClubsLightsThree3                = false
ConfigIpls.nightClubsLightsThree4                = true
ConfigIpls.nightClubsLightsFour1                 = false
ConfigIpls.nightClubsLightsFour2                 = false
ConfigIpls.nightClubsLightsFour3                 = false
ConfigIpls.nightClubsLightsFour4                 = true
-- Bar content. The booze props will only work if bar content is on.
ConfigIpls.nightClubsBarContent                  = true
ConfigIpls.nightClubBooze1                       = true
ConfigIpls.nightClubBooze2                       = true
ConfigIpls.nightClubBooze3                       = true
-- Night Club Office
ConfigIpls.nightClubTrophy1                      = true
ConfigIpls.nightClubTrophy2                      = true
ConfigIpls.nightClubTrophy3                      = true
ConfigIpls.nightClubOfficeChest                  = true
ConfigIpls.nightClubOfficeAmmoBoxes              = true
ConfigIpls.nightClubOfficeMeth                   = true
ConfigIpls.nightClubOfficeFakeIds                = true
ConfigIpls.nightClubOfficeWeed                   = true
ConfigIpls.nightClubOfficeCoke                   = true
ConfigIpls.nightClubOfficeCash                   = true
ConfigIpls.nightClubsOfficeClutter               = true
ConfigIpls.nightClubsWorkLamps                   = true
ConfigIpls.nightClubsDeliveryTruck               = true
ConfigIpls.nightClubsDryIce                      = true
ConfigIpls.nightClubsRigsOff                     = true
ConfigIpls.nightClubsLightGrid                   = true
ConfigIpls.nightClubsTradLights                  = true
ConfigIpls.nightClubsForSale                     = true
ConfigIpls.nightClubsDixon                       = true
ConfigIpls.nightClubsMadonna                     = true
ConfigIpls.nightClubsSolomun                     = true
ConfigIpls.nightClubsTaleOfUs                    = true
ConfigIpls.nightClubsSmokeMachine                = true
ConfigIpls.nightClubsDryIceScale                 = 5.0
--[[
    Interior Ids. DO NOT CHANGE THIS OR PROPS WON'T LOAD!!!!!!!!!!!!!!!!!
]]
ConfigIpls.outdoors                              = 0
-- Diamond Casino & Resort - Works if used with +set sv_enforceGameBuild 2060 otherwise doesn't work natively yet.
--[[
    +set sv_enforceGameBuild 2060 needs to be used outside of the ConfigIpls file and at startup.

    Example of Windows batch file:
    @RMDIR /S /Q "C:\Server\server-data\cache"
    cd /d C:\Server\server-data
    C:\Server\FXServer.exe  +exec server.cfg +set onesync legacy +set sv_enforceGameBuild 2060
]]
-- Apartment One
ConfigIpls.apartmentOneModernId                  = 227329
ConfigIpls.apartmentOneMoodyId                   = 228097
ConfigIpls.apartmentOneVirbrantId                = 228353
ConfigIpls.apartmentOneSharpId                   = 229633
ConfigIpls.apartmentOneMonochromeId              = 230401
ConfigIpls.apartmentOneSeductiveId               = 231169
ConfigIpls.apartmentOneRegalId                   = 231937
ConfigIpls.apartmentOneAquaId                    = 146945
-- Apartment Two
ConfigIpls.apartmentTwoModernId                  = 227585
ConfigIpls.apartmentTwoMoodyId                   = 228353
ConfigIpls.apartmentTwoVirbrantId                = 214641
ConfigIpls.apartmentTwoSharpId                   = 229889
ConfigIpls.apartmentTwoMonochromeId              = 230657
ConfigIpls.apartmentTwoSeductiveId               = 231425
ConfigIpls.apartmentTwoRegalId                   = 232193
ConfigIpls.apartmentTwoAquaId                    = 232961
-- Apartment Three
ConfigIpls.apartmentThreeModernId                = 146945
ConfigIpls.apartmentThreeMoodyId                 = 146949
ConfigIpls.apartmentThreeVirbrantId              = 144385
ConfigIpls.apartmentThreeSharpId                 = 146945
ConfigIpls.apartmentThreeMonochromeId            = 146945
ConfigIpls.apartmentThreeSeductiveId             = 146945
ConfigIpls.apartmentThreeRegalId                 = 146945
ConfigIpls.apartmentThreeAquaId                  = 146945
-- CEO
-- Garage
ConfigIpls.ceoGarageId                           = 252417
-- Vehicle Shop
ConfigIpls.ceoVehicleShopId                      = 252929
-- Arcadius Office - Choose One
ConfigIpls.arcadiusOldSpiceWarmId                = 236289
ConfigIpls.arcadiusOldSpiceVintageId             = 236801
ConfigIpls.arcadiusOldSpiceClassicalId           = 236545
ConfigIpls.arcadiusExecutiveContrastId           = 237057
ConfigIpls.arcadiusExecutiveRichId               = 237313
ConfigIpls.arcadiusExecutiveCoolId               = 237569
ConfigIpls.arcadiusPowerBrokerIceId              = 237825
ConfigIpls.arcadiusPowerBrokerConservativeId     = 238081
ConfigIpls.arcadiusPowerBrokerPolishedId         = 238337
-- Maze Bank
ConfigIpls.mazeBankOldSpiceWarmId                = 238593
ConfigIpls.mazeBankOldSpiceClassicalId           = 238849
ConfigIpls.mazeBankOldSpiceVintageId             = 239105
ConfigIpls.mazeBankExecutiveRichId               = 239617
ConfigIpls.mazeBankExecutiveCoolId               = 239873
ConfigIpls.mazeBankExecutiveContrastId           = 239361
ConfigIpls.mazeBankPowerBrokerIceId              = 240129
ConfigIpls.mazeBankPowerBrokerConservativeId     = 240385
ConfigIpls.mazeBankPowerBrokerPolishedId         = 240641
-- Maze Bank West
ConfigIpls.mazeWestOldSpiceWarmId                = 243201
ConfigIpls.mazeWestOldSpiceClassicalId           = 243457
ConfigIpls.mazeWestOldSpiceVintageId             = 243713
ConfigIpls.mazeWestExecutiveRichId               = 244225
ConfigIpls.mazeWestExecutiveCoolId               = 244481
ConfigIpls.mazeWestExecutiveContrastId           = 243969
ConfigIpls.mazeWestPowerBrokerIceId              = 244737
ConfigIpls.mazeWestPowerBrokerConservativeId     = 244993
ConfigIpls.mazeWestPowerBrokerPolishedId         = 245249
-- Lom Bank
ConfigIpls.lomBankOldSpiceWarmId                 = 240897
ConfigIpls.lomBankOldSpiceClassicalId            = 241153
ConfigIpls.lomBankOldSpiceVintageId              = 241409
ConfigIpls.lomBankExecutiveRichId                = 241921
ConfigIpls.lomBankExecutiveCoolId                = 242177
ConfigIpls.lomBankExecutiveContrastId            = 241665
ConfigIpls.lomBankPowerBrokerIceId               = 242433
ConfigIpls.lomBankPowerBrokerConservativeId      = 242689
ConfigIpls.lomBankPowerBrokerPolishedId          = 242945
-- Trevors Trailer
ConfigIpls.trevorsTrailerId                      = 110338
-- USS Luxington
ConfigIpls.luxingtonId                           = 133889
-- Yatchs
ConfigIpls.dignityHeistYachtId                   = 174337
ConfigIpls.galaxySuperYacht                      = 174593
-- FIB
ConfigIpls.FIBLobbyId                            = 58882
-- Diamond Casino and Resort
ConfigIpls.diamondCasinoId                       = 275201
ConfigIpls.casinoPenthouseId                     = 274689
ConfigIpls.casinoCarParkId                       = 275457
-- Warehouses
ConfigIpls.wareHouseOneId                        = 247041
ConfigIpls.wareHouseTwoId                        = 247297
ConfigIpls.wareHouseThreeId                      = 247553
ConfigIpls.wareHouseFourId                       = 247809
ConfigIpls.wareHouseFiveId                       = 246785
ConfigIpls.wareHouseSmallId                      = 235777
ConfigIpls.wareHouseMediumId                     = 325521
ConfigIpls.wareHouseLargeId                      = 236033
-- Bunker
ConfigIpls.bunkerId                              = 258561
-- import/Export garage
ConfigIpls.importExportId                        = 252673
-- Clubhouses
ConfigIpls.clubHouseOneId                        = 246273
ConfigIpls.clubHoue2Id                           = 246529
-- Smugglers Run
ConfigIpls.smugglersId                           = 260353
ConfigIpls.doomsdayId                            = 269313
-- Arena Wars
ConfigIpls.arenaWarsId                           = 272385
-- The Rest
ConfigIpls.simeonId                              = 7170
ConfigIpls.vangelicoJewelryId                    = 82690
ConfigIpls.maxRendaId                            = 514
ConfigIpls.unionDepositoryId                     = 59906
ConfigIpls.morgueId                              = 60418
ConfigIpls.cluckinBellId                         = 75778
ConfigIpls.oneilsFarmId                          = 31746
ConfigIpls.lesterFactoryId                       = 72674
ConfigIpls.lifeInvaderId                         = 35842
ConfigIpls.carWashId                             = 198145
ConfigIpls.fameOrShameId                         = 78338
ConfigIpls.bahamaMamas                           = 168961
ConfigIpls.nightClubsId                          = 271617