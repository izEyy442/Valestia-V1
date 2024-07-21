--[[
  This file is part of SweetyLife RolePlay.
  Copyright (c) SweetyLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Config = {
	AccessPalier = true,
	PlateLetters = 4,
	PlateNumbers = 4,
	TimeToRespawn = 200,
	TimeToJesus = 400,
	RespawningPlace = vector3(320.5275, -570.8456, 48.21426),
	Percent = 0.05,
    Get = {
        ESX = "esx:getSharedObject",
		Marker = {
			Type = 2,
			Size = {0.2, 0.2, 0.2},
			Color = {45,110,185},
			Rotation = 180.0,
		},
    },

	Radars = {
		{ station = 1, name = 'Commissariat', speedlimit = 130, r = 35, flash = {x = 398.12, y = -1050.50, z = 29.39 }, props = { x = 419.14, y = -1033.50, z = 28.48 } },
    	{ station = 2, name = 'Benny\'s', speedlimit = 130, r = 40, flash = {x = -270.35, y = -1139.82, z = 23.09 }, props = { x = -247.89, y = -1125.06, z = 18.84 } },
    	{ station = 3, name = 'San Andreas Avenue', speedlimit = 130, r = 40, flash = { x = -251.45, y = -661.61, z = 33.25 }, props = { x = -232.12, y = -650.50, z = 32.27 } },
    	{ station = 4, name = 'Parking central', speedlimit = 130, r = 40, flash = {x = 169.67, y = -819.68, z = 31.17}, props = {x = 201.02, y = -805.37, z = 30.06} },
   	 	{ station = 5, name = 'Freeway', speedlimit = 300, r = 40, flash = {x = 1613.86, y = 1122.46, z = 82.66}, props = {x = 1627.88, y = 1135.56, z = 82.05} },
		{ station = 6, name = 'Freeway Sud', speedlimit = 300, r = 40, flash = {x = -2318.29, y = -322.42, z = 13.79}, props = {x = -2284.40, y = -309.78, z = 16.01} },
		{ station = 7, name = 'Freeway Nord', speedlimit = 250, r = 20, flash = {x = 2431.51, y = -177.62, z = 87.96}, props = {x = 2445.56, y = -166.68, z = 87.36}},
	},

	Components = {
		{
			label = _U('sex'),
			name = 'sex',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65
		},
		{
			label = _U('mom'),
			name = 'mom',
			value = 21,
			min = 21,
			zoomOffset = 0.6,
			camOffset = 0.65
		},
		{
			label = _U('dad'),
			name = 'dad',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65
		},
		{
			label = _U('resemblance'),
			name = 'face_md_weight',
			value = 50,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65
		},
		{
			label = _U('skin_tone'),
			name = 'skin_md_weight',
			value = 50,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65
		},
		{
			label = _U('nose_1'),
			name = 'nose_1',
			value = 0,
			min = -10,
			zoomOffset = 0.6,
			camOffset = 0.65
		},
		{
			label = _U('nose_2'),
			name = 'nose_2',
			value = 0,
			min = -10,
			zoomOffset = 0.6,
			camOffset = 0.65
		},
		{
			label = _U('nose_3'),
			name = 'nose_3',
			value = 0,
			min = -10,
			zoomOffset = 0.6,
			camOffset = 0.65
		}, {
			label = _U('nose_4'),
			name = 'nose_4',
			value = 0,
			min = -10,
			zoomOffset = 0.6,
			camOffset = 0.65
		}, {
			label = _U('nose_5'),
			name = 'nose_5',
			value = 0,
			min = -10,
			zoomOffset = 0.6,
			camOffset = 0.65
		}, {
			label = _U('nose_6'),
			name = 'nose_6',
			value = 0,
			min = -10,
			zoomOffset = 0.6,
			camOffset = 0.65
		}, {
			label = _U('cheeks_1'),
			name = 'cheeks_1',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('cheeks_2'),
			name = 'cheeks_2',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('cheeks_3'),
			name = 'cheeks_3',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('lip_fullness'),
			name = 'lip_thickness',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('jaw_bone_width'),
			name = 'jaw_1',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('jaw_bone_length'),
			name = 'jaw_2',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('chin_height'),
			name = 'chin_1',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('chin_length'),
			name = 'chin_2',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('chin_width'),
			name = 'chin_3',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('chin_hole'),
			name = 'chin_4',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('neck_thickness'),
			name = 'neck_thickness',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('hair_1'),
			name = 'hair_1',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65
		}, {
			label = _U('hair_2'),
			name = 'hair_2',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65
		}, {
			label = _U('hair_color_1'),
			name = 'hair_color_1',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65
		}, {
			label = _U('hair_color_2'),
			name = 'hair_color_2',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65
		}, {
			label = _U('tshirt_1'),
			name = 'tshirt_1',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			componentId = 8
		}, {
			label = _U('tshirt_2'),
			name = 'tshirt_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			textureof = 'tshirt_1'
		}, {
			label = _U('torso_1'),
			name = 'torso_1',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			componentId = 11
		}, {
			label = _U('torso_2'),
			name = 'torso_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			textureof = 'torso_1'
		}, {
			label = _U('decals_1'),
			name = 'decals_1',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			componentId = 10
		}, {
			label = _U('decals_2'),
			name = 'decals_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			textureof = 'decals_1'
		}, {
			label = _U('arms'),
			name = 'arms',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15
		}, {
			label = _U('arms_2'),
			name = 'arms_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15
		}, {
			label = _U('pants_1'),
			name = 'pants_1',
			value = 0,
			min = 0,
			zoomOffset = 0.8,
			camOffset = -0.5,
			componentId = 4
		}, {
			label = _U('pants_2'),
			name = 'pants_2',
			value = 0,
			min = 0,
			zoomOffset = 0.8,
			camOffset = -0.5,
			textureof = 'pants_1'
		}, {
			label = _U('shoes_1'),
			name = 'shoes_1',
			value = 0,
			min = 0,
			zoomOffset = 0.8,
			camOffset = -0.8,
			componentId = 6
		}, {
			label = _U('shoes_2'),
			name = 'shoes_2',
			value = 0,
			min = 0,
			zoomOffset = 0.8,
			camOffset = -0.8,
			textureof = 'shoes_1'
		}, {
			label = _U('mask_1'),
			name = 'mask_1',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65,
			componentId = 1
		}, {
			label = _U('mask_2'),
			name = 'mask_2',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65,
			textureof = 'mask_1'
		}, {
			label = _U('bproof_1'),
			name = 'bproof_1',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			componentId = 9
		}, {
			label = _U('bproof_2'),
			name = 'bproof_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			textureof = 'bproof_1'
		}, {
			label = _U('chain_1'),
			name = 'chain_1',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65,
			componentId = 7
		}, {
			label = _U('chain_2'),
			name = 'chain_2',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65,
			textureof = 'chain_1'
		}, {
			label = _U('helmet_1'),
			name = 'helmet_1',
			value = -1,
			min = -1,
			zoomOffset = 0.6,
			camOffset = 0.65,
			componentId = 0
		}, {
			label = _U('helmet_2'),
			name = 'helmet_2',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65,
			textureof = 'helmet_1'
		}, {
			label = _U('glasses_1'),
			name = 'glasses_1',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65,
			componentId = 1
		}, {
			label = _U('glasses_2'),
			name = 'glasses_2',
			value = 0,
			min = 0,
			zoomOffset = 0.6,
			camOffset = 0.65,
			textureof = 'glasses_1'
		}, {
			label = _U('watches_1'),
			name = 'watches_1',
			value = -1,
			min = -1,
			zoomOffset = 0.75,
			camOffset = 0.15,
			componentId = 6
		}, {
			label = _U('watches_2'),
			name = 'watches_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			textureof = 'watches_1'
		}, {
			label = _U('bracelets_1'),
			name = 'bracelets_1',
			value = -1,
			min = -1,
			zoomOffset = 0.75,
			camOffset = 0.15,
			componentId = 7
		}, {
			label = _U('bracelets_2'),
			name = 'bracelets_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			textureof = 'bracelets_1'
		}, {
			label = _U('bag'),
			name = 'bags_1',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			componentId = 5
		}, {
			label = _U('bag_color'),
			name = 'bags_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15,
			textureof = 'bags_1'
		}, {
			label = _U('eye_color'),
			name = 'eye_color',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('eye_squint'),
			name = 'eye_squint',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('eyebrow_size'),
			name = 'eyebrows_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('eyebrow_type'),
			name = 'eyebrows_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('eyebrow_color_1'),
			name = 'eyebrows_3',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('eyebrow_color_2'),
			name = 'eyebrows_4',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('eyebrow_height'),
			name = 'eyebrows_5',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('eyebrow_depth'),
			name = 'eyebrows_6',
			value = 0,
			min = -10,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('makeup_type'),
			name = 'makeup_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('makeup_thickness'),
			name = 'makeup_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('makeup_color_1'),
			name = 'makeup_3',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('makeup_color_2'),
			name = 'makeup_4',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('lipstick_type'),
			name = 'lipstick_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('lipstick_thickness'),
			name = 'lipstick_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('lipstick_color_1'),
			name = 'lipstick_3',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('lipstick_color_2'),
			name = 'lipstick_4',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('ear_accessories'),
			name = 'ears_1',
			value = -1,
			min = -1,
			zoomOffset = 0.4,
			camOffset = 0.65,
			componentId = 2
		}, {
			label = _U('ear_accessories_color'),
			name = 'ears_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65,
			textureof = 'ears_1'
		}, {
			label = _U('chest_hair'),
			name = 'chest_1',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15
		}, {
			label = _U('chest_hair_1'),
			name = 'chest_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15
		}, {
			label = _U('chest_color'),
			name = 'chest_3',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15
		}, {
			label = _U('bodyb'),
			name = 'bodyb_1',
			value = -1,
			min = -1,
			zoomOffset = 0.75,
			camOffset = 0.15
		}, {
			label = _U('bodyb_size'),
			name = 'bodyb_2',
			value = 0,
			min = 0,
			zoomOffset = 0.75,
			camOffset = 0.15
		}, {
			label = _U('bodyb_extra'),
			name = 'bodyb_3',
			value = -1,
			min = -1,
			zoomOffset = 0.4,
			camOffset = 0.15
		}, {
			label = _U('bodyb_extra_thickness'),
			name = 'bodyb_4',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.15
		}, {
			label = _U('wrinkles'),
			name = 'age_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('wrinkle_thickness'),
			name = 'age_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('blemishes'),
			name = 'blemishes_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('blemishes_size'),
			name = 'blemishes_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('blush'),
			name = 'blush_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('blush_1'),
			name = 'blush_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('blush_color'),
			name = 'blush_3',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('complexion'),
			name = 'complexion_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('complexion_1'),
			name = 'complexion_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('sun'),
			name = 'sun_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('sun_1'),
			name = 'sun_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('freckles'),
			name = 'moles_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('freckles_1'),
			name = 'moles_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('beard_type'),
			name = 'beard_1',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('beard_size'),
			name = 'beard_2',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('beard_color_1'),
			name = 'beard_3',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		}, {
			label = _U('beard_color_2'),
			name = 'beard_4',
			value = 0,
			min = 0,
			zoomOffset = 0.4,
			camOffset = 0.65
		},
	},

	-- Clothes²

	Price = 250,

	Shops = {
		{pos = vector3(72.254, -1399.102, 28.876)},
		{pos = vector3(-703.776, -152.258, 36.915)},
		{pos = vector3(-167.863, -298.969, 39.233)},
		{pos = vector3(428.694, -800.106, 28.991)},
		{pos = vector3(-829.413, -1073.710, 10.828)},
		{pos = vector3(-1447.797, -242.461, 49.320)},
		{pos = vector3(11.632, 6514.224, 31.377)},
		{pos = vector3(123.646, -219.440, 54.057)},
		{pos = vector3(1696.291, 4829.312, 41.563)},
		{pos = vector3(618.093, 2759.629, 41.588)},
		{pos = vector3(1190.550, 2713.441, 37.722)},
		{pos = vector3(-1193.429, -772.262, 16.824)},
		{pos = vector3(-3172.496, 1048.133, 20.363)},
		{pos = vector3(-1108.441, 2708.923, 18.607)},
	},


    Identity = {
        spawnPos = vector3(-760.88, 325.48, 170.60-1),
        spawnHeading = 100.22,
        playerSpawn = vector3(1078.90, -689.74, 57.62),
        playerHeading = 198.00,
    },

	Bank = {
		{x = 149.92, y = -1040.83, z = 29.37}, 
		{x=-1212.980, y=-330.841, z=37.56},
		{x=-2962.582, y=482.627, z=15.703},
		{x=-112.202, y=6469.295, z=31.626},
		{x=314.187, y=-278.621, z=54.170},
		{x=-351.534, y=-49.529, z=49.042},
		{x=1175.0643310547, y=2706.6435546875, z=38.094036102295},
	},

	Bank2 = {
		{x = 237.3406, y = 217.8895, z = 106.2868},
	},

	ATMObjects = {
        "prop_fleeca_atm",
        "prop_atm_01",
        "prop_atm_03",
        "prop_atm_02",
    },

	Location = {
		allpos = {
			{pos = vector3(-101.0550, -611.7049, 36.2640), sortie = vector3(-1057.783, -2709.945, 13.63701)},
		},
	},

	GoFast = {
		Pos = vector3(1284.2, -2553.0, 42.7),
		Sell = vector3(114.87, 6611.87, 31.86),
		SpawnVehiculeJoueur = vector3(1261.7, -2563.9, 42.7),
		SpawnJoueur = vector3(1263.8, -2559.3, 42.7),
		Reward = 100000,
	},

	VehicleLock = {
		place = {
			Pos = {x = 170.28, y = -1799.53, z =  28.34},
			Size  = {x = 1.5, y = 1.5, z = 1.0},
			Color = {r = 255, g = 119, b = 0},
			Type  = 27
		},
	},

	Bitcoin = {
		Recolte = vector3(2435.3, 4966.9, 46.8),
		Vente = vector3(346.4, 3406.4, 35.5),
		ValueVente = 120,
	},

	-- Tabac = {
	-- 	Recolte = vector3(2854.18, 4597.4, 47.8),
	-- 	Traitement = vector3(2341.1, 3128.5, 48.5),
	-- 	Vente = vector3(1952.4, 3842.1, 31.17),
	-- 	ValueVente = 350,
	-- },

	ConfigShop = {
		Locations = {
			[1] = {
				["shelfs"] = {
					{["x"] = 26.35, ["y"] = -1347.42, ["z"] = 28.5, ["value"] = "checkout"},
					--{["x"] = 25.67, ["y"] = -1344.99, ["z"] = 28.5, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 24.44, ["y"] = -1347.34, ["z"] = 28.5, ["h"] = 270.82
				},
			},
	
			[2] = {
				["shelfs"] = {
					{["x"] = -48.37, ["y"] = -1757.93, ["z"] = 28.42, ["value"] = "checkout"},
				--	{["x"] = -47.25, ["y"] = -1756.58, ["z"] = 28.42, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -47.38, ["y"] = -1758.7, ["z"] = 28.44, ["h"] = 48.84
				},
			},
	
			[3] = {
				["shelfs"] = {
					{["x"] = -1222.26, ["y"] = -906.86, ["z"] = 11.33, ["value"] = "checkout"},
				--	{["x"] = -1224.09, ["y"] = -908.13, ["z"] = 11.33, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -1221.47, ["y"] = -907.99, ["z"] = 11.36, ["h"] = 28.09,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[4] = {
				["shelfs"] = {
					{["x"] = -1487.62, ["y"] = -378.60, ["z"] = 39.16, ["value"] = "checkout"},
				--	{["x"] = -1486.07, ["y"] = -380.21, ["z"] = 39.16, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -1486.75, ["y"] = -377.51, ["z"] = 39.18, ["h"] = 130.0,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[5] = {
				["shelfs"] = {
					{["x"] = -707.31, ["y"] = -914.66, ["z"] = 18.22, ["value"] = "checkout"},
				--	{["x"] = -707.36, ["y"] = -912.83, ["z"] = 18.22, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -706.13, ["y"] = -914.52, ["z"] = 18.24, ["h"] = 90.0
				},
			},
	
			[6] = {
				["shelfs"] = {
					{["x"] = 1135.7, ["y"] = -982.79, ["z"] = 45.42, ["value"] = "checkout"},
				--	{["x"] = 1135.3, ["y"] = -980.55, ["z"] = 45.42, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1134.27, ["y"] = -983.16, ["z"] = 45.44, ["h"] = 280.08,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[7] = {
				["shelfs"] = {
					{["x"] = 373.55, ["y"] = 325.52, ["z"] = 102.57, ["value"] = "checkout"},
				--	{["x"] = 374.17, ["y"] = 327.92, ["z"] = 102.57, ["value"] = "diverse"},
				}, 
				["cashier"] = {
					["x"] = 372.54, ["y"] = 326.38, ["z"] = 102.59, ["h"] = 257.27
				}
			},
	
			[8] = {
				["shelfs"] = {
					{["x"] = 1163.67, ["y"] = -323.92, ["z"] = 68.21, ["value"] = "checkout"},
				--	{["x"] = 1163.33, ["y"] = -322.25, ["z"] = 68.21, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1164.85, ["y"] = -323.67, ["z"] = 68.23, ["h"] = 98.12
				},
			},
	
			[9] = {
				["shelfs"] = {
					{["x"] = 2557.44, ["y"] = 382.03, ["z"] = 107.62, ["value"] = "checkout"},
				--	{["x"] = 2555.08, ["y"] = 382.18, ["z"] = 107.64, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 2557.27, ["y"] = 380.81, ["z"] = 107.64, ["h"] = 0.0
				},
			},
	
			[10] = {
				["shelfs"] = {
					{["x"] = -3039.16, ["y"] = 585.71, ["z"] = 6.91, ["value"] = "checkout"},
				--	{["x"] = -3041.03, ["y"] = 585.11, ["z"] = 6.91, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -3038.96, ["y"] = 584.53, ["z"] = 6.93, ["h"] = 0.0
				},
			},
	
			[11] = {
				["shelfs"] = {
					{["x"] = -3242.11, ["y"] = 1001.20, ["z"] = 11.83, ["value"] = "checkout"},
				--	{["x"] = -3243.89, ["y"] = 1001.32, ["z"] = 11.84, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -3242.24, ["y"] = 1000.0, ["z"] = 11.85, ["h"] = 353.5
				},
			},
	
			[12] = {
				["shelfs"] = {
					{["x"] = -2967.78, ["y"] = 391.49, ["z"] = 14.04, ["value"] = "checkout"},
				--	{["x"] = -2967.87, ["y"] = 389.3, ["z"] = 14.04, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -2966.38, ["y"] = 391.44, ["z"] = 14.06, ["h"] = 91.62,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[13] = {
				["shelfs"] = {
					{["x"] = -1820.38, ["y"] = 792.69, ["z"] = 137.11, ["value"] = "checkout"},
				--	{["x"] = -1821.55, ["y"] = 793.97, ["z"] = 137.12, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -1819.53, ["y"] = 793.55, ["z"] = 137.11, ["h"] = 129.05,
				},
			},
	
			[14] = {
				["shelfs"] = {
					{["x"] = 547.75, ["y"] = 2671.53, ["z"] = 41.16, ["value"] = "checkout"},
				--	{["x"] = 548.08, ["y"] = 2669.36, ["z"] = 41.16, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 549.04, ["y"] = 2671.36, ["z"] = 41.18, ["h"] = 98.25
				},
			},
	
			[15] = {
				["shelfs"] = {
					{["x"] = 1165.36, ["y"] = 2709.45, ["z"] = 39.16, ["value"] = "checkout"},
				--	{["x"] = 1167.64, ["y"] = 2709.41, ["z"] = 39.16, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1165.29, ["y"] = 2710.79, ["z"] = 37.18, ["h"] = 176.18,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[16] = {
				["shelfs"] = {
					{["x"] = 2678.82, ["y"] = 3280.36, ["z"] = 54.24, ["value"] = "checkout"},
				--	{["x"] = 2676.91, ["y"] = 3281.38, ["z"] = 54.24, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 2678.1, ["y"] = 3279.4, ["z"] = 54.26, ["h"] = 331.07
				},
			},
	
			[17] = {
				["shelfs"] = {
					{["x"] = 1961.17, ["y"] = 3740.5, ["z"] = 31.34, ["value"] = "checkout"},
				--	{["x"] = 1960.18, ["y"] = 3742.21, ["z"] = 31.36, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1960.13, ["y"] = 3739.94, ["z"] = 31.36, ["h"] = 297.89
				},
			},
	
			[18] = {
				["shelfs"] = {
					{["x"] = 1393.13, ["y"] = 3605.2, ["z"] = 33.98, ["value"] = "checkout"},
					--{["x"] = 1390.93, ["y"] = 3604.4, ["z"] = 34.0, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1392.74, ["y"] = 3606.35, ["z"] = 34.0, ["h"] = 202.73,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[19] = {
				["shelfs"] = {
					{["x"] = 1697.92, ["y"] = 4924.46, ["z"] = 41.06, ["value"] = "checkout"},
				--	{["x"] = 1699.44, ["y"] = 4923.41, ["z"] = 41.06, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1697.3, ["y"] = 4923.47, ["z"] = 41.08, ["h"] = 323.98
				},
			},
	
			[20] = {
				["shelfs"] = {
					{["x"] = 1728.78, ["y"] = 6414.41, ["z"] = 34.04, ["value"] = "checkout"},
				--	{["x"] = 1729.82, ["y"] = 6416.42, ["z"] = 34.04, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1727.87, ["y"] = 6415.25, ["z"] = 34.06, ["h"] = 242.93
				},
			},
	
		--	[21] = {
			--	["shelfs"] = {
		--			{["x"] = 190.3221, ["y"] = -889.4789, ["z"] = 29.71, ["value"] = "diverse"},
		-----			{["x"] = 189.3611, ["y"] = -891.1009, ["z"] = 29.71, ["value"] = "checkout"},
		---		},
		--		["cashier"] = {
		---			["x"] = 188.7763, ["y"] = -889.0504, ["z"] = 29.71307, ["h"] = 260.98
		---		},
		--	},
		},
	
		Locales = {
			["checkout"] = "Caisse",
			["diverse"] = "Magasin",
		},
	
		Items = {
			["diverse"] = {
				{label = "Bouteille d'eau", item = "water", price = 6},
				{label = "Pain", item = "bread", price = 6},
				{label = "Téléphone", item = "phone", price = 200},
			},
		},
	},

	Ammunation = {
		showBlip = true, -- Afficher les blips sur la carte // oui = true | non = false
        showMarker = true, -- Afficher les marker // oui = true | non = false
        Menu = {
            Title = "Armurerie",
            Subtitle = "Achetez vos armes",    
        },
        Marker = { -- https://docs.fivem.net/docs/game-references/markers/ & https://htmlcolorcodes.com/fr/
            Type = 2, 
            Size = {0.2, 0.2, 0.2},  -- x, y, z
            Color = {0,129,211}, -- r, g, b
            Rotation = 180.0,
        },
        Positions = {
            infoBlip = { -- https://docs.fivem.net/docs/game-references/blips/
                Name = "[Public] Armurerie",
                Sprite = 110,
				Display = 4,
				Scale = 0.6,
				Color = 1,
				Range = true,
            },
            interactionZone = { -- Position x,y,z pour les intéractions & blips
                {pos = vector3(-662.4192, -935.4647, 21.82921)},
                {pos = vector3(810.5966, -2157.017, 29.61898)},
                {pos = vector3(1693.578, 3759.426, 34.7053)},
                {pos = vector3(-330.4556, 6083.456, 31.45476)},
                {pos = vector3(251.9472, -49.86555, 69.94102)},
                {pos = vector3(21.82369, -1107.19, 29.797)},
				{pos = vector3(2568.004, 294.5252, 108.7348)},
				{pos = vector3(-1117.884, 2698.496, 18.55412)},
				{pos = vector3(842.4682, -1033.3, 28.19486)},
				{pos = vector3(-1305.939, -394.0775, 36.69574)},
            },
        },
		PPA = { price = 150000 },
        Items = {
            whiteWeapon = {
                { label = "Couteau", description = "Ce couteau à lame de 17 cm en acier au carbone est doté d'un double tranchant et d'une partie dentelée pour mieux s'enfoncer et découper.", item = "weapon_knife", type = "weapon_hand", price = "5000" },
				{ label = "Batte de baseball", description = "Batte de baseball en aluminium avec une poignée en cuir. Légère et résistante, parfaite pour les battants.", item = "weapon_bat", type = "weapon_hand", price = "7500" },
				{ label = "Machette", description = "Une machette est un long couteau à manche court muni d'une lame épaisse.", item = "weapon_machete", type = "weapon_hand", price = "10000" },
            },
            letalWeapon = {
                { label = "Pétoire", description = "Le flingue idéal pour sortir à Vinewood. Moins précis qu'un bouchon de bouteille, mais deux fois plus dangereux et puissant.", item = "weapon_snspistol", type = "weapon", price = "130000" },
				{ label = "Pistolet", description = "Arme à feu portative, à canon court, qui se tient d'une seule main. Légère et maniable, une arme pouvant causé de très gros dégâts.", item = "weapon_pistol", type = "weapon", price = "180000" },
            },
            accessories = {
                --{ label = "Chargeur", description = "Performant, discret contenant des balles de qualitées partant à plus de 1000km/h lors d'un tir.", item = "clip", type = "item", price = "5000" },
				--{ label = "Kevlar Lourd", description = "Lourd mais résistant, l'équipement idéal pour se protéger face au grosse armes létales.", item = "kevlar", type = "item", price = "50000" },
				--{ label = "Kevlar Medium", description = "Léger et résistance moyenne, l'équipement idéal pour se protéger face au moyenne armes létales.", item = "kevlarmid", type = "item", price = "30000" },
				--{ label = "Kevlar Léger", description = "Super Léger mais moins résistant, l'équipement idéal pour se protéger face au petite armes létales.", item = "kevlarlow", type = "item", price = "20000" },
            },
        },
	},

	Jobs = {
		police = {
			Bureau = {
				{Bureau = vector3(-384.6011,-360.853,48.53271)}
			},
			Plainte = {
				{Plainte = vector3(-376.1311, -353.3322, 31.65467)}
			},
			RangerVehicule = {
				{pos = vector3(-381.0073, -361.6754, 24.75667)}
			},
			Peds = {
				{ped = {"s_m_y_cop_01", vector3(-379.017, -352.425, 30.654), 254.70}},
			},
			wlcustom = {
				[GetHashKey("police6f")] = true,
				[GetHashKey("police6h")] = true,
				[GetHashKey("lspdtorrence")] = true,
				[GetHashKey("policeb")] = true,
				[GetHashKey("police2b")] = true,
				[GetHashKey("lspdumkwash")] = true,
				[GetHashKey("lspdverus")] = true,
				[GetHashKey("pinnaclep")] = true,
				[GetHashKey("lspdraiden")] = true,
				[GetHashKey("lspdbus")] = true,
				[GetHashKey("lspdcara")] = true,
				[GetHashKey("lspdumktorrence")] = true,
				[GetHashKey("riot")] = true,
				[GetHashKey("lspdumkscoutgnd")] = true,
				[GetHashKey("poltaxi")] = true
			},
			Amende = {
				["amende"] = {
					{label = 'Usage abusif du klaxon', price = 1500},
					{label = 'Franchir une ligne continue', price = 1500},
					{label = 'Circulation à contresens', price = 1500},
					{label = 'Demi-tour non autorisé', price = 1500},
					{label = 'Circulation hors-route', price = 1500},
					{label = 'Non-respect des distances de sécurité', price = 1500},
					{label = 'Arrêt dangereux / interdit', price = 1500},
					{label = 'Stationnement gênant / interdit', price = 1500},
					{label = 'Non respect  de la priorité à droite', price = 1500},
					{label = 'Non-respect à un véhicule prioritaire', price = 1500},
					{label = 'Non-respect d\'un stop', price = 1500},
					{label = 'Non-respect d\'un feu rouge', price = 1500},
					{label = 'Dépassement dangereux', price = 1500},
					{label = 'Véhicule non en état', price = 1500},
					{label = 'Conduite sans permis', price = 1500},
					{label = 'Délit de fuite', price = 1500},
					{label = 'Excès de vitesse < 5 kmh', price = 1500},
					{label = 'Excès de vitesse 5-15 kmh', price = 1500},
					{label = 'Excès de vitesse 15-30 kmh', price = 1500},
					{label = 'Excès de vitesse > 30 kmh', price = 1500},
					{label = 'Entrave de la circulation', price = 1500},
					{label = 'Dégradation de la voie publique', price = 1500},
					{label = 'Trouble à l\'ordre publique', price = 1500},
					{label = 'Entrave opération de police', price = 1500},
					-- {label = 'Insulte envers / entre civils', price = 1500},
					-- {label = 'Outrage à agent de police', price = 1500},
					{label = 'Menace verbale ou intimidation envers civil', price = 1500},
					{label = 'Menace verbale ou intimidation envers policier', price = 1500},
					{label = 'Manifestation illégale', price = 1500},
					{label = 'Tentative de corruption', price = 1500},
					{label = 'Arme blanche sortie en ville', price = 1500},
					{label = 'Arme léthale sortie en ville', price = 1500},
					{label = 'Port d\'arme non autorisé (défaut de license)', price = 1500},
					{label = 'Port d\'arme illégal', price = 1500},
					{label = 'Pris en flag lockpick', price = 1500},
					{label = 'Vol de voiture', price = 1500},
					{label = 'Vente de drogue', price = 1500},
					{label = 'Fabriquation de drogue', price = 1500},
					{label = 'Possession de drogue', price = 1500},
					{label = 'Prise d\'ôtage civil', price = 1500},
					{label = 'Prise d\'ôtage agent de l\'état', price = 1500},
					{label = 'Braquage particulier', price = 1500},
					{label = 'Braquage magasin', price = 1500},
					{label = 'Braquage de banque', price = 1500},
					{label = 'Tir sur civil', price = 1500},
					{label = 'Tir sur agent de l\'état', price = 1500},
					{label = 'Tentative de meurtre sur civil', price = 1500},
					{label = 'Tentative de meurtre sur agent de l\'état', price = 1500},
					{label = 'Meurtre sur civil', price = 1500},
					{label = 'Meurte sur agent de l\'état', price = 1500}, 
					{label = 'Escroquerie à l\'entreprise', price = 1500},
				}
			},
			Zones = {
				{
					Armurerie = vector3(-403.0094, -377.1043, 25.09871),
					Vestiaire = vector3(-397.3265, -369.1445, 25.09872),
					PosGarage = vector3(-386.5316, -358.4, 24.75665),
				},
			},
			Uniforms = {
				recruit_wear = {
					male = {
						['tshirt_1'] = 260, ['tshirt_2'] = 0,
						['torso_1'] = 787, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 6,
						['pants_1'] = 35, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
                        ['bproof_1'] = -1,  ['bproof_2'] = 0,
						['bags_1'] = 182, ['bags_2'] = 0,
						['chain_1'] = 318, ['chain_2'] = 1,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 356, ['tshirt_2'] = 0,
						['torso_1'] = 868, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 34, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 84,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 136, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				officer_wear = {
					male = {
						['tshirt_1'] = 274, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 35, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = -1,  ['bproof_2'] = 0,
						['bags_1'] = 182, ['bags_2'] = 0,
						['chain_1'] = 323, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 0,
						['torso_1'] = 868, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 325, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 136, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				sergeant_wear = {
					male = {
						['tshirt_1'] = 260, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 0,
						['decals_1'] = 151, ['decals_2'] = 2,
						['arms'] = 12,
						['pants_1'] = 35, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = -1,  ['bproof_2'] = 0,
						['bags_1'] = 182, ['bags_2'] = 0,
						['chain_1'] = 323, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 0,
						['torso_1'] = 868, ['torso_2'] = 0,
						['decals_1'] = 150, ['decals_2'] = 2,
						['arms'] = 11,
						['pants_1'] = 325, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 136, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				lieutenant_wear = {
					male = {
						['tshirt_1'] = 260, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 0,
						['decals_1'] = 173, ['decals_2'] = 0,
						['arms'] = 12,
						['pants_1'] = 35, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
						['bags_1'] = 182, ['bags_2'] = 0,
						['chain_1'] = 323, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 0,
						['torso_1'] = 837, ['torso_2'] = 0,
						['decals_1'] = 162, ['decals_2'] = 0,
						['arms'] = 14,
						['pants_1'] = 34, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = -1,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 136, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				capitaine_wear = {
					male = {
						['tshirt_1'] = 274, ['tshirt_2'] = 0,
						['torso_1'] = 756, ['torso_2'] = 0,
						['decals_1'] = 150, ['decals_2'] = 1,
						['arms'] = 12,
						['pants_1'] = 35, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = 323, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
						['bags_1'] = 182, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 837, ['torso_2'] = 0,
						['decals_1'] = 162, ['decals_2'] = 1,
						['arms'] = 14,
						['pants_1'] = 34, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = -1,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 136, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				commander_wear = {
					male = {
						['tshirt_1'] = 260, ['tshirt_2'] = 0,
						['torso_1'] = 787, ['torso_2'] = 0,
						['decals_1'] = 150, ['decals_2'] = 2,
						['arms'] = 12,
						['pants_1'] = 35, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
						['bags_1'] = 182, ['bags_2'] = 0,
						['chain_1'] = 323, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 837, ['torso_2'] = 0,
						['decals_1'] = 162, ['decals_2'] = 2,
						['arms'] = 14,
						['pants_1'] = 34, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = -1,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 136, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				deputy_wear = {
					male = {
						['tshirt_1'] = 260, ['tshirt_2'] = 0,
						['torso_1'] = 787, ['torso_2'] = 0,
						['decals_1'] = 150, ['decals_2'] = 3,
						['arms'] = 12,
						['pants_1'] = 35, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
						['bags_1'] = 182, ['bags_2'] = 0,
						['chain_1'] = 323, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 837, ['torso_2'] = 0,
						['decals_1'] = 162, ['decals_2'] = 3,
						['arms'] = 14,
						['pants_1'] = 34, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = -1,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 136, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				assistantboss_wear = {
					male = {
						['tshirt_1'] = 260, ['tshirt_2'] = 0,
						['torso_1'] = 787, ['torso_2'] = 0,
						['decals_1'] = 150, ['decals_2'] = 4,
						['arms'] = 12,
						['pants_1'] = 35, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
						['bags_1'] = 182, ['bags_2'] = 0,
						['chain_1'] = 323, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 837, ['torso_2'] = 0,
						['decals_1'] = 162, ['decals_2'] = 4,
						['arms'] = 14,
						['pants_1'] = 34, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = -1,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 136, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				boss_wear = {
					male = {
						['tshirt_1'] = 260, ['tshirt_2'] = 0,
						['torso_1'] = 787, ['torso_2'] = 0,
						['decals_1'] = 150, ['decals_2'] = 5,
						['arms'] = 12,
						['pants_1'] = 35, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
						['bags_1'] = 182, ['bags_2'] = 0,
						['chain_1'] = 323, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 837, ['torso_2'] = 0,
						['decals_1'] = 162, ['decals_2'] = 5,
						['arms'] = 14,
						['pants_1'] = 34, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = -1,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 136, ['bags_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},	
				},
				bullet_wear = {
					male = {
						['bproof_1'] = 112,  ['bproof_2'] = 0,
					},
					female = {
						['bproof_1'] = 87,  ['bproof_2'] = 0
					}
				},
				gilet_wear = {
					male = {
						['bproof_1'] = 85,  ['bproof_2'] = 0,
					},
					female = {
						['bproof_1'] = 84,  ['bproof_2'] = 0
					}
				},
			},
		},
		Bsco = {
			Plainte = {
				{Plainte = vector3(-446.15905761719, 6012.4306640625, 32.288719177246)}
			},
			RangerVehicule = {
				{pos = vector3(-481.89151000977, 6024.1381835938, 31.340402603149)}
			},
			Peds = {
				{ped = {"s_m_y_sheriff_01", vector3(-446.06188964844, 6014.7817382813, 35.995685577393), 225.19195556640625}},
			},
			Amende = {
				["amende"] = {
					{label = 'Usage abusif du klaxon', price = 1500},
					{label = 'Franchir une ligne continue', price = 1500},
					{label = 'Circulation à contresens', price = 1500},
					{label = 'Demi-tour non autorisé', price = 1500},
					{label = 'Circulation hors-route', price = 1500},
					{label = 'Non-respect des distances de sécurité', price = 1500},
					{label = 'Arrêt dangereux / interdit', price = 1500},
					{label = 'Stationnement gênant / interdit', price = 1500},
					{label = 'Non respect  de la priorité à droite', price = 1500},
					{label = 'Non-respect à un véhicule prioritaire', price = 1500},
					{label = 'Non-respect d\'un stop', price = 1500},
					{label = 'Non-respect d\'un feu rouge', price = 1500},
					{label = 'Dépassement dangereux', price = 1500},
					{label = 'Véhicule non en état', price = 1500},
					{label = 'Conduite sans permis', price = 1500},
					{label = 'Délit de fuite', price = 1500},
					{label = 'Excès de vitesse < 5 kmh', price = 1500},
					{label = 'Excès de vitesse 5-15 kmh', price = 1500},
					{label = 'Excès de vitesse 15-30 kmh', price = 1500},
					{label = 'Excès de vitesse > 30 kmh', price = 1500},
					{label = 'Entrave de la circulation', price = 1500},
					{label = 'Dégradation de la voie publique', price = 1500},
					{label = 'Trouble à l\'ordre publique', price = 1500},
					{label = 'Entrave opération de police', price = 1500},
					-- {label = 'Insulte envers / entre civils', price = 1500},
					-- {label = 'Outrage à agent de police', price = 1500},
					{label = 'Menace verbale ou intimidation envers civil', price = 1500},
					{label = 'Menace verbale ou intimidation envers policier', price = 1500},
					{label = 'Manifestation illégale', price = 1500},
					{label = 'Tentative de corruption', price = 1500},
					{label = 'Arme blanche sortie en ville', price = 1500},
					{label = 'Arme léthale sortie en ville', price = 1500},
					{label = 'Port d\'arme non autorisé (défaut de license)', price = 1500},
					{label = 'Port d\'arme illégal', price = 1500},
					{label = 'Pris en flag lockpick', price = 1500},
					{label = 'Vol de voiture', price = 1500},
					{label = 'Vente de drogue', price = 1500},
					{label = 'Fabriquation de drogue', price = 1500},
					{label = 'Possession de drogue', price = 1500},
					{label = 'Prise d\'ôtage civil', price = 1500},
					{label = 'Prise d\'ôtage agent de l\'état', price = 1500},
					{label = 'Braquage particulier', price = 1500},
					{label = 'Braquage magasin', price = 1500},
					{label = 'Braquage de banque', price = 1500},
					{label = 'Tir sur civil', price = 1500},
					{label = 'Tir sur agent de l\'état', price = 1500},
					{label = 'Tentative de meurtre sur civil', price = 1500},
					{label = 'Tentative de meurtre sur agent de l\'état', price = 1500},
					{label = 'Meurtre sur civil', price = 1500},
					{label = 'Meurte sur agent de l\'état', price = 1500}, 
					{label = 'Escroquerie à l\'entreprise', price = 1500},
				}
			},
			Zones2 = {
				{
					Armurerie2 = vector3(-443.83767700195, 6013.1245117188, 37.008338928223),
					Vestiaire2 = vector3(-437.417,6009.694,36.995),
					PosGarage2 = vector3(-453.23913574219, 5990.7641601563, 31.489166259766),
				},
			},
			Uniforms = {
				recruit_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 726, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 0,
						['pants_1'] = 309, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 797, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 14,
						['pants_1'] = 337, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				officer_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 147, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 146, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				sergeant_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 180, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 191, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				sergeantchief_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 151, ['decals_2'] = 3,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 150, ['decals_2'] = 3,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				intendent_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 161, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 173, ['decals_2'] = 3,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				lieutenant_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 176, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 172, ['bags_2'] = 0,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 187, ['decals_2'] = 3,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 0,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				chef_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 806, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 230,
						['pants_1'] = 24, ['pants_2'] = 0,
						['shoes_1'] = 10, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 137, ['bags_2'] = 5,
						['chain_1'] = 351, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 0,
						['torso_1'] = 855, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 49,
						['pants_1'] = 6, ['pants_2'] = 0,
						['shoes_1'] = 27, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 119, ['bags_2'] = 5,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				boss_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 806, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 230,
						['pants_1'] = 24, ['pants_2'] = 0,
						['shoes_1'] = 10, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 137, ['bags_2'] = 5,
						['chain_1'] = 351, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 0,
						['torso_1'] = 855, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 49,
						['pants_1'] = 6, ['pants_2'] = 0,
						['shoes_1'] = 27, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 119, ['bags_2'] = 5,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},	
				},
				bullet_wear = {
					male = {
						['bproof_1'] = 119,  ['bproof_2'] = 0,
					},
					female = {
						['bproof_1'] = 91,  ['bproof_2'] = 2
					}
				},
				gilet_wear = {
					male = {
						['bproof_1'] = 115,  ['bproof_2'] = 0,
					},
					female = {
						['bproof_1'] = 84,  ['bproof_2'] = 3
					}
				},
			},
		},


		Taxi = {
			Clothes = {
				{clothes = vector3(-1606.85, -839.30, 10.27)},
			},
			Uniforms = {
				male = {
					['bags_1'] = 0, ['bags_2'] = 0,
					['tshirt_1'] = 4, ['tshirt_2'] = 0,
					['torso_1'] = 106, ['torso_2'] = 5,
					['arms'] = 4,
					['pants_1'] = 43, ['pants_2'] = 5,
					['shoes_1'] = 33, ['shoes_2'] = 3,
					['mask_1'] = 0, ['mask_2'] = 0,
					['bproof_1'] = 0,
					['helmet_1'] = -1, ['helmet_2'] = 0,
					["decals_1"] = -1, ["decals_2"] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
				},
				female = {
					['bags_1'] = 0, ['bags_2'] = 0,
					['tshirt_1'] = 15, ['tshirt_2'] = 0,
					['torso_1'] = 97, ['torso_2'] = 1,
					['arms'] = 0,
					['pants_1'] = 7, ['pants_2'] = 0,
					['shoes_1'] = 8, ['shoes_2'] = 0,
					['mask_1'] = 0, ['mask_2'] = 0,
					['bproof_1'] = 0,
					['helmet_1'] = -1, ['helmet_2'] = 0,
					["decals_1"] = -1, ["decals_2"] = 0,
					['chain_1'] = -1, ['chain_2'] = 0,
				}
			},
		},

		RoxWoodSherif = {
			Plainte = {
				{Plainte = vector3(-1029.518, 6659.389, 3.185932)}
			},
			RangerVehicule = {
				{pos = vector3(-1049.295, 6680.597, 3.15753)}
			},
			Amende = {
				["amende"] = {
					{label = 'Usage abusif du klaxon', price = 1500},
					{label = 'Franchir une ligne continue', price = 1500},
					{label = 'Circulation à contresens', price = 1500},
					{label = 'Demi-tour non autorisé', price = 1500},
					{label = 'Circulation hors-route', price = 1500},
					{label = 'Non-respect des distances de sécurité', price = 1500},
					{label = 'Arrêt dangereux / interdit', price = 1500},
					{label = 'Stationnement gênant / interdit', price = 1500},
					{label = 'Non respect  de la priorité à droite', price = 1500},
					{label = 'Non-respect à un véhicule prioritaire', price = 1500},
					{label = 'Non-respect d\'un stop', price = 1500},
					{label = 'Non-respect d\'un feu rouge', price = 1500},
					{label = 'Dépassement dangereux', price = 1500},
					{label = 'Véhicule non en état', price = 1500},
					{label = 'Conduite sans permis', price = 1500},
					{label = 'Délit de fuite', price = 1500},
					{label = 'Excès de vitesse < 5 kmh', price = 1500},
					{label = 'Excès de vitesse 5-15 kmh', price = 1500},
					{label = 'Excès de vitesse 15-30 kmh', price = 1500},
					{label = 'Excès de vitesse > 30 kmh', price = 1500},
					{label = 'Entrave de la circulation', price = 1500},
					{label = 'Dégradation de la voie publique', price = 1500},
					{label = 'Trouble à l\'ordre publique', price = 1500},
					{label = 'Entrave opération de police', price = 1500},
					{label = 'Insulte envers / entre civils', price = 1500},
					{label = 'Outrage à agent de police', price = 1500},
					{label = 'Menace verbale ou intimidation envers civil', price = 1500},
					{label = 'Menace verbale ou intimidation envers policier', price = 1500},
					{label = 'Manifestation illégale', price = 1500},
					{label = 'Tentative de corruption', price = 1500},
					{label = 'Arme blanche sortie en ville', price = 1500},
					{label = 'Arme léthale sortie en ville', price = 1500},
					{label = 'Port d\'arme non autorisé (défaut de license)', price = 1500},
					{label = 'Port d\'arme illégal', price = 1500},
					{label = 'Pris en flag lockpick', price = 1500},
					{label = 'Vol de voiture', price = 1500},
					{label = 'Vente de drogue', price = 1500},
					{label = 'Fabriquation de drogue', price = 1500},
					{label = 'Possession de drogue', price = 1500},
					{label = 'Prise d\'ôtage civil', price = 1500},
					{label = 'Prise d\'ôtage agent de l\'état', price = 1500},
					{label = 'Braquage particulier', price = 1500},
					{label = 'Braquage magasin', price = 1500},
					{label = 'Braquage de banque', price = 1500},
					{label = 'Tir sur civil', price = 1500},
					{label = 'Tir sur agent de l\'état', price = 1500},
					{label = 'Tentative de meurtre sur civil', price = 1500},
					{label = 'Tentative de meurtre sur agent de l\'état', price = 1500},
					{label = 'Meurtre sur civil', price = 1500},
					{label = 'Meurte sur agent de l\'état', price = 1500}, 
					{label = 'Escroquerie à l\'entreprise', price = 1500},
				}
			},
			Zones = {
				{
					Armurerie = vector3(-1032.377, 6657.553, 3.185935),
					Vestiaire = vector3(-1034.68, 6661.746, 5.67989),
					PosGarage = vector3(-1040.789, 6677.034, 3.160908),
				},
			},
			Uniforms = {
				recruit_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 726, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 0,
						['pants_1'] = 309, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 797, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 14,
						['pants_1'] = 337, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				officer_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 147, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 146, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				sergeant_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 180, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 191, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				sergeantchief_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 151, ['decals_2'] = 3,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 150, ['decals_2'] = 3,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				intendent_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 161, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 184, ['bags_2'] = 6,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 173, ['decals_2'] = 3,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 6,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				lieutenant_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 782, ['torso_2'] = 3,
						['decals_1'] = 176, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 292, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 323, ['mask_2'] = 0,
						['bags_1'] = 172, ['bags_2'] = 0,
						['chain_1'] = 351, ['chain_2'] = 0,
                        ['bproof_1'] = 93,  ['bproof_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 1,
						['torso_1'] = 868, ['torso_2'] = 3,
						['decals_1'] = 187, ['decals_2'] = 3,
						['arms'] = 11,
						['pants_1'] = 316, ['pants_2'] = 0,
						['shoes_1'] = 25, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
                        ['bproof_1'] = 96,  ['bproof_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 157, ['bags_2'] = 0,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				chef_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 806, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 230,
						['pants_1'] = 24, ['pants_2'] = 0,
						['shoes_1'] = 10, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 137, ['bags_2'] = 5,
						['chain_1'] = 351, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 0,
						['torso_1'] = 855, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 49,
						['pants_1'] = 6, ['pants_2'] = 0,
						['shoes_1'] = 27, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 119, ['bags_2'] = 5,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				boss_wear = {
					male = {
						['tshirt_1'] = 255, ['tshirt_2'] = 0,
						['torso_1'] = 806, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 230,
						['pants_1'] = 24, ['pants_2'] = 0,
						['shoes_1'] = 10, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 137, ['bags_2'] = 5,
						['chain_1'] = 351, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 351, ['tshirt_2'] = 0,
						['torso_1'] = 855, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 49,
						['pants_1'] = 6, ['pants_2'] = 0,
						['shoes_1'] = 27, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['bags_1'] = 119, ['bags_2'] = 5,
						['chain_1'] = 216, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},	
				},
				bullet_wear = {
					male = {
						['bproof_1'] = 119,  ['bproof_2'] = 0,
					},
					female = {
						['bproof_1'] = 91,  ['bproof_2'] = 2
					}
				},
				gilet_wear = {
					male = {
						['bproof_1'] = 115,  ['bproof_2'] = 0,
					},
					female = {
						['bproof_1'] = 84,  ['bproof_2'] = 3
					}
				},
			},
		},
		Ambulance = {
			Gestion = {
				{gestion = vector3(-784.8987, -1244.977, 7.33743)},
			},
			Pharma = {
				{pharma = vector3(320.8593, -581.8071, 43.27029)},
			},
			Clothes = {
				{clothes = vector3(309.5089, -587.8444, 38.33098)},
			},
			Vehicle = {
				{vehicle = vector3(295.4362, -600.5153, 43.30345)},
			},
			DeleteVeh = {
				{deleteveh = vector3(296.0662, -607.3741, 43.33054)},
			},
			Uniforms = {
                male = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 256, ['tshirt_2'] = 0,
                    ['torso_1'] = 769, ['torso_2'] = 18,
                    ['arms'] = 92,
                    ['pants_1'] = 301, ['pants_2'] = 0,
                    ['shoes_1'] = 25, ['shoes_2'] = 0,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
					['bags_1'] = 159, ['bags_2'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ["decals_1"] = 0, ["decals_2"] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                },
                female = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 345, ['tshirt_2'] = 0,
                    ['torso_1'] = 851, ['torso_2'] = 18,
                    ['arms'] = 168,
                    ['pants_1'] = 329, ['pants_2'] = 0,
                    ['shoes_1'] = 27, ['shoes_2'] = 0,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
					['bags_1'] = 127, ['bags_2'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ["decals_1"] = 0, ["decals_2"] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                }
            },
		},
		Unicorn = {
			Frigo = {
					{coords = vector3(111.14, -1283.31, 29.61)},
					},
			Garage = {
					 {coords = vector3(-1396.422, -591.1769, 30.30967)},
					 },
			SpawnVehicule = {
				{coords = {vector3(-555.23553466797, 303.07382202148, 83.240509033203), 269.49627685546875}},
			},
			-- RangerVehicule = {
			-- 	{coords = vector3(-1414.619, -592.8475, 30.4287)},
			-- },
		},

		YellowJack = {
			Frigo = {
					{coords = vector3(1898.41, -3046.60, 47.20)},
					},
			Garage = {
					 {coords = vector3(1999.35, 3042.66, 47.33)},
					 },
			SpawnVehicule = {
				{coords = {vector3(1989.34, 3032.12, 47.05), 58.99}},
			},
			-- RangerVehicule = {
			-- 	{coords = vector3(-1414.619, -592.8475, 30.4287)},
			-- },
		},

		Mecano = {
			Clothes = {
				{clothes = vector3(-209.6078, -1338.3535, 30.8904)},
			},
			Uniforms = {
                male = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 271, ['tshirt_2'] = 0,
                    ['torso_1'] = 139, ['torso_2'] = 0,
                    ['arms'] = 4,
                    ['pants_1'] = 9, ['pants_2'] = 7,
                    ['shoes_1'] = 24, ['shoes_2'] = 0,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ["decals_1"] = -1, ["decals_2"] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                },
                female = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 392, ['tshirt_2'] = 0,
                    ['torso_1'] = 136, ['torso_2'] = 0,
                    ['arms'] = 3,
                    ['pants_1'] = 45, ['pants_2'] = 1,
                    ['shoes_1'] = 24, ['shoes_2'] = 0,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ["decals_1"] = -1, ["decals_2"] = 0,
                    ['chain_1'] = -1, ['chain_2'] = 0,
                }
            },
		},
		cardealer2 = {
			Actions = {
				{actions = vector3(92.59966, 6534.688, 31.65903)},
			},
		},
		Cardealer = {
			Actions = {
				{actions = vector3(-782.5371, -211.8741, 36.9975)}, 
			},
		},
		Boat = {
			Actions = {
				{actions = vector3(-734.22015380859, -1343.8698730469, 1.57192456722265)},
			},
		},
		Plane = {
			Actions = {
				{actions = vector3(-963.991, -2966.675, 12.42519)},
			},
		},
		Unicorn = {
			Blip = {
				{coords = vector3(129.6, -1300.6, 29.2)},
			},
		},

		Avocat = {

			-- Accueil = {
			-- 	{actions = vector3(-768.7946, -612.1107, 30.26001)},
			-- },
			
		},

		Brinks = {
			Armurerie = { 
				{pos = vector3(11.10654, -661.1917, 33.44897)} 
			},
			Items = {
				{label = "Tazer", weapon = "WEAPON_STUNGUN", price = 0},
				{label = "Pistolet de combat", weapon = "WEAPON_COMBATPISTOL", price = 0},
				{label = "Fusil avancé", weapon = "WEAPON_ADVANCEDRIFLE", price = 0},
			},
			ListeVehicle = {
				{label = "Stockade", model = "stockade", grade = 0},
			},
			SortirVehicle = { 
				{pos = vector3(-11.50391, -698.5498, 32.49406)} 
			},
			PosSortirVehicule = vector3(-5.054764, -670.801, 31.94371),
			HeadingSortirVehicule = 183.98121643066,
			DeleteVehicle = {
				{pos = vector3(-5.064245, -670.3618, 32.33811)}
			},
		},

		studio = {

			RangerVehicule = {
				{pos = vector3(-785.8735, -592.3677, 30.12603)}
			},

			Zones = {
				{
					PosGarage = vector3(-771.8354, -599.1964, 30.276),
				},
			},
			
		},
	},

	Garage = {
		showBlip = true,
		Positions = {
            infoBlip = { 
                Name = "[Garage] Garage Public",
                Sprite = 831,
				Display = 4,
				Scale = 0.4,
				Color = 3,
				Range = true,
            },
            spawnZone = { 
                {spawn = vector3(233.77, -788.29, 30.81), pos = vector3(215.44, -810.39, 30.72), heading = 156.51}, -- central
                {spawn = vector3(1738.6, 3720.83, 34.02), pos = vector3(1737.43, 3710.22, 34.13), heading = 26.86}, -- sandy shores
				{spawn = vector3(124.63, 6603.73, 31.7), pos = vector3(106.85, 6612.20, 31.97), heading = 221.15}, -- Paleto
				{spawn = vector3(1869.28, 2577.80, 45.67), pos = vector3(1849.59, 2587.26, 45.67), heading = 267.83}, -- Prison 
				{spawn = vector3(1202.95, 334.7, 81.99), pos = vector3(1213.29, 341.14, 81.99), heading = 143.32}, -- Casino
				{spawn = vector3(-509.11, -602.58, 30.3), pos = vector3(-505.01, -612.00, 30.29), heading = 266.56}, -- Centre ville
				{spawn = vector3(1019.73, -766.36, 57.92), pos = vector3(1034.58, -762.12, 58.08), heading = 317.63}, -- Spawn
				{spawn = vector3(-1256.01, -385.77, 37.28), pos = vector3(-1255.85, -382.50, 37.28), heading = 295.75}, -- Bloods
				{spawn = vector3(-1134.93, 2672.06, 18.09), pos = vector3(-1145.17, 2668.37, 18.09), heading = 134.60}, -- Military
				{spawn = vector3(-947.39, -2439.93, 13.83), pos = vector3(-944.31, -2460.18, 13.98), heading = 214.11}, -- Airport
				{spawn = vector3(-1670.13, 65.48, 63.54), pos = vector3(-1677.86, 65.64, 63.93), heading = 290.65}, -- Garage Tenis
				{spawn = vector3(4474.42, -4460.30, 4.25), pos = vector3(4462.83, -4469.04, 4.24), heading = 197.38}, -- Garage Cayo
				{spawn = vector3(-573.9974, -168.2229, 37.35837), pos = vector3(-582.6383, -172.3038, 37.81154), heading = 292.87}, -- Gouv
            },
			deleteZone = {
                {pos = vector3(224.50, -757.70, 30.82)}, -- central
                {pos = vector3(1724.98, 3715.85, 34.18)}, -- sandy shores
				{pos = vector3(143.83, 6626.51, 31.7)}, -- Paleto
				{pos = vector3(1216.155, 356.29, 81.99)}, -- Casino
				{pos = vector3(-510.68, -623.23, 30.3)}, -- Centre ville
				{pos = vector3(1039.05, -785.38, 58.01)}, -- Spawn
				{pos = vector3(-1245.61, -394.23, 37.28)}, -- Bloods
				{pos = vector3(-1154.53, 2662.51, 18.09)}, -- Military
				{pos = vector3(-939.37, -2434.63, 13.83)}, -- Airport
				{pos = vector3(-1663.43, 77.48, 63.45)}, -- Garage Tenis
				{pos = vector3(4482.59, -4451.49, 4.09)}, -- Garage Cayo
				{pos = vector3(-549.5462, -157.9245, 37.66764)}, -- Gouv
			},
        },
	},

	Fourriere = {
		showBlip = true,
		Positions = {
            infoBlip = { 
                Name = "[Fourriere] Fourriere Public",
                Sprite = 67,
				Display = 4,
				Scale = 0.6,
				Color = 64,
				Range = true,
            },
            interactionZone = { 
                {spawn = vector3(405.80, -1643.37, 29.29), pos = vector3(409.48, -1623.18, 29.29), heading = 222.32}, -- Los Santos
                {spawn = vector3(1642.38, 3796.84, 34.65), pos = vector3(1651.06, 3802.37, 38.65), heading = 219.77}, -- Sandy Shores
                {spawn = vector3(-239.82, 6194.65, 31.49), pos = vector3(-234.56, 6199.09, 31.93), heading = 129.75}, -- Paleto
				{spawn = vector3(4519.48, -4466.253, 4.18), pos = vector3(4443.31, -4470.25, 4.32), heading = 109.73}, -- Cayo
            },
        },
	},
	Parachute = {
		DrawDistance = 100,
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 0, g = 128, b = 255},
		Type = 40,
	}
}

Config['URL'] = 'https://www.youtube.com/embed/%s?autoplay=1&controls=1&disablekb=1&fs=0&rel=0&showinfo=0&iv_load_policy=3&start=%s'
Config['API'] = {
    ['URL'] = 'https://www.googleapis.com/youtube/v3/videos?id=%s&part=contentDetails&key=%s',
    ['Key'] = ''
}
Config['DurationCheck'] = false 

Config['Objects'] = {
    {
        ['Object'] = 'prop_tv_flat_01',
        ['Scale'] = 0.05,
        ['Offset'] = vec3(-0.925, -0.055, 1.0),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = 'prop_tv_flat_michael',
        ['Scale'] = 0.035,
        ['Offset'] = vec3(-0.675, -0.055, 0.4),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = 'prop_trev_tv_01',
        ['Scale'] = 0.012,
        ['Offset'] = vec3(-0.225, -0.01, 0.26),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = 'prop_tv_flat_03b',
        ['Scale'] = 0.016,
        ['Offset'] = vec3(-0.3, -0.062, 0.18),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = 'prop_tv_flat_03',
        ['Scale'] = 0.016,
        ['Offset'] = vec3(-0.3, -0.01, 0.4),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = 'prop_tv_flat_02b',
        ['Scale'] = 0.026,
        ['Offset'] = vec3(-0.5, -0.012, 0.525),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = 'prop_tv_flat_02',
        ['Scale'] = 0.026,
        ['Offset'] = vec3(-0.5, -0.012, 0.525),
        ['Distance'] = 7.5,
    },
    {
        ['Object'] = 'prop_tv_flat_02',
        ['Scale'] = 0.026,
        ['Offset'] = vec3(-0.5, -0.012, 0.525),
        ['Distance'] = 7.5,
    },
}

Strings = {
    ['VideoHelp'] = 'Saisissez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~/tv youtube id~s~ pour lire une vidéo.\nExemple : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~/tv 3hqjseATp4g~s~',
    ['VolumeHelp'] = 'Saisissez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~/volume (0-10)~s~ pour modifier le volume.\nExemple : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~/volume 5~s~\n\nSaisissez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~/tv youtube id~s~ pour changer la vidéo.\nExemple : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~/tv 3hqjseATp4g~s~\n\nTapez ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~/tvstop~s~ pour arrêter la vidéo\n\n~INPUT_CONTEXT~ Synchroniser l\'heure de la vidéo',
}

Config.Props = {
    {nameprops = 'Chaise',              modelprops = 'apa_mp_h_din_chair_12'},
    {nameprops = 'Carton',              modelprops = 'prop_cardbordbox_04a'},
    {nameprops = 'Sac',                 modelprops = 'prop_cs_heist_bag_02'},
    {nameprops = 'Table 1',             modelprops = 'prop_rub_table_02'},
    {nameprops = 'Table 2',             modelprops = 'prop_table_04'},
    {nameprops = 'Table 3',             modelprops = 'bkr_prop_weed_table_01b'},
    {nameprops = 'Chaise 1',            modelprops = 'bkr_prop_clubhouse_chair_01'},
    {nameprops = 'Chaise 2',            modelprops = 'bkr_prop_weed_chair_01a'},
    {nameprops = 'Chaise de Pêche',     modelprops = 'hei_prop_hei_skid_chair'},
    {nameprops = 'Chaise de Bureau',    modelprops = 'bkr_prop_clubhouse_offchair_01a'},
    {nameprops = 'Canapé',              modelprops = 'v_tre_sofa_mess_c_s'},
    {nameprops = 'Canapé 2',            modelprops = 'v_res_tre_sofa_mess_a'},
    {nameprops = 'Ordinateur',          modelprops = 'bkr_prop_clubhouse_laptop_01a'},
    {nameprops = 'Lit',                 modelprops = 'gr_prop_bunker_bed_01'},
    {nameprops = 'Outils',              modelprops = 'prop_cs_trolley_01'},
    {nameprops = 'Outils de mécanique', modelprops = 'prop_carcreeper'},
    {nameprops = 'Sac de sport',        modelprops = 'prop_cs_heist_bag_02'},
    {nameprops = 'Trousse médical 2',   modelprops = 'xm_prop_x17_bag_med_01a'},
}

ActiveMenu = false

Restrein = true

Group = {
    Authorize1 = 'animateur',
    Authorize2 = 'founder',
    --Authorize3 = '',
    --Authorize4 = '',
    --Authorize5 = '',
}