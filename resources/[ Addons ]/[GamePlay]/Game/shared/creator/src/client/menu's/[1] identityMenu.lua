function _Client.open:identityMenu()
    local identityMenu = RageUIClothes.CreateMenu("", __["put_your_info"])
    identityMenu.Closable = false;

    RageUIClothes.Visible(identityMenu, (not RageUIClothes.Visible(identityMenu)))
    FreezeEntityPosition(PlayerPedId(), true)

    while identityMenu do
        Wait(0)

        RageUIClothes.IsVisible(identityMenu, function()
            -- RageUIClothes.Line()
            RageUIClothes.Button(("%s"..__["firstname"]):format(arrow), nil, { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = playerIdentity.firstname }, true, {
                onSelected = function()
                    local firstname = UtilsCreator:input("Veuillez indiquer votre prénom (ex : Chris) :", "", 20)
                    if firstname ~= nil and firstname ~= "" and firstname ~= __["undefinited"] and not tonumber(firstname) then
                        playerIdentity.firstname = firstname
                    else
                        ESX.ShowNotification("Il semblerait que vous n\'ayez pas entrer de prénom.")
                    end
                end
            })
            if playerIdentity.firstname ~= __["undefinited"] then
                RageUIClothes.Button(("%s"..__["name"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = playerIdentity.name}, true, {
                    onSelected = function()
                        local name = UtilsCreator:input("Veuillez indiquer votre nom (ex : Wallace) :", "", 20)
                        if name ~= nil and name ~= "" and name ~= __["undefinited"] and not tonumber(name) then
                            playerIdentity.name = name
                        else
                            ESX.ShowNotification("Il semblerait que vous n\'ayez pas entrer de nom")
                        end
                    end
                })
            else
                RageUIClothes.Button(("%s"..__["name"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = playerIdentity.name}, false, {})
            end
            if playerIdentity.firstname ~= __["undefinited"] and playerIdentity.name ~= __["undefinited"] then
                RageUIClothes.Button(("%s"..__["height"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = playerIdentity.height}, true, {
                    onSelected = function()
                        local height = UtilsCreator:input("Veuillez indiquer votre taille (ex : 195) :", "", 20)
                        if height ~= nil and height ~= "" and height ~= __["undefinited"] and tonumber(height) ~= nil then
                            playerIdentity.height = height
                        else
                            ESX.ShowNotification("Il semblerait que vous n'ayez pas entrer de taille. Assurez vous qu'il s'agisse bel et bien d'un nombre")
                        end
                    end
                })
            else
                RageUIClothes.Button(("%s"..__["height"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = playerIdentity.height}, false, {})
            end
            if playerIdentity.firstname ~= __["undefinited"] and playerIdentity.name ~= __["undefinited"] and playerIdentity.height ~= __["undefinited"] then
                RageUIClothes.Button(("%s"..__["date_of_birth"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = playerIdentity.birthday}, true, {
                    onSelected = function()
                        local birthday = UtilsCreator:input("Veuillez indiquer votre date de naissance (ex : 09/02/2002) :", "", 20)
                        if UtilsCreator:IsDateCorrect(birthday) and birthday ~= __["undefinited"] then
                            playerIdentity.birthday = birthday
                        else
                            ESX.ShowNotification("Il semblerait que vous n'ayez pas entrer de date de naissance. Assurez vous qu'il s'agisse bel et bien d'un nombre")
                        end
                    end
                })
            else
                RageUIClothes.Button(("%s"..__["date_of_birth"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = playerIdentity.birthday}, false, {})
            end
            if playerIdentity.firstname ~= __["undefinited"] and playerIdentity.name ~= __["undefinited"] and playerIdentity.height ~= __["undefinited"] and playerIdentity.birthday ~= __["undefinited"] then
                RageUIClothes.Button(("%s"..__["sex"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = playerIdentity.sex}, true, {
                    onSelected = function()
                        local sex = UtilsCreator:input("Veuillez indiquer votre sexe (ex : h ou f) :", "", 20)
                        if sex == "h" or sex == "f" then
                            playerIdentity.sex = sex
                        else
                            ESX.ShowNotification("Il semblerait que vous n\'ayez pas entrer votre sexe. Assurez vous que ce soit bel et bien h ou f.")
                            sex = __["undefinited"]
                        end
                    end
                })
            else
                RageUIClothes.Button(("%s"..__["sex"]):format(arrow), nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = playerIdentity.sex}, false, {})
            end
            if playerIdentity.firstname ~= __["undefinited"] and playerIdentity.name ~= __["undefinited"] and playerIdentity.height ~= __["undefinited"] and playerIdentity.birthday ~= __["undefinited"] and playerIdentity.sex ~= __["undefinited"] then
                RageUIClothes.Button(__["valid_&_continue"], __["advert_continue"], {LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUIClothes.BadgeStyle.Tick}, true, {
                    onSelected = function()
                        ESX.ShowNotification("Votre identité a été enregistrée avec succès.")
                        TriggerEvent(_Prefix..':saveSkin')
                        local posPlayer = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent(_Prefix..':identity:setIdentity', playerIdentity, posPlayer)
                        UtilsCreator:goCloak()
                    end
                })
            else
                RageUIClothes.Button(__["valid_&_continue"], __["not_filled"], {LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUIClothes.BadgeStyle.Tick}, false, {})
            end
        end)

        if not RageUIClothes.Visible(identityMenu) then
            identityMenu = RMenuClothes:DeleteType("identityMenu", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end