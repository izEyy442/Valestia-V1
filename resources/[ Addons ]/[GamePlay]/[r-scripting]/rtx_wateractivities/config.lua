Config = {}

Config.Framework = "esx"  -- types (standalone, qbcore, esx)

Config.ESXFramework = {
	newversion = true, -- use this if you using new esx version (if you get error with old esxsharedobjectmethod in console)
	getsharedobject = "esx:getSharedObject",
	resourcename = "Framework"
}

Config.QBCoreFrameworkResourceName = "qb-core" -- qb-core resource name, change this if you have different name of main resource of qbcore

Config.InterfaceColor = "#ff66ff" -- change interface color, color must be in hex

Config.Language = "English" -- text language from code (English)

Config.Target = false -- enable this if you want use target

Config.Targettype = "qtarget" -- types - qtarget, qbtarget, oxtarget

Config.TargetIcons = {ticketicon = "fa-solid fa-cart-shopping", seaticon = "fa-solid fa-chair"} 

Config.WaterActivitiesInteractionSystem = 1 -- 1 == Our custom interact system, 2 == 3D Text Interact, 3 == Gta V Online Interaction Style

Config.WaterActivitiesViaItem = false -- if you enable this feature, activities can only be spawned via item. Only works for qbcore and esx! (you can edit other.lua to create item for other frameworks)

Config.WaterActivitiesViaCommand = true -- if you enable this feature, activities can only be spawned via command. Commands is writed in Config.WaterActivitiesSpawnableCommands

Config.WaterActivitiesSeatKey = "E" -- water activities key for sit

Config.WaterActivitiesExitKey = "F" -- water activities key for exit

Config.WaterActivitiesEndAttractionKey = "G" -- water activities key for end

Config.EndAttractionAfterLeavingVehicle = false -- enable this if you want to end attraction when host of the attraction leave vehicle

Config.WaterActivitiesEndAttractionInterface = true -- enable this if you want show screen interface with press bind to end attraction

Config.SandCastlesBuild = true -- enable this if you want to allow players to build sand castles

Config.SandCastlesBuildCommand = "buildsandcastle" -- 4 types of sand castles example for spawn /buildsandcastle 1 or /buildsandcastle 2

Config.SandCastlesBuildDuration = 15 -- in seconds

Config.LoungerRemoveCommand = "removelounger" -- command for remove nearby lounger

Config.FallingFromAttractions = true -- enable this if you want fall from attractions (This triggers a mini-game where the player must react, if they don't react in time they will fall off the ride.)

Config.FallingFromAttractionsReactionTime = 4500 -- maximum time at which the player must react in order not to fall (in miliseconds)

Config.FallingFromAttractionsReactionWatingTime = 4500 -- the time it takes for the reaction to appear (in miliseconds)

Config.FallingFromAttractionsOnlyInAngle = false -- enable this feature if you only want a reaction minigame when the attraction is at an angle.

Config.WaterActivitiesForAnyBoat = true -- enable this if you want water activites for all boats, if you disable that it will work only for boats which is defined in Config.WaterActivitiesVehicles

Config.WaterActivitiesVehicles = {
	{
		vehiclename = "jetmax", -- vehicle name
	},	
}

Config.WaterActivitiesSpawnableCommands = {
	["banana"] = "spawnbanana", -- command for spawn a banana ride
	["inflatablering1"] = "spawnring1", -- command for spawn a inflatable ride (for 3 players)
	["inflatablering2"] = "spawnring2", -- command for spawn a inflatable ride (for 3 players)
	["parasailing"] = "spawnparachute", -- command for spawn a parasailing ride
	["ski"] = "spawnski", -- command for spawn a water ski ride
	["lounger1"] = "lounger1", -- command for spawn a lounger (type 1)
	["lounger2"] = "lounger2", -- command for spawn a lounger (type 2)
	["lounger3"] = "lounger3", -- command for spawn a lounger (type 3)
	["lounger4"] = "lounger4", -- command for spawn a lounger (type 4 for 4 players)
}

Config.AttractionsSettings = {
	banana = {
		usedistance = 2.5,  -- distance for use attraction
	},
	inflatable = {
		usedistance = 2.5,  -- distance for use attraction,		
	},	
	parasailing = {
		usedistance = 2.5,  -- distance for use attraction
		maxheight = 100.0,
	},	
	ski = {
		usedistance = 10.5,  -- distance for use attraction
		markerstyle = {markercolor = {r = 255, g = 102, b = 255}, markersize = {x = 1.5, y = 1.5, z = 1.0}},
	},
	circle = {
		usedistance = 2.5,  -- distance for use attraction
	},	
	bed = {
		usedistance = 2.5,  -- distance for use attraction
	},		
	scootercars = {
		disable = false, -- enable this if you dont want to use this attraction
		scootermodel = "jetmax", -- vehicle model of scooter
		buycoords = vector3(-1293.08, -1755.15, 2.15), -- coors for rent scooter
		buydistance = 1.5,  -- distance for buy ticket
		minminutes = 1, -- minimum minutes in scooter cars
		maxminutes = 10, -- max minutes in scooter cars
		priceperminute = 10, -- price for ticket per minute
		maxplayers = 15, -- maximum number of players for scooter cars
		scooterbuykey = "E",-- scooter cars key for buy scooter cars
		scooterleavekey = "E",-- scooter cars key for leave scooter cars
		disablescooterkeyboard = true, -- turning off the keyboard when driving scooter cars
		blip = {
			enabled = true, -- enable this if you want display blip on map
			blipiconid = 410, -- icon type
			blipdisplay = 4, -- icon display
			blipcolor = 3, -- icon color
			blipshortrange = true, -- icon range
			blipscale = 0.7, -- icon scale
			bliptext = "[Activité] Location de bateau", -- text of blip
		},		
		marker = {
			enabled = true, -- enable this if you want display marker when player is nearby
			markerdistance = 10.0, -- minimum distance to see a marker.
			markertype = 1, 
			markercolor = {r = 255, g = 102, b = 255}, 
			markersize = {x = 1.5, y = 1.5, z = 1.0},
		},		
	},	
}

Config.SandCastlesBuildAllowedGroundMaterial = {
	[1288448767] = true,
	[-1595148316] = true,
	[1144315879] = true,
	[510490462] = true,
}

Config.SandCastlesModelTypes = { -- if you want change models of sand castles, you can do it here.
	[1] = "prop_beach_sculp_01",
	[2] = "prop_beach_sandcas_03",
	[3] = "prop_beach_sandcas_04",
	[4] = "prop_beach_sandcas_05",
}

Config.ScooterCarsSpawnPoints = {
	{coords = vector3(-1324.4, -1784.24, -1.0), heading = 119.5, radius = 2.0},
	{coords = vector3(-1328.34, -1777.88, -1.16), heading = 119.5, radius = 2.0},
	{coords = vector3(-1335.67, -1768.84, -1.07), heading = 119.5, radius = 2.0},
	{coords = vector3(-1339.81, -1758.83, -0.97), heading = 119.5, radius = 2.0},
	{coords = vector3(-1343.07, -1749.59, -0.86), heading = 119.5, radius = 2.0},
	{coords = vector3(-1343.07, -1749.59, -0.86), heading = 119.5, radius = 2.0},
	{coords = vector3(-1339.03, -1746.11, -0.73), heading = 119.5, radius = 2.0},
}

Config.ReactionLetters = { -- letters for reaction
	{reactionkey = "H", keyid = 74},
	{reactionkey = "U", keyid = 303},
	{reactionkey = "S", keyid = 8},
	{reactionkey = "D", keyid = 9},
	{reactionkey = "H", keyid = 74},
	{reactionkey = "B", keyid = 29},
}

Config.WaterActivitiesItemNames = { -- item names for attractions
	["banana"] = "banana",
	["inflatable"] = "inflatable",
	["parasailing"] = "parasailing",
	["ski"] = "ski",
	["circle"] = "circle",
	["bed1"] = "bed1",
	["bed2"] = "bed2",
	["bed3"] = "bed3",
	["bed4"] = "bed4",
}


Config.PlayerLoadedEvent = { -- load methods of water wctivities
	esx = "esx:playerLoaded", 
	qbcore = "QBCore:Client:OnPlayerLoaded",
	standalone = "playerLoaded",
	customevent = true, -- enable this if you dont want load water wctivities after player loaded to server. (enable this for example for servers with multicharacter)
	standaloneevent = false, -- enable this if you dont want load water wctivities after player loaded to server. (for standalone version)
}

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 240
		DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 255, 102, 255, 150)
	end
end


function Notify(text)
	TriggerEvent('esx:showNotification',text) -- if you get error in this line its because you dont use our notify system buy it here https://rtx.tebex.io/package/5402098 or you can use some other notify system just replace this notify line with your notify system
	--exports["mythic_notify"]:SendAlert("inform", text, 5000)
end

function AddScooterKey(vehicle)
	-- if you use some vehicle key system, add here your function for add keys (name of vehicle is seashark)
end