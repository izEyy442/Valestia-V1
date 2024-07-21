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

function NewBlip(sprite, color, scale, pos, name)
    local NewBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(NewBlip, sprite)
    SetBlipColour(NewBlip, color)
    SetBlipScale(NewBlip, scale)
    SetBlipAsShortRange(NewBlip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(name)
    EndTextCommandSetBlipName(NewBlip)
end

NewBlip(109, 0, 0.6, Config.locate_club, "[Activité] Minigolf")

Game = {}
Game.data = {}
Game.__index = Game

local firstInit, total_stroke, inGame = true, 0, false
allGame = {}
c, s = nil, nil

setmetatable(Game, {
    __call = function(cls, index)
        self = Game.new(index)
        return self
    end
})

function Game.new(hole)
    local self = setmetatable({}, Game)

    self.hole = hole
    self.stroke = 0
    self.ped = assert(PlayerPedId)

    self.ball = Object('prop_golf_ball', Config.golf_track[self.hole].start)
    self.club = Object('prop_golf_putter_01', Utils:getEntityCoords(self.ped()))

    ApplyBallParams(self.ball.object)
    AttachEntityToEntity(self.club.object, self.ped(), GetPedBoneIndex(self.ped(), 28422), 0, 0, 0, 0.0, 0.0, 0.0, false, false, false, true, 0, true)

    return self
end

function Game:addStroke()
    local hasMaxStroke = false

    if self.stroke + 1 >= Config.max_stroke + 1 then
        self.stroke, hasMaxStroke = Config.max_stroke, true
    else
        self.stroke = self.stroke + 1
    end

    for key, value in pairs(allGame) do
        if rawequal(value.hole, self.hole) then
            value.stroke = self.stroke
            break
        end
    end

    if hasMaxStroke then
        DrawLineActive, self.ball, self.club = false, self.ball:delete(), self.club:delete()

        -- Ui:displayNotification(translation["max_stroke"])
        ESX.ShowNotification(translation["max_stroke"])

        Utils:freezeEntity(c.ped(), false)
        ClearPedTasksImmediately(c.ped())

        if self.hole + 1 < #Config.golf_track then
            self.hole = self.hole + 1
            TriggerEvent("mrw_minigolf:st_game", self.hole)
        else
            total_stroke = total_stroke + self.stroke

            CreateThread(DisplayScaleform)
            s:addContent(translation["congrats"], ("%s %s %s"):format(translation["finish_game"], total_stroke, translation["stroke"]))

            SetTimeout(2500, function()
                TriggerEvent("mrw_minigolf:cut_game")
            end)
        end

        self, inGame = nil, false
    end

    return hasMaxStroke
end

function Game:shoot()

    Utils:setEntityHeading(self.ball.object, 0.0)

    local coords = Utils:getEntityCoords(self.ped())
    local power = getPower()
    local cam = camPosition()
    local offset = GetOffsetFromEntityGivenWorldCoords(self.ball.object, cam.x, cam.y, cam.z)

    Utils:playAnimation("mini@golfai", "iron_swing_action", {coords.x - 0.6, coords.y + 0.2, coords.z}, 5000, 0)

    SetTimeout(500, function()
        Utils:playSoundFromEntity("GOLF_SWING_FAIRWAY_IRON_LIGHT_MASTER")

        FreezeEntityPosition(self.ball.object, false)
        SetEntityVelocity(self.ball.object, offset.x * power, offset.y * power, -0.1)
        ApplyForceToEntity(self.ball.object, 0, offset.x, offset.y, 0.0, 0.0, 0.0, 0.0, 0, false, false, false, false, true)

        Utils:createCamera()

        while true do Wait(100)
            if power > 0.00 then
                power = power - 0.01
            else
                local speed = GetEntitySpeed(self.ball.object)

                if speed < 1.0 then
                    SetEntityVelocity(self.ball.object, 0.0, 0.0, 0.0)
                    FreezeEntityPosition(self.ball.object, true)

                    local material = Utils:groundMaterial()
                    local objectAtCoords = DoesObjectOfTypeExistAtCoords(Config.golf_track[self.hole].hole, 0.1, `prop_golf_ball`, false)

                    Utils:deleteCamera()

                    if objectAtCoords then
                        self:finishGame()
                        return
                    elseif not material then
                        self:out()
                        return
                    else
                        self:reroll()
                        return
                    end
                end
            end
        end
    end)
end

function Game:finishGame()
    CreateThread(DisplayScaleform)

    total_stroke, DrawLineActive, self.ball, self.club = total_stroke + self.stroke, false, self.ball:delete(), self.club:delete()

    --print('Total stroke :', total_stroke)

    if self.hole == #Config.golf_track then
        s:addContent(translation["congrats"], ("%s %s %s"):format(translation["finish_game"], total_stroke, translation["stroke"]))

        SetTimeout(2500, function()
            TriggerEvent("mrw_minigolf:cut_game")
            self = nil
        end)
    else
        self.hole = self.hole + 1

        s:addContent(translation["congrats"], ("%s %s %s"):format(translation["round_win"], self.stroke, translation["stroke"]))

        SetTimeout(2500, function()
            Utils:freezeEntity(self.ped(), false)
            TriggerEvent("mrw_minigolf:st_game", self.hole)
            self = nil
        end)
    end
end

function Game:out()
    -- Ui:displayNotification(translation['off_side'])
    ESX.ShowNotification(translation['off_side'])
    DrawLineActive = false
    
    self:returnToStart()
end

function Game:reroll()
    local hole = Config.golf_track[self.hole].hole
    local coords = self.ball:getPosition()
    local nx, ny = coords.x - hole.x, coords.y - hole.y
    local angle = Utils:deg(nx, ny)

    Ui:fadeOut(500)

    SetTimeout(1000, function()
        setCurrentPosition(coords)
        Utils:placePed(angle)
        Utils:playAnimation("mini@golfai", "wedge_idle_a", {}, -1, 1)
        Utils:freezeEntity(c.ped(), true)
        Ui:fadeIn()

        CreateThread(DisplayDrawLine)
        CreateThread(ProcessThread)
    end)
end

function Game:returnToStart()
    local data = Config.golf_track[self.hole]

    Ui:fadeOut(500)

    Wait(500)

    Utils:freezeEntity(self.ped(), false)
    Utils:freezeEntity(self.ball.object, false)

    setCurrentPosition(data.start)

    self.ball:setPosition(data.start)
    self.ball:setHeading(0.0)
    PlaceObjectOnGroundProperly(self.ball.object)

    Utils:placePed(data.heading)

    SetTimeout(2000, function()

        Utils:playAnimation("mini@golfai", "wedge_idle_a", {}, -1, 1)
        Utils:freezeEntity(self.ped(), true)
        Utils:freezeEntity(self.ball.object, true)

        Ui:fadeIn()

        CreateThread(DisplayDrawLine)
        CreateThread(ProcessThread)
    end)
end

function Game:quit()
    -- Ui:displayNotification(translation['quit'])
    ESX.ShowNotification(translation['quit'])
    Utils:freezeEntity(c.ped(), false)
    ClearPedTasksImmediately(c.ped())
    TriggerEvent("mrw_minigolf:cut_game")
    self = nil
end

RegisterNetEvent("mrw_minigolf:st_game")
AddEventHandler("mrw_minigolf:st_game", function(index)
    local data = Config.golf_track[index]

    if firstInit then
        RequestScriptAudioBank("GOLF_I", 0)
        s = Scaleform()

        for i = 1, #Config.golf_track, 1 do
            table.insert(allGame, {hole = i, stroke = 0})
        end

        firstInit = false
    end

    setCurrentPosition(data.start)

    Ui:fadeOut(500)

    c = Game(index)
    
    Wait(500)

    Utils:placePed(data.heading)

    SetTimeout(2000, function()
        Utils:playAnimation("mini@golfai", "wedge_idle_a", {}, -1, 1)
        Utils:freezeEntity(c.ped(), true)
        Ui:fadeIn()

        CreateThread(DisplayDrawLine)
        CreateThread(ProcessThread)
    end)

    inGame = true
end)

RegisterNetEvent("mrw_minigolf:cut_game")
AddEventHandler("mrw_minigolf:cut_game", function()
    ScaleformActive, DrawLineActive = false, false

    Wait(1)

    s:destruct()

    if c.ball and c.club then
        c.ball, c.club = c.ball:delete(), c.club:delete()
    end

    total_stroke, inGame, firstInit, allGame, c, s = 0, false, true, {}, nil, nil
    
    local ped = PlayerPedId()

    DetachEntity(ped, true, true)
    FreezeEntityPosition(ped, false)
    ClearPedTasksImmediately(ped)
end)

AddEventHandler("onResourceStop", function(name)
    if GetCurrentResourceName() == name then
        if c then
            c.ball = c.ball:delete()
            c.club = c.club:delete()
            c = nil
        end

        if s then
            s:destruct()
            s = nil
        end

        if inGame then
            local ped = PlayerPedId()

            DetachEntity(ped, true, true)
            FreezeEntityPosition(ped, false)
            ClearPedTasksImmediately(ped)

            if IsScreenFadedOut() then
                DoScreenFadeIn(100)
            end
        end
    end
end)

--[[
RegisterCommand('st-golf', function(s,a)
    TriggerEvent('mrw_minigolf:st_game', 1)
end)
]]