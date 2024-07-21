local Server = GetConvar('sv_type', 'FA')
local Servers = {
	['DEV'] = {
		webhook = "",
		drugs = {
			WeedField = vector3(-124.086, 2791.240, 53.107),
			WeedProcessing = vector3(-1146.794, 4940.908, 222.26),
			WeedDealer = vector3(364.350, -2065.05, 21.74),
			CokeField = vector3(-106.441, 1910.979, 196.936),
			CokeProcessing = vector3(722.438, 4190.06, 41.09),
			CokeDealer = vector3(724.99, -1189.87, 24.27),
			MethField = vector3(2434.164, 4969.4897, 42.347),
			MethProcessing = vector3(1391.541, 3603.589, 38.941),
			MethDealer = vector3(-1146.794, 4940.908, 222.268),
			OpiumField = vector3(1444.35, 6332.3, 23.96),
			OpiumProcessing = vector3(2165.724, 3379.376, 46.43),
			OpiumDealer = vector3(3817.0505, 4441.494, 2.810)
		}
	},
	['FA'] = {
		webhook = "https://discord.com/api/webhooks/1226978396290945126/o2aPf999sGSB5koBrRGnKT9C5HctLLV6TQWAsDU5JNCfC7U89kyXbOJNrX_JQKlX9y1H",
		drugs = {
			WeedField = vector3(-299.58, 2535.71, 74.61),
			WeedProcessing = vector3(1123.28, -1302.482, 34.71),
			WeedDealer = vector3(870.52, -2312.09, 30.57),
			CokeField = vector3(5332.92, -5167.48, 28.31),
			CokeProcessing = vector3(4961.52, -5108.73, 2.98),
			CokeDealer = vector3(1081.85, -2412.88, 30.20),
			MethField = vector3(414.38, 6632.52, 28.26),
			MethProcessing = vector3(1791.725, 4604.93, 37.18),
			MethDealer = vector3(-339.11, -2444.28, 7.29),
			OpiumField = vector3(222.14, 2579.73, 45.81),
			OpiumProcessing = vector3(894.67, -883.11, 26.11),
			OpiumDealer = vector3(969.02, -1226.70, 27.06),
			BilletField = vector3(152.42, -3210.08, 5.89),
			BilletProcessing = vector3(1298.93, -1752.9, 53.88),
			BilletDealer = vector3(297.38, -1776.22, 28.06)
		}
	},
	['WL'] = {
		webhook = "",
		drugs = {
			WeedField = vector3(-2939.7504, 590.7938, 23.9843),
			WeedProcessing = vector3(9.1790, 52.8179, 71.6338),
			WeedDealer = vector3(37.2775, -1029.3741, 29.5688),
			CokeField = vector3(1222.5316, 1898.9322, 77.9426),
			CokeProcessing = vector3(8.7506, -243.1087, 55.8605),
			CokeDealer = vector3(-289.3043, -1080.6926, 23.0211),
			MethField = vector3(-1000.0, -1000.0, -1000.0),
			MethProcessing = vector3(-1000.0, -1000.0, -1000.0),
			MethDealer = vector3(-1000.0, -1000.0, -1000.0),
			OpiumField = vector3(-1000.0, -1000.0, -1000.0),
			OpiumProcessing = vector3(-1000.0, -1000.0, -1000.0),
			OpiumDealer = vector3(-1000.0, -1000.0, -1000.0)
		}
	}
}

exports('GetData', function(key)
	return Servers[Server][key]
end)