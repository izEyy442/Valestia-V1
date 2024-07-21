local riiick = Riiick:new()

dj_yacht = RageUI.CreateMenu(" ", "Yacht Platine");


dj_yacht:isVisible(function(items)
    items:Button("Choix d'une musique", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true,{
        onSelected = function() 
            local dialog = ShowInput({
                header = "Choix d'une musique",
                submitText = "Lancer",
                inputs = {
                    {
                        text = "URL", -- text you want to be displayed as a place holder
                        name = "lienytb", -- name of the input should be unique otherwise it might override
                        type = "text", -- type of the input
                        isRequired = false, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                    },
                },
            })
            if dialog ~= nil then
                for _,v in pairs(dialog) do
                    TriggerServerEvent('Riiick:playMusic', v)
                end
            else
                ESX.ShowNotification("Lien incorrecte !")
            end
        end
    });
    items:Button("Mettre en pause la musique", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true,{
        onSelected = function() 
            TriggerServerEvent('Riiick:pauseMusic')
        end
    });
    items:Button("Remettre la musique", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true,{
        onSelected = function() 
            TriggerServerEvent('Riiick:resumeMusic')
        end
    });
    items:Button("Changer le volume", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true,{
        onSelected = function() 
            vol = riiick:KeyboardInput("Volume 0.01 - 1", "0.1", 100)
            if vol then
                TriggerServerEvent('Riiick:changeVolume', vol)
            end
        end
    });
    items:Button("Arrêter la musique", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true,{
        onSelected = function() 
            TriggerServerEvent('Riiick:stopMusic')
        end
    });
end);