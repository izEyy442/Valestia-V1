
function Inventaire:ApplyClothes(tenue)
    local clothes = tenue 
    Inventaire:startAnimAction('clothingtie', 'try_tie_neutral_a')
    Wait(1000)
    ClearPedTasks(PlayerPedId())  

    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadClothes', skin, json.decode(clothes))
    end)
    -- -- save la tenue 
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent(Config.Trigger['saveSkin'], skin)
    end)
end


RegisterNUICallback("removeClothes",function(data)
    index = data.component
    TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
        TriggerEvent("skinchanger:getSkin", function(skina)
            if Config.Clothes[index] then 
                if skin[index .. '_1'] ~= skina[index .. '_1'] then
                    if index == 'torso' then

                        TriggerEvent("skinchanger:loadClothes", skina, { 
                            ["torso_1"] = skin.torso_1, ["torso_2"] = skin.torso_2, 
                            ["tshirt_1"] = skin.tshirt_1, ["tshirt_2"] = skin.tshirt_2, 
                            ["arms"] = skin.arms 
                        })

                    else
                        TriggerEvent("skinchanger:loadClothes", skina, { [index .. '_1'] = skin[index .. '_1'], [index .. '_2'] = skin[index .. '_2'] })
                    end
                else
                    if index == 'torso' then
                        TriggerEvent("skinchanger:loadClothes", skina, { [index .. '_1'] = Config.Clothes[index][skin.sex][index .. '_1'], [index .. '_2'] =  Config.Clothes[index][skin.sex][index .. '_2'],
                            ['tshirt_1'] = Config.Clothes['tshirt'][skin.sex]['tshirt_1'], ['tshirt_2'] =  Config.Clothes['tshirt'][skin.sex]['tshirt_2'],
                            ['arms'] = Config.Clothes['arms'][skin.sex]['arms_1'], ['arms_2'] = Config.Clothes['arms'][skin.sex]['arms_2'],
                        })
                    else
                        TriggerEvent("skinchanger:loadClothes", skina, { [index .. '_1'] = Config.Clothes[index][skin.sex][index .. '_1'], [index .. '_2'] =  Config.Clothes[index][skin.sex][index .. '_2'] })
                    end
                end
                RefreshPedScreen()
            end
        end)
    end)

end)


exports('addClothes', function(type, name, data)
    TriggerServerEvent('lgd_inv:addCloth', type, name, data)
end)

