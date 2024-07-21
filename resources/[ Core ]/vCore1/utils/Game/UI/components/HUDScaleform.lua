--[[
----
----Created Date: 3:25 Wednesday April 12th 2023
----Author: vCore3
----Made with ❤
----
----File: [HUDScaleform]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local _DrawScaleformMovie = DrawScaleformMovie;
local _RequestScaleformMovie = RequestScaleformMovie;
local _HasScaleformMovieLoaded = HasScaleformMovieLoaded;
local _EndScaleformMovieMethod = EndScaleformMovieMethod;
local _BeginScaleformMovieMethod = BeginScaleformMovieMethod;
local _DrawScaleformMovieFullscreen = DrawScaleformMovieFullscreen;
local _ScaleformMovieMethodAddParamInt = ScaleformMovieMethodAddParamInt;
local _ScaleformMovieMethodAddParamBool = ScaleformMovieMethodAddParamBool;
local _ScaleformMovieMethodAddParamFloat = ScaleformMovieMethodAddParamFloat;
local _ScaleformMovieMethodAddParamString = ScaleformMovieMethodAddParamString;

---@type fun(): HUDScaleform
HUDScaleform = Class.new(function (class)
    
    ---@class HUDScaleform: BaseObject
    ---@field scalform number
    ---@field colors table
    ---@field settings table
    local self = class;

    ---@param scaleformName string
    ---@param settings table
    function self:Constructor(scaleformName, settings)
        assert(type(scaleformName) == "string", "HUDScaleform(): name must be a string");
        assert(type(settings) == "table", "HUDScaleform(): Settings must be a table");
        self.name = scaleformName;
        self.scalform = nil;
        self.colors = {};
        self.colors.r = 255;
        self.colors.g = 255;
        self.colors.b = 255;
        self.colors.a = 255;
        self.settings = settings
    end

    function self:HasLoaded()
        return self.scalform ~= nil and _HasScaleformMovieLoaded(self.scalform);
    end

    ---@param callback? function
    function self:Request(callback)
        CreateThread(function()
            if (not self:HasLoaded()) then
                self.scalform = _RequestScaleformMovie(self.name);
                while (not _HasScaleformMovieLoaded(self.scalform)) do
                    Wait(0);
                end
                if (callback) then callback(); end
            end
        end);
    end

    ---@param r number
    ---@param g number
    ---@param b number
    ---@param a number
    function self:SetColor(r, g, b, a)
        self.colors.r = r;
        self.colors.g = g;
        self.colors.b = b;
        self.colors.a = a;
    end

    ---@param param string
    ---@param value number|boolean|string
    ---@param callback? function
    function self:SetParam(param, value, callback)

        _BeginScaleformMovieMethod(self.scaleform, param);

        if (math.type(value) == "integer") then
            _ScaleformMovieMethodAddParamInt(value);
        elseif (type(value) == "boolean") then
            _ScaleformMovieMethodAddParamBool(value);
        elseif (math.type(value) == "float") then
            _ScaleformMovieMethodAddParamFloat(value);
        elseif (type(value) == "string") then
            _ScaleformMovieMethodAddParamTextureNameString(value);
        end

        if (callback) then callback(); end

        _EndScaleformMovieMethod();

    end

    ---@param fullscreen boolean	
    function self:Draw(fullscreen)
        
        self:Request(function()

            if (fullscreen) then

                _DrawScaleformMovieFullscreen(
                    
                    self.scalform, 
                    self.colors.r, 
                    self.colors.g, 
                    self.colors.b, 
                    self.colors.a, 
                    0

                );

            else

                local x, y = HUD.ToResolution(self.settings.x, self.settings.y);
                local width, height = HUD.ToResolution(self.settings.width, self.settings.height);    

                _DrawScaleformMovie(
                    
                    self.scalform, 
                    x,
                    y,
                    width,
                    height,
                    self.colors.r, 
                    self.colors.g, 
                    self.colors.b, 
                    self.colors.a, 
                    0

                );

            end

        end);

    end

    return self;

end);