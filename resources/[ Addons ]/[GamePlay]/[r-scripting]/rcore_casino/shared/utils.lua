function Trim(value)
    if value then
        return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
    else
        return nil
    end
end

function Clamp(value, min, max)
    if value < min then
        value = min
    elseif value > max then
        value = max
    end
    return value
end

function GetHigherBetStepOf(bet)
    if bet < 50 then
        return bet + 5
    elseif bet < 100 then
        return bet + 10
    elseif bet < 500 then
        return bet + 50
    elseif bet < 1000 then
        return bet + 100
    elseif bet < 10000 then
        return bet + 1000
    elseif bet < 100000 then
        return bet + 10000
    else
        return bet + 100000
    end
end

function GetLowerBetStepOf(bet)
    if bet < 50 then
        return bet - 5
    elseif bet < 100 then
        return bet - 10
    elseif bet < 500 then
        return bet - 50
    elseif bet <= 1000 then
        return bet - 100
    elseif bet <= 10000 then
        return bet - 1000
    elseif bet <= 100000 then
        return bet - 10000
    else
        return Clamp(bet - 100000, 0, bet)
    end
end

function ReduceNumberByPercentage(n, percentage)
    local one = n / 100.0
    return math.ceil(n - (one * percentage))
end

function Shuffle(tbl)
    for i = #tbl, 1, -1 do
        local j = RandomNumber(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

function ShuffleList(list, seed)
    math.randomseed(seed or GetGameTimer())
    for i = #list, 2, -1 do
        local j = math.random(i)
        list[i], list[j] = list[j], list[i]
    end
end

function Lerp(a, b, t)
    return a + (b - a) * Clamp(t, 0, 1)
end

function LerpVector3(vector3_a, vector3_b, t)
    return vector3(Lerp(vector3_a.x, vector3_b.x, t), Lerp(vector3_a.y, vector3_b.y, t),
        Lerp(vector3_a.z, vector3_b.z, t))
end

function LerpVector3Angle(vector3_a, vector3_b, t)
    return vector3(LerpAngle(vector3_a.x, vector3_b.x, t), LerpAngle(vector3_a.y, vector3_b.y, t),
        LerpAngle(vector3_a.z, vector3_b.z, t))
end

function LerpAngle(a, b, t)
    local num = Repeat(b - a, 360.0)
    if num > 180.0 then
        num = num - 360.0
    end
    return a + num * Clamp(t, 0.0, 1.0)
end

function Repeat(t, length)
    return Clamp(t - math.floor(t / length) * length, 0.0, length)
end

-- calculates gain from betting & odds 
function GetGainFromBet(horseId, bet)
    if horseId == nil or bet == nil then
        return 0
    end
    local multiplier = horsePresets[horseId].odds
    return bet * multiplier
end

-- Roulette helpers =)
function IsNumberInArray(number, array)
    for k, v in pairs(array) do
        if v == number then
            return true
        end
    end
    return false
end

function IsRouletteIndexBetOutsideBet(index)
    local outsideBets = {39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50}
    return IsNumberInArray(index, outsideBets)
end

-- gets summary of the ticket, total betting value
function GetRouletteBetCountAndValue(ticket)
    local betCount = 0
    local betValueInside = 0
    local betValueOutside = 0
    for k, v in pairs(ticket) do
        if v ~= nil and v > 0 then
            if IsRouletteIndexBetOutsideBet(k) then
                betValueOutside = betValueOutside + v
            else
                betValueInside = betValueInside + v
            end
            betCount = betCount + 1
        end
    end
    return betCount, betValueInside, betValueOutside
end

-- helper for calculating roulette results from number

-- black
local function IsNumberBlack(number)
    return IsNumberInArray(number, {15, 4, 2, 17, 6, 13, 11, 8, 10, 24, 33, 20, 31, 22, 29, 28, 35, 26})
end
-- red
local function IsNumberRed(number)
    return IsNumberInArray(number, {32, 19, 21, 25, 34, 27, 36, 30, 23, 5, 16, 1, 14, 9, 18, 7, 12, 3})
end
-- even
local function IsNumberEven(number)
    return IsNumberInArray(number, {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36})
end
-- odd
local function IsNumberOdd(number)
    return IsNumberInArray(number, {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35})
end
-- 2 to 1
local function IsNumber2To1_1(number)
    return IsNumberInArray(number, {1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34})
end
-- 2 to 1
local function IsNumber2To1_2(number)
    return IsNumberInArray(number, {2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35})
end
-- 2 to 1
local function IsNumber2To1_3(number)
    return IsNumberInArray(number, {3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36})
end

-- 4in1s
local function IsBet4In1(bet)
    return bet >= 50 and bet <= 72
end

local function IsNumberIn4In1(number, fourInOneIndex)

    local actualIndex = 50
    local fourInOneNumbers = {2, 3, 5, 6, 5, 6, 9, 8, 8, 9, 11, 12, 11, 12, 14, 15, 14, 15, 18, 17, 18, 17, 20, 21, 20,
                              21, 23, 24, 23, 24, 26, 27, 26, 27, 29, 30, 29, 30, 32, 33, 32, 33, 35, 36, 1, 2, 4, 5, 4,
                              5, 8, 7, 8, 7, 10, 11, 10, 11, 14, 13, 14, 13, 17, 16, 17, 16, 19, 20, 19, 20, 23, 22, 23,
                              22, 25, 26, 25, 26, 29, 28, 29, 28, 32, 31, 32, 31, 34, 35}

    for x = 0, 21 do
        actualIndex = actualIndex + 1
        if actualIndex == fourInOneIndex then
            local hoverNums = {}
            local startIndex = (x * 4) + 1
            for xn = startIndex, startIndex + 3 do
                if fourInOneNumbers[xn] == number then
                    return true
                end
            end
        end
    end
    return false
end

-- calculate winnings from ticket
function CalculateRoulettePlayerWinnings(winNumber, ticket)
    local totalWinnings = 0
    for k, v in pairs(ticket) do
        if k <= 38 and winNumber == k then
            totalWinnings = totalWinnings + (v * 36)
        elseif k == 39 and IsNumberRed(winNumber) then
            totalWinnings = totalWinnings + (v * 2)
        elseif k == 40 and IsNumberBlack(winNumber) then
            totalWinnings = totalWinnings + (v * 2)
        elseif k == 41 and IsNumberEven(winNumber) then
            totalWinnings = totalWinnings + (v * 2)
        elseif k == 42 and IsNumberOdd(winNumber) then
            totalWinnings = totalWinnings + (v * 2)
        elseif k == 43 and winNumber >= 1 and winNumber <= 18 then
            totalWinnings = totalWinnings + (v * 2)
        elseif k == 44 and winNumber >= 19 and winNumber <= 36 then
            totalWinnings = totalWinnings + (v * 2)
        elseif k == 45 and winNumber >= 1 and winNumber <= 12 then
            totalWinnings = totalWinnings + (v * 3)
        elseif k == 46 and winNumber >= 13 and winNumber <= 24 then
            totalWinnings = totalWinnings + (v * 3)
        elseif k == 47 and winNumber >= 25 and winNumber <= 36 then
            totalWinnings = totalWinnings + (v * 3)
        elseif k == 48 and IsNumber2To1_1(winNumber) then
            totalWinnings = totalWinnings + (v * 3)
        elseif k == 49 and IsNumber2To1_2(winNumber) then
            totalWinnings = totalWinnings + (v * 3)
        elseif k == 50 and IsNumber2To1_3(winNumber) then
            totalWinnings = totalWinnings + (v * 3)
        elseif IsBet4In1(k) and IsNumberIn4In1(winNumber, k) then
            totalWinnings = totalWinnings + (v * 8)
        end
    end
    return totalWinnings
end

-- will dump table
--- @param node table
--- @param printing boolean
function Dump(node, printing)
    local cache, stack, output = {}, {}, {}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k, v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k, v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str, "}", output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str, "\n", output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output, output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "[" .. tostring(k) .. "]"
                else
                    key = "['" .. tostring(k) .. "']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = " .. tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = {\n"
                    table.insert(stack, node)
                    table.insert(stack, v)
                    cache[node] = cur_index + 1
                    break
                else
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = '" .. tostring(v) .. "'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output, output_str)
    output_str = table.concat(output)
    if printing then
        print(output_str)
    end
    return output_str
end
function IsActivityEnabled(activity)
    for k, v in pairs(GameStates) do
        if v.activity == activity then
            return v.enabled
        end
    end
    return true
end

--- @param table table
--- @return number
function tableLength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

string.startswith = function(self, str)
    return self:find('^' .. str) ~= nil
end

function removeSpaces(inputString)
    local outputString = inputString:gsub(" ", "")
    return outputString
end

function CommaValue(amount)
    if type(amount) ~= "number" then
        return amount
    end
    
    local formatted = tostring(amount)
    
    local function InsertCommas(str)
        return string.gsub(str, "^(-?%d+)(%d%d%d)", '%1,%2')
    end
    
    if formatted:len() > 9 then
        local billions = tonumber(formatted) / 1e9
        formatted = string.format('%.1fB', billions)
    elseif formatted:len() > 6 then
        local millions = tonumber(formatted) / 1e6
        formatted = string.format('%.1fM', millions)
    else
        formatted = InsertCommas(formatted)
    end
    
    return formatted
end

function FormatPrice(ammount)
    return CommaValue(ammount) .. " " .. Config.PRICES_CURRENCY
end

function GetGreatestNumber(numbers)
    if type(numbers) == 'table' then
        local g = 0
        for k, v in pairs(numbers) do
            if tonumber(v) and v > g then
                g = v
            end
        end
        return g
    else
        return tonumber(numbers) or 0
    end
end

local _randomseed = math.random(1, 10000)
function RandomNumber(min, max)
    _randomseed = _randomseed + 1
    math.randomseed(_randomseed)
    if max then
        return math.random(min, max)
    else
        return math.random(min)
    end
end

function GetRandomItem(items)
    if items ~= nil and #(items) > 0 then
        return items[RandomNumber(1, #(items))]
    end
    return nil
end
