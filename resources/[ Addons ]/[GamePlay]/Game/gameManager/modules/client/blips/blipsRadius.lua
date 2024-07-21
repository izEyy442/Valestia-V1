-- --[[
--   This file is part of Valestia RolePlay.
--   Copyright (c) Valestia RolePlay - All Rights Reserved
--   Unauthorized using, copying, modifying and/or distributing of this file,
--   via any medium is strictly prohibited. This code is confidential.
-- --]]

-- Map = {

--     {name="[Public] Commissariat de Police",color=77, id=60, x=449.47723388672, y=-986.58728027344, z=43.690696716309, r= 0.0},

--     {name="[Public] B.C.S.O",color=52, id=58, x=-445.31930541992, y=6008.9243164063, z=44.012222290039, r= 0},

--     {name="[Public] Hôpital",color=2, id=61, x=-1865.544921875, y=-346.95434570312, z=135.11682128906, r= 0.0}, 

--     -- {name="[Public] Bureau FIB",color=5, id=88, scale=0.8, x=2530.2587890625, y=-382.09423828125, z=92.99340820312, r= 1500.0},

--     -- {name="Sherrif",color=56, id=60, x=-443.08, y = 6016.76, z = 31.4},

--     {name="[Mecano] Benny's",color=5, id=446, scale=0.8, x= -216.6223, y = -1326.719, z= 31.300, r= 0},

--     {name="[Mecano] Ls Custom",color=50, id=446, scale=0.8, x=-331.3797, y = -109.7054, z= 39.01394, r= 0},

--     {name="[Mecano] North Custom",scale, color=16, id=446, scale=0.8, x=111.46559143066, y = 6626.2924804688, z= 38.793937683105, r= 0},

--     {name="[Public] Gouvernement",color=0, id=419,x=-437.126, y = 1089.869, z= 330.2457, r= 0},

--     {name="[Public] Unicorn", color=27, id=121, 12, x=129.246, y = -1300.6, z= 29.2, r= 0},

--     {name="[Public] Tequilala", color=5, id=93, 12, x=-584.87310791016, y = 296.06509399414, z= 89.617156982422, r= 0},

--     -- {name="[Territoire] Bloods",color=1, id=378,x = -1545.39, y = -407.93, z = 41.98, r= 0},

--     -- {name="[Territoire] Marabunta",color=26, id=378,x=1256.80, y = -1582.10, z= 54.55, r= 0},

--     -- {name="[Territoire] Vagos",color=5, id=378,x=324.73, y = -2031.74, z= 20.87, r= 0}, 

--     -- {name="[Territoire] Ballas",color=27, id=378,x=88.05, y = -1925.59, z= 20.79, r= 0},

--     -- {name="[Territoire] Families",color=2, id=378,x=-165.40, y = -1632.77, z= 33.65, r= 0},

--     {name="[Activité] Zone de Chasse",color=17, id=141,x=-567.27, y = 5253.18, z= 70.46, r= 0.0},

--     {name="[Public] Boucherie",color=34, id=478, x = 960.84, y = -2111.57, z = 31.94, r= 0.0},

--     {name="[Public] Diamond Casino", color=0, id=679, x = 967.33441162109, y = 41.609596252441, z = 123.12677764893, r= 0.0},

--     {name="[Entreprise] Vigneron",color=61, id=85, x = -1890.2873535156, y = 2045.201171875, z = 140.8708190918, r= 0.0},

--     -- {name="[Privé] Gouvernement de Cayo Perico",color=21, id=501, x = 4824.451, y = -5043.9, z = 30.9309, r= 10000.0},

--     {name="[Public] Pacific Central Bank",color=0, id=375, x = 232.8646, y = 215.7497, z = 157.5744, r= 0.0},

--     --{name="[Entreprise] Agence Immobilière",color=69, id=40, x = -706.3798, y = 268.9534, z = 83.10735, r= 0.0},

--     --{name="Acheteur de poisson",color=51, id=480, x = 1961.89, y = 5184.36, z = 47.98, r= 0.0},

--     --{name="Pêche",color=38, id=480, x = 2073.23, y = 4554.31, z = 31.31, r= 0.0},

--     --{name="Hopital",color=2, id=61,x=286.6, y = -582.8, z= 43.3},

--     --{name="Commissariat de Police",color=29, id=60,x=425.1, y = -979.5, z= 30.7},

--     --{name="Quartier Yakuza",color=68, id=378,x=-1059.5769, y = -1028.1550, z= 30.7},

-- }

-- Citizen.CreateThread(function()
--   for i=1, #Map, 1 do
--     local blip = AddBlipForCoord(Map[i].x, Map[i].y, Map[i].z) 
--       SetBlipSprite (blip, Map[i].id)
--       SetBlipDisplay(blip, 4)
--       SetBlipScale  (blip, 0.6)
--       SetBlipColour (blip, Map[i].color)
--       SetBlipAsShortRange(blip, true)
--       BeginTextCommandSetBlipName("STRING") 
--       AddTextComponentString(Map[i].name)
--       EndTextCommandSetBlipName(blip)
--       local zoneblip = AddBlipForRadius(Map[i].x, Map[i].y, Map[i].z, Map[i].r)
--       SetBlipSprite(zoneblip,1)
--       SetBlipColour(zoneblip,Map[i].color)
--       SetBlipAlpha(zoneblip,100)
--   end
-- end)