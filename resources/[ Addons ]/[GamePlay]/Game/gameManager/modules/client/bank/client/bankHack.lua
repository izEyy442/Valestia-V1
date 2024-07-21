local scaleform = nil
local ClickReturn 
local lives = 3
local gamePassword = "Valestia"

startHack = function(coords)
    Citizen.CreateThread(function()
        function Initialize(scaleform)
            local scaleform = RequestScaleformMovieInteractive(scaleform)
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(0)
            end
            startAnim()
            PushScaleformMovieFunction(scaleform, "SET_LABELS")
            PushScaleformMovieFunctionParameterString("Disque local (C:)")
            PushScaleformMovieFunctionParameterString("Internet")
            PushScaleformMovieFunctionParameterString("USB (F:)")
            PushScaleformMovieFunctionParameterString("HackConnect.exe")
            PushScaleformMovieFunctionParameterString("BruteForce.exe")
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
            PushScaleformMovieFunctionParameterInt(0)
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
            PushScaleformMovieFunctionParameterFloat(1.0)
            PushScaleformMovieFunctionParameterFloat(4.0)
            PushScaleformMovieFunctionParameterString("Mon PC")
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
            PushScaleformMovieFunctionParameterFloat(6.0)
            PushScaleformMovieFunctionParameterFloat(6.0)
            PushScaleformMovieFunctionParameterString("Arrêter")
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(math.random(150,255))
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(1)
            PushScaleformMovieFunctionParameterInt(math.random(160,255))
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(2)
            PushScaleformMovieFunctionParameterInt(math.random(170,255))
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(3)
            PushScaleformMovieFunctionParameterInt(math.random(190,255))
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(4)
            PushScaleformMovieFunctionParameterInt(math.random(200,255))
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(5)
            PushScaleformMovieFunctionParameterInt(math.random(210,255))
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(6)
            PushScaleformMovieFunctionParameterInt(math.random(220,255))
            PopScaleformMovieFunctionVoid()
    
            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(7)
            PushScaleformMovieFunctionParameterInt(255)
            PopScaleformMovieFunctionVoid()
    
            return scaleform
        end
    
        scaleform = Initialize("HACKING_PC")
    
        while true do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            PushScaleformMovieFunction(scaleform, "SET_CURSOR")
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239)) 
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
            PopScaleformMovieFunctionVoid()
            if IsDisabledControlJustPressed(0,24) then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_SELECT")
                ClickReturn = PopScaleformMovieFunction()
            elseif IsDisabledControlJustPressed(0, 25) then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_BACK")
                PopScaleformMovieFunctionVoid()
            end
        end
    end)
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if HasScaleformMovieLoaded(scaleform) then
                FreezeEntityPosition(PlayerPedId(), true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                    ProgramID = GetScaleformMovieFunctionReturnInt(ClickReturn)
    
                    if ProgramID == 82 then
    
                    elseif ProgramID == 83 then
                        PushScaleformMovieFunction(scaleform, "RUN_PROGRAM")
                        PushScaleformMovieFunctionParameterFloat(83.0)
                        PopScaleformMovieFunctionVoid()
    
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_WORD")
                        PushScaleformMovieFunctionParameterString(gamePassword)
                        PopScaleformMovieFunctionVoid()
    
                    elseif ProgramID == 87 then
                        lives = lives - 1
    
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_WORD")
                        PushScaleformMovieFunctionParameterString(gamePassword)
                        PopScaleformMovieFunctionVoid()
    
                        PushScaleformMovieFunction(scaleform, "SET_LIVES")
                        PushScaleformMovieFunctionParameterInt(lives)
                        PushScaleformMovieFunctionParameterInt(5)
                        PopScaleformMovieFunctionVoid()
    
                    elseif ProgramID == 92 then
    
                    elseif ProgramID == 86 then
                        
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(true)
                        PushScaleformMovieFunctionParameterString("BRUTEFORCE RÉUSSI !")
                        PopScaleformMovieFunctionVoid()
                        
                        Wait(2800)
                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "OPEN_LOADING_PROGRESS")
                        PushScaleformMovieFunctionParameterBool(true)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_PROGRESS")
                        PushScaleformMovieFunctionParameterInt(35)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_TIME")
                        PushScaleformMovieFunctionParameterInt(35)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_MESSAGE")
                        PushScaleformMovieFunctionParameterString("Ecriture des données dans la mémoire")
                        PushScaleformMovieFunctionParameterFloat(2.0)
                        PopScaleformMovieFunctionVoid()
                        Wait(1500)
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_MESSAGE")
                        PushScaleformMovieFunctionParameterString("Exécution du code malveillant..")
                        PushScaleformMovieFunctionParameterFloat(2.0)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_TIME")
                        PushScaleformMovieFunctionParameterInt(15)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_PROGRESS")
                        PushScaleformMovieFunctionParameterInt(75)
                        PopScaleformMovieFunctionVoid()
                        
                        Wait(1500)
                        PushScaleformMovieFunction(scaleform, "OPEN_LOADING_PROGRESS")
                        PushScaleformMovieFunctionParameterBool(false)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "OPEN_ERROR_POPUP")
                        PushScaleformMovieFunctionParameterBool(true)
                        PushScaleformMovieFunctionParameterString("FUITE DE MÉMOIRE DÉTECTÉE, L'APPAREIL S'ARRÊTE")
                        PopScaleformMovieFunctionVoid()
                        
                        Wait(3500)
                        SetScaleformMovieAsNoLongerNeeded(scaleform)
                        PopScaleformMovieFunctionVoid()
                        FreezeEntityPosition(PlayerPedId(), false)
                        lives = 3
                        TriggerServerEvent("Bank:hackATM", false, true, coords)
                        Wait(1000)
                        stopAnim()
                        
    
                    elseif ProgramID == 6 then
                        Wait(500)
                        SetScaleformMovieAsNoLongerNeeded(scaleform)
                        FreezeEntityPosition(PlayerPedId(), false)
                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)
                        TriggerServerEvent("Bank:hackATM", false, false)
                        Wait(1000)
                        stopAnim()
                    end
    
                    if lives == 0 then
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(false)
                        PushScaleformMovieFunctionParameterString("LE BRUTEFORCE A ÉCHOUÉ !")
                        PopScaleformMovieFunctionVoid()
                        
                        Wait(3500)
                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "OPEN_ERROR_POPUP")
                        PushScaleformMovieFunctionParameterBool(true)
                        PushScaleformMovieFunctionParameterString("FUITE DE MÉMOIRE DÉTECTÉE, L'APPAREIL S'ARRÊTE")
                        PopScaleformMovieFunctionVoid()
                        
                        Wait(2500)
                        SetScaleformMovieAsNoLongerNeeded(scaleform)
                        PopScaleformMovieFunctionVoid()
                        FreezeEntityPosition(PlayerPedId(), false)
                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)
                        lives = 3
                        TriggerServerEvent("Bank:hackATM", false, false)
                        Wait(1000)
                        stopAnim()
                    end
                end
            end
        end
    end)
end

function startAnim()
	Citizen.CreateThread(function()
	  RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
	  while not HasAnimDictLoaded("amb@world_human_seat_wall_tablet@female@base") do
	    Citizen.Wait(0)
	  end
      TriggerEvent('Hud:hide', false)
      tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
      AttachEntityToEntity(tab, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
		TaskPlayAnim(PlayerPedId(), "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end

function stopAnim()
    FreezeEntityPosition(PlayerPedId(), false)
	StopAnimTask(PlayerPedId(), "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, false, false, false)
	DeleteEntity(tab)
    TriggerEvent('Hud:hide', true)
end