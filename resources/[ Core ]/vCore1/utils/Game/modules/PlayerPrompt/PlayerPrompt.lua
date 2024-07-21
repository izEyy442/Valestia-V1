---@type PlayerPrompt
PlayerPromt = Class.new(function(class) 

    ---@class PlayerPrompt: BaseObject
    local self = class;

    ---@param senderId number
    ---@param promptMessage string
    ---@param durationInSecond number
    function self:Constructor(senderId, promptMessage, durationInSecond)

        self.sender = senderId;
        self.message = promptMessage;
        self.timer = Shared.Timer(durationInSecond);

    end

    ---@param eventName string
    function self:SetAcceptEvent(eventName, ...)

        self.acceptEvent = {

            eventName = eventName,
            args = {...}

        };

    end

    ---@param eventName string
    function self:SetCancelEvent(eventName, ...)

        self.cancelEvent = {

            eventName = eventName,
            args = {...}

        };

    end

    function self:Start()

        CreateThread(function()

            if (not Client.Player:IsBusy()) then
    
                Client.Player:SetBusy(true);

                self.timer:Start();
    
                while true do

                    if (not self.timer:HasPassed()) then

                        Game.Notification:ShowHelp(self.message, true);
        
                        if IsControlJustReleased(0, 246) then
        
                            Client.Player:SetBusy(false);
                            Shared.Events:ToServer(self.acceptEvent.eventName, self.sender, table.unpack(self.acceptEvent.args));
                            break;
        
                        end
    
                    elseif (self.timer:HasPassed()) then
    
                        Game.Notification:ShowSimple(Shared.Lang:Translate("prompt_timeout"));
                        Client.Player:SetBusy(false);
                        Shared.Events:ToServer(self.cancelEvent.eventName, self.sender, table.unpack(self.cancelEvent.args));
                        Shared.Events:ToServer(Enums.Prompt.RequestCanceled, self.sender);
                        break;
    
                    end
    
                    Wait(0);
    
                end
    
            else

                Shared.Events:ToServer(self.cancelEvent.eventName, self.sender, table.unpack(self.cancelEvent.args));
                Shared.Events:ToServer(Enums.Prompt.RequestCanceled, self.sender);

            end
    
        end);

    end

    return self;

end);