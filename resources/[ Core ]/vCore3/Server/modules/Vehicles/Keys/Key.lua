--[[
----
----Created Date: 8:40 Friday October 14th 2022
----Author: vCore3
----Made with ❤
----
----File: [Key]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

VehicleKey = Class.extends(Key, function(class) 

    ---@class VehicleKey: Key
    local self = class;

    function self:Constructor(owner, keyId, handle)
        self.handle = handle;
        self:super(owner, keyId);
    end

    ---@param handle number
    function self:AddHandle(handle)
        self.handle = handle;
    end

    ---Remove vehicle associated with key
    function self:RemoveHandle()
        self.handle = nil;
    end

    ---@return number
    function self:GetHandle()
        return self.handle;
    end

    return self;
end);