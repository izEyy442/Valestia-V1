-- Author : Morow
-- Github : https://github.com/Morow73

local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
        Citizen.Wait(100)
    end
end)

local currentPosition, ScoreboardIsOpen, power, gameCamPosition = nil, false, 0.0, nil
DrawLineActive, ScaleformActive = false, false

function openGolfMenu()
    local golfMenu = RageUI.CreateMenu("", "Actions disponible", 0, 100, "commonmenu", "interaction_bgd")
    golfMenu:DisplayGlare(false)
    RageUI.Visible(golfMenu, not RageUI.Visible(golfMenu))
    while (golfMenu) do
        RageUI.IsVisible(golfMenu, function()
            RageUI.Button("Louer un club de golf", "Parfait pour jouer seul ou entre amis", { LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "350~g~$ ~s~→" }, true, {
                onSelected = function()
                    RageUI.CloseAll()
                    TriggerServerEvent("mrw_minigolf:locateClub")
                end
            })
        end)
        if not RageUI.Visible(golfMenu) then
            golfMenu = RMenu:DeleteType("golfMenu", true)
        end
        Wait(0)
    end
end

function setCurrentPosition(p)
    currentPosition = p
end

function getPower()
    return power
end

function camPosition()
    return gameCamPosition
end

function ZoneThread()
    while true do
        local d = 500
        local pcoords = Utils:getEntityCoords(PlayerPedId())
        local distance = #(pcoords - Config.locate_club)

        if distance <= 1.5 then
            d = 1

            DrawMarker(20, -1734.6975097656, -1135.2038574219, 13.06153678894, 0, 0, 0, 0, 0, 0, 0.25, 0.25, 0.25, 45,110,185, 255, 1, 0, 0, 2)   

            Ui:displayHelpNotification({
                translation['locate_club']
            })

            DrawMarker()

            if IsControlJustPressed(0, 38) then
                openGolfMenu()
            end
        end

        Wait(d)
    end
end

function ProcessThread()
    power, gameCamPosition = 0.0, nil

    local totalStroke = c:addStroke()

    if c.stroke > 0 then
        -- Ui:displayNotification(('%s : %s'):format(translation["play_your"], c.stroke))
        ESX.ShowNotification(('%s : %s'):format(translation["play_your"], c.stroke))
    end

    if totalStroke then return end

    while true do
        local d = 500
        local pcoords = Utils:getEntityCoords(c.ped())
        local distance = #(pcoords - currentPosition)

        if distance <= 1.5 then
            d = 1

            Ui:displayHelpNotification({
                translation["other_params"],
                translation["rotate_params"],
                translation["games_params"]
            })

            if IsControlJustPressed(0, 121) and not ScoreboardIsOpen then
                Ui:displayScoreboard(true)
                ScoreboardIsOpen = not ScoreboardIsOpen
            
            elseif IsControlJustReleased(0, 121) and ScoreboardIsOpen then
                Ui:displayScoreboard(false)
                ScoreboardIsOpen = not ScoreboardIsOpen

            elseif IsControlPressed(0, 24) and power < 1.0 then
                power = power + 0.01
                Ui:displayPowerBar(true, power)

            elseif IsControlPressed(0, 174) then
                local baseHeading = Utils:getEntityHeading(c.ped())
                
                if not IsEntityAttached(c.ped()) then
                    AttachEntityToEntity(c.ped(), c.ball.object, 20, 0.14, -0.62, 0.99, 0.0, 0.0, 0.0, false, false, false, false, 1, true)
                end
                
                Utils:setEntityHeading(c.ball.object, baseHeading + 1.0)
                DetachEntity(c.ped(), true, true)

            elseif IsControlPressed(0, 175) then
                local baseHeading = Utils:getEntityHeading(c.ped())
                
                if not IsEntityAttached(c.ped()) then
                    AttachEntityToEntity(c.ped(), c.ball.object, 20, 0.14, -0.62, 0.99, 0.0, 0.0, 0.0, false, false, false, false, 1, true)
                end

                Utils:setEntityHeading(c.ball.object, baseHeading - 1.0)
                DetachEntity(c.ped(), true, true)

            elseif IsControlJustPressed(0, 178) then
                c:quit()
                return
            elseif IsControlJustPressed(0, 82) then
                c:returnToStart()
                return
            elseif IsControlJustReleased(0, 24) then
                Ui:displayPowerBar(false, 0)
                gameCamPosition, DrawLineActive = Utils:rayCastGamePlayCamera(90.0), false
                c:shoot()
                return
            end
        end

        Wait(d)
    end
end

function DisplayDrawLine()
    if not DrawLineActive then DrawLineActive = true end

    while DrawLineActive do Wait(1)

        if c.ball == nil then
            return
        end

        local bcoords = Utils:getEntityCoords(c.ball.object)
        local direction = Utils:rayCastGamePlayCamera(50.0)

        Ui:drawLine(bcoords, direction)
    end
end

function DisplayScaleform()
    if not ScaleformActive then ScaleformActive = true end

    while ScaleformActive do Wait(1)
        s:display()
    end
end

CreateThread(ZoneThread)