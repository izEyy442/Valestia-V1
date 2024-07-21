---@type UVehicle
UVehicle = Class.new(function(class) 

    ---@class UVehicle: BaseObject
    local self = class;

    ---@param numberPlate string
    ---@return string
    function self:ConvertPlate(numberPlate)
        local plate = numberPlate;
        if (plate) then
            if (string.find(numberPlate, " ")) then
                plate = string.gsub(numberPlate, " ", "");
            end
        end
        return plate;
    end

    ---@param networkId number
    ---@param callback fun(vehicleHandle: number)
    function self:GetByNetworkId(networkId, callback)
        CreateThread(function()
            local obj = NetworkGetEntityFromNetworkId(networkId)
            local tries = 0
            while not DoesEntityExist(obj) do
                obj = NetworkGetEntityFromNetworkId(networkId)
                Wait(0)
                tries = tries + 1
                if tries > 250 then
                    break
                end
            end
            if (callback) then callback(obj); end
        end);
    end

    return self;
end);