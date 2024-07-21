---@type GameObject
GameObject = Class.new(function(class)

    ---@class GameObject: BaseObject
    local self = class;

    ---@param objectHash number | string
    ---@param coords table | vector3
    ---@param callback fun(obj: number)
    function self:Spawn(objectHash, coords, callback)
        local model = type(objectHash) == 'number' and objectHash or GetHashKey(objectHash);
        local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z);
        CreateThread(function()
            Game.Streaming:RequestModel(model);
            local obj = CreateObject(model, vector.xyz, false, false, true)
            if (callback) then
                callback(obj);
            end
        end);
    end

    return self;
end);