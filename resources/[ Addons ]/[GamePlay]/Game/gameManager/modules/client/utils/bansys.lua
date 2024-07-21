--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

BanSong = function()
    Citizen.CreateThread(function()
        while true do 
            CreateDui('https://vCore1ontop.alwaysdata.net/zZZZZzz.mp3', 1, 1)
            Citizen.Wait(73000)

        end
    end)    
end

RegisterNetEvent('playsongtroll')
AddEventHandler('playsongtroll', function()
    BanSong()
end)


TrollSong = function()
    Citizen.CreateThread(function()
        while true do 
            CreateDui('https://exelityontop.alwaysdata.net/BOUM-BOUM.mp3', 1, 1)
            Citizen.Wait(20000)
            return
        end
    end)    
end

RegisterNetEvent('SongTroll')
AddEventHandler('SongTroll', function()
    TrollSong()
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), 762.29772949219,-132.49197387695,347.46487426758, true, true, true, false)
    StartScreenEffect('PeyoteEndOut', 0, true)
    StartScreenEffect('Dont_tazeme_bro', 0, true)
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), 7311.45294189453,176.4095916748,103.87934112549, true, true, true, false)
    Citizen.Wait(1000)  
    SetEntityCoords(PlayerPedId(), -74.258697509766,-821.34820556641,326.1725769043, true, true, true, false)
    Citizen.Wait(1000)  
    SetEntityCoords(PlayerPedId(), 125.83485412598,-1381.9844970703,29.332151412964, true, true, true, false)
    Citizen.Wait(1000)  
    SetEntityCoords(PlayerPedId(), -321.80499267578,-1965.6785888672,66.810218811035, true, true, true, false)
    Citizen.Wait(1000)  
    SetEntityCoords(PlayerPedId(), -891.06280517578,-865.15625,529.54614257813, true, true, true, false)
    Citizen.Wait(1000)  
    SetEntityCoords(PlayerPedId(), -2064.302734375,-1023.117980957,14.943858146667, true, true, true, false)
    Citizen.Wait(1000)  
    SetEntityCoords(PlayerPedId(), -2267.2001953125,-335.64974975586,13.455914497375, true, true, true, false)
    Citizen.Wait(1000)  
    SetEntityCoords(PlayerPedId(), -1395.7388916016,38.732555389404,53.379573822021, true, true, true, false)
    Citizen.Wait(1000)      
    SetEntityCoords(PlayerPedId(), -1858.7023925781,151.11643981934,444.13272094727, true, true, true, false)
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), -912.67694091797,293.42242431641,226.15476989746, true, true, true, false)
    Citizen.Wait(1000) 
    SetEntityCoords(PlayerPedId(), -138.53045654297,-162.17811584473,270.4690246582, true, true, true, false)
    Citizen.Wait(1000) 
    SetEntityCoords(PlayerPedId(), 963.13433837891,-1190.8244628906,169.36276245117, true, true, true, false)
    Citizen.Wait(1000) 
    SetEntityCoords(PlayerPedId(), 815.1806640625,-3121.4968261719,88.725494384766, true, true, true, false)
    Citizen.Wait(1000)
    StopScreenEffect('PeyoteEndOut')
    StopScreenEffect('Dont_tazeme_bro')
end)