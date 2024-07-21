setFarmProduction = function()
    for i =1, #DrugsHandler.LaboData do 
        local lab = DrugsHandler.LaboData[i]
        local production = lab.production
        if lab.type == "Meth" then 
            BikerMethLab = exports['bob74_ipl']:GetBikerMethLabObject()
            if production ~= nil then 
                if production[1] == 1 then
                    BikerMethLab.Details.Enable("meth_lab_production", false)
                else
                    BikerMethLab.Details.Enable("meth_lab_production", true)
                end
            end
        elseif lab.type == "Cocaïne" then 
            BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
            if production ~= nil then 
                if production[1] == 1 then
                    BikerCocaine.Details.Enable(BikerCocaine.Details.cokeBasic1, false)
                else
                    BikerCocaine.Details.Enable(BikerCocaine.Details.cokeBasic1, true)
                end
                if production[2] == 1 then
                    BikerCocaine.Details.Enable(BikerCocaine.Details.cokeBasic2, false)
                else
                    BikerCocaine.Details.Enable(BikerCocaine.Details.cokeBasic2, true)
                end
                if production[3] == 1 then
                    BikerCocaine.Details.Enable(BikerCocaine.Details.cokeBasic3, false)
                else
                    BikerCocaine.Details.Enable(BikerCocaine.Details.cokeBasic3, true)
                end
                if lab.data.interiorStatus == "upgrade" then 
                    if production[4] ~= nil then 
                        if production[4] == 1 then
                            BikerCocaine.Details.Enable(BikerCocaine.Details.cokeUpgrade1, false)
                        else
                            BikerCocaine.Details.Enable(BikerCocaine.Details.cokeUpgrade1, true)
                        end
                    end
                    if production[5] ~= nil then 
                        if production[5] == 1 then
                            BikerCocaine.Details.Enable(BikerCocaine.Details.cokeUpgrade2, false)
                        else
                            BikerCocaine.Details.Enable(BikerCocaine.Details.cokeUpgrade2, true)
                        end
                    end
                else
                    BikerCocaine.Details.Enable(BikerCocaine.Details.cokeUpgrade1, false)
                    BikerCocaine.Details.Enable(BikerCocaine.Details.cokeUpgrade2, false)
                end
            end
        elseif lab.type == "Weed" then
            BikerWeedFarm = exports['bob74_ipl']:GetBikerWeedFarmObject()
            if production ~= nil then 
                if production[1] == 1 then
                    BikerWeedFarm.Plant1.Clear(true)
                elseif production[1] == 2 then
                    BikerWeedFarm.Plant1.Set(BikerWeedFarm.Plant1.Stage.small, BikerWeedFarm.Plant1.Light.basic)
                elseif production[1] == 3 then
                    BikerWeedFarm.Plant1.Set(BikerWeedFarm.Plant1.Stage.medium, BikerWeedFarm.Plant1.Light.basic)
                elseif production[1] == 4 then 
                    BikerWeedFarm.Plant1.Set(BikerWeedFarm.Plant1.Stage.full, BikerWeedFarm.Plant1.Light.basic)
                end
                if production[2] == 1 then
                    BikerWeedFarm.Plant2.Clear(true)
                elseif production[2] == 2 then
                    BikerWeedFarm.Plant2.Set(BikerWeedFarm.Plant2.Stage.small, BikerWeedFarm.Plant2.Light.basic)
                elseif production[2] == 3 then
                    BikerWeedFarm.Plant2.Set(BikerWeedFarm.Plant2.Stage.medium, BikerWeedFarm.Plant2.Light.basic)
                elseif production[2] == 4 then 
                    BikerWeedFarm.Plant2.Set(BikerWeedFarm.Plant2.Stage.full, BikerWeedFarm.Plant2.Light.basic)
                end
                if production[3] == 1 then
                    BikerWeedFarm.Plant3.Clear(true)
                elseif production[3] == 2 then
                    BikerWeedFarm.Plant3.Set(BikerWeedFarm.Plant3.Stage.small, BikerWeedFarm.Plant3.Light.basic)
                elseif production[3] == 3 then
                    BikerWeedFarm.Plant3.Set(BikerWeedFarm.Plant3.Stage.medium, BikerWeedFarm.Plant3.Light.basic)
                elseif production[3] == 4 then 
                    BikerWeedFarm.Plant3.Set(BikerWeedFarm.Plant3.Stage.full, BikerWeedFarm.Plant3.Light.basic)
                end
                if production[4] == 1 then
                    BikerWeedFarm.Plant4.Clear(true)
                elseif production[4] == 2 then
                    BikerWeedFarm.Plant4.Set(BikerWeedFarm.Plant4.Stage.small, BikerWeedFarm.Plant4.Light.basic)
                elseif production[4] == 3 then
                    BikerWeedFarm.Plant4.Set(BikerWeedFarm.Plant4.Stage.medium, BikerWeedFarm.Plant4.Light.basic)
                elseif production[4] == 4 then 
                    BikerWeedFarm.Plant4.Set(BikerWeedFarm.Plant4.Stage.full, BikerWeedFarm.Plant4.Light.basic)
                end
                if production[5] == 1 then
                    BikerWeedFarm.Plant5.Clear(true)
                elseif production[5] == 2 then
                    BikerWeedFarm.Plant5.Set(BikerWeedFarm.Plant5.Stage.small, BikerWeedFarm.Plant5.Light.basic)
                elseif production[5] == 3 then
                    BikerWeedFarm.Plant5.Set(BikerWeedFarm.Plant5.Stage.medium, BikerWeedFarm.Plant5.Light.basic)
                elseif production[5] == 4 then 
                    BikerWeedFarm.Plant5.Set(BikerWeedFarm.Plant5.Stage.full, BikerWeedFarm.Plant5.Light.basic)
                end
                if production[6] == 1 then
                    BikerWeedFarm.Plant6.Clear(true)
                elseif production[6] == 2 then
                    BikerWeedFarm.Plant6.Set(BikerWeedFarm.Plant6.Stage.small, BikerWeedFarm.Plant6.Light.basic)
                elseif production[6] == 3 then
                    BikerWeedFarm.Plant6.Set(BikerWeedFarm.Plant6.Stage.medium, BikerWeedFarm.Plant6.Light.basic)
                elseif production[6] == 4 then 
                    BikerWeedFarm.Plant6.Set(BikerWeedFarm.Plant6.Stage.full, BikerWeedFarm.Plant6.Light.basic)
                end
                if production[7] == 1 then
                    BikerWeedFarm.Plant7.Clear(true)
                elseif production[7] == 2 then
                    BikerWeedFarm.Plant7.Set(BikerWeedFarm.Plant7.Stage.small, BikerWeedFarm.Plant7.Light.basic)
                elseif production[7] == 3 then
                    BikerWeedFarm.Plant7.Set(BikerWeedFarm.Plant7.Stage.medium, BikerWeedFarm.Plant7.Light.basic)
                elseif production[7] == 4 then 
                    BikerWeedFarm.Plant7.Set(BikerWeedFarm.Plant7.Stage.full, BikerWeedFarm.Plant7.Light.basic)
                end
                if production[8] == 1 then
                    BikerWeedFarm.Plant8.Clear(true)
                elseif production[8] == 2 then
                    BikerWeedFarm.Plant8.Set(BikerWeedFarm.Plant8.Stage.small, BikerWeedFarm.Plant8.Light.basic)
                elseif production[8] == 3 then
                    BikerWeedFarm.Plant8.Set(BikerWeedFarm.Plant8.Stage.medium, BikerWeedFarm.Plant8.Light.basic)
                elseif production[8] == 4 then 
                    BikerWeedFarm.Plant8.Set(BikerWeedFarm.Plant8.Stage.full, BikerWeedFarm.Plant8.Light.basic)
                end
                if production[9] == 1 then
                    BikerWeedFarm.Plant9.Clear(true)
                elseif production[9] == 2 then
                    BikerWeedFarm.Plant9.Set(BikerWeedFarm.Plant9.Stage.small, BikerWeedFarm.Plant9.Light.basic)
                elseif production[9] == 3 then
                    BikerWeedFarm.Plant9.Set(BikerWeedFarm.Plant9.Stage.medium, BikerWeedFarm.Plant9.Light.basic)
                elseif production[9] == 4 then 
                    BikerWeedFarm.Plant9.Set(BikerWeedFarm.Plant9.Stage.full, BikerWeedFarm.Plant9.Light.basic)
                end
            end
        end
    end
end


