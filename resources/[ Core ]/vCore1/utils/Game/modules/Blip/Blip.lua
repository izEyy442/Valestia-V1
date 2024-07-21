---@type Blip[]
local Blips = {}

--AddTextEntryByHash(`BLIP_OTHPLYR`, "Farming")
--AddTextEntryByHash(`BLIP_PROPCAT`, "Entreprise")
--AddTextEntryByHash(`BLIP_APARTCAT`, "Service")

---@type Blip
Blip = Class.new(function(class) 

    ---@class Blip: BaseObject
    local self = class;

    ---https://docs.fivem.net/natives/?_0x9029B2F3DA924928
    ---Type are: service | farm | job
    ---@param name string
    ---@param data table @coords @label @sprite @color @scale @display @range @type @job @jobGrade @job2 @job2Grade
    function self:Constructor(name, data)
        self.name = name;
        self.coords = data.coords or {};
        self.sprite = data.sprite or 1;
        self.display = data.display or 2;
        self.color = data.color or 49;
        self.scale = data.scale or 0.6;
        self.range = data.range or true;
        self.label = data.label or "No Label set";
        self.type = data.type or "notype";
        self.job = data.job or "not";
        self.jobGrade = data.jobGrade or "not";
        self.job2 = data.job2 or "not";
        self.job2Grade = data.job2Grade or "not";
        self.route = false;
        self.visible = false;
    
        Blips[self.name] = self;
        return self
    end
    
    ---@return string Blip name 
    function self:GetName()
        return self.name
    end
    
    ---@return boolean 
    function self:IsVisible()
        return self.visible
    end
    
    ---@param bool boolean
    function self:SetVisible(bool)
        self.visible = bool
    end
    
    ---@param coords vector3
    function self:SetCoords(coords)
        self.coords = coords
    end
    
    ---@param toggle boolean
    function self:SetRoute(toggle)
        self.route = toggle
    end
    
    ---Show the blip in game
    function self:Show()
        if not self:IsVisible() then
            self.id = AddBlipForCoord(self.coords.x, self.coords.y, self.coords.z)
            self:SetLabel();
            SetBlipSprite(self.id, self.sprite)
            SetBlipDisplay(self.id, self.display)
            SetBlipScale(self.id, self.scale)
            SetBlipColour(self.id, self.color)
            SetBlipAsShortRange(self.id, self.range)
            BeginTextCommandSetBlipName('BLIP'..self.name)
            --AddTextComponentString(self.label)
            AddTextComponentSubstringPlayerName(self.label)
            EndTextCommandSetBlipName(self.id)
            SetBlipRoute(self.id, self.route)
            self:SetVisible(true)
        end
    end
    
    ---@return string
    function self:GetJob()
        return self.job
    end
    
    ---@return string
    function self:GetJob2()
        return self.job2
    end
    
    ---@return string
    function self:GetJobGrade()
        return self.jobGrade
    end
    
    ---@return string
    function self:GetJob2Grade()
        return self.job2Grade
    end
    
    function self:Update()
        if self:IsVisible() then
            self:Hide()
            self:Show()
        end
    end
    
    function self:SetLabel()
        --local newLabel = self.label
        if self.type == "job" then 
            --SetBlipCategory(self.id, 10)
            AddTextEntry('BLIP'..self.name, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Entreprise~c~:~s~ ~a~')
            --newLabel = ("~c~[~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ENTREPRISE~c~]~s~ %s"):format(self.label)
        elseif self.type == "farm" then 
            --SetBlipCategory(self.id, 7)
            AddTextEntry('BLIP'..self.name, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Farming~c~:~s~ ~a~')
            --newLabel = ("~c~[~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~FARM~c~]~s~ %s"):format(self.label)
        elseif self.type == "service" then 
            AddTextEntry('BLIP'..self.name, '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Service~c~:~s~ ~a~')
            --SetBlipCategory(self.id, 11)
            --newLabel = ("~c~[~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~SERVICE~c~]~s~ %s"):format(self.label)
        else
            AddTextEntry('BLIP'..self.name, '~a~')
        end
        --return newLabel
    end
    
    ---Hide blip but dont delete his data to show him later
    function self:Hide()
        if self:IsVisible() then
            RemoveBlip(self.id)
            self.id = RemoveBlip(self.id)
            self:SetVisible(false)
        end
    end
    
    ---@param color number https://docs.fivem.net/docs/game-references/blips/#classColors
    function self:SetColor(color)
        self.color = color
        SetBlipColour(self.id, color)
        self:Update()
        return self
    end
    
    ---@param sprite number https://docs.fivem.net/docs/game-references/blips/
    function self:SetSprite(sprite)
        self.sprite = sprite
        SetBlipSprite(self.id, sprite)
        self:update()
        return self
    end
    
    ---@param scale number @/!\ Scale is between 0.6 and 2.0 /!\
    function self:SetScale(scale)
        self.scale = scale
        SetBlipScale(self.id, scale)
        self:Update()
        return self
    end
    
    ---@param range boolean Sets whether or not the specified blip 
    ---should only be displayed when nearby, or on the minimap.
    function self:SetHasShortRange(range)
        self.range = range
        SetBlipAsShortRange(self.id, range)
        self:Update()
        return self
    end
    
    ---@param label string
    function self:SetNewLabel(label)
        self.label = label
        self:Update()
        return self
    end

    return self;
end);

local function refreshBlips()
    CreateThread(function()
        local player = Client.Player
        for k, _ in pairs(Blips) do
            ---@type Blip
            local blip = Blips[k]
            if player:GetJob().name == blip.job and blip.jobGrade == "not"
                    or (Shared:IsJob2Enabled()) and player:GetJob2().name == blip.job2 and blip.job2Grade == "not"
                    or player:GetJob().name == blip.job and blip.jobGrade == player:GetJob().grade_name
                    or (Shared:IsJob2Enabled()) and player:GetJob2().name == blip.job2 and blip.job2Grade == player:GetJob2().grade_name
            then
                if not blip:IsVisible() then
                    blip:Show()
                end
            elseif blip.job == "not" 
                and blip.jobGrade == "not" 
                and blip.job2 == "not" 
                and blip.job2Grade == "not" 
            then
                if not blip:IsVisible() then
                    blip:Show()
                end
            else
                if blip:IsVisible() then
                    blip:Hide()
                end
            end
        end
    end)
end

Shared.Events:On(Enums.Player.Events.updateZonesAndBlips, function()
    refreshBlips();
end);