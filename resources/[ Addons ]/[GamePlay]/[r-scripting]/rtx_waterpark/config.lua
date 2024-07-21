Config = {}

Config.Framework = "standalone"  -- types (standalone, qbcore, esx)

Config.ESXFramework = {
	newversion = false, -- use this if you using new esx version (if you get error with old esxsharedobjectmethod in console)
	getsharedobject = "esx:getSharedObject"
}

Config.QBCoreFrameworkResourceName = "qb-core" -- qb-core resource name, change this if you have different name of main resource of qbcore

Config.Language = "English" -- text language from code

Config.WaterParkPaymentRequired = false -- enable this if you want to have payed entry to waterpark (for standalone framework you need edit other.lua function to add there remove money funciton)

Config.WaterParkPass = false -- enable this if you want use waterpass items (for qbcore, esx, its already configured you need use give items to players (items: waterpass, waterpassunlimited) for standalone version you need create item in other.lua, we have example here.

Config.WaterPassTime = 10 -- time when normal waterpass expire when player use it (in minutes)

Config.WaterParkEntryPrice = 100 -- price for entry to waterpark (Config.WaterParkPaymentRequired must be activated)

Config.WaterSlideWait = 5000 -- wait in miliseconds after other player can use waterslide

Config.TurnStileLockWait = 4000 -- time after locking the turnstile after purchasing entry (Config.WaterParkPaymentRequired must be activated)

Config.WaterSlideUseDistance = 3.5 -- max distance for use waterslide

Config.WaterSlideBuyDistance = 3.5 -- max distance for buy entry

Config.Target = false -- enable this if you want use target

Config.Targettype = "qtarget" -- types - qtarget, qbtarget, oxtarget

Config.TargetIcons = {buyicon = "fa-solid fa-cart-shopping", slideicon = "fa-solid fa-water"} 

Config.WaterParkSlideEntryBuyKey = "E" -- water slide entry buy key

Config.WaterParkSlideUseKey = "E" -- water slide use key

Config.WaterParkInteractionSystem = 1 -- 1 == Our custom interact system, 2 == 3D Text Interact, 3 == Gta V Online Interaction Style

Config.CalmWater = false -- enable this if you want calm water in waterpark

Config.CalmWaterValue = 0.60 -- value of calm water (higher number more calm)

Config.DisablePlayerControlsOnSlide = true -- enable this if you want to disable players controls.

Config.DifferentAnimation = {enabled = false, animdict = "", animname = ""} -- configure this if you want use different animation for water slide

Config.WaterSlideSpeed = 1.7 -- we recommend to keep it as 1, maximum is 2

Config.CustomPedsOffsets = { -- offsets for custom ped models
    {
        pedmodel = "player_one", -- ped model name
		zoffset = 0.8,  -- z offset
	},
}

Config.WaterParkBlip = {
	blip = true, -- enable this if you want display blip on map
	blipcoords = vector3(-1410.49, -1586.86, 1.93), -- location of blip
	blipiconid = 266, -- icon type
	blipdisplay = 4, -- icon display
	blipcolor = 3, -- icon color
	blipshortrange = true, -- icon range
	blipscale = 0.6, -- icon scale
	bliptext = "[Activité] Parc Aquatique", -- text of blip
}

function Notify(text)
	exports["rtx_notify"]:Notify("Water Park", text, 5000, "info") -- if you get error in this line its because you dont use our notify system buy it here https://rtx.tebex.io/package/5402098 or you can use some other notify system just replace this notify line with your notify system
	--exports["mythic_notify"]:SendAlert("inform", text, 5000)
end

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