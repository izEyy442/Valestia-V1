local blackmoney = 0

local passblanchiment = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
        Citizen.Wait(100)
    end
    while ESX.GetPlayerData().job == nil do ---- Recherche du job du joueurs 
        Citizen.Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local izBlanchiment = RageUI.CreateMenu("", "Blanchiment", 0, 0, 'commonmenu', 'interaction_bgd')
izBlanchiment.Closed = function()
    open = false
end

ConfigBlackListeJob = {
    ["police"] = true,
    ["bcso"] = true,
    ["fib"] = true
}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    Wait(2000)
end)
function rhash(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Citizen.CreateThread(function()
    Wait(750)

	for k,v in pairs(ConfigWashMoney.ConfigBlanchiment) do
		local pp = v.ped
		local pc = v.pedpos
		local pedHash = GetHashKey(pp)
		local head = v.pedhead
		rhash(pedHash)
		local pped = CreatePed(2, pedHash, pc.x , pc.y , pc.z , head, false, true)
		FreezeEntityPosition(pped, true)
		SetEntityInvincible(pped, true)
		SetPedCanRagdoll(pped, true)
		SetPedCanArmIk(pped, true )
		SetPedCanBeTargetted(pped, true)
		SetBlockingOfNonTemporaryEvents(pped, true)  
    end
end)

function DMenuBanchiment(taux,pos,minimal)
	getblackmoney()
	if open then
		open = false
		RageUI.Visible(izBlanchiment,false)
		return
	else
        
		open = true
		RageUI.Visible(izBlanchiment,true)
		CreateThread(function()
			while open do 
				
				local pc = GetEntityCoords(PlayerPedId())
				local dif = #(pc-pos)
				if dif > 6 then
					RageUI.CloseAll()
				end
				if blackmoney >= minimal then
					passblanchiment = true 

				else
					passblanchiment = false 

				end
				RageUI.IsVisible(izBlanchiment,function()
					if ConfigBlackListeJob[ESX.PlayerData.job and ESX.PlayerData.job.name] then
						RageUI.Separator("")
						RageUI.Separator("Tu veux quoi ? il n'a rien à voir ici dégage !")
						RageUI.Separator("")
					else

						local moneyconverted = blackmoney - blackmoney*taux/100
						RageUI.Separator("Taux de Blanchiment : ~h~~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..taux.."%~h~")
						RageUI.Separator("Minimum pour Blanchir : ~h~~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..minimal.."$~h~")
						RageUI.Separator("Vous avez : ~h~~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..blackmoney.."$~h~")
						RageUI.Separator("Vous recevrez : ~h~~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..moneyconverted.."$~h~")
						RageUI.Line()
						if passblanchiment == true then  
							RageUI.Button("Argent disponible a blanchir", nil, {RightLabel = "(~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..blackmoney.. "$~s~)"}, passblanchiment == true , {
								onSelected = function()
									if (not IsInPVP) then
										TriggerServerEvent("Blanchiment", taux, minimal)
										RageUI.CloseAll()
									else
										ESX.ShowNotification("Impossible en mode PvP...")
									end
								end
							})
						else
							RageUI.Button("Tu n'a pas le Minimum", nil, {RightLabel = "~r~"..blackmoney.. " $"}, passblanchiment == true , {
								onSelected = function()
									RageUI.CloseAll()
								end
							})
						end
					end
				end)
				Citizen.Wait(1)
			end
		end)
	end
end
function getblackmoney()
	ESX.TriggerServerCallback("GetBlacKMoney",function(cb)
		blackmoney = cb
	end)
end
CreateThread(function()
	while true do
		local interval = 750 
		for _,v in pairs (ConfigWashMoney.ConfigBlanchiment) do 
			local ped = PlayerPedId()
			local pc = GetEntityCoords(ped)
			local mc = v.pos
			local dif = #(pc-mc)
			
			if dif < 10 then 
				interval = 1
				if dif < 1.5 and not RageUI.Visible(izBlanchiment) then
					ESX.ShowHelpNotification("Appuye sur ~INPUT_CONTEXT~ pour parler a "..v.blanchisseurname)
					-- DrawMarker(6,mc.x,mc.y,mc.z,0.0,0.0,100.0,0.0,0.0,0.0,0.5,0.5,0.5,245, 245, 245,255,false,false,0,false,nil,nil,false)
					if IsControlJustPressed(0, 51) then
						DMenuBanchiment(v.taux,v.pos,v.minimal)
					end
				end
			end
		end
		Wait(interval)
	end
end)