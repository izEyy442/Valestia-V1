--- MENU ---

local open = false 
local mainMenu = RageUI.CreateMenu('', 'Frigo Yellow Jack') 
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function OpenMenuAccueilyellowjack() 
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(mainMenu, function()

        RageUI.Separator("↓ Boissons ↓")

        RageUI.Button("~y~Acheter~s~ x1 Tequila", nil, {RightLabel = "100$"}, not codesCooldown5 , {
			onSelected = function()
			TriggerServerEvent('yellowjack:BuyTequila', 100)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
       end 
    })

    RageUI.Button("~y~Acheter~s~ x1 Jack Daniel", nil, {RightLabel = "100$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('yellowjack:BuyJackDaniel', 100)	
    Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
   end 
})

RageUI.Button("~y~Acheter~s~ x1 Poliakov", nil, {RightLabel = "100$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyPoliakov', 100)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Vin", nil, {RightLabel = "100$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyVin', 100)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Don Papa", nil, {RightLabel = "100$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyDonPapa', 100)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Champagne", nil, {RightLabel = "100$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyChampagne', 100)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Bière 8.6", nil, {RightLabel = "100$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:Buy86', 100)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Mojito", nil, {RightLabel = "100$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyMojito', 100)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Sangria", nil, {RightLabel = "100$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuySangria', 100)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Limoncello", nil, {RightLabel = "100$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyLimoncello', 100)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Coca", nil, {RightLabel = "15$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyCoca', 15)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Ice Tea", nil, {RightLabel = "15$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyIceTea', 15)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Café", nil, {RightLabel = "15$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyCafe', 15)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

RageUI.Button("~y~Acheter~s~ x1 Diabolo", nil, {RightLabel = "15$"}, not codesCooldown5 , {
    onSelected = function()
    TriggerServerEvent('yellowjack:BuyDiabolo', 15)	
Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
end 
})

    RageUI.Separator("↓ Nourritures ↓")

    RageUI.Button("~y~Acheter~s~ x1 Burrito", nil, {RightLabel = "35$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('yellowjack:BuyBurrito', 35)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~y~Acheter~s~ x1 Hot Dog", nil, {RightLabel = "30$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('yellowjack:BuyHotDog', 30)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~y~Acheter~s~ x1 Croissant", nil, {RightLabel = "10$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('yellowjack:BuyCroissant', 10)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~y~Acheter~s~ x1 Saucisson", nil, {RightLabel = "15$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('yellowjack:BuySaucisson', 15)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~y~Acheter~s~ x1 Cacahuètes", nil, {RightLabel = "10$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('yellowjack:BuyCacahuetes', 10)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~y~Acheter~s~ x1 Doritos", nil, {RightLabel = "10$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('yellowjack:BuyDoritos', 10)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~y~Acheter~s~ x1 Monster Munch", nil, {RightLabel = "15$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('yellowjack:BuyMonsterMunch', 15)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

		end)			
		Wait(0)
	   end
	end)
 end
end

local position = {
    {x = 1989.42, y = 3046.60, z = 47.20}
}

Citizen.CreateThread(function()
    while true do
        local wait = 1000

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellowjack' then 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 15.0 then
                    wait = 0
                    DrawMarker(36, 1989.42, 3046.60, 47.20, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 59, 255, true, true, p19, true)  

            
                    if dist <= 3.0 then
                        --Visual.Subtitle("Appuyer sur ~y~[E]~s~ pour intéragir avec le Frigo", 1)
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le frigo.")
                        if IsControlJustPressed(1,51) then
                            OpenMenuAccueilyellowjack()
                        end
                    end
                end
            end
        end

        Wait(wait)
    end
end)

