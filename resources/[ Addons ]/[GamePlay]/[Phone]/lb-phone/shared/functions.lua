function debugprint(...)
    if Config.Debug then
        local data = {...}
        local str = ""
        for i = 1, #data do
            if type(data[i]) == "table" then
                str = str .. json.encode(data[i])
            elseif type(data[i]) ~= "string" then
                str = str .. tostring(data[i])
            else
                str = str .. data[i]
            end
            if i ~= #data then
                str = str .. " "
            end
        end

        print("^6[LB Phone] ^3[Debug]^0: " .. str)
    end
end

function table.deep_clone(og)
    local copy = {}
    for k, v in pairs(og) do
        if type(v) == "table" then
            v = table.deep_clone(v)
        end
        copy[k] = v
    end
    return copy
end

function contains(t, v)
    for i = 1, #t do
        if t[i] == v then
            return true
        end
    end
    return false
end

local function GenerateLocales(localesFile)
    local tempLocals = {}
    local function FormatLocales(localeTable, prefix)
        for k, v in pairs(localeTable) do
            if type(v) == "table" then
                FormatLocales(v, prefix .. k .. ".")
            else
                tempLocals[prefix .. k] = v
            end
        end
    end

    FormatLocales(localesFile, "")
    return tempLocals
end

local locales = GenerateLocales(json.decode(LoadResourceFile(GetCurrentResourceName(), "config/locales/" .. (Config.DefaultLocale or "en") .. ".json")))
local defaultLocales = GenerateLocales(json.decode(LoadResourceFile(GetCurrentResourceName(), "config/locales/en.json")))

function L(path, args)
    assert(type(path) == "string", "path must be a string")

    local translation = locales[path] or defaultLocales[path] or path

    if args then
        for k, v in pairs(args) do
            local safe_v = tostring(v):gsub("%%", "%%%%")  -- Escape % characters
            translation = translation:gsub("{" .. k .. "}", safe_v)
        end
    end

    return translation
end

if not IsDuplicityVersion() then
    local lastInteraction = 0
    function CanInteract()
        if lastInteraction + 500 > GetGameTimer() then
            return false
        end
        lastInteraction = GetGameTimer()
        return true
    end
end

function SpamError(error)
    CreateThread(function()
        while error do
            Wait(0)
            print("^6[LB Phone] ^1[ERROR]^7: " .. error)
        end
    end)
end

function SeperateNumber(number)
    -- https://stackoverflow.com/questions/10989788/format-integer-in-lua
    local res = tostring(number):reverse():gsub("(%d%d%d)", "%1 "):reverse():gsub("^ ", "")
    return res
end

function FormatNumber(number)
    if not number or type(number) ~= "string" then
        return ""
    end

    local format = Config.PhoneNumber.Format
    -- remove any non-numeric characters from the number
    number = number:gsub("%D", "")

    -- iterate through the format string
    local result = {}
    local i = 1
    while i <= #format do
        local c = format:sub(i, i)
        if c == "{" then
            -- get the number of digits specified in the format string
            local j = i + 1
            while j <= #format and format:sub(j, j) ~= "}" do
                j += 1
            end
            local n = tonumber(format:sub(i + 1, j - 1))

            -- add the next n digits from the number to the result
            for k = 1, n do
                local digit = number:sub(k, k)
                if not digit then
                    break
                end
                result[#result+1] = digit
            end
            number = number:sub(n + 1)
            i = j + 1
        else
            -- add the non-digit character to the result
            result[#result+1] = c
            i += 1
        end
    end
    return table.concat(result)
end
exports("FormatNumber", FormatNumber)
