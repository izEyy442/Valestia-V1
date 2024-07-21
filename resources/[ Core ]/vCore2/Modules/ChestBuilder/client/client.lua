CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)
local ChestServer = {}
local tempoTable = {}

local pos = nil
local job = nil
local MaxWeight = 0
local AccesBlackMoney = nil
local bpos = nil
local bjob = nil
local bMaxWeight = nil
local bAccesBlackMoney = nil

local currentmoney = 0
local currentbmoney = 0

local ChestBuilderMenu = RageUI.CreateMenu("", "Coffre Builder", 0, 0, 'commonmenu', 'interaction_bgd')
local ChestBuilderMenuInteract = RageUI.CreateSubMenu(ChestBuilderMenu, "", "Coffre Builder", 0, 0, 'commonmenu', 'interaction_bgd')
local ChestBuilderMenuChestIneract = RageUI.CreateSubMenu(ChestBuilderMenu, "", "Coffre Builder", 0, 0, 'commonmenu', 'interaction_bgd') 

local ChestMenu = RageUI.CreateMenu("", "Coffre", 0, 0, 'commonmenu', 'interaction_bgd')
local ChestMenuMyInventory = RageUI.CreateSubMenu(ChestMenu, "", "Votre Inventaire", 0, 0, 'commonmenu', 'interaction_bgd')
local ChestInventory = RageUI.CreateSubMenu(ChestMenu, "", "Inventaire du coffre", 0, 0, 'commonmenu', 'interaction_bgd')

ChestBuilderMenu.Closed = function()
    open = false
    pos = nil
    job = nil
    MaxWeight = 0
    AccesBlackMoney = nil
end
ChestMenu.Closed = function()
    open2 = false
    pos = nil
    job = nil
    MaxWeight = 0
    AccesBlackMoney = nil
end

RegisterNetEvent("ChestBuilder:OpenChestBuilder")
AddEventHandler("ChestBuilder:OpenChestBuilder", function()
    OpenChestBuilder()
end)

RegisterNetEvent("ChestBuilder:RefreshChest")
AddEventHandler("ChestBuilder:RefreshChest", function(SChestServer)
    ChestServer = SChestServer
end)
RegisterNetEvent("ChestBuilder:refreshMoney")
AddEventHandler("ChestBuilder:refreshMoney", function(type,money)
    if type == "money" then
        currentmoney = money
    elseif type == "bmoney" then
        currentbmoney = money
    end
end)
   


function OpenChestBuilder()
	if open then
		open = false
		RageUI.Visible(ChestBuilderMenu,false)
		return
	else
		open = true
		RageUI.Visible(ChestBuilderMenu,true)
		CreateThread(function()
			while open do 
                if pos ~= nil then
                    bpos = "💩"
                else
                    bpos = "→→→"
                end
                if job ~= nil then
                    bjob = "💩"
                else
                    bjob = "→→→"
                end
                if MaxWeight ~= 0 then
                    bMaxWeight = "💩"
                else
                    bMaxWeight = "→→→"
                end
                if AccesBlackMoney == true then
                    bAccesBlackMoney = "💩"
                elseif AccesBlackMoney == false then
                    bAccesBlackMoney = "💦"
                else
                    bAccesBlackMoney = "→→→"
                end
				RageUI.IsVisible(ChestBuilderMenu,function() 
					RageUI.Button("Possition", pos, {RightLabel = bpos}, true, {
						onSelected = function()
							pos = GetEntityCoords(PlayerPedId())
						end
					})
                    RageUI.Button("Job", job, {RightLabel = bjob}, true, {
						onSelected = function()
							job = KeyboardInput("Job", "Job", 30)
						end
					})
                    RageUI.Button("Poids Maximal", MaxWeight.."KG", {RightLabel = bMaxWeight}, true, {
						onSelected = function()
							MaxWeight = KeyboardInput("Poids Maximal", "Poids Maximal", 30)
                            if tonumber(MaxWeight) ~= nil then
                                MaxWeight = tonumber(MaxWeight)
                            else
                                ESX.ShowNotification("Veuillez mettre un nombre")
                                MaxWeight = 0
                            end
						end
					})
                    RageUI.Button("Argent Sale (ui/no)", AccesBlackMoney, {RightLabel = bAccesBlackMoney}, true, {
						onSelected = function()
                            AccesBlackMoney = KeyboardInput("Argent Sale (oui/non)", "Argent Sale (oui/non)", 30)
                            if AccesBlackMoney == "ui" then
                                AccesBlackMoney = true
                            elseif AccesBlackMoney == "no" then
                                AccesBlackMoney = false
                            else
                                ESX.ShowNotification("Veuillez mettre ui ou no")
                                AccesBlackMoney = nil
                            end
                        end
					})
                    RageUI.Button("~g~Confirme la creation~s~", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
						onSelected = function()
                            if pos ~= nil and job ~= nil and MaxWeight ~= 0 then
                                TriggerServerEvent("ChestBuilder:CreateChest", pos, job, MaxWeight, AccesBlackMoney)
                                pos = nil
                                job = nil
                                MaxWeight = 0
                                AccesBlackMoney = false
                                ESX.ShowNotification("~g~Création effectué")
                            else
                                TriggerEvent('esx:showNotification', "~r~Veuillez remplir tous les champs~s~")
                            end
						end
					})
                    RageUI.Line()
                    RageUI.Button("Gestion Coffre", nil, {RightLabel = "→→→"}, true, {
						onSelected = function()
							
						end
					},ChestBuilderMenuInteract)

				end)
                RageUI.IsVisible(ChestBuilderMenuInteract,function()
                    for k,v in pairs(ChestServer) do
                        local tempWeigth = 0
                        for k,v in pairs(v.items) do
                            tempWeigth = tempWeigth + (v.weight * v.count)
                        end
                        RageUI.Button("Coffre : "..v.job, "Poids : "..tempWeigth.." KG / "..v.MaxWeight.." KG\nArgent Propre : ~g~"..v.money.."$~s~\nArgent Sale : ~r~"..v.bmoney.." $~s~", {RightLabel = "ID : "..v.id}, true, {
                            onSelected = function()
                                tempoTable = v
                            end
                        },ChestBuilderMenuChestIneract)
                    end
                end) 
                RageUI.IsVisible(ChestBuilderMenuChestIneract,function()

                    RageUI.Button("Modifier la possition", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            Tpos = GetEntityCoords(PlayerPedId())
                            if Tpos ~= nil then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, nil,nil,nil,Tpos)
                                RageUI.GoBack()
                            end
                        end
                    })

                    RageUI.Button("Modifier le job", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            Tjob = KeyboardInput("Job", "Job", 30)
                            if Tjob ~= nil then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, Tjob)
                                RageUI.GoBack()
                            else
                                ESX.ShowNotification("Veuillez mettre un job")
                            end
                        end
                    })

                    RageUI.Button("Modifier le poid maximal", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            TMaxWeight = KeyboardInput("Poids Maximal", "Poids Maximal", 30)
                            if tonumber(TMaxWeight) ~= nil then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, nil, tonumber(TMaxWeight))
                                RageUI.GoBack()
                            else
                                ESX.ShowNotification("Veuillez mettre un nombre")
                            end
                        end
                    })

                    RageUI.Button("Modifier l'acces a l'argent sale (oui/non)", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            response = KeyboardInput("Argent Sale (oui/non)", "Argent Sale (oui/non)", 30)
                            if response == "ui" then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, nil,nil,true)

                                RageUI.GoBack()

                            elseif response == "no" then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, nil,nil, false)
                                RageUI.GoBack()
                            else
                                ESX.ShowNotification("Veuillez mettre oui ou non")
                            end
                        end
                    })

                    RageUI.Button("Déposer argent propre", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            local money = KeyboardInput("Nombre", "Combien voulez vous deposer ?", 30)
                            if tonumber(money) ~= nil then
                                TriggerServerEvent("ChestBuilder:PutMoney", tempoTable.id, tonumber(money))
                                RageUI.GoBack()
                            else
                                ESX.ShowNotification("Veuillez mettre un nombre")
                            end
                        end
                    })

                    RageUI.Button("Retirer argent propre", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            local Rmoney = KeyboardInput("Nombre", "Combien voulez vous retirer ?", 30)
                            if tonumber(Rmoney) ~= nil then
                                TriggerServerEvent("ChestBuilder:TakeMoney", tempoTable.id, tonumber(Rmoney))
                                RageUI.GoBack()
                            else
                                ESX.ShowNotification("Veuillez mettre un nombre")
                            end
                            
                        end
                    })
                    if tempoTable.accesbmoney ~= 0 then
                        RageUI.Line()

                        RageUI.Button("Déposer argent sale", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                local money = KeyboardInput("Nombre", "Combien voulez vous deposer ?", 30)
                                if tonumber(money) ~= nil then
                                    TriggerServerEvent("ChestBuilder:PutBlackMoney", tempoTable.id, tonumber(money))
                                    RageUI.GoBack()
                                else
                                    ESX.ShowNotification("Veuillez mettre un nombre")
                                end
                            end
                        })

                        RageUI.Button("Retirer argent sale", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                local Rmoney = KeyboardInput("Nombre", "Combien voulez vous retirer ?", 30)
                                if tonumber(Rmoney) ~= nil then
                                    TriggerServerEvent("ChestBuilder:TakeBlackMoney", tempoTable.id, tonumber(Rmoney))
                                    RageUI.GoBack()
                                else
                                    ESX.ShowNotification("Veuillez mettre un nombre")
                                end
                            end
                        })


                    end
                    RageUI.Line()
                    RageUI.Button("~r~Supprimer le coffre~s~", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            TriggerServerEvent("ChestBuilder:DeleteChest", tempoTable.id)
                            RageUI.GoBack()
                        end
                    })

                end)

				Citizen.Wait(1)
			end
		end)
	end
end

function OpenChestMenu(id)
    if open2 then
        open2 = false
        RageUI.Visible(ChestMenu,false)
        return
    else
        open2 = true
        RageUI.Visible(ChestMenu,true)
        CreateThread(function()
            while open2 do 
                local weight = 0
                for k,v in pairs(ChestServer[id].items) do
                    weight = weight + (v.weight * v.count)
                end
                RageUI.IsVisible(ChestMenu,function()
                    RageUI.Separator("Coffre : "..ESX.PlayerData.job.label)
                    -- RageUI.Separator("ID : "..ChestServer[id].id)
                    RageUI.Separator("Poids : "..weight.." KG / "..ChestServer[id].MaxWeight.." KG")
                    -- RageUI.Separator("Argent Propre : ~g~"..currentmoney.."$~s~")
                    -- if ChestServer[id].accesbmoney ~= 0 then
                    --     RageUI.Separator("Argent Sale : ~r~"..currentbmoney.."$~s~")
                    -- end
                    RageUI.Line()
                    RageUI.Button("Déposer objet", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            
                        end
                    },ChestMenuMyInventory)
                    RageUI.Button("Prendre objet", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            
                        end
                    },ChestInventory)
                    -- --RageUI.Line()
                    -- RageUI.Button("Déposer argent propre", nil, {RightLabel = "→→→"}, true, {
                    --     onSelected = function()
                    --         local money = KeyboardInput("Nombre", "Combien voulez vous deposer ?", 30)
                    --         if tonumber(money) ~= nil then
                    --             TriggerServerEvent("ChestBuilder:PutMoney", ChestServer[id].id, tonumber(money))
                    --         else
                    --             ESX.ShowNotification("Veuillez mettre un nombre")
                    --         end
                    --     end
                    -- })
                    -- RageUI.Button("Retirer argent propre", nil, {RightLabel = "→→→"}, true, {
                    --     onSelected = function()
                    --         local Rmoney = KeyboardInput("Nombre", "Combien voulez vous retirer ?", 30)
                    --         if tonumber(Rmoney) ~= nil then
                    --             TriggerServerEvent("ChestBuilder:TakeMoney", ChestServer[id].id, tonumber(Rmoney))
                    --         else
                    --             ESX.ShowNotification("Veuillez mettre un nombre")
                    --         end
                            
                    --     end
                    -- })
                    -- if ChestServer[id].accesbmoney ~= 0 then
                    --     RageUI.Line()

                    --     RageUI.Button("Déposer argent sale", nil, {RightLabel = "→→→"}, true, {
                    --         onSelected = function()
                    --             local money = KeyboardInput("Nombre", "Combien voulez vous deposer ?", 30)
                    --             if tonumber(money) ~= nil then
                    --                 TriggerServerEvent("ChestBuilder:PutBlackMoney", ChestServer[id].id, tonumber(money))
                    --             else
                    --                 ESX.ShowNotification("Veuillez mettre un nombre")
                    --             end
                    --         end
                    --     })

                    --     RageUI.Button("Retirer argent sale", nil, {RightLabel = "→→→"}, true, {
                    --         onSelected = function()
                    --             local Rmoney = KeyboardInput("Nombre", "Combien voulez vous retirer ?", 30)
                    --             if tonumber(Rmoney) ~= nil then
                    --                 TriggerServerEvent("ChestBuilder:TakeBlackMoney", ChestServer[id].id, tonumber(Rmoney))
                    --             else
                    --                 ESX.ShowNotification("Veuillez mettre un nombre")
                    --             end
                    --         end
                    --     })

                    -- end
                end)

                RageUI.IsVisible(ChestMenuMyInventory,function()
                    local weight = 0
                    ESX.PlayerData = ESX.GetPlayerData()
                    for k,v in pairs(ESX.PlayerData.inventory) do
                        weight = weight + (v.weight * v.count)
                    end
                    for k,v in pairs(ESX.PlayerData.inventory) do
                        RageUI.Button(v.label, "Poids unitaire : "..v.weight.." KG", {RightLabel = v.count.."x"}, true, {
                            onSelected = function()
                                local countg = KeyboardInput("Nombre", "Combien voulez vous deposer ?", 30)
                                if tonumber(countg) ~= nil then
                                    TriggerServerEvent("ChestBuilder:PutItem", ChestServer[id].id, v.name, countg)
                                    RageUI.GoBack()
                                else
                                    ESX.ShowNotification("Veuillez mettre un nombre")
                                end
                            end
                        })
                    end
                end)

                RageUI.IsVisible(ChestInventory,function()
                    local weight = 0
                    for k,v in pairs(ChestServer[id].items) do
                        weight = weight + (v.weight * v.count)
                    end
                    for k,v in pairs(ChestServer[id].items) do
                        RageUI.Button(v.label, "Poids unitaire : "..v.weight.." KG", {RightLabel = v.count.."x"}, true, {
                            onSelected = function()
                                local countg = KeyboardInput("Nombre", "Combien voulez vous retirer ?", 30)
                                if tonumber(countg) ~= nil then
                                    TriggerServerEvent("ChestBuilder:TakeItem", ChestServer[id].id, v.name, countg)
                                    RageUI.GoBack()
                                else
                                    ESX.ShowNotification("Veuillez mettre un nombre")
                                end
                                
                            end
                        })
                    end
                end)
                Wait(1)
            end
        end)
    end
end


-- CreateThread(function()
--     while true do
--         local tc = 700
--         local pos = GetEntityCoords(PlayerPedId())
--         for k,v in pairs(ChestServer) do
--             local posb = vector3(v.pos.x,v.pos.y,v.pos.z)
--             local dif = #(pos - posb)
--             if dif < 7 then
--                 if v.job == ESX.PlayerData.job.name then
--                     tc = 1
--                     ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
--                     Marker(posb.x,posb.y,posb.z)
--                     if IsControlJustPressed(0, 38) then
--                         currentmoney = v.money
--                         currentbmoney = v.bmoney
--                         OpenChestMenu(k)
--                     end
--                 end
--             end
--         end
--         Wait(tc)
--     end
-- end)

CreateThread(function()
    while not ESX do 
		Wait(1)
	end
    while true do
        local isProche = false
        for k, v in pairs(ChestServer) do
            if v.job == ESX.PlayerData.job.name then
                local myCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist2(myCoords, v.pos.x,v.pos.y,v.pos.z)
                if dist < 12 then
                    isProche = true
                    DrawMarker(2, v.pos.x,v.pos.y,v.pos.z - 0.4, 0, 0, 0, 180, nil, nil, 0.2, 0.2, 0.2, 45,110,185, 270, 0, 1, 0, 0, nil, nil, 0)
                end

                if dist < 8 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
                    if IsControlJustPressed(1, 51) then
                        currentmoney = v.money
                        currentbmoney = v.bmoney
                        OpenChestMenu(k)
                    end
                end
            end
        end


        if isProche then
            Wait(0)
        else
            Wait(1000)
        end
    end
end)