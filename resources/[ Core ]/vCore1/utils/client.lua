---@type Client
Client = Class.new(function(class)

    ---@class Client: BaseObject
    local self = class;

    function self:Constructor()
        Shared:Initialized("Client");
    end

    ---@param playerData xPlayer | table
    function self:InitializePlayer(playerData)
        Shared.Log:Debug("^7[ ^6LocalPlayer ^7]^0 instanciated.");
        ---@type LocalPlayer
        self.Player = LocalPlayer(playerData);
        self.PlayersManager = CPlayersManager();
    end

    ---@param gameEventName string
    ---@param callback fun(data: table)
    function self:SubscribeToGameEvent(gameEventName, callback)

        Shared.Events:On("gameEventTriggered", function(event, data)
            if (event == gameEventName) then
                if (callback) then
                    callback(data);
                end
            end
        end);

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

                local file = LoadResourceFile("core", filePath);

                local func, err = load(file);

                if (func) then

                    local success, pcallErr = pcall(func);
                    if (not success) then

                        Shared.Log:Error(("Error while loading file: ^4%s^0, Error informations: ^1%s^0"):format(filePath, pcallErr));
                        
                    end

                else

                    Shared.Log:Error(("Error while loading file: ^4%s^0, Error informations: ^1%s^0"):format(filePath, err));
                    
                end


            end

        end

    end


    return self;

end)();
