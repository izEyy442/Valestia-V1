------------------------
-- Optional to change --
------------------------
-- variables for esx_vehicleshop
local PlateLetters = Config.PlateLetters
local PlateNumbers = Config.PlateNumbers
local PlateUseSpace = Config.PlateUseSpace

-- Taken from esx_vehicleshop for optimalization purpose.
local NumberCharset = {}
local Charset = {}

for i = 48, 57 do
    table.insert(NumberCharset, string.char(i))
end

for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

-- Taken from esx_vehicleshop for optimalization purpose.
function GetRandomNumber(length)
    Wait(0)
    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[RandomNumber(1, #NumberCharset)]
    else
        return ''
    end
end

-- Taken from esx_vehicleshop for optimalization purpose.
function GetRandomLetter(length)
    Wait(0)
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[RandomNumber(1, #Charset)]
    else
        return ''
    end
end

function GetPlateList()
    local newTable = {}

    if Config.MongoDB then
        local rows = MongoDB:Select("player_vehicles", {})
        for k, v in pairs(rows) do
            newTable[v.plate] = true
        end
    else
        local sql = "SELECT plate FROM owned_vehicles"
        if Framework.Active == 2 then
            sql = "SELECT plate FROM player_vehicles"
        end

        local data = MySQL.Sync.fetchAll(sql, {})

        for k, v in pairs(data) do
            newTable[v.plate] = true
        end
    end

    return newTable
end

-- CreateThread(function()
--    local generatedPlate = VehiclePlate().GeneratePlate()
--
--    print(generatedPlate)
-- end)

function VehiclePlate()
    local self = {}
    self.ClaimedPlates = {}
    self.hasFetched = false

    self.GeneratePlate = function()
        local plates = {}
        if not self.hasFetched then
            self.hasFetched = true
            plates = GetPlateList()
        end

        local generatedPlate
        local doBreak = false
        while true do
            Wait(0)
            if PlateUseSpace then
                generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. ' ' .. GetRandomNumber(PlateNumbers))
            else
                generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. GetRandomNumber(PlateNumbers))
            end
            if not plates[generatedPlate] and not self.ClaimedPlates[generatedPlate] then
                doBreak = true
                self.ClaimedPlates[generatedPlate] = true
            end

            if doBreak then
                break
            end
        end
        return generatedPlate
    end

    self.ResetPlateList = function()
        self.ClaimedPlates = {}
    end

    return self
end
