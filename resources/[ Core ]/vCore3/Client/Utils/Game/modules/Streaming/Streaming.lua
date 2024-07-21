--[[
----
----Created Date: 2:26 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Streaming]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@type GameStreaming
GameStreaming = Class.new(function(class) 

    ---@class GameStreaming: BaseObject
    local self = class;

    function self:Constructor()
        Shared:Initialized("Game.Streaming");
    end

    ---@param modelHash number | string
    ---@param callback function
    function self:RequestModel(modelHash)

        modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash));

        if (not IsModelInCdimage(modelHash)) then
            return false;
        end

        RequestModel(modelHash);
        while not HasModelLoaded(modelHash) do
            Wait(0);
        end

        return true;

    end

    ---@param textureDict string
    ---@param callback function
    function self:RequestStreamedTextureDict(textureDict, callback)
        if (not HasStreamedTextureDictLoaded(textureDict)) then
            RequestStreamedTextureDict(textureDict);
    
            while (not HasStreamedTextureDictLoaded(textureDict)) do
                Wait(0);
            end
        end
    
        if (callback) then
            callback();
        end
    end

    ---@param assetName string
    ---@param callback function
    function self:RequestNamedPtfxAsset(assetName, callback)
        if (not HasNamedPtfxAssetLoaded(assetName)) then
            RequestNamedPtfxAsset(assetName);
    
            while (not HasNamedPtfxAssetLoaded(assetName)) do
                Wait(0);
            end
        end
    
        if (callback) then
            callback();
        end
    end
    
    ---@param assetName string
    ---@param callback function
    function self:RequestAnimSet(animSet, callback)
        if (not HasAnimSetLoaded(animSet)) then
            RequestAnimSet(animSet);
    
            while (not HasAnimSetLoaded(animSet)) do
                Wait(0);
            end
        end
    
        if (callback) then
            callback();
        end
    end

    ---@param animDict string
    ---@param callback function
    function self:RequestAnimDict(animDict, callback)
        if (not HasAnimDictLoaded(animDict)) then
            RequestAnimDict(animDict);
    
            while (not HasAnimDictLoaded(animDict)) do
                Wait(0);
            end
        end
    
        if (callback) then
            callback();
        end
    end

    ---@param weaponHash number | string
    ---@param callback function
    function self:RequestWeaponAsset(weaponHash, callback)
        if (not HasWeaponAssetLoaded(weaponHash)) then
            RequestWeaponAsset(weaponHash);
    
            while (not HasWeaponAssetLoaded(weaponHash)) do
                Wait(0);
            end
        end
    
        if (callback) then
            callback();
        end
    end

    return self;
end);