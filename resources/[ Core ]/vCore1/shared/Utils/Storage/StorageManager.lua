---@type StorageManager
StorageManager = Class.new(function(class) 

    ---@class StorageManager: BaseObject
    local self = class;

    function self:Constructor()
        self.data = {};
    end

    ---@param name string
    ---@param data table | nil
    ---@return Storage
    function self:Register(name, data)
        self.data[name] = Storage(name, data);
        return self.data[name];
    end

    ---@param name string
    ---@return Storage
    function self:Get(name)
        return self.data[name];
    end

    return self;
end);