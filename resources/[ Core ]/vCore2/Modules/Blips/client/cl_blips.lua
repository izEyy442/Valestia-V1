--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Map = {

    {name="[Public] Commissariat de Police",color=77, id=60, x=-581.6697, y=-421.753, z=35.1718, r= 0.0},

    {name="[Public] B.C.S.O",color=52, id=58, x=-445.31930541992, y=6008.9243164063, z=44.012222290039, r= 0},

    {name="[Public] Hôpital",color=2, id=61, x=-1865.544921875, y=-346.95434570312, z=135.11682128906, r= 0.0}, 

    {name="[Mecano] Benny's",color=5, id=566, scale=0.8, x= -216.6223, y = -1326.719, z= 31.300, r= 0},

    {name="[Mecano] Ls Customs",color=62, id=777, scale=0.8, x=-331.3797, y = -109.7054, z= 39.01394, r= 0},

    {name="[Mecano] North Custom",scale, color=16, id=446, scale=0.8, x=111.46559143066, y = 6626.2924804688, z= 38.793937683105, r= 0},

    {name="[Public] Gouvernement",color=0, id=419,x=-437.126, y = 1089.869, z= 330.2457, r= 0},

    {name="[Public] Unicorn", color=27, id=121, 12, x=129.246, y = -1300.6, z= 29.2, r= 0},

    {name="[Public] Tequilala", color=5, id=93, 12, x=-584.87310791016, y = 296.06509399414, z= 89.617156982422, r= 0},

    {name="[Public] Yellow Jack", color=5, id=93, 12, x = 1989.42, y = 3046.60, z = 47.20, r= 0},

    {name="[Métier Libre] Zone de Chasse",color=17, id=432,x=-567.27, y = 5253.18, z= 70.46, r= 0.0},

    {name="[Public] Boucherie",color=34, id=478, x = 960.84, y = -2111.57, z = 31.94, r= 0.0},

    {name="[Public] Diamond Casino", color=0, id=679, x = 967.33441162109, y = 41.609596252441, z = 123.12677764893, r= 0.0},

    {name="[Entreprise] Vigneron", color=61, id=85, x = -1890.2873535156, y = 2045.201171875, z = 140.8708190918, r= 0.0},

    {name="[Public] Pont de Cayo Perico", color=21, id=181, x = 1440.9175, y = -2613.8506, z = 48.2869, r= 0.0},
    
    {name="[Public] Pont de Roxwood", color=21, id=181, x = -543.4686, y = 6278.7549, z = 9.5811, r= 0.0},

    {name="[Public] Point de rassemblement", color=26, id=778, x = 859.3779, y = -2365.1123, z = 30.3462, r= 0.0},

    {name="[Illégal] Cage de combat", color=75, id=437, x = 928.7234, y = -1786.8075, z = 30.6626, r= 0.0},

    {name="[Activité] Terrain de cross", color=4, id=495, x = 1051.7683, y = 2331.8545, z = 91.9774, r= 0.0},

    {name="[Activité] Circuit de Karting", color=4, id=127, x = 2100.0286, y = 3961.5974, z = 37.2783, r= 0.0},

    {name="[Public] Pawn Shop", color=0, id=605, x = 445.9537, y = -1472.1261, z = 29.2923, r= 0.0},

    {name="[Public] Église", color=0, id=305, x = -766.9183, y = -23.5088, z = 41.0808, r= 0.0},

    {name="[Privé] Académie de Police", color=77, id=60, x = -1633.8694, y = 182.1387, z = 61.7524, r= 0.0},

    {name="[Entreprise] RockFord Record", color=22, id=135, x = -1018.6962, y = -263.3723, z = 39.0408, r= 0.0},
    
    {name="[Activité] Aire de jeux", color=68, id=197, x = -1467.0002, y = -1188.5492, z = 2.6373, r= 0.0},

    {name="[Activité] Circuit de Karting", color=4, id=127, x = -153.2229, y = -2137.8896, z = 16.7051, r= 0.0},

}

Citizen.CreateThread(function()
  for i=1, #Map, 1 do
    local blip = AddBlipForCoord(Map[i].x, Map[i].y, Map[i].z) 
      SetBlipSprite (blip, Map[i].id)
      SetBlipDisplay(blip, 4)
      SetBlipScale  (blip, 0.6)
      SetBlipColour (blip, Map[i].color)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING") 
      AddTextComponentString(Map[i].name)
      EndTextCommandSetBlipName(blip)
      local zoneblip = AddBlipForRadius(Map[i].x, Map[i].y, Map[i].z, Map[i].r)
      SetBlipSprite(zoneblip,1)
      SetBlipColour(zoneblip,Map[i].color)
      SetBlipAlpha(zoneblip,100)
  end
end)