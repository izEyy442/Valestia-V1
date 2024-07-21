local riiick = Riiick:new()

stockves_yacht = RageUI.CreateMenu(" ", "Yacht Stockage / Vestiaire");
local vessub_yacht = RageUI.CreateSubMenu(stockves_yacht," ", "Yacht Vestiaire");
local stocksub_yacht = RageUI.CreateSubMenu(stockves_yacht," ", "Yacht Stockage");
local invsub_yacht = RageUI.CreateSubMenu(stocksub_yacht," ", "Yacht Stockage");
local soutsub_yacht = RageUI.CreateSubMenu(stocksub_yacht," ", "Yacht Stockage");

local dtstock = {}

RegisterNetEvent('Riiick:setSoutInv')
AddEventHandler('Riiick:setSoutInv', function(data)
    dtstock = data
end)

stockves_yacht:isVisible(function(items)
    items:Button("Stockage", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true,{
        onSelected = function() 
        end
    }, stocksub_yacht);
    items:Button("Vestiaire", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→→"}, true,{
        onSelected = function() 
        end
    }, vessub_yacht);
end);

stocksub_yacht:isVisible(function(items)
    items:Button("Votre Inventaire", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true,{
        onSelected = function() 
        end
    }, invsub_yacht);
    items:Button("Inventaire de la soute", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true,{
        onSelected = function() 
        end
    }, soutsub_yacht);
end);

invsub_yacht:isVisible(function(items)
    ESX.PlayerData = ESX.GetPlayerData()
    for i = 1, #ESX.PlayerData.inventory, 1 do
            local invCount = {}

            for i = 1, ESX.PlayerData.inventory[i].count, 1 do
                table.insert(invCount, i)
            end
        if ESX.PlayerData.inventory[i].count > 0 then
            items:Button(""..ESX.PlayerData.inventory[i].label .. ' ~y~(' .. ESX.PlayerData.inventory[i].count .. ')~s~', nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
                onSelected = function() 
                    ItemSelected = ESX.PlayerData.inventory[i]
                    countItemm = riiick:KeyboardInput("Combien de ~y~"..ItemSelected.label.."~s~ voulez vous mettre en soute ?", "", 4)
                    if type(tonumber(countItemm)) == "number" then
                        TriggerServerEvent("Riiick:addItemStock",tonumber(countItemm),ItemSelected.name)
                    else
                        ESX.ShowNotification("~r~La saisie n'est pas un nombre !")
                    end
                end
            });
        end
    end
end);

soutsub_yacht:isVisible(function(items)
    if dtstock.items == nil then 
        items:Separator("~r~Aucun items")
    else
        for _, v in pairs(dtstock.items) do
            items:Button(v.label .. ' ~y~(' .. v.count .. ')~s~', nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
                onSelected = function() 
                    countItem = riiick:KeyboardInput("Combien de ~y~"..v.label.."~s~ voulez vous prendre en soute ?", "", 4)
                    if type(tonumber(countItem)) == "number" then
                        TriggerServerEvent("Riiick:removeItemStock",tonumber(countItem),v.name)
                    else
                        ESX.ShowNotification("~r~La saisie n'est pas un nombre !")
                    end
                end
            });
        end
    end
end)

vessub_yacht:isVisible(function(items)
    if ClothData == nil then 
        ClothRefresh()
        BLCCCCCCCCCCC = false
        items:Separator("Chargement de vos tenue en cours...")
    elseif ClothData == {} then 
        items:Separator("Aucune tenue")
    else
        for _,v in pairs(ClothData) do
            if v.type == "outfit" then
                items:Button(v.name, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
                    onSelected = function() 
                        CreateThread(function()
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerEvent('skinchanger:loadClothes', skin, json.decode(v.data))
                                Citizen.Wait(50)
                                TriggerEvent('skinchanger:getSkin', function(skin_)
                                    TriggerServerEvent('esx_skin:save', skin_)
                                end)
                            end)
                        end)
                        ESX.ShowNotification('~g~Vous avez enfilé la tenue : '..v.name)
                    end
                });
            end
        end       
    end
end)