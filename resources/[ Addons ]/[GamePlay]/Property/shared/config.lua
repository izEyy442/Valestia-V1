Config = {}

Config.PropertySettings = {
	EnableBanner = false, -- Activer ou non la bannière personnalisée, (Bannière Dynasty8)
    AllowedJob = "realestateagent", -- Job alloué pour avoir accès au F6
	ActivateForcedDoor = true, -- Activer ou non la possibilité de "Rentrer de force dans la propriété"
	AllowedJobs = { -- Jobs ayant l'accès à "Rentrer de force dans la propriété"
		"police","bcso"
	}
}

Config.Buckets = { 
    ["player"] = 178540, 
}

Config.BuilderSettings = { 
    PropertiesType = 1,
    PropertyInfos = {},
    AnnounceList = {Index = 1, "~HUD_COLOUR_WAYPOINT~Ouvert~s~", "~HUD_COLOUR_WAYPOINT~Fermé~s~", "~HUD_COLOUR_WAYPOINT~Autres~s~"},
	InteriorsList = {
		Index = 1, 
		"~HUD_COLOUR_WAYPOINT~Appartement Modeste~s~", "~HUD_COLOUR_WAYPOINT~Appartement (Motel)~s~",
		"~HUD_COLOUR_WAYPOINT~Appartement Moderne~s~", "~HUD_COLOUR_WAYPOINT~Appartement Luxueux #1~s~",
		"~HUD_COLOUR_WAYPOINT~Appartement Luxueux #2~s~", "~HUD_COLOUR_WAYPOINT~Appartement Luxueux #3~s~",
		"~HUD_COLOUR_WAYPOINT~Appartement Luxueux #4~s~", "~HUD_COLOUR_WAYPOINT~Maison Moderne #1~s~",
		"~HUD_COLOUR_WAYPOINT~Maison Moderne #2~s~", "~HUD_COLOUR_WAYPOINT~Bureau~s~",
		"~HUD_COLOUR_WAYPOINT~Bureau - (Stock)~s~", "~HUD_COLOUR_WAYPOINT~Bureau - (Avocat)~s~",
		"~HUD_COLOUR_WAYPOINT~Club de bikers~s~", "~HUD_COLOUR_WAYPOINT~Entrepôt (Petit)~s~", 
		"~HUD_COLOUR_WAYPOINT~Entrepôt (Moyen)~s~", "~HUD_COLOUR_WAYPOINT~Entrepôt (Grand)~s~"
	},
    GarageList = {Index = 1, "~HUD_COLOUR_WAYPOINT~2 places~s~", "~HUD_COLOUR_WAYPOINT~4 places~s~", "~HUD_COLOUR_WAYPOINT~6 places~s~", "~HUD_COLOUR_WAYPOINT~10 places~s~"},
    StorageList = {Index = 1, "~HUD_COLOUR_WAYPOINT~50KG~s~", "~HUD_COLOUR_WAYPOINT~75KG~s~", "~HUD_COLOUR_WAYPOINT~125KG~s~", "~HUD_COLOUR_WAYPOINT~250KG~s~"},
	PropertyList = {Index = 1, "Tout", "Propriété(s)", "Garage(s)"},
    SellList = {Index = 1, "Moi", "Joueurs"},
    AddGarageCheckbox = false,
    CheckForView = false,
    dataMoneyList = {
        {Index = 1, "Déposer", "Retirer"},
        {Index = 1, "Déposer", "Retirer"}
    }
}

Config.PropertiesInteriors = {
	{
		IdType = 1, 
		PropertyName = "Appartement Modeste",
		IPL = vector3(266.129,-1007.42,-102.008), 
		Storage = vector3(265.828,-999.302,-99.008), 
		Exit = vector3(266.129,-1007.42,-102.008)
	},
	{
		IdType = 2, 
		PropertyName = "Appartement (Motel)",
		IPL = vector3(151.46,-1007.74,-99), 
		Storage = vector3(151.34512329102,-1003.0447387695,-99.0), 
		Exit = vector3(151.46,-1007.74,-99)
	},
	{
		IdType = 3,
		PropertyName = "Appartement Moderne",
		IPL = vector3(346.613, -1012.85, -100.196), 
		Storage = vector3(345.224,-996.93,-99.19), 
		Exit = vector3(346.613, -1012.85, -100.196)
	},
	{
		IdType = 4, 
		PropertyName = "Appartement Luxueux #1",
		IPL = vector3(-31.55,-595.03,79.03),
		Storage = vector3(-7.784,-594.330,79.430), 
		Exit = vector3(-31.55,-595.03,79.03)
	},
	{
		IdType = 5, 
		PropertyName = "Appartement Luxueux #2",
		IPL = vector3(-17.766,-589.527,89.114), 
		Storage = vector3(-22.417,-590.79,90.114), 
		Exit = vector3(-17.766,-589.527,89.114)
	},
    {
		IdType = 6,
		PropertyName = "Appartement Luxueux #3",
		IPL = vector3(-774.1382, 342.0316, 196.050), 
		Storage = vector3(-764.16,331.25,196.08), 
		Exit = vector3(-774.1382, 342.0316, 196.050)
	},
    {
		IdType = 7, 
		PropertyName = "Appartement Luxueux #4",
		IPL = vector3(-786.87, 315.7497, 186.91), 
		Storage = vector3(-796.78894042969,329.40200805664,190.71348571777), 
		Exit = vector3(-786.87, 315.7497, 186.91)
	},
	{
		IdType = 8, 
		PropertyName = "Maison Moderne #1",
		IPL = vector3(-174.28,497.65,136.66), 
		Storage = vector3(-169.847,491.016,130.043), 
		Exit = vector3(-174.28,497.65,136.66)
	},
    {
		IdType = 9, 
		PropertyName = "Maison Moderne #2",
		IPL = vector3(373.603,423.684,144.907), 
		Storage = vector3(373.836,433.312,138.300), 
		Exit = vector3(373.603,423.684,144.907)
	},
    {
		IdType = 10, 
		PropertyName = "Bureau",
		IPL = vector3(-141.1987, -620.913, 167.8205), 
		Storage = vector3(-138.975, -634.139, 168.820), 
		Exit = vector3(-141.1987, -620.913, 167.8205)
	},
    {
		IdType = 11, 
		PropertyName = "Bureau - (Stock)",
		IPL = vector3(1173.47,-3196.55,-40), 
		Storage = vector3(1167.11,-3197.11,-39.00), 
		Exit = vector3(1173.47,-3196.55,-40)
	},
    {
		IdType = 12, 
		PropertyName = "Bureau - (Avocat)",
		IPL = vector3(-1902.145,-572.377,18.097), 
		Storage = vector3(-1912.501,-570.140,19.097), 
		Exit = vector3(-1902.145,-572.377,18.097)
	},
    {
		IdType = 13,
		PropertyName = "Club de bikers",
		IPL = vector3(1121.02,-3152.78,-38.30), 
		Storage = vector3(1112.28,-3145.16,-37.06), 
		Exit = vector3(1121.02,-3152.78,-38.30)
	},
    -- {
	-- 	IdType = 14, 
	-- 	PropertyName = "Local",
	-- 	IPL = vector3(242.2, 361.4, 104.74), 
	-- 	Storage = vector3(245.9732208252,370.64495849609,105.7381362915), 
	-- 	Exit = vector3(242.2, 361.4, 104.74)
	-- },
    {
		IdType = 15, 
		PropertyName = "Entrepôt (Petit)",
		IPL = vector3(1087.35,-3099.43,-39.80), 
		Storage = vector3(1088.572,-3101.529,-38.999), 
		Exit = vector3(1087.35,-3099.43,-39.80)
	},
    {
		IdType = 16, 
		PropertyName = "Entrepôt (Moyen)",
		IPL = vector3(1048.02,-3097.10,-39.99), 
		Storage = vector3(1049.147,-3100.367,-38.999), 
		Exit = vector3(1048.02,-3097.10,-39.99)
	},
    {
		IdType = 17, 
		PropertyName = "Entrepôt (Grand)",
		IPL = vector3(992.40,-3097.85,-39.99), 
		Storage = vector3(994.37,-3100.53,-38.99), 
		Exit = vector3(992.40,-3097.85,-39.99)
	}
}


Config.GarageInteriors = {   
    {
        IdType = 1, -- 2 places
        IPL = vector3(178.98764038086,-1000.0971069336,-98.999938964844), 
        Computer = vector3(172.72589111328,-1000.1436767578,-98.999938964844),
        Exit = vector3(178.98764038086,-1000.0971069336,-98.999938964844), 
        AllowedPositions = {
            {pos = vector3(171.66674804688,-1004.0279541016,-99.85), heading = 179.53 },
            {pos = vector3(175.15599060059,-1003.4877929688,-99.85), heading = 179.67 }
        }
    },
    {
        IdType = 2, -- 4 places
        IPL = vector3(206.88, -1018.4, -99.0), 
        Computer = vector3(205.53, -1014.68, -99.0),
        Exit = vector3(206.88, -1018.4, -99.0), 
        AllowedPositions = {
            {pos = vector3(194.50, -1016.14, -99.85), heading = 180.13 },
            {pos = vector3(194.57, -1022.32, -99.85), heading = 180.13 },
            {pos = vector3(202.21, -1020.14, -99.85), heading = 90.13 },
            {pos = vector3(202.21, -1023.32, -99.85), heading = 90.13 }
        }
    },
    {
        IdType = 3, -- 6 places
        IPL = vector3(207.15864562988,-998.93975830078,-99.0), 
        Computer = vector3(205.65, -995.29, -99.0),
        Exit = vector3(207.15864562988,-998.93975830078,-99.0), 
        AllowedPositions = {
            {pos = vector3(203.82, -1004.63, -99.85), heading = 88.05 },
            {pos = vector3(194.16, -1004.63, -99.85), heading = 266.42 },
            {pos = vector3(193.83, -1000.63, -99.85), heading = 266.42 },
            {pos = vector3(202.62, -1000.63, -99.85), heading = 88.05 },
            {pos = vector3(193.83, -997.01, -99.85), heading = 266.42 },
            {pos = vector3(202.62, -997.01, -99.85), heading = 88.05 }
        }
    },
    {
        IdType = 4, -- 10 places
        IPL = vector3(240.71, -1004.96, -99.0), 
        Computer = vector3(234.41, -976.79, -99.0),
        Exit = vector3(240.71, -1004.96, -99.0), 
        AllowedPositions = {
            {pos = vector3(233.47, -982.57, -99.85), heading = 90.1 },
            {pos = vector3(233.47, -987.57, -99.85), heading = 90.1 },
            {pos = vector3(233.47, -992.57, -99.85), heading = 90.1 },
            {pos = vector3(233.47, -997.57, -99.85), heading = 90.1 },
            {pos = vector3(233.47, -1002.57, -99.85), heading = 90.1 },
            {pos = vector3(223.55, -982.57, -99.85), heading = 266.36 },
            {pos = vector3(223.55, -987.57, -99.85), heading = 266.36 },
            {pos = vector3(223.55, -992.57, -99.85), heading = 266.36 },
            {pos = vector3(223.55, -997.57, -99.85), heading = 266.36 },
            {pos = vector3(223.55, -1002.57, -99.85), heading = 266.36 }
        }
    },
}