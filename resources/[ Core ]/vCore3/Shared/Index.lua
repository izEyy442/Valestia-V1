--
--Created Date: 15:44 11/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Index]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

local random = math.random;
Enums = {};

---vCore3 resource main table (Client, Server, Shared) Made for Valestia
JG = {};

---@type Shared
Shared = Class.new(function(class)

    ---@class Shared: BaseObject
    local self = class;

    function self:Constructor()

        self.colors = {
            blue = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~",
            purple = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~",
            yellow = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~",
            green = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~",
            red = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~",
            black = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~",
            orange = "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"
        };

        self.Lang = Lang();
        self.Log = Log();

        self:LoadESX();

        self.Math = Math();
        self.String = String();
        self.Storage = StorageManager();
        self.Table = Table();
        self.Vehicle = UVehicle();
        self.Timer = Timer;
        self.Events = NetworkEvents();
        self.Commands = {}

        self:Initialized("Shared");
    end

    function self:LoadESX()
        ESX = exports["Framework"]:getSharedObject();

        if (ESX) then

            self.Log:Success("ESX loaded.");
            SetTimeout(1000, function()
                TriggerEvent("vCore3:esx:loaded");
            end);

        else

            self.Log:Error("ESX not loaded. Aborting.");
            self:Shutdown();

        end

    end

    ---Close the server
    function self:Shutdown()
        if (IsDuplicityVersion()) then

            SetTimeout(200, os.exit);
            self.Log:Info("Shutting down...");

        end
    end

    ---@Crédits go to https://gist.github.com/jrus
    ---@param template string ex: '4xxx-yxxx'
    ---@return string
    function self:Uuid(template)
        local temp = template or 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
        return string.gsub(temp, '[xy]', function (c)
            local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
            return string.format('%x', v)
        end)
    end

    ---@param ObjectName string
    function self:Initialized(ObjectName)
        return self.Log:Debug(string.format("^7[ ^6%s ^7]^0 initialized.", ObjectName));
    end

    ---Client function
    ---@param textEntry string
    ---@param maxLength number
    ---@param text string
    ---@param text2 string
    ---@param text3 string
    ---@param text4 string
    function self:KeyboardInput(textEntry, maxLenght, text, text2, text3, text4)
        AddTextEntry('FMMC_KEY_TIP1', textEntry)
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", textEntry, "", "", "", "", maxLenght)

        while (UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2) do
            DisableAllControlActions(0);
            Wait(0);
        end

        if (UpdateOnscreenKeyboard() ~= 2) then
            local result = GetOnscreenKeyboardResult();
            Wait(500);
            return result;
        else
            Wait(500);
            return nil;
        end
    end

    ---@param input string
    ---@param inputType "string" | "number" | "boolean"
    function self:InputIsValid(input, inputType)
        if (input and input ~= "") then
            if (inputType == "string") then
                return true;
            elseif (inputType == "number") then
                if (tonumber(input) and (input):match("^%-?%d+$")) then
                    return true;
                end
            elseif (inputType == "boolean") then
                if (
                    input == "1"
                        or input == "0"
                        or input == "true"
                        or input == "false"
                ) then
                    return true;
                end
            end
        end
    end

    ---@return table
    function self:GetCommands()
        return self.Commands
    end

    ---@param commandName string
    ---@param callback fun(xPlayer: xPlayer, args: table)
    ---@param adminOnly table
    function self:RegisterCommand(commandName, callback, suggestion, adminOnly)

        if type(suggestion) == "table" then
            if type(suggestion.params) ~= "table" then
                suggestion.params = {}
            end

            if type(suggestion.help) ~= "string" then
                suggestion.help = ""
            end

            table.insert(self.Commands, {name = ("/%s"):format(commandName:lower()), help = suggestion.help, params = suggestion.params})
        end

        return RegisterCommand(commandName, function(source, args)
            if (IsDuplicityVersion()) then

                local playerId = source;
                local Player = ESX.GetPlayerFromId(playerId);

                if (playerId ~= 0 and Player == nil) then
                    return;
                end
                
                if (Player ~= nil and (type(adminOnly) == "table" or type(adminOnly) == "boolean")) then

                    if (not JG.AdminManager:PlayerIsStaff(Player)) then
                        return
                    end

                    if (type(adminOnly) ~= "boolean" and adminOnly.inMode ~= nil and not JG.AdminManager:StaffGetValue(Player.source, "state")) then
                        return Player.showNotification("Veuillez activer votre ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~mode Staff~s~.")
                    elseif (type(adminOnly) ~= "boolean" and adminOnly.group ~= nil and Player.getGroup() ~= adminOnly.group and not JG.AdminManager:GroupIsHigher(Player.getGroup(), adminOnly.group, adminOnly.group_equal)) then
                        return Player.showNotification("Vous n'avez pas le grade nécessaire pour cette commande.")
                    elseif (type(adminOnly) ~= "boolean" and adminOnly.permission ~= nil and not JG.AdminManager:GroupHasPermission(Player.getGroup(), adminOnly.permission)) then
                        return Player.showNotification("Vous n'avez pas la permission nécessaire pour cette commande.")
                    end

                end

                if (callback) then callback(Player, args); end

            else
                if (callback) then callback(args); end
            end
        end, false);

    end

    ---@param commandName string
    ---@param description table label: string, args: any
    ---@param defaultKey string
    ---@param callback fun(args: table)
    function self:RegisterKeyMapping(commandName, description, defaultKey, callback)
        description = type(description) == "table" and description or { label = "No label set" };
        if (not IsDuplicityVersion()) then
            self:RegisterCommand(commandName, callback);
            RegisterKeyMapping(commandName, self.Lang:Translate(description.label, description.args and table.unpack(description.args)), "keyboard", defaultKey);
        else
            self.Log:error("Shared:RegisterKeyMapping(): This method is client only.");
        end
    end

    ---Get user defined server color
    ---@return string
    function self:ServerColor()
        return self.colors[Config["ServerColor"]] or "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~";
    end

    ---@return boolean
    function self:IsJob2Enabled()
        return Config["Job2Enabled"];
    end

    ---@param var any
    ---@return boolean
    function self:IsString(var)
        return type(var) == "string"
    end

    ---@param var any
    ---@return boolean
    function self:IsNumber(var)
        return type(var) == "number"
    end

    ---@param var any
    ---@return boolean
    function self:IsBoolean(var)
        return type(var) == "boolean"
    end

    ---@param weaponName string
    ---@return boolean
    function self:IsWeaponPermanent(weaponName)

        local config = Config["Weapons"]["PERMANENT_WEAPONS"];

        for i = 1, #config do

            if (string.upper(config[i]) == string.upper(weaponName)) then
                return true;
            end

        end

        return false;

    end

    ---@param weaponName string
    ---@return string | nil
    function self:GetWeaponType(weaponName)

        for weaponType, weaponList in pairs(Enums.Weapons.ByType) do

            for wName, _ in pairs(weaponList) do

                if (string.upper(wName) == string.upper(weaponName)) then
                    return weaponType;
                end

            end

        end

        return nil;

    end

    ---@param filePath string | table
    function self:Require(filePath)

        if (filePath) then

            if (type(filePath) == "table") then
                
                for i = 1, #filePath do
                    
                    if (filePath[i] and filePath[i]["Path"] and filePath[i]["File"]) then
    
                        self:Require(filePath[i]["Path"], filePath[i]["File"]);
    
                    end
    
                end

            elseif (type(filePath) == "string") then

                local file = LoadResourceFile("vCore3", filePath);

                local func, err = load(file);

                if (func) then

                    local success, pcallErr = pcall(func);
                    
                    if (not success) then

                        self.Log:Error(("Error while loading file: ^4%s^0, Error informations: ^1%s^0"):format(filePath, pcallErr));
                        
                    end

                else

                    self.Log:Error(("Error while loading file: ^4%s^0, Error informations: ^1%s^0"):format(filePath, err));
                    
                end


            end

        end

    end


    return self;

end)();
