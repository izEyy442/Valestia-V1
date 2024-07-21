local TELEPORT_POINT = {
    ['LSPD Ascenseur'] = {
        POSITION = {
            vector3(-590.2600, -430.8631, 35.1796),
            vector3(-590.2604, -430.9144, 39.6403),
            vector3(-589.6138, -431.0593, 45.6353),
            vector3(-593.0043, -430.7242, 31.1727),
        },
        TextMenu = "LSPD Ascenseur",
        Action = function()
            openPoliceTeleporMenu()
        end
    },
    ['Federal Bureau Investigation Ascenseur'] = {
        POSITION = {
            vector3(2503.6215820313, -356.658203125, 82.293785095215),
            vector3(2498.7644042969, -347.99398803711, 94.092323303223),
            vector3(2498.7644042969, -347.99398803711, 101.89334869385),
            vector3(2498.7644042969, -347.99398803711, 105.69055938721),
            vector3(2514.9665527344, -337.18768310547, 118.02426147461),
        },
        TextMenu = "Federal Bureau Investigation Ascenseur",
        Action = function()
            openFIBTeleporMenu()
        end
    },
    ['Hopital Ascenseur'] = {
        POSITION = {
            vector3(-1848.5610, -340.3081, 41.2484),
            vector3(-1842.9498, -341.7955, 49.4528),
            vector3(-1839.7172, -335.0581, 53.7801),
            vector3(-1869.9181, -309.2688, 58.1604),
        },
        TextMenu = "Hopital Ascenseur",
        Action = function()
            openEmsTeleporMenu()
        end
    },
}

Citizen.CreateThread(function()
    while true do
        local isProche = false
        for k,v in pairs(TELEPORT_POINT) do
            for i,p in pairs(TELEPORT_POINT[k].POSITION) do 
                local myCoords = GetEntityCoords(PlayerPedId())
                local dist = Vdist2(myCoords, p)

                if dist < 3 then
                    isProche = true
                    ESX.ShowHelpNotification(v.TextMenu.."\n~s~Appuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                    if IsControlJustPressed(1,51) then
                        v.Action()
                    end
                end
            end
        end
        
		if isProche then
			Wait(0)
		else
			Wait(0)
		end
	end
end)

local IsNotTimer = true

function openPoliceTeleporMenu()
    local menu = RageUI.CreateMenu('', 'Etages Disponibles')

    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
                RageUI.Button('Sous Sol', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(-593.0043, -430.7242, 31.1727))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
                RageUI.Button('Accueil centrale', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(-590.2600, -430.8631, 35.1796))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
                RageUI.Button('Premier étage', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(-590.2604, -430.9144, 39.6403))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
                RageUI.Button('2eme étage', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(-589.6138, -431.0593, 45.6353))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

function openFIBTeleporMenu()
    local menu = RageUI.CreateMenu('', 'Etages Disponibles')

    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
                RageUI.Button('Sous Sol', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(2503.6215820313, -356.658203125, 82.293785095215))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })    
                RageUI.Button('Rez de Chaussée', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(2498.7644042969, -347.99398803711, 94.092323303223))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
                RageUI.Button('Premier étage', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(2498.7644042969, -347.99398803711, 101.89334869385))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
                RageUI.Button('Deuxième étage', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(2498.7644042969, -347.99398803711, 105.69055938721))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
                RageUI.Button('Helipad', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(2514.9665527344, -337.18768310547, 118.02426147461))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

function openEmsTeleporMenu()
    local menu = RageUI.CreateMenu('', 'Etages Disponibles')

    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
                RageUI.Button('Sous sol', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(-1848.5610, -340.3081, 41.2484))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
                RageUI.Button('Accueil', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(-1842.9498, -341.7955, 49.4528))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
                RageUI.Button('Premier étage', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(-1839.7172, -335.0581, 53.7801))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
                RageUI.Button('Helipad', nil, { LeftBadge = RageUI.BadgeStyle.Star }, IsNotTimer, {
                    onSelected = function()
                        IsNotTimer = false
                        SetEntityCoords(PlayerPedId(), vector3(-1869.9181, -309.2688, 58.1604))
                        Citizen.SetTimeout(1000, function()
                            IsNotTimer = true
                        end)
                    end
                })
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end