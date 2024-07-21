-- Author : Morow
-- Github : https://github.com/Morow73

Object = {}
Object.__index = Object

setmetatable(Object, {
    __call = function(cls, m, p)
        self = Object.new(m, p)
        return self
    end
})

function ApplyBallParams(entity)
    SetEntityLoadCollisionFlag(entity, true)
    SetEntityCollision(entity, true, true)
    SetEntityRecordsCollisions(entity, true)
    SetEntityHasGravity(entity, true)
    FreezeEntityPosition(entity, true)
    SetEntityHeading(entity, 0.0)
    SetEntityMaxSpeed(entity, 10.0)
    PlaceObjectOnGroundProperly(entity)
end

function Object.new(model, position)
    local self = setmetatable({}, Object)
    local model = model
    local hash = GetHashKey(model)

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(1)
    end

    self.object = CreateObject(hash, position, true, false, false)

    return self
end

function Object:getPosition()
    return GetEntityCoords(self.object)
end

function Object:setPosition(position)
    SetEntityCoords(self.object, position, false, false, false, false)
end

function Object:setHeading(h)
    SetEntityHeading(self.object, h)
end

function Object:delete()
    DeleteObject(self.object)
    self = nil
    return self
end