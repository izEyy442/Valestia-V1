Config = {}

-- This enabled additional debug commands and logs
-- Debug commands:
-- /surfaceDebug - Displays the surface that the wheel is standing on along with all its configured values
Config.debug = false


-------------------------------------------------
--- GENERAL SETTINGS
-------------------------------------------------

-- By default this script is configured to replicate realistic(ish) values while keeping the gameplay fun and entertaining.
-- If you want to make this script less realistic and more arcady. If your players are getting annoyed and you don't want
-- a realistic handling. Here are the recommended values:
-- generalDepthDifficulty = 25
-- generalSinkageSpeed = 50
-- generalTractionLoss = 50

-- General difficulty of the depth handling.
-- 100 = default
-- Lower this value to make driving in deep surfaces (such as mud or deep sand) easier for ALL vehicles
-- Raise this value to make driving in deep surfaces more difficult
Config.generalDepthDifficulty = 100

-- General speed of the vehicle sinking into the surface
-- 100 = Default
-- Lower this value to make all vehicles sink slower
-- Raise this value to make all vehicles sink faster
Config.generalSinkageSpeed = 100

-- General loss of traction based on vehicle surface
-- Vehicles will be more likely to skid on low traction surfaces
-- Lower this value to decrease the general traction loss (make vehicles drift less on slippery surfaces)
-- Raise this value to make vehicles lose more traction on slippery surfaces (make vehicles drift more on slippery surfaces)
Config.generalTractionLoss = 100



-------------------------------------------------
--- VEHICLE MODIFIERS
-------------------------------------------------

-- Changes that offroad tires will make.
-- upgradeValue = value of how much better the vehicle should perform when deep in a surface (mud, sand, etc.)
-- tractionOnSoft = Additional traction when on materials of softness that's more than 10
-- tractionOnHard = Additional (in default case negative) traction on hard materials (softness less than 10)
Config.offroadTires = {
    upgradeValue = 50,
    tractionOnSoft = 20,
    tractionOnHard = -10,
}

-- Handling upgrade in deep surface for AWD (4WD) vehicles
Config.awdUpgrade = 25



-------------------------------------------------
--- SCRIPT PERFORMANCE SETTINGS
-------------------------------------------------

-- The refresh rate of all the sinking/surface logic. The higher the value the less smoother the visuals but better script performance.
-- If your server is known for players with slower devices you might want to turn this up
-- If your players have better computers or you really want the off-roading to look good try turning it down
-- Values between 100 - 500
Config.refreshRate = 200



-------------------------------------------------
--- AREA BLACKLISTING
-------------------------------------------------

-- Some custom MLOs have incorrectly set surfaces for the areas (e.g asphalt is marked as dirt or sand), causing vehicles to sink
-- Here you can define custom areas in which the script will not be active in

-- By default I configured some popular locations for custom MLOs to hopefully prevent majority of issues with sinking into
-- incorrectly setup MLO surfaces
Config.areaBlacklist = {
    { -- Pillbox hospital
        coords = vector3(293.17, -584.5, 42.8),
        radius = 20.0
    },
    { -- LSPD
        coords = vector3(444.9, -1003.2, 30.7),
        radius = 60.0
    },
    { -- Simeon's dealership
        coords = vector3(-40.4, -1111.3, 25.8),
        radius = 40.0
    },
    { -- BCSO
        coords = vector3(-446.0, 6013.8, 31.8),
        radius = 50.0
    },
    { -- Sandy Shores PD
        coords = vector3(1853.6, 3685.8, 34.3),
        radius = 25.0
    },
    { -- Legion Square
        coords = vector3(202.3, -941.9, 27.6),
        radius = 120.0
    },
}

-------------------------------------------------
--- DETAILED SETTINGS
-------------------------------------------------

-- Blacklist. This will disable all script functionality for said model/vehicle class
Config.blacklist = {
    models = {
        'rcbandito',
        'monster',
        'rhino',
        'scarab',
        'khanjali',
    },
    classes = {
        [0] = false, -- Compacts
        [1] = false, -- Sedans
        [2] = false, -- SUVs
        [3] = false, -- Coupes
        [4] = false, -- Muscle
        [5] = false, -- Sports Classics
        [6] = false, -- Sports
        [7] = false, -- Super
        [8] = false, -- Motorcycles
        [9] = false, -- Off-road
        [10] = false, -- Industrial
        [11] = false, -- Utility
        [12] = false, -- Vans
        [17] = false, -- Service
        [18] = false, -- Emergency
        [19] = false, -- Military
        [20] = false, -- Commercial
    }
}

-- If you define a model specific multiplier it will be used instead of the class multiplier
-- Vehicle classes https://docs.fivem.net/natives/?_0x29439776AAA00A62
-- Abstract value - Determines how well the class or model of the vehicle can handle being submerged in the surface
-- 0 = Default
-- Positive values = Better handling / ability to get out of deep surface
-- Negative values = Worse handling / less ability to get out of deep surface
Config.depthHandlingQuality = {
    models = {
        seminole2 = 20,
        sandking = 20,
        sandking2 = 20,
        issi2 = -10,
        panto = -20,
        comet4 = 30,

        -- dirt bikes
        bf400 = 30,
        sanchez = 20,
        manchez = 20,
        esskey = 0,
        cliffhanger = 0,
        enduro = 0,
    },
    classes = {
        [0] = 5, -- Compacts
        [1] = -5, -- Sedans
        [2] = 15, -- SUVs
        [3] = 0, -- Coupes
        [4] = -5, -- Muscle
        [5] = 5, -- Sports Classics
        [6] = 5, -- Sports
        [7] = 5, -- Super
        [8] = -10, -- Motorcycles
        [9] = 35, -- Off-road
        [10] = -10, -- Industrial
        [11] = -10, -- Utility
        [12] = -5, -- Vans
        [17] = 10, -- Service
        [18] = 10, -- Emergency
        [19] = 15, -- Military
        [20] = -5, -- Commercial
    }
}

-------------------------------------------------
--- ROADSIDE SETTINGS
-------------------------------------------------

-- When enabled it makes surfaces which are close to main roads less deep to prevent cars from sinking too deep when on the median etc.
Config.roadSideHelper = {
    enabled = true,
    
    -- Maximum distance from the road (mind that this takes the middle point of the road. You can see the distance in the /surfaceDebug mode
    distanceThreshold = 15.0,
    
    -- Depth multiplier
    depthMultiplier = 0.1,

    -- Traction loss multiplier
    tractionMultiplier = 0.25,
}



-------------------------------------------------
--- SURFACES
-------------------------------------------------

-- name = Only used for the ease of config as well as the debug mode
-- traction = Amount of traction on the surface. Anything below 100 will make the vehicles skid. Lower value = more skid
-- Maximum 100
-- Minimum 0

-- depth = Maximum depth of the surface in mm (millimeter) - (100mm = +-4 inches)
-- Maximum infinite
-- Minimum 0

-- softness = The softness of the material. This dictates how fast the vehicles will sink into the surface. (This is also used for off-road tires to decide their handling boost
-- Maximum infinite
-- Minimum 0

-- Values which will be assigned to all un-configured surfaces
Config.fallbackSurface = {
    name = 'Fallback Surface',
    traction = 100,
    depth = 0,
    softness = 0,
}

Config.surfaces = {
    [1] = {
        name = 'Concrete',
        traction = 100,
        depth = 0,
        softness = 0,
    },
    [4] = {
        name = 'Road',
        traction = 100,
        depth = 0,
        softness = 0,
    },
    [5] = {
        name = 'Metal',
        traction = 100,
        depth = 0,
        softness = 0,
    },
    [6] = {
        name = 'Sandy roadside',
        traction = 80,
        depth = 50,
        softness = 5,
    },
    [9] = {
        name = 'Sandstone',
        traction = 80,
        depth = 0,
        softness = 0,
    },
    [10] = {
        name = 'Rock',
        traction = 80,
        depth = 0,
        softness = 0,
    },
    [11] = {
        name = 'Rock',
        traction = 80,
        depth = 0,
        softness = 0,
    },
    [13] = {
        name = 'Cobble',
        traction = 90,
        depth = 0,
        softness = 0,
    },
    [16] = {
        name = 'Limestoneesque sand',
        traction = 80,
        depth = 0,
        softness = 0,
    },
    [17] = {
        name = 'Rocky dry dirt',
        traction = 80,
        depth = 50,
        softness = 5,
    },
    [18] = {
        name = 'Dry sand',
        traction = 80,
        depth = 130,
        softness = 40,
    },
    [19] = {
        name = 'Road sand',
        traction = 90,
        depth = 30,
        softness = 5,
    },
    [20] = {
        name = 'Grainy Sand',
        traction = 80,
        depth = 100,
        softness = 10,
    },
    [21] = {
        name = 'Gravely sand',
        traction = 70,
        depth = 220,
        softness = 30,
    },
    [22] = {
        name = 'Wet hard sand',
        traction = 70,
        depth = 250,
        softness = 50,
    },
    [23] = {
        name = 'Gravel road',
        traction = 75,
        depth = 50,
        softness = 5,
    },
    [24] = {
        name = 'Wet sand',
        traction = 60,
        depth = 350,
        softness = 70,
    },
    [31] = {
        name = 'Gravely dirt/path',
        traction = 70,
        depth = 50,
        softness = 5,
    },
    [32] = {
        name = 'Gravely dirt',
        traction = 70,
        depth = 200,
        softness = 15,
    },
    [35] = {
        name = 'Tuff Sand',
        traction = 90,
        depth = 50,
        softness = 5,
    },
    [36] = {
        name = 'Dirt',
        traction = 70,
        depth = 300,
        softness = 40,
    },
    [37] = {
        name = 'Deep road sand',
        traction = 60,
        depth = 75,
        softness = 15,
    },
    [38] = {
        name = 'Rocky sand',
        traction = 70,
        depth = 150,
        softness = 10,
    },
    [40] = {
        name = 'Moist dirt path',
        traction = 60,
        depth = 150,
        softness = 50,
    },
    [41] = {
        name = 'Swamp grass',
        traction = 50,
        depth = 250,
        softness = 50,
    },
    [42] = {
        name = 'Swamp sand',
        traction = 70,
        depth = 500,
        softness = 110,
    },
    [43] = {
        name = 'Hard Sand',
        traction = 75,
        depth = 50,
        softness = 10,
    },
    [44] = {
        name = 'Dirt/Sand',
        traction = 50,
        depth = 200,
        softness = 25,
    },
    [46] = {
        name = 'Hard grass',
        traction = 80,
        depth = 50,
        softness = 5,
    },
    [47] = {
        name = 'Grass',
        traction = 65,
        depth = 125,
        softness = 10,
    },
    [48] = {
        name = 'Tall grass',
        traction = 60,
        depth = 150,
        softness = 20,
    },
    [49] = {
        name = 'Farmland',
        traction = 60,
        depth = 200,
        softness = 35,
    },
    [50] = {
        name = 'Podzol',
        traction = 70,
        depth = 125,
        softness = 25,
    },
    [51] = {
        name = 'Podzol',
        traction = 70,
        depth = 125,
        softness = 25,
    },
    [52] = {
        name = 'Dry podzol',
        traction = 80,
        depth = 75,
        softness = 10,
    },
    [64] = {
        name = 'Metal',
        traction = 90,
        depth = 0,
        softness = 0,
    },
    [125] = {
        name = 'Drain concrete',
        traction = 70,
        depth = 0,
        softness = 0,
    },
}


-- Zone multiplier
-- This has been added to modify the maximum depth of all surfaces located within zones.
-- Its used to make grass located (for example) in the city less deep to make it more realistic and easier to drive on.
-- If you have popular areas in your city in which you want the off-roading (think of road medians etc.) to be easier you can add the zone here.
-- Same goes for areas which you want to be more difficult. You can make the depth multiplier higher for those

-- You can view the zone you're in by using the debug command /surfaceDebug

-- Map of zones: https://www.reddit.com/media?url=https%3A%2F%2Fi.redd.it%2F5cw11krz9kcz.jpg
-- Zone names and hashes: https://docs.fivem.net/natives/?_0xCD90657D4C30E1CA

Config.zones = {
    {
        name = 'City',
        depthMultiplier = 0.3,
        tractionMultiplier = 0.6,
        zones = {
            'MOVIE',
            'ROCKF',
            'DOWNT',
            'DTVINE',
            'EAST_V',
            'GOLF',
            'LEGSQU',
            'ROCKF',
            'MORN',
            'STAD',
            'DAVIS',
            'RANCHO',
            'STRAW',
            'CHAMH',
            'PBOX',
            'SKID',
            'TEXTI',
            'LMESA',
            'ELYSIAN',
            'TERMINA',
            'HAWICK',
            'ALTA',
            'BURTON',
            'DELPE',
        },
    },
    {
        name = 'City beaches',
        depthMultiplier = 0.75,
        tractionMultiplier = 0.75,
        zones = {
            'BEACH',
            'DELBE',
        },
    },
    {
        name = 'Mountains',
        depthMultiplier = 1.25,
        tractionMultiplier = 1.1,
        zones = {
            'MTCHIL',
            'MTGORDO',
            'MTJOSE',
            'PALHIGH',
        },
    },
    {
        name = 'Zancudo Swamp',
        depthMultiplier = 1.1,
        tractionMultiplier = 1.1,
        zones = {
            'LAGO',
            'ZANCUDO',
        },
    },
    {
        name = 'Popular',
        depthMultiplier = 0.75,
        tractionMultiplier = 0.75,
        zones = {
            'PALETO',
            'HARMO',
            'GRAPES',
            'SANDY',
            'RTRAK',
            'ZQ_UAR',
            'HUMLAB',
        },
    },
}


-- (Advanced)
-- When making the vehicles sink the suspension does not always get updated properly.
-- Therefore I had to add a system which updates/refreshes the vehicles suspension.
-- There are two systems "force" and "flag". "force" is an old system which applies tiny amounts of visual damage to the car
-- Unfortunately this sometimes appears to be too much for certain modded vehicles with very soft shells.
-- The new system "flag" seems to work much better but hasn't been tested with some vehicles.
-- If you encounter any issues with this system, please let us know on our discord <3
Config.suspensionRefresh = {
    enabled = true,
    type = 'flag',
}
