--[[
----
----Created Date: 8:29 Friday October 14th 2022
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

---@type Key
Key = Class.new(function(class)

    ---@class Key: BaseObject
    local self = class;

    ---@param owner xPlayer
    ---@param keyId string
    function self:Constructor(owner, keyId)
        if (not owner) then self:Delete(); end
        self.defaultOwner = owner;
        self.owner = owner;
        self.id = keyId;
    end

    ---@return string
    function self:GetDefaultOwner()
        return self.defaultOwner;
    end

    ---@param xPlayer xPlayer
    function self:SetDefaultOwner(xPlayer)
        self.defaultOwner = xPlayer.getIdentifier();
    end

    ---@return string
    function self:GetOwner()
        return self.owner;
    end

    ---@param newOwner xPlayer
    ---@param notify boolean
    function self:SetOwner(newOwner, notify)
        self.owner = newOwner.getIdentifier();
        if (notify) then
            newOwner.showNotification(Shared.Lang:Translate("keys_vehicle_give", self:GetId()));
        end
    end

    ---@return string
    function self:GetId()
        return self.id;
    end

    return self;
end);